// pedido.js

function validarBusca() {
	var codigo = document.getElementById("codigo").value;
	if (codigo.trim() === "") {
		alert("Por favor, insira um Código.");
		return false;
	}
	return true;
}

function editarPedido(codigo) {
	window.location.href = 'pedido?cmd=alterar&codigo=' + codigo;
}

function excluirPedido(codigo) {
	if (confirm("Tem certeza que deseja excluir este Pedido?")) {
		window.location.href = 'pedido?cmd=Excluir&codigo=' + codigo;
	}
}
function mostrarValor(codigo) {
	console.log(codigo);
}

function validarFormulario(event) {
	var botao = event.submitter.value;
	var campos = [
		{ id: "nome", nome: "Nome" },
		{ id: "descricao", nome: "Descrição" },
		{ id: "cliente", nome: "Cliente" },
		{ id: "estado", nome: "Estado" },
		{ id: "valorTotal", nome: "Valor Total" },
		{ id: "tipoPagamento", nome: "Tipo Pagamento" },
		{ id: "statusPagamento", nome: "Status Pagamento" },
		{ id: "dataPagamento", nome: "Data Pagamento" }
	];

	if (botao === "Cadastrar" || botao === "Alterar") {
		for (var i = 0; i < campos.length; i++) {
			var campo = document.getElementById(campos[i].id);
			if (campo.value.trim() === "") {
				alert("Por favor, preencha o campo " + campos[i].nome + ".");
				campo.focus(); // Coloca o foco no campo vazio
				event.preventDefault();
				return false;
			}

			// Validação para o campo de cliente
			if (campo.id === "cliente" && campo.value === "0") {
				alert("Por favor, selecione um cliente.");
				campo.focus();
				event.preventDefault();
				return false;
			}

			// Validação para o Valor
			if (campos[i].id === "valorTotal") {
				var valor = parseFloat(campo.value.replace(/[^\d,]/g, '').replace(",", "."));
				if (valor <= 0 || isNaN(valor)) {
					alert("O campo " + campos[i].nome + " deve ser maior que R$ 0,00.");
					campo.focus();
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

	else if (botao === "Adicionar") {
		var codigo = document.getElementById("codigo").value.trim();
		if (codigo === "" || isNaN(codigo) || parseInt(codigo) <= 0) {
			alert("Por favor, preencha o campo de código corretamente.");
			document.getElementById("nome").focus(); // Coloca o foco no campo código
			event.preventDefault();
			return false;
		}
	}
	return true;
}


function redirectToWhatsApp() {
	// Obtém o valor do campo de telefone
	var phoneNumber = document.getElementById('telefone').value;

	if (phoneNumber) {
		// Construa a URL do WhatsApp
		var url = "https://web.whatsapp.com/send?phone=" + encodeURIComponent(phoneNumber);
		window.open(url, "_blank");
	} else {
		alert("Número de telefone não encontrado.");
	}
}

function updateEndereco() {
	const clienteSelect = document.getElementById("cliente");
	const selectedOption = clienteSelect.options[clienteSelect.selectedIndex];

	// Dados do cliente selecionado (exemplo: armazenados como atributos data-*)
	const cep = selectedOption.getAttribute("data-cep");
	const logradouro = selectedOption.getAttribute("data-logradouro");
	const numero = selectedOption.getAttribute("data-numero");
	const complemento = selectedOption.getAttribute("data-complemento");
	const bairro = selectedOption.getAttribute("data-bairro");
	const localidade = selectedOption.getAttribute("data-localidade");
	const UF = selectedOption.getAttribute("data-UF");
	const telefone = selectedOption.getAttribute("data-telefone");

	// Preenchendo os campos com os dados do cliente
	document.getElementById("CEP").value = cep;
	document.getElementById("logradouro").value = logradouro;
	document.getElementById("numero").value = numero;
	document.getElementById("complemento").value = complemento;
	document.getElementById("bairro").value = bairro;
	document.getElementById("localidade").value = localidade; telefone
	document.getElementById("UF").value = UF;
	document.getElementById("telefone").value = telefone;
}

function confirmarFinalizacao(estado) {
	if (estado === "Pedido Finalizado") {
		alert("Este pedido já está finalizado e não pode ser alterado.");
		return false;
	}
	return confirm("Gostaria de Finalizar este Pedido? Não será possível realizar alterações posteriores");
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
	const campovalorUnitario = document.getElementById('valorTotal');
	if (campovalorUnitario) {
		formatarMoeda(campovalorUnitario);
		campovalorUnitario.addEventListener('input', function() {
			formatarMoeda(this);
		});
	}
});