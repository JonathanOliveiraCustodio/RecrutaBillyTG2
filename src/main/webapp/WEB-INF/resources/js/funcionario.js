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

// Funções auxiliares
function validarCPF(cpf) {
    cpf = cpf.replace(/[^\d]+/g, '');
    if (cpf.length !== 11 || /^(\d)\1{10}$/.test(cpf)) {
        return false;
    }
    let soma = 0;
    for (let i = 0; i < 9; i++) {
        soma += parseInt(cpf.charAt(i)) * (10 - i);
    }
    let resto = (soma * 10) % 11;
    if (resto === 10 || resto === 11) resto = 0;
    if (resto !== parseInt(cpf.charAt(9))) return false;

    soma = 0;
    for (let i = 0; i < 10; i++) {
        soma += parseInt(cpf.charAt(i)) * (11 - i);
    }
    resto = (soma * 10) % 11;
    if (resto === 10 || resto === 11) resto = 0;
    if (resto !== parseInt(cpf.charAt(10))) return false;

    return true;
}

function validarSenhas() {
    var senha = document.getElementById("senha").value;
    var confirmarSenha = document.getElementById("confirmarSenha").value;
    return senha === confirmarSenha;
}

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
                alert("CPF inválido.");
                event.preventDefault();
                return false;
            }

            // Verificar se as senhas são válidas
            if (!validarSenhas()) {
                alert("As senhas não são iguais. Por favor, verifique.");
                event.preventDefault();
                return false;
            }

            // Verificar se o horário é válido
            var horario = document.getElementById("horario").value.trim();
            if (horario && !validarHorario(horario)) {
                alert("Horário inválido. Por favor, use o formato 'HH:mm às HH:mm'.");
                event.preventDefault();
                return false;
            }

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


function validarHorario(horario) {
	// Regex para validar o formato "HH:mm às HH:mm"
	var regex = /^([0-1]?[0-9]|2[0-3]):[0-5][0-9] às ([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/;
	return regex.test(horario);
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

 function validarERedirecionar() {
        // Obtenha o CPF do campo
        var cpf = document.getElementById("CPF").value.trim();

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



// Formata o valor inicial ao carregar a página
document.addEventListener('DOMContentLoaded', function() {
    const campoSalario = document.getElementById('salario');
    if (campoSalario) {
        formatarMoeda(campoSalario);
    }
});

