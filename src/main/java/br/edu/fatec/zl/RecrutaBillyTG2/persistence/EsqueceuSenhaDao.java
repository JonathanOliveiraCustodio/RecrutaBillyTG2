package br.edu.fatec.zl.RecrutaBillyTG2.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public class EsqueceuSenhaDao {
    private GenericDao gDao;

    public EsqueceuSenhaDao(GenericDao gDao) {
        this.gDao = gDao;
    }

    public Map<String, String> alterarSenha(String email, String cpf, String novaSenha, String codigoRecuperacao) {
        Connection conn = null;
        CallableStatement cstmt = null;
        Map<String, String> resultado = new HashMap<>();

        try {
            conn = gDao.getConnection(); 
            
            String sql = "{CALL sp_alterar_senha(?,?,?,?,?)}";
            cstmt = conn.prepareCall(sql);
            cstmt.setString(1, email);
            cstmt.setString(2, cpf);
            cstmt.setString(3, novaSenha);
            cstmt.setString(4, codigoRecuperacao);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR); 
            cstmt.execute();

            resultado.put("mensagem", cstmt.getString(5));

            return resultado;
        } catch (SQLException e) {
            e.printStackTrace();
            resultado.put("mensagem", "Erro ao alterar senha: " + e.getMessage());
            return resultado;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            resultado.put("mensagem", "Erro ao alterar senha: Classe não encontrada");
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
}
