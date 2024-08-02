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
public class Despesa {
	private int codigo;
	private String nome;
	private Date data;
	private Date dataVencimento;
	private String tipo;
	private String pagamento;
	private float valor;
	private String estado;
}
