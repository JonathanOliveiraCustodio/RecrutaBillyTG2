package br.edu.fatec.zl.RecrutaBillyTG2.model;

import java.sql.Date;

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
	float precoCompra;
	float precoVenda;
	int quantidade;
	String unidade;
	Fornecedor fornecedor;
	Date dataCompra;
	
	
	@Override
	public String toString() {
		return nome;
	}
}
