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

import br.edu.fatec.zl.RecrutaBillyTG2.model.Configuracoes;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Orcamento;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Pedido;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ConfiguracoesDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.IndexDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.OrcamentoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.PedidoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ProdutoDao;
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
	ProdutoDao prDao;

	@Autowired
	OrcamentoDao oDao;

	@Autowired
	ConfiguracoesDao cDao;

	@RequestMapping(name = "index", value = "/index", method = RequestMethod.GET)
	public ModelAndView indexGet(@RequestParam Map<String, String> allRequestParam, HttpServletRequest request,
			ModelMap model) {
		HttpSession session = request.getSession();
		session.removeAttribute("index");

		String saida = "";
		String erro = "";
		String tituloTabela = "Pedidos Recentes";

		Configuracoes configuracoes = null;
		List<Pedido> pedidos = new ArrayList<>();

		try {
			configuracoes = cDao.findConfiguracoes();
			pedidos = pDao.findData();
			atualizarContadores(model, configuracoes);
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("pedidos", pedidos);
			model.addAttribute("configuracoes", configuracoes);
			model.addAttribute("tituloTabela", tituloTabela);
		}

		return new ModelAndView("index");
	}

	@RequestMapping(name = "index", value = "/index", method = RequestMethod.POST)
	public ModelAndView indexPost(@RequestParam Map<String, String> allRequestParam, HttpServletRequest request,
			ModelMap model) {

		// Parâmetros de entrada
		String escolha = allRequestParam.get("escolha");
		String saida = "";
		String erro = "";
		String tituloTabela = "Pedidos Recentes";

		List<Pedido> pedidos = new ArrayList<>();
		List<Produto> produtos = new ArrayList<>();
		List<Orcamento> orcamentos = new ArrayList<>();
		Configuracoes configuracoes = null;

		try {
			configuracoes = cDao.findConfiguracoes();

			switch (escolha) {
			case "orcamentos":
				orcamentos = oDao.findByStatus("Orçamento");
				tituloTabela = "Lista de Orçamentos";
				break;
			case "pedidosAndamento":
				pedidos = pDao.findByEstado("Em andamento");
				tituloTabela = "Pedidos em Andamento";
				break;
			case "pedidosRecebidos":
				pedidos = pDao.findByEstado("Recebido");
				tituloTabela = "Pedidos Recebidos";
				break;
			case "produtosProducao":
				produtos = prDao.findByStatus("Em Produção");
				tituloTabela = "Produtos em Produção";
				break;
			case "pedidosDespachados":
				pedidos = pDao.findByEstado("Despachado");
				tituloTabela = "Pedidos Despachados";
				break;
			case "produtosEstoqueBaixo":
				int qtdMinimaEstoque = configuracoes.getQtdMinimaProdutoEstoque();
				produtos = prDao.findByEstoqueBaixo(qtdMinimaEstoque);
				tituloTabela = "Produtos com Estoque Baixo";
				break;
			default:
				saida = "Escolha inválida.";
				break;
			}

			atualizarContadores(model, configuracoes);

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("escolha", escolha);
			model.addAttribute("pedidos", pedidos);
			model.addAttribute("orcamentos", orcamentos);
			model.addAttribute("produtos", produtos);
			model.addAttribute("tituloTabela", tituloTabela);
			model.addAttribute("configuracoes", configuracoes);
		}
		return new ModelAndView("index");
	}

	// Método para atualizar os contadores
	private void atualizarContadores(ModelMap model, Configuracoes c) throws SQLException, ClassNotFoundException {
		int qtdMinimaEstoque = c.getQtdMinimaProdutoEstoque();
		model.addAttribute("totalOrcamentos", iDao.countOrcamentos());
		model.addAttribute("totalPedidoAndamento", iDao.countPedidosAndamento());
		model.addAttribute("totalPedidosRecebidos", iDao.countPedidosRecebidos());
		model.addAttribute("totalPedidosDespachados", iDao.countPedidosDespachados());
		model.addAttribute("totalProdutosProducao", iDao.countProdutosProducao());
		model.addAttribute("totalProdutoEstoqueBaixo", iDao.countProdutosEstoqueBaixo(qtdMinimaEstoque));
	}

}