package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Fornecedor;

public interface IFornecedorDao {

	public String sp_iud_fornecedor(String acao, Fornecedor f) throws SQLException, ClassNotFoundException;
	public List<Fornecedor> findFornecedoresByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException;
	public List<Fornecedor> findByName(String nome) throws SQLException, ClassNotFoundException;
}
