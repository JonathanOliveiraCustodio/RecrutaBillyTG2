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

import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IProdutoOrcamentoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.CategoriaProduto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Orcamento;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.ProdutoOrcamento;

@Repository
public class ProdutoOrcamentoDao implements IProdutoOrcamentoDao{
	private GenericDao gDao;
	
	public ProdutoOrcamentoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public String iudProdutoOrcamento(String acao, ProdutoOrcamento po) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "CALL sp_iud_produto_orcamento(?,?,?,?,?)";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, po.getCodigoOrcamento());
		cs.setInt(3, po.getCodigoProduto());
		cs.setInt(4, po.getQuantidade());
		cs.registerOutParameter(5, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(5);
		return saida;
	}

	@Override
	public List<ProdutoOrcamento> findAll(Orcamento o) throws SQLException, ClassNotFoundException {
		List<ProdutoOrcamento> produtosOrcamento = new ArrayList<>();
		Connection con = gDao.getConnection();
		String sql = "SELECT * FROM v_produto_orcamento WHERE codigo_orcamento = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, o.getCodigo());
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Produto p = new Produto();
			ProdutoOrcamento po = new ProdutoOrcamento();
			
			CategoriaProduto c = new CategoriaProduto();
			c.setCodigo(rs.getInt("codigo_categoria"));
			c.setNome(rs.getString("nome_categoria"));
			
			p.setCodigo(rs.getInt("codigo_produto"));
			p.setNome(rs.getString("nome_produto"));
			p.setCategoria(c);
			p.setDescricao(rs.getString("descricao"));
			p.setValorUnitario(rs.getFloat("valor_unitario"));
			
			po.setProduto(p);
			po.setCodigoProduto(p.getCodigo());
			po.setCodigoOrcamento(rs.getInt("codigo_orcamento"));
			po.setQuantidade(rs.getInt("quantidade"));
			produtosOrcamento.add(po);
		}
		rs.close();
		ps.close();
		con.close();
		return produtosOrcamento;
	}
	
	
}
