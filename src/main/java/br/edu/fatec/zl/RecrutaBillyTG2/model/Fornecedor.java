package br.edu.fatec.zl.RecrutaBillyTG2.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Fornecedor {
	int codigo;
	String nome;
	String endereco;
	String telefone;
	String email;
	String empresa;
	
	@Override
	public String toString() {
		return nome;
	}
	
}
