// endereco.js

function consultarEndereco(CPF) {
	window.location.href = 'consulta?CPF=' + CPF;
}

function editarEndereco(codigo, CPF) {
    // Corrige o nome do parâmetro para "funcionario"
    window.location.href = 'endereco?cmd=alterar&codigo=' + codigo + '&funcionario=' + CPF;
}


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



function validarFormulario(event) {
    var botao = event.submitter.value;
    
    if (botao === "Cadastrar" || botao === "Alterar") {
        var campos = [
            { id: "CEP", nome: "CEP" },
            { id: "numero", nome: "Número" },
            { id: "tipoEndereco", nome: "Tipo de Endereço" }
        ];

        // Validação dos campos obrigatórios
        for (var i = 0; i < campos.length; i++) {
            var campo = document.getElementById(campos[i].id);
            if (campo.value.trim() === "") {
                alert("Por favor, preencha o campo " + campos[i].nome + ".");
                campo.focus(); // Coloca o foco no campo vazio
                event.preventDefault();
                return false;
            }
        }

        // Validação do CEP
        var cep = document.getElementById("CEP").value.replace(/\D/g, '');
        var validacep = /^[0-9]{8}$/;
        if (!validacep.test(cep)) {
            alert("Formato de CEP inválido.");
            document.getElementById("CEP").focus(); // Coloca o foco no campo CEP
            event.preventDefault();
            return false;
        }
        
        // Validação do número
        var numero = document.getElementById("numero").value.trim();
        if (isNaN(numero) || numero === "") {
            alert("Por favor, preencha o campo Número com um valor numérico válido.");
            document.getElementById("numero").focus(); // Coloca o foco no campo Número
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


