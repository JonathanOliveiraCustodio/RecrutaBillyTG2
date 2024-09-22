package br.edu.fatec.zl.RecrutaBillyTG2.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.edu.fatec.zl.RecrutaBillyTG2.model.Configuracoes;

@Repository
public class ConfiguracoesDao {

    @Autowired
    GenericDao gDao;

    public Configuracoes findConfiguracoes() throws SQLException, ClassNotFoundException {
        Connection con = gDao.getConnection();
        String sql = "SELECT * FROM configuracoes";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        Configuracoes c = null;
        if (rs.next()) {
            c = new Configuracoes();
            c.setQtdMaximaOrcamento(rs.getInt("qtdMaximaOrcamento"));
            c.setQtdMinimaProdutoEstoque(rs.getInt("qtdMinimaProdutoEstoque"));      
            c.setQtdMediaPedidoAndamento(rs.getInt("qtdMediaPedidoAndamento"));
            c.setQtdMediaPedidosRecebidos(rs.getInt("qtdMediaPedidosRecebidos"));
            c.setQtdMediaPedidosDespachados(rs.getInt("qtdMediaPedidosDespachados"));
            c.setQtdMediaProducaoProdutos(rs.getInt("qtdMediaProducaoProdutos"));      	
            c.setQtdDespesasPendentes(rs.getInt("qtdDespesasPendentes")); 
            c.setQtdDespesasVencidas(rs.getInt("qtdDespesasVencidas")); 
        	c.setValorTotalDespesasMes(rs.getFloat("valorTotalDespesasMes")); 
        }
        rs.close();
        ps.close();
        con.close();
        return c;
    }

    public String sp_u_configuracoes(Configuracoes c) throws SQLException, ClassNotFoundException {
        String sql = "CALL sp_u_configuracoes(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection con = gDao.getConnection();
        CallableStatement cs = con.prepareCall(sql);
        cs.setInt(1, c.getQtdMaximaOrcamento());
        cs.setInt(2, c.getQtdMinimaProdutoEstoque());
        cs.setInt(3, c.getQtdMediaPedidoAndamento());
        cs.setInt(4, c.getQtdMediaPedidosRecebidos());
        cs.setInt(5, c.getQtdMediaPedidosDespachados());
        cs.setInt(6, c.getQtdMediaProducaoProdutos());
        cs.setInt(7, c.getQtdDespesasPendentes()); 
        cs.setInt(8, c.getQtdDespesasVencidas()); 
        cs.setFloat(9, c.getValorTotalDespesasMes()); 
        
        cs.registerOutParameter(10, Types.VARCHAR);
        cs.execute();
        String saida = cs.getString(10);
        cs.close();
        con.close();
        return saida;
    }
}