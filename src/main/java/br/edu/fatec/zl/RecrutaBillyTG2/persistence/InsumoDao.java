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
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IInsumoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Fornecedor;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Insumo;

@Repository
public class InsumoDao implements ICrud<Insumo>, IInsumoDao {

	private GenericDao gDao;

	public InsumoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public String sp_iud_Insumo(String acao, Insumo i) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_iud_insumo (?,?,?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, i.getCodigo());
		cs.setString(3, i.getNome());
		cs.setFloat(4, i.getPrecoCompra());
		cs.setFloat(5, i.getPrecoVenda());
		cs.setFloat(6, i.getQuantidade());
		cs.setString(7, i.getUnidade());
		cs.setInt(8, i.getFornecedor().getCodigo());
		cs.setDate(9, i.getDataCompra());
		cs.registerOutParameter(10, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(10);
		cs.close();
		c.close();

		return saida;
	}

	@Override
	public Insumo findBy(Insumo i) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM vw_insumo WHERE codigo = ?");
		
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setInt(1, i.getCodigo());

		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			Fornecedor f = new Fornecedor();
			f.setCodigo(rs.getInt("codigoFornecedor"));
			f.setNome(rs.getString("nomeFornecedor"));
			
			i.setCodigo(rs.getInt("codigo"));
			i.setNome(rs.getString("nome"));
			i.setPrecoCompra(rs.getFloat("precoCompra"));
			i.setPrecoVenda(rs.getFloat("precoVenda"));
			i.setQuantidade(rs.getFloat("quantidade"));
			i.setUnidade(rs.getString("unidade"));
			i.setFornecedor(f);
            i.setDataCompra(rs.getDate("dataCompra"));
			rs.close();
			ps.close();
			c.close();
			return i;
		} else {
			rs.close();
			ps.close();
			c.close();
			return null;
		}
	}

	@Override
	public List<Insumo> findAll() throws SQLException, ClassNotFoundException {
		List<Insumo> insumos = new ArrayList<>();
		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM vw_insumo");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Fornecedor f = new Fornecedor();
			f.setCodigo(rs.getInt("codigoFornecedor"));
			f.setNome(rs.getString("nomeFornecedor"));
			Insumo i = new Insumo();
			i.setCodigo(rs.getInt("codigo"));
			i.setNome(rs.getString("nome"));
			i.setPrecoCompra(rs.getFloat("precoCompra"));
			i.setPrecoVenda(rs.getFloat("precoVenda"));
			i.setQuantidade(rs.getFloat("quantidade"));
			i.setUnidade(rs.getString("unidade"));
			i.setFornecedor(f);
			i.setDataCompra(rs.getDate("dataCompra"));
			insumos.add(i);
		}
		rs.close();
		ps.close();
		c.close();
		return insumos;
	}
	
	@Override
	public List<Insumo> findInsumosByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException {
		List<Insumo> insumos = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM fn_buscar_insumo(?,?) ");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setString(1, opcao);
		ps.setString(2, parametro);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Fornecedor f = new Fornecedor();
			f.setCodigo(rs.getInt("codigoFornecedor"));
			f.setNome(rs.getString("nomeFornecedor"));
			Insumo i = new Insumo();
			i.setCodigo(rs.getInt("codigo"));
			i.setNome(rs.getString("nome"));
			i.setPrecoCompra(rs.getFloat("precoCompra"));
			i.setPrecoVenda(rs.getFloat("precoVenda"));
			i.setQuantidade(rs.getFloat("quantidade"));
			i.setUnidade(rs.getString("unidade"));
			i.setFornecedor(f);
			i.setDataCompra(rs.getDate("dataCompra"));
			insumos.add(i);
		}

		rs.close();
		ps.close();
		con.close();

		return insumos;
	}


}