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

import br.edu.fatec.zl.RecrutaBillyTG2.model.Orcamento;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Pedido;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.IndexDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.OrcamentoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.PedidoDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class IndexController {

	@Autowired
	GenericDao gDao;

	@Autowired
	IndexDao iDao;

	@Autowired
	PedidoDao pDao;
	
	@Autowired
	OrcamentoDao oDao;

	@RequestMapping(name = "index", value = "/index", method = RequestMethod.GET)
	public ModelAndView indexGet(@RequestParam Map<String, String> allRequestParam, HttpServletRequest request,
			ModelMap model) {
		HttpSession session = request.getSession();
		session.removeAttribute("index");

		String saida = "";
		String erro = "";
		String tituloTabela = "Pedidos Recentes";

		int totalOrcamentos = 0;
		int totalPedidoAndamento = 0;
		int totalPedidosRecebidos = 0;
		int totalPedidosDespachados = 0;

		List<Pedido> pedidos = new ArrayList<>();

		try {
			// Definir uma quatidade ou periodo para 
			pedidos = pDao.findAll();
			totalOrcamentos = iDao.countOrcamentos();
			totalPedidoAndamento = iDao.countPedidosAndamento();
			totalPedidosRecebidos = iDao.countPedidosRecebidos();
			totalPedidosDespachados = iDao.countPedidosDespachados();

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("pedidos", pedidos);
			model.addAttribute("tituloTabela", tituloTabela);
			model.addAttribute("totalOrcamentos", totalOrcamentos);
			model.addAttribute("totalPedidoAndamento", totalPedidoAndamento);
			model.addAttribute("totalPedidosRecebidos", totalPedidosRecebidos);
			model.addAttribute("totalPedidosDespachados", totalPedidosDespachados);
		}

		return new ModelAndView("index");
	}

	 @RequestMapping(name = "index", value = "/index", method = RequestMethod.POST)
	    public ModelAndView indexPost(@RequestParam Map<String, String> allRequestParam, HttpServletRequest request,
	                                  ModelMap model) {

	        // Parâmetros de entrada
	        String escolha = allRequestParam.get("escolha");

	        int totalOrcamentos = 0;
	        int totalPedidoAndamento = 0;
	        int totalPedidosRecebidos = 0;
	        int totalPedidosDespachados = 0;

	        String saida = "";
	        String erro = "";
	        String tituloTabela = "Pedidos Recentes";

	        List<Pedido> pedidos = new ArrayList<>();
	        List<Orcamento> orcamentos = new ArrayList<>();
	        try {
	            
	            switch (escolha) {
	                case "orcamentos":
	                    //saida = "Você escolheu visualizar os orçamentos.";
	                    orcamentos = oDao.findByStatus("Orçamento"); 
	                    tituloTabela = "Lista de Orçamentos";
	                    break;
	                case "pedidosAndamento":
	                 //   saida = "Você escolheu visualizar os pedidos em andamento.";
	                    pedidos = pDao.findByEstado("Em andamento"); 
	                    tituloTabela = "Pedidos em Andamento";
	                    break;
	                case "pedidosRecebidos":
	                   // saida = "Você escolheu visualizar os pedidos recebidos.";
	                    pedidos = pDao.findByEstado("Recebido"); 
	                    tituloTabela = "Pedidos Recebidos";
	                    break;
	                case "pedidosDespachados":
	                  //  saida = "Você escolheu visualizar os pedidos despachados.";
	                    pedidos = pDao.findByEstado("Despachado"); 
	                    tituloTabela = "Pedidos Despachados";
	                    break;
	                default:
	                    saida = "Escolha inválida.";
	                    break;
	            }

	            // Atualizar contadores
	            totalOrcamentos = iDao.countOrcamentos();
	            totalPedidoAndamento = iDao.countPedidosAndamento();
	            totalPedidosRecebidos = iDao.countPedidosRecebidos();
	            totalPedidosDespachados = iDao.countPedidosDespachados();

	        } catch (SQLException | ClassNotFoundException e) {
	            erro = e.getMessage();
	        } finally {
	            model.addAttribute("saida", saida);
	            model.addAttribute("erro", erro);
	            model.addAttribute("escolha", escolha);
	            model.addAttribute("pedidos", pedidos);
	            model.addAttribute("orcamentos", orcamentos);
	            model.addAttribute("totalOrcamentos", totalOrcamentos);
	            model.addAttribute("totalPedidoAndamento", totalPedidoAndamento);
	            model.addAttribute("totalPedidosRecebidos", totalPedidosRecebidos);
	            model.addAttribute("totalPedidosDespachados", totalPedidosDespachados);
	            model.addAttribute("tituloTabela", tituloTabela);
	        }
	        return new ModelAndView("index");
	    }


}