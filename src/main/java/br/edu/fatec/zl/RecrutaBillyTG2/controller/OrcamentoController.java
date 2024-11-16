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
import br.edu.fatec.zl.RecrutaBillyTG2.model.Cliente;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Orcamento;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ClienteDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.OrcamentoDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class OrcamentoController {

	@Autowired
	GenericDao gDao;

	@Autowired
	OrcamentoDao oDao;

	@Autowired
	ClienteDao cDao;

	@RequestMapping(name = "orcamento", value = "/orcamento", method = RequestMethod.GET)
    public ModelAndView orcamentoGet(@RequestParam Map<String, String> allRequestParam, HttpServletRequest request,
            ModelMap model) {
        HttpSession session = request.getSession();
        session.removeAttribute("orcamento");
        String cmd = allRequestParam.get("cmd");
        String codigo = allRequestParam.get("codigo");

        String saida = "";
        String erro = "";
        Orcamento o = new Orcamento();
        Cliente c = new Cliente();
        List<Cliente> clientes = new ArrayList<>();
        List<Orcamento> orcamentos = new ArrayList<>();
	    try {
	        clientes = cDao.findAll();
	        
	        // Verifica se um código foi fornecido e busca o pedido correspondente
	        if (codigo != null) {
	            o.setCodigo(Integer.parseInt(codigo));
	            o = buscarOrcamento(o);
	        }

	        // Comando para alterar, excluir ou listar pedidos
	        if (cmd != null) {
	            if (cmd.contains("alterar")) {
	                o = buscarOrcamento(o);
	            } else if (cmd.contains("excluir")) {
	                o = buscarOrcamento(o);
	                saida = excluirOrcamento(o);
	                o = null;
	            } else if (cmd.contains("Listar")) {
	                orcamentos = listarOrcamentos();
	            }
	        }
        } catch (SQLException | ClassNotFoundException e) {
            erro = e.getMessage();
        } finally {
            model.addAttribute("saida", saida);
            model.addAttribute("erro", erro);
            model.addAttribute("orcamento", o);
            model.addAttribute("orcamentos", orcamentos);
            model.addAttribute("clientes", clientes);
            model.addAttribute("cliente", c);
        }
        return new ModelAndView("orcamento");
    }

	@RequestMapping(name = "orcamento", value = "/orcamento", method = RequestMethod.POST)
	public ModelAndView orcamentoPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
		// Parâmetros de entrada
		String cmd = allRequestParam.get("botao");
		String codigo = allRequestParam.get("codigo");
		String nome = allRequestParam.get("nome");
		String cliente = allRequestParam.get("cliente");
		String status = allRequestParam.get("status");
		String descricao = allRequestParam.get("descricao");
		String valorTotal = allRequestParam.get("valorTotal");
		String formaPagamento = allRequestParam.get("formaPagamento");
		String observacao = allRequestParam.get("observacao");
		String dataOrcamento = allRequestParam.get("dataOrcamento");
		
		// Parâmetros de saida
		String saida = "";
		String erro = "";
		Orcamento o = new Orcamento();
		Cliente c = new Cliente();
		List<Orcamento> orcamentos = new ArrayList<>();
		List<Cliente> clientes = new ArrayList<>();

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			o = null;

		} else if (!cmd.contains("Listar")) {
			o.setNome(nome);
		}
		try {
			clientes = cDao.findAll();

			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
				if (cliente != null && !cliente.isEmpty()) {
					c.setCodigo(Integer.parseInt(cliente));
					c = cDao.findBy(c);
					o.setCliente(c);
				}
				if (codigo != null && !codigo.isEmpty()) {
					o.setCodigo(Integer.parseInt(codigo));
				}
				o.setNome(nome);
				o.setStatus(status);
				o.setDescricao(descricao);
				o.setObservacao(observacao);
				
				// Remover a máscara de moeda
				valorTotal = valorTotal.replace("R$", "").replace(".", "").replace(",", ".");

				o.setValorTotal(Float.parseFloat(valorTotal));
				
				o.setFormaPagamento(formaPagamento);
				
				// A Data do Pagamento pode ser vazia
				if (dataOrcamento != null && !dataOrcamento.isEmpty()) {
					o.setDataOrcamento(Date.valueOf(dataOrcamento));
				} else {
					o.setDataOrcamento(null);
				}
				
			}

			if (cmd.contains("Cadastrar")) {
				saida = cadastrarOrcamento(o);
				o = null;
			}
			if (cmd.contains("Alterar")) {
				saida = alterarOrcamento(o);
				o = null;
			}
			if (cmd.contains("Excluir")) {
				saida = excluirOrcamento(o);
				o = null;
			}
			if (cmd.contains("Buscar")) {
				// Buscar orçamentos pelo nome
				orcamentos = buscarOrcamentoNome(nome);
				// Verificar o número de registros retornados
				if (orcamentos.isEmpty()) {
					// Caso não encontre nenhum orçamento
					saida = "Nenhum Orçamento encontrado com o Nome '" + nome + "'";
				} else if (orcamentos.size() == 1) {
					Orcamento orcamento = orcamentos.get(0);
					saida = "Orçamento encontrado: " + orcamento.getNome();
					o = buscarOrcamento(orcamento);
				} else {
					// Caso encontre mais de um orçamento
					saida = "Foram encontrados " + orcamentos.size() + " pedidos com o Nome '" + nome + "'";

				}
			}

			if (cmd.contains("Listar")) {
				orcamentos = listarOrcamentos();
			}
			if (cmd.contains("Efetivar Pedido")) {
				if (codigo != null && !codigo.isEmpty()) {
					o.setCodigo(Integer.parseInt(codigo));
					// c = oDao.findBy(o);
					// o.setCliente(c);
					saida = efetivarPedido(o);
					o = null;
				}
			}
			if (cmd.contains("Adicionar")) {
				o = buscarOrcamento(o);
				if (o == null) {
					saida = "Nenhum Orçamento encontrado com o codigo especificado.";
					o = null;
				} else {
					model.addAttribute("orcamento", o);
					return new ModelAndView("forward:/produtosOrcamento", model);
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("orcamento", o);
			model.addAttribute("orcamentos", orcamentos);
			model.addAttribute("cliente", c);
			model.addAttribute("clientes", clientes);
		}
		return new ModelAndView("orcamento");
	}

	private String efetivarPedido(Orcamento o) throws ClassNotFoundException, SQLException {
		String saida = oDao.sp_orcamento_pedido(o);
		return saida;
	}

	private String cadastrarOrcamento(Orcamento o) throws ClassNotFoundException, SQLException {
		String saida = oDao.sp_iud_orcamento("I", o);
		return saida;
	}

	private String alterarOrcamento(Orcamento o) throws ClassNotFoundException, SQLException {
		String saida = oDao.sp_iud_orcamento("U", o);
		return saida;
	}

	private String excluirOrcamento(Orcamento o) throws ClassNotFoundException, SQLException {
		String saida = oDao.sp_iud_orcamento("D", o);
		return saida;
	}

	private Orcamento buscarOrcamento(Orcamento o) throws ClassNotFoundException, SQLException {
		o = oDao.findBy(o);
		return o;
	}

	private List<Orcamento> buscarOrcamentoNome(String nome) throws ClassNotFoundException, SQLException {
		List<Orcamento> orcamentos = new ArrayList<>();
		orcamentos = oDao.findByName(nome);
		return orcamentos;
	}

	private List<Orcamento> listarOrcamentos() throws ClassNotFoundException, SQLException {
		List<Orcamento> orcamentos = new ArrayList<>();
		orcamentos = oDao.findAll();
		return orcamentos;

	}
}
