package br.edu.fatec.zl.RecrutaBillyTG2.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import br.edu.fatec.zl.RecrutaBillyTG2.model.Funcionario;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Log;

@Repository
public class LogDao {
	private GenericDao gDao;

	public LogDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	public List<Log> findAll() throws SQLException, ClassNotFoundException {
		List<Log> logs = new ArrayList<>();
		String sql = "SELECT lf.codigo, lf.CPF, f.nome, lf.dataLogin, lf.dataLogout, "
				+ "lf.duracaoSessao, lf.ipAddress, lf.dispositivo, lf.navegador " + "FROM logFuncionario lf "
				+ "JOIN funcionario f ON lf.CPF = f.CPF " + "ORDER BY lf.dataLogin DESC";

		// Obter conexão
		Connection c = gDao.getConnection();
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Log l = new Log();
			Funcionario f = new Funcionario();

			l.setCodigo(rs.getInt("codigo"));
			l.setCPF(rs.getString("CPF"));

			f.setNome(rs.getString("nome"));
			l.setFuncionario(f);

			// Converter Timestamp para LocalDateTime
			Timestamp tsdataLogin = rs.getTimestamp("dataLogin");
			if (tsdataLogin != null) {
				l.setDataLogin(tsdataLogin.toLocalDateTime());
			}

			// Converter Timestamp para LocalDateTime
			Timestamp tsdataLogout = rs.getTimestamp("dataLogout");
			if (tsdataLogout != null) {
				l.setDataLogout(tsdataLogout.toLocalDateTime());
			}

			l.setDuracaoSessao(rs.getTime("duracaoSessao"));
			l.setIpAddress(rs.getString("ipAddress"));
			l.setDispositivo(rs.getString("dispositivo"));
			l.setNavegador(rs.getString("navegador"));

			logs.add(l);
		}

		ps.close();
		rs.close();
		c.close();
		return logs;
	}

}