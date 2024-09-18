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
<script
	src="${pageContext.request.contextPath}/resources/js/orcamento.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/styles.css">

<title>Orçamento</title>

</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-1">
				<h1 class="display-6 fw-bold">Manutenção de Orçamento</h1>
				<form action="orcamento" method="post"
					onsubmit="return validarFormulario(event);" class="row g-3 mt-3">
					<!-- Primeira Linha: Código, Nome, Descrição -->
					<div class="row g-3">
						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="number" min="0" step="1"
									id="codigo" name="codigo" placeholder="Código"
									value='<c:out value="${orcamento.codigo}"></c:out>' readonly>
								<label for="codigo">Código</label>
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-floating">
								<input class="form-control" type="text" id="nome" name="nome"
									placeholder="Nome do Orçamento"
									value='<c:out value="${orcamento.nome}"></c:out>'> <label
									for="nome">Nome</label>
							</div>
						</div>
						<div class="col-md-1">
							<button type="submit" id="botao" name="botao" value="Buscar"
								class="btn btn-outline-primary w-100 d-flex justify-content-center align-items-center"
								onclick="return validarBusca()" style="height: 56px;">
								<!-- Ícone SVG dentro do botão -->
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
            <path
										d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
        </svg>
							</button>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="text" id="descricao"
									name="descricao" placeholder="Descrição"
									value='<c:out value="${orcamento.descricao}"></c:out>'>
								<label for="descricao">Descrição</label>
							</div>
						</div>
					</div>

					<!-- Segunda Linha: Cliente, Estado -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<select class="form-select" id="cliente" name="cliente"
									onclick="mostrarValor(this.value)">
									<option value="0">Escolha um Cliente</option>
									<c:forEach var="c" items="${clientes}">
										<c:if
											test="${empty cliente or c.codigo ne orcamento.cliente.codigo}">
											<option value="${c.codigo}">
												<c:out value="${c.nome}" />
											</option>
										</c:if>
										<c:if test="${c.codigo eq orcamento.cliente.codigo}">
											<option value="${c.codigo}" selected>
												<c:out value="${c.nome}" />
											</option>
										</c:if>
									</c:forEach>
								</select> <label for="cliente">Cliente</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="text" id="status"
									name="status" placeholder="Pedido"
									value='<c:out value="${orcamento.status}"></c:out>' readonly>
								<label for="status">Status</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="text" id="valorTotal"
									name="valorTotal" placeholder="Valor Total"
									value='<c:out value="${orcamento.valorTotal}"></c:out>'
									oninput="formatarMoeda(this)"> <label for="valorTotal">Valor
									Total</label>
							</div>
						</div>
					</div>

					<!-- Terceira Linha: Tipo Pagamento, Observação -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<select class="form-select" id="formaPagamento"
									name="formaPagamento">
									<option value="">Escolha um Tipo Pagamento</option>
									<option value="PIX"
										<c:if test="${orcamento.formaPagamento eq 'PIX'}">selected</c:if>>PIX</option>
									<option value="Boleto"
										<c:if test="${orcamento.formaPagamento eq 'Boleto'}">selected</c:if>>Boleto</option>
									<option value="Cartão de Crédito"
										<c:if test="${orcamento.formaPagamento eq 'Cartão de Crédito'}">selected</c:if>>Cartão
										de Crédito</option>
									<option value="Mercado Pago"
										<c:if test="${orcamento.formaPagamento eq 'Mercado Pago'}">selected</c:if>>Mercado
										Pago</option>
									<option value="Transferência Bancária"
										<c:if test="${orcamento.formaPagamento eq 'Transferência Bancária'}">selected</c:if>>Transferência
										Bancária</option>
								</select> <label for="formaPagamento">Forma de Pagamento:</label>
							</div>
						</div>

						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="date" id="dataOrcamento"
									name="dataOrcamento" placeholder="Data Orçamento"
									value='<c:out value="${orcamento.dataOrcamento}"></c:out>'
									readonly> <label for="dataOrcamento">Data
									Orçamento:</label>
							</div>
						</div>
					</div>

					<!-- Quarta Linha: Observação -->
					<div class="row g-3 mt-2">
						<div class="col-md-12">
							<div class="form-floating">
								<textarea id="observacao" name="observacao" class="form-control"
									placeholder="Observações" rows="3" maxlength="800"><c:out
										value="${orcamento.observacao}"></c:out></textarea>
								<label for="observacao">Observação</label>
							</div>
						</div>
					</div>

					<!-- Linha dos Botões -->
					<div class="row g-3 mt-3">
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Cadastrar"
								class="btn btn-success btn-align">
						</div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Alterar"
								class="btn btn-warning btn-align">
						</div>
						<div class="col-md-2 d-grid text-center"></div>
						<div class="col-md-2 d-grid text-center"></div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Listar"
								class="btn btn-dark btn-align">
						</div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Limpar"
								class="btn btn-secondary btn-align">
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

		<div class="container py-4 text-center d-flex justify-content-center">
			<c:if test="${not empty orcamentos }">
				<div class="table-responsive w-100">
					<table class="table table-striped">
						<thead>
							<tr>
								<th class="titulo-tabela" colspan="10"
									style="text-align: center; font-size: 25px;">Lista de
									Orçamentos</th>
							</tr>
							<tr class="table-dark">
								<th></th>
								<th>Código</th>
								<th>Nome Orçamento</th>
								<th>Código Cliente</th>
								<th>Nome Cliente</th>
								<th>Data Orçamento</th>
								<th>Produtos</th>
								<th>Valor Total</th>
								<th>Status</th>
								<th>Efetivar</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="o" items="${orcamentos }">
								<tr>
									<td style="text-align: center;">
										<button class="btn btn-outline-dark" name="opcao"
											value="${o.codigo}" onclick="editarOrcamento(this.value)"
											${o.codigo eq codigoEdicao ? 'checked' : ''}>
											<svg xmlns="http://www.w3.org/2000/svg" width="16"
												height="16" fill="currentColor" class="bi bi-search"
												viewBox="0 0 16 16">
										  <path
													d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
										</svg>
										</button>
									</td>
									<td><c:out value="${o.codigo}" /></td>
									<td><c:out value="${o.nome}" /></td>
									<td><c:out value="${o.cliente.codigo}" /></td>
									<td><c:out value="${o.cliente.nome}" /></td>
									<td><fmt:formatDate value="${o.dataOrcamento}"
											pattern="dd/MM/yyyy" /></td>
									<td>
										<button
											onclick="window.location.href='produtosPedido?pedido=${o.codigo}'"
											class="btn btn-info">Adicionar</button>
									</td>
									<td><fmt:formatNumber value="${o.valorTotal}"
											type="currency" currencySymbol="R$" /></td>

									<td><c:out value="${o.status}" /></td>
									<td>

										<form action="orcamento" method="post"
											onsubmit="return confirmarConversao()">
											<input type="hidden" name="codigo" value="${o.codigo}">
											<input type="hidden" name="cliente" value="${o.codigo}">
											<input type="hidden" id="botao" name="botao"
												value="Efetivar Pedido">
											<button type="submit" class="btn btn-outline-dark">Efetivar
												Pedido</button>
										</form>
									<td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:if>
		</div>
	</div>
	<div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>
