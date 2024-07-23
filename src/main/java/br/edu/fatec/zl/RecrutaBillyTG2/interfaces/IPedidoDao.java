package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Pedido;

public interface IPedidoDao {
	public String iudPedido(String acao, Pedido p) throws SQLException, ClassNotFoundException;
}
