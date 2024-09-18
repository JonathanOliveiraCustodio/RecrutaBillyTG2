<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/styles.css">
<title>Pedido</title>
</head>
<body>
	<script
		src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/pedido.js"></script>
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
						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="number" min="0" step="1"
									id="codigo" name="codigo" placeholder="Código"
									value='<c:out value="${pedido.codigo}"></c:out>' readonly>
								<label for="codigo">Código:</label>
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-floating">
								<input class="form-control" type="text" id="nome" name="nome"
									placeholder="Nome do Pedido"
									value='<c:out value="${pedido.nome}"></c:out>'> <label
									for="nome">Nome:</label>
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
									value='<c:out value="${pedido.descricao}"></c:out>'> <label
									for="descricao">Descrição:</label>
							</div>
						</div>
					</div>

					<!-- Segunda Linha: Cliente, Estado -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<select class="form-select" id="cliente" name="cliente"
									onchange="updateEndereco()">
									<option value="0" data-cep="" data-logradouro="" data-numero=""
										data-complemento="" data-bairro="" data-localidade=""
										data-estado="">Escolha um Cliente</option>
									<c:forEach var="c" items="${clientes}">
										<option value="${c.codigo}" data-cep="${c.CEP}"
											data-logradouro="${c.logradouro}" data-numero="${c.numero}"
											data-complemento="${c.complemento}" data-bairro="${c.bairro}"
											data-localidade="${c.localidade}" data-estado="${c.UF}"
											<c:if test="${c.codigo eq pedido.cliente.codigo}"> selected</c:if>>
											<c:out value="${c.nome}" />
										</option>
									</c:forEach>
								</select> <label for="cliente">Cliente:</label>
							</div>

						</div>
						<div class="col-md-4">
							<div class="form-floating">
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
								</select> <label for="estado">Estado:</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="text" id="valorTotal"
									name="valorTotal" placeholder="Valor Total"
									value='<c:out value="${pedido.valorTotal}"></c:out>'
									oninput="formatarMoeda(this)"><label for="valorTotal">Valor
									Total:</label>
							</div>
						</div>
					</div>

					<!-- Terceira Linha: Tipo Pagamento, Observação -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<select class="form-select" id="tipoPagamento"
									name="tipoPagamento">
									<option value="">Escolha um Tipo Pagamento</option>
									<option value="PIX"
										<c:if test="${pedido.tipoPagamento eq 'PIX'}">selected</c:if>>PIX</option>
									<option value="Boleto"
										<c:if test="${pedido.tipoPagamento eq 'Boleto'}">selected</c:if>>Boleto</option>
									<option value="Cartão de Crédito"
										<c:if test="${pedido.tipoPagamento eq 'Cartão de Crédito'}">selected</c:if>>Cartão
										de Crédito</option>
									<option value="Mercado Pago"
										<c:if test="${pedido.tipoPagamento eq 'Mercado Pago'}">selected</c:if>>Mercado
										Pago</option>
									<option value="Transferência Bancária"
										<c:if test="${pedido.tipoPagamento eq 'Transferência Bancária'}">selected</c:if>>Transferência
										Bancária</option>
								</select> <label for="tipoPagamento">Tipo Pagamento:</label>
							</div>
						</div>

						<div class="col-md-4">
							<div class="form-floating">
								<select id="statusPagamento" name="statusPagamento"
									class="form-select">
									<option value="">Escolha um Estado</option>
									<option value="Pendente"
										<c:if test="${pedido.statusPagamento eq 'Pendente'}">selected</c:if>>Pendente</option>
									<option value="Pago"
										<c:if test="${pedido.statusPagamento eq 'Pago'}">selected</c:if>>Pago</option>
								</select> <label for="statusPagamento">Status Pagamento:</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="date" id="dataPagamento"
									name="dataPagamento" placeholder="Data Pagamento"
									value='<c:out value="${pedido.dataPagamento}"></c:out>'>
								<label for="dataPagamento">Data Pagamento:</label>
							</div>
						</div>
					</div>

					<!-- Quarta Linha: CEP, Logradouro, Número -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="CEP" name="CEP" class="form-control"
									placeholder="CEP" maxlength="9"
									value='<c:out value="${pedido.cliente.CEP}"></c:out>' readonly>
								<label for="cep">CEP:</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="logradouro" name="logradouro"
									class="form-control" placeholder="Logradouro" maxlength="100"
									value='<c:out value="${pedido.cliente.logradouro}"></c:out>'
									readonly> <label for="logradouro">Logradouro:</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="numero" name="numero"
									class="form-control" placeholder="Número" maxlength="10"
									value='<c:out value="${pedido.cliente.numero}"></c:out>'
									readonly> <label for="numero">Número:</label>
							</div>
						</div>
					</div>

					<!-- Quinta Linha: Complemento, Bairro, Cidade -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="complemento" name="complemento"
									class="form-control" placeholder="Complemento" maxlength="100"
									value='<c:out value="${pedido.cliente.complemento}"></c:out>'
									readonly> <label for="complemento">Complemento:</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="bairro" name="bairro"
									class="form-control" placeholder="Bairro" maxlength="100"
									value='<c:out value="${pedido.cliente.bairro}"></c:out>'
									readonly> <label for="bairro">Bairro:</label>
							</div>
						</div>

						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="UF" name="UF" class="form-control"
									placeholder="UF" maxlength="2"
									value='<c:out value="${pedido.cliente.UF}"></c:out>' readonly>
								<label for="UF">UF:</label>
							</div>
						</div>
					</div>

					<!-- Sexta Linha: Observações -->
					<div class="row g-3 mt-2">
						<div class="col-md-12">
							<div class="form-floating">
								<textarea id="observacao" name="observacao" class="form-control"
									placeholder="Observações" rows="3" maxlength="800"><c:out
										value="${pedido.observacao}"></c:out></textarea>
								<label for="observacoes">Observações:</label>
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
			<c:if test="${not empty pedidos }">
				<div class="table-responsive w-100">
					<table class="table table-striped">
						<thead>
							<tr>
								<th class="titulo-tabela" colspan="12"
									style="text-align: center; font-size: 35px;">Lista de
									Pedidos</th>
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
								<th>Etiqueta</th>
								<th>Estado Atual</th>
								<th>Finalizar</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="p" items="${pedidos}">
								<tr>
									<td style="text-align: center;">
										<button class="btn btn-outline-dark" name="opcao"
											value="${p.codigo}" onclick="editarPedido(this.value)"
											${p.codigo eq codigoEdicao ? 'checked' : ''}>
											<svg xmlns="http://www.w3.org/2000/svg" width="26"
												height="26" fill="currentColor" class="bi bi-pencil-square"
												viewBox="0 0 16 16">
                            <path
													d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                            <path fill-rule="evenodd"
													d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
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
									<td>
										<form action="etiqueta" method="post" target="_blank">
											<input type="hidden" name="cliente"
												value="${p.cliente.codigo}"> <input type="hidden"
												name="pedido" value="${p.codigo}"> <input
												type="hidden" id="botao" name="botao" value="Imprimir">
											<button type="submit" class="btn btn-success">Imprimir</button>
										</form>
									</td>
									<td><c:out value="${p.estado}" /></td>
									<td>
										<form action="pedido" method="post"
											onsubmit="return confirmarFinalizacao('${p.estado}')">
											<input type="hidden" name="codigo" value="${p.codigo}">
											<input type="hidden" name="cliente"
												value="${p.cliente.codigo}"> <input type="hidden"
												id="botao" name="botao" value="Finalizar">
											<button type="submit" class="btn btn-outline-dark">Finalizar
											</button>
										</form>
									</td>
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
