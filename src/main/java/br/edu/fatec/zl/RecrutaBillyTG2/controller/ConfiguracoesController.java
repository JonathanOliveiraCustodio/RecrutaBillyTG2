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

import br.edu.fatec.zl.RecrutaBillyTG2.model.Configuracoes;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ConfiguracoesDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import jakarta.servlet.http.HttpSession;

@Controller
public class ConfiguracoesController {

	@Autowired
	GenericDao gDao;

	@Autowired
	ConfiguracoesDao cDao;

	@RequestMapping(name = "configuracoes", value = "/configuracoes", method = RequestMethod.GET)
	public ModelAndView configuracoesGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {
		String erro = "";
		String saida = "";

		Configuracoes configuracoes = null;

		try {
			configuracoes = cDao.findConfiguracoes();
		} catch (ClassNotFoundException | SQLException error) {
			erro = error.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("configuracoes", configuracoes);
		}

		return new ModelAndView("configuracoes");
	}

	@RequestMapping(name = "configuracoes", value = "/configuracoes", method = RequestMethod.POST)
	public ModelAndView configuracoesPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
		String maxOrcamentos = allRequestParam.get("maxOrcamentos");
		String minEstoque = allRequestParam.get("minEstoque");
		String medPedidosAndamento = allRequestParam.get("medPedidosAndamento");
		String medPedidosRecebidos = allRequestParam.get("medPedidosRecebidos");
		String medPedidosDespachados = allRequestParam.get("medPedidosDespachados");
		String medProducaoProdutos = allRequestParam.get("medProducaoProdutos");
		
		String erro = "";
		String saida = "";

		Configuracoes configuracoes = new Configuracoes();

		try {
			
			configuracoes.setQtdMaximaOrcamento(Integer.parseInt(maxOrcamentos));
			configuracoes.setQtdMinimaProdutoEstoque(Integer.parseInt(minEstoque));
			configuracoes.setQtdMediaPedidoAndamento(Integer.parseInt(medPedidosAndamento));
			configuracoes.setQtdMediaPedidosRecebidos(Integer.parseInt(medPedidosRecebidos));
			configuracoes.setQtdMediaPedidosDespachados(Integer.parseInt(medPedidosDespachados));
			configuracoes.setQtdMediaProducaoProdutos(Integer.parseInt(medProducaoProdutos));

			saida = cDao.sp_u_configuracoes(configuracoes);
		} catch (NumberFormatException e) {
			erro = "Valores inválidos. Por favor, insira números válidos.";
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("configuracoes", configuracoes);
		}

		return new ModelAndView("configuracoes");
	}
}