package br.edu.fatec.zl.RecrutaBillyTG2.controller;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fatec.zl.RecrutaBillyTG2.model.Despesa;
import jakarta.servlet.http.HttpSession;

@Controller
public class DespesaController {
	@RequestMapping(name = "despesas", value = "/despesas", method = RequestMethod.GET)
	public ModelAndView despesasGet(@RequestParam Map<String, String> allRequestParam, ModelMap model, HttpSession session) {
		return new ModelAndView("despesas");
	}
	
	@RequestMapping(name = "despesas", value = "/despesas", method = RequestMethod.POST)
	public ModelAndView despesasPost(@RequestParam Map<String, String> allRequestParam, ModelMap model, HttpSession session) throws SQLException, ClassNotFoundException {
		String cmd = allRequestParam.get("botao");
		String codigo = allRequestParam.get("codigo");
		String nome = allRequestParam.get("nome");
		String dataInicio = allRequestParam.get("data");
		String dataVencimento = allRequestParam.get("dataVencimento");
		String valor = allRequestParam.get("valor");
		String tipo = allRequestParam.get("tipo");
		String estado = allRequestParam.get("estado");
		String filtro = allRequestParam.get("filtro");
		
		String saida = "";
		String erro = "";
		
		Despesa d = new Despesa();
		List<Despesa> despesas = new ArrayList<>();	
		
		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			d = null;
		} else if (!cmd.contains("Listar")) {
			d.setCodigo(Integer.parseInt(codigo));
		}
		
		if(cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
			d.setCodigo(Integer.parseInt(codigo));
			d.setNome(nome);
			d.setData(Date.valueOf(dataInicio));
			d.setDataVencimento(Date.valueOf(dataVencimento));
			d.setValor(Float.parseFloat(valor));
			d.setTipo(tipo);
			d.setEstado(estado);
		}
		try {
			if(cmd.contains("Cadastrar")) {
				saida = cadastrarDespesa(d);
				d = null;
			}
			if(cmd.contains("Alterar")) {
				saida = alterarDespesa(d);
				d = null;
			}
			if(cmd.contains("Excluir")) {
				d = excluirDespesa(d);
				d = null;
			}
			if(cmd.contains("Buscar")) {
				d = buscarDespesa(d);
				if(d==null) {
					erro = "Despesa não encontrada";
				}
			}
			if(cmd.contains("Listar")) {
				despesas = listarDespesas(filtro);
			}
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("despesa", d);
			model.addAttribute("despesas", despesas);
		}
		return new ModelAndView("despesa");
	}
	
	private String cadastrarDespesa(Despesa d) {
		// TODO Auto-generated method stub
		return null;
	}

	private String alterarDespesa(Despesa d) {
		// TODO Auto-generated method stub
		return null;
	}

	private Despesa excluirDespesa(Despesa d) {
		// TODO Auto-generated method stub
		return null;
	}

	private Despesa buscarDespesa(Despesa d) {
		// TODO Auto-generated method stub
		return null;
	}

	private List<Despesa> listarDespesas(String filtro) {
		// TODO Auto-generated method stub
		return null;
	}
}
