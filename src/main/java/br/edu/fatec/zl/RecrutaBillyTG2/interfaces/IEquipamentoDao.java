package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;

import br.edu.fatec.zl.RecrutaBillyTG2.model.Equipamento;

public interface IEquipamentoDao {

	public String iudEquipamento(String acao, Equipamento e) throws SQLException, ClassNotFoundException;

}
