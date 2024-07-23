package br.edu.fatec.zl.RecrutaBillyTG2.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class PedidoProduto {
	Produto produto;
	int codigoPedido;
	int codigoProduto;
	int quantidade;
}
