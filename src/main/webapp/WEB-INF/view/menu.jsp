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
	<nav class="navbar navbar-expand-lg bg-body-tertiary" data-bs-theme="dark">
		<div class="container-fluid">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
				aria-controls="navbarNavDropdown" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<a
					class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none"
					href="${pageContext.request.contextPath}/index">
					<h3>
						<svg xmlns="http://www.w3.org/2000/svg" width="26" height="26"
							fill="currentColor" class="bi bi-pencil-square"
							viewBox="0 0 16 16">
						<path
								d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
						<path fill-rule="evenodd"
								d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
					</svg>
						Recruta Billy
					</h3>
				</a>

				<ul class="nav nav-pills">
				
				<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle px-3 link-body-emphasis" href="#"
						id="navbarDropdown" role="button" data-bs-toggle="dropdown"
						aria-expanded="false"> Controle de Cadastros </a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/cliente">Cliente</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/equipamento">Equipamento</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/fornecedor">Fornecedor</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/insumo">Insumo</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/usuario">Usuário</a></li>
						</ul></li>
				
				
					<li class="nav-item"><a
						class="nav-link px-3 link-body-emphasis"
						href="${pageContext.request.contextPath}/despesas">Despesas</a></li>
						
					<li class="nav-item"><a
						class="nav-link px-3 link-body-emphasis"
						href="${pageContext.request.contextPath}/pedido">Pedido</a></li>
					<li class="nav-item"><a
						class="nav-link px-3 link-body-emphasis"
						href="${pageContext.request.contextPath}/produto">Produto</a></li>
						
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle px-3 link-body-emphasis" href="#"
						id="navbarDropdown" role="button" data-bs-toggle="dropdown"
						aria-expanded="false"> Relatório </a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/relatorio">Simples</a></li>
							<li><a class="dropdown-item" href="#">Analítico</a></li>
						</ul></li>
					<li class="nav-item"><a
						class="nav-link px-3 link-body-emphasis" href="#"
						onclick="logout()">Logout</a></li>
				</ul>
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