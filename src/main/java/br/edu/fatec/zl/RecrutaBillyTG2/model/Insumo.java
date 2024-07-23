package br.edu.fatec.zl.RecrutaBillyTG2.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Insumo {
	int codigo;
	String nome;
	float valor;
	int quantidade;
	String unidade;
	Fornecedor fornecedor;
	
	
	@Override
	public String toString() {
		return nome;
	}
}
