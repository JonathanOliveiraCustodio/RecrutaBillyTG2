package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Endereco;

public interface IEnderecoDao {
	
	public String sp_iud_endereco(String acao, Endereco pp) throws SQLException, ClassNotFoundException;
	public List<Endereco> findAll(String CPF) throws SQLException, ClassNotFoundException;

}
