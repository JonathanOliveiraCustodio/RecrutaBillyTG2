package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Orcamento;


public interface IOrcamentoDao {
	
	public String sp_iud_orcamento(String acao, Orcamento o) throws SQLException, ClassNotFoundException;
	public List<Orcamento> findPedidosByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException;
	public Orcamento findByName(Orcamento o) throws SQLException, ClassNotFoundException;
}
