package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;

import br.edu.fatec.zl.RecrutaBillyTG2.model.Equipamento;

public interface IEquipamentoDao {

	public String sp_iud_equipamento(String acao, Equipamento e) throws SQLException, ClassNotFoundException;

}
