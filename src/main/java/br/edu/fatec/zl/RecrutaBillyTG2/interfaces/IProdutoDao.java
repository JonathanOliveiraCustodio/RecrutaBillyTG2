package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;

public interface IProdutoDao {
	public String sp_iud_produto(String acao, Produto p) throws SQLException, ClassNotFoundException;
	public List<Produto> findProdutosByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException;
	public List<Produto> findByName(String nome) throws SQLException, ClassNotFoundException;
}
