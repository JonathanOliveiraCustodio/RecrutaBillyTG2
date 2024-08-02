package br.edu.fatec.zl.RecrutaBillyTG2.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.InsumoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Cliente;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Equipamento;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Fornecedor;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Insumo;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Pedido;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Funcionario;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ClienteDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.EquipamentoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.FornecedorDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.PedidoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ProdutoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.FuncionarioDao;
import jakarta.servlet.http.HttpSession;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;

@Controller
public class RelatorioController {

	@Autowired
	GenericDao gDao;

	@Autowired
	ClienteDao cDao;

	@Autowired
	ProdutoDao pDao;

	@Autowired
	PedidoDao pedDao;

	@Autowired
	FornecedorDao fDao;

	@Autowired
	InsumoDao iDao;

	@Autowired
	EquipamentoDao eDao;

	@Autowired
	FuncionarioDao uDao;

	@RequestMapping(name = "relatorio", value = "/relatorio", method = RequestMethod.GET)
	public ModelAndView relatorioGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {

		return new ModelAndView("relatorio");
	}

	@RequestMapping(name = "relatorio", value = "/relatorio", method = RequestMethod.POST)
	public ModelAndView relatorioPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		// Parâmetros de entrada
		String cmd = allRequestParam.get("botao");
		String categoria = allRequestParam.get("categoria");
		String opcao = allRequestParam.get("opcao");
		String parametro = allRequestParam.get("parametro");

		// Parâmetros de saída
		String saida = "";
		String erro = "";

		Cliente c = new Cliente();
		Produto pro = new Produto();
		Pedido ped = new Pedido();
		Fornecedor f = new Fornecedor();
		Insumo i = new Insumo();
		Equipamento e = new Equipamento();
		Funcionario u = new Funcionario();

		List<Cliente> clientes = new ArrayList<>();
		List<Produto> produtos = new ArrayList<>();
		List<Pedido> pedidos = new ArrayList<>();
		List<Fornecedor> fornecedores = new ArrayList<>();
		List<Insumo> insumos = new ArrayList<>();
		List<Equipamento> equipamentos = new ArrayList<>();
		List<Funcionario> usuarios = new ArrayList<>();

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			c = null;

		} else if (!cmd.contains("Listar")) {
			// c.setCodigo(Integer.parseInt(codigo));
		}

		if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {

		}

		try {

			if (cmd.contains("Visualizar")) {

				// clientes = listarClientes();
			}
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("cliente", c);
			model.addAttribute("clientes", clientes);
			model.addAttribute("produto", pro);
			model.addAttribute("produtos", produtos);
			model.addAttribute("pedido", ped);
			model.addAttribute("pedidos", pedidos);
			model.addAttribute("fornecedor", f);
			model.addAttribute("fornecedores", fornecedores);
			model.addAttribute("insumo", i);
			model.addAttribute("insumos", insumos);
			model.addAttribute("equipamento", e);
			model.addAttribute("equipamentos", equipamentos);
			model.addAttribute("usuario", u);
			model.addAttribute("usuarios", usuarios);
		}
		return new ModelAndView("relatorio");
	}

	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(name = "relatorioCategoria", value = "/relatorioCategoria", method = RequestMethod.POST)
	public ResponseEntity relatorioPost(@RequestParam Map<String, String> allRequestParam) {

		String erro = "";

		String categoria = allRequestParam.get("categoria");
		String opcao = allRequestParam.get("opcao");
		String parametro = allRequestParam.get("parametro");
		System.out.println(categoria);
		System.out.println(opcao);
		System.out.println(parametro);

		Map<String, Object> paramRelatorio = new HashMap<String, Object>();
		paramRelatorio.put("opcao", allRequestParam.get("opcao"));
		paramRelatorio.put("parametro", allRequestParam.get("parametro"));
		paramRelatorio.put(JRParameter.REPORT_CLASS_LOADER, this.getClass().getClassLoader());

		byte[] bytes = null;

		InputStreamResource resource = null;
		HttpStatus status = null;
		HttpHeaders header = new HttpHeaders();

		String reportPath = "";
		if (categoria.equals("cliente")) {
			reportPath = "classpath:reports/RelatorioCliente.jasper";

		} else if (categoria.equals("fornecedor")) {
			reportPath = "classpath:reports/RelatorioFornecedor.jasper";

		} else if (categoria.equals("insumo")) {
			reportPath = "classpath:reports/RelatorioInsumo.jasper";

		} else if (categoria.equals("pedido")) {
			reportPath = "classpath:reports/RelatorioPedidos.jasper";
		}

		else if (categoria.equals("produto")) {
			reportPath = "classpath:reports/RelatorioProduto.jasper";
		} else if (categoria.equals("equipamento")) {
			reportPath = "classpath:reports/RelatorioEquipamento.jasper";
		}

		try {

			Connection c = gDao.getConnection();
			File arquivo = ResourceUtils.getFile(reportPath);
			JasperReport report = (JasperReport) JRLoader.loadObjectFromFile(arquivo.getAbsolutePath());
			bytes = JasperRunManager.runReportToPdf(report, paramRelatorio, c);
		} catch (ClassNotFoundException | SQLException | FileNotFoundException | JRException e) {
			e.printStackTrace();
			erro = e.getMessage();
			status = HttpStatus.BAD_REQUEST;
		} finally {
			if (erro.equals("")) {
				InputStream inputStream = new ByteArrayInputStream(bytes);
				resource = new InputStreamResource(inputStream);
				header.setContentLength(bytes.length);
				header.setContentType(MediaType.APPLICATION_PDF);
				status = HttpStatus.OK;
			}
		}
		return new ResponseEntity<>(resource, header, status);
	}

	private List<Cliente> listarClientes() throws ClassNotFoundException, SQLException {
		List<Cliente> clientes = new ArrayList<>();
		clientes = cDao.findAll();
		return clientes;
	}

	private List<Produto> listarProdutos() throws ClassNotFoundException, SQLException {
		List<Produto> produtos = new ArrayList<>();
		produtos = pDao.findAll();
		return produtos;
	}

	private List<Pedido> listarPedidos() throws ClassNotFoundException, SQLException {
		List<Pedido> pedidos = new ArrayList<>();
		pedidos = pedDao.findAll();
		return pedidos;
	}

	private List<Fornecedor> listarFornecedores() throws ClassNotFoundException, SQLException {
		List<Fornecedor> fornecedores = new ArrayList<>();
		fornecedores = fDao.findAll();
		return fornecedores;
	}

	private List<Insumo> listarInsumos() throws ClassNotFoundException, SQLException {
		List<Insumo> insumos = new ArrayList<>();
		insumos = iDao.findAll();
		return insumos;
	}

	private List<Equipamento> listarEquipamentos() throws ClassNotFoundException, SQLException {
		List<Equipamento> equipamentos = new ArrayList<>();
		equipamentos = eDao.findAll();
		return equipamentos;
	}

	private List<Funcionario> listarUsuarios() throws ClassNotFoundException, SQLException {
		List<Funcionario> usuarios = new ArrayList<>();
		usuarios = uDao.findAll();
		return usuarios;
	}

}
