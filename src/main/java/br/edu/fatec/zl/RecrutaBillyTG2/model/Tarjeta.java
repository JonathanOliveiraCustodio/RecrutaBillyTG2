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
public class Tarjeta {
	int codigo;
	String nome;
	CategoriaProduto categoria;
	String descricao;
	float valorProduto;
	String status;
	String refEstoque;
	int quantidade;
	Date data;
	String tamanhoTarjeta;
	String tamanhoLetra;
	String espacoEntreLinhas;
	String fardaColete;
	String formato;
	String corBordas;
	String corFundo;
	String corLetras;
	String corTipoSanguineo;
	String corFatorRH;
	NomeTarjeta nomesEmborrachados;
	
}