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
import br.edu.fatec.zl.RecrutaBillyTG2.model.Endereco;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Funcionario;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.EnderecoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;


@Controller
public class EnderecoClienteController {

	@Autowired
	GenericDao gDao;

	@Autowired
	EnderecoDao eDao;

	@RequestMapping(name = "endereco", value = "/endereco", method = RequestMethod.GET)
	public ModelAndView enderecoGet(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String erro = "";
		String funcionario = allRequestParam.get("funcionario");
		List<Endereco> enderecos = new ArrayList<>();

		Funcionario f = new Funcionario();
		f.setCPF(funcionario);
		try {
			enderecos = listarEnderecos(funcionario);

		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();

		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("funcionario", f);
			model.addAttribute("enderecos", enderecos);

		}
		return new ModelAndView("endereco");
	}

	@RequestMapping(name = "endereco", value = "/endereco", method = RequestMethod.POST)
	public ModelAndView enderecoPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String cmd = allRequestParam.get("botao");
		String funcionario = allRequestParam.get("funcionario");
		String codigo = allRequestParam.get("codigo");
		String CEP = allRequestParam.get("CEP");
		String logradouro = allRequestParam.get("logradouro");
		String bairro = allRequestParam.get("bairro");
		String localidade = allRequestParam.get("localidade");
		String UF = allRequestParam.get("UF");
		String complemento = allRequestParam.get("complemento");
		String numero = allRequestParam.get("numero");
		String tipoEndereco = allRequestParam.get("tipoEndereco");


		if (cmd != null && cmd.equals("Endereço")) {

			return new ModelAndView("redirect:/endereco?funcionario=" + funcionario, model);
		}

		String saida = "";
		String erro = "";

//		InsumoProduto pi = new InsumoProduto();
//		Produto p = new Produto();
//		Insumo i = new Insumo();
//		
//		List<InsumoProduto> insumosProduto = new ArrayList<>();
//		List<Insumo> insumos = new ArrayList<>();
//
//		try {
//			
//			insumos = listarInsumos();
//			insumosProduto = listarProdutosInsumo(Integer.parseInt(produto));
//			
//			if (!cmd.contains("Listar")) {			
//				p.setCodigo(Integer.parseInt(produto));
//				p = buscarProduto(p);				
//				pi.setProduto(p);
//				
//				i.setCodigo(Integer.parseInt(insumo));
//				i = buscarInsumo(i);				
//				pi.setInsumo(i);
//				
//			}
//
//			if (cmd.contains("Cadastrar") || cmd.contains("Excluir")) {
//				pi.setCodigoProduto(Integer.parseInt(produto));
//				System.out.println("Produto " + produto);
//				System.out.println("Insumo " + insumo);
//				pi.setCodigoInsumo(Integer.parseInt(insumo));
//				pi.setQuantidade(Integer.parseInt(quantidade));
//			}
//
//			if (cmd.contains("Cadastrar")) {
//				saida = cadastrarProdutoInsumo(pi, i);
//				i = null;		
//			}
//			if (cmd.contains("Excluir")) {
//		
//				saida = excluirProdutoInsumo(pi, i);
//			}
//			if (cmd.contains("Buscar")) {
//				pi = buscarProdutoInsumo(pi);
//				if (pi == null) {
//					saida = "Nenhum conteudo encontrado com o código especificado.";
//				}
//			}
//
//			insumos = listarInsumos();
//			insumosProduto = listarProdutosInsumo(Integer.parseInt(produto));
//
//		} catch (SQLException | ClassNotFoundException e) {
//			erro = e.getMessage();
//		} finally {
//			model.addAttribute("saida", saida);
//			model.addAttribute("erro", erro);
//			model.addAttribute("insumoProduto", pi);
//			model.addAttribute("insumosProduto", insumosProduto);
//			model.addAttribute("produto", p);
//			model.addAttribute("insumo", i);
//			model.addAttribute("insumos", insumos);
//		}

		return new ModelAndView("endereco");

	}

//	private String cadastrarProdutoInsumo(InsumoProduto pi, Insumo i) throws SQLException, ClassNotFoundException {
//		String saida = piDao.iudProdutoInsumo("I", pi, i);
//		return saida;
//
//	}
//
//
//	private String excluirProdutoInsumo(InsumoProduto pi, Insumo i) throws SQLException, ClassNotFoundException {	
//		String saida = piDao.iudProdutoInsumo("D", pi, i);
//		System.out.println(pi.getProduto().getCodigo());
//		System.out.println(i.getCodigo());
//		return saida;
//
//	}
//
//	private InsumoProduto buscarProdutoInsumo(InsumoProduto pi) throws SQLException, ClassNotFoundException {
//		pi = piDao.consultar(pi);
//		return pi;
//	}

	private List<Endereco> listarEnderecos(String CPF) throws SQLException, ClassNotFoundException {
		List<Endereco> enderecos = eDao.findAll(CPF);
		return enderecos;
	}

//	private Insumo buscarInsumo(Insumo i) throws SQLException, ClassNotFoundException {
//		i = iDao.findBy(i);
//		return i;
//	}
//	
	private Endereco buscarEndereco(Endereco e) throws SQLException, ClassNotFoundException {
		e = eDao.findBy(e);
		return e;
	}

}