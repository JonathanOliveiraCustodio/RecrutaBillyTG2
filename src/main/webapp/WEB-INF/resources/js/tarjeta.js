// categoriaProduto.js

function editarTarjeta(codigo) {
	window.location.href = 'tarjeta?cmd=alterar&codigo=' + codigo;
}

function excluirTarjeta(codigo) {
	if (confirm("Tem certeza que deseja excluir esta Tarjeta?")) {
		window.location.href = 'tarjeta?cmd=excluir&codigo=' + codigo;
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

function adicionarLinha() {
    const tabela = document.getElementById('registroTabela');
    const linhaModelo = tabela.querySelector('tr:first-child');
    const novaLinha = linhaModelo.cloneNode(true);

    // Limpar os valores dos campos de entrada na nova linha
    novaLinha.querySelectorAll('input, select').forEach(campo => {
        if (campo.tagName === 'INPUT') {
            campo.value = '';
        } else if (campo.tagName === 'SELECT') {
            campo.selectedIndex = 0;
        }
    });

    // Substituir o botão de adicionar por um botão de remover na nova linha
    const botaoAcao = novaLinha.querySelector('button');
    botaoAcao.className = 'btn btn-danger';
    botaoAcao.textContent = 'Remover';
    botaoAcao.onclick = function() {
        removerLinha(botaoAcao);
    };

    tabela.appendChild(novaLinha);
}

function removerLinha(botao) {
    const linha = botao.closest('tr');
    const tabela = document.getElementById('registroTabela');

    // Verificar se há mais de uma linha na tabela antes de remover
    if (tabela.rows.length > 1) {
        linha.remove();
    } else {
        alert("Não é possível remover todas as linhas.");
    }
}


function validarFormulario(event) {
	var botao = event.submitter.value;
	var campos = [
		{ id: "nome", nome: "Nome" },
		{ id: "categoria", nome: "Categoria" },
		{ id: "descricao", nome: "Descrição" },
		{ id: "valorProduto", nome: "Valor Produto" },
		{ id: "status", nome: "status" },
		{ id: "quantidade", nome: "Quantidade" },
		{ id: "refEstoque", nome: "Referência no Estoque" },
		{ id: "data", nome: "Data" },

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

			// Validação para o campo de cliente
			if (campo.id === "categoria" && campo.value === "0") {
				alert("Por favor, selecione uma categooria.");
				campo.focus();
				event.preventDefault();
				return false;
			}

			// Validação para o Valor
			if (campos[i].id === "valorUnitario") {
				var valor = parseFloat(campo.value.replace(/[^\d,]/g, '').replace(",", "."));
				if (valor <= 0 || isNaN(valor)) {
					alert("O campo " + campos[i].nome + " deve ser maior que R$ 0,00.");
					campo.focus();
					event.preventDefault();
					return false;
				}
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
	const campovalorUnitario = document.getElementById('valorProduto');
	if (campovalorUnitario) {
		formatarMoeda(campovalorUnitario);
		campovalorUnitario.addEventListener('input', function() {
			formatarMoeda(this);
		});
	}
});

