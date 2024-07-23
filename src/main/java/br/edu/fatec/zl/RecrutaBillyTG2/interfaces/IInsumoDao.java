package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Insumo;

public interface IInsumoDao {

	public String iudInsumo(String acao, Insumo i) throws SQLException, ClassNotFoundException;
}
