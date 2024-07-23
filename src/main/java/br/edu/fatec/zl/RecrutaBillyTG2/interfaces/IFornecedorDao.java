package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;

import br.edu.fatec.zl.RecrutaBillyTG2.model.Fornecedor;

public interface IFornecedorDao {

	public String iudFornecedor(String acao, Fornecedor f) throws SQLException, ClassNotFoundException;

}
