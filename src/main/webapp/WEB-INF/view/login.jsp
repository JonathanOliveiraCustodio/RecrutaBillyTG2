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
						<label for="email" class="form-label col-md-2">E-mail:</label>
						<div class="col-md-4">
							<input type="text" id="email" name="email" class="form-control"
								placeholder="E-mail">
						</div>
						<div class="col-md-0"></div>
						<label for="senha" class="form-label col-md-2">Senha:</label>
						<div class="col-md-4">
							<input type="password" id="senha" name="senha"
								class="form-control" placeholder="Senha">
						</div>
						<div class="col-md-0"></div>

						<div class="col-md-2 d-grid">
							<input type="submit" id="botao" name="botao" value="Login"
								class="btn btn-primary">
						</div>
						<div class="col-md-0"></div>
						<div class="col-md-0 d-grid">
							<input type="submit" id="botao" name="botao" value="Esqueceu a Senha?"
								class="btn btn-link">
						</div>
						
						
					</form>

					<div>
						<jsp:include page="footer.jsp" />
					</div>
				</div>
				<c:if test="${not empty errorMessage}">
					<div class="error-message">
						<h2 class="text-danger">
							<b><c:out value="${errorMessage}" /></b>
						</h2>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	<br />
</body>
</html>
