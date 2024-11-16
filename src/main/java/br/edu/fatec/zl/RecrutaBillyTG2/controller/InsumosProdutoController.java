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

import br.edu.fatec.zl.RecrutaBillyTG2.model.Insumo;
import br.edu.fatec.zl.RecrutaBillyTG2.model.InsumoProduto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.InsumoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ProdutoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ProdutoInsumoDao;


@Controller
public class InsumosProdutoController {
	
	@Autowired
	GenericDao gDao;

	@Autowired
	ProdutoDao pDao;
	
	@Autowired
	InsumoDao iDao;
	
	@Autowired
	ProdutoInsumoDao piDao;

	@RequestMapping(name = "insumosProduto", value = "/insumosProduto", method = RequestMethod.GET)
	public ModelAndView produtoInsumoGet(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String erro = "";
		String produto = allRequestParam.get("produto");
		
		List<InsumoProduto> insumosProduto = new ArrayList<>();
		List<Insumo> insumos = new ArrayList<>();
		
		Produto p = new Produto();
		p.setCodigo(Integer.parseInt(produto));
		
		try {
		
			insumos = listarInsumos();
			insumosProduto = listarProdutosInsumo(Integer.parseInt(produto));

		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();

		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("produto", p);
			model.addAttribute("insumosProduto", insumosProduto);	
			model.addAttribute("insumos", insumos);		
		}
		return new ModelAndView("insumosProduto");
	}

	@RequestMapping(name = "insumosProduto", value = "/insumosProduto", method = RequestMethod.POST)
	public ModelAndView produtoInsumoPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String cmd = allRequestParam.get("botao");
		String produto = allRequestParam.get("produto");		
		String insumo = allRequestParam.get("insumo");
		String quantidade = allRequestParam.get("quantidade");

		if (cmd != null && cmd.equals("Adicionar")) {

			return new ModelAndView("redirect:/insumosProduto?produto=" + produto, model); 
		}

		String saida = "";
		String erro = "";

		InsumoProduto pi = new InsumoProduto();
		Produto p = new Produto();
		Insumo i = new Insumo();
		
		List<InsumoProduto> insumosProduto = new ArrayList<>();
		List<Insumo> insumos = new ArrayList<>();

		try {
			
			insumos = listarInsumos();
			insumosProduto = listarProdutosInsumo(Integer.parseInt(produto));
			
			if (!cmd.contains("Listar")) {			
				p.setCodigo(Integer.parseInt(produto));
				p = buscarProduto(p);				
				pi.setProduto(p);
				
				i.setCodigo(Integer.parseInt(insumo));
				i = buscarInsumo(i);				
				pi.setInsumo(i);
				
			}

			if (cmd.contains("Cadastrar") || cmd.contains("Excluir")) {
				pi.setCodigoProduto(Integer.parseInt(produto));
				System.out.println("Produto " + produto);
				System.out.println("Insumo " + insumo);
				pi.setCodigoInsumo(Integer.parseInt(insumo));
				pi.setQuantidade(Integer.parseInt(quantidade));
			}

			if (cmd.contains("Cadastrar")) {
				saida = cadastrarProdutoInsumo(pi, i);
				i = null;		
			}
			if (cmd.contains("Excluir")) {
		
				saida = excluirProdutoInsumo(pi, i);
			}
			if (cmd.contains("Buscar")) {
				pi = buscarProdutoInsumo(pi);
				if (pi == null) {
					saida = "Nenhum conteudo encontrado com o código especificado.";
				}
			}

			insumos = listarInsumos();
			insumosProduto = listarProdutosInsumo(Integer.parseInt(produto));

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("insumoProduto", pi);
			model.addAttribute("insumosProduto", insumosProduto);
			model.addAttribute("produto", p);
			model.addAttribute("insumo", i);
			model.addAttribute("insumos", insumos);
		}

		return new ModelAndView("insumosProduto");

	}

	private String cadastrarProdutoInsumo(InsumoProduto pi, Insumo i) throws SQLException, ClassNotFoundException {
		String saida = piDao.iudProdutoInsumo("I", pi, i);
		return saida;

	}

	private String excluirProdutoInsumo(InsumoProduto pi, Insumo i) throws SQLException, ClassNotFoundException {	
		String saida = piDao.iudProdutoInsumo("D", pi, i);
		System.out.println(pi.getProduto().getCodigo());
		System.out.println(i.getCodigo());
		return saida;

	}

	private InsumoProduto buscarProdutoInsumo(InsumoProduto pi) throws SQLException, ClassNotFoundException {
		pi = piDao.consultar(pi);
		return pi;
	}

	private List<InsumoProduto> listarProdutosInsumo(int codigo) throws SQLException, ClassNotFoundException {
		List<InsumoProduto> insumos = piDao.listarCodigo(codigo);
		return insumos;
	}
	
	private List<Insumo> listarInsumos() throws SQLException, ClassNotFoundException {
		List<Insumo> insumos = iDao.findAll();
		return insumos;
	}

	private Insumo buscarInsumo(Insumo i) throws SQLException, ClassNotFoundException {
		i = iDao.findBy(i);
		return i;
	}
	
	private Produto buscarProduto(Produto p) throws SQLException, ClassNotFoundException {
		p = pDao.findBy(p);
		return p;
	}

}