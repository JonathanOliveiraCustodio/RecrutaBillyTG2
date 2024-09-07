function validarFormulario(event) {
		var botao = event.submitter.value;
		if (botao === "Cadastrar") {
			var campos = [ "descricao" ];
			for (var i = 0; i < campos.length; i++) {
				var campo = document.getElementById(campos[i]).value.trim();
				if (campo === "") {
					alert("Por favor, preencha todos os campos.");
					event.preventDefault();
					return false;
				}
			}
		} else if (botao === "Excluir") {
			var confirmacao = confirm("Você realmente deseja excluir este registro?");
			if (!confirmacao) {
				event.preventDefault();
				return false;
			}
		}
	}