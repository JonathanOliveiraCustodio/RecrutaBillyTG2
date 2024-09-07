package br.edu.fatec.zl.RecrutaBillyTG2.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

@Repository
public class IndexDao {
	private GenericDao gDao;

	public IndexDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	public int countOrcamentos() throws SQLException, ClassNotFoundException {
		int count = 0;
		Connection c = gDao.getConnection();
		String sql = "SELECT COUNT(*) AS total FROM vw_orcamento";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			count = rs.getInt("total");
		}
		rs.close();
		ps.close();
		c.close();
		return count;
	}

	public int countPedidosAndamento() throws SQLException, ClassNotFoundException {
		int count = 0;
		Connection c = gDao.getConnection();
		String sql = "SELECT COUNT(*) AS total FROM v_pedidos WHERE estado = 'Em Andamento'";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			count = rs.getInt("total");
		}
		rs.close();
		ps.close();
		c.close();
		return count;
	}

	public int countPedidosRecebidos() throws SQLException, ClassNotFoundException {
		int count = 0;
		Connection c = gDao.getConnection();
		String sql = "SELECT COUNT(*) AS total FROM v_pedidos WHERE estado = 'Recebido'";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			count = rs.getInt("total");
		}
		rs.close();
		ps.close();
		c.close();
		return count;
	}
	
	public int countPedidosDespachados() throws SQLException, ClassNotFoundException {
		int count = 0;
		Connection c = gDao.getConnection();
		String sql = "SELECT COUNT(*) AS total FROM v_pedidos WHERE estado = 'Despachado'";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			count = rs.getInt("total");
		}
		rs.close();
		ps.close();
		c.close();
		return count;
	}
}
