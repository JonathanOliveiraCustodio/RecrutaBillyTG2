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
			var campos = [ "nome", "categoria", "descricao", "valorUnitario",
					"status", "quantidade" ];
			for (var i = 0; i < campos.length; i++) {
				var campo = document.getElementById(campos[i]).value.trim();
				if (campo === "") {
					alert("Por favor, preencha todos os campos.");
					event.preventDefault();
					return false;
				}
			}
		}
		return true;
	}