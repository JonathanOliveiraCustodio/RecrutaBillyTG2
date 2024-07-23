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

import br.edu.fatec.zl.RecrutaBillyTG2.model.Fornecedor;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.FornecedorDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import jakarta.servlet.http.HttpSession;

@Controller
public class FornecedorController {

	@Autowired
	GenericDao gDao;

	@Autowired
	FornecedorDao fDao;

	@RequestMapping(name = "fornecedor", value = "/fornecedor", method = RequestMethod.GET)
	public ModelAndView fornecedorGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {

		String nivelAcesso = (String) session.getAttribute("nivelAcesso");
		String erro = "";
		String saida = "";

		List<Fornecedor> fornecedores = new ArrayList<>();
		Fornecedor f = new Fornecedor();

		try {
			String cmd = allRequestParam.get("cmd");
			String codigo = allRequestParam.get("codigo");

			if (cmd != null) {
				if (cmd.contains("alterar")) {
					f.setCodigo(Integer.parseInt(codigo));
					f = buscarFornecedor(f);

				} else if (cmd.contains("excluir")) {
					f.setCodigo(Integer.parseInt(codigo));
					saida = excluirFornecedor(f);
					f = null;

				}
				fornecedores = listarFornecedores();
			}

		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();
		} finally {
			if (nivelAcesso == null || !nivelAcesso.equals("admin")) {
				saida = "Você não possui acesso para visualizar esta página.";
			}
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("fornecedor", f);
			model.addAttribute("fornecedores", fornecedores);
		}

		return new ModelAndView("fornecedor");
	}

	@RequestMapping(name = "fornecedor", value = "/fornecedor", method = RequestMethod.POST)
	public ModelAndView fornecedorPost(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {

		String cmd = allRequestParam.get("botao");
		String codigo = allRequestParam.get("codigo");
		String nome = allRequestParam.get("nome");
		String endereco = allRequestParam.get("endereco");
		String telefone = allRequestParam.get("telefone");
		String email = allRequestParam.get("email");
		String empresa = allRequestParam.get("empresa");

		String saida = "";
		String erro = "";

		Fornecedor f = new Fornecedor();
		List<Fornecedor> fornecedores = new ArrayList<>();

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			f = null;

		} else if (!cmd.contains("Listar")) {
			f.setCodigo(Integer.parseInt(codigo));
		}
		try {
			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
				f.setNome(nome);
				f.setEndereco(endereco);
				f.setTelefone(telefone);
				f.setEmail(email);
				f.setEmpresa(empresa);
			}
			if (cmd.contains("Cadastrar")) {
				cadastrarFornecedor(f);
				saida = "Fornecedor Cadastrado com sucesso!";
				f = null;
			}
			if (cmd.contains("Alterar")) {
				alterarFornecedor(f);
				saida = "Fornecedor Alterado com sucesso!";
				f = null;
			}
			if (cmd.contains("Excluir")) {
				// Buscar um Fornecedor antes de Excluir para realizar a Validação
				Fornecedor forn = buscarFornecedor(f);
				if (forn != null) {
					saida = excluirFornecedor(f);
					f = null;
				} else {
					saida = "Nenhum Fornecedor encontrado com o código " + codigo;
				}
			}
			if (cmd.contains("Buscar")) {
				f = buscarFornecedor(f);
				if (f == null) {
					saida = "Nenhum Fornecedor encontrado com o código " + codigo;
				}
			}
			if (cmd.contains("Listar")) {
				fornecedores = listarFornecedores();
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("fornecedor", f);
			model.addAttribute("fornecedores", fornecedores);
		}
		return new ModelAndView("fornecedor");
	}

	private String cadastrarFornecedor(Fornecedor f) throws SQLException, ClassNotFoundException {
		String saida = fDao.iudFornecedor("I", f);
		return saida;

	}

	private String alterarFornecedor(Fornecedor f) throws SQLException, ClassNotFoundException {
		String saida = fDao.iudFornecedor("U", f);
		return saida;

	}

	private String excluirFornecedor(Fornecedor f) throws SQLException, ClassNotFoundException {

		String saida = fDao.iudFornecedor("D", f);
		return saida;
	}

	private Fornecedor buscarFornecedor(Fornecedor f) throws SQLException, ClassNotFoundException {
		f = fDao.consultar(f);
		return f;
	}

	private List<Fornecedor> listarFornecedores() throws SQLException, ClassNotFoundException {
		List<Fornecedor> fornecedores = fDao.listar();
		return fornecedores;
	}

}
