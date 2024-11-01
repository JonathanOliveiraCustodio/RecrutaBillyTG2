function consultarFuncionario(CPF) {
	window.location.href = 'consulta?CPF=' + CPF;
}

function editarFuncionario(CPF) {
	window.location.href = 'funcionario?cmd=alterar&CPF=' + CPF;
}

function excluirFuncionario(CPF) {
	if (confirm("Tem certeza que deseja excluir este Funcionário?")) {
		window.location.href = 'funcionario?cmd=excluir&CPF=' + CPF;
	}
}

function validarBusca() {
	var CPF = document.getElementById("nome").value;
	if (CPF.trim() === "") {
		alert("Por favor, insira um nome.");
		return false;
	}
	return true;
}

function validarSenhas() {
	var senha = document.getElementById("senha").value;
	var confirmarSenha = document.getElementById("confirmarSenha").value;

	// Expressão para verificar se a senha tem ao menos:
	// - uma letra maiúscula
	// - um caractere especial
	// - mínimo de 8 caracteres
	var regexSenha = /^(?=.*[A-Z])(?=.*[!@#$%^&*])(?=.{8,})/;

	if (senha !== confirmarSenha) {
		alert("As senhas não são iguais. Por favor, verifique.");
		return false;
	}

	if (!regexSenha.test(senha)) {
		alert("A senha deve ter pelo menos 8 caracteres, uma letra maiúscula e um caractere especial (!@#$%^&*).");
		return false;
	}

	return true;
}

// Função para validar CPF
function validarCPF(cpf) {
	cpf = cpf.replace(/[^\d]+/g, ''); // Remove caracteres não numéricos
	if (cpf.length !== 11 || /^(\d)\1{10}$/.test(cpf)) { // Verifica se tem 11 dígitos e se não é uma sequência repetida
		alert("CPF inválido. Por favor, verifique o número digitado.");
		return false;
	}
	let soma = 0;
	for (let i = 0; i < 9; i++) {
		soma += parseInt(cpf.charAt(i)) * (10 - i);
	}
	let resto = (soma * 10) % 11;
	if (resto === 10 || resto === 11) resto = 0;
	if (resto !== parseInt(cpf.charAt(9))) {
		alert("CPF inválido. Verifique o dígito verificador.");
		return false;
	}

	soma = 0;
	for (let i = 0; i < 10; i++) {
		soma += parseInt(cpf.charAt(i)) * (11 - i);
	}
	resto = (soma * 10) % 11;
	if (resto === 10 || resto === 11) resto = 0;
	if (resto !== parseInt(cpf.charAt(10))) {
		alert("CPF inválido. Verifique o dígito verificador.");
		return false;
	}

	return true;
}

// Função para validar o formulário
function validarFormulario(event) {
	var botao = event.submitter.value;
	var campos = [
		{ id: "CPF", nome: "CPF" },
		{ id: "nome", nome: "Nome" },
		{ id: "dataNascimento", nome: "Data Nascimento" },
		{ id: "email", nome: "E-mail" },
		{ id: "senha", nome: "Senha" },
		{ id: "cargo", nome: "Cargo" },
		{ id: "horario", nome: "Horário" },
		{ id: "nivelAcesso", nome: "Nível de Acesso" },
		{ id: "salario", nome: "Salário" },
		{ id: "dataAdmissao", nome: "Data Admissão" },
		{ id: "telefone", nome: "Telefone" }
	];

	var dataAdmissao = document.getElementById("dataAdmissao").value;

	// Validações para botões Cadastrar e Alterar
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

		// Verificar se o CPF é válido
		var cpf = document.getElementById("CPF").value.trim();
		if (cpf && !validarCPF(cpf)) {
			event.preventDefault();
			return false;
		}

		// Verificar se as senhas são válidas (implementação necessária)
		if (!validarSenhas()) {
			event.preventDefault();
			return false;
		}

		// Verificar se o horário é válido (implementação necessária)
		var horario = document.getElementById("horario").value.trim();
		if (horario && !validarHorario(horario)) {
			alert("Horário inválido. Por favor, use o formato 'HH:mm às HH:mm'.");
			event.preventDefault();
			return false;
		}

		// Validação para o Salário
		var salarioCampo = document.getElementById("salario");
		var salario = parseFloat(salarioCampo.value.replace(/[^\d,]/g, '').replace(",", "."));
		if (salario <= 0) {
			alert("O campo Salário deve ser maior que R$ 0,00.");
			salarioCampo.focus();
			event.preventDefault();
			return false;
		}

		// Validação da data de aquisição
		if (!validarDataAdmissao(dataAdmissao)) {
			alert("Data de Adimissão é inválida. Por favor, insira uma data no passado.");
			document.getElementById("dataAdmissao").focus(); // Coloca o foco no campo dataAdmissao
			event.preventDefault();
			return false;
		}
		
		// Validações para o botão Excluir
	} else if (botao === "Excluir") {
		var codigo = document.getElementById("CPF").value.trim();
		if (codigo === "" || isNaN(codigo) || parseInt(codigo) <= 0) {
			alert("Por favor, preencha o campo de CPF corretamente.");
			document.getElementById("CPF").focus();
			event.preventDefault();
			return false;
		}
		// Confirmar a exclusão
		if (!confirm('Você realmente deseja excluir este registro? Esta ação não pode ser desfeita.')) {
			event.preventDefault();
			return false;
		}

		// Validação para o botão Endereço
	} else if (botao === "Endereço") {
		var cpf = document.getElementById("CPF").value.trim();
		if (cpf === "") {
			alert("O CPF não pode estar vazio para o botão 'Endereço'.");
			document.getElementById("CPF").focus();
			event.preventDefault();
			return false;
		}
	}
	return true;
}

function validarDataAdmissao(dataAdmissao) {
	var hoje = new Date();
	var aquisicao = new Date(dataAdmissao);

	// Zera as horas, minutos e segundos de ambas as datas para comparar apenas as datas
	hoje.setHours(0, 0, 0, 0);
	aquisicao.setHours(0, 0, 0, 0);

	// A data de aquisição deve ser anterior ao dia de hoje
	return aquisicao < hoje;
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

function validarHorario(horario) {
	// Regex para validar o formato "HH:mm às HH:mm" ou "HH:mm as HH:mm"
	var regex = /^([0-1]?[0-9]|2[0-3]):[0-5][0-9] (às|as) ([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/;
	return regex.test(horario);
}

function validarERedirecionar() {
	// Obtenha o CPF do campo
	var cpf = document.getElementById("CPF").value.trim();

	cpf = cpf.replace(/[^\d]+/g, '');
	// Verifique se o CPF está vazio
	if (cpf === "") {
		alert("O CPF não pode estar vazio.");
		document.getElementById("CPF").focus(); // Coloca o foco no campo CPF
		return;
	}
	// Verifique a validade do CPF se necessário
	if (!validarCPF(cpf)) {
		alert("CPF inválido.");
		return;
	}
	// Se o CPF estiver correto, redirecione para a URL desejada
	window.location.href = 'endereco?funcionario=' + encodeURIComponent(cpf);
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


function aplicarMascaraCPF() {
	var cpfInput = document.getElementById('CPF');
	cpfInput.addEventListener('input', function() {
		this.value = formatarCPF(this.value);
	});

	// Formata o valor inicial se o campo já tiver um valor
	if (cpfInput.value) {
		cpfInput.value = formatarCPF(cpfInput.value);
	}
}

document.addEventListener('DOMContentLoaded', function() {
	aplicarMascaraTelefone();
	aplicarMascaraCPF();

	const campovalorUnitario = document.getElementById('salario');
	if (campovalorUnitario) {
		formatarMoeda(campovalorUnitario);
		campovalorUnitario.addEventListener('input', function() {
			formatarMoeda(this);
		});
	}

	// Aplicar a máscara de CPF em todas as células da tabela que contêm CPF
	var cpfsNaTabela = document.querySelectorAll('.CPF-campo');
	cpfsNaTabela.forEach(function(campo) {
		campo.textContent = formatarCPF(campo.textContent); // Aplica a máscara de CPF
	});


});

