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
public class TermosServicosController {

	@RequestMapping(name = "termosservicos", value = "/termosservicos", method = RequestMethod.GET)
	public ModelAndView termosservicosGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {
		
		return new ModelAndView("termosservicos");
	}

	@RequestMapping(name = "termosservicos", value = "/termosservicos", method = RequestMethod.POST)
	public ModelAndView termosservicosPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
		
		return new ModelAndView("termosservicos");
	}

}