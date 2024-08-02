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
import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ProdutoDao;

@Controller
public class ProdutoController {

	@Autowired
	GenericDao gDao;

	@Autowired
	ProdutoDao pDao;

	@RequestMapping(name = "produto", value = "/produto", method = RequestMethod.GET)
	public ModelAndView produtoGet(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String cmd = allRequestParam.get("cmd");
		String codigo = allRequestParam.get("codigo");

		if (cmd != null) {
			Produto p = new Produto();
			p.setCodigo(Integer.parseInt(codigo));

			String saida = "";
			String erro = "";
			List<Produto> produtos = new ArrayList<>();

			try {
				if (cmd.contains("alterar")) {
					p = buscarProduto(p);
				} else if (cmd.contains("excluir")) {
					p = buscarProduto(p);
					saida = excluirProduto(p);
					p = null;
				}

				produtos = listarProdutos();

			} catch (SQLException | ClassNotFoundException error) {
				erro = error.getMessage();
			} finally {

				model.addAttribute("saida", saida);
				model.addAttribute("erro", erro);
				model.addAttribute("produto", p);
				model.addAttribute("produtos", produtos);

			}

		}

		return new ModelAndView("produto");
	}

	@RequestMapping(name = "produto", value = "/produto", method = RequestMethod.POST)
	public ModelAndView produtoPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String cmd = allRequestParam.get("botao");
		String codigo = allRequestParam.get("codigo");
		String nome = allRequestParam.get("nome");
		String categoria = allRequestParam.get("categoria");
		String descricao = allRequestParam.get("descricao");
		String valorUnitario = allRequestParam.get("valorUnitario");
		String status = allRequestParam.get("status");
		String quantidade = allRequestParam.get("quantidade");
		String refEstoque = allRequestParam.get("refEstoque");
		
		String saida = "";
		String erro = "";
		Produto p = new Produto();

		List<Produto> produtos = new ArrayList<>();

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			p = null;

		} else if (!cmd.contains("Listar")) {
			p.setCodigo(Integer.parseInt(codigo));
		}
		try {

			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
				p.setNome(nome);
				p.setCategoria(categoria);
				p.setDescricao(descricao);
				p.setValorUnitario(Float.parseFloat(valorUnitario));
				p.setStatus(status);
				p.setQuantidade(Integer.parseInt(quantidade));
				p.setRefEstoque(refEstoque);
			}
			if (cmd.contains("Cadastrar") ) {
				saida = cadastrarProduto(p);
				p = null;
			}
			if (cmd.contains("Alterar")) {
				saida = alterarProduto(p);
				p = null;
			}
			if (cmd.contains("Excluir")) {
				p = buscarProduto(p);
				saida = excluirProduto(p);
				p = null;
			}
			if (cmd.contains("Buscar")) {
				p = buscarProduto(p);
				if (p == null) {
					saida = "Nenhum Produto encontrado com o código " + codigo ;
				}
			}
			if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
				p = null;
			}

			if (cmd.contains("Listar")) {
				produtos = listarProdutos();
			}

			if (cmd.contains("Adicionar")) {
				p = buscarProduto(p);
				if (p == null) {
					saida = "Nenhum produto encontrado com o codigo especificado.";
					p = null;
				} else {
					model.addAttribute("produto", p);
					return new ModelAndView("forward:/insumosProduto", model);
				}
			}
		} catch (SQLException | ClassNotFoundException error) {
			erro = error.getMessage();

		} finally {

			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("produto", p);
			model.addAttribute("produtos", produtos);

		}

		return new ModelAndView("produto");
	}

	private String cadastrarProduto(Produto p) throws SQLException, ClassNotFoundException {
		String saida = pDao.sp_iud_produto("I", p);
		return saida;
	}

	private String alterarProduto(Produto p) throws SQLException, ClassNotFoundException {
		String saida = pDao.sp_iud_produto("U", p);
		return saida;

	}

	private String excluirProduto(Produto p) throws SQLException, ClassNotFoundException {
		String saida = pDao.sp_iud_produto("D", p);
		return saida;

	}

	private Produto buscarProduto(Produto p) throws SQLException, ClassNotFoundException {
		p = pDao.findBy(p);
		return p;

	}

	private List<Produto> listarProdutos() throws SQLException, ClassNotFoundException {
		List<Produto> produtos = pDao.findAll();
		return produtos;
	}

}