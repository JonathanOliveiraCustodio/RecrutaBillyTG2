// insumo.js

function consultarInsumo(codigo) {
		window.location.href = 'consulta?codigo=' + codigo;
	}

	function editarInsumo(codigo) {
		window.location.href = 'insumo?cmd=alterar&codigo=' + codigo;
	}

	function excluirInsumo(codigo) {
		if (confirm("Tem certeza que deseja excluir este insumo?")) {
			window.location.href = 'insumo?cmd=excluir&codigo=' + codigo;
		}
	}

	function validarBusca() {
		var codigo = document.getElementById("codigo").value;
		if (codigo.trim() === "") {
			alert("Por favor, insira um Código.");
			return false;
		}
		return true;
	}
	function validarFormulario(event) {
		var botao = event.submitter.value;
		if (botao === "Cadastrar" || botao === "Alterar") {
			var campos = [ "nome", "valor", "quantidade", "fornecedor" ];
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