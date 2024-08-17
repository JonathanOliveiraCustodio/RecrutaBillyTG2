// cliente.js

function buscarEndereco() {
	var cep = document.getElementById("CEP").value.replace(/\D/g, '');

	if (cep != "") {
		var validacep = /^[0-9]{8}$/;

		if (validacep.test(cep)) {
			document.getElementById("logradouro").value = "...";
			document.getElementById("bairro").value = "...";
			document.getElementById("localidade").value = "...";
			document.getElementById("UF").value = "...";

			var script = document.createElement('script');
			script.src = 'https://viacep.com.br/ws/' + cep
				+ '/json/?callback=preencherEndereco';
			document.body.appendChild(script);
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
	tamanho = cnpj.length - 2
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

        if (!validarDataNascimento(dataNascimento)) {
            alert("Data de nascimento inválida. Por favor, insira uma data no passado.");
            document.getElementById("dataNascimento").focus(); // Coloca o foco no campo dataNascimento
            event.preventDefault();
            return false;
        }
    } else if (botao === "Excluir") {
        var codigo = document.getElementById("codigo").value.trim();
        if (codigo === "" || isNaN(codigo) || parseInt(codigo) <= 0) {
            alert("Por favor, preencha o campo de código.");
            document.getElementById("codigo").focus(); // Coloca o foco no campo código
            event.preventDefault();
            return false;
        }
    }
    return true;
}


function validarDataNascimento(dataNascimento) {
    var hoje = new Date();
    var nascimento = new Date(dataNascimento);

    // A data de nascimento deve ser anterior ao dia de hoje
    return nascimento < hoje;
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
	var documento = document.getElementById("documento");
	if (tipo === "CPF") {
		documento.maxLength = 11;
	} else if (tipo === "CNPJ") {
		documento.maxLength = 14;
	} else {
		documento.maxLength = 14;
	}
}


document.getElementById("tipo").addEventListener("change", function() {
	ajustarMaxlength(this.value);
});
