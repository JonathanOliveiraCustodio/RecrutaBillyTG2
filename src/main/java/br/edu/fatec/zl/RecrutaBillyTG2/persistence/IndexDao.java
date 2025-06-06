package br.edu.fatec.zl.RecrutaBillyTG2.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IIndexDao;

@Repository
public class IndexDao implements IIndexDao {
	private GenericDao gDao;

	public IndexDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public int countOrcamentos() throws SQLException, ClassNotFoundException {
		int count = 0;
		Connection c = gDao.getConnection();
		String sql = "SELECT COUNT(*) AS total FROM vw_orcamento WHERE status LIKE 'Orçamento'";
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

	@Override
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

	@Override
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
	
	@Override
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
	
	@Override
	public int countProdutosProducao() throws SQLException, ClassNotFoundException {
		int count = 0;
		Connection c = gDao.getConnection();
		String sql = "SELECT COUNT(*) AS total FROM v_produto WHERE status = 'Em Produção'";
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
	
	@Override
	public int countProdutosEstoqueBaixo(int minEstoque) throws SQLException, ClassNotFoundException {
	    int count = 0;
	    Connection c = gDao.getConnection();
	    String sql = "SELECT COUNT(*) AS total FROM v_produto WHERE quantidade < ?";
	    PreparedStatement ps = c.prepareStatement(sql);
	    ps.setInt(1, minEstoque);
	    ResultSet rs = ps.executeQuery();
	    if (rs.next()) {
	        count = rs.getInt("total");
	    }
	    rs.close();
	    ps.close();
	    c.close();
	    return count;
	}
	
	@Override
    public int countDespesasPendentes() throws SQLException, ClassNotFoundException {
        int count = 0;
        Connection c = gDao.getConnection();
        String sql = "SELECT COUNT(*) AS total FROM v_despesa WHERE estado = 'Pendente'";
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

    @Override
    public int countDespesasVencidas() throws SQLException, ClassNotFoundException {
        int count = 0;
        Connection c = gDao.getConnection();
        String sql = "SELECT COUNT(*) AS total FROM v_despesa WHERE dataVencimento < GETDATE() AND estado != 'Pago'";
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

    @Override
    public float countValorTotalDespesasMes() throws SQLException, ClassNotFoundException {
        float total = 0;
        Connection c = gDao.getConnection();
        String sql = "SELECT SUM(valor) AS total FROM v_despesa WHERE MONTH(dataInicio) = MONTH(GETDATE()) AND YEAR(dataInicio) = YEAR(GETDATE())";
        PreparedStatement ps = c.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            total = rs.getFloat("total");
        }
        rs.close();
        ps.close();
        c.close();
        return total;
    }
	
	
	
}
