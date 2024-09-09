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
							<div class="col-md-4">
								<div class="card text-center shadow-sm" style="cursor: pointer;"
									onclick="setEscolha('orcamentos')">
									<div class="card-body">
										<h5 class="card-title">Orçamentos em Aberto</h5>
										<p class="card-text display-6">
											<c:out value="${totalOrcamentos}" />
										</p>
										<c:choose>
											<c:when
												test="${totalOrcamentos > configuracoes.qtdMaximaOrcamento}">
												<p class="text-danger">Entre em contato com os clientes!</p>
											</c:when>
											<c:otherwise>
												<p class="text-success">Orçamentos dentro do limite
													esperado.</p>
											</c:otherwise>
										</c:choose>
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
										<c:choose>
											<c:when
												test="${totalProdutosProducao < configuracoes.qtdMediaPedidoAndamento}">
												<p class="text-danger">Produção acima do limite,
													verifique a capacidade!</p>
											</c:when>
											<c:when
												test="${totalProdutosProducao > configuracoes.qtdMediaPedidoAndamento}">
												<p class="text-warning">Produção abaixo do esperado,
													ajuste os recursos!</p>
											</c:when>
											<c:otherwise>
												<p class="text-success">Produção dentro do nível
													adequado.</p>
											</c:otherwise>
										</c:choose>

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
										<c:choose>
											<c:when
												test="${totalPedidosRecebidos < configuracoes.qtdMediaPedidosRecebidos}">
												<p class="text-danger">Volume alto de pedidos, priorize
													o processamento!</p>
											</c:when>
											<c:when
												test="${totalPedidosRecebidos > configuracoes.qtdMediaPedidosRecebidos}">
												<p class="text-warning">Volume baixo de pedidos, avaliar
													estratégias!</p>
											</c:when>
											<c:otherwise>
												<p class="text-success">Pedidos recebidos dentro do
													esperado.</p>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>

							<div class="col-md-4">
								<div class="card text-center shadow-sm" style="cursor: pointer;"
									onclick="setEscolha('pedidosDespachados')">
									<div class="card-body">
										<h5 class="card-title">Pedidos Enviados</h5>
										<p class="card-text display-6">
											<c:out value="${totalPedidosDespachados}" />
										</p>
										<c:choose>
											<c:when
												test="${totalPedidosDespachados > configuracoes.qtdMediaPedidosDespachados}">
												<p class="text-danger">Baixo volume de pedidos
													enviados, verifique atrasos!</p>
											</c:when>
											<c:when
												test="${totalPedidosDespachados < configuracoes.qtdMediaPedidosDespachados}">
												<p class="text-warning">Envios em alta, monitorar
													eficiência logística.</p>
											</c:when>
											<c:otherwise>
												<p class="text-success">Pedidos Enviados dentro do
													padrão esperado.</p>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>


							<div class="col-md-4">
								<div class="card text-center shadow-sm" style="cursor: pointer;"
									onclick="setEscolha('produtosProducao')">
									<div class="card-body">
										<h5 class="card-title">Produtos em Produção</h5>
										<p class="card-text display-6">
											<c:out value="${totalProdutosProducao}" />
										</p>
										<c:choose>
											<c:when
												test="${totalProdutosProducao < configuracoes.qtdMediaProducaoProdutos}">
												<p class="text-warning">Alto volume,
													verificar capacidade da equipe!</p>
											</c:when>
											<c:when
												test="${totalProdutosProducao > configuracoes.qtdMediaProducaoProdutos}">
												<p class="text-danger">Baixo volume, pode
													haver atraso nos pedidos!</p>
											</c:when>
											<c:otherwise>
												<p class="text-success">Produção dentro do esperado.</p>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>


							<!-- Produtos Estoque Baixo -->
							<div class="col-md-4">
								<div class="card text-center shadow-sm" style="cursor: pointer;"
									onclick="setEscolha('produtosEstoqueBaixo')">
									<div class="card-body">
										<h5 class="card-title">Produtos com Estoque Baixo</h5>
										<p class="card-text display-6">
											<c:out value="${totalProdutoEstoqueBaixo}" />
										</p>

										<!-- Indicação de Status do Estoque -->
										<c:choose>
											<c:when test="${totalProdutoEstoqueBaixo == 0}">
												<p class="text-success">Todos os produtos estão com o
													estoque adequado!</p>
											</c:when>
											<c:when
												test="${totalProdutoEstoqueBaixo > 0 && totalProdutoEstoqueBaixo < configuracoes.qtdMinimaProdutoEstoque}">
												<p class="text-warning">Alguns produtos estão com
													estoque baixo.</p>
											</c:when>
											<c:otherwise>
												<p class="text-danger">Estoque crítico! Reposição
													necessária imediata!</p>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>

						</div>
						<!-- Lista de Pedidos Recentes -->
						<div class="row mt-5">
							<div class="col-md-12">
								<div class="card shadow-sm">
									<div class="card-body">
										<div class="table-responsive">
											<table class="table table-striped">
												<thead>
													<tr>
														<th class="titulo-tabela" colspan="8"
															style="text-align: center; font-size: 22px;"><c:out
																value="${tituloTabela}" /></th>
													</tr>
													<c:choose>
														<c:when test="${escolha == 'orcamentos'}">
															<tr class="table-dark">
																<th>Código</th>
																<th>Nome</th>
																<th>Descrição</th>
																<th>Cliente</th>
																<th>Valor Total</th>
																<th>Forma de Pagamento</th>
																<th>Status</th>
																<th>Data do Orçamento</th>
															</tr>
														</c:when>
														<c:when
															test="${escolha == 'produtosProducao' || escolha == 'produtosEstoqueBaixo'}">
															<tr class="table-dark">
																<th>Código</th>
																<th>Nome</th>
																<th>Categoria</th>
																<th>Descrição</th>
																<th>Valor Unitário</th>
																<th>Status</th>
																<th>Quantidade</th>
																<th>Ref. Estoque</th>
															</tr>
														</c:when>
														<c:otherwise>
															<tr class="table-dark">
																<th>Código</th>
																<th>Cliente</th>
																<th>Data</th>
																<th>Status</th>
																<th>Valor</th>
															</tr>
														</c:otherwise>
													</c:choose>
												</thead>
												<tbody>
													<c:choose>
														<c:when test="${escolha == 'orcamentos'}">
															<c:forEach var="orcamento" items="${orcamentos}">
																<tr>
																	<td><c:out value="${orcamento.codigo}" /></td>
																	<td><c:out value="${orcamento.nome}" /></td>
																	<td><c:out value="${orcamento.descricao}" /></td>
																	<td><c:out value="${orcamento.cliente.nome}" /></td>
																	<td><fmt:formatNumber
																			value="${orcamento.valorTotal}" type="currency"
																			currencySymbol="R$" /></td>
																	<td><c:out value="${orcamento.formaPagamento}" /></td>
																	<td><c:out value="${orcamento.status}" /></td>
																	<td><fmt:formatDate
																			value="${orcamento.dataOrcamento}"
																			pattern="dd/MM/yyyy" /></td>
																</tr>
															</c:forEach>
														</c:when>
														<c:when
															test="${escolha == 'produtosProducao' || escolha == 'produtosEstoqueBaixo'}">
															<c:forEach var="produto" items="${produtos}">
																<tr>
																	<td><c:out value="${produto.codigo}" /></td>
																	<td><c:out value="${produto.nome}" /></td>
																	<td><c:out value="${produto.categoria}" /></td>
																	<td><c:out value="${produto.descricao}" /></td>
																	<td><fmt:formatNumber
																			value="${produto.valorUnitario}" type="currency"
																			currencySymbol="R$" /></td>
																	<td><c:out value="${produto.status}" /></td>
																	<td><c:out value="${produto.quantidade}" /></td>
																	<td><c:out value="${produto.refEstoque}" /></td>
																</tr>
															</c:forEach>
														</c:when>
														<c:otherwise>
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
														</c:otherwise>
													</c:choose>
												</tbody>
											</table>
										</div>
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