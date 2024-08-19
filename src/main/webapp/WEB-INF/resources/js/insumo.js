// insumo.js

function consultarInsumo(codigo) {
	window.location.href = 'consulta?codigo=' + codigo;
}

function editarInsumo(codigo) {
	window.location.href = 'insumo?cmd=alterar&codigo=' + codigo;
}

function excluirInsumo(codigo) {
	if (confirm("Tem certeza que deseja excluir este insumo?")) {
		window.location.href = 'insumo?cmd=excluir&codigo=' + codigo;
	}
}

function validarBusca() {
	var codigo = document.getElementById("nome").value;
	if (codigo.trim() === "") {
		alert("Por favor, insira um Nome.");
		return false;
	}
	return true;
}
function validarFormulario(event) {
	var botao = event.submitter ? event.submitter.value : null;
	var campos = [
		{ id: "nome", nome: "Nome" },
		{ id: "precoCompra", nome: "Preço de Compra" },
		{ id: "precoVenda", nome: "Preço de Venda" },
		{ id: "quantidade", nome: "Quantidade" },
		{ id: "unidade", nome: "Unidade" },
		{ id: "fornecedor", nome: "Fornecedor" },
		{ id: "dataCompra", nome: "Data de Compra" }
	];

	if (botao === "Cadastrar" || botao === "Alterar") {
		for (var i = 0; i < campos.length; i++) {
			var campo = document.getElementById(campos[i].id);
			if (campo) {
				if (campo.value.trim() === "" || (campo.id === "fornecedor" && campo.value === "0")) {
					alert("Por favor, preencha o campo " + campos[i].nome + ".");
					campo.focus(); // Coloca o foco no campo vazio
					event.preventDefault();
					return false;
				}
			}
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
		if (!confirm('Você realmente deseja excluir este registro? Esta ação não pode ser desfeita.')) {
			event.preventDefault(); // Cancela o envio do formulário se o usuário cancelar a exclusão
			return false;
		}
	}
	return true;
}
