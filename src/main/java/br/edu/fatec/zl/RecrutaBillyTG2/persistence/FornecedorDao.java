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
		String sql = "SELECT * FROM vw_fornecedor WHERE codigo = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, f.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			f.setCodigo(rs.getInt("codigo"));
			f.setNome(rs.getString("nome"));
			f.setTelefone(rs.getString("telefone"));
			f.setEmail(rs.getString("email"));
			f.setEmpresa(rs.getString("empresa"));
			f.setCEP(rs.getString("CEP"));
			f.setLogradouro(rs.getString("logradouro"));
			f.setNumero(rs.getString("numero"));
			f.setBairro(rs.getString("bairro"));
			f.setComplemento(rs.getString("complemento"));
			f.setCidade(rs.getString("cidade"));
			f.setUF(rs.getString("UF"));
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
		String sql = "SELECT * FROM vw_fornecedor";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {

			Fornecedor f = new Fornecedor();
			f.setCodigo(rs.getInt("codigo"));
			f.setNome(rs.getString("nome"));
			f.setTelefone(rs.getString("telefone"));
			f.setEmail(rs.getString("email"));
			f.setEmpresa(rs.getString("empresa"));
			f.setCEP(rs.getString("CEP"));
			f.setLogradouro(rs.getString("logradouro"));
			f.setNumero(rs.getString("numero"));
			f.setBairro(rs.getString("bairro"));
			f.setComplemento(rs.getString("complemento"));
			f.setCidade(rs.getString("cidade"));
			f.setUF(rs.getString("UF"));
			fornecedores.add(f);
		}
		rs.close();
		ps.close();
		c.close();
		return fornecedores;
	}

	@Override
	public String sp_iud_fornecedor(String acao, Fornecedor f) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_iud_fornecedor (?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, f.getCodigo());
		cs.setString(3, f.getNome());
		cs.setString(4, f.getTelefone());
		cs.setString(5, f.getEmail());
		cs.setString(6, f.getEmpresa());
		cs.setString(7, f.getCEP());
		cs.setString(8, f.getLogradouro());
		cs.setString(9, f.getNumero());
		cs.setString(10, f.getBairro());
		cs.setString(11, f.getComplemento());
		cs.setString(12, f.getCidade());
		cs.setString(13, f.getUF());
		cs.registerOutParameter(14, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(14);
		cs.close();
		c.close();
		return saida;
	}

	@Override
	public List<Fornecedor> findFornecedoresByOption(String opcao, String parametro)
			throws SQLException, ClassNotFoundException {
		List<Fornecedor> fornecedores = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM fn_buscar_fornecedor(?,?) ");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setString(1, opcao);
		ps.setString(2, parametro);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Fornecedor f = new Fornecedor();
			f.setCodigo(rs.getInt("codigo"));
			f.setNome(rs.getString("nome"));
			f.setTelefone(rs.getString("telefone"));
			f.setEmail(rs.getString("email"));
			f.setEmpresa(rs.getString("empresa"));
			f.setCEP(rs.getString("CEP"));
			f.setLogradouro(rs.getString("logradouro"));
			f.setNumero(rs.getString("numero"));
			f.setBairro(rs.getString("bairro"));
			f.setComplemento(rs.getString("complemento"));
			f.setCidade(rs.getString("cidade"));
			f.setUF(rs.getString("UF"));
			fornecedores.add(f);
		}

		rs.close();
		ps.close();
		con.close();

		return fornecedores;
	}

	@Override
	public List<Fornecedor> findByName(String nome) throws SQLException, ClassNotFoundException {
		List<Fornecedor> fornecedores = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM vw_fornecedor WHERE nome LIKE ?");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		// "%" Para fazer buscas aproximadas
		ps.setString(1, "%" + nome + "%");
		//ps.setString(1, nome);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Fornecedor f = new Fornecedor();
			f.setCodigo(rs.getInt("codigo"));
			f.setNome(rs.getString("nome"));
			f.setTelefone(rs.getString("telefone"));
			f.setEmail(rs.getString("email"));
			f.setEmpresa(rs.getString("empresa"));
			f.setCEP(rs.getString("CEP"));
			f.setLogradouro(rs.getString("logradouro"));
			f.setNumero(rs.getString("numero"));
			f.setBairro(rs.getString("bairro"));
			f.setComplemento(rs.getString("complemento"));
			f.setCidade(rs.getString("cidade"));
			f.setUF(rs.getString("UF"));
			fornecedores.add(f);
		}

		rs.close();
		ps.close();
		con.close();

		return fornecedores;
	}

}