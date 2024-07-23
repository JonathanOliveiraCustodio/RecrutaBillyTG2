// insumosProduto.js

document.addEventListener("DOMContentLoaded", function() {
    const unidadesInsumos = JSON.parse(document.getElementById('unidadesInsumos').value);
    const selectInsumo = document.getElementById('insumo');
    const inputUnidade = document.getElementById('unidade');

    selectInsumo.addEventListener('change', function() {
        const insumoCodigo = this.value;
        if (unidadesInsumos[insumoCodigo]) {
            inputUnidade.value = unidadesInsumos[insumoCodigo];
        } else {
            inputUnidade.value = ''; // Limpa o campo se não houver unidade
        }
    });

    // Preenche o campo unidade ao carregar a página, caso haja um insumo selecionado
    const initialInsumoCodigo = selectInsumo.value;
    if (unidadesInsumos[initialInsumoCodigo]) {
        inputUnidade.value = unidadesInsumos[initialInsumoCodigo];
    }
});

	function validarFormulario(event) {
		var botao = event.submitter.value;
		if (botao === "Cadastrar") {
			var campos = [ "insumo" ];
			for (var i = 0; i < campos.length; i++) {
				var campo = document.getElementById(campos[i]).value.trim();
				if (campo === "") {
					alert("Por favor, preencha todos os campos.");
					event.preventDefault();
					return false;
				}
			}
		} else if (botao === "Excluir") {
			var insumo = document.getElementById("insumo").value.trim();
			if (insumo === "" || isNaN(insumo) || parseInt(insumo) <= 0) {
				alert("Por favor, preencha o campo de código.");
				event.preventDefault();
				return false;
			}
		}
		return true;
	}
