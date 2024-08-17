package br.edu.fatec.zl.RecrutaBillyTG2.interfaces;

import java.sql.SQLException;
import java.util.List;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Equipamento;

public interface IEquipamentoDao {

	public String sp_iud_equipamento(String acao, Equipamento e) throws SQLException, ClassNotFoundException;
	public List<Equipamento> findEquipamentosByOption(String opcao, String parametro) throws SQLException, ClassNotFoundException;
	public List<Equipamento> findByName(String nome) throws SQLException, ClassNotFoundException;
}
