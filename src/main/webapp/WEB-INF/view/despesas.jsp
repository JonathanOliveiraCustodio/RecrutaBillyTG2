<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<title>Despesas</title>
</head>
<body>
	<div>
    	<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<c:if test="${nivelAcesso == 'admin' }">
			<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
				<div class="container-fluid py-1">
					<h1 class="display-6 fw-bold">Gestão de Despesas</h1>
					
					<form action="despesa" method="post" class="row g-3 mt-3">
					
						<!-- Linha de visualização das métricas -->
						<div class="row g-3 justify-content-center bg-body-secondary">
							<div class="col-md-1 d-flex align-items-center">
								<label for="entrada" class="form-label">R$ de Entrada:</label>
							</div>
							<div class="col-md-2">
								<input type="text" id="entrada" name="entrada" class="form-control" placeholder="R$ 0,00" disabled >
							</div> 
							
							<div class="col-md-1 d-flex align-items-center">
								<label for="saida" class="form-label">R$ de Saída:</label>
							</div>
							<div class="col-md-2">
								<input type="text" id="saida" name="saida" class="form-control" placeholder="R$ 0,00" disabled >
							</div>
							
							<div class="col-md-1 d-flex align-items-center">
								<label for="saldo" class="form-label">% de Gastos:</label>
							</div>
							<div class="col-md-1">
								<input type="text" id="saldo" name="saldo" class="form-control" placeholder="R$ 0,00" disabled >
							</div>
						</div>
						
						<!-- O resto para operação de CRUD -->
						<div class="row g-3 mt-2">
							<div class="cod-md-1 d-flex align-items-center">
								<label for="codigo" class="form-label"></label>
							</div>
							<div class="cod-md-3">
								<input type="number" min="0" step="1" id="codigo" name="codigo"
									class="form-control" placeholder="Código"
									value='<c:out value="${cliente.codigo }"></c:out>'>
							</div>
						</div>
					</form>
				</div>
			</div>
		</c:if>
	</div>
</body>
</html>