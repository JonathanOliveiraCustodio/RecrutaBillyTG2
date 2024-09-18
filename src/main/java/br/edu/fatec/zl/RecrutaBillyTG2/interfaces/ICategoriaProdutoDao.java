package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;
import br.edu.fatec.zl.RecrutaBillyTG2.model.CategoriaProduto;


public interface ICategoriaProdutoDao {
	public String sp_iud_categoria_produto(String acao, CategoriaProduto p) throws SQLException, ClassNotFoundException;
	public List<CategoriaProduto> findPedidosByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException;
	public List<CategoriaProduto> findByName(String nome) throws SQLException, ClassNotFoundException;
}
