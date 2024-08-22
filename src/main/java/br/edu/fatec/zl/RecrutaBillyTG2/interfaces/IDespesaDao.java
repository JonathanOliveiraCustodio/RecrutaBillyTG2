package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Despesa;

public interface IDespesaDao {
	public String iudDespesa (String acao, Despesa d) throws SQLException, ClassNotFoundException;
	public List<Despesa> findByName(String nome) throws SQLException, ClassNotFoundException;
}
