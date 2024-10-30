package br.edu.fatec.zl.RecrutaBillyTG2.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Patente {
	int codigo;
	String nome;
	String instituicao;
	
	@Override
	public String toString() {
		return nome;
	}
}
