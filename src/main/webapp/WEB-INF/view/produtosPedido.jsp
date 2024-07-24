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
<title>Gerenciar Produtos Pedido</title>
<script src="${pageContext.request.contextPath}/resources/js/produtosPedido.js"></script>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-1">
				<h1 class="display-6 fw-bold">Gerenciar Produtos de um Pedido</h1>
				<form action="produtosPedido" method="post"
					onsubmit="return validarFormulario(event);" class="container mt-3">
					<input type="hidden" id="pedido" name="pedido"
						value='<c:out value="${pedido}"></c:out>'>

					<!-- Linha do Formulário -->
					<div class="row g-3">
						<!-- Produto -->
						<div class="col-md-6 d-flex align-items-center">
							<label for="produto" class="form-label me-2">Produto:</label> <select
								class="form-select flex-grow-1" id="produto" name="produto">
								<option value="0">Escolha um Produto</option>
								<c:forEach var="p" items="${produtos}">
									<c:if
										test="${empty pedidoProduto or p.codigo ne pedidoProduto.produto.codigo}">
										<option value="${p.codigo}">
											<c:out value="${p.nome}" />
										</option>
									</c:if>
									<c:if test="${p.codigo eq pedidoProduto.produto.codigo}">
										<option value="${p.codigo}" selected="selected">
											<c:out value="${p.nome}" />
										</option>
									</c:if>
								</c:forEach>
							</select>
						</div>

						<!-- Quantidade -->
						<div class="col-md-6 d-flex align-items-center">
							<label for="quantidade" class="form-label me-2">Quantidade:</label>
							<input class="form-control flex-grow-1" type="number" min="1"
								step="1" id="quantidade" name="quantidade"
								placeholder="Quantidade"
								value='<c:out value="${pedidoProduto.quantidade}"></c:out>'>
						</div>
					</div>
					<!-- Linha dos Botões -->
					<div class="row g-3 mt-3">
					<div class="col-md-4 d-grid text-center"></div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Cadastrar"
								class="btn btn-success">
						</div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Excluir"
								class="btn btn-danger">
						</div>
					</div>
				</form>

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
			<c:if test="${not empty saida }">
				<h2 style="color: #198754;">
					<b><c:out value="${saida}" /></b>
				</h2>
			</c:if>
		</div>

		<div align="center" class="mt-4">
			<c:if test="${not empty pedidoProdutos }">
				<table class="table table-striped">
					<thead>
						<tr>
							<th class="titulo-tabela" colspan="6"
								style="text-align: center; font-size: 23px;">Lista de
								Produtos de um Pedido</th>
						</tr>
						<tr class="table-dark">
							<th>Nome</th>
							<th>Categoria</th>
							<th>Descrição</th>
							<th>Valor</th>
							<th>Quantidade</th>
							<th>Ação</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="p" items="${pedidoProdutos}">
							<tr>
								<td><c:out value="${p.produto.nome }" /></td>
								<td><c:out value="${p.produto.categoria}" /></td>
								<td><c:out value="${p.produto.descricao}" /></td>
								<td><fmt:formatNumber value="${p.produto.valorUnitario}"
										type="currency" currencySymbol="R$" /></td>
								<td><c:out value="${p.quantidade }" /></td>
								<td>
									<form action="produtosPedido" method="post">
										<input type="hidden" name="produto" value="${p.codigoProduto}">
										<input type="hidden" name="pedido" value="${p.codigoPedido}">
										<input type="hidden" name="botao" value="Excluir">
										<button type="submit" class="btn btn-danger">Excluir</button>
									</form>
								</td>
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
