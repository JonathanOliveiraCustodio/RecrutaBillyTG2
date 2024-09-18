package br.edu.fatec.zl.RecrutaBillyTG2.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CategoriaProduto {
	int codigo;
	String nome;
	
	@Override
	public String toString() {
		return nome;
	}
}
