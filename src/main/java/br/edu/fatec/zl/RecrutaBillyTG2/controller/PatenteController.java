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

import br.edu.fatec.zl.RecrutaBillyTG2.model.Patente;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.PatenteDao;
import jakarta.servlet.http.HttpSession;

@Controller
public class PatenteController {

	@Autowired
	GenericDao gDao;

	@Autowired
	PatenteDao pDao;

	@RequestMapping(name = "patente", value = "/patente", method = RequestMethod.GET)
	public ModelAndView categoriaProdutoGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {

		String nivelAcesso = (String) session.getAttribute("nivelAcesso");
		String erro = "";
		String saida = "";

		List<Patente> patentes = new ArrayList<>();
		Patente p = null;

		try {
			String cmd = allRequestParam.get("cmd");
			String codigo = allRequestParam.get("codigo");

			if (cmd != null) {
				if (cmd.contains("alterar")) {
					// Inicializando antes de utilizá-lo
					p = new Patente();
					p.setCodigo(Integer.parseInt(codigo));
					p = buscarPatente(p);

				} else if (cmd.contains("excluir")) {
					// Inicializando antes de utilizá-lo
					p = new Patente();
					p.setCodigo(Integer.parseInt(codigo));
					saida = excluirPatente(p);
					p = null;
				}
				patentes = listarPatentes();
			}

		} catch (ClassNotFoundException | SQLException error) {
			erro = error.getMessage();
		} finally {
			if (nivelAcesso == null || !nivelAcesso.equals("admin")) {
				saida = "Você não possui acesso para visualizar esta página.";
			}
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("patente", p);
			model.addAttribute("patentes", patentes);
		}

		return new ModelAndView("patente");
	}

	@RequestMapping(name = "patente", value = "/patente", method = RequestMethod.POST)
	public ModelAndView patentePost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
		// Parâmetros de entrada
		String cmd = allRequestParam.get("botao");
		String nome = allRequestParam.get("nome");
		String instituicao = allRequestParam.get("instituicao");
		String codigo = allRequestParam.get("codigo");

		// Parâmetros de saída
		String saida = "";
		String erro = "";

		Patente p = new Patente();
		List<Patente> patentes = new ArrayList<>();

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			p = null;

		} else if (!cmd.contains("Listar")) {
			p.setNome(nome);
		}

		if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
			if (codigo != null && !codigo.isEmpty()) {
				p.setCodigo(Integer.parseInt(codigo));
			}
			p.setNome(nome);
			p.setInstituicao(instituicao);

		}

		try {
			if (cmd.contains("Cadastrar")) {
				saida = cadastrarPatente(p);
				p = null;
			}
			if (cmd.contains("Alterar")) {
				saida = alterarPatente(p);
				p = null;
			}
			if (cmd.contains("Excluir")) {
				p = new Patente();
				p.setCodigo(Integer.parseInt(codigo));
				saida = excluirPatente(p);
				p = null;
			}
			if (cmd.contains("Buscar")) {
				// Buscar clientes pelo nome
				patentes = buscarPatenteNome(nome);
				// Verificar o número de registros retornados
				if (patentes.isEmpty()) {
					// Caso não encontre nenhuma Categoria
					saida = "Nenhuma Patente  encontrado com o Nome '" + nome + "'";
				} else if (patentes.size() == 1) {
					Patente patente = patentes.get(0);
					saida = "Patente encontrado: " + patente.getNome();
					p = buscarPatente(patente);
				} else {
					// Caso encontre mais de uma patente
					saida = "Foram encontrados " + patentes.size() + " patentes com o Nome '" + nome + "'";

				}
			}

			if (cmd.contains("Listar")) {
				patentes = listarPatentes();
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("patente", p);
			model.addAttribute("patentes", patentes);
		}
		return new ModelAndView("patente");
	}

	private String cadastrarPatente(Patente p) throws ClassNotFoundException, SQLException {
		String saida = pDao.sp_iud_patente("I", p);
		return saida;
	}

	private String alterarPatente(Patente p) throws ClassNotFoundException, SQLException {
		String saida = pDao.sp_iud_patente("U", p);
		return saida;
	}

	private String excluirPatente(Patente p) throws ClassNotFoundException, SQLException {
		String saida = pDao.sp_iud_patente("D", p);
		return saida;
	}

	private Patente buscarPatente(Patente p) throws ClassNotFoundException, SQLException {
		p = pDao.findBy(p);
		return p;
	}

	private List<Patente> buscarPatenteNome(String nome) throws ClassNotFoundException, SQLException {
		List<Patente> patentes = new ArrayList<>();
		patentes = pDao.findByName(nome);
		return patentes;
	}

	private List<Patente> listarPatentes() throws ClassNotFoundException, SQLException {
		List<Patente> patentes = new ArrayList<>();
		patentes = pDao.findAll();
		return patentes;
	}
}
