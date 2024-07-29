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
import br.edu.fatec.zl.RecrutaBillyTG2.model.Equipamento;
import br.edu.fatec.zl.RecrutaBillyTG2.model.ManutencaoEquipamento;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.EquipamentoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ManutencaoEquipamentoDao;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ManutencoesEquipamentoController {

	@Autowired
	EquipamentoDao eDao;

	@Autowired
	ManutencaoEquipamentoDao meDao;

	@RequestMapping(name = "manutencoesEquipamento", value = "/manutencoesEquipamento", method = RequestMethod.GET)
	public ModelAndView manutencoesEquipamentoGet(@RequestParam Map<String, String> allRequestParam,
			HttpServletRequest request, ModelMap model) {
	//	HttpSession session = request.getSession();

		String erro = "";
		String equipamento = allRequestParam.get("equipamento");
			
		Equipamento e = new Equipamento();
		e.setCodigo(Integer.parseInt(equipamento));

		List<ManutencaoEquipamento> equipamentoManutencoes = new ArrayList<>();

		try {
			
			equipamentoManutencoes = listarManutencoes(Integer.parseInt(equipamento));

		} catch (SQLException | ClassNotFoundException error) {
			erro = error.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("equipamento", e);
			model.addAttribute("equipamentoManutencoes", equipamentoManutencoes);
		}

		return new ModelAndView("manutencoesEquipamento");
	}

	@RequestMapping(name = "manutencoesEquipamento", value = "/manutencoesEquipamento", method = RequestMethod.POST)
	public ModelAndView manutencoesEquipamentoPost(@RequestParam Map<String, String> allRequestParam,
			HttpServletRequest request, ModelMap model) {

		String cmd = allRequestParam.get("botao");
		String codigoEquipamento = allRequestParam.get("equipamento");
		String codigoManutencao = allRequestParam.get("codigoManutencao");
		String descricaoManutencao = allRequestParam.get("descricao");

		ManutencaoEquipamento me = new ManutencaoEquipamento();
		List<ManutencaoEquipamento> equipamentoManutencoes = new ArrayList<>();

		String saida = "";
		String erro = "";

		try {

			if (cmd.contains("Cadastrar")) {
				me.setCodigoEquipamento(Integer.parseInt(codigoEquipamento));
				me.setDescricao(descricaoManutencao);
				saida = AdicionarManutencao(me);
			}
			if (cmd.contains("Excluir")) {
				me.setCodigoEquipamento(Integer.parseInt(codigoEquipamento));
				me.setCodigoManutencao(Integer.parseInt(codigoManutencao));

				saida = excluirManutencao(me);
			}
			equipamentoManutencoes = listarManutencoes(Integer.parseInt(codigoEquipamento));

		} catch (SQLException | ClassNotFoundException error) {
			erro = error.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("manutencoesEquipamento", me);
			model.addAttribute("equipamentoManutencoes", equipamentoManutencoes);

		}
		return new ModelAndView("manutencoesEquipamento");
	}

	private List<ManutencaoEquipamento> listarManutencoes(int codigoEquipamento)
			throws ClassNotFoundException, SQLException {
		return meDao.findAllCodigo(codigoEquipamento);
	}

	private String AdicionarManutencao(ManutencaoEquipamento me) throws SQLException, ClassNotFoundException {
		String saida = meDao.sp_manutencaoEquipamento("I", me);
		return saida;

	}

	private String excluirManutencao(ManutencaoEquipamento me) throws SQLException, ClassNotFoundException {
		String saida = meDao.sp_manutencaoEquipamento("D", me);
		return saida;

	}
}
