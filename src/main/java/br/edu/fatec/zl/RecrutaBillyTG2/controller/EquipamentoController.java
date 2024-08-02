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
import br.edu.fatec.zl.RecrutaBillyTG2.model.Equipamento;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.EquipamentoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import jakarta.servlet.http.HttpSession;

@Controller
public class EquipamentoController {

	@Autowired
	GenericDao gDao;

	@Autowired
	EquipamentoDao eDao;


	@RequestMapping(name = "equipamento", value = "/equipamento", method = RequestMethod.GET)
	public ModelAndView equipamentoGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {

		String nivelAcesso = (String) session.getAttribute("nivelAcesso");
		String erro = "";
		String saida = "";
		String cmd = allRequestParam.get("cmd");
		String codigo = allRequestParam.get("codigo");

		List<Equipamento> equipamentos = new ArrayList<>();
		Equipamento e = null; 
		//e = null;
		try {
			

			if (cmd != null) {
	            if (cmd.contains("alterar")) {
	                // Inicializando e antes de utilizá-lo
	                e = new Equipamento();
	                e.setCodigo(Integer.parseInt(codigo));
	                e = buscarEquipamento(e);

	            } else if (cmd.contains("excluir")) {
	                // Inicializando e antes de utilizá-lo
	                e = new Equipamento();
	                e.setCodigo(Integer.parseInt(codigo));
	                saida = excluirEquipamento(e);
	                e = null;  
	            }
				equipamentos = listarEquipamentos();
			}

		} catch (ClassNotFoundException | SQLException error) {
			erro = error.getMessage();
		} finally {
			if (nivelAcesso == null || !nivelAcesso.equals("admin")) {
				saida = "Você não possui acesso para visualizar esta página.";
			}
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("equipamento", e);
			model.addAttribute("equipamentos", equipamentos);
		}

		return new ModelAndView("equipamento");
	}

	@RequestMapping(name = "equipamento", value = "/equipamento", method = RequestMethod.POST)
	public ModelAndView equipamentoPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String cmd = allRequestParam.get("botao");
		String codigo = allRequestParam.get("codigo");
		String nome = allRequestParam.get("nome");
		String descricao = allRequestParam.get("descricao");
		String fabricante = allRequestParam.get("fabricante");
		String dataAquisicao= allRequestParam.get("dataAquisicao");

		String saida = "";
		String erro = "";
		Equipamento e = new Equipamento();

		List<Equipamento> equipamentos = new ArrayList<>();

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			e = null;
		} else if (!cmd.contains("Listar")) {
			e.setCodigo(Integer.parseInt(codigo));
		}
		try {
			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
				e.setNome(nome);
				e.setDescricao(descricao);
				e.setFabricante(fabricante);
				e.setDataAquisicao(Date.valueOf(dataAquisicao));
			}
			if (cmd.contains("Cadastrar")) {
				saida = cadastrarEquipamento(e);
				e = null;
			}
			if (cmd.contains("Alterar")) {
				saida = alterarEquipamento(e);
				e = null;
			}
			if (cmd.contains("Buscar")) {
				e = buscarEquipamento(e);
				if (e == null) {
					saida = "Nenhum Equipamento encontrado com o código " + codigo;
				}
			}
			if (cmd.contains("Excluir")) {
				// Buscar um Equipamento antes de Excluir para realizar a Validação
				Equipamento equi = buscarEquipamento(e);
				if (equi != null) {
					saida = excluirEquipamento(e);
					e = null; 
				} else {
					saida = "Nenhum Equipamento encontrado com o código " + codigo;
				}
			}
			if (cmd.contains("Listar")) {
				equipamentos = listarEquipamentos();
			}
			
			if (cmd.contains("Adicionar")) {
				e = buscarEquipamento(e);
				if (e == null) {
					saida = "Nenhum equipamento encontrado com o codigo especificado.";
					e = null;
				} else {
					model.addAttribute("equipamento", e);
					return new ModelAndView("forward:/manutencoesEquipamento", model);
				}
			}

		} catch (SQLException | ClassNotFoundException error) {
			erro = error.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("equipamento", e);
			model.addAttribute("equipamentos", equipamentos);

		}
		return new ModelAndView("equipamento");
	}

	private String cadastrarEquipamento(Equipamento e) throws SQLException, ClassNotFoundException {
		String saida = eDao.sp_iud_equipamento("I", e);
		return saida;
	}

	private String alterarEquipamento(Equipamento e) throws SQLException, ClassNotFoundException {
		String saida = eDao.sp_iud_equipamento("U", e);
		return saida;

	}

	private String excluirEquipamento(Equipamento e) throws SQLException, ClassNotFoundException {
		String saida = eDao.sp_iud_equipamento("D", e);
		return saida;

	}

	private Equipamento buscarEquipamento(Equipamento e) throws SQLException, ClassNotFoundException {
		e = eDao.findBy(e);
		return e;

	}

	private List<Equipamento> listarEquipamentos() throws SQLException, ClassNotFoundException {
		List<Equipamento> equipamentos = eDao.findAll();
		return equipamentos;
	}

}
