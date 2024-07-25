<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/insumo.js"></script>
<title>Insumo</title>

</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<c:if test="${nivelAcesso == 'admin'}">
			<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
				<div class="container-fluid py-1">
					<h1 class="display-6 fw-bold">Manutenção de Insumo</h1>
					<form action="insumo" method="post" class="row g-3 mt-3"
						onsubmit="return validarFormulario(event);">
						<!-- Primeira Linha: Código, Nome, Preço de Venda -->
						<div class="row g-3">
							<div class="col-md-1 d-flex align-items-center">
								<label for="codigo" class="form-label">Código:</label>
							</div>
							<div class="col-md-2">
								<input class="form-control" type="number" min="0" step="1"
									id="codigo" name="codigo" placeholder="Código"
									value='<c:out value="${insumo.codigo}"></c:out>'>
							</div>
							<div class="col-md-1">
								<input type="submit" id="botaoBuscar" name="botao"
									class="btn btn-primary mb-3" value="Buscar"
									onclick="return validarBusca()">
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="nome" class="form-label">Nome:</label>
							</div>
							<div class="col-md-3">
								<input class="form-control" type="text" id="nome" name="nome"
									placeholder="Nome"
									value='<c:out value="${insumo.nome}"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="precoVenda" class="form-label">Preço de
									Custo:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="precoCompra" name="precoCompra"
									class="form-control" placeholder="Preço de Custo"
									value='<c:out value="${insumo.precoCompra}"></c:out>'>
							</div>
						</div>

						<!-- Segunda Linha: Preço de Custo, Quantidade, Unidade -->
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="precoCusto" class="form-label">Preço de
									Venda:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="precoVenda" name="precoVenda"
									class="form-control" placeholder="Preço de Venda"
									value='<c:out value="${insumo.precoVenda}"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="quantidade" class="form-label">Quantidade:</label>
							</div>
							<div class="col-md-3">
								<input type="number" id="quantidade" name="quantidade"
									class="form-control" placeholder="Quantidade"
									value='<c:out value="${insumo.quantidade}"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="unidade" class="form-label">Unidade:</label>
							</div>
							<div class="col-md-3">
								<select id="unidade" name="unidade" class="form-select">
									<option value="">Escolha uma Unidade</option>
									<option value="ml"
										<c:if test="${insumo.unidade eq 'ml'}">selected</c:if>>ml</option>
									<option value="kg"
										<c:if test="${insumo.unidade eq 'kg'}">selected</c:if>>kg</option>
									<option value="unidade"
										<c:if test="${insumo.unidade eq 'unidade'}">selected</c:if>>unidade</option>
									<option value="m²"
										<c:if test="${insumo.unidade eq 'm²'}">selected</c:if>>m²</option>
								</select>
							</div>
						</div>

						<!-- Terceira Linha: Fornecedor, Data de Compra -->
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="fornecedor" class="form-label">Fornecedor:</label>
							</div>
							<div class="col-md-3">
								<select id="fornecedor" name="fornecedor" class="form-select">
									<option value="0">Escolha um Fornecedor</option>
									<c:forEach var="f" items="${fornecedores}">
										<option value="${f.codigo}"
											<c:if test="${f.codigo eq insumo.fornecedor.codigo}">selected</c:if>>
											<c:out value="${f}" />
										</option>
									</c:forEach>
								</select>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="dataCompra" class="form-label">Data de
									Compra:</label>
							</div>
							<div class="col-md-3">
								<input type="date" id="dataCompra" name="dataCompra"
									class="form-control"
									value='<c:out value="${insumo.dataCompra}"></c:out>'>
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
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Excluir"
									class="btn btn-danger">
							</div>
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
		</c:if>
	</div>

	<div align="center">
		<c:if test="${not empty erro}">
			<h2 style="color: black;">
				<b><c:out value="${erro}" /></b>
			</h2>
		</c:if>
	</div>


	<div align="center">
		<c:if test="${not empty saida }">
			<h2 style="color: black;">
				<b><c:out value="${saida}" /></b>
			</h2>
		</c:if>
	</div>

	<div class="container py-4 text-center d-flex justify-content-center"
		align="center">
		<c:if test="${not empty insumos }">
			<table class="table table-striped">
				<thead>
					<tr>
						<th class="titulo-tabela" colspan="11"
							style="text-align: center; font-size: 23px;">Lista de
							Insumos</th>
					</tr>
					<tr class="table-dark">
						<th></th>
						<th>Código</th>
						<th>Nome</th>
						<th>Preço Custo</th>
						<th>Preço Venda</th>
						<th>Quantidade</th>
						<th>Unidade</th>
						<th>Fornecedor</th>
						<th>Data Compra</th>
						
						<th>Excluir</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<c:forEach var="i" items="${insumos}">
						<tr>
							<td style="text-align: center;">
								<button class="btn btn-outline-info" name="opcao"
									value="${i.codigo}" onclick="editarInsumo(this.value)"
									${i.codigo eq codigoEdicao ? 'checked' : ''}>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									  <path
											d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
									</svg>
								</button>
							</td>
							<td><c:out value="${i.codigo}" /></td>
							<td><c:out value="${i.nome}" /></td>
							
							<td><fmt:formatNumber value="${i.precoCompra}"
										type="currency" currencySymbol="R$" /></td>
							<td><fmt:formatNumber value="${i.precoVenda}"
										type="currency" currencySymbol="R$" /></td>
							<td><c:out value="${i.quantidade}" /></td>
							<td><c:out value="${i.unidade}" /></td>
							<td><c:out value="${i.fornecedor.nome}" /></td>							
							<td><fmt:formatDate value="${i.dataCompra}"
									pattern="dd/MM/yyyy" /></td>
							<td style="text-align: center;">
								<button class="btn btn-danger"
									onclick="excluirInsumo('${i.codigo}')">Excluir</button>
							</td>
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
