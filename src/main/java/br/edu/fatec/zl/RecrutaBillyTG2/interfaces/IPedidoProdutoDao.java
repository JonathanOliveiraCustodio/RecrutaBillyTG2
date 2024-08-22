package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;

import br.edu.fatec.zl.RecrutaBillyTG2.model.Pedido;
import br.edu.fatec.zl.RecrutaBillyTG2.model.PedidoProduto;

public interface IPedidoProdutoDao {
	
	public String iudPedidoProduto(String acao, PedidoProduto pp) throws SQLException, ClassNotFoundException;
	public List<PedidoProduto> findAll(Pedido p) throws SQLException, ClassNotFoundException;

}
