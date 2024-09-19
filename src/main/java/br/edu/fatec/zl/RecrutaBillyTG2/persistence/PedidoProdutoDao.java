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

import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IPedidoProdutoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.CategoriaProduto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Pedido;
import br.edu.fatec.zl.RecrutaBillyTG2.model.PedidoProduto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;

@Repository
public class PedidoProdutoDao implements IPedidoProdutoDao{
	private GenericDao gDao;
	
	public PedidoProdutoDao(GenericDao gDao) {
		this.gDao = gDao;
	}
	 
	@Override
	public String iudPedidoProduto(String acao, PedidoProduto pp) throws SQLException, ClassNotFoundException {
	    Connection c = null;
	    CallableStatement cs = null;
	    String saida = "";
	    try {
	        c = gDao.getConnection();
	        String sql = "{CALL sp_iud_produtos_pedido(?,?,?,?,?)}";
	        cs = c.prepareCall(sql);
	        cs.setString(1, acao);
	        cs.setInt(2, pp.getCodigoPedido());
	        cs.setInt(3, pp.getCodigoProduto());
	        cs.setInt(4, pp.getQuantidade());
	        cs.registerOutParameter(5, Types.VARCHAR);
	        cs.execute();
	        boolean hasResult = cs.getMoreResults();
	        while (hasResult || cs.getUpdateCount() != -1) {
	            hasResult = cs.getMoreResults();
	        }
	        saida = cs.getString(5);
	    } finally {
	        if (cs != null) {
	            cs.close();
	        }
	        if (c != null) {
	            c.close();
	        }
	    }
	    return saida;
	}

	@Override
	public List<PedidoProduto> findAll(Pedido p) throws SQLException, ClassNotFoundException {
		List<PedidoProduto> pedidoProdutos = new ArrayList<>();
		Connection con = gDao.getConnection();
		String sql = "SELECT * FROM v_pedido_produto WHERE codigo_pedido = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, p.getCodigo());
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Produto pr = new Produto();
			PedidoProduto pp = new PedidoProduto();
			pr.setCodigo(rs.getInt("codigo_produto"));
			pr.setNome(rs.getString("nome_produto"));
			
			CategoriaProduto c = new CategoriaProduto();
			c.setCodigo(rs.getInt("codigo_categoria"));
			c.setNome(rs.getString("nome_categoria"));
			
			pr.setCategoria(c);
			pr.setDescricao(rs.getString("descricao_produto"));
			pr.setValorUnitario(rs.getInt("valor_unitario"));
			pp.setProduto(pr);
			pp.setCodigoProduto(pr.getCodigo());
			pp.setCodigoPedido(p.getCodigo());
			pp.setQuantidade(rs.getInt("quantidade"));
			pedidoProdutos.add(pp);
		}
		rs.close();
		ps.close();
		con.close();
		return pedidoProdutos;
	}

}
