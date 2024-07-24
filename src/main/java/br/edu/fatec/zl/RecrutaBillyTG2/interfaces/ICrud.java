package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;

public interface ICrud<T> {
	
	public T findBy(T t) throws SQLException, ClassNotFoundException;
	public List<T> findAll() throws SQLException, ClassNotFoundException;
}
