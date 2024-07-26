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
	String telefone;
	String email;
	String empresa;
	String CEP;
	String logradouro;
	String numero;
	String bairro;
	String complemento;
	String cidade;
	String UF;
	
	
	
	@Override
	public String toString() {
		return nome;
	}
	
}
