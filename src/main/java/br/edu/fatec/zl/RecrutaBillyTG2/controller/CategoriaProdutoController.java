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
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.CategoriaProdutoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import jakarta.servlet.http.HttpSession;

@Controller
public class CategoriaProdutoController {

	@Autowired
	GenericDao gDao;

	@Autowired
	CategoriaProdutoDao cpDao;

	@RequestMapping(name = "categoriaProduto", value = "/categoriaProduto", method = RequestMethod.GET)
	public ModelAndView categoriaProdutoGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {

		String nivelAcesso = (String) session.getAttribute("nivelAcesso");
		String erro = "";
		String saida = "";

		List<CategoriaProduto> categoriaProdutos = new ArrayList<>();
		CategoriaProduto cp = null;

		try {
			String cmd = allRequestParam.get("cmd");
			String codigo = allRequestParam.get("codigo");

			if (cmd != null) {
				if (cmd.contains("alterar")) {
					// Inicializando antes de utilizá-lo
					cp = new CategoriaProduto();
					cp.setCodigo(Integer.parseInt(codigo));
					cp = buscarCliente(cp);

				} else if (cmd.contains("excluir")) {
					// Inicializando antes de utilizá-lo
					cp = new CategoriaProduto();
					cp.setCodigo(Integer.parseInt(codigo));
					saida = excluirCliente(cp);
					cp = null;
				}
				categoriaProdutos = listarCategoriaProdutos();
			}

		} catch (ClassNotFoundException | SQLException error) {
			erro = error.getMessage();
		} finally {
			if (nivelAcesso == null || !nivelAcesso.equals("admin")) {
				saida = "Você não possui acesso para visualizar esta página.";
			}
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("categoriaProduto", cp);
			model.addAttribute("categoriaProdutos", categoriaProdutos);
		}

		return new ModelAndView("categoriaProduto");
	}

	@RequestMapping(name = "categoriaProduto", value = "/categoriaProduto", method = RequestMethod.POST)
	public ModelAndView categoriaProdutoPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
		// Parâmetros de entrada
		String cmd = allRequestParam.get("botao");
		String nome = allRequestParam.get("nome");
		String codigo = allRequestParam.get("codigo");

		// Parâmetros de saída
		String saida = "";
		String erro = "";

		CategoriaProduto cp = new CategoriaProduto();
		List<CategoriaProduto> categoriaProdutos = new ArrayList<>();

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			cp = null;

		} else if (!cmd.contains("Listar")) {
			cp.setNome(nome);
		}

		if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
			if (codigo != null && !codigo.isEmpty()) {
				cp.setCodigo(Integer.parseInt(codigo));
			}
			cp.setNome(nome);
		}

		try {
			if (cmd.contains("Cadastrar")) {
				saida = cadastrarCliente(cp);
				cp = null;
			}
			if (cmd.contains("Alterar")) {
				saida = alterarCliente(cp);
				cp = null;
			}
			if (cmd.contains("Excluir")) {
				cp = new CategoriaProduto();
				cp.setCodigo(Integer.parseInt(codigo));
				saida = excluirCliente(cp);
				cp = null;
			}
			if (cmd.contains("Buscar")) {
				// Buscar clientes pelo nome
				categoriaProdutos = buscarClienteNome(nome);
				// Verificar o número de registros retornados
				if (categoriaProdutos.isEmpty()) {
					// Caso não encontre nenhuma Categoria
					saida = "Nenhuma Categoria  encontrado com o Nome '" + nome + "'";
				} else if (categoriaProdutos.size() == 1) {
					CategoriaProduto categoriaProduto = categoriaProdutos.get(0);
					saida = "Cliente encontrado: " + categoriaProduto.getNome();
					cp = buscarCliente(categoriaProduto);
				} else {
					// Caso encontre mais de um cliente
					saida = "Foram encontrados " + categoriaProdutos.size() + " categorias com o Nome '" + nome + "'";

				}
			}

			if (cmd.contains("Listar")) {
				categoriaProdutos = listarCategoriaProdutos();
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("categoriaProduto", cp);
			model.addAttribute("categoriaProdutos", categoriaProdutos);
		}
		return new ModelAndView("categoriaProduto");
	}

	private String cadastrarCliente(CategoriaProduto c) throws ClassNotFoundException, SQLException {
		String saida = cpDao.sp_iud_categoria_produto("I", c);
		return saida;
	}

	private String alterarCliente(CategoriaProduto c) throws ClassNotFoundException, SQLException {
		String saida = cpDao.sp_iud_categoria_produto("U", c);
		return saida;
	}

	private String excluirCliente(CategoriaProduto c) throws ClassNotFoundException, SQLException {
		String saida = cpDao.sp_iud_categoria_produto("D", c);
		return saida;
	}

	private CategoriaProduto buscarCliente(CategoriaProduto c) throws ClassNotFoundException, SQLException {
		c = cpDao.findBy(c);
		return c;
	}

	private List<CategoriaProduto> buscarClienteNome(String nome) throws ClassNotFoundException, SQLException {
		List<CategoriaProduto> categoriaProdutos = new ArrayList<>();
		categoriaProdutos = cpDao.findByName(nome);
		return categoriaProdutos;
	}

	private List<CategoriaProduto> listarCategoriaProdutos() throws ClassNotFoundException, SQLException {
		List<CategoriaProduto> categoriaProdutos = new ArrayList<>();
		categoriaProdutos = cpDao.findAll();
		return categoriaProdutos;
	}
}
