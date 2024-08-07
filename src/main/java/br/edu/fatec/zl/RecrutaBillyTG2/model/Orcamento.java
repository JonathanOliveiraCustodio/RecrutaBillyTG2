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
public class Orcamento {
	int codigo;
	String nome;
    String descricao;
	float valorTotal;
	String status;
	Date dataOrcamento;
	String observacao;
	Cliente cliente;
}
