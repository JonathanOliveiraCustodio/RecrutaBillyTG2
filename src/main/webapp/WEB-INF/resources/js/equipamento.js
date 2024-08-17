function validarBusca() {
	var nome = document.getElementById("nome").value.trim();
	if (nome === "") {
		alert("Por favor, insira um Nome.");
		return false;
	}
	return true;
}

function editarEquipamento(codigo) {
	window.location.href = 'equipamento?cmd=alterar&codigo=' + codigo;
}

function excluirEquipamento(codigo) {
	if (codigo === "" || isNaN(codigo) || parseInt(codigo) <= 0) {
		alert("Por favor, informe um código de equipamento válido.");
		return false;
	}

	if (confirm("Tem certeza que deseja excluir este Equipamento? Esta ação não pode ser desfeita.")) {
		window.location.href = 'equipamento?cmd=excluir&codigo=' + codigo;
	}
}

function validarFormulario(event) {
	var botao = event.submitter.value;
	var campos = [
		{ id: "nome", nome: "Nome" },
		{ id: "fabricante", nome: "Fabricante" },
		{ id: "descricao", nome: "Descrição" },
		{ id: "dataAquisicao", nome: "Data de Aquisição" }
	];

	if (botao === "Cadastrar" || botao === "Alterar") {
		for (var i = 0; i < campos.length; i++) {
			var campo = document.getElementById(campos[i].id);
			if (campo && campo.value.trim() === "") {
				alert("Por favor, preencha o campo " + campos[i].nome + ".");
				campo.focus(); // Coloca o foco no campo vazio
				event.preventDefault();
				return false;
			}
		}

		var dataAquisicao = document.getElementById("dataAquisicao").value;

		if (!validarDataAquisicao(dataAquisicao)) {
			alert("Data de Aquisição inválida. Por favor, insira uma data anterior a Data de Hoje.");
			document.getElementById("dataAquisicao").focus(); // Coloca o foco no campo dataAquisicao
			event.preventDefault();
			return false;
		}
	} else if (botao === "Excluir") {
		var codigo = document.getElementById("codigo").value.trim();
		if (codigo === "" || isNaN(codigo) || parseInt(codigo) <= 0) {
			alert("Por favor, preencha o campo de código corretamente.");
			document.getElementById("codigo").focus(); // Coloca o foco no campo código
			event.preventDefault();
			return false;
		}

		// Confirmar a exclusão
		if (!confirmarExclusao()) {
			event.preventDefault(); // Cancela o envio do formulário se o usuário cancelar a exclusão
			return false;
		}
	}

	return true;
}

function validarDataAquisicao(data) {
	var hoje = new Date();
	var dataAquisicao = new Date(data);

	// Ajusta a hora para garantir que estamos comparando apenas datas
	hoje.setHours(0, 0, 0, 0);
	dataAquisicao.setHours(0, 0, 0, 0);

	return dataAquisicao < hoje; // Data deve ser menor que a Data de Hoje
}

function confirmarExclusao() {
	var codigo = document.getElementById("codigo").value.trim();
	// Verifica se o código está presente e é válido
	if (codigo === "" || isNaN(codigo) || parseInt(codigo) <= 0) {
		alert("Por favor, informe um código válido para exclusão.");
		return false; // Impede o envio do formulário
	}
	// Se o código for válido, exibe a mensagem de confirmação
	return confirm('Você realmente deseja excluir este registro? Esta ação não pode ser desfeita.');
}

