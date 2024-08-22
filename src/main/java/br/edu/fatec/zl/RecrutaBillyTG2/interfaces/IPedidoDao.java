package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Pedido;

public interface IPedidoDao {
	
	public String sp_iud_pedido(String acao, Pedido p) throws SQLException, ClassNotFoundException;
	public List<Pedido> findPedidosByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException;
	public List<Pedido> findByName(String nome) throws SQLException, ClassNotFoundException;
}
