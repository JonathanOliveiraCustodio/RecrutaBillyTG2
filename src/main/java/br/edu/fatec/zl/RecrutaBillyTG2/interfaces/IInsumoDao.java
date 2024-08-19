package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Insumo;

public interface IInsumoDao {

	public String sp_iud_Insumo(String acao, Insumo i) throws SQLException, ClassNotFoundException;
	public List<Insumo> findInsumosByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException;
	public List<Insumo> findByName(String nome) throws SQLException, ClassNotFoundException;
}
