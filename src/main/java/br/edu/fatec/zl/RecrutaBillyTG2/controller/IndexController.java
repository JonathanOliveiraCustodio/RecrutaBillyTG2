package br.edu.fatec.zl.RecrutaBillyTG2.controller;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.IndexDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class IndexController {

	@Autowired
	GenericDao gDao;

	@Autowired
	IndexDao iDao;

	@RequestMapping(name = "index", value = "/index", method = RequestMethod.GET)
	public ModelAndView indexGet(@RequestParam Map<String, String> allRequestParam, HttpServletRequest request,
			ModelMap model) {
		HttpSession session = request.getSession();
		session.removeAttribute("index");

		String saida = "";
		String erro = "";
	

		int totalOrcamentos = 0; 
		int totalPedidoAndamento = 0; 
		int  totalPedidosRecebidos =0;
		int  totalPedidosDespachados =0;

		try {

			totalOrcamentos = iDao.countOrcamentos();
			totalPedidoAndamento = iDao.countPedidosAndamento();
			totalPedidosRecebidos = iDao.countPedidosRecebidos();
			totalPedidosDespachados = iDao.countPedidosDespachados();

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
		
			model.addAttribute("totalOrcamentos", totalOrcamentos);
			model.addAttribute("totalPedidoAndamento", totalPedidoAndamento);
			model.addAttribute("totalPedidosRecebidos", totalPedidosRecebidos);
			model.addAttribute("totalPedidosDespachados", totalPedidosDespachados);
		}

		return new ModelAndView("index");
	}

	@RequestMapping(name = "index", value = "/index", method = RequestMethod.POST)
	public ModelAndView indexPost(ModelMap model) {
		return new ModelAndView("index");
	}

}