package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Funcionario;

public interface IFuncionarioDao {

	public String sp_iud_funcionario (String acao, Funcionario f) throws SQLException, ClassNotFoundException;
	public List<Funcionario> findFuncionariosByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException;

}
