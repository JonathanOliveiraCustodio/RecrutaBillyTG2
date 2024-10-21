function consultarEquipamento(codigo) {
	window.location.href = 'consulta?codigo=' + codigo;
}

function editarEquipamento(codigo) {
	window.location.href = 'equipamento?cmd=alterar&codigo=' + codigo;
}

function excluirEquipamento(codigo) {
	if (confirm("Tem certeza que deseja excluir este Equipamento?")) {
		window.location.href = 'equipamento?cmd=excluir&codigo=' + codigo;
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

function validarDataAquisicao(dataAquisicao) {
    var hoje = new Date();
    var aquisicao = new Date(dataAquisicao);

    // Zera as horas, minutos e segundos de ambas as datas para comparar apenas as datas
    hoje.setHours(0, 0, 0, 0);
    aquisicao.setHours(0, 0, 0, 0);

    // A data de aquisição deve ser anterior ao dia de hoje
    return aquisicao < hoje;
}


function validarFormulario(event) {
	var botao = event.submitter.value;
	var campos = [
		{ id: "nome", nome: "Nome" },
		{ id: "fabricante", nome: "Fabricante" },
		{ id: "descricao", nome: "Descrição" },
		{ id: "dataAquisicao", nome: "Data Aquisição" },
	];

	var dataAquisicao = document.getElementById("dataAquisicao").value;
	
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

		// Validação da data de aquisição
		if (!validarDataAquisicao(dataAquisicao)) {
			alert("Data de Aquisição é inválida. Por favor, insira uma data no passado.");
			document.getElementById("dataAquisicao").focus(); // Coloca o foco no campo dataAquisicao
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
