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

import br.edu.fatec.zl.RecrutaBillyTG2.model.Cliente;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Despesa;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Equipamento;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Fornecedor;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Funcionario;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Insumo;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Orcamento;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Pedido;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ClienteDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.DespesaDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.EquipamentoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.FornecedorDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.FuncionarioDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.InsumoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.OrcamentoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.PedidoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ProdutoDao;
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
	
	@Autowired
	OrcamentoDao oDao;
	
	@Autowired
	DespesaDao dDao;

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

		List<Cliente> clientes = new ArrayList<>();
		List<Produto> produtos = new ArrayList<>();
		List<Pedido> pedidos = new ArrayList<>();
		List<Fornecedor> fornecedores = new ArrayList<>();
		List<Insumo> insumos = new ArrayList<>();
		List<Equipamento> equipamentos = new ArrayList<>();
		List<Funcionario> funcionarios = new ArrayList<>();
		List<Orcamento> orcamentos = new ArrayList<>();
		List<Despesa> despesas = new ArrayList<>();

		try {
			if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
				categoria = "";
				opcao = "";
				parametro = "";
			} else
				
				if (cmd.contains("Visualizar Relatório")) {
				switch (categoria) {
				case "cliente":
					clientes = listarClientes(opcao, parametro);
					break;
				case "fornecedor":
					fornecedores = listarFornecedores(opcao, parametro);
					break;
				case "insumo":
					insumos = listarInsumos(opcao, parametro);
					break;
				case "equipamento":
					equipamentos = listarEquipamentos(opcao, parametro);
					break;
				case "funcionario":
					funcionarios = listarFuncionarios(opcao, parametro);
					break;
				case "pedido":
					pedidos = listarPedidos(opcao, parametro);
					break;
				case "produto":
					produtos = listarProdutos(opcao, parametro);
					break;		
				case "orcamento":
					orcamentos = listarOrcamentos(opcao, parametro);
					break;	
				case "despesa":
					despesas = listarDespesas(opcao, parametro);
					break;	

				default:
					erro = "Categoria desconhecida: " + categoria;
					break;
				}
			}
		} catch (SQLException | ClassNotFoundException error) {
			erro = error.getMessage();
		} finally {

			model.addAttribute("categoria", categoria);
			model.addAttribute("opcao", opcao);
			model.addAttribute("parametro", parametro);
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("clientes", clientes);
			model.addAttribute("produtos", produtos);
			model.addAttribute("pedidos", pedidos);
			model.addAttribute("fornecedores", fornecedores);
			model.addAttribute("insumos", insumos);
			model.addAttribute("equipamentos", equipamentos);
			model.addAttribute("funcionarios", funcionarios);
			model.addAttribute("orcamentos", orcamentos);
			model.addAttribute("despesas", despesas);
		}
		return new ModelAndView("relatorio");
	}

	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(name = "relatorioCategoria", value = "/relatorioCategoria", method = RequestMethod.POST)
	public ResponseEntity relatorioPost(@RequestParam Map<String, String> allRequestParam) {

		String erro = "";

		String categoria = allRequestParam.get("categoria");
		//String opcao = allRequestParam.get("opcao");
		//String parametro = allRequestParam.get("parametro");

		Map<String, Object> paramRelatorio = new HashMap<String, Object>();
		paramRelatorio.put("opcao", allRequestParam.get("opcao"));
		paramRelatorio.put("parametro", allRequestParam.get("parametro"));
		paramRelatorio.put(JRParameter.REPORT_CLASS_LOADER, this.getClass().getClassLoader());

		byte[] bytes = null;

		InputStreamResource resource = null;
		HttpStatus status = null;
		HttpHeaders header = new HttpHeaders();

		String reportPath = "";
		switch (categoria) {
		case "cliente":
			reportPath = "classpath:reports/RelatorioCliente.jasper";
			break;
		case "fornecedor":
			reportPath = "classpath:reports/RelatorioFornecedor.jasper";
			break;
		case "insumo":
			reportPath = "classpath:reports/RelatorioInsumo.jasper";
			break;
		case "pedido":
			reportPath = "classpath:reports/RelatorioPedidos.jasper";
			break;
		case "produto":
			reportPath = "classpath:reports/RelatorioProduto.jasper";
			break;
		case "equipamento":
			reportPath = "classpath:reports/RelatorioEquipamento.jasper";
			break;
		case "funcionario":
			reportPath = "classpath:reports/RelatorioFuncionario.jasper";
			break;
		case "orcamento":
			reportPath = "classpath:reports/RelatorioOrcamento.jasper";
			break;
		case "despesa":
			reportPath = "classpath:reports/RelatorioDespesa.jasper";
			break;	
			
		default:
			throw new IllegalArgumentException("Categoria desconhecida " + categoria);
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

	private List<Cliente> listarClientes(String opcao, String parametro) throws ClassNotFoundException, SQLException {
		List<Cliente> clientes = new ArrayList<>();
		clientes = cDao.findClientesByOption(opcao, parametro);
		return clientes;
	}

	private List<Produto> listarProdutos(String opcao, String parametro) throws ClassNotFoundException, SQLException {
		List<Produto> produtos = new ArrayList<>();
		produtos = pDao.findProdutosByOption(opcao, parametro);
		return produtos;
	}

	private List<Pedido> listarPedidos(String opcao, String parametro) throws ClassNotFoundException, SQLException {
		List<Pedido> pedidos = new ArrayList<>();
		pedidos = pedDao.findPedidosByOption(opcao, parametro);
		return pedidos;
	}

	private List<Fornecedor> listarFornecedores(String opcao, String parametro)
			throws ClassNotFoundException, SQLException {
		List<Fornecedor> fornecedores = new ArrayList<>();
		fornecedores = fDao.findFornecedoresByOption(opcao, parametro);
		return fornecedores;
	}

	private List<Insumo> listarInsumos(String opcao, String parametro) throws ClassNotFoundException, SQLException {
		List<Insumo> insumos = new ArrayList<>();
		insumos = iDao.findInsumosByOption(opcao, parametro);
		return insumos;
	}

	private List<Equipamento> listarEquipamentos(String opcao, String parametro)
			throws ClassNotFoundException, SQLException {
		List<Equipamento> equipamentos = new ArrayList<>();
		equipamentos = eDao.findEquipamentosByOption(opcao, parametro);
		return equipamentos;
	}

	private List<Funcionario> listarFuncionarios(String opcao, String parametro)
			throws ClassNotFoundException, SQLException {
		List<Funcionario> funcionarios = new ArrayList<>();
		funcionarios = uDao.findFuncionariosByOption(opcao, parametro);
		return funcionarios;
	}
	
	private List<Orcamento> listarOrcamentos(String opcao, String parametro)
			throws ClassNotFoundException, SQLException {
		List<Orcamento> orcamentos = new ArrayList<>();
		orcamentos = oDao.findOrcamentosByOption(opcao, parametro);
		return orcamentos;
	}
	
	private List<Despesa> listarDespesas(String opcao, String parametro)
			throws ClassNotFoundException, SQLException {
		List<Despesa> despesas = new ArrayList<>();
		despesas = dDao.findDespesasByOption(opcao, parametro);
		return despesas;
	}

}
