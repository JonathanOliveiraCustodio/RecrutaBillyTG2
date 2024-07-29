package br.edu.fatec.zl.RecrutaBillyTG2.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
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
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
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

	@RequestMapping(name = "relatorio", value = "/relatorio", method = RequestMethod.GET)
	public ModelAndView relatorioGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {

		return new ModelAndView("relatorio");
	}
	
	@RequestMapping(name = "relatorio", value = "/relatorio", method = RequestMethod.POST)
	public ModelAndView relatorioPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
		// Parâmetros de entrada
		String cmd = allRequestParam.get("botao");
		
		// Parâmetros de saída
		String saida = "";
		String erro = "";

		Cliente cli = new Cliente();
		Cliente c = new Cliente();
		List<Cliente> clientes = new ArrayList<>();

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			c = null;

		} else if (!cmd.contains("Listar")) {
		//	c.setCodigo(Integer.parseInt(codigo));
		}

		if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {

		}

		try {
			if (cmd.contains("Cadastrar")) {
			//	saida = cadastrarCliente(c);
				c = null;
			}
			if (cmd.contains("Alterar")) {
			//	saida = alterarCliente(c);
				c = null;
			}
			if (cmd.contains("Excluir")) {
				// Buscar um Cliente antes de Excluir para realizar a Validação
			//	Cliente cli = buscarCliente(c);
				if (cli != null) {
				//	saida = excluirCliente(c);
					c = null;
				} else {
			//		saida = "Nenhum Cliente encontrado com o código " + codigo;
				}
			}
			if (cmd.contains("Buscar")) {
			//	c = buscarCliente(c);
				if (c == null) {
					//saida = "Nenhum Cliente encontrado com o código " + codigo;
				}
			}
			if (cmd.contains("Listar")) {
			//	clientes = listarClientes();
			}
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("cliente", c);
			model.addAttribute("clientes", clientes);
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
			
		}else if (categoria.equals("insumo")) {
			reportPath = "classpath:reports/RelatorioInsumo.jasper";
			
		}else if (categoria.equals("pedido")) {
			reportPath = "classpath:reports/RelatorioPedidos.jasper";
		}
		
		else if (categoria.equals("produto")) {
			reportPath = "classpath:reports/RelatorioProduto.jasper";
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

}
