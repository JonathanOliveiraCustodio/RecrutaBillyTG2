package br.edu.fatec.zl.RecrutaBillyTG2.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
public class PoliticaPrivacidadeController {

	@RequestMapping(name = "politicaprivacidade", value = "/politicaprivacidade", method = RequestMethod.GET)
	public ModelAndView politicaprivacidadeGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {

		
		return new ModelAndView("politicaprivacidade");
	}

	@RequestMapping(name = "politicaprivacidade", value = "/politicaprivacidade", method = RequestMethod.POST)
	public ModelAndView politicaprivacidadePost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
		
		return new ModelAndView("politicaprivacidade");
	}

}