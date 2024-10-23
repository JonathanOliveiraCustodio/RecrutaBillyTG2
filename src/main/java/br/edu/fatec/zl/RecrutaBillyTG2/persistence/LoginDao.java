package br.edu.fatec.zl.RecrutaBillyTG2.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

			// Chama o procedimento armazenado sp_login_funcionario
			String sql = "{CALL sp_login_funcionario(?, ?, ?, ?)}"; // Não precisamos mais passar tentativas
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
			e.printStackTrace();
			resultado.put("mensagem", "Erro ao validar credenciais: " + e.getMessage());
			resultado.put("nivelAcesso", null);
			return resultado;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			resultado.put("mensagem", "Erro ao validar credenciais: Classe não encontrada");
			resultado.put("nivelAcesso", null);
			return resultado;
		} finally {
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
	
	public String obterCodigoRecuperacao(String email) throws SQLException, ClassNotFoundException {
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    String codigoRecuperacao = null;
	    try {
	        conn = gDao.getConnection(); // Obtém a conexão com o banco
	        String sql = "SELECT codigoRecuperacao FROM funcionario WHERE email = ?";
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, email);

	        rs = stmt.executeQuery();

	        if (rs.next()) {
	            codigoRecuperacao = rs.getString("codigoRecuperacao");
	        }

	    } finally {
	        if (rs != null) rs.close();
	        if (stmt != null) stmt.close();
	        if (conn != null) conn.close();
	    }

	    return codigoRecuperacao;
	}
	
	public String obterNumeroTelefone(String email) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String numeroTelefone = null;

	    try {
	        conn = gDao.getConnection(); // Obtém uma conexão com o banco de dados

	        // Consulta para obter o número de telefone
	        String sql = "SELECT telefone FROM funcionario WHERE email = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, email);

	        rs = pstmt.executeQuery();

	        // Verifica se o resultado existe e obtém o número de telefone
	        if (rs.next()) {
	            numeroTelefone = rs.getString("telefone");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) {
	                rs.close();
	            }
	            if (pstmt != null) {
	                pstmt.close();
	            }
	            if (conn != null) {
	                conn.close();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return numeroTelefone; // Retorna o número de telefone ou null se não encontrado
	}
}