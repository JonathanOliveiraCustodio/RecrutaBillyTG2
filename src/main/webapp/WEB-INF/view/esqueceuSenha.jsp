<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js">
	
</script>
<script
	src="${pageContext.request.contextPath}/resources/js/esqueceuSenha.js"></script>
<title>Recuperação de Senha</title>
</head>
<body>
	<div>
		<jsp:include page="menuLogin.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-1">
				<h1 class="display-6 fw-bold">Recuperação de Senha</h1>
				<form action="esqueceuSenha" method="post"
					onsubmit="return validarFormulario(event);"
					class="row g-3 mt-3 justify-content-center">
					<!-- Primeira Linha: E-mail e CPF -->
					<div class="row g-3 justify-content-center">
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
					</div>

					<!-- Segunda Linha: Nova Senha e Confirmar Nova Senha -->
					<div class="row g-3 mt-2 justify-content-center">
						<div class="col-md-4">
							<div class="form-floating">
								<input type="password" class="form-control" id="novaSenha"
									name="novaSenha" placeholder="Nova Senha"> <label
									for="novaSenha">Nova Senha</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input type="password" class="form-control" id="confirmarSenha"
									name="confirmarSenha" placeholder="Confirmar Nova Senha">
								<label for="confirmarSenha">Confirmar Nova Senha</label>
							</div>
						</div>
					</div>

					<!-- Terceira Linha: Botão Alterar Senha -->
					<div class="row g-3 mt-2 justify-content-center">
						<div class="col-md-2 d-grid text-center">
							<button type="submit" class="btn btn-primary"
								value="Alterar Senha">Alterar Senha</button>

						</div>
					</div>
				</form>
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
