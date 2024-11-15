// nomeTarjeta.js

function consultarNomeTarjeta(codigo) {
	window.location.href = 'consulta?codigo=' + codigo;
}

function editarNomeTarjeta(codigo) {
    document.getElementById('codigoEditar').value = codigo;
    document.getElementById('formEditar').submit();
}
function excluirNomeTarjeta(codigo) {
    if (confirm("Tem certeza que deseja excluir este Nome?")) {
        document.getElementById('codigoExcluir').value = codigo;
        document.getElementById('formExcluir').submit();
    } else {
        // Se o usuário cancelar, não faça nada
        return;
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

function validarDataCompra(dataCompra) {
	var hoje = new Date();
	var compra = new Date(dataCompra);

	// Zera as horas, minutos e segundos de ambas as datas para comparar apenas as datas
	hoje.setHours(0, 0, 0, 0);
	compra.setHours(0, 0, 0, 0);

	// A data de aquisição deve ser anterior ao dia de hoje
	return compra < hoje;
}

function validarFormulario(event) {
	var botao = event.submitter ? event.submitter.value : null;
	var campos = [
		{ id: "nome", nome: "Nome" },
		{ id: "tipoSanguineo", nome: "Tipo Sanguineo" },
		{ id: "fatorRH", nome: "Fator RH" },
		{ id: "quantidade", nome: "Quantidade" }
	];
	
	if (botao === "Cadastrar" || botao === "Alterar") {
		for (var i = 0; i < campos.length; i++) {
			var campo = document.getElementById(campos[i].id);
			if (campo) {
				if (campo.value.trim() === "" || (campo.id === "patente" && campo.value === "0")) {
					alert("Por favor, preencha o campo " + campos[i].nome + ".");
					campo.focus(); // Coloca o foco no campo vazio
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

function validarSalvarNovo() {
    const novoNome = document.querySelector('[name="novoNome"]');
    const novoTipoSanguineo = document.querySelector('[name="novoTipoSanguineo"]');
    const novoFatorRH = document.querySelector('[name="novoFatorRH"]');
    const novoQuantidade = document.querySelector('[name="novoQuantidade"]');
    const novoPatente = document.querySelector('[name="novoPatente"]');

    // Verifica se algum campo obrigatório está vazio
    if (!novoNome.value.trim()) {
        alert("Por favor, preencha o campo Nome.");
        novoNome.focus();
        return false;
    }
    if (!novoTipoSanguineo.value) {
        alert("Por favor, selecione um Tipo Sanguíneo.");
        novoTipoSanguineo.focus();
        return false;
    }
    if (!novoFatorRH.value) {
        alert("Por favor, selecione o Fator RH.");
        novoFatorRH.focus();
        return false;
    }
    if (!novoQuantidade.value || novoQuantidade.value <= 0) {
        alert("Por favor, insira uma Quantidade válida.");
        novoQuantidade.focus();
        return false;
    }
    if (!novoPatente.value) {
        alert("Por favor, selecione uma Patente.");
        novoPatente.focus();
        return false;
    }

    return true; // Permite o envio se todos os campos estão preenchidos
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

function formatarQuantidade(input) {
	// Remove qualquer caractere que não seja número ou ponto
	input.value = input.value.replace(/[^0-9.]/g, '');

	// Garante que só exista um ponto decimal
	if ((input.value.match(/\./g) || []).length > 1) {
		input.value = input.value.replace(/\.+$/, ''); // Remove o último ponto se houver mais de um
	}

	// Limita a dois números após o ponto decimal
	const partes = input.value.split('.');
	if (partes[1] && partes[1].length > 2) {
		partes[1] = partes[1].slice(0, 2);
		input.value = partes.join('.');
	}
}

document.addEventListener('DOMContentLoaded', function() {
	const campoPrecoCompra = document.getElementById('precoCompra');
	if (campoPrecoCompra) {
		formatarMoeda(campoPrecoCompra);
		campoPrecoCompra.addEventListener('input', function() {
			formatarMoeda(this);
		});
	}

	const campoPrecoVenda = document.getElementById('precoVenda');
	if (campoPrecoVenda) {
		formatarMoeda(campoPrecoVenda);
		campoPrecoVenda.addEventListener('input', function() {
			formatarMoeda(this);
		});
	}
});
