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

import br.edu.fatec.zl.RecrutaBillyTG2.model.NomeTarjeta;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Patente;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.NomeTarjetaDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.PatenteDao;
import jakarta.servlet.http.HttpSession;

@Controller
public class NomeTarjetaController {

	@Autowired
	GenericDao gDao;

	@Autowired
	PatenteDao pDao;

	@Autowired
	NomeTarjetaDao ntDao;

	@RequestMapping(name = "nometarjeta", value = "/nometarjeta", method = RequestMethod.GET)
	public ModelAndView nometarjetaGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {

		String nivelAcesso = (String) session.getAttribute("nivelAcesso");
		String erro = "";
		String saida = "";

		List<Patente> patentes = new ArrayList<>();
		List<NomeTarjeta> nomesTarjetas = new ArrayList<>();

		NomeTarjeta nt = null;

		try {
			String cmd = allRequestParam.get("cmd");
			String codigo = allRequestParam.get("codigo");
			patentes = listarPatentes();
			nomesTarjetas = listarNomesTarjetas();
			if (cmd != null) {
				if (cmd.contains("alterar")) {
					// Inicializando antes de utilizá-lo
					nt = new NomeTarjeta();
					nt.setCodigo(Integer.parseInt(codigo));
					nt = buscarNomeTarjeta(nt);

				} else if (cmd.contains("excluir")) {
					// Inicializando antes de utilizá-lo
					nt = new NomeTarjeta();
					nt.setCodigo(Integer.parseInt(codigo));
					saida = excluirNomeTarjeta(nt);
					nt = null;
				}
				// categoriaProdutos = listarCategoriaProdutos();
			}

		} catch (ClassNotFoundException | SQLException error) {
			erro = error.getMessage();
		} finally {
			if (nivelAcesso == null || !nivelAcesso.equals("admin")) {
				saida = "Você não possui acesso para visualizar esta página.";
			}
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("nometarjeta", nt);
			model.addAttribute("patentes", patentes);
			model.addAttribute("nomesTarjetas", nomesTarjetas);

		}

		return new ModelAndView("nometarjeta");
	}

	@RequestMapping(name = "nometarjeta", value = "/nometarjeta", method = RequestMethod.POST)
	public ModelAndView nometarjetaPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
		String cmd = allRequestParam.get("botao"); // Pega o valor do botão
		String codigo = allRequestParam.get("codigo");
		String nome = allRequestParam.get("nome");
		String tipoSanguineo = allRequestParam.get("tipoSanguineo");
		String fatorRH = allRequestParam.get("fatorRH");
		String quantidade = allRequestParam.get("quantidade");
		String patente = allRequestParam.get("patente");

		String novoNome = allRequestParam.get("novoNome");
		String novoTipoSanguineo = allRequestParam.get("novoTipoSanguineo");
		String novoFatorRH = allRequestParam.get("novoFatorRH");
		String novoQuantidade = allRequestParam.get("novoQuantidade");
		String novoPatente = allRequestParam.get("novoPatente");

		String saida = "";
		String erro = "";

		List<NomeTarjeta> nomesTarjetas = new ArrayList<>();
		List<Patente> patentes = new ArrayList<>();

		NomeTarjeta nt = new NomeTarjeta();
		Patente p = new Patente();

		try {
			patentes = listarPatentes();

			// Verifica se cmd não é nulo
			if (cmd != null && !cmd.isEmpty()) {
				if (cmd.contains("Limpar")) {
					nt = null;
				} else if (!cmd.contains("Listar")) {
					nt.setNome(nome);
				}

				if ("Salvar Novo".equals(cmd)) {
					// Cria um novo objeto NomeTarjeta com os valores do novo registro
					NomeTarjeta novoNt = new NomeTarjeta();
					novoNt.setNome(novoNome);
					novoNt.setTipoSanguineo(novoTipoSanguineo);
					novoNt.setFatorRH(novoFatorRH);
					novoNt.setQuantidade(Integer.parseInt(novoQuantidade));

					// Configura a patente do novo objeto, se houver
					if (novoPatente != null && !novoPatente.isEmpty()) {
						p.setCodigo(Integer.parseInt(novoPatente));
						p = buscarPatente(p); // Buscar detalhes da patente, caso necessário
						novoNt.setPatente(p);
					}

					// Cadastrar novo registro
					saida = cadastrarNomeTarjeta(novoNt);
				} 
				
				if ("Salvar Todos".equals(cmd)) {
	                // Salvar todos os registros alterados
	                int totalRegistros = (allRequestParam.size() - 1) / 7; // Dividir pelo número de campos por registro, menos o botão
	                for (int i = 0; i < totalRegistros; i++) {
	                    nt = new NomeTarjeta();
	                    codigo = allRequestParam.get("codigo[" + i + "]");
	                    if (codigo != null && !codigo.isEmpty()) {
	                        nt.setCodigo(Integer.parseInt(codigo));
	                    }
	                    nt.setNome(allRequestParam.get("nome[" + i + "]"));
	                    nt.setTipoSanguineo(allRequestParam.get("tipoSanguineo[" + i + "]"));
	                    nt.setFatorRH(allRequestParam.get("fatorRH[" + i + "]"));
	                    nt.setQuantidade(Integer.parseInt(allRequestParam.get("quantidade[" + i + "]")));

	                    patente = allRequestParam.get("patente[" + i + "]");
	                    if (patente != null && !patente.isEmpty()) {
	                        p = new Patente();
	                        p.setCodigo(Integer.parseInt(patente));
	                        p = buscarPatente(p);
	                        nt.setPatente(p);
	                    }

	                    saida = alterarNomeTarjeta(nt);
	                }
	            }
				
				if (cmd.contains("Selecionar")) {
					// Inicializando antes de utilizá-lo
					nt = new NomeTarjeta();
					nt.setCodigo(Integer.parseInt(codigo));
					nt = buscarNomeTarjeta(nt);
				}

				if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
					if (codigo != null && !codigo.isEmpty()) {
						nt.setCodigo(Integer.parseInt(codigo));
					}

					if (patente != null && !patente.isEmpty()) {
						p.setCodigo(Integer.parseInt(patente));
						p = buscarPatente(p);
						nt.setPatente(p);
					}
					nt.setNome(nome);
					nt.setTipoSanguineo(tipoSanguineo);
					nt.setFatorRH(fatorRH);
					nt.setPatente(p);
					nt.setQuantidade(Integer.parseInt(quantidade));
				}
				if (cmd.contains("Cadastrar")) {
					saida = cadastrarNomeTarjeta(nt);
					nt = null;
				}
				if (cmd.contains("Alterar")) {
					saida = alterarNomeTarjeta(nt);
					nt = null;
				}
				if (cmd.contains("Excluir")) {
					nt = new NomeTarjeta();
					nt.setCodigo(Integer.parseInt(codigo));
					nt = buscarNomeTarjeta(nt);
					// p.setCodigo(Integer.parseInt(patente));
					// p = buscarPatente(p);
					// nt.setPatente(p);
					saida = excluirNomeTarjeta(nt);
					nt = null;
				}
				if (cmd.contains("Buscar")) {
					// Buscar nome tarjeta pelo nome
					nomesTarjetas = buscarNomeTarjetaNome(nome);
					// Verificar o número de registros retornados
					if (nomesTarjetas.isEmpty()) {
						// Caso não encontre nenhum Insumo
						saida = "Nenhum nome de Tarjeta encontrado com o Nome '" + nome + "'";
					} else if (nomesTarjetas.size() == 1) {
						NomeTarjeta nomeTarjeta = nomesTarjetas.get(0);
						saida = "Insumo encontrado: " + nomeTarjeta.getNome();
						nt = buscarNomeTarjeta(nomeTarjeta);
					} else {
						// Caso encontre mais de um Nome Tarjeta
						saida = "Foram encontrados " + nomesTarjetas.size() + " Nomes de Tarjetas com o Nome '" + nome
								+ "'";
					}
				}
				if (cmd.contains("Listar")) {
					nomesTarjetas = listarNomesTarjetas();
				}
				
				
			}

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("nometarjeta", nt);
			model.addAttribute("nomesTarjetas", nomesTarjetas);
			model.addAttribute("patentes", patentes);
		}

		return new ModelAndView("nometarjeta");
	}

	private String cadastrarNomeTarjeta(NomeTarjeta nt) throws SQLException, ClassNotFoundException {
		String saida = ntDao.spManterNomeTarjeta("I", nt);
		return saida;
	}

	private String alterarNomeTarjeta(NomeTarjeta nt) throws SQLException, ClassNotFoundException {
		String saida = ntDao.spManterNomeTarjeta("U", nt);
		return saida;

	}

	private String excluirNomeTarjeta(NomeTarjeta nt) throws SQLException, ClassNotFoundException {
		String saida = ntDao.spManterNomeTarjeta("D", nt);
		return saida;

	}

	private NomeTarjeta buscarNomeTarjeta(NomeTarjeta nt) throws SQLException, ClassNotFoundException {
		nt = ntDao.findBy(nt);
		return nt;

	}

	private List<NomeTarjeta> listarNomesTarjetas() throws SQLException, ClassNotFoundException {
		List<NomeTarjeta> nomesTarjetas = ntDao.findAll();
		return nomesTarjetas;
	}

	private Patente buscarPatente(Patente p) throws SQLException, ClassNotFoundException {
		p = pDao.findBy(p);
		return p;
	}

	private List<Patente> listarPatentes() throws SQLException, ClassNotFoundException {
		List<Patente> patentes = pDao.findAll();
		return patentes;
	}

	private List<NomeTarjeta> buscarNomeTarjetaNome(String nome) throws ClassNotFoundException, SQLException {
		List<NomeTarjeta> nomesTarjetas = new ArrayList<>();
		nomesTarjetas = ntDao.findByName(nome);
		return nomesTarjetas;
	}

}
