function buscarEndereco() {
	var cep = document.getElementById("CEP").value.replace(/\D/g, '');
	console.log("CEP Digitado: ", cep);
	if (cep != "") {
		var validacep = /^[0-9]{8}$/;
		if (validacep.test(cep)) {
			document.getElementById("logradouro").value = "...";
			document.getElementById("bairro").value = "...";
			document.getElementById("cidade").value = "...";
			document.getElementById("UF").value = "...";
			var script = document.createElement('script');
			script.src = 'https://viacep.com.br/ws/' + cep + '/json/?callback=preencherEndereco';
			document.body.appendChild(script);
		} else {
			alert("Formato de CEP inválido.");
		}
	} else {
		alert("CEP não informado.");
	}
}

function preencherEndereco(conteudo) {
	console.log("Conteúdo do CEP: ", conteudo);
	if (!("erro" in conteudo)) {
		document.getElementById("logradouro").value = conteudo.logradouro;
		document.getElementById("bairro").value = conteudo.bairro;
		document.getElementById("cidade").value = conteudo.localidade;
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

function consultarFornecedor(codigo) {
	window.location.href = 'consulta?codigo=' + codigo;
}

function editarFornecedor(codigo) {
	window.location.href = 'fornecedor?cmd=alterar&codigo=' + codigo;
}

function excluirFornecedor(codigo) {
	if (confirm("Tem certeza que deseja excluir este funcionario?")) {
		window.location.href = 'fornecedor?cmd=excluir&codigo=' + codigo;
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
    var botao = event.submitter.value;
    var campos = [
        { id: "nome", nome: "Nome" },
        { id: "telefone", nome: "Telefone" },
        { id: "email", nome: "E-mail" },
        { id: "empresa", nome: "Empresa" },
        { id: "CEP", nome: "CEP" },
        { id: "logradouro", nome: "Logradouro" },
        { id: "bairro", nome: "Bairro" },
        { id: "cidade", nome: "Cidade" },
        { id: "UF", nome: "UF" },
        { id: "numero", nome: "Número" },
    ];

    if (botao === "Cadastrar" || botao === "Alterar") {
        var campoInvalido = campos.find(campo => {
            var elemento = document.getElementById(campo.id);
            return elemento && elemento.value.trim() === "";
        });

        if (campoInvalido) {
            alert("Por favor, preencha o campo " + campoInvalido.nome + ".");
            document.getElementById(campoInvalido.id).focus(); // Coloca o foco no campo vazio
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

function aplicarMascaraTelefone() {
    var telefoneInput = document.getElementById('telefone');
    telefoneInput.addEventListener('input', function () {
        this.value = formatarTelefone(this.value);
    });

    // Formata o valor inicial se o campo já tiver um valor
    if (telefoneInput.value) {
        telefoneInput.value = formatarTelefone(telefoneInput.value);
    }
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

document.addEventListener('DOMContentLoaded', function() {
     aplicarMascaraTelefone();
});





