function consultarProduto(codigo) {
	window.location.href = 'consulta?codigo=' + codigo;
}

function editarProduto(codigo) {
	window.location.href = 'produto?cmd=alterar&codigo=' + codigo;
}

function excluirProduto(codigo) {
	if (confirm("Tem certeza que deseja excluir este Produto?")) {
		window.location.href = 'produto?cmd=excluir&codigo=' + codigo;
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
		{ id: "categoria", nome: "Categoria" },
		{ id: "descricao", nome: "Descrição" },
		{ id: "valorUnitario", nome: "Valor Unitário" },
		{ id: "status", nome: "status" },
		{ id: "quantidade", nome: "Quantidade" },
		{ id: "refEstoque", nome: "Referência no Estoque" }

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

// Formata o valor inicial ao carregar a página
document.addEventListener('DOMContentLoaded', function() {
    const campoValorUnitario = document.getElementById('valorUnitario');
    if (campoValorUnitario) {
        formatarMoeda(campoValorUnitario);
    }
});



