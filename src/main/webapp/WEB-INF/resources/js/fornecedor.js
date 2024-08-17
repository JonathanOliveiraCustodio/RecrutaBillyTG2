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
	var codigo = document.getElementById("codigo").value;
	if (codigo.trim() === "") {
		alert("Por favor, insira um codigo.");
		return false;
	}
	return true;
}

function validarFormulario(event) {
	var botao = event.submitter.value;
	if (botao === "Cadastrar" || botao === "Alterar") {
		var campos = ["nome", "endereco", "telefone", "email", "empresa"];
		for (var i = 0; i < campos.length; i++) {
			var campo = document.getElementById(campos[i]).value.trim();
			if (campo === "") {
				alert("Por favor, preencha todos os campos.");
				event.preventDefault();
				return false;
			}
		}
	} else if (botao === "Excluir") {
		var codigo = document.getElementById("codigo").value.trim();
		if (codigo === "" || isNaN(codigo) || parseInt(codigo) <= 0) {
			alert("Por favor, preencha o campo de código.");
			event.preventDefault();
			return false;
		}
	}
	// Se todos os campos estiverem preenchidos, permitir o envio do formulário
	return true;
}

function validarTelefone(input) {
	// Limita o número de dígitos a 11
	input.value = input.value.replace(/\D/g, '').slice(0, 11);
}




