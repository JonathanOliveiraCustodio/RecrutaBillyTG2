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
import br.edu.fatec.zl.RecrutaBillyTG2.model.Funcionario;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.FuncionarioDao;
import jakarta.servlet.http.HttpSession;

@Controller
public class FuncionarioController {

	@Autowired
	GenericDao gDao;

	@Autowired
	FuncionarioDao fDao;

	@RequestMapping(name = "funcionario", value = "/funcionario", method = RequestMethod.GET)
	public ModelAndView funcionarioGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {

		String nivelAcesso = (String) session.getAttribute("nivelAcesso");
		String erro = "";
		String saida = "";

		List<Funcionario> funcionarios = new ArrayList<>();
		Funcionario f = null;
		// e = null;
		try {
			String cmd = allRequestParam.get("cmd");
			String CPF = allRequestParam.get("CPF");

			if (cmd != null) {
				if (cmd.contains("alterar")) {
					// Inicializando e antes de utilizá-lo
					f = new Funcionario();
					f.setCPF(CPF);
					f = buscarFuncionario(f);

				} else if (cmd.contains("excluir")) {
					// Inicializando e antes de utilizá-lo
					f = new Funcionario();
					f.setCPF(CPF);
					saida = excluirFuncionario(f);
					f = null;
				}
				funcionarios = listarFuncionarios();
			}

		} catch (ClassNotFoundException | SQLException error) {
			erro = error.getMessage();
		} finally {
			if (nivelAcesso == null || !nivelAcesso.equals("admin")) {
				saida = "Você não possui acesso para visualizar esta página.";
			}
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("funcionario", f);
			model.addAttribute("funcionarios", funcionarios);
		}

		return new ModelAndView("funcionario");
	}

	@RequestMapping(name = "funcionario", value = "/funcionario", method = RequestMethod.POST)
	public ModelAndView funcionarioPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
		// Parâmetros de entrada
		String cmd = allRequestParam.get("botao");
		String CPF = allRequestParam.get("CPF");
		String nome = allRequestParam.get("nome");
		String nivelAcesso = allRequestParam.get("nivelAcesso");
		String email = allRequestParam.get("email");
		String senha = allRequestParam.get("senha");
		String dataNascimento = allRequestParam.get("dataNascimento");
		String telefone = allRequestParam.get("telefone");
		String cargo = allRequestParam.get("cargo");
		String horario = allRequestParam.get("horario");
		String salario = allRequestParam.get("salario");
		String dataAdmissao = allRequestParam.get("dataAdmissao");
		String dataDesligamento = allRequestParam.get("dataDesligamento");
		String observacao = allRequestParam.get("observacao");

		// Parâmetros de saida
		String saida = "";
		String erro = "";

		Funcionario f = new Funcionario();
		List<Funcionario> funcionarios = new ArrayList<>();

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			f = null;

		} else

		if (!cmd.contains("Listar")) {
			f.setCPF(CPF);
		}

		if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
			f.setNome(nome);
			f.setNivelAcesso(nivelAcesso);
			f.setEmail(email);
			f.setSenha(senha);
			f.setDataNascimento(Date.valueOf(dataNascimento));
			f.setTelefone(telefone);
			f.setCargo(cargo);
			f.setHorario(horario);
			
			 // Remover a máscara de moeda
			salario = salario.replace("R$", "").replace(".", "").replace(",", ".");
			
			f.setSalario(Float.parseFloat(salario));
			f.setDataAdmissao(Date.valueOf(dataAdmissao));
			if (dataDesligamento != null && !dataDesligamento.trim().isEmpty()) {
				f.setDataDesligamento(Date.valueOf(dataDesligamento));
			} else {
				f.setDataDesligamento(null); 
			}
			f.setObservacao(observacao);
		}
		try {
			if (cmd.contains("Cadastrar")) {
				saida = cadastrarFuncionario(f);
				f = null;
			}
			if (cmd.contains("Alterar")) {
				saida = alterarFuncionario(f);
				f = null;
			}
			if (cmd.contains("Excluir")) {
				// Buscar um Usuario antes de Excluir para realizar a Validação
				Funcionario func = buscarFuncionario(f);
				if (func != null) {
					saida = excluirFuncionario(f);
					f = null;
				} else {
					saida = "Nenhum Funcionário encontrado com o CPF " + CPF;
				}
			}
			if (cmd.contains("Buscar")) {
				// Buscar clientes pelo nome
				funcionarios = buscarFuncionarioNome(nome);
				// Verificar o número de registros retornados
				if (funcionarios.isEmpty()) {
					// Caso não encontre nenhum cliente
					saida = "Nenhum Funcionário encontrado com o Nome '" + nome + "'";
				} else if (funcionarios.size() == 1) {
					Funcionario funcionario = funcionarios.get(0);
					saida = "Funcionário encontrado: " + funcionario.getNome();
					f = buscarFuncionario(funcionario);
				} else {
					// Caso encontre mais de um Funcionário
					saida = "Foram encontrados " + funcionarios.size() + " funcionários com o Nome '" + nome + "'";

				}
			}
			if (cmd.contains("Listar")) {
				funcionarios = listarFuncionarios();
			}
			
			if (cmd.contains("Endereço")) {
				f = buscarFuncionario(f);
				if (f == null) {
					saida = "Nenhum Funcionário encontrado com o CPF especificado.";
					f = null;
				} else {
					model.addAttribute("funcionario", f);
					return new ModelAndView("forward:/endereco", model);
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("funcionario", f);
			model.addAttribute("funcionarios", funcionarios);
		}
		return new ModelAndView("funcionario");
	}

	private String cadastrarFuncionario(Funcionario u) throws ClassNotFoundException, SQLException {
		String saida = fDao.sp_iud_funcionario("I", u);
		return saida;
	}

	private String alterarFuncionario(Funcionario u) throws ClassNotFoundException, SQLException {
		String saida = fDao.sp_iud_funcionario("U", u);
		return saida;
	}

	private String excluirFuncionario(Funcionario u) throws ClassNotFoundException, SQLException {
		String saida = fDao.sp_iud_funcionario("D", u);
		return saida;
	}

	private Funcionario buscarFuncionario(Funcionario u) throws ClassNotFoundException, SQLException {
		u = fDao.findBy(u);
		return u;

	}

	private List<Funcionario> listarFuncionarios() throws ClassNotFoundException, SQLException {
		List<Funcionario> usuarios = new ArrayList<>();
		usuarios = fDao.findAll();
		return usuarios;
	}
	
	private List<Funcionario> buscarFuncionarioNome(String nome) throws ClassNotFoundException, SQLException {
		List<Funcionario> funcionarios = new ArrayList<>();
		funcionarios = fDao.findByName(nome);
		return funcionarios;
	}
}
