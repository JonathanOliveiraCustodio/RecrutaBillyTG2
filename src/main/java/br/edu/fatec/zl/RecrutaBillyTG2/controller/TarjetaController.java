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
import br.edu.fatec.zl.RecrutaBillyTG2.model.Tarjeta;
import br.edu.fatec.zl.RecrutaBillyTG2.model.CategoriaProduto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.NomeTarjeta;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Patente;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.TarjetaDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.CategoriaProdutoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.NomeTarjetaDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.PatenteDao;
import jakarta.servlet.http.HttpSession;

@Controller
public class TarjetaController {

	@Autowired
	PatenteDao pDao;

	@Autowired
	TarjetaDao tDao;

	@Autowired
	CategoriaProdutoDao cpDao;

	@Autowired
	NomeTarjetaDao ntDao;

	@RequestMapping(name = "tarjeta", value = "/tarjeta", method = RequestMethod.GET)
	public ModelAndView tarjetaGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {

		String nivelAcesso = (String) session.getAttribute("nivelAcesso");
		String erro = "";
		String saida = "";

		List<Patente> patentes = new ArrayList<>();
		List<Tarjeta> tarjetas = new ArrayList<>();
		List<CategoriaProduto> categorias = new ArrayList<>();
		List<NomeTarjeta> nomesTarjetas = new ArrayList<>();

		Tarjeta t = null;
        NomeTarjeta nt = null;
		
		try {
			String cmd = allRequestParam.get("cmd");
			String codigo = allRequestParam.get("codigo");
			patentes = listarPatentes();
			tarjetas = listarTarjetas();
			categorias = listarCategorias();
			nomesTarjetas = listarNomesTarjetas();

			if (cmd != null) {
				if (cmd.contains("alterar")) {
					// Inicializando antes de utilizá-lo
					t = new Tarjeta();
					t.setCodigo(Integer.parseInt(codigo));
					t = buscarTarjeta(t);
					nomesTarjetas = listarNomesTarjetas();

				} else if (cmd.contains("excluir")) {
					// Inicializando antes de utilizá-lo
					t = new Tarjeta();
					t.setCodigo(Integer.parseInt(codigo));
					System.out.println("Código enviado " + codigo );
					t = buscarTarjeta(t);
					saida = excluirTarjeta(t);
					t = null;
				}
				else if (cmd.contains("excluirNomeTarjeta")) {
					// Inicializando antes de utilizá-lo
					nt = new NomeTarjeta();
					nt.setCodigo(Integer.parseInt(codigo));
					System.out.println("Código enviado" + codigo );
					nt = buscarNomeTarjeta(nt);
					saida = excluirNomeTarjeta(nt);
					t = null;
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
			model.addAttribute("tarjeta", t);
			model.addAttribute("patentes", patentes);
			model.addAttribute("tarjetas", tarjetas);
			model.addAttribute("categorias", categorias);
			model.addAttribute("nomesTarjetas", nomesTarjetas);

		}

		return new ModelAndView("tarjeta");
	}

	@RequestMapping(name = "tarjeta", value = "/tarjeta", method = RequestMethod.POST)
	public ModelAndView tarjetaPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
		// Parâmetros de entrada
		String cmd = allRequestParam.get("botao");
		String nome = allRequestParam.get("nome");
		String codigo = allRequestParam.get("codigo");
		String descricao = allRequestParam.get("descricao");
		String valorProduto = allRequestParam.get("valorProduto");
		String status = allRequestParam.get("status");
		String refEstoque = allRequestParam.get("refEstoque");
		// String quantidade = allRequestParam.get("quantidade");
		// String data = allRequestParam.get("data");
		String categoria = allRequestParam.get("categoria");
		String tamanhoTarjeta = allRequestParam.get("tamanhoTarjeta");
		String tamanhoLetra = allRequestParam.get("tamanhoLetra");
		String espacoEntreLinhas = allRequestParam.get("espacoEntreLinhas");
		String fardaColete = allRequestParam.get("fardaColete");
		String formato = allRequestParam.get("formato");
		String corBordas = allRequestParam.get("corBordas");
		String corFundo = allRequestParam.get("corFundo");
		String corLetras = allRequestParam.get("corLetras");
		String corTipoSanguineo = allRequestParam.get("corTipoSanguineo");
		String corFatorRH = allRequestParam.get("corFatorRH");
		
		String patente = allRequestParam.get("patente");
		String novoNome = allRequestParam.get("novoNome");
		String novoTipoSanguineo = allRequestParam.get("novoTipoSanguineo");
		String novoFatorRH = allRequestParam.get("novoFatorRH");
		String novoQuantidade = allRequestParam.get("novoQuantidade");
		String novoPatente = allRequestParam.get("novoPatente");
		
		// Adicionar os atributos referentes a classe

		// Parâmetros de saída
		String saida = "";
		String erro = "";

		Tarjeta t = new Tarjeta();
		Patente p = new Patente();
		NomeTarjeta nt = new NomeTarjeta();
		
		CategoriaProduto cp = new CategoriaProduto();
		List<Tarjeta> tarjetas = new ArrayList<>();
		List<Patente> patentes = new ArrayList<>();
		List<CategoriaProduto> categorias = new ArrayList<>();
		List<NomeTarjeta> nomesTarjetas = new ArrayList<>();

		try {

			patentes = listarPatentes();

			// Verifica se cmd não é nulo
			if (cmd != null && !cmd.isEmpty()) {
				if (cmd.contains("Limpar")) {
					t = null;
				} else if (!cmd.contains("Listar")) {
					t.setNome(nome);
				}

				if ("Novo".equals(cmd)) {
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
					int totalRegistros = (allRequestParam.size() - 1) / 7; // Dividir pelo número de campos por
																			// registro, menos o botão
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
				
				if (cmd.contains("Remover")) {
					nt = new NomeTarjeta();
					nt.setCodigo(Integer.parseInt(codigo));
					nt = buscarNomeTarjeta(nt);
					saida = excluirNomeTarjeta(nt);
					nt = null;
				}
				if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
					if (codigo != null && !codigo.isEmpty()) {
						t.setCodigo(Integer.parseInt(codigo));
					}

					if (categoria != null && !categoria.isEmpty()) {
						cp.setCodigo(Integer.parseInt(categoria));
						cp = buscarFornecedor(cp);
						t.setCategoria(cp);
					}
					t.setNome(nome);
					t.setDescricao(descricao);

					// Remover Mascara que vem do jsp
					valorProduto = valorProduto.replace("R$", "").replace(".", "").replace(",", ".");

					t.setValorProduto(Float.parseFloat(valorProduto));
					t.setStatus(status);
					t.setQuantidade(1);
					t.setRefEstoque(refEstoque);
					// t.setQuantidade(Integer.parseInt(quantidade));
					// t.setData(Date.valueOf(data));
					t.setTamanhoTarjeta(tamanhoTarjeta);
					t.setTamanhoLetra(tamanhoLetra);
					t.setEspacoEntreLinhas(espacoEntreLinhas);
					t.setFardaColete(fardaColete);
					t.setFormato(formato);
					t.setCorBordas(corBordas);
					t.setCorFundo(corFundo);
					t.setCorLetras(corLetras);
					t.setCorTipoSanguineo(corTipoSanguineo);
					t.setCorFatorRH(corFatorRH);

				}
				patentes = listarPatentes();
				if (cmd.contains("Cadastrar")) {
					saida = cadastrarTarjeta(t);
					t = null;
				}
				if (cmd.contains("Alterar")) {
					saida = alterarTarjeta(t);
					t = null;
				}
				if (cmd.contains("Excluir")) {
					t = new Tarjeta();
					t.setCodigo(Integer.parseInt(codigo));
					saida = excluirTarjeta(t);
					t = null;
				}
				if (cmd.contains("Buscar")) {
					// Carregar a Lista com os nomes
					nomesTarjetas = listarNomesTarjetas();
					// Buscar clientes pelo nome
					tarjetas = buscarTarjetaNome(nome);
					// Verificar o número de registros retornados
					if (tarjetas.isEmpty()) {
						// Caso não encontre nenhuma Tarjeta
						saida = "Nenhuma tarjeta encontrado com o Nome '" + nome + "'";
					} else if (tarjetas.size() == 1) {
						Tarjeta tarjeta = tarjetas.get(0);
						saida = "Tarjeta encontrado: " + tarjeta.getNome();
						t = buscarTarjeta(tarjeta);
					} else {
						// Caso encontre mais de uma emborrachado
						saida = "Foram encontrados " + tarjetas.size() + " tarjetas com o Nome '" + nome + "'";

					}
				}

				if (cmd.contains("Listar")) {
					tarjetas = listarTarjetas();
					categorias = listarCategorias();
				}
			}
		} catch (SQLException | ClassNotFoundException error) {
			erro = error.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("tarjeta", t);
			model.addAttribute("tarjetas", tarjetas);
			model.addAttribute("patentes", patentes);
			model.addAttribute("categorias", categorias);
			model.addAttribute("nomesTarjetas", nomesTarjetas);
		}

		return new ModelAndView("tarjeta");
	}

	private String cadastrarTarjeta(Tarjeta t) throws ClassNotFoundException, SQLException {
		String saida = tDao.spManterTarjeta("I", t);
		return saida;
	}

	private String alterarTarjeta(Tarjeta t) throws ClassNotFoundException, SQLException {
		String saida = tDao.spManterTarjeta("U", t);
		return saida;
	}

	private String excluirTarjeta(Tarjeta t) throws ClassNotFoundException, SQLException {
		String saida = tDao.spManterTarjeta("D", t);
		return saida;
	}

	private Tarjeta buscarTarjeta(Tarjeta t) throws ClassNotFoundException, SQLException {
		t = tDao.findBy(t);
		return t;
	}

	private List<Tarjeta> buscarTarjetaNome(String nome) throws ClassNotFoundException, SQLException {
		List<Tarjeta> tarjetas = new ArrayList<>();
		tarjetas = tDao.findByName(nome);
		return tarjetas;
	}

	private List<Tarjeta> listarTarjetas() throws ClassNotFoundException, SQLException {
		List<Tarjeta> tarjetas = new ArrayList<>();
		tarjetas = tDao.findAll();
		return tarjetas;
	}

	private List<Patente> listarPatentes() throws ClassNotFoundException, SQLException {
		List<Patente> patentes = new ArrayList<>();
		patentes = pDao.findAll();
		return patentes;
	}

	private CategoriaProduto buscarFornecedor(CategoriaProduto cp) throws SQLException, ClassNotFoundException {
		cp = cpDao.findBy(cp);
		return cp;
	}

	private List<CategoriaProduto> listarCategorias() throws ClassNotFoundException, SQLException {
		List<CategoriaProduto> categorias = new ArrayList<>();
		categorias = cpDao.findAll();
		return categorias;
	}

	private List<NomeTarjeta> listarNomesTarjetas() throws SQLException, ClassNotFoundException {
		List<NomeTarjeta> nomesTarjetas = ntDao.findAll();
		return nomesTarjetas;
	}
	
	private Patente buscarPatente(Patente p) throws SQLException, ClassNotFoundException {
		p = pDao.findBy(p);
		return p;
	}
	
	private String cadastrarNomeTarjeta(NomeTarjeta nt) throws SQLException, ClassNotFoundException {
		String saida = ntDao.spManterNomeTarjeta("I", nt);
		return saida;
	}

	private String alterarNomeTarjeta(NomeTarjeta nt) throws SQLException, ClassNotFoundException {
		String saida = ntDao.spManterNomeTarjeta("U", nt);
		return saida;
	}
	
	private NomeTarjeta buscarNomeTarjeta(NomeTarjeta nt) throws SQLException, ClassNotFoundException {
		nt = ntDao.findBy(nt);
		return nt;
	}

	private String excluirNomeTarjeta(NomeTarjeta nt) throws SQLException, ClassNotFoundException {
		String saida = ntDao.spManterNomeTarjeta("D", nt);
		return saida;
	}


}