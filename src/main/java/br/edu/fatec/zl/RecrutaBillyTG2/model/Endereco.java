package br.edu.fatec.zl.RecrutaBillyTG2.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Endereco {
	int codigo;
	String CEP;
	String logradouro;
	String bairro;
	String localidade;
	String UF;
	String complemento;
	String numero;
	String tipoEndereco;
	Funcionario funcionario;
}
