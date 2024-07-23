package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Insumo;
import br.edu.fatec.zl.RecrutaBillyTG2.model.InsumoProduto;

public interface IProdutoInsumoDao {

	String iudProdutoInsumo(String acao, InsumoProduto pi, Insumo i) throws SQLException, ClassNotFoundException;


}
