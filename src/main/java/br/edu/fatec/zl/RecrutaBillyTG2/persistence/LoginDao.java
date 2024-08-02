package br.edu.fatec.zl.RecrutaBillyTG2.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public class LoginDao {
	private GenericDao gDao;

	public LoginDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	public Map<String, String> validarCredenciais(String email, String senha) {
		Connection conn = null;
		CallableStatement cstmt = null;
		Map<String, String> resultado = new HashMap<>();

		try {
			conn = gDao.getConnection(); // Obtém uma conexão com o banco de dados

			// Chama o procedimento armazenado sp_login_usuario
			String sql = "{CALL sp_login_funcionario(?, ?, ?, ?)}";
			cstmt = conn.prepareCall(sql);
			cstmt.setString(1, email);
			cstmt.setString(2, senha);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR); // Parâmetro de saída para armazenar a mensagem
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR); // Parâmetro de saída para armazenar o nível de
																	// acesso
			cstmt.execute();

			// Obtém o resultado do procedimento armazenado
			resultado.put("mensagem", cstmt.getString(3));
			resultado.put("nivelAcesso", cstmt.getString(4));

			return resultado;
		} catch (SQLException e) {
			// Tratar exceção de SQL aqui, se necessário
			e.printStackTrace();
			resultado.put("mensagem", "Erro ao validar credenciais: " + e.getMessage());
			resultado.put("nivelAcesso", null);
			return resultado;
		} catch (ClassNotFoundException e) {
			// Tratar exceção de classe não encontrada aqui
			e.printStackTrace();
			resultado.put("mensagem", "Erro ao validar credenciais: Classe não encontrada");
			resultado.put("nivelAcesso", null);
			return resultado;
		} finally {
			// Fechando recursos
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}