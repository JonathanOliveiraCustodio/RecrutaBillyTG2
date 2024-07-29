package br.edu.fatec.zl.RecrutaBillyTG2.model;


import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ManutencaoEquipamento{
	Equipamento equipamento;
	int codigoEquipamento;
	int codigoManutencao;
	String descricao;
    Date dataManutencao;
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return super.toString();
	}
	
 

}
