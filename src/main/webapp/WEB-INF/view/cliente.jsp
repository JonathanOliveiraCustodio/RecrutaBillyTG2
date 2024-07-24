<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<title>Cliente</title>
<script>
	function editarCliente(codigo) {
		window.location.href = 'cliente?cmd=alterar&codigo=' + codigo;
	}

	function excluirCliente(codigo) {
		if (confirm("Tem certeza que deseja excluir este Cliente?")) {
			window.location.href = 'cliente?cmd=excluir&codigo=' + codigo;
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

	function validarCPF(cpf) {
		cpf = cpf.replace(/[^\d]+/g, '');
		if (cpf == '')
			return false;
		if (cpf.length != 11 || cpf == "00000000000" || cpf == "11111111111"
				|| cpf == "22222222222" || cpf == "33333333333"
				|| cpf == "44444444444" || cpf == "55555555555"
				|| cpf == "66666666666" || cpf == "77777777777"
				|| cpf == "88888888888" || cpf == "99999999999")
			return false;
		add = 0;
		for (i = 0; i < 9; i++)
			add += parseInt(cpf.charAt(i)) * (10 - i);
		rev = 11 - (add % 11);
		if (rev == 10 || rev == 11)
			rev = 0;
		if (rev != parseInt(cpf.charAt(9)))
			return false;
		add = 0;
		for (i = 0; i < 10; i++)
			add += parseInt(cpf.charAt(i)) * (11 - i);
		rev = 11 - (add % 11);
		if (rev == 10 || rev == 11)
			rev = 0;
		if (rev != parseInt(cpf.charAt(10)))
			return false;
		return true;
	}

	function validarCNPJ(cnpj) {
		cnpj = cnpj.replace(/[^\d]+/g, '');
		if (cnpj == '')
			return false;
		if (cnpj.length != 14)
			return false;
		if (cnpj == "00000000000000" || cnpj == "11111111111111"
				|| cnpj == "22222222222222" || cnpj == "33333333333333"
				|| cnpj == "44444444444444" || cnpj == "55555555555555"
				|| cnpj == "66666666666666" || cnpj == "77777777777777"
				|| cnpj == "88888888888888" || cnpj == "99999999999999")
			return false;
		tamanho = cnpj.length - 2
		numeros = cnpj.substring(0, tamanho);
		digitos = cnpj.substring(tamanho);
		soma = 0;
		pos = tamanho - 7;
		for (i = tamanho; i >= 1; i--) {
			soma += numeros.charAt(tamanho - i) * pos--;
			if (pos < 2)
				pos = 9;
		}
		resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
		if (resultado != digitos.charAt(0))
			return false;
		tamanho = tamanho + 1;
		numeros = cnpj.substring(0, tamanho);
		soma = 0;
		pos = tamanho - 7;
		for (i = tamanho; i >= 1; i--) {
			soma += numeros.charAt(tamanho - i) * pos--;
			if (pos < 2)
				pos = 9;
		}
		resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
		if (resultado != digitos.charAt(1))
			return false;
		return true;
	}

	function validarFormulario(event) {
		var botao = event.submitter.value;
		if (botao === "Cadastrar" || botao === "Alterar") {
			var campos = [ "nome", "telefone", "email", "tipo", "documento" ];
			for (var i = 0; i < campos.length; i++) {
				var campo = document.getElementById(campos[i]).value.trim();
				if (campo === "") {
					alert("Por favor, preencha todos os campos.");
					event.preventDefault();
					return false;
				}
			}

			var tipo = document.getElementById("tipo").value;
			var documento = document.getElementById("documento").value.trim();

			if (tipo === "CPF" && !validarCPF(documento)) {
				alert("CPF inválido.");
				event.preventDefault();
				return false;
			}

			if (tipo === "CNPJ" && !validarCNPJ(documento)) {
				alert("CNPJ inválido.");
				event.preventDefault();
				return false;
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


	function ajustarMaxlength(tipo) {
		var documento = document.getElementById("documento");
		if (tipo === "CPF") {
			documento.maxLength = 11;
		} else if (tipo === "CNPJ") {
			VA
			documento.maxLength = 14;
		} else {
			documento.maxLength = 14;
		}
	}

	document.getElementById("tipo")
			.addEventListener("change", ajustarMaxlength);
</script>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<c:if test="${nivelAcesso == 'admin'}">
			<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
				<div class="container-fluid py-1">
					<h1 class="display-6 fw-bold">Manutenção de Cliente</h1>

					<form action="cliente" method="post" class="row g-3 mt-3"
						onsubmit="return validarFormulario(event);">
						<!-- Primeira Linha: Código, Nome, Telefone -->
						<div class="row g-3">
							<div class="col-md-1 d-flex align-items-center">
								<label for="codigo" class="form-label">Código:</label>
							</div>
							<div class="col-md-2">
								<input type="number" min="0" step="1" id="codigo" name="codigo"
									class="form-control" placeholder="Código"
									value='<c:out value="${cliente.codigo }"></c:out>'>
							</div>
							<div class="col-md-1">
								<input type="submit" id="botao" name="botao" value="Buscar"
									class="btn btn-primary mb-3" onclick="return validarBusca()">
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="nome" class="form-label">Nome:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="nome" name="nome" class="form-control"
									placeholder="Nome" maxlength="100"
									value='<c:out value="${cliente.nome }"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="telefone" class="form-label">Telefone:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="telefone" name="telefone"
									class="form-control" placeholder="Telefone" maxlength="11"
									value='<c:out value="${cliente.telefone }"></c:out>'>
							</div>
						</div>

						<!-- Segunda Linha: Email, Tipo, Documento -->
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="email" class="form-label">Email:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="email" name="email" class="form-control"
									placeholder="Email" maxlength="100"
									value='<c:out value="${cliente.email }"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="tipo" class="form-label">Tipo:</label>
							</div>
							<div class="col-md-3">
								<select id="tipo" name="tipo" class="form-select"
									onclick="ajustarMaxlength(this.value)">
									<option value="">Escolha um Tipo de Documento</option>
									<option value="CPF"
										<c:if test="${cliente.tipo eq 'CPF'}">selected</c:if>>CPF</option>
									<option value="CNPJ"
										<c:if test="${cliente.tipo eq 'CNPJ'}">selected</c:if>>CNPJ</option>
								</select>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="documento" class="form-label">Documento:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="documento" name="documento"
									class="form-control" placeholder="Documento" maxlength="14"
									value='<c:out value="${cliente.documento }"></c:out>'>
							</div>
						</div>

						<!-- Terceira Linha: CEP, Logradouro, Número -->
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="cep" class="form-label">CEP:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="CEP" name="CEP" class="form-control"
									placeholder="CEP" maxlength="9"
									value='<c:out value="${cliente.CEP }"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="logradouro" class="form-label">Logradouro:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="logradouro" name="logradouro"
									class="form-control" placeholder="Logradouro" maxlength="100"
									value='<c:out value="${cliente.logradouro }"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="numero" class="form-label">Número:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="numero" name="numero"
									class="form-control" placeholder="Número" maxlength="10"
									value='<c:out value="${cliente.numero }"></c:out>'>
							</div>
						</div>

						<!-- Quarta Linha: UF, Localidade, Bairro -->
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="uf" class="form-label">UF:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="UF" name="UF" class="form-control"
									placeholder="UF" maxlength="2"
									value='<c:out value="${cliente.UF }"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="localidade" class="form-label">Localidade:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="localidade" name="localidade"
									class="form-control" placeholder="Localidade" maxlength="100"
									value='<c:out value="${cliente.localidade }"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="bairro" class="form-label">Bairro:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="bairro" name="bairro"
									class="form-control" placeholder="Bairro" maxlength="100"
									value='<c:out value="${cliente.bairro }"></c:out>'>
							</div>
						</div>

						<!-- Quinta Linha: Complemento, Data Nascimento e Botão Contato por WhatsApp -->
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="complemento" class="form-label">Compl:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="complemento" name="complemento"
									class="form-control" placeholder="Complemento"
									value='<c:out value="${cliente.complemento }"></c:out>'>
							</div>
							<div class="col-md-1 d-flex align-items-center">
								<label for="dataNascimento" class="form-label">
									Nascimento:</label>
							</div>
							<div class="col-md-3">
								<input class="form-control" type="date" id="dataNascimento"
									name="dataNascimento" placeholder="Data Nascimento"
									value='<c:out value="${cliente.dataNascimento }"></c:out>'>
							</div>
							<div class="col-md-4 d-flex align-items-center">
								<button type="button"
									class="btn btn-outline-success d-flex align-items-center"
									onclick="redirectToWhatsApp()">
									<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
										fill="currentColor" class="bi bi-whatsapp" viewBox="0 0 16 16"
										style="margin-right: 5px;">
                    <path
											d="M13.601 2.326A7.85 7.85 0 0 0 7.994 0C3.627 0 .068 3.558.064 7.926c0 1.399.366 2.76 1.057 3.965L0 16l4.204-1.102a7.9 7.9 0 0 0 3.79.965h.004c4.368 0 7.926-3.558 7.93-7.93A7.9 7.9 0 0 0 13.6 2.326zM7.994 14.521a6.6 6.6 0 0 1-3.356-.92l-.24-.144-2.494.654.666-2.433-.156-.251a6.56 6.56 0 0 1-1.007-3.505c0-3.626 2.957-6.584 6.591-6.584a6.56 6.56 0 0 1 4.66 1.931 6.56 6.56 0 0 1 1.928 4.66c-.004 3.639-2.961 6.592-6.592 6.592m3.615-4.934c-.197-.099-1.17-.578-1.353-.646-.182-.065-.315-.099-.445.099-.133.197-.513.646-.627.775-.114.133-.232.148-.43.05-.197-.1-.836-.308-1.592-.985-.59-.525-.985-1.175-1.103-1.372-.114-.198-.011-.304.088-.403.087-.088.197-.232.296-.346.1-.114.133-.198.198-.33.065-.134.034-.248-.015-.347-.05-.099-.445-1.076-.612-1.47-.16-.389-.323-.335-.445-.34-.114-.007-.247-.007-.38-.007a.73.73 0 0 0-.529.247c-.182.198-.691.677-.691 1.654s.71 1.916.81 2.049c.098.133 1.394 2.132 3.383 2.992.47.205.84.326 1.129.418.475.152.904.129 1.246.08.38-.058 1.171-.48 1.338-.943.164-.464.164-.86.114-.943-.049-.084-.182-.133-.38-.232" />
                </svg>
									Contato WhatsApp
								</button>
							</div>
						</div>



						<!-- Linha dos Botões -->
						<div class="row g-3 mt-3">
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Cadastrar"
									class="btn btn-success">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Alterar"
									class="btn btn-warning">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Excluir"
									class="btn btn-danger">
							</div>
							<div class="col-md-2 d-grid text-center"></div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Listar"
									class="btn btn-dark">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Limpar"
									class="btn btn-secondary">
							</div>
						</div>
					</form>
				</div>
			</div>
		</c:if>
	</div>

	<div align="center">
		<c:if test="${not empty erro}">
			<h2 style="color: black;">
				<b><c:out value="${erro}" /></b>
			</h2>
		</c:if>
	</div>

	<div align="center">
		<c:if test="${not empty saida }">
			<h2 style="color: black;">
				<b><c:out value="${saida}" /></b>
			</h2>
		</c:if>
	</div>
	<br />

	<div class="container py-4 text-center d-flex justify-content-center"
		align="center">
		<c:if test="${not empty clientes }">
			<table class="table table-striped">
				<thead>
					<tr>
						<th class="titulo-tabela" colspan="8"
							style="text-align: center; font-size: 23px;">Lista de
							Clientes</th>
					</tr>
					<tr class="table-dark">
						<td></td>
						<td>Código</td>
						<td>Nome</td>
						<td>Telefone</td>
						<td>Email</td>
						<td>Tipo do Documento</td>
						<td>Documento</td>
						<td>Excluir</td>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<c:forEach var="c" items="${clientes }">
						<tr>
							<td style="text-align: center;">
								<button class="btn btn-info" name="opcao" value="${c.codigo}"
									onclick="editarCliente(this.value)"
									${c.codigo eq codigoEdicao ? 'checked' : ''}>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									  <path
											d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
									</svg>
								</button>
							</td>
							<td><c:out value="${c.codigo }" /></td>
							<td><c:out value="${c.nome }" /></td>
							<td><c:out value="${c.telefone }" /></td>
							<td><c:out value="${c.email }" /></td>
							<td><c:out value="${c.tipo }" /></td>
							<td><c:out value="${c.documento }" /></td>
							<td style="text-align: center;">
								<button class="btn btn-danger"
									onclick="excluirCliente('${c.codigo}')">Excluir</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
	<div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>
