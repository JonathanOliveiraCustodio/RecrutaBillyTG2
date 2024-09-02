function validarFormulario(event) {
    var botao = event.submitter.value;
    
    if (botao === "Cadastrar") {
        var campos = ["descricao"];
        for (var i = 0; i < campos.length; i++) {
            var campo = document.getElementById(campos[i]).value.trim();
            if (campo === "") {
                alert("Por favor, preencha todos os campos.");
                event.preventDefault();
                return false;
            }
        }
    } else if (botao === "Excluir") {
        var descricao = document.getElementById("descricao").value.trim();
        if (descricao === "" || isNaN(descricao)) {
            alert("Por favor, preencha o campo de descricao com um número válido.");
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
