/**
 * 
 */

function atualizarOpcoes() {
	var categoria = document.getElementById("categoria").value;
	var opcaoSelect = document.getElementById("opcao");

	// Limpa as opções existentes
	while (opcaoSelect.options.length > 0) {
		opcaoSelect.remove(0);
	}

	// Adiciona as novas opções dependendo da categoria selecionada
	if (categoria === "cliente") {
		opcaoSelect.add(new Option("Escolha Uma opção", ""));
		
		opcaoSelect.add(new Option("Todos", "Todos"));
		opcaoSelect.add(new Option("Nome", "Nome"));
		opcaoSelect.add(new Option("Tipo Cliente", "Tipo Cliente"));
		opcaoSelect.add(new Option("Localidade", "Localidade"));
		opcaoSelect.add(new Option("UF", "UF"));
		opcaoSelect.add(new Option("CEP", "CEP"));

	} else if (categoria === "produto") {
		opcaoSelect.add(new Option("Escolha Uma opção", ""));
		opcaoSelect.add(new Option("Todos", "Todos"));
		opcaoSelect.add(new Option("Código", "Código"));
		opcaoSelect.add(new Option("Nome", "Nome"));
		opcaoSelect.add(new Option("Categoria", "Categoria"));
		opcaoSelect.add(new Option("Descricao", "Descricao"));
		opcaoSelect.add(new Option("Status", "Status"));
		opcaoSelect.add(new Option("Quantidade", "Quantidade"));
		opcaoSelect.add(new Option("Ref Estoque", "Ref Estoque"));
		opcaoSelect.add(new Option("Valor Unitario Igual", "Valor Unitario Igual"));
		opcaoSelect.add(new Option("Valor Unitario Maior Que", "Valor Unitario Maior Que"));
		opcaoSelect.add(new Option("Valor Unitario Menor Que", "Valor Unitario Menor Que"));
		
	

	} else if (categoria === "equipamento") {
		opcaoSelect.add(new Option("Escolha Uma opção", ""));
		opcaoSelect.add(new Option("Todos", "Todos"));
		
		opcaoSelect.add(new Option("Código", "Código"));
		opcaoSelect.add(new Option("Nome", "nome"));
		opcaoSelect.add(new Option("Descrição", "Descricao"));
		opcaoSelect.add(new Option("Fabricante", "Fabricante"));

	} else if (categoria === "insumo") {
		opcaoSelect.add(new Option("Escolha Uma opção", ""));
		
		opcaoSelect.add(new Option("Todos", "Todos"));
		opcaoSelect.add(new Option("Nome", "Nome"));
		opcaoSelect.add(new Option("Unidade", "Unidade"));
		opcaoSelect.add(new Option("Fornecedor", "Fornecedor"));
		opcaoSelect.add(new Option("Preço Compra Igual", "Preço Compra Igual"));
		opcaoSelect.add(new Option("Preço Compra Maior Que", "Preço Compra Maior Que"));
		opcaoSelect.add(new Option("Preço Compra Menor Que", "Preço Compra Menor Que"));
		opcaoSelect.add(new Option("Preço Venda Igual", "Preço Venda Igual"));
		opcaoSelect.add(new Option("Preço Venda Maior Que", "Preço Venda Maior Que"));
		opcaoSelect.add(new Option("Preço Venda Menor Que", "Preço Venda Menor Que"));
	
	

	} else if (categoria === "fornecedor") {
		opcaoSelect.add(new Option("Escolha Uma opção", ""));
		
		opcaoSelect.add(new Option("Todos", "Todos"));
		opcaoSelect.add(new Option("Nome", "Nome"));
		opcaoSelect.add(new Option("Bairro", "Bairro"));
		opcaoSelect.add(new Option("Cidade", "Cidade"));
		opcaoSelect.add(new Option("UF", "UF"));

	} else if (categoria === "pedido") {
		opcaoSelect.add(new Option("Escolha Uma opção", ""));
		
		opcaoSelect.add(new Option("Todos", "Todos"));
		opcaoSelect.add(new Option("Cliente", "Cliente"));
		opcaoSelect.add(new Option("Estado", "Estado"));
		opcaoSelect.add(new Option("Data", "Data"));
		opcaoSelect.add(new Option("Valor Maior que", "Valor Maior que"));
		opcaoSelect.add(new Option("Valor Menor que", "Valor Menor que"));
		
	} else if (categoria === "usuario") {
		opcaoSelect.add(new Option("Escolha Uma opção", ""));

		opcaoSelect.add(new Option("CPF", "cpf"));
		opcaoSelect.add(new Option("Nome", "nome"));
	}
}


