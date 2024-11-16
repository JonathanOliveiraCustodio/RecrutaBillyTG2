package br.edu.fatec.zl.RecrutaBillyTG2.controller;

import java.sql.Date;
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
import br.edu.fatec.zl.RecrutaBillyTG2.model.InsumoProduto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.CategoriaProdutoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ProdutoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ProdutoInsumoDao;

@Controller
public class ProdutoController {

	@Autowired
	GenericDao gDao;

	@Autowired
	ProdutoDao pDao;

	@Autowired
	CategoriaProdutoDao cpDao;
	
	@Autowired
	ProdutoInsumoDao piDao;

	@RequestMapping(name = "produto", value = "/produto", method = RequestMethod.GET)
	public ModelAndView produtoGet(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String cmd = allRequestParam.get("cmd");
		String codigo = allRequestParam.get("codigo");
		String saida = "";
		String erro = "";

		List<Produto> produtos = new ArrayList<>();
		List<CategoriaProduto> categorias = new ArrayList<>();
		List<InsumoProduto> insumosProduto = new ArrayList<>();
		
		Produto p = null;

		try {
			// Carrega as listas de produtos e categorias
			// produtos = listarProdutos();
			categorias = listarCategoriaProdutos();

			// Verifica se o código foi fornecido e busca o produto correspondente
			if (codigo != null && !codigo.isEmpty()) {
				p = new Produto();
				p.setCodigo(Integer.parseInt(codigo));
				p = buscarProduto(p);
			}

			// Comando para alterar ou excluir o produto
			if (cmd != null) {
				if (cmd.contains("alterar")) {
					p = buscarProduto(p); // Busca novamente para assegurar que está atualizado
					insumosProduto = piDao.listarCodigo(p.getCodigo()); 
				} else if (cmd.contains("excluir")) {
					p = buscarProduto(p);
					saida = excluirProduto(p);
					p = null;
				}
			}

		} catch (SQLException | ClassNotFoundException | NumberFormatException error) {
			erro = error.getMessage();
		} finally {
			// Adiciona os atributos ao model para serem acessados na view
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("produto", p);
			model.addAttribute("produtos", produtos);
			model.addAttribute("categorias", categorias);
			model.addAttribute("insumosProduto", insumosProduto);
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
		String data = allRequestParam.get("data");

		String saida = "";
		String erro = "";
		Produto p = new Produto();
		CategoriaProduto cp = new CategoriaProduto();

		List<Produto> produtos = new ArrayList<>();
		List<CategoriaProduto> categorias = new ArrayList<>();
		List<InsumoProduto> insumosProduto = new ArrayList<>();

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			p = null;

		} else if (!cmd.contains("Listar")) {
			p.setNome(nome);
		}
		try {

			categorias = cpDao.findAll();
			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
				if (categoria != null && !categoria.isEmpty()) {
					cp.setCodigo(Integer.parseInt(categoria));
					cp = buscarCategoria(cp);
					p.setCategoria(cp);
				}

				if (codigo != null && !codigo.isEmpty()) {
					p.setCodigo(Integer.parseInt(codigo));
				}
				p.setNome(nome);
				p.setDescricao(descricao);

				// Remover a máscara de moeda
				valorUnitario = valorUnitario.replace("R$", "").replace(".", "").replace(",", ".");
				p.setValorUnitario(Float.parseFloat(valorUnitario));

				p.setStatus(status);
				p.setQuantidade(Integer.parseInt(quantidade));
				p.setRefEstoque(refEstoque);
				p.setData(Date.valueOf(data));
			}
			if (cmd.contains("Cadastrar")) {
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
				// Buscar Produto pelo nome
				produtos = buscarProdutoNome(nome);
				// Verificar o número de registros retornados
				if (produtos.isEmpty()) {
					// Caso não encontre nenhum produto
					saida = "Nenhum Produto encontrado com o Nome '" + nome + "'";
				} else if (produtos.size() == 1) {
					Produto produto = produtos.get(0);
					saida = "Produto encontrado: " + produto.getNome();
					p = buscarProduto(produto);
					insumosProduto = piDao.listarCodigo(p.getCodigo()); 
				} else {
					// Caso encontre mais de um pedido
					saida = "Foram encontrados " + produtos.size() + " produtos com o Nome '" + nome + "'";

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

			if (p == null) {
				p = new Produto();
			}
		} catch (SQLException | ClassNotFoundException error) {
			erro = error.getMessage();

		} finally {

			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("produto", p);
			model.addAttribute("produtos", produtos);
			model.addAttribute("categorias", categorias);
			model.addAttribute("insumosProduto", insumosProduto);

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

	private CategoriaProduto buscarCategoria(CategoriaProduto cp) throws SQLException, ClassNotFoundException {
		cp = cpDao.findBy(cp);
		return cp;
	}

	private List<Produto> listarProdutos() throws SQLException, ClassNotFoundException {
		List<Produto> produtos = pDao.findAll();
		return produtos;
	}

	private List<CategoriaProduto> listarCategoriaProdutos() throws SQLException, ClassNotFoundException {
		List<CategoriaProduto> categorias = cpDao.findAll();
		return categorias;
	}

	private List<Produto> buscarProdutoNome(String nome) throws ClassNotFoundException, SQLException {
		List<Produto> produtos = new ArrayList<>();
		produtos = pDao.findByName(nome);
		return produtos;
	}

}