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
import br.edu.fatec.zl.RecrutaBillyTG2.model.Cliente;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Pedido;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.ClienteDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.PedidoDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PedidoController {

	@Autowired
	GenericDao gDao;

	@Autowired
	PedidoDao pDao;

	@Autowired
	ClienteDao cDao;

	@RequestMapping(name = "pedido", value = "/pedido", method = RequestMethod.GET)
	public ModelAndView pedidoGet(@RequestParam Map<String, String> allRequestParam, HttpServletRequest request,
			ModelMap model) {
		HttpSession session = request.getSession();
		session.removeAttribute("pedido");
		String cmd = allRequestParam.get("cmd");
		
		String codigo = allRequestParam.get("codigo");

		String saida = "";
		String erro = "";
		Pedido p = new Pedido();
		Cliente c = new Cliente();
		List<Cliente> clientes = new ArrayList<>();
		List<Pedido> pedidos = new ArrayList<>();
		try {
			//p = null;
			clientes = cDao.listar();

			if (cmd != null) {
				p.setCodigo(Integer.parseInt(codigo));
				if (cmd.contains("alterar")) {
					p = buscarPedido(p);
				} else {
					if (cmd.contains("excluir")) {
						p = buscarPedido(p);
						saida = excluirPedido(p);
						p = null;
					} else {
						if (cmd.contains("Listar")) {
							pedidos = listarPedidos();
						}
					}
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("pedido", p);
			model.addAttribute("pedidos", pedidos);
			model.addAttribute("clientes", clientes);
			model.addAttribute("cliente", c);
		}
		return new ModelAndView("pedido");
	}

	@RequestMapping(name = "pedido", value = "/pedido", method = RequestMethod.POST)
	public ModelAndView pedidoPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
		// Parâmetros de entrada
		String cmd = allRequestParam.get("botao");
		String codigo = allRequestParam.get("codigo");
		String nome = allRequestParam.get("nome");
		String cliente = allRequestParam.get("cliente");
		String estado = allRequestParam.get("estado");
		String descricao = allRequestParam.get("descricao");

		// Parâmetros de saida
		String saida = "";
		String erro = "";
		Pedido p = new Pedido();
		Cliente c = new Cliente();
		List<Pedido> pedidos = new ArrayList<>();
		List<Cliente> clientes = new ArrayList<>();

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			p = null;

		} else if (!cmd.contains("Listar")) {
			p.setCodigo(Integer.parseInt(codigo));
		}
		try {
			clientes = cDao.listar();
			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
				c.setCodigo(Integer.parseInt(cliente));
				c = cDao.consultar(c);
				p.setCliente(c);
				p.setCodigo(Integer.parseInt(codigo));
				p.setNome(nome);
				p.setEstado(estado);
				p.setDescricao(descricao);
			}

			if (cmd.contains("Cadastrar")) {
				saida = cadastrarPedido(p);
				p = null;
			}
			if (cmd.contains("Alterar")) {
				saida = alterarPedido(p);
				p = null;
			}
			if (cmd.contains("Excluir")) {
				saida = excluirPedido(p);
				p = null;
			}
			if (cmd.contains("Buscar")) {
				p = buscarPedido(p);
				if (p == null) {
					saida = "Nenhum Pedido encontrado com o código " + codigo ;
				}
			}
			if (cmd.contains("Listar")) {
				pedidos = listarPedidos();
			}
			if (cmd.contains("Finalizar Pedido")) {
				c.setCodigo(Integer.parseInt(cliente));
				c = cDao.consultar(c);
				p.setCliente(c);
				saida = finalizarPedido(p);
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("pedido", p);
			model.addAttribute("pedidos", pedidos);
			model.addAttribute("cliente", c);
			model.addAttribute("clientes", clientes);
		}
		return new ModelAndView("pedido");
	}

	private String finalizarPedido(Pedido p) throws ClassNotFoundException, SQLException {
		String saida = pDao.finalizar(p);
		return saida;
	}

	private String cadastrarPedido(Pedido p) throws ClassNotFoundException, SQLException {
		String saida = pDao.iudPedido("I", p);
		return saida;
	}

	private String alterarPedido(Pedido p) throws ClassNotFoundException, SQLException {
		String saida = pDao.iudPedido("U", p);
		return saida;
	}

	private String excluirPedido(Pedido p) throws ClassNotFoundException, SQLException {
		String saida = pDao.iudPedido("D", p);
		return saida;
	}

	private Pedido buscarPedido(Pedido p) throws ClassNotFoundException, SQLException {
		p = pDao.consultar(p);
		return p;
	}

	private List<Pedido> listarPedidos() throws ClassNotFoundException, SQLException {
		List<Pedido> pedidos = new ArrayList<>();
		pedidos = pDao.listar();
		return pedidos;

	}
}
