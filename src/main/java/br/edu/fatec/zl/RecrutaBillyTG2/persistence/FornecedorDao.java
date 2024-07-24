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
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IFornecedorDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Fornecedor;

@Repository
public class FornecedorDao implements ICrud<Fornecedor>, IFornecedorDao {

	private GenericDao gDao;

	public FornecedorDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public Fornecedor findBy(Fornecedor f) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT codigo, nome, endereco, telefone, email, empresa FROM fornecedor WHERE codigo = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, f.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			f.setCodigo(rs.getInt("codigo"));
			f.setNome(rs.getString("nome"));
			f.setEndereco(rs.getString("endereco"));
			f.setTelefone(rs.getString("telefone"));
			f.setEmail(rs.getString("email"));
			f.setEmpresa(rs.getString("empresa"));

			rs.close();
			ps.close();
			c.close();
			return f;
		} else {
			rs.close();
			ps.close();
			c.close();
			return null;
		}
	}

	@Override
	public List<Fornecedor> findAll() throws SQLException, ClassNotFoundException {

		List<Fornecedor> fornecedores = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT codigo, nome, endereco, telefone, email, empresa FROM fornecedor";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {

			Fornecedor f = new Fornecedor();
			f.setCodigo(rs.getInt("codigo"));
			f.setNome(rs.getString("nome"));
			f.setEndereco(rs.getString("endereco"));
			f.setTelefone(rs.getString("telefone"));
			f.setEmail(rs.getString("email"));
			f.setEmpresa(rs.getString("empresa"));
			fornecedores.add(f);
		}
		rs.close();
		ps.close();
		c.close();
		return fornecedores;
	}

	@Override
	public String iudFornecedor(String acao, Fornecedor f) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_iud_fornecedor (?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, f.getCodigo());
		cs.setString(3, f.getNome());
		cs.setString(4, f.getEndereco());
		cs.setString(5, f.getTelefone());
		cs.setString(6, f.getEmail());
		cs.setString(7, f.getEmpresa());
		cs.registerOutParameter(8, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(8);
		cs.close();
		c.close();

		return saida;
	}

}