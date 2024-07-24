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
<title>Produto</title>
<script src="${pageContext.request.contextPath}/resources/js/produto.js"></script>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-1">
				<h1 class="display-6 fw-bold">Manutenção de Produto</h1>
				<form action="produto" method="post"
					onsubmit="return validarFormulario(event);" class="row g-3 mt-3">
					<!-- Primeira Linha: Código, Nome, Categoria -->
					<div class="row g-3">
						<div class="col-md-1 d-flex align-items-center">
							<label for="codigo" class="form-label">Código:</label>
						</div>
						<div class="col-md-2">
							<input class="form-control" type="number" min="0" step="1"
								id="codigo" name="codigo" placeholder="Código"
								value='<c:out value="${produto.codigo}"></c:out>'>
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
								placeholder="Nome do Produto"
								value='<c:out value="${produto.nome}"></c:out>'>
						</div>

						<div class="col-md-1 d-flex align-items-center">
							<label for="categoria" class="form-label">Categoria:</label>
						</div>
						<div class="col-md-3">
							<input class="form-control" type="text" id="categoria"
								name="categoria" placeholder="Categoria"
								value='<c:out value="${produto.categoria}"></c:out>'>
						</div>
					</div>

					<!-- Segunda Linha: Descrição, Valor, Status -->
					<div class="row g-3 mt-2">
						<div class="col-md-1 d-flex align-items-center">
							<label for="descricao" class="form-label">Descrição:</label>
						</div>
						<div class="col-md-3">
							<input class="form-control" type="text" id="descricao"
								name="descricao" placeholder="Descrição"
								value='<c:out value="${produto.descricao}"></c:out>'>
						</div>

						<div class="col-md-1 d-flex align-items-center">
							<label for="valorUnitario" class="form-label">Valor:</label>
						</div>
						<div class="col-md-3">
							<input class="form-control" type="text" id="valorUnitario"
								name="valorUnitario" placeholder="Valor Unitário"
								value='<c:out value="${produto.valorUnitario}"></c:out>'>
						</div>

						<div class="col-md-1 d-flex align-items-center">
							<label for="status" class="form-label">Status:</label>
						</div>
						<div class="col-md-3">
							<select class="form-select" id="status" name="status">
								<option value="">Escolha um Status</option>
								<option value="Não Aplicável"
									<c:if test="${produto.status eq 'Não Aplicável'}">selected</c:if>>Não
									Aplicável</option>
								<option value="Em Produção"
									<c:if test="${produto.status eq 'Em Produção'}">selected</c:if>>Em
									Produção</option>
								<option value="Disponível"
									<c:if test="${produto.status eq 'Disponível'}">selected</c:if>>Disponível</option>
							</select>
						</div>
					</div>

					<!-- Terceira Linha: Quantidade, Ref Estoque -->
					<div class="row g-3 mt-2">
						<div class="col-md-1 d-flex align-items-center">
							<label for="quantidade" class="form-label">Quantidade:</label>
						</div>
						<div class="col-md-3">
							<input class="form-control" type="number" min="0" step="1"
								id="quantidade" name="quantidade" placeholder="Quantidade"
								value='<c:out value="${produto.quantidade}"></c:out>'>
						</div>

						<div class="col-md-1 d-flex align-items-center">
							<label for="refEstoque" class="form-label">Ref Est:</label>
						</div>
						<div class="col-md-3">
							<input class="form-control" type="text" id="refEstoque"
								name="refEstoque" placeholder="Referência Estoque"
								value='<c:out value="${produto.refEstoque}"></c:out>'>
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
	</div>
	<div align="center">
		<c:if test="${not empty erro}">
			<h2 style="color: #dc3545;">
				<b><c:out value="${erro}" /></b>
			</h2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty saida}">
			<h2 style="color: #198754;">
				<b><c:out value="${saida}" /></b>
			</h2>
		</c:if>
	</div>

	<div class="container py-4 text-center d-flex justify-content-center">
		<c:if test="${not empty produtos}">
			<table class="table table-striped">
				<thead>
					<tr>
						<th class="titulo-tabela" colspan="10"
							style="text-align: center; font-size: 23px;">Lista de
							Produtos</th>
					</tr>
					<tr class="table-dark">
						<th> </th>
						<th>Código</th>
						<th>Nome</th>
						<th>Categoria</th>
						<th>Descrição</th>
						<th>Valor</th>
						<th>Status</th>
						<th>Quantidade</th>
						<th>Ref Est</th>
						<th>Insumos</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="p" items="${produtos}">
						<tr>
							<td style="text-align: center;">
								<button class="btn btn-outline-info" name="opcao" value="${p.codigo}"
									onclick="editarProduto(this.value)"
									${p.codigo eq codigoEdicao ? 'checked' : ''}>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
									</svg>
								</button>
							</td>
							<td><c:out value="${p.codigo}" /></td>
							<td><c:out value="${p.nome}" /></td>
							<td><c:out value="${p.categoria}" /></td>
							<td><c:out value="${p.descricao}" /></td>
							<td><fmt:formatNumber value="${p.valorUnitario}"
									type="currency" currencySymbol="R$" /></td>
							<td><c:out value="${p.status}" /></td>
							<td><c:out value="${p.quantidade}" /></td>
							<td><c:out value="${p.refEstoque}" /></td>
							<td>
								<button
									onclick="window.location.href='insumosProduto?produto=${p.codigo}'"
									class="btn btn-info">Adicionar</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
	<div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>
