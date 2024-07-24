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
<title>Pedido</title>
<script src="${pageContext.request.contextPath}/resources/js/pedido.js"></script>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-1">
				<h1 class="display-6 fw-bold">Manutenção de Pedido</h1>

				<form action="pedido" method="post"
					onsubmit="return validarFormulario(event);" class="row g-3 mt-3">
					<!-- Primeira Linha: Código, Nome, Descrição -->
					<div class="row g-3">
						<div class="col-md-1 d-flex align-items-center">
							<label for="pedido" class="form-label">Código:</label>
						</div>
						<div class="col-md-2">
							<input class="form-control" type="number" min="0" step="1"
								id="codigo" name="codigo" placeholder="Código"
								value='<c:out value="${pedido.codigo}"></c:out>'>
						</div>
						<div class="col-md-1">
							<input type="submit" id="botaoBuscar" name="botao"
								class="btn btn-primary" value="Buscar"
								onclick="return validarBusca()">
						</div>

						<div class="col-md-1 d-flex align-items-center">
							<label for="nome" class="form-label">Nome:</label>
						</div>
						<div class="col-md-3">
							<input class="form-control" type="text" id="nome" name="nome"
								placeholder="Nome do Pedido"
								value='<c:out value="${pedido.nome}"></c:out>'>
						</div>

						<div class="col-md-1 d-flex align-items-center">
							<label for="descricao" class="form-label">Descrição:</label>
						</div>
						<div class="col-md-3">
							<input class="form-control" type="text" id="descricao"
								name="descricao" placeholder="Descrição"
								value='<c:out value="${pedido.descricao}"></c:out>'>
						</div>
					</div>

					<!-- Segunda Linha: Cliente, Estado -->
					<div class="row g-3 mt-2">
						<div class="col-md-1 d-flex align-items-center">
							<label for="codigoCliente" class="form-label">Cliente:</label>
						</div>
						<div class="col-md-3">
							<select class="form-select" id="cliente" name="cliente"
								onclick="mostrarValor(this.value)">
								<option value="0">Escolha um Cliente</option>
								<c:forEach var="c" items="${clientes}">
									<c:if
										test="${empty cliente or c.codigo ne pedido.cliente.codigo}">
										<option value="${c.codigo}">
											<c:out value="${c.nome}" />
										</option>
									</c:if>
									<c:if test="${c.codigo eq pedido.cliente.codigo}">
										<option value="${c.codigo}" selected>
											<c:out value="${c.nome}" />
										</option>
									</c:if>
								</c:forEach>
							</select>
						</div>

						<div class="col-md-1 d-flex align-items-center">
							<label for="estado" class="form-label">Estado:</label>
						</div>
						<div class="col-md-3">
							<select class="form-select" id="estado" name="estado">
								<option value="">Escolha um Estado</option>
								<option value="Em andamento"
									<c:if test="${pedido.estado eq 'Em andamento'}">selected</c:if>>Em
									andamento</option>
								<option value="Recebido"
									<c:if test="${pedido.estado eq 'Recebido'}">selected</c:if>>Recebido</option>
								<option value="Pedido Finalizado"
									<c:if test="${pedido.estado eq 'Pedido Finalizado'}">selected</c:if>>Pedido
									Finalizado</option>
								<option value="Despachado"
									<c:if test="${pedido.estado eq 'Despachado'}">selected</c:if>>Despachado</option>
							</select>
						</div>
					</div>

					<!-- Linha dos Botões -->
					<div class="row g-3 mt-3">
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Cadastrar"
								class="btn btn-success">
						</div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Alterar"
								class="btn btn-warning">
						</div>

						<div class="col-md-2 d-grid text-center"></div>
						<div class="col-md-2 d-grid text-center"></div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Listar"
								class="btn btn-dark">
						</div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Limpar"
								class="btn btn-secondary">
						</div>
					</div>
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

		<div class="text-center mt-4">
			<c:if test="${not empty pedidos }">
				<table class="table table-striped">
					<thead>
						<tr>
							<th colspan="10" class="text-center">Lista de Pedidos</th>
						</tr>
						<tr class="table-dark">
							<th></th>
							<th>Código</th>
							<th>Nome Pedido</th>
							<th>Código Cliente</th>
							<th>Nome Cliente</th>
							<th>Data Pedido</th>
							<th>Produtos</th>
							<th>Valor Total</th>
							<th>Estado Atual</th>
							<th>Finalizar</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="p" items="${pedidos }">
							<tr>
								<td style="text-align: center;">
									<button class="btn btn-outline-info" name="opcao"
										value="${p.codigo}" onclick="editarPedido(this.value)"
										${p.codigo eq codigoEdicao ? 'checked' : ''}>
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
											fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
										  <path
												d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
										</svg>
									</button>
								</td>
								<td><c:out value="${p.codigo}" /></td>
								<td><c:out value="${p.nome}" /></td>
								<td><c:out value="${p.cliente.codigo}" /></td>
								<td><c:out value="${p.cliente.nome}" /></td>
								<td><fmt:formatDate value="${p.dataPedido}"
										pattern="dd/MM/yyyy" /></td>
								<td>
									<button
										onclick="window.location.href='produtosPedido?pedido=${p.codigo}'"
										class="btn btn-info">Adicionar</button>
								</td>


								<td><fmt:formatNumber value="${p.valorTotal}"
										type="currency" currencySymbol="R$" /></td>

								<td><c:out value="${p.estado}" /></td>
								<td>
									<form action="pedido" method="post">
										<input type="hidden" name="codigo" value="${p.codigo}">
										<input type="hidden" name="cliente"
											value="${p.cliente.codigo}"> <input type="hidden"
											id="botao" name="botao" value="Finalizar Pedido">
										<button type="submit" class="btn btn-outline-dark">Finalizar
											Pedido</button>


									</form>
								<td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
	</div>
	<div>
		<jsp:include page="footer.jsp" />
	</div>

</body>
</html>
