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
	public String iudPedido(String acao, Pedido p) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "CALL sp_iud_pedido(?,?,?,?,?,?,?)";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, p.getCodigo());
		cs.setString(3, p.getNome());
		cs.setString(4, p.getDescricao());
		cs.setInt(5, p.getCliente().getCodigo());
		cs.setString(6, p.getEstado());
		cs.registerOutParameter(7, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(7);
		cs.close();
		c.close();
		return saida;
	}
	
	@Override
	public Pedido consultar(Pedido p) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM v_pedidos WHERE codigo_pedido = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, p.getCodigo());
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			p.setCodigo(rs.getInt("codigo_pedido"));
			p.setNome(rs.getString("nome_pedido"));
			p.setEstado(rs.getString("estado"));
			p.setDescricao(rs.getString("descricao"));
			Cliente cl = new Cliente();
			cl.setCodigo(rs.getInt("cliente_pedido"));
			cl.setNome(rs.getString("cliente_nome"));
			
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
	public List<Pedido> listar() throws SQLException, ClassNotFoundException {
		List<Pedido> pedidos = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM v_pedidos";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Pedido p = new Pedido();
			p.setCodigo(rs.getInt("codigo_pedido"));
			p.setNome(rs.getString("nome_pedido"));
			Cliente cl = new Cliente();
			cl.setCodigo(rs.getInt("cliente_pedido"));
			cl.setNome(rs.getString("cliente_nome"));
			p.setCliente(cl);
			p.setDescricao(rs.getString("descricao"));
			p.setEstado(rs.getString("estado"));
			p.setDataPedido(rs.getDate("dataPedido"));
			p.setValorTotal(rs.getFloat("valorTotal"));
			pedidos.add(p);
		}
		rs.close();
		ps.close();
		c.close();
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
}