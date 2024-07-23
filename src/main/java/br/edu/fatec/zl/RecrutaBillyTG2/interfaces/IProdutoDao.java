package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;

import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;

public interface IProdutoDao {

	public String iudProduto(String acao, Produto p) throws SQLException, ClassNotFoundException;

}
