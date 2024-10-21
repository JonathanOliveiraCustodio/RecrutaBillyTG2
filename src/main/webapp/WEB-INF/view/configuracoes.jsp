<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Parâmetros de Operação</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/styles.css">
</head>
<body>
	<script
		src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/configuracoes.js"></script>

	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<c:if test="${nivelAcesso == 'admin' }">
			<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
				<div class="container-fluid py-1">
					<h1 class="display-6 fw-bold">Configurações Operacionais</h1>
					<form action="configuracoes" method="post"
						onsubmit="return validarFormulario(event);" class="row g-3 mt-3">
						<!-- Campo para definir a quantidade máxima de orçamentos em aberto -->
						<div class="col-md-6 form-floating">
							<input type="number" class="form-control" id="maxOrcamentos"
								name="maxOrcamentos" value="${configuracoes.qtdMaximaOrcamento}"
								placeholder="Quantidade Máxima de Orçamentos em Aberto">
							<label for="maxOrcamentos">Quantidade Máxima de
								Orçamentos em Aberto</label>
						</div>
						<!-- Campo para definir a quantidade mínima para o estoque -->
						<div class="col-md-6 form-floating">
							<input type="number" class="form-control" id="minEstoque"
								name="minEstoque"
								value="${configuracoes.qtdMinimaProdutoEstoque}"
								placeholder="Quantidade Mínima para o Estoque"> <label
								for="minEstoque">Quantidade Mínima para o Estoque</label>
						</div>

						<div class="col-md-6 form-floating">
							<input type="number" class="form-control"
								id="medPedidosAndamento" name="medPedidosAndamento"
								value="${configuracoes.qtdMediaPedidoAndamento}"
								placeholder="Quantidade Média de Pedidos em Andamento">
							<label for="medPedidosAndamento">Quantidade Média de
								Pedidos em Andamento</label>
						</div>

						<div class="col-md-6 form-floating">
							<input type="number" class="form-control"
								id="medPedidosRecebidos" name="medPedidosRecebidos"
								value="${configuracoes.qtdMediaPedidosRecebidos}"
								placeholder="Quantidade Média de Pedidos Recebidos"> <label
								for="medPedidosRecebidos">Quantidade Média de Pedidos
								Recebidos</label>
						</div>

						<div class="col-md-6 form-floating">
							<input type="number" class="form-control"
								id="medPedidosDespachados" name="medPedidosDespachados"
								value="${configuracoes.qtdMediaPedidosDespachados}"
								placeholder="Quantidade Média de Pedidos Despachados"> <label
								for="medPedidosDespachados">Quantidade Média de Pedidos
								Despachados</label>
						</div>

						<div class="col-md-6 form-floating">
							<input type="number" class="form-control"
								id="medProducaoProdutos" name="medProducaoProdutos"
								value="${configuracoes.qtdMediaProducaoProdutos}"
								placeholder="Quantidade Média de Produção de Produtos">
							<label for="medProducaoProdutos">Quantidade Média de
								Produção de Produtos</label>
						</div>

						<div class="col-md-6 form-floating">
							<input type="number" class="form-control"
								id="medDespesasPendentes" name="medDespesasPendentes"
								value="${configuracoes.qtdDespesasPendentes}"
								placeholder="Quantidade Média de Despesas Pendentes"> <label
								for="medDespesasPendentes">Quantidade Média de Despesas
								Pendentes</label>
						</div>

						<div class="col-md-6 form-floating">
							<input type="number" class="form-control"
								id="medDespesasVencidas" name="medDespesasVencidas"
								value="${configuracoes.qtdDespesasVencidas}"
								placeholder="Quantidade Média de Despesas Vencidas"> <label
								for="medDespesasVencidas">Quantidade Média de Despesas
								Vencidas</label>
						</div>

						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="text"
									id="valorTotalDespesasMes" name="valorTotalDespesasMes"
									placeholder="Meta de Despesas do Mês"
									value='<fmt:formatNumber value="${configuracoes.valorTotalDespesasMes}" type="currency" currencySymbol="R$" />'>
								<label for="valorTotalDespesasMes">Meta de Despesas do
									Mês</label>
							</div>
						</div>

						<!-- Botão para submeter o formulário -->
						<div class="row g-3 mt-3 justify-content-center">
							<div class="col-md-2 d-grid text-center">
								<button type="submit" class="btn btn-success btn-align"
									value="Alterar">Alterar</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</c:if>
	</div>

	<div class="text-center">
		<c:if test="${not empty erro}">
			<h2 class="text-danger">
				<b><c:out value="${erro}" /></b>
			</h2>
		</c:if>
	</div>

	<div class="text-center">
		<c:if test="${not empty saida}">
			<h2 class="text-success">
				<b><c:out value="${saida}" /></b>
			</h2>
		</c:if>
	</div>

	<div>
		<jsp:include page="footer.jsp" />
	</div>

</body>
</html>