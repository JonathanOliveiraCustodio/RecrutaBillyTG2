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

function formatarMoeda(campo) {
	let valor = campo.value;

	valor = valor.replace(/[^\d]/g, '');
	valor = (valor / 100).toFixed(2) + '';
	valor = valor.replace(".", ",");

	valor = valor.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
	campo.value = 'R$ ' + valor;
	
	if (campo.value.endsWith(',0')) {
		campo.value = campo.value.slice(0, -1) + '00';
	}
}

document.addEventListener('DOMContentLoaded', function() {
	const campoPrecoCompra = document.getElementById('precoCompra');
	if (campoPrecoCompra) {
		formatarMoeda(campoPrecoCompra);
		campoPrecoCompra.addEventListener('input', function() {
			formatarMoeda(this);
		});
	}

	const campoPrecoVenda = document.getElementById('precoVenda'); // Substitua pelo ID do segundo campo
	if (campoPrecoVenda) {
		formatarMoeda(campoPrecoVenda);
		campoPrecoVenda.addEventListener('input', function() {
			formatarMoeda(this);
		});
	}
});
