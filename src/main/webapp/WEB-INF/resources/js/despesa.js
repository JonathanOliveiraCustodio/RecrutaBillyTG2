// despesa.js

function editarDespesa(codigo) {
	window.location.href = 'despesas?cmd=alterar&codigo=' + codigo;
}

function excluirDespesa(codigo) {
	if (confirm("Tem certeza que deseja excluir esta Despesa?")) {
		window.location.href = 'despesas?cmd=excluir&codigo=' + codigo;
	}
}

function validarFormulario(event) {
	var botao = event.submitter.value;
	var campos = [
		{ id: "nome", nome: "Nome" },
		{ id: "data", nome: "Data" },
		{ id: "dataVencimento", nome: "Data Vencimento" },
		{ id: "pagamento", nome: "Forma de Pagamento" },
		{ id: "tipo", nome: "Tipo de Despesa" },
		{ id: "valor", nome: "Valor" },
		{ id: "estado", nome: "Estado Da Despesa" }
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
    const campoSalario = document.getElementById('valor');
    if (campoSalario) {
        formatarMoeda(campoSalario);
    }
});
