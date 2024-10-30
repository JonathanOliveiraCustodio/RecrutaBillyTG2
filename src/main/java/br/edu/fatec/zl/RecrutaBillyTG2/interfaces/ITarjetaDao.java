package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Tarjeta;

public interface ITarjetaDao{
	
	public String spManterTarjeta(String acao, Tarjeta t) throws SQLException, ClassNotFoundException;
	public List<Tarjeta> findTarjetasByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException;
	public List<Tarjeta> findByName(String nome) throws SQLException, ClassNotFoundException;

}
