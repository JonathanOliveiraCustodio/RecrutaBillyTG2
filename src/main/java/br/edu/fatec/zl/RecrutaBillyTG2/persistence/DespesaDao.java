package br.edu.fatec.zl.RecrutaBillyTG2.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
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
		String sql = "CALL sp_iud_despesa(?,?,?,?,?,?,?,?,?)";
		Connection c = gDao.getConnection();
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, d.getCodigo());
		cs.setString(3, d.getNome());
		cs.setDate(4, d.getData());
		cs.setDate(5, d.getDataVencimento());
		cs.setFloat(6, d.getValor());
		cs.setString(7, d.getTipo());
		cs.setString(8, d.getEstado());
		cs.registerOutParameter(9, Types.VARCHAR);
		String saida = cs.getString(8);
		cs.close();
		c.close();
		return saida;
	}
	
	@Override
	public Despesa findBy(Despesa t) throws SQLException, ClassNotFoundException {
		String sql = "SELECT * FROM despesa WHERE codigo = ?";
	}

	@Override
	public List<Despesa> findAll() throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}

	
	
}
