package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;

public interface IIndexDao {

	public int countOrcamentos() throws SQLException, ClassNotFoundException;
	public int countPedidosAndamento() throws SQLException, ClassNotFoundException;
	public int countPedidosRecebidos() throws SQLException, ClassNotFoundException;
	public int countPedidosDespachados() throws SQLException, ClassNotFoundException;
	public int countProdutosEstoqueBaixo(int minEstoque) throws SQLException, ClassNotFoundException;
	public int countProdutosProducao() throws SQLException, ClassNotFoundException;
	public int countDespesasPendentes() throws SQLException, ClassNotFoundException;
	public int countDespesasVencidas() throws SQLException, ClassNotFoundException;
	public float countValorTotalDespesasMes() throws SQLException, ClassNotFoundException;

}
