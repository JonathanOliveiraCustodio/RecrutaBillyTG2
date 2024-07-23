package br.edu.fatec.zl.RecrutaBillyTG2.model;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InsumoProduto{
	Insumo insumo;
	Produto produto;
	int codigoProduto;
	int codigoInsumo;
	int quantidade;
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return super.toString();
	}
	
 

}
