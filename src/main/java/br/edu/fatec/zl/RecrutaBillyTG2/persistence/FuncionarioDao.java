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
import br.edu.fatec.zl.RecrutaBillyTG2.interfaces.IFuncionarioDao;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Funcionario;

@Repository
public class FuncionarioDao implements ICrud<Funcionario>, IFuncionarioDao {
	private GenericDao gDao;

	public FuncionarioDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public Funcionario findBy(Funcionario f) throws SQLException, ClassNotFoundException {
		String sql = "SELECT * FROM fn_listar_funcionario_cpf(?)";
		Connection c = gDao.getConnection();
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, f.getCPF());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			f.setCPF(rs.getString("CPF"));
			f.setNome(rs.getString("nome"));
			f.setNivelAcesso(rs.getString("nivelAcesso"));
			f.setEmail(rs.getString("email"));
			f.setSenha(rs.getString("senha"));
			f.setDataNascimento(rs.getDate("dataNascimento"));
			f.setTelefone(rs.getString("telefone"));
			f.setCargo(rs.getString("cargo"));
			f.setHorario(rs.getString("horario"));
			f.setSalario(rs.getFloat("salario"));
			f.setDataAdmissao(rs.getDate("dataAdmissao"));
			f.setDataDesligamento(rs.getDate("dataDesligamento"));
			f.setObservacao(rs.getString("observacao"));
			
			rs.close();
			ps.close();
			c.close();
			return f;
		} else {
			rs.close();
			ps.close();
			c.close();
			return null;
		}

	}

	@Override
	public List<Funcionario> findAll() throws SQLException, ClassNotFoundException {
		List<Funcionario> funcionarios = new ArrayList<>();
		String sql = "SELECT * FROM v_funcionario";
		Connection c = gDao.getConnection();
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Funcionario f = new Funcionario();
			f.setCPF(rs.getString("CPF"));
			f.setNome(rs.getString("nome"));
			f.setNivelAcesso(rs.getString("nivelAcesso"));
			f.setSenha(rs.getString("senha"));
			f.setEmail(rs.getString("email"));
			f.setDataNascimento(rs.getDate("dataNascimento"));
			f.setTelefone(rs.getString("telefone"));
			f.setCargo(rs.getString("cargo"));
			f.setHorario(rs.getString("horario"));
			f.setSalario(rs.getFloat("salario"));
			f.setDataAdmissao(rs.getDate("dataAdmissao"));
			f.setDataDesligamento(rs.getDate("dataDesligamento"));
			f.setObservacao(rs.getString("observacao"));
			funcionarios.add(f);
		}
		ps.close();
		rs.close();
		c.close();
		return funcionarios;
	}

	// @Override
	public String sp_iud_funcionario(String acao, Funcionario f) throws SQLException, ClassNotFoundException {
		String sql = "CALL sp_iud_funcionario(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		Connection c = gDao.getConnection();
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setString(2, f.getCPF());
		cs.setString(3, f.getNome());
		cs.setString(4, f.getNivelAcesso());
		cs.setString(5, f.getSenha());
		cs.setString(6, f.getEmail());	
		cs.setDate(7, f.getDataNascimento());
		cs.setString(8, f.getTelefone());
		cs.setString(9, f.getCargo());
		cs.setString(10, f.getHorario());
		cs.setFloat(11, f.getSalario());
		cs.setDate(12, f.getDataAdmissao());
		cs.setDate(13, f.getDataDesligamento());
		cs.setString(14, f.getObservacao());

		cs.registerOutParameter(15, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(15);

		cs.close();
		c.close();
		return saida;
	}
	
	@Override
	public List<Funcionario> findFuncionariosByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException {
		List<Funcionario> funcionarios = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM fn_buscar_funcionario(?,?) ");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setString(1, opcao);
		ps.setString(2, parametro);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {	
			Funcionario f = new Funcionario();
			f.setCPF(rs.getString("CPF"));
			f.setNome(rs.getString("nome"));
			f.setNivelAcesso(rs.getString("nivelAcesso"));
			f.setSenha(rs.getString("senha"));
			f.setEmail(rs.getString("email"));
			f.setDataNascimento(rs.getDate("dataNascimento"));
			f.setTelefone(rs.getString("telefone"));
			f.setCargo(rs.getString("cargo"));
			f.setHorario(rs.getString("horario"));
			f.setSalario(rs.getFloat("salario"));
			f.setDataAdmissao(rs.getDate("dataAdmissao"));
			f.setDataDesligamento(rs.getDate("dataDesligamento"));
			f.setObservacao(rs.getString("observacao"));
			funcionarios.add(f);
		
		}

		rs.close();
		ps.close();
		con.close();

		return funcionarios;
	}

	@Override
	public List<Funcionario> findByName(String nome) throws SQLException, ClassNotFoundException {
		List<Funcionario> funcionarios = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM v_funcionario WHERE nome LIKE ?");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		// "%" Para fazer buscas aproximadas
		ps.setString(1, "%" + nome + "%");
		//ps.setString(1, nome);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {	
			Funcionario f = new Funcionario();
			f.setCPF(rs.getString("CPF"));
			f.setNome(rs.getString("nome"));
			f.setNivelAcesso(rs.getString("nivelAcesso"));
			f.setSenha(rs.getString("senha"));
			f.setEmail(rs.getString("email"));
			f.setDataNascimento(rs.getDate("dataNascimento"));
			f.setTelefone(rs.getString("telefone"));
			f.setCargo(rs.getString("cargo"));
			f.setHorario(rs.getString("horario"));
			f.setSalario(rs.getFloat("salario"));
			f.setDataAdmissao(rs.getDate("dataAdmissao"));
			f.setDataDesligamento(rs.getDate("dataDesligamento"));
			f.setObservacao(rs.getString("observacao"));
			funcionarios.add(f);
		
		}

		rs.close();
		ps.close();
		con.close();

		return funcionarios;
	}
}
