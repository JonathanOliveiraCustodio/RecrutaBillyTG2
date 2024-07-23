<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<title>Usuário</title>
<script>
	function consultarUsuario(CPF) {
		window.location.href = 'consulta?CPF=' + CPF;
	}

	function editarUsuario(CPF) {
		window.location.href = 'usuario?cmd=alterar&CPF=' + CPF;
	}

	function excluirUsuario(CPF) {
		if (confirm("Tem certeza que deseja excluir este Usuario?")) {
			window.location.href = 'usuario?cmd=excluir&CPF=' + CPF;
		}
	}

	function validarBusca() {
		var CPF = document.getElementById("CPF").value;
		if (CPF.trim() === "") {
			alert("Por favor, insira um CPF.");
			return false;
		}
		return true;
	}

	function validarSenhas() {
		var senha = document.getElementById("senha").value;
		var confirmarSenha = document.getElementById("confirmarSenha").value;
		if (senha !== confirmarSenha) {
			alert("As senhas não são iguais. Por favor, verifique.");
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
		var add = 0;
		for (var i = 0; i < 9; i++)
			add += parseInt(cpf.charAt(i)) * (10 - i);
		var rev = 11 - (add % 11);
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

	function validarFormulario(event) {
		var botao = event.submitter.value;
		var CPF = document.getElementById("CPF").value.trim();

		if (botao === "Cadastrar" || botao === "Alterar") {
			var campos = [ "CPF", "nome", "nivelAcesso", "email", "senha",
					"confirmarSenha" ];
			for (var i = 0; i < campos.length; i++) {
				var campo = document.getElementById(campos[i]).value.trim();
				if (campo === "") {
					alert("Por favor, preencha todos os campos.");
					event.preventDefault();
					return false;
				}
			}
			if (!validarCPF(CPF)) {
				alert("CPF inválido.");
				event.preventDefault();
				return false;
			}
			if (!validarSenhas()) {
				event.preventDefault();
				return false;
			}
		} else if (botao === "Excluir") {
			if (CPF === "" || isNaN(CPF) || parseInt(CPF) <= 0) {
				alert("Por favor, preencha o campo de CPF.");
				event.preventDefault();
				return false;
			}
		}

		// Se todos os campos estiverem preenchidos, permitir o envio do formulário
		return true;
	}
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
					<h3 class="display-6 fw-bold">Manutenção de Usuário</h3>
					<form action="usuario" method="post" class="row g-3 mt-3"
						onsubmit="return validarFormulario(event);">
						<!-- Primeira Linha: CPF, Nome, Nível de Acesso -->
						<div class="row g-3">
							<div class="col-md-1 d-flex align-items-center">
								<label for="CPF" class="form-label">CPF:</label>
							</div>
							<div class="col-md-2">
								<input type="number" min="1" step="1" id="CPF" name="CPF"
									class="form-control" placeholder="CPF"
									value='<c:out value="${usuario.CPF}"></c:out>'>
							</div>
							<div class="col-md-1">
								<input type="submit" id="botaoBuscar" name="botao"
									value="Buscar" class="btn btn-outline-primary mb-3"
									onclick="return validarBusca()">
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="nome" class="form-label">Nome:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="nome" name="nome" class="form-control"
									placeholder="Nome do Usuário" maxlength="100"
									value='<c:out value="${usuario.nome}"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="nivelAcesso" class="form-label">Nível de
									Acesso:</label>
							</div>
							<div class="col-md-3">
								<select class="form-select" id="nivelAcesso" name="nivelAcesso">
									<option value="">Escolha um Nível de Acesso</option>
									<option value="admin"
										<c:if test="${usuario.nivelAcesso eq 'admin'}">selected</c:if>>admin</option>
									<option value="Funcionário"
										<c:if test="${usuario.nivelAcesso eq 'Funcionário'}">selected</c:if>>Funcionário</option>
								</select>
							</div>
						</div>

						<!-- Segunda Linha: Email, Senha, Confirmar Senha -->
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="email" class="form-label">Email:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="email" name="email" class="form-control"
									placeholder="Email" maxlength="100"
									value='<c:out value="${usuario.email}"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="senha" class="form-label">Senha:</label>
							</div>
							<div class="col-md-3">
								<input type="password" id="senha" name="senha"
									class="form-control" placeholder="Senha"
									value='<c:out value="${usuario.senha}"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="confirmarSenha" class="form-label">Confirmar
									Senha:</label>
							</div>
							<div class="col-md-3">
								<input type="password" id="confirmarSenha" name="confirmarSenha"
									class="form-control" placeholder="Confirmar Senha">
							</div>
						</div>

						<!-- Linha dos Botões -->
						<div class="row g-3 mt-3">
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botaoCadastrar" name="botao"
									value="Cadastrar" class="btn btn-outline-success"
									onclick="return validarSenhas()">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botaoAlterar" name="botao"
									value="Alterar" class="btn btn-outline-warning">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botaoExcluir" name="botao"
									value="Excluir" class="btn btn-outline-danger">
							</div>
							<div class="col-md-2 d-grid text-center"></div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botaoListar" name="botao"
									value="Listar" class="btn btn-outline-dark">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botaoLimpar" name="botao"
									value="Limpar" class="btn btn-outline-secondary">
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
	<div class="container py-4 text-center d-flex justify-content-center"
		align="center">
		<c:if test="${not empty usuarios}">
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th class="titulo-tabela" colspan="6"
							style="text-align: center; font-size: 32px;">Lista de
							Usuários</th>
					</tr>
					<tr class="table-dark">
						<th> </th>
						<th>CPF</th>
						<th>Nome</th>
						<th>Nv. Acesso</th>
						<th>E-mail</th>
						<th>Excluir</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="u" items="${usuarios}">
						<tr>
							<td style="text-align: center;">
								<button class="btn btn-info" name="opcao" value="${u.CPF}"
									onclick="editarUsuario(this.value)"
									${u.CPF eq codigoEdicao ? 'checked' : ''}>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
									</svg>
								</button>
							</td>
							<td><c:out value="${u.CPF}" /></td>
							<td><c:out value="${u.nome}" /></td>
							<td><c:out value="${u.nivelAcesso}" /></td>
							<td><c:out value="${u.email}" /></td>
							<td style="text-align: center;">
								<button class="btn btn-danger"
									onclick="excluirUsuario('${u.CPF}')">Excluir</button>
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
