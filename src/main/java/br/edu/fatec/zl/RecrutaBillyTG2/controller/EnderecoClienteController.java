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

import br.edu.fatec.zl.RecrutaBillyTG2.model.Endereco;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Funcionario;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.EnderecoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.FuncionarioDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;

@Controller
public class EnderecoClienteController {

	@Autowired
	GenericDao gDao;

	@Autowired
	EnderecoDao eDao;

	@Autowired
	FuncionarioDao fDao;

	@RequestMapping(name = "endereco", value = "/endereco", method = RequestMethod.GET)
	public ModelAndView enderecoGet(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String erro = "";
		String saida = "";
		String funcionario = allRequestParam.get("funcionario");
		String codigo = allRequestParam.get("codigo");
		String cmd = allRequestParam.get("cmd");
		List<Endereco> enderecos = new ArrayList<>();

		Funcionario f = new Funcionario();
		Endereco e = new Endereco();
		f.setCPF(funcionario);
		try {

			if (cmd != null) {
				e.setCodigo(Integer.parseInt(codigo));
				f.setCPF(funcionario);
				f = buscarFuncionario(f);
				e.setFuncionario(f);
				if (cmd.contains("alterar")) {
					e = buscarEndereco(e);
				} else {
					if (cmd.contains("excluir")) {
						e = buscarEndereco(e);
						saida = excluirEndereco(e);
						e = null;
					} 
					
				}
			}

			enderecos = listarEnderecos(funcionario);

		} catch (ClassNotFoundException | SQLException error) {
			erro = error.getMessage();

		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("funcionario", f);
			model.addAttribute("endereco", e);
			model.addAttribute("enderecos", enderecos);

		}
		return new ModelAndView("endereco");
	}

	@RequestMapping(value = "/endereco", method = RequestMethod.POST)
	public ModelAndView enderecoPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String cmd = allRequestParam.get("botao");
		String CPF = allRequestParam.get("funcionario");
		String codigo = allRequestParam.get("codigo");
		String CEP = allRequestParam.get("CEP");
		String logradouro = allRequestParam.get("logradouro");
		String bairro = allRequestParam.get("bairro");
		String localidade = allRequestParam.get("localidade");
		String UF = allRequestParam.get("UF");
		String complemento = allRequestParam.get("complemento");
		String numero = allRequestParam.get("numero");
		String tipoEndereco = allRequestParam.get("tipoEndereco");

		String saida = "";
		String erro = "";

		List<Endereco> enderecos = new ArrayList<>();

		Funcionario f = new Funcionario();
		Endereco e = new Endereco();

		try {
			enderecos = listarEnderecos(CPF);

			if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
				e = null;

			} else if (!cmd.contains("Listar")) {
				f.setCPF(CPF);
				f = buscarFuncionario(f);
				e.setFuncionario(f);
			}
			
			if (cmd.contains("Cadastrar") || cmd.contains("Alterar") || cmd.contains("Excluir")) {
				e.setCodigo(Integer.parseInt(codigo));
				e.setFuncionario(f);
				e.setCEP(CEP);
				e.setLogradouro(logradouro);
				e.setBairro(bairro);
				e.setLocalidade(localidade);
				e.setUF(UF);
				e.setComplemento(complemento);
				e.setNumero(numero);
				e.setTipoEndereco(tipoEndereco);
			}

			if (cmd.contains("Cadastrar")) {
				saida = cadastrarEndereco(e);
				e = null;
			}
			if (cmd.contains("Excluir")) {
				saida = excluirEndereco(e);
			}
			if (cmd.contains("Alterar")) {
				saida = alterarEndereco(e);
			}
			if (cmd.contains("Buscar")) {
				e = buscarEndereco(e);
				if (e == null) {
					saida = "Nenhum conteudo encontrado com o código especificado.";
				}
			}
			enderecos = listarEnderecos(CPF);

		} catch (SQLException | ClassNotFoundException error) {
			erro = error.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("funcionario", f);
			model.addAttribute("endereco", e);
			model.addAttribute("enderecos", enderecos);
		}

		return new ModelAndView("endereco");
	}

	private String cadastrarEndereco(Endereco e) throws SQLException, ClassNotFoundException {
		String saida = eDao.sp_iud_endereco("I", e);
		return saida;

	}

	private String excluirEndereco(Endereco e) throws SQLException, ClassNotFoundException {
		String saida = eDao.sp_iud_endereco("D", e);
		return saida;
	}

	private String alterarEndereco(Endereco e) throws SQLException, ClassNotFoundException {
		String saida = eDao.sp_iud_endereco("U", e);
		return saida;
	}

	private List<Endereco> listarEnderecos(String CPF) throws SQLException, ClassNotFoundException {
		List<Endereco> enderecos = eDao.findAll(CPF);
		return enderecos;
	}

	private Funcionario buscarFuncionario(Funcionario f) throws SQLException, ClassNotFoundException {
		f = fDao.findBy(f);
		return f;
	}

	private Endereco buscarEndereco(Endereco e) throws SQLException, ClassNotFoundException {
		e = eDao.findBy(e);
		return e;
	}

}