package br.edu.fatec.zl.RecrutaBillyTG2.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class NomeTarjeta {
	int codigo;	
	String nome;
	String PostoGraduacao;
	String tipoSanguineo;
	String fatorRH;
	Patente patente;
	int quantidade;
}