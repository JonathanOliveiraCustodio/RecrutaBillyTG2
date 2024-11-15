// cliente.js

function buscarEndereco() {
	var cep = document.getElementById("CEP").value.replace(/\D/g, '');

	if (cep != "") {
		var validacep = /^[0-9]{8}$/;

		if (validacep.test(cep)) {
			// Exibe "carregando" enquanto busca o endereço
			document.getElementById("logradouro").value = "...";
			document.getElementById("bairro").value = "...";
			document.getElementById("localidade").value = "...";
			document.getElementById("UF").value = "...";
			// Faz a requisição AJAX para buscar o endereço
			$.ajax({
				url: 'https://viacep.com.br/ws/' + cep + '/json/',
				dataType: 'json',
				success: function(conteudo) {
					if (!("erro" in conteudo)) {
						preencherEndereco(conteudo);
					} else {
						alert("CEP não encontrado.");
						limparCamposEndereco();
					}
				},
				error: function() {
					alert("Erro ao buscar o CEP.");
				}
			});
		} else {
			alert("Formato de CEP inválido.");
		}
	} else {
		alert("CEP não informado.");
	}
}

function preencherEndereco(conteudo) {
	if (!("erro" in conteudo)) {
		document.getElementById("logradouro").value = conteudo.logradouro;
		document.getElementById("bairro").value = conteudo.bairro;
		document.getElementById("localidade").value = conteudo.localidade;
		document.getElementById("UF").value = conteudo.uf;
	} else {
		alert("CEP não encontrado.");
		limparCamposEndereco();
	}
}

function limparCamposEndereco() {
	document.getElementById("logradouro").value = "";
	document.getElementById("bairro").value = "";
	document.getElementById("localidade").value = "";
	document.getElementById("UF").value = "";
}

function editarCliente(codigo) {
	window.location.href = 'cliente?cmd=alterar&codigo=' + codigo;
}

function excluirCliente(codigo) {
	if (confirm("Tem certeza que deseja excluir este Cliente?")) {
		window.location.href = 'cliente?cmd=excluir&codigo=' + codigo;
	}
}

function abrirModalCliente(codigo) {
	// Validação do código
	if (codigo == 0 || codigo.trim() === "") {
		alert("O código do cliente não pode estar vazio.");
		return; // Interrompe a função se o código estiver vazio
	}

	// Seleciona os campos de entrada com os dados preenchidos no formulário
	var codigoInput = document.getElementById('codigo');
	var nomeInput = document.getElementById('nome');
	var telefoneInput = document.getElementById('telefone');
	var emailInput = document.getElementById('email');
	var tipoSelect = document.getElementById('tipo');
	var documentoInput = document.getElementById('documento');
	var cepInput = document.getElementById('CEP');
	var logradouroInput = document.getElementById('logradouro');
	var bairroInput = document.getElementById('bairro');
	var ufInput = document.getElementById('UF');
	var localidadeInput = document.getElementById('localidade');
	var numeroInput = document.getElementById('numero');
	var complementoInput = document.getElementById('complemento');
	var dataNascimentoInput = document.getElementById('dataNascimento');

	// Função para formatar a data de "yyyy-MM-dd" para "dd/MM/yyyy"
	function formatarData(data) {
		var partesData = data.split("-");
		return partesData[2] + "/" + partesData[1] + "/" + partesData[0];
	}

	// Preenche os dados no modal
	document.getElementById('modalCodigo').innerText = codigoInput.value;
	document.getElementById('modalNome').innerText = nomeInput.value;
	document.getElementById('modalTelefone').innerText = telefoneInput.value;
	document.getElementById('modalEmail').innerText = emailInput.value;

	// Pega o texto do tipo de documento selecionado
	var tipoNome = tipoSelect.options[tipoSelect.selectedIndex].text;
	document.getElementById('modalTipo').innerText = tipoNome;

	document.getElementById('modalDocumento').innerText = documentoInput.value;
	document.getElementById('modalCEP').innerText = cepInput.value;
	document.getElementById('modalLogradouro').innerText = logradouroInput.value;
	document.getElementById('modalBairro').innerText = bairroInput.value;
	document.getElementById('modalUF').innerText = ufInput.value;
	document.getElementById('modalLocalidade').innerText = localidadeInput.value;
	document.getElementById('modalNumero').innerText = numeroInput.value;
	document.getElementById('modalComplemento').innerText = complementoInput.value;

	// Formata a data de nascimento e preenche no modal
	var dataFormatada = formatarData(dataNascimentoInput.value);
	document.getElementById('modalDataNascimento').innerText = dataFormatada;

	// Exibe o modal
	let clienteModal = new bootstrap.Modal(document.getElementById('clienteModal'));
	clienteModal.show();
}


function exibirSpinner() {
	const spinner = document.getElementById("spinner");
	const botao = document.getElementById("botao");

	// Exibe o spinner e desativa o botão para evitar múltiplos envios
	spinner.classList.remove("d-none");
	botao.setAttribute("disabled", true);
}

function validarBusca() {
	var codigo = document.getElementById("nome").value;
	if (codigo.trim() === "") {
		alert("Por favor, insira um nome.");
		return false;
	}
	return true;
}

function validarCPF(cpf) {
	cpf = cpf.replace(/[^\d]+/g, '');
	if (cpf == '')
		return false;
	if (cpf.length != 11 || cpf == "00000000000" || cpf == "11111111111"
		|| cpf == "22222222222" || cpf == "33333333333"
		|| cpf == "44444444444" || cpf == "55555555555"
		|| cpf == "66666666666" || cpf == "77777777777"
		|| cpf == "88888888888" || cpf == "99999999999")
		return false;
	add = 0;
	for (i = 0; i < 9; i++)
		add += parseInt(cpf.charAt(i)) * (10 - i);
	rev = 11 - (add % 11);
	if (rev == 10 || rev == 11)
		rev = 0;
	if (rev != parseInt(cpf.charAt(9)))
		return false;
	add = 0;
	for (i = 0; i < 10; i++)
		add += parseInt(cpf.charAt(i)) * (11 - i);
	rev = 11 - (add % 11);
	if (rev == 10 || rev == 11)
		rev = 0;
	if (rev != parseInt(cpf.charAt(10)))
		return false;
	return true;
}

function validarCNPJ(cnpj) {
	cnpj = cnpj.replace(/[^\d]+/g, '');
	if (cnpj == '')
		return false;
	if (cnpj.length != 14)
		return false;
	if (cnpj == "00000000000000" || cnpj == "11111111111111"
		|| cnpj == "22222222222222" || cnpj == "33333333333333"
		|| cnpj == "44444444444444" || cnpj == "55555555555555"
		|| cnpj == "66666666666666" || cnpj == "77777777777777"
		|| cnpj == "88888888888888" || cnpj == "99999999999999")
		return false;
	tamanho = cnpj.length - 2;
	numeros = cnpj.substring(0, tamanho);
	digitos = cnpj.substring(tamanho);
	soma = 0;
	pos = tamanho - 7;
	for (i = tamanho; i >= 1; i--) {
		soma += numeros.charAt(tamanho - i) * pos--;
		if (pos < 2)
			pos = 9;
	}
	resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
	if (resultado != digitos.charAt(0))
		return false;
	tamanho = tamanho + 1;
	numeros = cnpj.substring(0, tamanho);
	soma = 0;
	pos = tamanho - 7;
	for (i = tamanho; i >= 1; i--) {
		soma += numeros.charAt(tamanho - i) * pos--;
		if (pos < 2)
			pos = 9;
	}
	resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
	if (resultado != digitos.charAt(1))
		return false;
	return true;
}

function validarFormulario(event) {
	var botao = event.submitter.value;
	var campos = [
		{ id: "nome", nome: "Nome" },
		{ id: "telefone", nome: "Telefone" },
		{ id: "email", nome: "E-mail" },
		{ id: "numero", nome: "Número" },
		{ id: "tipo", nome: "Tipo de Documento" },
		{ id: "documento", nome: "Documento" },
		{ id: "dataNascimento", nome: "Data de Nascimento" }
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
		}

		var tipo = document.getElementById("tipo").value;
		var documento = document.getElementById("documento").value.trim();
		var dataNascimento = document.getElementById("dataNascimento").value;

		if (tipo === "CPF" && !validarCPF(documento)) {
			alert("CPF inválido.");
			document.getElementById("documento").focus(); // Coloca o foco no campo documento
			event.preventDefault();
			return false;
		}

		if (tipo === "CNPJ" && !validarCNPJ(documento)) {
			alert("CNPJ inválido.");
			document.getElementById("documento").focus(); // Coloca o foco no campo documento
			event.preventDefault();
			return false;
		}

		// Validação da data de nascimento
		if (!validarDataNascimento(dataNascimento)) {
			alert("Data de nascimento inválida. Por favor, insira uma data no passado.");
			document.getElementById("dataNascimento").focus(); // Coloca o foco no campo dataNascimento
			event.preventDefault();
			return false;
		}

		// Validação da idade mínima de 18 anos
		if (!validarIdadeMinima(dataNascimento)) {
			alert("O cliente deve ter mais de 18 anos.");
			document.getElementById("dataNascimento").focus(); // Coloca o foco no campo dataNascimento
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

function validarIdadeMinima(dataNascimento) {
	var dataNasc = new Date(dataNascimento);
	var dataAtual = new Date();

	// Calcula a diferença em anos
	var idade = dataAtual.getFullYear() - dataNasc.getFullYear();
	var mes = dataAtual.getMonth() - dataNasc.getMonth();
	var dia = dataAtual.getDate() - dataNasc.getDate();

	// Ajusta se ainda não fez aniversário este ano
	if (mes < 0 || (mes === 0 && dia < 0)) {
		idade--;
	}
	// Verifica se a idade é menor que 18
	return idade >= 18;
}


function validarDataNascimento(dataNascimento) {
	var hoje = new Date();
	var nascimento = new Date(dataNascimento);

	// Zera as horas, minutos e segundos de ambas as datas para comparar apenas as datas
	hoje.setHours(0, 0, 0, 0);
	nascimento.setHours(0, 0, 0, 0);

	// A data de nascimento deve ser anterior ao dia de hoje
	return nascimento < hoje;
}


function validarIdade() {
	var inputDataNascimento = document.getElementById('dataNascimento').value;
	var dataNascimento = new Date(inputDataNascimento);
	var dataAtual = new Date();

	// Calcula a diferença em anos
	var idade = dataAtual.getFullYear() - dataNascimento.getFullYear();
	var mesAtual = dataAtual.getMonth() - dataNascimento.getMonth();
	var diaAtual = dataAtual.getDate() - dataNascimento.getDate();

	// Ajusta a idade se o aniversário ainda não aconteceu neste ano
	if (mesAtual < 0 || (mesAtual === 0 && diaAtual < 0)) {
		idade--;
	}

	// Verifica se é maior de 18 anos
	if (idade < 18) {
		alert('O cliente deve ter mais de 18 anos.');
		return false; // Impede o envio do formulário
	}

	return true; // Prossegue com o envio se a validação estiver correta
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

function ajustarMaxlength(tipo) {
	var inputDocumento = document.getElementById("documento");
	if (tipo.value === "CPF") {
		inputDocumento.setAttribute("maxlength", "14");
	} else if (tipo.value === "CNPJ") {
		inputDocumento.setAttribute("maxlength", "18");
	}
}

function formatarCPF(cpf) {
	cpf = cpf.replace(/\D/g, ''); // Remove caracteres não numéricos
	cpf = cpf.slice(0, 11); // Limita a 11 dígitos

	if (cpf.length <= 3) {
		return cpf;
	} else if (cpf.length <= 6) {
		return cpf.slice(0, 3) + '.' + cpf.slice(3);
	} else if (cpf.length <= 9) {
		return cpf.slice(0, 3) + '.' + cpf.slice(3, 6) + '.' + cpf.slice(6);
	} else {
		return cpf.slice(0, 3) + '.' + cpf.slice(3, 6) + '.' + cpf.slice(6, 9) + '-' + cpf.slice(9);
	}
}

function formatarCNPJ(cnpj) {
	cnpj = cnpj.replace(/\D/g, ''); // Remove caracteres não numéricos
	cnpj = cnpj.slice(0, 14); // Limita a 14 dígitos

	if (cnpj.length <= 2) {
		return cnpj;
	} else if (cnpj.length <= 5) {
		return cnpj.slice(0, 2) + '.' + cnpj.slice(2);
	} else if (cnpj.length <= 8) {
		return cnpj.slice(0, 2) + '.' + cnpj.slice(2, 5) + '.' + cnpj.slice(5);
	} else if (cnpj.length <= 12) {
		return cnpj.slice(0, 2) + '.' + cnpj.slice(2, 5) + '.' + cnpj.slice(5, 8) + '/' + cnpj.slice(8);
	} else {
		return cnpj.slice(0, 2) + '.' + cnpj.slice(2, 5) + '.' + cnpj.slice(5, 8) + '/' + cnpj.slice(8, 12) + '-' + cnpj.slice(12);
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

function aplicarMascara() {
	var tipo = $('#tipo').val();
	var $documento = $('#documento');

	$documento.off('input'); // Remove qualquer evento de input anterior

	if (tipo === 'CPF') {
		$documento.on('input', function() {
			this.value = formatarCPF(this.value);
		});

		// Formata o valor inicial se o campo já tiver um valor
		if ($documento.val()) {
			$documento.val(formatarCPF($documento.val()));
		}
	} else if (tipo === 'CNPJ') {
		$documento.on('input', function() {
			this.value = formatarCNPJ(this.value);
		});

		// Formata o valor inicial se o campo já tiver um valor
		if ($documento.val()) {
			$documento.val(formatarCNPJ($documento.val()));
		}
	} else {
		$documento.val($documento.val().replace(/\D/g, '')); // Remove a máscara caso não tenha tipo selecionado
	}
}

function aplicarMascaraTabela() {
	document.querySelectorAll('.documento').forEach(function(element) {
		var tipo = element.getAttribute('data-tipo');
		var documento = element.textContent;

		if (tipo === 'CPF') {
			element.textContent = formatarCPF(documento);
		} else if (tipo === 'CNPJ') {
			element.textContent = formatarCNPJ(documento);
		}
	});
}

function aplicarMascaraTabelaTelefone() {
	document.querySelectorAll('.telefone').forEach(function(element) {
		var telefone = element.textContent;
		element.textContent = formatarTelefone(telefone);
	});
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

function validarIdade() {
	var inputDataNascimento = document.getElementById('dataNascimento').value;
	var dataNascimento = new Date(inputDataNascimento);
	var dataAtual = new Date();

	// Calcula a diferença em anos
	var idade = dataAtual.getFullYear() - dataNascimento.getFullYear();
	var mesAtual = dataAtual.getMonth() - dataNascimento.getMonth();
	var diaAtual = dataAtual.getDate() - dataNascimento.getDate();

	// Ajusta a idade se o aniversário ainda não aconteceu neste ano
	if (mesAtual < 0 || (mesAtual === 0 && diaAtual < 0)) {
		idade--;
	}

	// Verifica se é maior de 18 anos
	if (idade < 18) {
		alert('O cliente deve ter mais de 18 anos.');
		return false; // Impede o envio do formulário
	}

	return true; // Prossegue com o envio se a validação estiver correta
}

document.addEventListener('DOMContentLoaded', function() {
	aplicarMascaraTabela();
	aplicarMascaraTabelaTelefone();
	aplicarMascaraTelefone();

	$('#tipo').change(function() {
		aplicarMascara();
	});

	// Aplica a máscara ao carregar a página
	aplicarMascara();
});
function validarTelefone(input) {
	// Remove todos os caracteres que não são dígitos
	let valor = input.value.replace(/\D/g, '');

	// Limita o valor a 11 dígitos
	if (valor.length > 11) {
		valor = valor.slice(0, 11);
	}
	// Atualiza o valor do input
	input.value = valor;
}
