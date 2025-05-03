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

import br.edu.fatec.zl.RecrutaBillyTG2.model.CategoriaProduto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Pedido;
import br.edu.fatec.zl.RecrutaBillyTG2.model.PedidoProduto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.CategoriaProdutoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.PedidoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.PedidoProdutoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ProdutoDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ProdutosPedidoController {
	@Autowired
	ProdutoDao proDao;

	@Autowired
	PedidoDao pedDao;

	@Autowired
	PedidoProdutoDao ppDao;

	@Autowired
	CategoriaProdutoDao cDao;

	@RequestMapping(name = "produtosPedido", value = "/produtosPedido", method = RequestMethod.GET)
	public ModelAndView produtosPedidoGet(@RequestParam Map<String, String> allRequestParam, HttpServletRequest request,
			ModelMap model) {
		HttpSession session = request.getSession();

		String pedido = allRequestParam.get("pedido");
		if (pedido == null) {
			pedido = (String) session.getAttribute("pedido");
		} else {
			session.setAttribute("pedido", pedido);
		}
		String erro = "";
		List<PedidoProduto> pedidoProdutos = new ArrayList<>();
		List<CategoriaProduto> categorias = new ArrayList<>();
		Pedido pe = new Pedido();

		try {
			pe.setCodigo(Integer.parseInt(pedido));
			pe = buscarPedido(pe);
			pedidoProdutos = listarProdutos(pe);
			categorias = listarCategorias();
			// produtos = proDao.findAll();
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("pedidoProdutos", pedidoProdutos);
			model.addAttribute("categorias", categorias);
		}
		return new ModelAndView("produtosPedido");
	}

	@RequestMapping(name = "produtosPedido", value = "/produtosPedido", method = RequestMethod.POST)
	public ModelAndView produtosPedidoPost(@RequestParam Map<String, String> allRequestParam,
			HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();
		
		String cmd = allRequestParam.get("botao");
		String codigoPedido = (String) session.getAttribute("pedido");
		String codigoProduto = allRequestParam.get("produto");
		String quantidade = allRequestParam.get("quantidade");
		String categoria = allRequestParam.get("categoria");

		CategoriaProduto c = new CategoriaProduto();
		Pedido pe = new Pedido();
		Produto pr = new Produto();
		PedidoProduto pp = new PedidoProduto();
		CategoriaProduto cp = new CategoriaProduto();

		List<PedidoProduto> pedidoProdutos = new ArrayList<>();
		List<Produto> produtos = new ArrayList<>();
		List<CategoriaProduto> categorias = new ArrayList<>();
		String saida = "";
		String erro = "";
		System.out.println("Categoria selecionada: " + categoria);
		try {
			pe.setCodigo(Integer.parseInt(codigoPedido));
			pe = buscarPedido(pe);
			pedidoProdutos = listarProdutos(pe);
			categorias = listarCategorias();
			cp.setNome(categoria);
			
			produtos = listarProdutosCategoria(categoria);
			
			pr.setCodigo(Integer.parseInt(codigoProduto));
			pr = buscarProduto(pr);
			pp.setProduto(pr);

			if (cmd != null) {
				pedidoProdutos = listarProdutos(pe);
				produtos = listarProdutosCategoria(categoria);
				pe.setCodigo(Integer.parseInt(codigoPedido));

				if (!cmd.contains("Listar")) {
					pr.setCodigo(Integer.parseInt(codigoProduto));
					pr = proDao.findBy(pr);
					pp.setProduto(pr);
					pp.setCodigoPedido(Integer.parseInt(codigoPedido));
					pp.setCodigoProduto(Integer.parseInt(codigoProduto));
				}
				if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
					pp.setCodigoProduto(Integer.parseInt(codigoProduto));
					pp.setQuantidade(Integer.parseInt(quantidade));
				}
				if (cmd.contains("Cadastrar")) {
					saida = adicionarProduto(pp);
				}
				if (cmd.contains("Excluir")) {
					saida = excluirProduto(pp);
				}
				if (cmd.contains("Listar")) {
					pedidoProdutos = listarProdutos(pe);
				}
				pedidoProdutos = listarProdutos(pe);

			}
			pedidoProdutos = listarProdutos(pe);
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("produtosPedido", pedidoProdutos);
		    model.addAttribute("pedidoProduto", pp);
			model.addAttribute("pedidoProdutos", pedidoProdutos);
			model.addAttribute("produtos", produtos);
			model.addAttribute("categorias", categorias);
			model.addAttribute("produto", c);
			model.addAttribute("categoriaProduto", cp);

		}
		return new ModelAndView("produtosPedido");
	}

	private List<PedidoProduto> listarProdutos(Pedido pe) throws ClassNotFoundException, SQLException {
		return ppDao.findAll(pe);
	}

	private List<CategoriaProduto> listarCategorias() throws ClassNotFoundException, SQLException {
		return cDao.findAll();
	}

	private List<Produto> listarProdutosCategoria(String categoria) throws ClassNotFoundException, SQLException {
		return proDao.findCategoria(categoria);
	}

	private String adicionarProduto(PedidoProduto pp) throws ClassNotFoundException, SQLException {
		return ppDao.iudPedidoProduto("I", pp);
	}

	private String excluirProduto(PedidoProduto pp) throws ClassNotFoundException, SQLException {
		return ppDao.iudPedidoProduto("D", pp);
	}

	private Pedido buscarPedido(Pedido p) throws SQLException, ClassNotFoundException {
		p = pedDao.findBy(p);
		return p;
	}
	
	private Produto buscarProduto(Produto p) throws SQLException, ClassNotFoundException {
		p = proDao.findBy(p);
		return p;
	}
}
