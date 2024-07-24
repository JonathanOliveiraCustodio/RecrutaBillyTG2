	function validarFormulario(event) {
		var botao = event.submitter.value;
		if (botao === "Cadastrar") {
			var campos = [ "produto", "quantidade" ];
			for (var i = 0; i < campos.length; i++) {
				var campo = document.getElementById(campos[i]).value.trim();
				if (campo === "") {
					alert("Por favor, preencha todos os campos.");
					event.preventDefault();
					return false;
				}
			}
		} else if (botao === "Excluir") {
			var produto = document.getElementById("produto").value.trim();
			var quantidade = document.getElementById("quantidade").value.trim();

			if (produto === "" || isNaN(produto) || parseInt(produto) <= 0) {
				alert("Por favor, preencha o campo de código.");
				event.preventDefault();
				return false;
			}

			if (quantidade === "" || isNaN(quantidade)
					|| parseInt(quantidade) === 0) {
				alert("A quantidade deve ser diferente de 0.");
				event.preventDefault();
				return false;
			}
		}
		return true;
	}