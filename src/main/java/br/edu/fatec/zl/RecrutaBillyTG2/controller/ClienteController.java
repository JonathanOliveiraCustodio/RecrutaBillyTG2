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

import br.edu.fatec.zl.RecrutaBillyTG2.model.Cliente;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ClienteDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import jakarta.servlet.http.HttpSession;

@Controller
public class ClienteController {

	@Autowired
	GenericDao gDao;

	@Autowired
	ClienteDao cDao;

	@RequestMapping(name = "cliente", value = "/cliente", method = RequestMethod.GET)
	public ModelAndView clienteGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {

		String nivelAcesso = (String) session.getAttribute("nivelAcesso");
		String erro = "";
		String saida = "";

		List<Cliente> clientes = new ArrayList<>();
		Cliente c = null;

		try {
			String cmd = allRequestParam.get("cmd");
			String codigo = allRequestParam.get("codigo");

			if (cmd != null) {
				if (cmd.contains("alterar")) {
					// Inicializando antes de utilizá-lo
					c = new Cliente();
					c.setCodigo(Integer.parseInt(codigo));
					c = buscarCliente(c);

				} else if (cmd.contains("excluir")) {
					// Inicializando antes de utilizá-lo
					c = new Cliente();
					c.setCodigo(Integer.parseInt(codigo));
					saida = excluirCliente(c);
					c = null;
				}
				clientes = listarClientes();
			}

		} catch (ClassNotFoundException | SQLException error) {
			erro = error.getMessage();
		} finally {
			if (nivelAcesso == null || !nivelAcesso.equals("admin")) {
				saida = "Você não possui acesso para visualizar esta página.";
			}
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("cliente", c);
			model.addAttribute("clientes", clientes);
		}

		return new ModelAndView("cliente");
	}

	@RequestMapping(name = "cliente", value = "/cliente", method = RequestMethod.POST)
	public ModelAndView clientePost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
		// Parâmetros de entrada
		String cmd = allRequestParam.get("botao");
		String nome = allRequestParam.get("nome");
		String telefone = allRequestParam.get("telefone");
		String email = allRequestParam.get("email");
		String documento = allRequestParam.get("documento");
		String codigo = allRequestParam.get("codigo");
		String tipo = allRequestParam.get("tipo");
		String CEP = allRequestParam.get("CEP");
		String logradouro = allRequestParam.get("logradouro");
		String bairro = allRequestParam.get("bairro");
		String localidade = allRequestParam.get("localidade");
		String UF = allRequestParam.get("UF");
		String complemento = allRequestParam.get("complemento");
		String numero = allRequestParam.get("numero");
		String dataNascimento = allRequestParam.get("dataNascimento");

		// Parâmetros de saída
		String saida = "";
		String erro = "";

		Cliente c = new Cliente();
		List<Cliente> clientes = new ArrayList<>();

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			c = null;

		} else if (!cmd.contains("Listar")) {
			c.setNome(nome);
		}

		if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
			
			if (codigo != null && !codigo.isEmpty()) {
				c.setCodigo(Integer.parseInt(codigo));
			}
			
			c.setNome(nome);
			c.setTelefone(telefone);
			c.setEmail(email);
			c.setDocumento(documento);
			c.setTipo(tipo);
			c.setCEP(CEP);
			c.setLogradouro(logradouro);
			c.setBairro(bairro);
			c.setLocalidade(localidade);
			c.setUF(UF);
			c.setComplemento(complemento);
			c.setNumero(numero);
			c.setDataNascimento(Date.valueOf(dataNascimento));
		}

		try {
			if (cmd.contains("Cadastrar")) {
				saida = cadastrarCliente(c);
				c = null;
			}
			if (cmd.contains("Alterar")) {
				saida = alterarCliente(c);
				c = null;
			}
			if (cmd.contains("Excluir")) {
				c = new Cliente();
				c.setCodigo(Integer.parseInt(codigo));
				saida = excluirCliente(c);
				c = null;
			}
			if (cmd.contains("Buscar")) {
				// Buscar clientes pelo nome
				clientes = buscarClienteNome(nome);
				// Verificar o número de registros retornados
				if (clientes.isEmpty()) {
					// Caso não encontre nenhum cliente
					saida = "Nenhum Cliente encontrado com o Nome '" + nome + "'";
				} else if (clientes.size() == 1) {
					Cliente cliente = clientes.get(0);
					saida = "Cliente encontrado: " + cliente.getNome();
					c = buscarCliente(cliente);
				} else {
					// Caso encontre mais de um cliente
					saida = "Foram encontrados " + clientes.size() + " clientes com o Nome '" + nome + "'";

				}
			}

			if (cmd.contains("Listar")) {
				clientes = listarClientes();
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("cliente", c);
			model.addAttribute("clientes", clientes);
		}
		return new ModelAndView("cliente");
	}

	private String cadastrarCliente(Cliente c) throws ClassNotFoundException, SQLException {
		String saida = cDao.sp_iud_cliente("I", c);
		return saida;
	}

	private String alterarCliente(Cliente c) throws ClassNotFoundException, SQLException {
		String saida = cDao.sp_iud_cliente("U", c);
		return saida;
	}

	private String excluirCliente(Cliente c) throws ClassNotFoundException, SQLException {
		String saida = cDao.sp_iud_cliente("D", c);
		return saida;
	}

	private Cliente buscarCliente(Cliente c) throws ClassNotFoundException, SQLException {
		c = cDao.findBy(c);
		return c;
	}

	private List<Cliente> buscarClienteNome(String nome) throws ClassNotFoundException, SQLException {
		List<Cliente> clientes = new ArrayList<>();
		clientes = cDao.findByName(nome);
		return clientes;
	}

	private List<Cliente> listarClientes() throws ClassNotFoundException, SQLException {
		List<Cliente> clientes = new ArrayList<>();
		clientes = cDao.findAll();
		return clientes;
	}
}
