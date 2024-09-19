package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;

import br.edu.fatec.zl.RecrutaBillyTG2.model.Orcamento;
import br.edu.fatec.zl.RecrutaBillyTG2.model.ProdutoOrcamento;

public interface IProdutoOrcamentoDao {
	public String iudProdutoOrcamento(String acao, ProdutoOrcamento po) throws SQLException, ClassNotFoundException;
	public List<ProdutoOrcamento> findAll(Orcamento o) throws SQLException, ClassNotFoundException;	
}
