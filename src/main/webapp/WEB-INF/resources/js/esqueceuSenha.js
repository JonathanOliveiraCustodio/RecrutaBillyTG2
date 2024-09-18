// esqueceuSenha.js

function validarFormulario(event) {
	// Pegue o valor do botão que está sendo clicado para submissão
	var botao = event.submitter ? event.submitter.value : document.activeElement.value;

	// Campos a serem validados
	var campos = [
		{ id: "email", nome: "Email" },
		{ id: "CPF", nome: "CPF" },
		{ id: "novaSenha", nome: "Nova Senha" },
		{ id: "confirmarSenha", nome: "Confirmar Senha" }
	];

	// Verifica se o botão clicado foi "Alterar Senha"
	if (botao === "Alterar Senha") {
		for (var i = 0; i < campos.length; i++) {
			var campo = document.getElementById(campos[i].id);
			if (campo.value.trim() === "") {
				alert("Por favor, preencha o campo " + campos[i].nome + ".");
				campo.focus(); // Coloca o foco no campo vazio
				event.preventDefault(); // Impede o envio do formulário
				return false;
			}
		}

		// Verifica se a nova senha atende aos critérios
		var novaSenha = document.getElementById("novaSenha").value;
		var confirmarSenha = document.getElementById("confirmarSenha").value;

		// Expressão regular para a senha
		var regexSenha = /^(?=.*[A-Z])(?=.*[!@#$%^&*])(?=.{8,})/;

		if (!regexSenha.test(novaSenha)) {
			alert("A senha deve ter no mínimo 8 caracteres, incluindo pelo menos uma letra maiúscula e um caractere especial.");
			document.getElementById("novaSenha").focus(); // Coloca o foco no campo de senha
			event.preventDefault(); // Impede o envio do formulário
			return false;
		}

		// Verifica se as senhas coincidem
		if (novaSenha !== confirmarSenha) {
			alert("As senhas não coincidem. Por favor, verifique.");
			document.getElementById("confirmarSenha").focus(); // Coloca o foco na confirmação de senha
			event.preventDefault(); // Impede o envio do formulário
			return false;
		}
	}
	return true; // Permite o envio do formulário se tudo estiver correto
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
	aplicarMascaraCPF();
});




