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

import br.edu.fatec.zl.RecrutaBillyTG2.model.Fornecedor;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Insumo;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.FornecedorDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.InsumoDao;
import jakarta.servlet.http.HttpSession;

@Controller
public class InsumoController {

	@Autowired
	GenericDao gDao;

	@Autowired
	FornecedorDao fDao;

	@Autowired
	InsumoDao iDao;

	@RequestMapping(name = "insumo", value = "/insumo", method = RequestMethod.GET)
	public ModelAndView insumoGet(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) {

		String nivelAcesso = (String) session.getAttribute("nivelAcesso");
		String erro = "";
		String saida = "";

		List<Insumo> insumos = new ArrayList<>();
		List<Fornecedor> fornecedores = new ArrayList<>();
		Insumo i = null;
		try {
			String cmd = allRequestParam.get("cmd");
			String codigo = allRequestParam.get("codigo");
			fornecedores = listarFornecedores();

			if (cmd != null) {
				if (cmd.contains("alterar")) {
					// Inicializando e antes de utilizá-lo
					i = new Insumo();
					i.setCodigo(Integer.parseInt(codigo));
					i = buscarInsumo(i);

				} else if (cmd.contains("excluir")) {
					// Inicializando e antes de utilizá-lo
					i = new Insumo();
					i.setCodigo(Integer.parseInt(codigo));
					i = buscarInsumo(i);
					saida = excluirInsumo(i);
					i = null;
				}
				insumos = listarInsumos();
				fornecedores = listarFornecedores();
			}

		} catch (ClassNotFoundException | SQLException error) {
			erro = error.getMessage();
		} finally {
			if (nivelAcesso == null || !nivelAcesso.equals("admin")) {
				saida = "Você não possui acesso para visualizar esta página.";
			}
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("insumo", i);
			model.addAttribute("insumos", insumos);
			model.addAttribute("fornecedores", fornecedores);
		}

		return new ModelAndView("insumo");
	}

	@RequestMapping(name = "insumo", value = "/insumo", method = RequestMethod.POST)
	public ModelAndView insumoPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String cmd = allRequestParam.get("botao");
		String codigo = allRequestParam.get("codigo");
		String nome = allRequestParam.get("nome");
		String precoCompra = allRequestParam.get("precoCompra");
		String precoVenda = allRequestParam.get("precoVenda");
		String quantidade = allRequestParam.get("quantidade");
		String unidade = allRequestParam.get("unidade");
		String fornecedor = allRequestParam.get("fornecedor");
		String dataCompra = allRequestParam.get("dataCompra");

		String saida = "";
		String erro = "";
		Insumo i = new Insumo();
		Fornecedor f = new Fornecedor();

		List<Insumo> insumos = new ArrayList<>();
		List<Fornecedor> fornecedores = new ArrayList<>();

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			i = null;

		} else

		if (!cmd.contains("Listar")) {
			i.setNome(nome);
		}

		try {
			fornecedores = listarFornecedores();

			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {

				if (fornecedor != null && !fornecedor.isEmpty()) {
					f.setCodigo(Integer.parseInt(fornecedor));
					f = buscarFornecedor(f);
					i.setFornecedor(f);
				}
				if (codigo != null && !codigo.isEmpty()) {
					i.setCodigo(Integer.parseInt(codigo));
				}
				i.setNome(nome);
				
				 // Remover a máscara de moeda
				precoCompra = precoCompra.replace("R$", "").replace(".", "").replace(",", ".");
				precoVenda = precoVenda.replace("R$", "").replace(".", "").replace(",", ".");
				
				i.setPrecoCompra(Float.parseFloat(precoCompra));
				i.setPrecoVenda(Float.parseFloat(precoVenda));
				i.setQuantidade(Float.parseFloat(quantidade));
				i.setUnidade(unidade);
				i.setDataCompra(Date.valueOf(dataCompra));

			}
			if (cmd.contains("Cadastrar")) {
				saida = cadastrarInsumo(i);
				i = null;
			}
			if (cmd.contains("Alterar")) {
				saida = alterarInsumo(i);
				i = null;
			}
			if (cmd.contains("Excluir")) {
				i = new Insumo();
				i.setCodigo(Integer.parseInt(codigo));
				f.setCodigo(Integer.parseInt(fornecedor));
				f = buscarFornecedor(f);
				i.setFornecedor(f);
				saida = excluirInsumo(i);
				i = null;
			}
			if (cmd.contains("Buscar")) {
				// Buscar equipamentos pelo nome
				insumos = buscarInsumoNome(nome);
				// Verificar o número de registros retornados
				if (insumos.isEmpty()) {
					// Caso não encontre nenhum Insumo
					saida = "Nenhum Insumo encontrado com o Nome '" + nome + "'";
				} else if (insumos.size() == 1) {
					Insumo insumo = insumos.get(0);
					saida = "Insumo encontrado: " + insumo.getNome();
					i = buscarInsumo(insumo);
				} else {
					// Caso encontre mais de um Insumo
					saida = "Foram encontrados " + insumos.size() + " insumos com o Nome '" + nome + "'";

				}
			}
			if (cmd.contains("Listar")) {
				insumos = listarInsumos();
			}

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();

		} finally {

			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("insumo", i);
			model.addAttribute("insumos", insumos);
			model.addAttribute("fornecedores", fornecedores);

		}

		return new ModelAndView("insumo");
	}

	private String cadastrarInsumo(Insumo i) throws SQLException, ClassNotFoundException {
		String saida = iDao.sp_iud_Insumo("I", i);
		return saida;
	}

	private String alterarInsumo(Insumo i) throws SQLException, ClassNotFoundException {
		String saida = iDao.sp_iud_Insumo("U", i);
		return saida;

	}

	private String excluirInsumo(Insumo i) throws SQLException, ClassNotFoundException {
		String saida = iDao.sp_iud_Insumo("D", i);
		return saida;

	}

	private Insumo buscarInsumo(Insumo i) throws SQLException, ClassNotFoundException {
		i = iDao.findBy(i);
		return i;

	}

	private List<Insumo> listarInsumos() throws SQLException, ClassNotFoundException {
		List<Insumo> insumos = iDao.findAll();
		return insumos;
	}

	private Fornecedor buscarFornecedor(Fornecedor f) throws SQLException, ClassNotFoundException {
		f = fDao.findBy(f);
		return f;
	}

	private List<Fornecedor> listarFornecedores() throws SQLException, ClassNotFoundException {
		List<Fornecedor> fornecedores = fDao.findAll();
		return fornecedores;
	}

	private List<Insumo> buscarInsumoNome(String nome) throws ClassNotFoundException, SQLException {
		List<Insumo> insumos = new ArrayList<>();
		insumos = iDao.findByName(nome);
		return insumos;
	}

}
