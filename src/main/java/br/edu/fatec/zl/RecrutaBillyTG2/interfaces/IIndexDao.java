package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;

public interface IIndexDao {

	public int countOrcamentos() throws SQLException, ClassNotFoundException;
	public int countPedidosAndamento() throws SQLException, ClassNotFoundException;
	public int countPedidosRecebidos() throws SQLException, ClassNotFoundException;
	public int countPedidosDespachados() throws SQLException, ClassNotFoundException;




}
