// pedido.js

function validarFormulario(event) {
	var botao = event.submitter.value;
	var campos = [
		{ id: "nome", nome: "Nome" },
		{ id: "descricao", nome: "Descrição" },
		{ id: "cliente", nome: "Cliente" },
		{ id: "estado", nome: "Estado" },
		{ id: "valorTotal", nome: "Valor Total" },
		{ id: "tipoPagamento", nome: "Tipo Pagamento" },
		{ id: "statusPagamento", nome: "Status Pagamento" },
		{ id: "dataPagamento", nome: "Data Pagamento" }
	];

	if (botao === "Alterar") {
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

    valor = valor.replace(/[^\d]/g, '');
    valor = (valor / 100).toFixed(2) + '';
    valor = valor.replace(".", ",");
 
    valor = valor.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    campo.value = 'R$ ' + valor;
    if (campo.value.endsWith(',0')) {
        campo.value = campo.value.slice(0, -1) + '00';
    }
}

document.addEventListener('DOMContentLoaded', function() {
    const campoValorTotal = document.getElementById('valorTotalDespesasMes');
    if (campoValorTotal) {
        formatarMoeda(campoValorTotal);
        campoValorTotal.addEventListener('input', function() {
            formatarMoeda(this);
        });
    }
});