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

function validarDataCompra(dataCompra) {
	var hoje = new Date();
	var compra = new Date(dataCompra);

	// Zera as horas, minutos e segundos de ambas as datas para comparar apenas as datas
	hoje.setHours(0, 0, 0, 0);
	compra.setHours(0, 0, 0, 0);

	// A data de aquisição deve ser anterior ao dia de hoje
	return compra < hoje;
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

	var dataCompra = document.getElementById("dataCompra").value;
	
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
				// Validação para preço de compra e preço de venda
				if ((campo.id === "precoCompra" || campo.id === "precoVenda") && parseFloat(campo.value.replace(/[^\d,]/g, '').replace(",", ".")) <= 0) {
					alert("O campo " + campos[i].nome + " deve ser maior que R$ 0,00.");
					campo.focus();
					event.preventDefault();
					return false;
				}
			}
		}
		// Validação da data de aquisição
		if (!validarDataCompra(dataCompra)) {
			alert("Data de Compra é inválida. Por favor, insira uma data no passado.");
			document.getElementById("dataCompra").focus(); // Coloca o foco no campo dataAdmissao
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

function formatarQuantidade(input) {
	// Remove qualquer caractere que não seja número ou ponto
	input.value = input.value.replace(/[^0-9.]/g, '');

	// Garante que só exista um ponto decimal
	if ((input.value.match(/\./g) || []).length > 1) {
		input.value = input.value.replace(/\.+$/, ''); // Remove o último ponto se houver mais de um
	}

	// Limita a dois números após o ponto decimal
	const partes = input.value.split('.');
	if (partes[1] && partes[1].length > 2) {
		partes[1] = partes[1].slice(0, 2);
		input.value = partes.join('.');
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

	const campoPrecoVenda = document.getElementById('precoVenda');
	if (campoPrecoVenda) {
		formatarMoeda(campoPrecoVenda);
		campoPrecoVenda.addEventListener('input', function() {
			formatarMoeda(this);
		});
	}
});
