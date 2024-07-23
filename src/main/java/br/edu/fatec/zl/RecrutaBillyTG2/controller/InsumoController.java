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

import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.InsumoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Fornecedor;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Insumo;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.FornecedorDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
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
		String valor = allRequestParam.get("valor");
		String quantidade = allRequestParam.get("quantidade");
		String unidade = allRequestParam.get("unidade");
		String fornecedor = allRequestParam.get("fornecedor");

		String saida = "";
		String erro = "";
		Insumo i = new Insumo();

		List<Insumo> insumos = new ArrayList<>();
		List<Fornecedor> fornecedores = new ArrayList<>();

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			i = null;

		} else

		if (!cmd.contains("Listar")) {
			i.setCodigo(Integer.parseInt(codigo));
		}

		try {

			fornecedores = listarFornecedores();

			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
				i.setNome(nome);
				i.setValor(Float.parseFloat(valor));
				i.setQuantidade(Integer.parseInt(quantidade));
				i.setUnidade(unidade);
				Fornecedor f = new Fornecedor();
				f.setCodigo(Integer.parseInt(fornecedor));
				f = buscarFornecedor(f);
				i.setFornecedor(f);

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
				// Buscar um Insumo antes de Excluir para realizar a Validação
				Insumo ins = buscarInsumo(i);
				if (ins != null) {
					saida = excluirInsumo(i);
					i = null;
				} else {
					saida = "Nenhum Insumo encontrado com o código " + codigo;
				}
			}
			if (cmd.contains("Buscar")) {
				i = buscarInsumo(i);
				if (i == null) {
					saida = "Nenhum Insumo encontrado com o código " + codigo;
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
		String saida = iDao.iudInsumo("I", i);
		return saida;
	}

	private String alterarInsumo(Insumo i) throws SQLException, ClassNotFoundException {
		String saida = iDao.iudInsumo("U", i);
		return saida;

	}

	private String excluirInsumo(Insumo i) throws SQLException, ClassNotFoundException {
		String saida = iDao.iudInsumo("D", i);
		return saida;

	}

	private Insumo buscarInsumo(Insumo i) throws SQLException, ClassNotFoundException {
		i = iDao.consultar(i);
		return i;

	}

	private List<Insumo> listarInsumos() throws SQLException, ClassNotFoundException {
		List<Insumo> insumos = iDao.listar();
		return insumos;
	}

	private Fornecedor buscarFornecedor(Fornecedor f) throws SQLException, ClassNotFoundException {
		f = fDao.consultar(f);
		return f;

	}

	private List<Fornecedor> listarFornecedores() throws SQLException, ClassNotFoundException {
		List<Fornecedor> fornecedores = fDao.listar();
		return fornecedores;
	}

}