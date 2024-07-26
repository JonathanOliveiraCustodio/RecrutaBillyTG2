package br.edu.fatec.zl.RecrutaBillyTG2.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
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

import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import jakarta.servlet.http.HttpSession;
import net.sf.jasperreports.engine.JRException;
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

	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(name = "relatorioCategoria", value = "/relatorioCategoria", method = RequestMethod.POST)
	public ResponseEntity relatorioPost(@RequestParam Map<String, String> allRequestParam) {

		String erro = "";

		String categoria = allRequestParam.get("categoria");
		System.out.println(categoria);

		Map<String, Object> paramRelatorio = new HashMap<String, Object>();
		paramRelatorio.put("opcao", allRequestParam.get("opcao"));
		paramRelatorio.put("parametro", allRequestParam.get("parametro"));
		byte[] bytes = null;

		InputStreamResource resource = null;
		HttpStatus status = null;
		HttpHeaders header = new HttpHeaders();

		try {
			String reportPath = "";
			if (categoria.equals("cliente")) {
				reportPath = "classpath:reports/RelatorioCliente.jasper";

			} else if (categoria.equals("fornecedor")) {
				reportPath = "classpath:reports/RelatorioFornecedor.jasper";
				
			}else if (categoria.equals("insumo")) {
				reportPath = "classpath:reports/RelatorioInsumo.jasper";
			}
			
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
