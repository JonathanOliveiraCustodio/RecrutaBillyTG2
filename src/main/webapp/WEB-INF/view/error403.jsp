<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script
	src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
<title>Acesso Negado - Erro 403</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<h1 class="display-4 text-center">Acesso Negado</h1>
		<h2 class="display-4 text-center">Erro 403</h2>
		<p class="lead text-center">Desculpe, você não tem permissão para
			acessar esta página ou recurso.</p>
		<p class="text-center">Se você acha que está vendo esta página por
			engano, entre em contato com o suporte ou tente acessar outra página.</p>
		<p class="text-center">
			Você pode voltar para a <a
				href="${pageContext.request.contextPath}/index">página inicial</a>
			ou explorar outras áreas do site:
		</p>

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
