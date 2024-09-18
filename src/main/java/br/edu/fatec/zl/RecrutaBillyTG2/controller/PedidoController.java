package br.edu.fatec.zl.RecrutaBillyTG2.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.ResourceUtils;
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
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;

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
			// p = null;
			clientes = cDao.findAll();

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
		String valorTotal = allRequestParam.get("valorTotal");
		String formaPagamento = allRequestParam.get("tipoPagamento");
		String observacao = allRequestParam.get("observacao");
		String statusPagamento = allRequestParam.get("statusPagamento");
		String dataPagamento = allRequestParam.get("dataPagamento");

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
			if (codigo != null && !codigo.isEmpty()) {
				p.setNome(nome);
			}

		}
		try {
			clientes = cDao.findAll();
			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
				if (codigo != null && !codigo.isEmpty()) {
					p.setCodigo(Integer.parseInt(codigo));
				}
				p.setNome(nome);
				p.setDescricao(descricao);
				c.setCodigo(Integer.parseInt(cliente));
				c = cDao.findBy(c);
				p.setCliente(c);

				// Remover a máscara de moeda
				valorTotal = valorTotal.replace("R$", "").replace(".", "").replace(",", ".");
				p.setValorTotal(Float.parseFloat(valorTotal));
				p.setEstado(estado);
				p.setTipoPagamento(formaPagamento);
				p.setObservacao(observacao);
				p.setStatusPagamento(statusPagamento);

				// A Data do Pagamento pode ser vazia
				if (dataPagamento != null && !dataPagamento.isEmpty()) {
					p.setDataPagamento(Date.valueOf(dataPagamento));
				} else {
					p.setDataPagamento(null);
				}

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
				// Buscar clientes pelo nome
				pedidos = buscarPedidoNome(nome);
				// Verificar o número de registros retornados
				if (pedidos.isEmpty()) {
					// Caso não encontre nenhum cliente
					saida = "Nenhum Pedido encontrado com o Nome '" + nome + "'";
				} else if (pedidos.size() == 1) {
					Pedido pedido = pedidos.get(0);
					saida = "Pedido encontrado: " + pedido.getNome();
					p = buscarPedido(pedido);
				} else {
					// Caso encontre mais de um pedido
					saida = "Foram encontrados " + pedidos.size() + " pedidos com o Nome '" + nome + "'";

				}
			}
			if (cmd.contains("Listar")) {
				pedidos = listarPedidos();
			}
			if (cmd.contains("Finalizar")) {
				p.setCodigo(Integer.parseInt(codigo));
				c.setCodigo(Integer.parseInt(cliente));
				c = cDao.findBy(c);
				p.setCliente(c);
				saida = finalizarPedido(p);
				p = null;
			}
			if (cmd.contains("Adicionar")) {
				p = buscarPedido(p);
				if (p == null) {
					saida = "Nenhum Pedido encontrado com o codigo especificado.";
					p = null;
				} else {
					model.addAttribute("pedido", p);
					return new ModelAndView("forward:/produtosPedido", model);
				}
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

	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(name = "etiqueta", value = "/etiqueta", method = RequestMethod.POST)
	public ResponseEntity EtiquetaPost(@RequestParam Map<String, String> allRequestParam) {

		String erro = "";

		Map<String, Object> paramRelatorio = new HashMap<String, Object>();
		paramRelatorio.put("cliente", allRequestParam.get("cliente"));
		paramRelatorio.put("pedido", allRequestParam.get("pedido"));
		paramRelatorio.put(JRParameter.REPORT_CLASS_LOADER, this.getClass().getClassLoader());

		byte[] bytes = null;

		InputStreamResource resource = null;
		HttpStatus status = null;
		HttpHeaders header = new HttpHeaders();

		String reportPath = "";

		reportPath = "classpath:reports/Etiqueta1.jasper";

		try {

			Connection c = gDao.getConnection();
			File arquivo = ResourceUtils.getFile(reportPath);
			JasperReport report = (JasperReport) JRLoader.loadObjectFromFile(arquivo.getAbsolutePath());
			bytes = JasperRunManager.runReportToPdf(report, paramRelatorio, c);
		} catch (ClassNotFoundException | SQLException | FileNotFoundException | JRException e) {
			e.printStackTrace();
			erro = e.getMessage();
			status = HttpStatus.BAD_REQUEST;
		} finally {
			if (erro.equals("")) {
				InputStream inputStream = new ByteArrayInputStream(bytes);
				resource = new InputStreamResource(inputStream);
				header.setContentLength(bytes.length);
				header.setContentType(MediaType.APPLICATION_PDF);
				status = HttpStatus.OK;
			}
		}
		return new ResponseEntity<>(resource, header, status);
	}

	private String finalizarPedido(Pedido p) throws ClassNotFoundException, SQLException {
		String saida = pDao.sp_finalizar_pedido(p);
		return saida;
	}

	private String cadastrarPedido(Pedido p) throws ClassNotFoundException, SQLException {
		String saida = pDao.sp_iud_pedido("I", p);
		return saida;
	}

	private String alterarPedido(Pedido p) throws ClassNotFoundException, SQLException {
		String saida = pDao.sp_iud_pedido("U", p);
		return saida;
	}

	private String excluirPedido(Pedido p) throws ClassNotFoundException, SQLException {
		String saida = pDao.sp_iud_pedido("D", p);
		return saida;
	}

	private Pedido buscarPedido(Pedido p) throws ClassNotFoundException, SQLException {
		p = pDao.findBy(p);
		return p;
	}

	private List<Pedido> listarPedidos() throws ClassNotFoundException, SQLException {
		List<Pedido> pedidos = new ArrayList<>();
		pedidos = pDao.findAll();
		return pedidos;
	}

	private List<Pedido> buscarPedidoNome(String nome) throws ClassNotFoundException, SQLException {
		List<Pedido> pedidos = new ArrayList<>();
		pedidos = pDao.findByName(nome);
		return pedidos;
	}

//	private List<Pedido> buscarEtiqueta(int cliente, int pedido) throws ClassNotFoundException, SQLException {
//		List<Pedido> pedidos = new ArrayList<>();
//		pedidos = pDao.findEtiqueta(cliente, pedido);
//		return pedidos;
//	}

}
