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
public class Cliente {
	int codigo;
	String nome;
	String email;
	String telefone;
	String tipo;
	String documento;
	String CEP;
	String logradouro;
	String bairro;
	String localidade;
	String UF;
	String complemento;
	String numero;
	Date dataNascimento;
}
