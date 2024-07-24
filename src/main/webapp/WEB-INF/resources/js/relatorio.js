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
			opcaoSelect.add(new Option("Todos", "Todos"));
			opcaoSelect.add(new Option("Nome", "Nome"));
			opcaoSelect.add(new Option("Tipo", "tipo"));
			opcaoSelect.add(new Option("Localidade", "Localidade"));
			opcaoSelect.add(new Option("UF", "UF"));
			opcaoSelect.add(new Option("CEP", "CEP"));
			
		} else if (categoria === "produto") {
			opcaoSelect.add(new Option("Código", "codigo"));
			opcaoSelect.add(new Option("Nome", "nome"));
			
		} else if (categoria === "equipamento") {
			opcaoSelect.add(new Option("Código", "codigo"));
			opcaoSelect.add(new Option("Nome", "nome"));
			
		} else if (categoria === "insumo") {
			opcaoSelect.add(new Option("Código", "codigo"));
			opcaoSelect.add(new Option("Nome", "nome"));
			
		} else if (categoria === "fornecedor") {
			opcaoSelect.add(new Option("Nome", "Nome"));
			opcaoSelect.add(new Option("Empresa", "Empresa"));
			
		} else if (categoria === "pedido") {

			opcaoSelect.add(new Option("Código", "codigo"));
			opcaoSelect.add(new Option("Nome", "nome"));
		} else if (categoria === "usuario") {

			opcaoSelect.add(new Option("CPF", "cpf"));
			opcaoSelect.add(new Option("Nome", "nome"));
		}
	}