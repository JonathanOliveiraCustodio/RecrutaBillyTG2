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
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IOrcamentoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Cliente;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Orcamento;

@Repository
public class OrcamentoDao implements ICrud<Orcamento>, IOrcamentoDao {
	private GenericDao gDao;

	public OrcamentoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public String sp_iud_orcamento(String acao, Orcamento o) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "CALL sp_iud_orcamento(?,?,?,?,?,?,?,?,?)";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, o.getCodigo());
		cs.setString(3, o.getNome());
		cs.setString(4, o.getDescricao());
		cs.setInt(5, o.getCliente().getCodigo());
		cs.setFloat(6, o.getValorTotal());
		cs.setString(7, o.getStatus());
		cs.setString(8, o.getObservacao());
		cs.registerOutParameter(9, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(9);
		cs.close();
		c.close();
		return saida;
	}

	@Override
	public Orcamento findBy(Orcamento o) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM vw_orcamento WHERE codigo = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, o.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			o.setCodigo(rs.getInt("codigo"));
			o.setNome(rs.getString("nome"));
			o.setDescricao(rs.getString("descricao"));
			Cliente cl = new Cliente();
			cl.setCodigo(rs.getInt("codigoCliente"));
			cl.setNome(rs.getString("nomeCliente"));
			o.setCliente(cl);
			o.setValorTotal(rs.getFloat("valorTotal"));
			o.setStatus(rs.getString("status"));
			o.setObservacao(rs.getString("observacao"));
			o.setDataOrcamento(rs.getDate("dataOrcamento"));
			rs.close();
			ps.close();
			c.close();
			return o;
		} else {
			rs.close();
			ps.close();
			c.close();
			return null;
		}

	}

	@Override
	public Orcamento findByName(Orcamento o) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM vw_orcamento WHERE nome = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, o.getNome());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			o.setCodigo(rs.getInt("codigo"));
			o.setNome(rs.getString("nome"));
			o.setDescricao(rs.getString("descricao"));
			Cliente cl = new Cliente();
			cl.setCodigo(rs.getInt("codigoCliente"));
			cl.setNome(rs.getString("nomeCliente"));
			o.setCliente(cl);
			o.setValorTotal(rs.getFloat("valorTotal"));
			o.setStatus(rs.getString("status"));
			o.setObservacao(rs.getString("observacao"));
			o.setDataOrcamento(rs.getDate("dataOrcamento"));
			rs.close();
			ps.close();
			c.close();
			return o;
		} else {
			rs.close();
			ps.close();
			c.close();
			return null;
		}

	}
	@Override
	public List<Orcamento> findAll() throws SQLException, ClassNotFoundException {
		List<Orcamento> orcamentos = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM vw_orcamento";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Orcamento o = new Orcamento();
			o.setCodigo(rs.getInt("codigo"));
			o.setNome(rs.getString("nome"));
			o.setDescricao(rs.getString("descricao"));
			Cliente cl = new Cliente();
			cl.setCodigo(rs.getInt("codigoCliente"));
			cl.setNome(rs.getString("nomeCliente"));
			o.setCliente(cl);
			o.setValorTotal(rs.getFloat("valorTotal"));
			o.setStatus(rs.getString("status"));
			o.setObservacao(rs.getString("observacao"));
			o.setDataOrcamento(rs.getDate("dataOrcamento"));
			orcamentos.add(o);
		}
		rs.close();
		ps.close();
		c.close();
		return orcamentos;
	}

	@Override
	public List<Orcamento> findPedidosByOption(String opcao, String parametro)
			throws SQLException, ClassNotFoundException {
		List<Orcamento> orcamentos = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM fn_buscar_pedido(?,?)");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setString(1, opcao);
		ps.setString(2, parametro);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Orcamento o = new Orcamento();
			o.setCodigo(rs.getInt("codigo"));
			o.setNome(rs.getString("nomePedido"));

			Cliente cl = new Cliente();
			cl.setCodigo(rs.getInt("codigoCliente"));
			cl.setNome(rs.getString("nomeCliente"));
			o.setCliente(cl);

			o.setDescricao(rs.getString("descricao"));
			o.setStatus(rs.getString("estado"));
			o.setDataOrcamento(rs.getDate("dataPedido"));
			o.setObservacao(rs.getString("observacao"));
			o.setValorTotal(rs.getFloat("valorTotal"));
			orcamentos.add(o);
		}

		rs.close();
		ps.close();
		con.close();

		return orcamentos;
	}

	public String sp_orcamento_pedido(Orcamento o) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "CALL sp_orcamento_pedido(?,?)";
		CallableStatement cs = c.prepareCall(sql);
		cs.setInt(1, o.getCodigo());
		cs.registerOutParameter(2, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(2);
		cs.close();
		c.close();
		return saida;
	}

}