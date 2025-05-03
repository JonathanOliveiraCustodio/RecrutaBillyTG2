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
import br.edu.fatec.zl.RecrutaBillyTG2.model.CategoriaProduto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;

@Repository
public class ProdutoDao implements ICrud<Produto>, IProdutoDao {

	private GenericDao gDao;

	public ProdutoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public String sp_iud_produto(String acao, Produto p) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_iud_produto (?,?,?,?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, p.getCodigo());
		cs.setString(3, p.getNome());
		cs.setInt(4, p.getCategoria().getCodigo());
		cs.setString(5, p.getDescricao());
		cs.setFloat(6, p.getValorUnitario());
		cs.setString(7, p.getStatus());
		cs.setInt(8, p.getQuantidade());
		cs.setString(9, p.getRefEstoque());
		cs.setDate(10, p.getDataProduto());
		cs.registerOutParameter(11, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(11);
		cs.close();
		c.close();

		return saida;
	}

	@Override
	public Produto findBy(Produto p) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		String sql = "SELECT * FROM v_produto WHERE codigo = ?";
		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setInt(1, p.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			
			CategoriaProduto c = new CategoriaProduto();
			c.setCodigo(rs.getInt("codigoCategoria"));
			c.setNome(rs.getString("nomeCategoria"));
			
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nome"));
			p.setDescricao(rs.getString("descricao"));
			
			p.setCategoria(c);
			p.setValorUnitario(rs.getFloat("valorUnitario"));
			p.setStatus(rs.getString("status"));
			p.setQuantidade(rs.getInt("quantidade"));
			p.setRefEstoque(rs.getString("refEstoque"));
			//p.setDataProduto(rs.getDate("dataProduto"));
			return p;
		} else {
			rs.close();
			ps.close();
			con.close();
			return null;
		}
	}

	@Override
	public List<Produto> findAll() throws SQLException, ClassNotFoundException {

		List<Produto> produtos = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM v_produto ");
		PreparedStatement ps = con.prepareStatement(sql.toString());
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			CategoriaProduto c = new CategoriaProduto();
			c.setCodigo(rs.getInt("codigoCategoria"));
			c.setNome(rs.getString("nomeCategoria"));
			Produto p = new Produto();
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nome"));
			p.setCategoria(c);
			p.setDescricao(rs.getString("descricao"));
			p.setValorUnitario(rs.getFloat("valorUnitario"));
			p.setStatus(rs.getString("status"));
			p.setQuantidade(rs.getInt("quantidade"));
			p.setRefEstoque(rs.getString("refEstoque"));
		//	p.setDataProduto(rs.getDate("dataProduto"));
			produtos.add(p);
		}
		rs.close();
		ps.close();
		con.close();
		return produtos;
	}
	
	@Override
	public List<Produto> findProdutosByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException {
		List<Produto> produtos = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM fn_buscar_produto(?,?)");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setString(1, opcao);
		ps.setString(2, parametro);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {	
			CategoriaProduto c = new CategoriaProduto();
			c.setCodigo(rs.getInt("codigoCategoria"));
			c.setNome(rs.getString("nomeCategoria"));
			Produto p = new Produto();
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nome"));
			p.setCategoria(c);
			p.setDescricao(rs.getString("descricao"));
			p.setValorUnitario(rs.getFloat("valorUnitario"));
			p.setStatus(rs.getString("status"));
			p.setQuantidade(rs.getInt("quantidade"));
			p.setRefEstoque(rs.getString("refEstoque"));
		//	p.setDataProduto(rs.getDate("dataProduto"));
			produtos.add(p);	
		}
		rs.close();
		ps.close();
		con.close();

		return produtos;
	}

	@Override
	public List<Produto> findByName(String nome) throws SQLException, ClassNotFoundException {
		List<Produto> produtos = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM v_produto WHERE nome LIKE ?");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		// "%" Para fazer buscas aproximadas
		ps.setString(1, "%" + nome + "%");
		//ps.setString(1, nome);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {	
			CategoriaProduto c = new CategoriaProduto();
			c.setCodigo(rs.getInt("codigoCategoria"));
			c.setNome(rs.getString("nomeCategoria"));
			Produto p = new Produto();
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nome"));
			p.setCategoria(c);
			p.setDescricao(rs.getString("descricao"));
			p.setValorUnitario(rs.getFloat("valorUnitario"));
			p.setStatus(rs.getString("status"));
			p.setQuantidade(rs.getInt("quantidade"));
			p.setRefEstoque(rs.getString("refEstoque"));
		//	p.setDataProduto(rs.getDate("dataProduto"));
			produtos.add(p);	
		}
		rs.close();
		ps.close();
		con.close();

		return produtos;
	}
	
	public List<Produto> findByStatus(String status) throws SQLException, ClassNotFoundException {
		List<Produto> produtos = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM v_produto WHERE status LIKE ?");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		// "%" Para fazer buscas aproximadas
		ps.setString(1, "%" + status + "%");
		//ps.setString(1, nome);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {	
			CategoriaProduto c = new CategoriaProduto();
			c.setCodigo(rs.getInt("codigoCategoria"));
			c.setNome(rs.getString("nomeCategoria"));
			Produto p = new Produto();
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nome"));
			p.setCategoria(c);
			p.setDescricao(rs.getString("descricao"));
			p.setValorUnitario(rs.getFloat("valorUnitario"));
			p.setStatus(rs.getString("status"));
			p.setQuantidade(rs.getInt("quantidade"));
			p.setRefEstoque(rs.getString("refEstoque"));
		//	p.setDataProduto(rs.getDate("dataProduto"));
			produtos.add(p);			
		}
		rs.close();
		ps.close();
		con.close();
		return produtos;
	}
	
	public List<Produto> findByEstoqueBaixo(int qtd) throws SQLException, ClassNotFoundException {
	    List<Produto> produtos = new ArrayList<>();
	    Connection con = gDao.getConnection();
	    
	    StringBuilder sql = new StringBuilder();
	    sql.append("SELECT * FROM v_produto WHERE quantidade <= ?");  
	    PreparedStatement ps = con.prepareStatement(sql.toString());
	    ps.setInt(1, qtd);  

	    ResultSet rs = ps.executeQuery();

	    while (rs.next()) {	
	    	CategoriaProduto c = new CategoriaProduto();
			c.setCodigo(rs.getInt("codigoCategoria"));
			c.setNome(rs.getString("nomeCategoria"));
	        Produto p = new Produto();
	        p.setCodigo(rs.getInt("codigo"));
	        p.setNome(rs.getString("nome"));
	        p.setCategoria(c);
	        p.setDescricao(rs.getString("descricao"));
	        p.setValorUnitario(rs.getFloat("valorUnitario"));
	        p.setStatus(rs.getString("status"));
	        p.setQuantidade(rs.getInt("quantidade"));
	        p.setRefEstoque(rs.getString("refEstoque"));
	     //   p.setDataProduto(rs.getDate("dataProduto"));
	        produtos.add(p);			
	    }

	    rs.close();
	    ps.close();
	    con.close();

	    return produtos;
	}
	
	public List<Produto> findCategoria(String categoria) throws SQLException, ClassNotFoundException {
		List<Produto> produtos = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM v_produto WHERE nomeCategoria LIKE ?");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		// "%" Para fazer buscas aproximadas
		ps.setString(1, "%" + categoria + "%");
		//ps.setString(1, nome);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {	
			CategoriaProduto c = new CategoriaProduto();
			c.setCodigo(rs.getInt("codigoCategoria"));
			c.setNome(rs.getString("nomeCategoria"));
			Produto p = new Produto();
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nome"));
			p.setCategoria(c);
			p.setDescricao(rs.getString("descricao"));
			p.setValorUnitario(rs.getFloat("valorUnitario"));
			p.setStatus(rs.getString("status"));
			p.setQuantidade(rs.getInt("quantidade"));
			p.setRefEstoque(rs.getString("refEstoque"));
		//	p.setDataProduto(rs.getDate("dataProduto"));
			produtos.add(p);			
		}
		rs.close();
		ps.close();
		con.close();
		return produtos;
	}

}