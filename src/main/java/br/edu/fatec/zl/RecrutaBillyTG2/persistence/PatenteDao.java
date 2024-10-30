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
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IPatenteDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Patente;

@Repository
public class PatenteDao implements ICrud<Patente>, IPatenteDao {
	private GenericDao gDao;

	public PatenteDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public Patente findBy(Patente p) throws SQLException, ClassNotFoundException {
		String sql = "SELECT * FROM v_patente WHERE codigo = ?";
		Connection con = gDao.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, p.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nome"));
			p.setInstituicao(rs.getString("instituicao"));
			rs.close();
			ps.close();
			con.close();
			return p;
		} else {
			rs.close();
			ps.close();
			con.close();
			return null;
		}

	}

	@Override
	public List<Patente> findAll() throws SQLException, ClassNotFoundException {
		List<Patente> patentes = new ArrayList<>();
		String sql = "SELECT * FROM v_patente";
		Connection con = gDao.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Patente c = new Patente();
			c.setCodigo(rs.getInt("codigo"));
			c.setNome(rs.getString("nome"));
			c.setInstituicao(rs.getString("instituicao"));

			patentes.add(c);
		}
		ps.close();
		rs.close();
		con.close();
		return patentes;
	}

	@Override
	public String sp_iud_patente(String acao, Patente p) throws SQLException, ClassNotFoundException {
		String sql = "CALL sp_iud_patente(?,?,?,?,?)";
		Connection con = gDao.getConnection();
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, p.getCodigo());
		cs.setString(3, p.getNome());
		cs.setString(4, p.getInstituicao());
		cs.registerOutParameter(5, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(5);

		cs.close();
		con.close();
		return saida;
	}

	@Override
	public List<Patente> findByName(String nome) throws SQLException, ClassNotFoundException {
		List<Patente> patentes = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM v_patente WHERE nome LIKE ?");
		PreparedStatement ps = con.prepareStatement(sql.toString());
		// "%" Para fazer buscas aproximadas
		ps.setString(1, "%" + nome + "%");
		// ps.setString(1, nome);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Patente p = new Patente();
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nome"));
			p.setInstituicao(rs.getString("instituicao"));
			patentes.add(p);
		}

		rs.close();
		ps.close();
		con.close();

		return patentes;
	}

	@Override
	public List<Patente> findPatenteByOption(String opcao, String parametro)
			throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}

}
