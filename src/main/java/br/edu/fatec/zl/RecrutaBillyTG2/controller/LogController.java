package br.edu.fatec.zl.RecrutaBillyTG2.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Log;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.LogDao;
import jakarta.servlet.http.HttpSession;

@Controller
public class LogController {

	@Autowired
	GenericDao gDao;

	@Autowired
	LogDao lDao;

	@RequestMapping(value = "/log", method = RequestMethod.GET)
	public ModelAndView logGet(@RequestParam Map<String, String> allRequestParam, ModelMap model, HttpSession session) {

		String nivelAcesso = (String) session.getAttribute("nivelAcesso");
		String erro = "";
		String saida = "";

		List<Log> logs = new ArrayList<>();

		try {
				logs = listarLogs();

		} catch (ClassNotFoundException | SQLException error) {
			erro = error.getMessage();
		} finally {
			if (nivelAcesso == null || !nivelAcesso.equals("admin")) {
				saida = "Você não possui acesso para visualizar esta página.";
			}
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("logs", logs);
		}

		return new ModelAndView("log");
	}

	@RequestMapping(name = "log", value = "/log", method = RequestMethod.POST)
	public ModelAndView logPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		return new ModelAndView("log");
	}

	private List<Log> listarLogs() throws ClassNotFoundException, SQLException {
		List<Log> logs = new ArrayList<>();
		logs = lDao.findAll();
		return logs;
	}
}