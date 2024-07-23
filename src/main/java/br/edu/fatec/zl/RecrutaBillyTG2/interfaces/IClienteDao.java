package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;

import br.edu.fatec.zl.RecrutaBillyTG2.model.Cliente;

public interface IClienteDao{
	public String iudCliente (String acao, Cliente c) throws SQLException, ClassNotFoundException;
}
