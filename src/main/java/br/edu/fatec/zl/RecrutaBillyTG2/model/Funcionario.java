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
public class Funcionario {
	String CPF;
	String nome;
	String email;
	String senha;
	String nivelAcesso;
	Date dataNascimento;
	String telefone;
	String cargo;
	String horario;
	float salario;
	Date dataAdmissao;
	Date dataDesligamento;
	String observacao;
}
