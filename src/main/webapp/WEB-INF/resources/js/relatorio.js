function atualizarOpcoes() {
	var categoria = document.getElementById("categoria").value;
	var opcaoSelect = document.getElementById("opcao");

	// Captura o valor atualmente selecionado, se houver
	var opcaoSelecionada = opcaoSelect.value;

	// Salva a categoria e a opção selecionada nos campos ocultos
	document.getElementById("categoriaSelecionada").value = categoria;
	document.getElementById("opcaoSelecionada").value = opcaoSelecionada;

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
		opcaoSelect.add(new Option("Último Mês", "Último Mês"));
		opcaoSelect.add(new Option("Último Semana", "Último Semana"));
		opcaoSelect.add(new Option("Janeiro", "Janeiro"));
		opcaoSelect.add(new Option("Fevereiro", "Fevereiro"));
		opcaoSelect.add(new Option("Março", "Março"));
		opcaoSelect.add(new Option("Abril", "Abril"));
		opcaoSelect.add(new Option("Maio", "Maio"));
		opcaoSelect.add(new Option("Junho", "Junho"));
		opcaoSelect.add(new Option("Julho", "Julho"));
		opcaoSelect.add(new Option("Agosto", "Agosto"));
		opcaoSelect.add(new Option("Setembro", "Setembro"));
		opcaoSelect.add(new Option("Outubro", "Outubro"));
		opcaoSelect.add(new Option("Novembro", "Novembro"));
		opcaoSelect.add(new Option("Dezembro", "Dezembro"));
		

	} else if (categoria === "funcionario") {
		opcaoSelect.add(new Option("Escolha Uma opção", ""));
		opcaoSelect.add(new Option("Todos", "Todos"));
		opcaoSelect.add(new Option("Cargo", "cargo"));
		opcaoSelect.add(new Option("CPF", "nivelAcesso"));
		opcaoSelect.add(new Option("Nome", "nome"));
		opcaoSelect.add(new Option("Horário", "horario"));
		opcaoSelect.add(new Option("Salário Igual", "salario igual"));
		opcaoSelect.add(new Option("Salário Maior Que", "salario maior que"));
		opcaoSelect.add(new Option("Salário Menor Que", "salario menor que"));

	} else if (categoria === "orcamento") {
		opcaoSelect.add(new Option("Escolha Uma opção", ""));
		opcaoSelect.add(new Option("Todos", "Todos"));
		opcaoSelect.add(new Option("Cliente", "cliente"));
		opcaoSelect.add(new Option("Data Orçamento", "dataOrcamento"));
		opcaoSelect.add(new Option("Descrição", "descricao"));
		opcaoSelect.add(new Option("Forma de Pagamento", "formaPagamento"));
		opcaoSelect.add(new Option("Nome", "nome"));
		opcaoSelect.add(new Option("Status", "status"));
		opcaoSelect.add(new Option("Valor Total Igual", "valorTotal igual"));
		opcaoSelect.add(new Option("Valor Total Maior Que", "valorTotal maior que"));
		opcaoSelect.add(new Option("Valor Total Menor Que", "valorTotal menor que"));
	}

	else if (categoria === "despesa") {
		opcaoSelect.add(new Option("Escolha Uma opção", ""));
		opcaoSelect.add(new Option("Todos", "Todos"));
		opcaoSelect.add(new Option("Tipo", "tipo"));
		opcaoSelect.add(new Option("Pagamento", "pagamento"));
		opcaoSelect.add(new Option("Data", "dataInicio"));
		opcaoSelect.add(new Option("Data Vencimento", "dataVencimento"));
		opcaoSelect.add(new Option("Estado", "estado"));
		opcaoSelect.add(new Option("Nome", "nome"));
		opcaoSelect.add(new Option("Valor Igual", "valor igual"));
		opcaoSelect.add(new Option("Valor Maior Que", "valor maior que"));
		opcaoSelect.add(new Option("Valor Menor Que", "valor menor que"));
	}

	// Restaura a opção selecionada, se ainda estiver disponível
	for (var i = 0; i < opcaoSelect.options.length; i++) {
		if (opcaoSelect.options[i].value === opcaoSelecionada) {
			opcaoSelect.options[i].selected = true;
			break;
		}
	}
}

function gerarRelatorioPDF() {
	var categoria = document.getElementById("categoria").value;

	// Verificar se a categoria está selecionada
	if (!categoria) {
		alert("Por favor, selecione uma categoria.");
		return; // Impede o envio do formulário
	}

	const form = document.getElementById("form-relatorio");
	form.action = "relatorioCategoria";
	form.method = "post";
	form.target = "_blank";
	form.submit();
}

function resetarFormulario() {
	const form = document.getElementById("form-relatorio");
	form.action = "relatorio";
	form.method = "post";
	form.target = "_self";
}

document.addEventListener('DOMContentLoaded', function() {
	// Restaura a categoria e a opção selecionada
	var categoria = document.getElementById("categoriaSelecionada").value;
	var opcao = document.getElementById("opcaoSelecionada").value;

	if (categoria) {
		document.getElementById("categoria").value = categoria;
		atualizarOpcoes();
		document.getElementById("opcao").value = opcao;
	}
});