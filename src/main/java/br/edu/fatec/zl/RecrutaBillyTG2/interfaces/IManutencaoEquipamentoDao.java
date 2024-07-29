package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;

import br.edu.fatec.zl.RecrutaBillyTG2.model.ManutencaoEquipamento;

public interface IManutencaoEquipamentoDao {

	String sp_manutencaoEquipamento(String acao, ManutencaoEquipamento mp) throws SQLException, ClassNotFoundException;
	List<ManutencaoEquipamento> findAllCodigo(int codigoEquipamento) throws SQLException, ClassNotFoundException;

}
