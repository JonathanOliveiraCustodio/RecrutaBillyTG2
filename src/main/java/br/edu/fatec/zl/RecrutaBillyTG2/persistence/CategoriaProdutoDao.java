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

import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.ICategoriaProdutoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.ICrud;
import br.edu.fatec.zl.RecrutaBillyTG2.model.CategoriaProduto;


@Repository
public class CategoriaProdutoDao implements ICrud<CategoriaProduto>, ICategoriaProdutoDao {
	private GenericDao gDao;

	public CategoriaProdutoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	 @Override
	public CategoriaProduto findBy(CategoriaProduto c) throws SQLException, ClassNotFoundException {
		String sql = "SELECT * FROM categoriaProduto WHERE codigo = ?";
		Connection con = gDao.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, c.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			c.setCodigo(rs.getInt("codigo"));
			c.setNome(rs.getString("nome"));
			rs.close();
			ps.close();
			con.close();
			return c;
		} else {
			rs.close();
			ps.close();
			con.close();
			return null;
		}

	}

	 @Override
	public List<CategoriaProduto> findAll() throws SQLException, ClassNotFoundException {
		List<CategoriaProduto> categoriaProdutos = new ArrayList<>();
		String sql = "SELECT * FROM categoriaProduto";
		Connection con = gDao.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			CategoriaProduto c = new CategoriaProduto();
			c.setCodigo(rs.getInt("codigo"));
			c.setNome(rs.getString("nome"));
			
			categoriaProdutos.add(c);
		}
		ps.close();
		rs.close();
		con.close();
		return categoriaProdutos;
	}

	 @Override
	public String sp_iud_categoria_produto(String acao, CategoriaProduto c) throws SQLException, ClassNotFoundException {
		String sql = "CALL sp_iud_categoriaProduto(?,?,?,?)";
		Connection con = gDao.getConnection();
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, c.getCodigo());
		cs.setString(3, c.getNome());
		cs.registerOutParameter(4, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(4);

		cs.close();
		con.close();
		return saida;
	}

//	// @Override
//	public List<Cliente> findClientesByOption(String opcao, String parametro)
//			throws SQLException, ClassNotFoundException {
//		List<Cliente> clientes = new ArrayList<>();
//		Connection con = gDao.getConnection();
//		StringBuffer sql = new StringBuffer();
//
//		sql.append("SELECT * FROM fn_buscar_cliente(?,?) ");
//
//		PreparedStatement ps = con.prepareStatement(sql.toString());
//		ps.setString(1, opcao);
//		ps.setString(2, parametro);
//		ResultSet rs = ps.executeQuery();
//
//		while (rs.next()) {
//			Cliente cl = new Cliente();
//			cl.setCodigo(rs.getInt("codigo"));
//			cl.setNome(rs.getString("nome"));
//			cl.setTelefone(rs.getString("telefone"));
//			cl.setEmail(rs.getString("email"));
//			cl.setTipo(rs.getString("tipo"));
//			cl.setDocumento(rs.getString("documento"));
//			cl.setCEP(rs.getString("CEP"));
//			cl.setLogradouro(rs.getString("logradouro"));
//			cl.setBairro(rs.getString("bairro"));
//			cl.setLocalidade(rs.getString("localidade"));
//			cl.setUF(rs.getString("UF"));
//			cl.setComplemento(rs.getString("complemento"));
//			cl.setNumero(rs.getString("numero"));
//			cl.setDataNascimento(rs.getDate("dataNascimento"));
//			clientes.add(cl);
//		}
//
//		rs.close();
//		ps.close();
//		con.close();
//
//		return clientes;
//	}

	 @Override
	public List<CategoriaProduto> findByName(String nome) throws SQLException, ClassNotFoundException {
		List<CategoriaProduto> categoriaProdutos = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM categoriaProduto WHERE nome LIKE ?");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		// "%" Para fazer buscas aproximadas
		ps.setString(1, "%" + nome + "%");
		// ps.setString(1, nome);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			CategoriaProduto c = new CategoriaProduto();
			c.setCodigo(rs.getInt("codigo"));
			c.setNome(rs.getString("nome"));
			categoriaProdutos.add(c);
		}

		rs.close();
		ps.close();
		con.close();

		return categoriaProdutos;
	}

	@Override
	public List<CategoriaProduto> findPedidosByOption(String opcao, String parametro)
			throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}


}
