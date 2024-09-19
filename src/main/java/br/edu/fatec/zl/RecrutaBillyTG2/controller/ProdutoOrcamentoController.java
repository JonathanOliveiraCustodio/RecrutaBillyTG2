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

import br.edu.fatec.zl.RecrutaBillyTG2.model.CategoriaProduto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Orcamento;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.ProdutoOrcamento;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.CategoriaProdutoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.OrcamentoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ProdutoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ProdutoOrcamentoDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ProdutoOrcamentoController {
	
	@Autowired
	OrcamentoDao oDao;
	
	@Autowired
	ProdutoDao pDao;
	
	@Autowired
	CategoriaProdutoDao cDao;
	
	@Autowired
	ProdutoOrcamentoDao poDao;
	
	@RequestMapping(name = "produtosOrcamento", value = "/produtosOrcamento", method = RequestMethod.GET)
	public ModelAndView produtoOrcamentoGet(@RequestParam Map<String, String> allRequestParam, HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();
		
		String orcamento = allRequestParam.get("orcamento");
		if(orcamento == null) {
			orcamento = (String) session.getAttribute("orcamento");
		}else {
			session.setAttribute("orcamento", orcamento);
		}
		String erro = "";
		List<Produto> produtos = new ArrayList<>();
		List<ProdutoOrcamento> produtosOrcamento = new ArrayList<>();
		List<CategoriaProduto> categoriaProduto = new ArrayList<>();
		Orcamento o = new Orcamento();
		
		try {
			o.setCodigo(Integer.parseInt(orcamento));
			o = buscarOrcamento(o);
			produtosOrcamento = listarProdutos(o);
			categoriaProduto = listarCategorias();
		}catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			model.addAttribute("erro", erro);
			model.addAttribute("produtos", produtos);
			model.addAttribute("produtosOrcamento", produtosOrcamento);
			model.addAttribute("categorias", categoriaProduto);
		}
		return new ModelAndView("produtosOrcamento");
	}

	@RequestMapping(name = "produtosOrcamento", value = "/produtosOrcamento", method = RequestMethod.POST)
	public ModelAndView produtoOrcamentoPost(@RequestParam Map<String, String> allRequestParam, HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();
		String cmd = allRequestParam.get("botao");
		String codigoOrc = (String) session.getAttribute("orcamento");
		String codigoProduto = allRequestParam.get("produto");
		String quantidade = allRequestParam.get("quantidade");
		String categoria = allRequestParam.get("categoria");
		
		CategoriaProduto c = new CategoriaProduto();
		Orcamento o = new Orcamento();
		Produto p = new Produto();
		ProdutoOrcamento po = new ProdutoOrcamento();
		
		List<ProdutoOrcamento> produtosOrcamento = new ArrayList<>();
		List<Produto> produtos = new ArrayList<>();
		List<CategoriaProduto> categorias = new ArrayList<>();
		String saida = "";
		String erro = "";
		
		try {
			o.setCodigo(Integer.parseInt(codigoOrc));
			o = buscarOrcamento(o);
			produtosOrcamento = listarProdutos(o);
			categorias = listarCategorias();
			c.setNome(categoria);
			produtos = listarProdutosCategoria(categoria);
			
			p.setCodigo(Integer.parseInt(codigoProduto));
			p = buscarProduto(p);
			po.setProduto(p);
			
			if(cmd != null) {
				produtosOrcamento = listarProdutos(o);
				produtos = listarProdutosCategoria(categoria);
				o.setCodigo(Integer.parseInt(codigoOrc));
				
				if(!cmd.contains("Listar")) {
					p.setCodigo(Integer.parseInt(codigoProduto));
					p = buscarProduto(p);
					po.setProduto(p);
					po.setCodigoOrcamento(Integer.parseInt(codigoOrc));
					po.setCodigoProduto(Integer.parseInt(codigoProduto));
				}
				if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
					po.setCodigoOrcamento(Integer.parseInt(codigoOrc));
					po.setQuantidade(Integer.parseInt(quantidade));
				}
				if (cmd.contains("Cadastrar")) {
					saida = adicionarProduto(po);
				}
				if (cmd.contains("Excluir")) {
					saida = excluirProduto(po);
				}
				if (cmd.contains("Listar")) {
					produtosOrcamento = listarProdutos(o);
				}
			}
			produtosOrcamento = listarProdutos(o);
		}catch (SQLException | ClassNotFoundException e){
			erro = e.getMessage();
		}finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("produtosOrcamento", produtosOrcamento);
			model.addAttribute("produtos", produtos);
			model.addAttribute("categorias", categorias);
			model.addAttribute("produto", p);
			model.addAttribute("orcamento", o);
			model.addAttribute("categoriaProduto", c);
		}
		
		
		return new ModelAndView("produtosOrcamento");
	}

	private String adicionarProduto(ProdutoOrcamento po) throws ClassNotFoundException, SQLException {
		return poDao.iudProdutoOrcamento("I", po);
	}

	private String excluirProduto(ProdutoOrcamento po) throws ClassNotFoundException, SQLException {
		return poDao.iudProdutoOrcamento("D", po);
	}

	private Produto buscarProduto(Produto p) throws ClassNotFoundException, SQLException {
		return pDao.findBy(p);
	}

	private Orcamento buscarOrcamento(Orcamento o) throws ClassNotFoundException, SQLException {
		return oDao.findBy(o);
	}
	
	private List<ProdutoOrcamento> listarProdutos(Orcamento o) throws ClassNotFoundException, SQLException {
		return poDao.findAll(o);
	}
	
	private List<CategoriaProduto> listarCategorias() throws ClassNotFoundException, SQLException {
		return cDao.findAll();
	}
	
	private List<Produto> listarProdutosCategoria(String categoria) throws ClassNotFoundException, SQLException {
		return pDao.findCategoria(categoria);
	}

}
 