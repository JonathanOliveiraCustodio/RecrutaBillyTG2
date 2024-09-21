<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<title>Login</title>

</head>
<body>
	<div>
		<jsp:include page="menuLogin.jsp" />
	</div>
	<div class="container py-4">
		<div
			class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow center-form">
			<div class="container-fluid py-6">
				<h1 class="display-5 fw-bold">Sistema Gerencial Recruta Billy -
					Login</h1>
				<div class="container">
					<form action="<c:url value='/login' />" method="post"
						class="row g-3 mt-3 justify-content-center">
						<!-- Primeira Linha: E-mail -->
						<div class="row g-3 justify-content-center">
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="email" name="email" class="form-control"
										placeholder="E-mail"> <label for="email">E-mail</label>
								</div>
							</div>
						</div>
						<!-- Segunda Linha: Senha -->
						<div class="row g-3 mt-2 justify-content-center">
							<div class="col-md-4">
								<div class="form-floating">
									<input type="password" id="senha" name="senha"
										class="form-control" placeholder="Senha"> <label
										for="senha">Senha</label>
								</div>
							</div>
						</div>
						<!-- Terceira Linha: Botão Login -->
						<div class="row g-3 mt-2 justify-content-center">
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Login"
									class="btn btn-primary">
							</div>
						</div>

						<!-- Quarta Linha: Esqueceu a Senha -->
						<div class="row g-3 mt-2 justify-content-center">
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao"
									value="Esqueceu a Senha?" class="btn btn-link">
							</div>
						</div>
					</form>
					<c:if test="${not empty errorMessage}">
						<div class="error-message">
							<h2 class="text-danger">
								<b><c:out value="${errorMessage}" /></b>
							</h2>
						</div>
					</c:if>
					<div>
						<jsp:include page="footer.jsp" />
					</div>
				</div>

			</div>
		</div>
	</div>
	<br />
</body>
</html>
