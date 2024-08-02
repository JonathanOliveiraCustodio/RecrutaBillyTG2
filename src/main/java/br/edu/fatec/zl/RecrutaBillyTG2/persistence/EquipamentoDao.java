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
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IEquipamentoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Equipamento;

@Repository
public class EquipamentoDao implements ICrud<Equipamento>, IEquipamentoDao {

	private GenericDao gDao;

	public EquipamentoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public Equipamento findBy(Equipamento e) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM fn_consultar_equipamento(?)";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, e.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			e.setCodigo(rs.getInt("codigo"));
			e.setNome(rs.getString("nome"));
			e.setDescricao(rs.getString("descricao"));
			e.setFabricante(rs.getString("fabricante"));
			e.setDataAquisicao(rs.getDate("dataAquisicao"));

			rs.close();
			ps.close();
			c.close();
			return e;
		} else {
			rs.close();
			ps.close();
			c.close();
			return null;
		}
	}

	@Override
	public List<Equipamento> findAll() throws SQLException, ClassNotFoundException {

		List<Equipamento> equipamentos = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM fn_equipamento()";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {

			Equipamento e = new Equipamento();
			e.setCodigo(rs.getInt("codigo"));
			e.setNome(rs.getString("nome"));
			e.setDescricao(rs.getString("descricao"));
			e.setFabricante(rs.getString("fabricante"));
			e.setDataAquisicao(rs.getDate("dataAquisicao"));
			equipamentos.add(e);
		}
		rs.close();
		ps.close();
		c.close();
		return equipamentos;
	}

	@Override
	public String sp_iud_equipamento(String acao, Equipamento e) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_iud_equipamento (?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, e.getCodigo());
		cs.setString(3, e.getNome());
		cs.setString(4, e.getDescricao());
		cs.setString(5, e.getFabricante());
		cs.setDate(6, e.getDataAquisicao());
		cs.registerOutParameter(7, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(7);
		cs.close();
		c.close();

		return saida;
	}
}