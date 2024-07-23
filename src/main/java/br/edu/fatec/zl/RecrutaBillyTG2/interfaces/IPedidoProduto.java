package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;

import br.edu.fatec.zl.RecrutaBillyTG2.model.Pedido;
import br.edu.fatec.zl.RecrutaBillyTG2.model.PedidoProduto;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Produto;

public interface IPedidoProduto {
	public String iudPedidoProduto(String acao, PedidoProduto pp) throws SQLException, ClassNotFoundException; 
	public List<PedidoProduto> listar(Pedido p) throws SQLException, ClassNotFoundException;
	public Produto consultar(Produto p) throws SQLException, ClassNotFoundException;
}
