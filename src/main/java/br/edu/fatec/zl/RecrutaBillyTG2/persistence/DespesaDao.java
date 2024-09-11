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
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IDespesaDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Despesa;

@Repository
public class DespesaDao implements ICrud<Despesa>, IDespesaDao{
	private GenericDao gDao;
	
	public DespesaDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public String iudDespesa(String acao, Despesa d) throws SQLException, ClassNotFoundException {
		String sql = "CALL sp_iud_despesa(?,?,?,?,?,?,?,?,?,?)";
		Connection c = gDao.getConnection();
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, d.getCodigo());
		cs.setString(3, d.getNome());
		cs.setDate(4, d.getData());
		cs.setDate(5, d.getDataVencimento());
		cs.setFloat(6, d.getValor());
		cs.setString(7, d.getTipo());
		cs.setString(8, d.getPagamento());
		cs.setString(9, d.getEstado());
		cs.registerOutParameter(10, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(10);
		
		cs.close();
		c.close();
		return saida; 
	}
	
	@Override
	public Despesa findBy(Despesa d) throws SQLException, ClassNotFoundException {
		String sql = "SELECT * FROM despesa WHERE codigo = ?";
		Connection c = gDao.getConnection();
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, d.getCodigo());
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			d.setCodigo(rs.getInt("codigo"));
			d.setNome(rs.getString("nome"));
			d.setData(rs.getDate("dataInicio"));
			d.setDataVencimento(rs.getDate("dataVencimento"));
			d.setValor(rs.getFloat("valor"));
			d.setTipo(rs.getString("tipo"));
			d.setPagamento(rs.getString("pagamento"));
			d.setEstado(rs.getString("estado"));
		}
		rs.close();
		ps.close();
		c.close();
		return d;
	}

	@Override
	public List<Despesa> findAll() throws SQLException, ClassNotFoundException {
		List<Despesa> despesas = new ArrayList<>();
		String sql = "SELECT * FROM despesa";
		Connection c = gDao.getConnection();
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Despesa d = new Despesa();
			d.setCodigo(rs.getInt("codigo"));
			d.setNome(rs.getString("nome"));
			d.setData(rs.getDate("dataInicio"));
			d.setDataVencimento(rs.getDate("dataVencimento"));
			d.setValor(rs.getFloat("valor"));
			d.setTipo(rs.getString("tipo"));
			d.setPagamento(rs.getString("pagamento"));
			d.setEstado(rs.getString("estado"));
			despesas.add(d);
		}
		ps.close();
		rs.close();
		c.close();
		return despesas;
	}

	@Override
	public List<Despesa> findByName(String nome) throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}
}
