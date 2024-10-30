package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Patente;

public interface IPatenteDao {
	public String sp_iud_patente(String acao, Patente p) throws SQLException, ClassNotFoundException;
	public List<Patente> findPatenteByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException;
	public List<Patente> findByName(String nome) throws SQLException, ClassNotFoundException;
}
