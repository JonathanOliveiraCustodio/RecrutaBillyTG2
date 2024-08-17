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
<script src="${pageContext.request.contextPath}/resources/js/pedido.js"></script>
<title>Pedido</title>

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
								onclick="mostrarValor(this.value)" onchange="updateEndereco">
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

						<div class="col-md-1 d-flex align-items-center">
							<label for="valorTotal" class="form-label">Valor Total:</label>
						</div>
						<div class="col-md-3">
							<input class="form-control" type="text" id="valorTotal"
								name="valorTotal" placeholder="Valor Total"
								value='<c:out value="${pedido.valorTotal}"></c:out>'>
						</div>
					</div>

					<!-- Terceira Linha: Tipo Pagemento, Observação -->
					<div class="row g-3 mt-2">
						<div class="col-md-1 d-flex align-items-center">
							<label for="tipoPagamento" class="form-label">Pagamento:</label>
						</div>
						<div class="col-md-3">
							<select class="form-select" id="tipoPagemento"
								name="tipoPagemento">
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
								<option value="Transferência Bancária "
									<c:if test="${pedido.tipoPagamento eq 'Transferência Bancária '}">selected</c:if>>Transferência
									Bancária</option>
							</select>
						</div>

						<div class="col-md-1 d-flex align-items-center">
							<label for="statusPagamento" class="form-label">Status
								Pag.:</label>
						</div>
						<div class="col-md-3">
							<select id="statusPagamento" name="statusPagamento"
								class="form-select">
								<option value="">Escolha um Estado</option>
								<option value="Pendente"
									<c:if test="${pedido.statusPagamento eq 'Pendente'}">selected</c:if>>Pendente</option>
								<option value="Pago"
									<c:if test="${pedido.statusPagamento eq 'Pago'}">selected</c:if>>Pago</option>
							</select>
						</div>

						<div class="col-md-1 d-flex align-items-center">
							<label for="dataPagamento" class="form-label">Data Pag.:</label>
						</div>
						<div class="col-md-3">
							<input class="form-control" type="date" id="dataPagamento"
								name="dataPagamento" placeholder="Data Pagamento"
								value='<c:out value="${pedido.dataPagamento}"></c:out>'>
						</div>
					</div>

					<!-- Terceira Linha: CEP, Logradouro, Número -->
					<div class="row g-3 mt-2">
						<div class="col-md-1 d-flex align-items-center">
							<label for="cep" class="form-label">CEP:</label>
						</div>
						<div class="col-md-3">
							<input type="text" id="CEP" name="CEP" class="form-control"
								placeholder="CEP" maxlength="9"
								value='<c:out value="${pedido.cliente.CEP }"></c:out>'readonly>
						</div>

						<div class="col-md-1 d-flex align-items-center">
							<label for="logradouro" class="form-label">Logradouro:</label>
						</div>
						<div class="col-md-3">
							<input type="text" id="logradouro" name="logradouro"
								class="form-control" placeholder="Logradouro" maxlength="100"
								value='<c:out value="${pedido.cliente.logradouro }"></c:out>'readonly>
						</div>

						<div class="col-md-1 d-flex align-items-center">
							<label for="numero" class="form-label">Número:</label>
						</div>
						<div class="col-md-3">
							<input type="text" id="numero" name="numero" class="form-control"
								placeholder="Número" maxlength="10"
								value='<c:out value="${pedido.cliente.numero }"></c:out>'readonly>
						</div>
					</div>

					<!-- Dados do Cliente serão preenchidos ao selecionar o Cliente -->
					<!-- Quarta Linha: UF, Localidade, Bairro -->
					<div class="row g-3 mt-2">
						<div class="col-md-1 d-flex align-items-center">
							<label for="uf" class="form-label">UF:</label>
						</div>
						<div class="col-md-3">
							<input type="text" id="UF" name="UF" class="form-control"
								placeholder="UF" maxlength="2"
								value='<c:out value="${pedido.cliente.UF }"></c:out>'readonly>
						</div>

						<div class="col-md-1 d-flex align-items-center">
							<label for="localidade" class="form-label">Localidade:</label>
						</div>
						<div class="col-md-3">
							<input type="text" id="localidade" name="localidade"
								class="form-control" placeholder="Localidade" maxlength="100"
								value='<c:out value="${pedido.cliente.localidade }"></c:out>'readonly>
						</div>

						<div class="col-md-1 d-flex align-items-center">
							<label for="bairro" class="form-label">Bairro:</label>
						</div>
						<div class="col-md-3">
							<input type="text" id="bairro" name="bairro" class="form-control"
								placeholder="Bairro" maxlength="100"
								value='<c:out value="${pedido.cliente.bairro }"></c:out>'readonly>
						</div>
					</div>

					<!-- Quinta Linha: Complemento, Telefone e Botão Contato por WhatsApp -->
					<div class="row g-3 mt-2">
						<div class="col-md-1 d-flex align-items-center">
							<label for="complemento" class="form-label">Compl:</label>
						</div>
						<div class="col-md-3">
							<input type="text" id="complemento" name="complemento"
								class="form-control" placeholder="Complemento"
								value='<c:out value="${pedido.cliente.complemento }"></c:out>'readonly>
						</div>
						<div class="col-md-1 d-flex align-items-center">
							<label for="dataNascimento" class="form-label"> Telefone:</label>
						</div>
						<div class="col-md-3">
							<input class="form-control" type="text" id="telefone"
								name="telefone" placeholder="Telefone"
								value='<c:out value="${pedido.cliente.telefone }"></c:out>'readonly>
						</div>
						<div class="col-md-4 d-flex align-items-center">
							<button type="button"
								class="btn btn-outline-success d-flex align-items-center"
								onclick="redirectToWhatsApp()">
								<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
									fill="currentColor" class="bi bi-whatsapp" viewBox="0 0 16 16"
									style="margin-right: 5px;">
                    <path
										d="M13.601 2.326A7.85 7.85 0 0 0 7.994 0C3.627 0 .068 3.558.064 7.926c0 1.399.366 2.76 1.057 3.965L0 16l4.204-1.102a7.9 7.9 0 0 0 3.79.965h.004c4.368 0 7.926-3.558 7.93-7.93A7.9 7.9 0 0 0 13.6 2.326zM7.994 14.521a6.6 6.6 0 0 1-3.356-.92l-.24-.144-2.494.654.666-2.433-.156-.251a6.56 6.56 0 0 1-1.007-3.505c0-3.626 2.957-6.584 6.591-6.584a6.56 6.56 0 0 1 4.66 1.931 6.56 6.56 0 0 1 1.928 4.66c-.004 3.639-2.961 6.592-6.592 6.592m3.615-4.934c-.197-.099-1.17-.578-1.353-.646-.182-.065-.315-.099-.445.099-.133.197-.513.646-.627.775-.114.133-.232.148-.43.05-.197-.1-.836-.308-1.592-.985-.59-.525-.985-1.175-1.103-1.372-.114-.198-.011-.304.088-.403.087-.088.197-.232.296-.346.1-.114.133-.198.198-.33.065-.134.034-.248-.015-.347-.05-.099-.445-1.076-.612-1.47-.16-.389-.323-.335-.445-.34-.114-.007-.247-.007-.38-.007a.73.73 0 0 0-.529.247c-.182.198-.691.677-.691 1.654s.71 1.916.81 2.049c.098.133 1.394 2.132 3.383 2.992.47.205.84.326 1.129.418.475.152.904.129 1.246.08.38-.058 1.171-.48 1.338-.943.164-.464.164-.86.114-.943-.049-.084-.182-.133-.38-.232" />
                </svg>
								Contato WhatsApp
							</button>
						</div>
					</div>

					<!-- Sétima Linha: Observação -->
					<div class="row g-3 mt-2">
						<div class="col-md-1 d-flex align-items-center">
							<label for="observacao" class="form-label">Observação:</label>
						</div>
						<div class="col-md-11">
							<textarea id="observacao" name="observacao" class="form-control"
								placeholder="Observações" rows="3"><c:out
									value="${orcamento.observacao}"></c:out></textarea>
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

		<div class="container py-4 text-center d-flex justify-content-center">
			<c:if test="${not empty pedidos }">
				<table class="table table-striped">
					<thead>
						<tr>
							<th class="titulo-tabela" colspan="10"
								style="text-align: center; font-size: 25px;">Lista de
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
