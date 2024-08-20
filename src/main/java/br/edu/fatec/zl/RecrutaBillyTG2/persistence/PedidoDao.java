package br.edu.fatec.zl.RecrutaBillyTG2.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.ICrud;
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IPedidoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Cliente;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Pedido;

@Repository
public class PedidoDao implements ICrud<Pedido>, IPedidoDao {
    private GenericDao gDao;
	public PedidoDao(GenericDao gDao) {
		this.gDao = gDao;
	}
	
	@Override
	public String sp_iud_pedido(String acao, Pedido p) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "CALL sp_iud_pedido(?,?,?,?,?,?,?,?,?,?,?,?)";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, p.getCodigo());
		cs.setString(3, p.getNome());
		cs.setString(4, p.getDescricao());
		cs.setInt(5, p.getCliente().getCodigo());
		cs.setFloat(6, p.getValorTotal());
		cs.setString(7, p.getEstado());
		cs.setString(8, p.getTipoPagamento());
		cs.setString(9, p.getObservacao());
		cs.setString(10, p.getStatusPagamento());
		cs.setDate(11, p.getDataPagamento());
		
		cs.registerOutParameter(12, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(12);
		cs.close();
		c.close();
		return saida;
	}
	
	@Override
	public Pedido findBy(Pedido p) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM v_pedidos WHERE codigo = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, p.getCodigo());
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
		
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nomePedido"));
			p.setDescricao(rs.getString("descricao"));
			p.setEstado(rs.getString("estado"));
			p.setDescricao(rs.getString("descricao"));
			p.setValorTotal(rs.getFloat("valorTotal"));
			p.setEstado(rs.getString("estado"));
			p.setDataPedido(rs.getDate("dataPedido"));
			p.setTipoPagamento(rs.getString("tipoPagamento"));
			p.setObservacao(rs.getString("observacao"));
			p.setStatusPagamento(rs.getString("statusPagamento"));
			p.setDataPagamento(rs.getDate("dataPagamento"));
			
			Cliente cl = new Cliente();
			cl.setCodigo(rs.getInt("codigoCliente"));
			cl.setNome(rs.getString("nomeCliente"));
			cl.setCEP(rs.getString("CEP"));
			cl.setLogradouro(rs.getString("logradouro"));
			cl.setNumero(rs.getString("numero"));
			cl.setUF(rs.getString("UF"));
			cl.setLocalidade(rs.getString("localidade"));
			cl.setBairro(rs.getString("bairro"));
			cl.setComplemento(rs.getString("complemento"));
			cl.setTelefone(rs.getString("Telefone"));
			
			p.setCliente(cl);
			rs.close();
			ps.close();
			c.close();
			return p;
		} else {
			rs.close();
			ps.close();
			c.close();
			return null;
		}

	}

	@Override
	public List<Pedido> findAll() throws SQLException, ClassNotFoundException {
		List<Pedido> pedidos = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM v_pedidos";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Pedido p = new Pedido();
			
			
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nomePedido"));
			p.setDescricao(rs.getString("descricao"));
			p.setEstado(rs.getString("estado"));
			p.setDescricao(rs.getString("descricao"));
			p.setValorTotal(rs.getFloat("valorTotal"));
			p.setEstado(rs.getString("estado"));
			p.setDataPedido(rs.getDate("dataPedido"));
			p.setTipoPagamento(rs.getString("tipoPagamento"));
			p.setObservacao(rs.getString("observacao"));
			p.setStatusPagamento(rs.getString("statusPagamento"));
			p.setDataPagamento(rs.getDate("dataPagamento"));
			
			Cliente cl = new Cliente();
			
			cl.setCodigo(rs.getInt("codigoCliente"));
			cl.setNome(rs.getString("nomeCliente"));
			cl.setCEP(rs.getString("CEP"));
			cl.setLogradouro(rs.getString("logradouro"));
			cl.setNumero(rs.getString("numero"));
			cl.setUF(rs.getString("UF"));
			cl.setLocalidade(rs.getString("localidade"));
			cl.setBairro(rs.getString("bairro"));
			cl.setComplemento(rs.getString("complemento"));
			cl.setTelefone(rs.getString("Telefone"));
			
			p.setCliente(cl);
			pedidos.add(p);
		}
		rs.close();
		ps.close();
		c.close();
		return pedidos;
	}
	
	@Override
	public List<Pedido> findPedidosByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException {
		List<Pedido> pedidos = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM fn_buscar_pedido(?,?)");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setString(1, opcao);
		ps.setString(2, parametro);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {		
			Pedido p = new Pedido();
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nomePedido"));
			
			Cliente cl = new Cliente();
			cl.setCodigo(rs.getInt("codigoCliente"));
			cl.setNome(rs.getString("nomeCliente"));
			p.setCliente(cl);
			
			p.setDescricao(rs.getString("descricao"));
			p.setEstado(rs.getString("estado"));
			p.setDataPedido(rs.getDate("dataPedido"));
			p.setValorTotal(rs.getFloat("valorTotal"));
			pedidos.add(p);
		}

		rs.close();
		ps.close();
		con.close();

		return pedidos;
	}

	public String finalizar(Pedido p) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "CALL sp_finalizar_pedido(?,?,?)";
		CallableStatement cs = c.prepareCall(sql);
		cs.setInt(1, p.getCodigo());
		cs.setInt(2, p.getCliente().getCodigo());
		cs.registerOutParameter(3, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(3);
		cs.close();
		c.close();
		return saida;
	}

	@Override
	public List<Pedido> findByName(String nome) throws SQLException, ClassNotFoundException {
		List<Pedido> pedidos = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM v_pedidos WHERE nomePedido LIKE ?");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		// "%" Para fazer buscas aproximadas
		ps.setString(1, "%" + nome + "%");
		//ps.setString(1, nome);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {		
			Pedido p = new Pedido();
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nomePedido"));
			
			Cliente cl = new Cliente();
			cl.setCodigo(rs.getInt("codigoCliente"));
			cl.setNome(rs.getString("nomeCliente"));
			p.setCliente(cl);
			
			p.setDescricao(rs.getString("descricao"));
			p.setEstado(rs.getString("estado"));
			p.setDataPedido(rs.getDate("dataPedido"));
			p.setValorTotal(rs.getFloat("valorTotal"));
			pedidos.add(p);
		}

		rs.close();
		ps.close();
		con.close();

		return pedidos;
	}
	
	
}
