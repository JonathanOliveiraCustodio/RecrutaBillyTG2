// pedido.js

function validarBusca() {
		var codigo = document.getElementById("codigo").value;
		if (codigo.trim() === "") {
			alert("Por favor, insira um Código.");
			return false;
		}
		return true;
	}

	function editarPedido(codigo) {
		window.location.href = 'pedido?cmd=alterar&codigo=' + codigo;
	}

	function excluirPedido(codigo) {
		if (confirm("Tem certeza que deseja excluir este Pedido?")) {
			window.location.href = 'pedido?cmd=Excluir&codigo=' + codigo;
		}
	}
	function mostrarValor(codigo) {
		console.log(codigo);
	}

	function validarFormulario(event) {
		var botao = event.submitter.value;
		if (botao === "Cadastrar" || botao === "Alterar") {
			var campos = [ "nome", "codigoCliente", "estado" ];
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
	
	function redirectToWhatsApp() {
	    // Obtém o valor do campo de telefone
	    var phoneNumber = document.getElementById('telefone').value;

	    if (phoneNumber) {
	        // Construa a URL do WhatsApp
	        var url = "https://web.whatsapp.com/send?phone=" + encodeURIComponent(phoneNumber);
	        window.open(url, "_blank");
	    } else {
	        alert("Número de telefone não encontrado.");
	    }
	}
	
	 function updateEndereco() {
        var clienteSelect = document.getElementById('cliente');
        var selectedOption = clienteSelect.options[clienteSelect.selectedIndex];
        document.getElementById('CEP').value = selectedOption.getAttribute('data-cep');
        document.getElementById('logradouro').value = selectedOption.getAttribute('data-logradouro');
        document.getElementById('numero').value = selectedOption.getAttribute('data-numero');
        document.getElementById('UF').value = selectedOption.getAttribute('data-uf');
        document.getElementById('localidade').value = selectedOption.getAttribute('data-localidade');
        document.getElementById('bairro').value = selectedOption.getAttribute('data-bairro');
        document.getElementById('complemento').value = selectedOption.getAttribute('data-complemento');
        document.getElementById('telefone').value = selectedOption.getAttribute('data-telefone');
    }