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

import br.edu.fatec.zl.RecrutaBillyTG2.model.Despesa;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.DespesaDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import jakarta.servlet.http.HttpSession;

@Controller
public class DespesaController {
	
	@Autowired
	GenericDao gDao;
	
	@Autowired 
	DespesaDao dDao;
	
	@RequestMapping(name = "despesas", value = "/despesas", method = RequestMethod.GET)
	public ModelAndView despesasGet(@RequestParam Map<String, String> allRequestParam, ModelMap model, HttpSession session) {
		String nivelAcesso = (String) session.getAttribute("nivelAcesso");
		String entrada = allRequestParam.get("entrada");
		String gasto = allRequestParam.get("gasto");
		String saldo = allRequestParam.get("entrada");
		String erro = "";
		String saida = "";
		
		List<Despesa> despesas = new ArrayList<>();
		Despesa d = null;
		
		try {
			String cmd = allRequestParam.get("cmd");
			String codigo = allRequestParam.get("codigo");
			String filtro = allRequestParam.get("filtro");
			
			if(cmd != null) {
				if(cmd.contains("alterar")) {
					d = new Despesa();
					d.setCodigo(Integer.parseInt(codigo));
					d = buscarDespesa(d);
				}else {
					if(cmd.contains("excluir")) {
						d = new Despesa();
						d.setCodigo(Integer.parseInt(codigo));
						saida = excluirDespesa(d);
						d = null;
					}
				}
			}
		} catch(ClassNotFoundException | SQLException e) {
			erro = e.getMessage();
		}finally {
			if(nivelAcesso == null || !nivelAcesso.equals("admin")) {
				saida = "Você não possui acesso para visualizar esta página.";
			}
			entrada = "R$ " + Float.toString(calcularEntrada(despesas));
			gasto = "R$ " + Float.toString(calcularSaida(despesas));
			saldo = "R$ " + (Float.toString(calcularEntrada(despesas) - calcularSaida(despesas)));
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("entrada", entrada);
			model.addAttribute("gasto", gasto);
			model.addAttribute("saldo", saldo);
			model.addAttribute("despesa", d);
			model.addAttribute("despesas", despesas);
		}
		return new ModelAndView("despesas");
	}
	
	@RequestMapping(name = "despesas", value = "/despesas", method = RequestMethod.POST)
	public ModelAndView despesasPost(@RequestParam Map<String, String> allRequestParam, ModelMap model, HttpSession session) {
		String cmd = allRequestParam.get("botao");
		String codigo = allRequestParam.get("codigo");
		String nome = allRequestParam.get("nome");
		String dataInicio = allRequestParam.get("data");
		String dataVencimento = allRequestParam.get("dataVencimento");
		String valor = allRequestParam.get("valor");
		String tipo = allRequestParam.get("tipo");
		String pagamento = allRequestParam.get("pagamento");
		String estado = allRequestParam.get("estado");
		String filtro = allRequestParam.get("filtro");
		String entrada = allRequestParam.get("entrada");
		String gasto = allRequestParam.get("gasto");
		String saldo = allRequestParam.get("entrada");
		String pesquisa = allRequestParam.get("pesquisa");
		String[] meses = {"Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"};
		
		String saida = "";
		String erro = "";
		
		Despesa d = new Despesa();
		List<Despesa> despesas = new ArrayList<>();	
		
		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			d = null;
		} else if (!cmd.contains("Listar")) {
			if(codigo != null && codigo.isEmpty()) {				
				d.setCodigo(Integer.parseInt(codigo));
			}
		}
		
		if(cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
			d.setCodigo(Integer.parseInt(codigo));
			d.setNome(nome);
			d.setData(Date.valueOf(dataInicio));
			if(dataVencimento != null && !dataVencimento.isEmpty()) {			
				d.setDataVencimento(Date.valueOf(dataVencimento));
			}
			d.setValor(Float.parseFloat(valor));
			d.setTipo(tipo);
			d.setPagamento(pagamento);
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
				saida = excluirDespesa(d);
				d = null;
			}
			if(cmd.contains("Buscar")) {
				d = buscarDespesa(d);
				if(d==null) {
					erro = "Despesa não encontrada";
				}
			}
			if(cmd.contains("Listar")) {
				despesas = listarDespesas(Integer.parseInt(filtro));
				if(despesas.isEmpty()) {
					saida = "Nenhuma despesa para o mês de "+meses[Integer.parseInt(filtro)-1];
				}
			}
			if(cmd.contains("Pesquisar")) {
				despesas = pesquisarDespesas(pesquisa, Integer.parseInt(filtro));
				if(despesas.isEmpty()) {
					saida = "Nenhuma entrada encontrada com o parâmetro \""+pesquisa+"\"";
				}
			}
		} catch(ClassNotFoundException | SQLException e) {
			erro = e.getMessage();
		} finally {
			entrada = "R$ " + Float.toString(calcularEntrada(despesas));
			gasto = "R$ " + Float.toString(calcularSaida(despesas));
			saldo = "R$ " + (Float.toString(calcularEntrada(despesas) - calcularSaida(despesas)));
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("despesa", d);
			model.addAttribute("despesas", despesas);
			model.addAttribute("entrada", entrada);
			model.addAttribute("gasto", gasto);
			model.addAttribute("saldo", saldo);
		}
 		return new ModelAndView("despesas");
	}

	private List<Despesa> pesquisarDespesas(String pesquisa, int filtro) throws ClassNotFoundException, SQLException {
		List<Despesa> despesas = new ArrayList<>();
		List<Despesa> aux = new ArrayList<>();
		despesas = listarDespesas(filtro);
		for(Despesa d : despesas) {
			if(d.getNome().toUpperCase().contains(pesquisa.toUpperCase())) {
				aux.add(d);
			}
		}
		return aux;
	}

	private String cadastrarDespesa(Despesa d) throws ClassNotFoundException, SQLException {
		String saida = dDao.iudDespesa("I", d);
		return saida;
	}

	private String alterarDespesa(Despesa d) throws ClassNotFoundException, SQLException {
		String saida = dDao.iudDespesa("U", d);
		return saida;
	}

	private String excluirDespesa(Despesa d) throws ClassNotFoundException, SQLException {
		String saida = dDao.iudDespesa("D", d);
		return saida;
	}

	private Despesa buscarDespesa(Despesa d) throws ClassNotFoundException, SQLException {
		d = dDao.findBy(d);
		return d;
	}

	private List<Despesa> listarDespesas(int filtro) throws ClassNotFoundException, SQLException {
		List<Despesa> despesas = new ArrayList<>();
		List<Despesa> auxDespesas = new ArrayList<>();
		despesas = dDao.findAll();
		
		// Aplicação do filtro
		if(filtro != 0) {
			for(Despesa d : despesas) {
				if(d.getData().getMonth() + 1 == filtro) {
					auxDespesas.add(d);
				}
			}
			return auxDespesas;
		}
		return despesas;
	}
	
	private float calcularEntrada(List<Despesa> despesas) {
		float entrada = 0;
		for(Despesa d : despesas) {
			if(d.getTipo().equals("Entrada")) {
				entrada += d.getValor();
			}
		}
		return entrada;
	}
	
	private float calcularSaida(List<Despesa> despesas) {
		float saida = 0;
		for(Despesa d : despesas) {
			if(d.getTipo().equals("Saida")) {
				saida += d.getValor();
			}
		}
		return saida;
	}
}
