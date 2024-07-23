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
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IProdutoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;

@Repository
public class ProdutoDao implements ICrud<Produto>, IProdutoDao {

	private GenericDao gDao;

	public ProdutoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public String iudProduto(String acao, Produto p) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_iud_produto (?,?,?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, p.getCodigo());
		cs.setString(3, p.getNome());
		cs.setString(4, p.getCategoria());
		cs.setString(5, p.getDescricao());
		cs.setFloat(6, p.getValorUnitario());
		cs.setString(7, p.getStatus());
		cs.setInt(8, p.getQuantidade());
		cs.setString(9, p.getRefEstoque());
		cs.registerOutParameter(10, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(10);
		cs.close();
		c.close();

		return saida;
	}

	@Override
	public Produto consultar(Produto p) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM fn_consultar_produto(?)";
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setInt(1, p.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nome"));
			p.setDescricao(rs.getString("descricao"));
			p.setCategoria(rs.getString("categoria"));
			p.setValorUnitario(rs.getFloat("valorUnitario"));
			p.setStatus(rs.getString("status"));
			p.setQuantidade(rs.getInt("quantidade"));
			p.setRefEstoque(rs.getString("refEstoque"));
			return p;
		} else {
			rs.close();
			ps.close();
			c.close();
			return null;
		}
	}

	@Override
	public List<Produto> listar() throws SQLException, ClassNotFoundException {

		List<Produto> produtos = new ArrayList<>();
		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM fn_produto() ");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Produto p = new Produto();
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nome"));
			p.setCategoria(rs.getString("categoria"));
			p.setDescricao(rs.getString("descricao"));
			p.setValorUnitario(rs.getFloat("valorUnitario"));
			p.setStatus(rs.getString("status"));
			p.setQuantidade(rs.getInt("quantidade"));
			p.setRefEstoque(rs.getString("refEstoque"));
			produtos.add(p);
		}
		rs.close();
		ps.close();
		c.close();
		return produtos;
	}
}