<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/styles.css">
<script
	src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/esqueceuSenha.js"></script>
<title>Recuperação de Senha</title>
<!-- Adicione os scripts do Bootstrap para os modais -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div>
		<jsp:include page="menuLogin.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-1">
				<h1 class="display-6 fw-bold">Recuperação de Senha</h1>
				<form action="recuperarsenha" method="post" class="row g-3 mt-3"
					onsubmit="return validarFormulario(event);">
					<!-- Primeira Linha: E-mail e CPF -->
					<div class="row g-3">
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" class="form-control" id="email" name="email"
									placeholder="E-mail"> <label for="email">E-mail</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" class="form-control" id="CPF" name="CPF"
									placeholder="CPF"> <label for="cpf">CPF</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input type="password" class="form-control" id="novaSenha"
									name="novaSenha" placeholder="Nova Senha"> <label
									for="novaSenha">Nova Senha</label>
							</div>
						</div>
					</div>

					<!-- Segunda Linha: Nova Senha e Confirmar Nova Senha -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<input type="password" class="form-control" id="confirmarSenha"
									name="confirmarSenha" placeholder="Confirmar Nova Senha">
								<label for="confirmarSenha">Confirmar Nova Senha</label>
							</div>
						</div>

						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" class="form-control" id="codigoRecuperacao"
									name="codigoRecuperacao" placeholder="Código SMS" maxlength="6">
								<label for="codigoRecuperacao">Código SMS</label>
							</div>
						</div>

						<div class="col-md-4">
							<!-- Botão para abrir o modal -->
							<button type="button"
								class="btn btn-outline-secondary btn-align d-flex align-items-center w-100"
								data-toggle="modal" data-target="#codigoModal">
								Solicitar Código de Recuperação</button>
						</div>
					</div>

					<!-- Quarta Linha: Botão Alterar Senha -->
					<div class="row g-3 mt-2 justify-content-center">
						<div class="col-md-2 d-grid text-center">
							<button type="submit" class="btn btn-primary btn-align"
								value="Alterar Senha">Alterar Senha</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Modal para solicitar código de recuperação -->
	<div class="modal fade" id="codigoModal" tabindex="-1" role="dialog"
		aria-labelledby="codigoModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="codigoModalLabel">Solicitar Código
						de Recuperação</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="solicitarCodigo" method="post" class="row g-3">
						<div class="form-group">
							<label for="cpfOuEmail">CPF ou E-mail</label> <input type="text"
								class="form-control" id="cpfOuEmail" name="cpfOuEmail"
								placeholder="CPF ou E-mail" required>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Fechar</button>
							<button type="submit" class="btn btn-primary">Solicitar
								Código</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div align="center">
		<c:if test="${not empty erro}">
			<h2 style="color: #dc3545;">
				<b><c:out value="${erro}" /></b>
			</h2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty saida}">
			<h2 style="color: #198754;">
				<b><c:out value="${saida}" /></b>
			</h2>
		</c:if>
	</div>
	<div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>
