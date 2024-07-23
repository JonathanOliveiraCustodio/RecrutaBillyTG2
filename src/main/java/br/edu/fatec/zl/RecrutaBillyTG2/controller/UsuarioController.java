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
import br.edu.fatec.zl.RecrutaBillyTG2.model.Usuario;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.UsuarioDao;
import jakarta.servlet.http.HttpSession;

@Controller
public class UsuarioController {

	@Autowired
	GenericDao gDao;

	@Autowired
	UsuarioDao uDao;

	@RequestMapping(name = "usuario", value = "/usuario", method = RequestMethod.GET)
	public ModelAndView usuarioGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {

		String nivelAcesso = (String) session.getAttribute("nivelAcesso");
		String erro = "";
		String saida = "";

		List<Usuario> usuarios = new ArrayList<>();
		Usuario u = null; 
		//e = null;
		try {
			String cmd = allRequestParam.get("cmd");
			String CPF = allRequestParam.get("CPF");

			if (cmd != null) {
	            if (cmd.contains("alterar")) {
	                // Inicializando e antes de utilizá-lo
	                u = new Usuario();
	                u.setCPF(CPF);
	                u = buscarUsuario(u);

	            } else if (cmd.contains("excluir")) {
	                // Inicializando e antes de utilizá-lo
	            	u = new Usuario();
	                u.setCPF(CPF);
	                saida = excluirUsuario(u);
	                u = null;  
	            }
				usuarios = listarUsuarios();
			}

		} catch (ClassNotFoundException | SQLException error) {
			erro = error.getMessage();
		} finally {
			if (nivelAcesso == null || !nivelAcesso.equals("admin")) {
				saida = "Você não possui acesso para visualizar esta página.";
			}
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("usuario", u);
			model.addAttribute("usuarios", usuarios);
		}

		return new ModelAndView("usuario");
	}
	
	@RequestMapping(name = "usuario", value = "/usuario", method = RequestMethod.POST)
	public ModelAndView usuarioPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
		// Parâmetros de entrada
		String cmd = allRequestParam.get("botao");
		String CPF = allRequestParam.get("CPF");
		String nome = allRequestParam.get("nome");
		String nivelAcesso = allRequestParam.get("nivelAcesso");
		String email = allRequestParam.get("email");
		String senha = allRequestParam.get("senha");

		// Parâmetros de saida
		String saida = "";
		String erro = "";
		
		Usuario u = new Usuario();
		List<Usuario> usuarios = new ArrayList<>();
		
		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			u = null;

		} else

		if (!cmd.contains("Listar")) {
			u.setCPF(CPF);
		}

		if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
			u.setNome(nome);
			u.setNivelAcesso(nivelAcesso);
			u.setEmail(email);
			u.setSenha(senha);

		}
		try {
			if (cmd.contains("Cadastrar")) {
				saida = cadastrarUsuario(u);
				u = null;
			}
			if (cmd.contains("Alterar")) {
				saida = alterarUsuario(u);
				u = null;
			}
			if (cmd.contains("Excluir")) {
				// Buscar um Usuario antes de Excluir para realizar a Validação
				Usuario usu = buscarUsuario(u);
				if (usu != null) {
					saida = excluirUsuario(u);
					u = null;
				} else {
					saida = "Nenhum Usuario encontrado com o CPF " + CPF;
				}
			}
			if (cmd.contains("Buscar")) {
				u = buscarUsuario(u);
				if (u == null) {
					saida = "Nenhum Usuario encontrado com o CPF " + CPF ;
				}
			}
			if (cmd.contains("Listar")) {
				usuarios = listarUsuarios();
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("usuario", u);
			model.addAttribute("usuarios", usuarios);
		}
		return new ModelAndView("usuario");
	}

	private String cadastrarUsuario(Usuario u) throws ClassNotFoundException, SQLException {
		String saida = uDao.iudUsuario("I", u);
		return saida;
	}

	private String alterarUsuario(Usuario u) throws ClassNotFoundException, SQLException {
		String saida = uDao.iudUsuario("U", u);
		return saida;
	}

	private String excluirUsuario(Usuario u) throws ClassNotFoundException, SQLException {
		String saida = uDao.iudUsuario("D", u);
		return saida;
	}

	private Usuario buscarUsuario(Usuario u) throws ClassNotFoundException, SQLException {
		u = uDao.consultar(u);
		return u;
		
	}

	private List<Usuario> listarUsuarios() throws ClassNotFoundException, SQLException {
		List<Usuario> usuarios = new ArrayList<>();
		usuarios = uDao.listar();
		return usuarios;
	}
}
