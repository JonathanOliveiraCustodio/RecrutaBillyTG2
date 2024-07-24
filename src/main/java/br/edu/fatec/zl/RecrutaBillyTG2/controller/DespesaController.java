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
public class DespesaController {
	@RequestMapping(name = "despesas", value = "/despesas", method = RequestMethod.GET)
	public ModelAndView despesasGet(@RequestParam Map<String, String> allRequestParam, ModelMap model, HttpSession session) {
		return new ModelAndView("despesas");
	}
	
	@RequestMapping(name = "despesas", value = "/despesas", method = RequestMethod.POST)
	public ModelAndView despesasPost(@RequestParam Map<String, String> allRequestParam, ModelMap model, HttpSession session) {
		return new ModelAndView("despesas");
	}
}
