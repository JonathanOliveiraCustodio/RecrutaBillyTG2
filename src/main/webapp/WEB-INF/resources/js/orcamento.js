// pedido.js

function validarBusca() {
	var codigo = document.getElementById("codigo").value;
	if (codigo.trim() === "") {
		alert("Por favor, insira um Código.");
		return false;
	}
	return true;
}

function editarOrcamento(codigo) {
	window.location.href = 'orcamento?cmd=alterar&codigo=' + codigo;
}

function excluirOrcamento(codigo) {
	if (confirm("Tem certeza que deseja excluir este Orçamento?")) {
		window.location.href = 'orcamento?cmd=Excluir&codigo=' + codigo;
	}
}
function mostrarValor(codigo) {
	console.log(codigo);
}

function validarFormulario(event) {
	var botao = event.submitter.value;
	if (botao === "Cadastrar" || botao === "Alterar") {
		var campos = ["nome", "codigoCliente", "estado"];
		for (var i = 0; i < campos.length; i++) {
			var campo = document.getElementById(campos[i]).value.trim();
			if (campo === "") {
				alert("Por favor, preencha todos os campos.");
				event.preventDefault();
				return false;
			}
		}
	} else if (botao === "Excluir") {
		var codigo = document.getElementById("codigo").value.trim();
		if (codigo === "" || isNaN(codigo) || parseInt(codigo) <= 0) {
			alert("Por favor, preencha o campo de código.");
			event.preventDefault();
			return false;
		}
	}
	// Se todos os campos estiverem preenchidos, permitir o envio do formulário
	return true;
}

function formatarMoeda(campo) {
	let valor = campo.value;

	// Remove qualquer caractere que não seja número ou vírgula
	valor = valor.replace(/[^\d]/g, '');

	// Adiciona a vírgula para separar os centavos
	valor = (valor / 100).toFixed(2) + '';
	valor = valor.replace(".", ",");

	// Adiciona o ponto para separar os milhares
	valor = valor.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.");

	// Adiciona o símbolo de moeda
	campo.value = 'R$ ' + valor;
}

function confirmarConversao() {
	return confirm("Gostaria de converter este orçamento em pedido?");
}

// Formata o valor inicial ao carregar a página
document.addEventListener('DOMContentLoaded', function() {
	const campoValorTotal = document.getElementById('valorTotal');
	if (campoValorTotal) {
		formatarMoeda(campoValorTotal);
	}
});