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
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IClienteDao;
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.ICrud;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Cliente;

@Repository
public class ClienteDao implements ICrud<Cliente>, IClienteDao {
	private GenericDao gDao;

	public ClienteDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public Cliente findBy(Cliente cl) throws SQLException, ClassNotFoundException {
		String sql = "SELECT * FROM cliente WHERE codigo = ?";
		Connection c = gDao.getConnection();
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, cl.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			cl.setCodigo(rs.getInt("codigo"));
			cl.setNome(rs.getString("nome"));
			cl.setTelefone(rs.getString("telefone"));
			cl.setEmail(rs.getString("email"));
			cl.setTipo(rs.getString("tipo"));
			cl.setDocumento(rs.getString("documento"));
			cl.setCEP(rs.getString("CEP"));
			cl.setLogradouro(rs.getString("logradouro"));
			cl.setBairro(rs.getString("bairro"));
			cl.setLocalidade(rs.getString("localidade"));
			cl.setUF(rs.getString("UF"));
			cl.setComplemento(rs.getString("complemento"));
			cl.setNumero(rs.getString("numero"));
			cl.setDataNascimento(rs.getDate("dataNascimento"));
			rs.close();
			ps.close();
			c.close();
			return cl;
		} else {
			rs.close();
			ps.close();
			c.close();
			return null;
		}

	}

	@Override
	public List<Cliente> findAll() throws SQLException, ClassNotFoundException {
		List<Cliente> clientes = new ArrayList<>();
		String sql = "SELECT * FROM cliente";
		Connection c = gDao.getConnection();
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Cliente cl = new Cliente();
			cl.setCodigo(rs.getInt("codigo"));
			cl.setNome(rs.getString("nome"));
			cl.setTelefone(rs.getString("telefone"));
			cl.setEmail(rs.getString("email"));
			cl.setTipo(rs.getString("tipo"));
			cl.setDocumento(rs.getString("documento"));			
			cl.setCEP(rs.getString("CEP"));
			cl.setLogradouro(rs.getString("logradouro"));
			cl.setBairro(rs.getString("bairro"));
			cl.setLocalidade(rs.getString("localidade"));
			cl.setUF(rs.getString("UF"));
			cl.setComplemento(rs.getString("complemento"));
			cl.setNumero(rs.getString("numero"));	
			cl.setDataNascimento(rs.getDate("dataNascimento"));
			clientes.add(cl);
		}
		ps.close();
		rs.close();
		c.close();
		return clientes;
	}

	@Override
	public String sp_iud_cliente(String acao, Cliente cl) throws SQLException, ClassNotFoundException {
		String sql = "CALL sp_iud_cliente(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		Connection c = gDao.getConnection();
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, cl.getCodigo());
		cs.setString(3, cl.getNome());
		cs.setString(4, cl.getTelefone());
		cs.setString(5, cl.getEmail());
		cs.setString(6, cl.getTipo());
		cs.setString(7, cl.getDocumento());
		cs.setString(8, cl.getCEP());
		cs.setString(9, cl.getLogradouro());
		cs.setString(10, cl.getBairro());
		cs.setString(11, cl.getLocalidade());
		cs.setString(12, cl.getUF());
		cs.setString(13, cl.getComplemento());
		cs.setString(14, cl.getNumero());	
		cs.setDate(15, cl.getDataNascimento());
		cs.registerOutParameter(16, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(16);

		cs.close();
		c.close();
		return saida;
	}
	
	@Override
	public List<Cliente> findClientesByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException {
		List<Cliente> clientes = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM fn_buscar_cliente(?,?) ");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setString(1, opcao);
		ps.setString(2, parametro);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Cliente cl = new Cliente();
			cl.setCodigo(rs.getInt("codigo"));
			cl.setNome(rs.getString("nome"));
			cl.setTelefone(rs.getString("telefone"));
			cl.setEmail(rs.getString("email"));
			cl.setTipo(rs.getString("tipo"));
			cl.setDocumento(rs.getString("documento"));			
			cl.setCEP(rs.getString("CEP"));
			cl.setLogradouro(rs.getString("logradouro"));
			cl.setBairro(rs.getString("bairro"));
			cl.setLocalidade(rs.getString("localidade"));
			cl.setUF(rs.getString("UF"));
			cl.setComplemento(rs.getString("complemento"));
			cl.setNumero(rs.getString("numero"));	
			cl.setDataNascimento(rs.getDate("dataNascimento"));
			clientes.add(cl);
		}

		rs.close();
		ps.close();
		con.close();

		return clientes;
	}

	
}
