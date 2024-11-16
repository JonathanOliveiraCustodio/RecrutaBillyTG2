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

				<div align="center">
					<!-- Mensagem de Erro -->
					<c:if test="${not empty erro}">
						<div class="alert alert-danger fs-5" role="alert">
							<c:out value="${erro}" />
						</div>
					</c:if>

					<!-- Mensagem de Sucesso -->
					<c:if test="${not empty saida}">
						<div class="alert alert-success fs-5" role="alert">
							<c:out value="${saida}" />
						</div>
					</c:if>
				</div>

				<form action="pedido" method="post"
					onsubmit="return validarFormulario(event);" class="row g-3 mt-3"
					id="form-relatorio">
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
										data-UF="" data-telefone="">Escolha um Cliente</option>
									<c:forEach var="c" items="${clientes}">
										<option value="${c.codigo}" data-cep="${c.CEP}"
											data-logradouro="${c.logradouro}" data-numero="${c.numero}"
											data-complemento="${c.complemento}" data-bairro="${c.bairro}"
											data-localidade="${c.localidade}" data-UF="${c.UF}"
											data-telefone="${c.telefone}"
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
									value='<fmt:formatNumber value="${pedido.valorTotal}" type="currency" currencySymbol="R$" />'>
								<label for="valorTotal">Valor Total:</label>
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

					<!-- Quinta Linha: Complemento, Bairro, Cidade -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="localidade" name="localidade"
									class="form-control" placeholder="Localidade" maxlength="100"
									value='<c:out value="${pedido.cliente.localidade}"></c:out>'
									readonly> <label for="localidade">Localidade:</label>
							</div>
						</div>

						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="telefone" name="telefone"
									class="form-control" placeholder="Telefone" maxlength="15"
									value='<c:out value="${pedido.cliente.telefone }"></c:out>'
									readonly> <label for="telefone">Telefone</label>
							</div>
						</div>
						<div class="col-md-4 d-flex align-items-center">
							<button type="button"
								class="btn btn-outline-success btn-align d-flex align-items-center w-100"
								onclick="redirectToWhatsApp()">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									fill="currentColor" class="bi bi-whatsapp" viewBox="0 0 16 16"
									style="margin-right: 5px;">
                <path
										d="M13.601 2.326A7.85 7.85 0 0 0 7.994 0C3.627 0 .068 3.558.064 7.926c0 1.399.366 2.76 1.057 3.965L0 16l4.204-1.102a7.9 7.9 0 0 0 3.79.965h.004c4.368 0 7.926-3.558 7.93-7.93A7.9 7.9 0 0 0 13.6 2.326zM7.994 14.521a6.6 6.6 0 0 1-3.356-.92l-.24-.144-2.494.654.666-2.433-.156-.251a6.56 6.56 0 0 1-1.007-3.505c0-3.626 2.957-6.584 6.591-6.584a6.56 6.56 0 0 1 4.66 1.931 6.56 6.56 0 0 1 1.928 4.66c-.004 3.639-2.961 6.592-6.592 6.592m3.615-4.934c-.197-.099-1.17-.578-1.353-.646-.182-.065-.315-.099-.445.099-.133.197-.513.646-.627.775-.114.133-.232.148-.43.05-.197-.1-.836-.308-1.592-.985-.59-.525-.985-1.175-1.103-1.372-.114-.198-.011-.304.088-.403.087-.088.197-.232.296-.346.1-.114.133-.198.198-.33.065-.134.034-.248-.015-.347-.05-.099-.445-1.076-.612-1.47-.16-.389-.323-.335-.445-.34-.114-.007-.247-.007-.38-.007a.73.73 0 0 0-.529.247c-.182.198-.691.677-.691 1.654s.71 1.916.81 2.049c.098.133 1.394 2.132 3.383 2.992.47.205.84.326 1.129.418.475.152.904.129 1.246.08.38-.058 1.171-.48 1.338-.943.164-.464.164-.86.114-.943-.049-.084-.182-.133-.38-.232" />
            </svg>
								Contato WhatsApp
							</button>
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
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Listar"
								class="btn btn-dark btn-align">
						</div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Limpar"
								class="btn btn-secondary btn-align">
						</div>
						<div class="col-md-2 d-grid text-center">
							<!-- Botão para abrir o modal de visualização de material -->
							<button type="button" class="btn-purple btn-align"
								onclick="abrirModalPedido('${pedido.codigo}')">Ver
								Detalhes</button>
						</div>
					</div>

					<!-- Linha dos Botões de Ação -->
					<div class="row g-3 mt-3" id="linhaBotoes" style="display: none;">
						<div class="col-md-2 d-grid text-center"></div>
						<div class="col-md-2 d-grid text-center"></div>
						<div class="col-md-2 d-grid text-center"></div>

						<div class="col-md-2 d-grid text-center">
							<button type="button" id="botaoAdicionarProdutos"
								class="btn btn-info btn-align w-100 d-flex justify-content-center align-items-center"
								onclick="validarERedirecionar()">Adicionar Produto</button>
						</div>

						<div class="col-md-2 d-grid text-center">
							<input type="hidden" name="cliente"
								value="${pedido.cliente.codigo}"> <input type="hidden"
								name="pedido" value="${pedido.codigo}"> <input
								type="button" id="botaoPdf" name="botaoPdf" value="Etiqueta"
								class="btn btn-success btn-align" onclick="gerarEtiqueta()">
						</div>

						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Finalizar"
								class="btn btn-outline-dark btn-align"
								onclick="return confirmarFinalizacao('${pedido.estado}')">
						</div>

						<div class="col-md-2 d-grid text-center"></div>
					</div>
				</form>

				<div class="modal fade" id="pedidoModal" tabindex="-1"
					aria-labelledby="pedidoModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="pedidoModalLabel">Detalhes do
									Pedido</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Fechar"></button>
							</div>
							<div class="modal-body">
								<p>
									<strong>Código:</strong> <span id="modalCodigo"></span>
								</p>
								<p>
									<strong>Nome do Pedido:</strong> <span id="modalNome"></span>
								</p>
								<p>
									<strong>Descrição:</strong> <span id="modalDescricao"></span>
								</p>
								<p>
									<strong>Cliente:</strong> <span id="modalCliente"></span>
								</p>
								<p>
									<strong>Estado:</strong> <span id="modalEstado"></span>
								</p>
								<p>
									<strong>Valor Total:</strong> <span id="modalValorTotal"></span>
								</p>
								<p>
									<strong>Tipo de Pagamento:</strong> <span
										id="modalTipoPagamento"></span>
								</p>
								<p>
									<strong>Status do Pagamento:</strong> <span
										id="modalStatusPagamento"></span>
								</p>
								<p>
									<strong>Data de Pagamento:</strong> <span
										id="modalDataPagamento"></span>
								</p>
								<p>
									<strong>CEP:</strong> <span id="modalCEP"></span>
								</p>
								<p>
									<strong>Logradouro:</strong> <span id="modalLogradouro"></span>
								</p>
								<p>
									<strong>Número:</strong> <span id="modalNumero"></span>
								</p>
								<p>
									<strong>Complemento:</strong> <span id="modalComplemento"></span>
								</p>
								<p>
									<strong>Bairro:</strong> <span id="modalBairro"></span>
								</p>
								<p>
									<strong>Localidade:</strong> <span id="modalLocalidade"></span>
								</p>
								<p>
									<strong>UF:</strong> <span id="modalUF"></span>
								</p>
								<p>
									<strong>Telefone:</strong> <span id="modalTelefone"></span>
								</p>

								<!-- Tabela de Produtos -->
								<c:if test="${not empty pedidoProdutos}">
									<div class="table-responsive w-100 mt-4">
										<table class="table table-bordered table-hover">
											<thead class="table-dark">
												<tr>
													<th class="text-center" colspan="6"
														style="font-size: 20px;">Lista de Produtos de um
														Pedido</th>
												</tr>
												<tr>
													<th>Nome</th>
													<th>Categoria</th>
													<th>Descrição</th>
													<th>Valor</th>
													<th>Quantidade</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="p" items="${pedidoProdutos}">
													<tr>
														<td><c:out value="${p.produto.nome}" /></td>
														<td><c:out value="${p.produto.categoria}" /></td>
														<td><c:out value="${p.produto.descricao}" /></td>
														<td><fmt:formatNumber
																value="${p.produto.valorUnitario}" type="currency"
																currencySymbol="R$" /></td>
														<td><c:out value="${p.quantidade}" /></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</c:if>
							</div>
						</div>
					</div>
				</div>



			</div>
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
