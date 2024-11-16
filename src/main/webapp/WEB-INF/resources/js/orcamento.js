// Orçamento.js

function validarBusca() {
	var codigo = document.getElementById("nome").value;
	if (codigo.trim() === "") {
		alert("Por favor, insira um Nome.");
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

function validarERedirecionar() {
	// Obtenha o CPF do campo
	var codigo = document.getElementById("codigo").value.trim();

	if (codigo === "") {
		alert("O código não pode estar vazio.");
		document.getElementById("codigo").focus(); // Coloca o foco no campo CPF
		return;
	}

	// Se o CPF estiver correto, redirecione para a URL desejada
	window.location.href = 'produtosOrcamento?orcamento=' + encodeURIComponent(codigo);
}

function validarFormulario(event) {
	var botao = event.submitter.value;
	var campos = [
		{ id: "nome", nome: "Nome" },
		{ id: "descricao", nome: "Descrição" },
		{ id: "cliente", nome: "Cliente" },
		{ id: "valorTotal", nome: "Valor Total" },
		{ id: "formaPagamento", nome: "Forma de Pagamento" },
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
	return true;
}

function confirmarConversao() {
	return confirm("Gostaria de converter este orçamento em pedido?");
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
	document.getElementById("localidade").value = localidade;
	document.getElementById("UF").value = UF;
	document.getElementById("telefone").value = telefone;
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

function aplicarMascaraTelefone() {
	var telefoneInput = document.getElementById('telefone');
	telefoneInput.addEventListener('input', function() {
		this.value = formatarTelefone(this.value);
	});
	// Formata o valor inicial se o campo já tiver um valor
	if (telefoneInput.value) {
		telefoneInput.value = formatarTelefone(telefoneInput.value);
	}
}

function formatarTelefone(telefone) {
	telefone = telefone.replace(/\D/g, ''); // Remove caracteres não numéricos
	telefone = telefone.slice(0, 11); // Limita a 11 dígitos

	if (telefone.length <= 2) {
		return telefone;
	} else if (telefone.length <= 6) {
		return '(' + telefone.slice(0, 2) + ') ' + telefone.slice(2);
	} else if (telefone.length <= 10) {
		return '(' + telefone.slice(0, 2) + ') ' + telefone.slice(2, 6) + '-' + telefone.slice(6);
	} else {
		return '(' + telefone.slice(0, 2) + ') ' + telefone.slice(2, 7) + '-' + telefone.slice(7);
	}
}

function abrirModalOrcamento(codigo) {
    // Validação do código
    if (codigo == 0 || codigo.trim() === "") {
        alert("O orçamento não pode estar vazio. Selecione um orçamento para visualizar!");
        return;
    }

    // Seleciona os campos de entrada do formulário
    var codigoInput = document.getElementById('codigo');
    var nomeInput = document.getElementById('nome');
    var descricaoInput = document.getElementById('descricao');
    var clienteInput = document.getElementById('cliente');
    var statusInput = document.getElementById('status');
    var valorTotalInput = document.getElementById('valorTotal');
    var formaPagamentoInput = document.getElementById('formaPagamento');
    var dataOrcamentoInput = document.getElementById('dataOrcamento');
    var cepInput = document.getElementById('CEP');
    var logradouroInput = document.getElementById('logradouro');
    var numeroInput = document.getElementById('numero');
    var complementoInput = document.getElementById('complemento');
    var bairroInput = document.getElementById('bairro');
    var localidadeInput = document.getElementById('localidade');
    var ufInput = document.getElementById('UF');

    // Função para formatar data
    function formatarData(data) {
        var partesData = data.split("-");
        return partesData[2] + "/" + partesData[1] + "/" + partesData[0];
    }

    // Preenche os dados no modal
    document.getElementById('modalCodigo').innerText = codigoInput.value;
    document.getElementById('modalNome').innerText = nomeInput.value;
    document.getElementById('modalDescricao').innerText = descricaoInput.value;
    document.getElementById('modalCliente').innerText = clienteInput.options[clienteInput.selectedIndex].text;
    document.getElementById('modalStatus').innerText = statusInput.value;
    document.getElementById('modalValorTotal').innerText = valorTotalInput.value;
    document.getElementById('modalFormaPagamento').innerText = formaPagamentoInput.options[formaPagamentoInput.selectedIndex].text;

    var dataFormatada = formatarData(dataOrcamentoInput.value);
    document.getElementById('modalDataOrcamento').innerText = dataFormatada;

    // Preenche os dados de endereço
    document.getElementById('modalCEP').innerText = cepInput.value;
    document.getElementById('modalLogradouro').innerText = logradouroInput.value;
    document.getElementById('modalNumero').innerText = numeroInput.value;
    document.getElementById('modalComplemento').innerText = complementoInput.value;
    document.getElementById('modalBairro').innerText = bairroInput.value;
    document.getElementById('modalLocalidade').innerText = localidadeInput.value;
    document.getElementById('modalUF').innerText = ufInput.value;

    // Exibe o modal
    let orcamentoModal = new bootstrap.Modal(document.getElementById('orcamentoModal'));
    orcamentoModal.show();
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

document.addEventListener("DOMContentLoaded", function () {
    const codigoInput = document.getElementById("codigo");
    const linhaBotoes = document.getElementById("linhaBotoes");
    aplicarMascaraTelefone();

    function verificarCodigo() {
        const valorCodigo = codigoInput.value.trim();
        if (valorCodigo !== "" && valorCodigo !== "0") {
            linhaBotoes.style.display = "flex"; // Torna visível
        } else {
            linhaBotoes.style.display = "none"; // Esconde
        }
    }

    // Verifica o valor inicial do campo ao carregar a página
    verificarCodigo();

    // Escuta mudanças no campo para atualizar a visibilidade
    codigoInput.addEventListener("input", verificarCodigo);
});
