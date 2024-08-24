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
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IEnderecoDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Endereco;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Funcionario;

@Repository
public class EnderecoDao implements ICrud<Endereco>, IEnderecoDao {
	private GenericDao gDao;

	public EnderecoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public String sp_iud_endereco(String acao, Endereco e) throws SQLException, ClassNotFoundException {
		String sql = "CALL sp_iud_endereco(?,?,?,?,?,?,?,?,?,?,?,?)";
		Connection c = gDao.getConnection();
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, e.getCodigo());
		cs.setString(3, e.getFuncionario().getCPF());
		cs.setString(4, e.getCEP());
		cs.setString(5, e.getLogradouro());
		cs.setString(6, e.getBairro());
		cs.setString(7, e.getLocalidade());
		cs.setString(8, e.getUF());
		cs.setString(9, e.getComplemento());
		cs.setString(10, e.getNumero());
		cs.setString(11, e.getTipoEndereco());
		cs.registerOutParameter(12, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(12);

		cs.close();
		c.close();
		return saida;
	}

	@Override
	public List<Endereco> findAll(String CPF) throws SQLException, ClassNotFoundException {
		List<Endereco> enderecos = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM vw_endereco_funcionario WHERE CPF = ?");
		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setString(1, CPF);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Endereco e = new Endereco();
			e.setCodigo(rs.getInt("codigo"));
			Funcionario f = new Funcionario();
			f.setCPF(rs.getString("CPF"));
			f.setNome(rs.getString("nomeFuncionario"));
			e.setFuncionario(f);
			e.setCEP(rs.getString("CEP"));
			e.setLogradouro(rs.getString("logradouro"));
			e.setBairro(rs.getString("bairro"));
			e.setLocalidade(rs.getString("localidade"));
			e.setUF(rs.getString("UF"));
			e.setComplemento(rs.getString("complemento"));
			e.setNumero(rs.getString("numero"));
			e.setTipoEndereco(rs.getString("tipoEndereco"));

			enderecos.add(e);
		}
		ps.close();
		rs.close();
		con.close();
		return enderecos;
	}

	@Override
	public Endereco findBy(Endereco e) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM fn_consultar_endereco(?,?)";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, e.getCodigo());
		ps.setString(2, e.getFuncionario().getCPF());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			e.setCodigo(rs.getInt("codigo"));
			Funcionario f = new Funcionario();
			f.setCPF(rs.getString("CPF"));
			f.setNome(rs.getString("nomeFuncionario"));
			e.setFuncionario(f);
			e.setCEP(rs.getString("CEP"));
			e.setLogradouro(rs.getString("logradouro"));
			e.setBairro(rs.getString("bairro"));
			e.setLocalidade(rs.getString("localidade"));
			e.setUF(rs.getString("UF"));
			e.setComplemento(rs.getString("complemento"));
			e.setNumero(rs.getString("numero"));
			e.setTipoEndereco(rs.getString("tipoEndereco"));
			rs.close();
			ps.close();
			c.close();
			return e;
		} else {
			rs.close();
			ps.close();
			c.close();
			return null;
		}
	}

	@Override
	public List<Endereco> findAll() throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}

}
