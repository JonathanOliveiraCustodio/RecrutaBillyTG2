<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pagina Inicial</title>
</head>
<body>
	<script
		src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/index.js"></script>

	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-1">
				<h1 class="display-6 fw-bold">Bem-Vindo Recruta Billy</h1>
				<form id="index" action="index" method="post" class="row g-3 mt-3">
					<!-- Campo oculto para armazenar a escolha -->
					<input type="hidden" id="escolhaInput" name="escolha">

					<!-- Dashboard Section -->
					<div class="container mt-5">
						<h2 class="text-center mb-4">Dashboard de Operações</h2>
						<div class="row g-4">
							<!-- Quantos Orçamentos -->
							<div class="col-md-4">
								<div class="card text-center shadow-sm" style="cursor: pointer;"
									onclick="setEscolha('orcamentos')">
									<div class="card-body">
										<h5 class="card-title">Orçamentos</h5>
										<p class="card-text display-6">
											<c:out value="${totalOrcamentos}" />
										</p>
									</div>
								</div>
							</div>
							<!-- Pedidos em Andamento -->
							<div class="col-md-4">
								<div class="card text-center shadow-sm" style="cursor: pointer;"
									onclick="setEscolha('pedidosAndamento')">
									<div class="card-body">
										<h5 class="card-title">Pedidos em Andamento</h5>
										<p class="card-text display-6">
											<c:out value="${totalPedidoAndamento}" />
										</p>
									</div>
								</div>
							</div>
							<!-- Pedidos Recebidos -->
							<div class="col-md-4">
								<div class="card text-center shadow-sm" style="cursor: pointer;"
									onclick="setEscolha('pedidosRecebidos')">
									<div class="card-body">
										<h5 class="card-title">Pedidos Recebidos</h5>
										<p class="card-text display-6">
											<c:out value="${totalPedidosRecebidos}" />
										</p>
									</div>
								</div>
							</div>
							<!-- Pedidos Despachados -->
							<div class="col-md-4">
								<div class="card text-center shadow-sm" style="cursor: pointer;"
									onclick="setEscolha('pedidosDespachados')">
									<div class="card-body">
										<h5 class="card-title">Pedidos Despachados</h5>
										<p class="card-text display-6">
											<c:out value="${totalPedidosDespachados}" />
										</p>
									</div>
								</div>
							</div>
						</div>
						<!-- Lista de Pedidos Recentes -->
						<div class="row mt-5">
							<div class="col-md-12">
								<div class="card shadow-sm">
									<div class="card-body">
										<table class="table table-striped">
											<thead>
												<tr>
													<th class="titulo-tabela" colspan="5"
														style="text-align: center; font-size: 22px;"><c:out
															value="${tituloTabela}" /></th>
												</tr>
												<tr class="table-dark">
													<th>Código</th>
													<th>Cliente</th>
													<th>Data</th>
													<th>Status</th>
													<th>Valor</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="pedido" items="${pedidos}">
													<tr>
														<td><c:out value="${pedido.codigo}" /></td>
														<td><c:out value="${pedido.cliente.nome}" /></td>
														<td><fmt:formatDate value="${pedido.dataPedido}"
																pattern="dd/MM/yyyy" /></td>
														<td><c:out value="${pedido.estado}" /></td>
														<td><fmt:formatNumber value="${pedido.valorTotal}"
																type="currency" currencySymbol="R$" /></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<!-- End of Lista de Pedidos Recentes -->
					</div>
					<!-- End of Dashboard Section -->
				</form>

			</div>
		</div>

		<div class="text-center">
			<c:if test="${not empty erro}">
				<h2 class="text-danger">
					<b><c:out value="${erro}" /></b>
				</h2>
			</c:if>
		</div>

		<div class="text-center">
			<c:if test="${not empty saida }">
				<h2 class="text-success">
					<b><c:out value="${saida}" /></b>
				</h2>
			</c:if>
		</div>
	</div>
	<div>
		<jsp:include page="footer.jsp" />
	</div>

</body>
</html>
