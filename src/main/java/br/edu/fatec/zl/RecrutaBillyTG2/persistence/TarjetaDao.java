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
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.ITarjetaDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.CategoriaProduto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Tarjeta;

@Repository
public class TarjetaDao implements ICrud<Tarjeta>, ITarjetaDao {
	private GenericDao gDao;

	public TarjetaDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public Tarjeta findBy(Tarjeta t) throws SQLException, ClassNotFoundException {
		String sql = "SELECT * FROM v_tarjeta WHERE codigo = ?";
		Connection con = gDao.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, t.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			t.setCodigo(rs.getInt("codigo"));
			t.setNome(rs.getString("nome"));
			t.setDescricao(rs.getString("descricao"));
			t.setValorProduto(rs.getFloat("valorProduto"));
			t.setStatus(rs.getString("status"));
			t.setRefEstoque(rs.getString("refEstoque"));
			t.setQuantidade(rs.getInt("quantidade"));
			t.setData(rs.getDate("data"));
			t.setTamanhoTarjeta(rs.getString("tamanhoTarjeta"));
			t.setTamanhoLetra(rs.getString("tamanhoLetra"));
			t.setEspacoEntreLinhas(rs.getString("espacoEntreLinhas"));
			t.setFardaColete(rs.getString("fardaColete"));
			t.setFormato(rs.getString("formato"));
			t.setCorBordas(rs.getString("corBordas"));
			t.setCorFundo(rs.getString("corFundo"));
			t.setCorLetras(rs.getString("corLetras"));
			t.setCorTipoSanguineo(rs.getString("corTipoSanguineo"));
			t.setCorFatorRH(rs.getString("corFatorRH"));

			CategoriaProduto c = new CategoriaProduto();
			c.setCodigo(rs.getInt("categoria"));
			c.setNome(rs.getString("nomeCategoria"));
			t.setCategoria(c);

			rs.close();
			ps.close();
			con.close();
			return t;
		} else {
			rs.close();
			ps.close();
			con.close();
			return null;
		}

	}

	@Override
	public List<Tarjeta> findAll() throws SQLException, ClassNotFoundException {
		List<Tarjeta> emborrachados = new ArrayList<>();
		String sql = "SELECT * FROM v_tarjeta";
		Connection con = gDao.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Tarjeta t = new Tarjeta();
			t.setCodigo(rs.getInt("codigo"));
			t.setNome(rs.getString("nome"));
			t.setDescricao(rs.getString("descricao"));
			t.setValorProduto(rs.getFloat("valorProduto"));
			t.setStatus(rs.getString("status"));
			t.setRefEstoque(rs.getString("refEstoque"));
			t.setQuantidade(rs.getInt("quantidade"));
			t.setData(rs.getDate("data"));
			t.setTamanhoTarjeta(rs.getString("tamanhoTarjeta"));
			t.setTamanhoLetra(rs.getString("tamanhoLetra"));
			t.setEspacoEntreLinhas(rs.getString("espacoEntreLinhas"));
			t.setFardaColete(rs.getString("fardaColete"));
			t.setFormato(rs.getString("formato"));
			t.setCorBordas(rs.getString("corBordas"));
			t.setCorFundo(rs.getString("corFundo"));
			t.setCorLetras(rs.getString("corLetras"));
			t.setCorTipoSanguineo(rs.getString("corTipoSanguineo"));
			t.setCorFatorRH(rs.getString("corFatorRH"));

			CategoriaProduto c = new CategoriaProduto();
			c.setCodigo(rs.getInt("categoria"));
			c.setNome(rs.getString("nomeCategoria"));
			t.setCategoria(c);

			emborrachados.add(t);
		}
		ps.close();
		rs.close();
		con.close();
		return emborrachados;
	}

	@Override
	public String spManterTarjeta(String acao, Tarjeta t) throws SQLException, ClassNotFoundException {
		String sql = "CALL sp_iud_tarjeta(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		Connection c = gDao.getConnection();
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, t.getCodigo());
		cs.setString(3, t.getNome());
		cs.setInt(4, t.getCategoria().getCodigo());
		cs.setString(5, t.getDescricao());
		cs.setFloat(6, t.getValorProduto());
		cs.setString(7, t.getStatus());
		cs.setInt(8, t.getQuantidade());
		cs.setString(9, t.getRefEstoque());
		cs.setDate(10, t.getData());
		cs.setString(11, t.getTamanhoTarjeta());
		cs.setString(12, t.getTamanhoLetra());
		cs.setString(13, t.getEspacoEntreLinhas());
		cs.setString(14, t.getFardaColete());
		cs.setString(15, t.getFormato());
		cs.setString(16, t.getCorBordas());
		cs.setString(17, t.getCorFundo());
		cs.setString(18, t.getCorLetras());
		cs.setString(19, t.getCorTipoSanguineo());
		cs.setString(20, t.getCorFatorRH());
		cs.registerOutParameter(21, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(21);

		cs.close();
		c.close();
		return saida;
	}

	@Override
	public List<Tarjeta> findTarjetasByOption(String opcao, String parametro)
			throws SQLException, ClassNotFoundException {
		List<Tarjeta> tarjetas = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM fn_buscar_tarjeta(?,?) ");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setString(1, opcao);
		ps.setString(2, parametro);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Tarjeta t = new Tarjeta();
			t.setCodigo(rs.getInt("codigo"));
			t.setNome(rs.getString("nome"));
			t.setDescricao(rs.getString("descricao"));
			t.setValorProduto(rs.getFloat("valorProduto"));
			t.setStatus(rs.getString("status"));
			t.setRefEstoque(rs.getString("refEstoque"));
			t.setQuantidade(rs.getInt("quantidade"));
			t.setData(rs.getDate("data"));
			t.setTamanhoTarjeta(rs.getString("tamanhoTarjeta"));
			t.setTamanhoLetra(rs.getString("tamanhoLetra"));
			t.setEspacoEntreLinhas(rs.getString("espacoEntreLinhas"));
			t.setFardaColete(rs.getString("fardaColete"));
			t.setFormato(rs.getString("formato"));
			t.setCorBordas(rs.getString("corBordas"));
			t.setCorFundo(rs.getString("corFundo"));
			t.setCorLetras(rs.getString("corLetras"));
			t.setCorTipoSanguineo(rs.getString("corTipoSanguineo"));
			t.setCorFatorRH(rs.getString("corFatorRH"));

			CategoriaProduto c = new CategoriaProduto();
			c.setCodigo(rs.getInt("categoria"));
			c.setNome(rs.getString("nomeCategoria"));
			t.setCategoria(c);
			tarjetas.add(t);
		}

		rs.close();
		ps.close();
		con.close();

		return tarjetas;
	}

	@Override
	public List<Tarjeta> findByName(String nome) throws SQLException, ClassNotFoundException {
		List<Tarjeta> tarjetas = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM v_tarjeta WHERE nome LIKE ?");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		// "%" Para fazer buscas aproximadas
		ps.setString(1, "%" + nome + "%");
		// ps.setString(1, nome);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Tarjeta t = new Tarjeta();
			t.setCodigo(rs.getInt("codigo"));
			t.setNome(rs.getString("nome"));
			t.setDescricao(rs.getString("descricao"));
			t.setValorProduto(rs.getFloat("valorProduto"));
			t.setStatus(rs.getString("status"));
			t.setRefEstoque(rs.getString("refEstoque"));
			t.setQuantidade(rs.getInt("quantidade"));
			t.setData(rs.getDate("data"));
			t.setTamanhoTarjeta(rs.getString("tamanhoTarjeta"));
			t.setTamanhoLetra(rs.getString("tamanhoLetra"));
			t.setEspacoEntreLinhas(rs.getString("espacoEntreLinhas"));
			t.setFardaColete(rs.getString("fardaColete"));
			t.setFormato(rs.getString("formato"));
			t.setCorBordas(rs.getString("corBordas"));
			t.setCorFundo(rs.getString("corFundo"));
			t.setCorLetras(rs.getString("corLetras"));
			t.setCorTipoSanguineo(rs.getString("corTipoSanguineo"));
			t.setCorFatorRH(rs.getString("corFatorRH"));

			CategoriaProduto c = new CategoriaProduto();
			c.setCodigo(rs.getInt("categoria"));
			c.setNome(rs.getString("nomeCategoria"));
			t.setCategoria(c);
			tarjetas.add(t);
		}

		rs.close();
		ps.close();
		con.close();

		return tarjetas;
	}

}
