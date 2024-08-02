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
	var CPF = document.getElementById("CPF").value;
	if (CPF.trim() === "") {
		alert("Por favor, insira um CPF.");
		return false;
	}
	return true;
}

function validarSenhas() {
	var senha = document.getElementById("senha").value;
	var confirmarSenha = document.getElementById("confirmarSenha").value;
	if (senha !== confirmarSenha) {
		alert("As senhas não são iguais. Por favor, verifique.");
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
	var add = 0;
	for (var i = 0; i < 9; i++)
		add += parseInt(cpf.charAt(i)) * (10 - i);
	var rev = 11 - (add % 11);
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

function validarFormulario(event) {
	var botao = event.submitter.value;
	var CPF = document.getElementById("CPF").value.trim();

	if (botao === "Cadastrar" || botao === "Alterar") {
		var campos = [
			"CPF", "nome", "dataNascimento", "email", "senha", "confirmarSenha",
			"cargo", "horario", "nivelAcesso", "salario", "dataAdmissao",
			"telefone"
		];

		// Verificar se todos os campos obrigatórios estão preenchidos
		for (var i = 0; i < campos.length; i++) {
			var campo = document.getElementById(campos[i]).value.trim();
			if (campo === "") {
				alert("Por favor, preencha todos os campos.");
				event.preventDefault();
				return false;
			}
		}

		// Verificar se o CPF é válido
		if (!validarCPF(CPF)) {
			alert("CPF inválido.");
			event.preventDefault();
			return false;
		}

		// Verificar se as senhas são válidas
		if (!validarSenhas()) {
			event.preventDefault();
			return false;
		}


	} else if (botao === "Excluir") {
		if (CPF === "" || isNaN(CPF) || parseInt(CPF) <= 0) {
			alert("Por favor, preencha o campo de CPF.");
			event.preventDefault();
			return false;
		}
	}

	// Se todos os campos estiverem preenchidos, permitir o envio do formulário
	return true;
}

function validarHorario(horario) {
	// Regex para validar o formato "HH:mm às HH:mm"
	var regex = /^([0-1]?[0-9]|2[0-3]):[0-5][0-9] às ([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/;
	return regex.test(horario);
}
