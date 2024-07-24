package br.edu.fatec.zl.RecrutaBillyTG2.model;

import java.time.LocalDate;

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
	private LocalDate data;
	private String tipo;
	private float valor;
	private String estado;
}
