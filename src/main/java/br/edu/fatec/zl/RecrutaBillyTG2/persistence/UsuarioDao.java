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
import br.edu.fatec.zl.RecrutaBillyTG2.model.Usuario;

@Repository
public class UsuarioDao implements ICrud<Usuario> {
	private GenericDao gDao;

	public UsuarioDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public Usuario findBy(Usuario u) throws SQLException, ClassNotFoundException {
		String sql = "SELECT * FROM fn_listar_usuario_cpf(?)";
		Connection c = gDao.getConnection();
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, u.getCPF());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			u.setCPF(rs.getString("CPF"));
			u.setNome(rs.getString("nome"));
			u.setNivelAcesso(rs.getString("nivelAcesso"));
			u.setEmail(rs.getString("email"));
			u.setSenha(rs.getString("senha"));

			rs.close();
			ps.close();
			c.close();
			return u;
		} else {
			rs.close();
			ps.close();
			c.close();
			return null;
		}

	}

	@Override
	public List<Usuario> findAll() throws SQLException, ClassNotFoundException {
		List<Usuario> usuarios = new ArrayList<>();
		String sql = "SELECT * FROM v_usuario";
		Connection c = gDao.getConnection();
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Usuario u = new Usuario();
			u.setCPF(rs.getString("CPF"));
			u.setNome(rs.getString("nome"));
			u.setNivelAcesso(rs.getString("nivelAcesso"));
			u.setSenha(rs.getString("senha"));
			u.setEmail(rs.getString("email"));
			usuarios.add(u);
		}
		ps.close();
		rs.close();
		c.close();
		return usuarios;
	}

	// @Override
	public String iudUsuario(String acao, Usuario cl) throws SQLException, ClassNotFoundException {
		String sql = "CALL sp_iud_usuario(?,?,?,?,?,?,?)";
		Connection c = gDao.getConnection();
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setString(2, cl.getCPF());
		cs.setString(3, cl.getNome());
		cs.setString(4, cl.getNivelAcesso());
		cs.setString(5, cl.getSenha());
		cs.setString(6, cl.getEmail());
	
		cs.registerOutParameter(7, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(7);

		cs.close();
		c.close();
		return saida;
	}
}
