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
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IManutencaoEquipamentoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Equipamento;
import br.edu.fatec.zl.RecrutaBillyTG2.model.ManutencaoEquipamento;

@Repository
public class ManutencaoEquipamentoDao implements IManutencaoEquipamentoDao {

	private GenericDao gDao;

	public ManutencaoEquipamentoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	// @Override
	public List<ManutencaoEquipamento> findAllCodigo(int codigoEquipamento)
			throws SQLException, ClassNotFoundException {

		List<ManutencaoEquipamento> manutencoes = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM fn_listar_manutencoes_equipamento(?)");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setInt(1, codigoEquipamento);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			ManutencaoEquipamento mp = new ManutencaoEquipamento();

			Equipamento e = new Equipamento();
			e.setCodigo(rs.getInt("codigoEquipamento"));
			e.setNome(rs.getString("nomeEquipamento"));

			mp.setCodigoManutencao(rs.getInt("codigoManutencao"));
			mp.setCodigoEquipamento(rs.getInt("codigoEquipamento"));
			mp.setDescricao(rs.getString("descricaoManutencao"));
			mp.setDataManutencao(rs.getDate("dataManutencao"));
			mp.setEquipamento(e);
			manutencoes.add(mp);
		}

		rs.close();
		ps.close();
		con.close();

		return manutencoes;
	}

	@Override
	public String sp_manutencaoEquipamento(String acao, ManutencaoEquipamento mp)
			throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_iud_manutencoesEquipamento (?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, mp.getCodigoManutencao());
		cs.setInt(3, mp.getCodigoEquipamento());
		cs.setString(4, mp.getDescricao());
		cs.registerOutParameter(5, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(5);
		cs.close();
		c.close();

		return saida;

	}

}
