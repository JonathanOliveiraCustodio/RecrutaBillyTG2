package br.edu.fatec.zl.RecrutaBillyTG2.controller;

import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ClienteDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import jakarta.servlet.http.HttpSession;

@Controller
public class ErrorController {

	@Autowired
	GenericDao gDao;

	@Autowired
	ClienteDao cDao;

	@RequestMapping(name = "error505", value = "/error505", method = RequestMethod.GET)
	public ModelAndView errorGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {

		return new ModelAndView("error505");
	}

}
