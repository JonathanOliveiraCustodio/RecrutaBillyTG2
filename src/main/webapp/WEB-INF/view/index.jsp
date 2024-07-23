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
<title>Página Inicial</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<h1 class="display-4 text-center">Bem-vindo Recruta Billy!</h1>
		<p class="lead text-center">Aqui você pode acessar as principais
			funcionalidades.</p>

		<div class="container">
			<div class="row justify-content-center text-center">
				<div class="col-md-2 mb-3">
					<a href="${pageContext.request.contextPath}/cliente"
						class="btn btn-success">Gerenciar Clientes</a>
				</div>
				<div class="col-md-2 mb-3">
					<a href="${pageContext.request.contextPath}/produto"
						class="btn btn-dark">Gerenciar Produtos</a>
				</div>
				<div class="col-md-2 mb-3">
					<a href="${pageContext.request.contextPath}/pedido"
						class="btn btn-success">Gerenciar Pedidos</a>
				</div>
			</div>
		</div>

	</div>

	<div>
		<jsp:include page="footer.jsp" />
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-2m7dTgB0zr7FOpnlzr43I2k1vF8h5U9pFT0f3qlv1M4kv+4iTbiTY18VJhGtp7tt"
		crossorigin="anonymous"></script>
</body>
</html>