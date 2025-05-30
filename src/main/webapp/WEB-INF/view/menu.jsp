<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<title>Menu</title>
<script>
	
</script>
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-body-tertiary"
		data-bs-theme="dark">
		<div class="container-fluid">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
				aria-controls="navbarNavDropdown" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<div class="collapse navbar-collapse" id="navbarNavDropdown">
					<a
						class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none"
						href="${pageContext.request.contextPath}/index">
						<h3>
							<img
								src="${pageContext.request.contextPath}/resources/imagens/logo.png"
								style="width: 27px; height: 27px;"> Recruta Billy
						</h3>
					</a>

					<ul class="nav nav-pills">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle px-3 link-body-emphasis" href="#"
							id="navbarDropdown" role="button" data-bs-toggle="dropdown"
							aria-expanded="false"> Gestão de Cadastros </a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/cliente">Cliente</a></li>
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/equipamento">Equipamento</a></li>
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/fornecedor">Fornecedor</a></li>
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/funcionario">Funcionário</a></li>
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/insumo">Insumo</a></li>
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/categoriaproduto">Categoria
										de Produto</a></li>
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/patente">Patente</a></li>
									<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/nometarjeta">Nome Tarjeta</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle px-3 link-body-emphasis" href="#"
							id="financeDropdown" role="button" data-bs-toggle="dropdown"
							aria-expanded="false"> Gestão Financeira </a>
							<ul class="dropdown-menu" aria-labelledby="financeDropdown">
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/despesas">Despesas</a></li>
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/orcamento">Orçamento</a></li>
							</ul></li>
							
							<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle px-3 link-body-emphasis" href="#"
							id="financeDropdown" role="button" data-bs-toggle="dropdown"
							aria-expanded="false"> Gestão de Estoque </a>
							<ul class="dropdown-menu" aria-labelledby="financeDropdown">
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/produto">Produto</a></li>
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/tarjeta">Tarjeta</a></li>
							</ul></li>
							
						<li class="nav-item"><a
							class="nav-link px-3 link-body-emphasis"
							href="${pageContext.request.contextPath}/pedido">Pedido</a></li>
				
						<li class="nav-item"><a
							class="nav-link px-3 link-body-emphasis"
							href="${pageContext.request.contextPath}/relatorio">Relatório</a></li>

						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle px-3 link-body-emphasis" href="#"
							id="financeDropdown" role="button" data-bs-toggle="dropdown"
							aria-expanded="false"> Configurações </a>
							<ul class="dropdown-menu" aria-labelledby="financeDropdown">
								<li class="nav-item"><a
									class="nav-link px-3 link-body-emphasis"
									href="${pageContext.request.contextPath}/configuracoes">Configurações
										Operacionais</a></li>
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/log">Logs de
										Acesso</a></li>
							</ul></li>

						<li class="nav-item"><a
							class="nav-link px-3 link-body-emphasis" href="#"
							onclick="logout()">Logout</a></li>
					</ul>

				</div>
			</div>
		</div>
	</nav>
	<script>
		function logout() {
			window.location.href = "${pageContext.request.contextPath}/logout";
		}
	</script>
</body>
</html>