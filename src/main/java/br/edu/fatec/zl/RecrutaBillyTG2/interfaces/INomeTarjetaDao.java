package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;
import br.edu.fatec.zl.RecrutaBillyTG2.model.NomeTarjeta;

public interface INomeTarjetaDao{
	
	public String spManterNomeTarjeta(String acao, NomeTarjeta nt) throws SQLException, ClassNotFoundException;
	public List<NomeTarjeta> findNomeTarjetaByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException;
	public List<NomeTarjeta> findByName(String nome) throws SQLException, ClassNotFoundException;

}
