package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import br.edu.fatec.zl.RecrutaBillyTG2.model.Fornecedor;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Insumo;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.GenericDao;

@Repository
public class InsumoDao implements ICrud<Insumo>, IInsumoDao {

	private GenericDao gDao;

	public InsumoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public String iudInsumo(String acao, Insumo i) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_iud_insumo (?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, i.getCodigo());
		cs.setString(3, i.getNome());
		cs.setFloat(4, i.getValor());
		cs.setInt(5, i.getQuantidade());
		cs.setString(6, i.getUnidade());
		cs.setInt(7, i.getFornecedor().getCodigo());
		cs.registerOutParameter(8, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(8);
		cs.close();
		c.close();

		return saida;
	}

	@Override
	public Insumo consultar(Insumo i) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT i.codigo AS codigoInsumo, f.codigo AS codigoFornecedor, f.nome AS nomeFornecedor, ");
		sql.append("i.nome AS nomeInsumo,i.valor AS valorInsumo, i.quantidade AS quantidadeInsumo, i.unidade AS unidadeInsumo ");
		sql.append("FROM insumo i INNER JOIN fornecedor f ON i.fornecedor = f.codigo  ");
		sql.append("WHERE i.codigo = ?");

		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setInt(1, i.getCodigo());

		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			Fornecedor f = new Fornecedor();
			f.setCodigo(rs.getInt("codigoFornecedor"));
			f.setNome(rs.getString("nomeFornecedor"));
			i.setCodigo(rs.getInt("codigoInsumo"));
			i.setNome(rs.getString("nomeInsumo"));
			i.setValor(rs.getFloat("valorInsumo"));
			i.setQuantidade(rs.getInt("quantidadeInsumo"));
			i.setUnidade(rs.getString("unidadeInsumo"));
			i.setFornecedor(f);

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
	public List<Insumo> listar() throws SQLException, ClassNotFoundException {

		List<Insumo> insumos = new ArrayList<>();
		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM fn_insumo_funcionario() ");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Fornecedor f = new Fornecedor();
			f.setCodigo(rs.getInt("codigoFornecedor"));
			f.setNome(rs.getString("nomeFornecedor"));
			Insumo i = new Insumo();
			i.setCodigo(rs.getInt("codigoInsumo"));
			i.setNome(rs.getString("nomeInsumo"));
			i.setValor(rs.getFloat("valorInsumo"));
			i.setQuantidade(rs.getInt("quantidadeInsumo"));
			i.setUnidade(rs.getString("unidadeInsumo"));
			i.setFornecedor(f);
			insumos.add(i);
		}
		rs.close();
		ps.close();
		c.close();
		return insumos;
	}

}