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
public class Pedido {
	int codigo;
	String nome;
    String descricao;
	float valorTotal;
	String estado;
	Date dataPedido;
	String tipoPagamento;
	String observacao;
	Date dataPagamento;
	String statusPagamento;
	Cliente cliente;
}
