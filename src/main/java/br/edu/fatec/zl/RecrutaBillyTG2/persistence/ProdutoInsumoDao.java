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
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IProdutoInsumoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Insumo;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.InsumoProduto;

@Repository
public class ProdutoInsumoDao implements ICrud<InsumoProduto>, IProdutoInsumoDao {

	private GenericDao gDao;

	public ProdutoInsumoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	public InsumoProduto consultar(InsumoProduto t) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT a.CPF AS cpfAluno, a.nome AS nomeAluno, t.numero, t.tipo ");
		sql.append("FROM aluno a ");
		sql.append("JOIN telefone t ON a.CPF = t.aluno ");
		sql.append("WHERE a.CPF = ? AND t.numero = ?");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		// ps.setInt(1, t.getProduto().getCodigo());
		// ps.setInt(2, t.getInsumo().getCodigo());
		ResultSet rs = ps.executeQuery();

		if (rs.next()) {
			Produto p = new Produto();
			p.setCodigo(rs.getInt("codigoProduto"));
			p.setNome(rs.getString("nomeProduto"));

			Insumo i = new Insumo();
			i.setCodigo(rs.getInt("codigoInsumo"));
			i.setNome(rs.getString("nomeInsumo"));

			InsumoProduto insumo = new InsumoProduto();
			// insumo.setProduto(p);
			// insumo.setInsumo(i);

			rs.close();
			ps.close();
			con.close();
			return insumo;
		} else {
			rs.close();
			ps.close();
			con.close();
			return null;
		}
	}

	// @Override
	public List<InsumoProduto> listarCodigo(int codigoProduto) throws SQLException, ClassNotFoundException {
		List<InsumoProduto> insumos = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM fn_listar_insumos_produto(?)");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setInt(1, codigoProduto);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			InsumoProduto pi = new InsumoProduto();

			Produto p = new Produto();
			p.setCodigo(rs.getInt("codigoProduto"));
			p.setNome(rs.getString("nomeProduto"));

			Insumo i = new Insumo();
			i.setCodigo(rs.getInt("codigoInsumo"));
			i.setNome(rs.getString("nomeInsumo"));
			i.setUnidade(rs.getString("unidadeInsumo"));
			

			pi.setCodigoInsumo(rs.getInt("codigoInsumo"));
			pi.setCodigoProduto(rs.getInt("codigoProduto"));
			pi.setQuantidade(rs.getInt("quantidade"));
			pi.setInsumo(i);
			insumos.add(pi);
		}

		rs.close();
		ps.close();
		con.close();

		return insumos;
	}

	@Override
	public String iudProdutoInsumo(String acao, InsumoProduto pi, Insumo i)
			throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_iud_insumosProduto (?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, pi.getCodigoProduto());
		cs.setInt(3, pi.getCodigoInsumo());
		cs.setInt(4, pi.getQuantidade());
		cs.registerOutParameter(5, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(5);
		cs.close();
		c.close();

		return saida;
	}

	@Override
	public List<InsumoProduto> listar() throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}

}
