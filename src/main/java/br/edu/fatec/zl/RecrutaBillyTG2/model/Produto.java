package br.edu.fatec.zl.RecrutaBillyTG2.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Produto {
	int codigo;
	String nome;
	CategoriaProduto categoria;
	String descricao;
	float valorUnitario;
	String status;
	int quantidade;
	String refEstoque;
	CategoriaProduto categoriaProduto;
}