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
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.INomeTarjetaDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.NomeTarjeta;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Patente;


@Repository
public class NomeTarjetaDao implements ICrud<NomeTarjeta>, INomeTarjetaDao {
	private GenericDao gDao;

	public NomeTarjetaDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public NomeTarjeta findBy(NomeTarjeta nt) throws SQLException, ClassNotFoundException {
		String sql = "SELECT * FROM v_nomeTarjeta WHERE codigo = ?";
		Connection con = gDao.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, nt.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			nt.setCodigo(rs.getInt("codigo"));
			nt.setNome(rs.getString("nome"));
			nt.setTipoSanguineo(rs.getString("tipoSanguineo"));
			nt.setFatorRH(rs.getString("fatorRH"));
			nt.setQuantidade(rs.getInt("quantidade"));
			

			Patente p = new Patente();
			p.setCodigo(rs.getInt("codigoPatente"));
			p.setNome(rs.getString("nomePatente"));
			nt.setPatente(p);

			rs.close();
			ps.close();
			con.close();
			return nt;
		} else {
			rs.close();
			ps.close();
			con.close();
			return null;
		}

	}

	@Override
	public List<NomeTarjeta> findAll() throws SQLException, ClassNotFoundException {
		List<NomeTarjeta> nomesTarjetas = new ArrayList<>();
		String sql = "SELECT * FROM v_nomeTarjeta";
		Connection con = gDao.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			NomeTarjeta nt = new NomeTarjeta();
			nt.setCodigo(rs.getInt("codigo"));
			nt.setNome(rs.getString("nome"));
			nt.setTipoSanguineo(rs.getString("tipoSanguineo"));
			nt.setFatorRH(rs.getString("fatorRH"));
			nt.setQuantidade(rs.getInt("quantidade"));

			Patente p = new Patente();
			p.setCodigo(rs.getInt("codigoPatente"));
			p.setNome(rs.getString("nomePatente"));
			nt.setPatente(p);

			nomesTarjetas.add(nt);
		}
		ps.close();
		rs.close();
		con.close();
		return nomesTarjetas;
	}

	@Override
	public String spManterNomeTarjeta(String acao, NomeTarjeta nt) throws SQLException, ClassNotFoundException {
		String sql = "CALL sp_iud_nomesTarjetas(?,?,?,?,?,?,?,?)";
		Connection c = gDao.getConnection();
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, nt.getCodigo());
		cs.setString(3, nt.getNome());
		cs.setString(4, nt.getTipoSanguineo());
		cs.setString(5, nt.getFatorRH());
		cs.setInt(6, nt.getPatente().getCodigo());
		cs.setInt(7, nt.getQuantidade());
		cs.registerOutParameter(8, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(8);

		cs.close();
		c.close();
		return saida;
	}

	@Override
	public List<NomeTarjeta> findNomeTarjetaByOption(String opcao, String parametro)
			throws SQLException, ClassNotFoundException {
		List<NomeTarjeta> nomesTarjetas = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM fn_buscar_tarjeta(?,?) ");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setString(1, opcao);
		ps.setString(2, parametro);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			NomeTarjeta nt = new NomeTarjeta();
			nt.setCodigo(rs.getInt("codigo"));
			nt.setNome(rs.getString("nome"));
			nt.setTipoSanguineo(rs.getString("tipoSanguineo"));
			nt.setFatorRH(rs.getString("fatorRH"));
			nt.setQuantidade(rs.getInt("quantidade"));

			Patente p = new Patente();
			p.setCodigo(rs.getInt("codigoPatente"));
			p.setNome(rs.getString("nomePatente"));
			nt.setPatente(p);

			nomesTarjetas.add(nt);
		}

		rs.close();
		ps.close();
		con.close();

		return nomesTarjetas;
	}

	@Override
	public List<NomeTarjeta> findByName(String nome) throws SQLException, ClassNotFoundException {
		List<NomeTarjeta> nomesTarjetas = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM v_nomeTarjeta WHERE nome LIKE ?");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		// "%" Para fazer buscas aproximadas
		ps.setString(1, "%" + nome + "%");
		// ps.setString(1, nome);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			NomeTarjeta nt = new NomeTarjeta();
			nt.setCodigo(rs.getInt("codigo"));
			nt.setNome(rs.getString("nome"));
			nt.setTipoSanguineo(rs.getString("tipoSanguineo"));
			nt.setFatorRH(rs.getString("fatorRH"));
			nt.setQuantidade(rs.getInt("quantidade"));

			Patente p = new Patente();
			p.setCodigo(rs.getInt("codigoPatente"));
			p.setNome(rs.getString("nomePatente"));
			nt.setPatente(p);

			nomesTarjetas.add(nt);
		}

		rs.close();
		ps.close();
		con.close();

		return nomesTarjetas;
	}

}
