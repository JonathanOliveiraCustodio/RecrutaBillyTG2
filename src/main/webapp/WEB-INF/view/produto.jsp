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
<title>Produto</title>

</head>
<body>
	<script
		src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/produto.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-1">
				<h1 class="display-6 fw-bold">Manutenção de Produto</h1>

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

				<form action="produto" method="post"
					onsubmit="return validarFormulario(event);" class="row g-3 mt-3">
					<!-- Primeira Linha: Código, Nome, Categoria -->
					<div class="row g-3">
						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="number" min="0" step="1"
									id="codigo" name="codigo" placeholder="Código"
									value='<c:out value="${produto.codigo}"></c:out>'> <label
									for="codigo">Código</label>
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-floating">
								<input class="form-control" type="text" id="nome" name="nome"
									placeholder="Nome do Produto"
									value='<c:out value="${produto.nome}"></c:out>'> <label
									for="nome">Nome</label>
							</div>
						</div>
						<div class="col-md-1">
							<button type="submit" id="botaoBuscar" name="botao"
								value="Buscar"
								class="btn btn-outline-primary w-100 d-flex justify-content-center align-items-center"
								onclick="return validarBusca()" style="height: 56px;">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                    <path
										d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
                </svg>
							</button>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<select id="categoria" name="categoria" class="form-select">
									<option value="0">Escolha uma Categoria</option>
									<c:forEach var="c" items="${categorias }">
										<option value="${c.codigo}"
											<c:if test="${c.codigo eq produto.categoria.codigo}">selected</c:if>>
											<c:out value="${c}" />
										</option>
									</c:forEach>
								</select> <label for="categoria">Categoria</label>
							</div>
						</div>
					</div>

					<!-- Segunda Linha: Descrição, Valor, Status -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="text" id="descricao"
									name="descricao" placeholder="Descrição"
									value='<c:out value="${produto.descricao}"></c:out>'> <label
									for="descricao">Descrição</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="text" id="valorUnitario"
									name="valorUnitario" placeholder="Valor Unitário"
									value='<fmt:formatNumber value="${produto.valorUnitario}" type="currency" currencySymbol="R$" />'>
								<label for="valorUnitario">Valor Unitário:</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
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
								</select> <label for="status">Status</label>
							</div>
						</div>
					</div>

					<!-- Terceira Linha: Quantidade, Ref Estoque -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="number" min="0" step="1"
									id="quantidade" name="quantidade" placeholder="Quantidade"
									value='<c:out value="${produto.quantidade}"></c:out>'>
								<label for="quantidade">Quantidade</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="text" id="refEstoque"
									name="refEstoque" placeholder="Referência no Estoque"
									value='<c:out value="${produto.refEstoque}"></c:out>'>
								<label for="refEstoque">Referência no Estoque</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input type="date" id="data" name="data" class="form-control"
									placeholder="Data"
									value='<c:out value="${produto.data}"></c:out>'> <label
									for="data">Data</label>
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
								onclick="abrirModalProduto('${produto.codigo}')">Ver
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
								onclick="validarERedirecionar()">Adicionar Insumos</button>
						</div>

						<div class="col-md-2 d-grid text-center"></div>
						<div class="col-md-2 d-grid text-center"></div>
						<div class="col-md-2 d-grid text-center"></div>
					</div>

				</form>

				<div class="modal fade" id="produtoModal" tabindex="-1"
					aria-labelledby="produtoModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="produtoModalLabel">Detalhes do
									Produto</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Fechar"></button>
							</div>
							<div class="modal-body">
								<p>
									<strong>Código:</strong> <span id="modalCodigo"></span>
								</p>
								<p>
									<strong>Nome:</strong> <span id="modalNome"></span>
								</p>
								<p>
									<strong>Categoria:</strong> <span id="modalCategoria"></span>
								</p>
								<p>
									<strong>Descrição:</strong> <span id="modalDescricao"></span>
								</p>
								<p>
									<strong>Valor Unitário:</strong> <span id="modalValorUnitario"></span>
								</p>
								<p>
									<strong>Status:</strong> <span id="modalStatus"></span>
								</p>
								<p>
									<strong>Quantidade:</strong> <span id="modalQuantidade"></span>
								</p>
								<p>
									<strong>Referência no Estoque:</strong> <span
										id="modalRefEstoque"></span>
								</p>
								<p>
									<strong>Data:</strong> <span id="modalData"></span>
								</p>

								<c:if test="${not empty insumosProduto}">
									<div class="table-responsive w-100 mt-4">
										<table class="table table-bordered table-hover">
											<thead class="table-dark">
												<tr>
													<th class="text-center" colspan="5"
														style="text-align: center; font-size: 20px;">Lista de
														Insumos do Produto</th>
												</tr>
												<tr class="table-dark">
													<th>Código Insumo</th>
													<th>Nome Insumo</th>
													<th>Unidade</th>
													<th>Quantidade</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="ai" items="${insumosProduto}">
													<tr>
														<td><c:out value="${ai.insumo.codigo}" /></td>
														<td><c:out value="${ai.insumo.nome}" /></td>
														<td><c:out value="${ai.insumo.unidade}" /></td>
														<td><c:out value="${ai.quantidade}" /></td>
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
	</div>

	<div class="container py-4 text-center d-flex justify-content-center"
		align="center">
		<c:if test="${not empty produtos}">
			<div class="table-responsive">
				<table class="table table-striped">
					<thead>
						<tr>
							<th class="titulo-tabela" colspan="11"
								style="text-align: center; font-size: 35px;">Lista de
								Produtos</th>
						</tr>
						<tr class="table-dark">
							<th></th>
							<th>Código</th>
							<th>Nome</th>
							<th>Categoria</th>
							<th>Descrição</th>
							<th>Valor</th>
							<th>Status</th>
							<th>Quantidade</th>
							<th>Ref Est</th>
							<th>Data</th>
							<th>Insumos</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="p" items="${produtos}">
							<tr>
								<td style="text-align: center;">
									<button class="btn btn-outline-dark" name="opcao"
										value="${p.codigo}" onclick="editarProduto(this.value)"
										${p.codigo eq codigoEdicao ? 'checked' : ''}>
										<svg xmlns="http://www.w3.org/2000/svg" width="26" height="26"
											fill="currentColor" class="bi bi-pencil-square"
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
								<td><c:out value="${p.categoria}" /></td>
								<td><c:out value="${p.descricao}" /></td>
								<td><fmt:formatNumber value="${p.valorUnitario}"
										type="currency" currencySymbol="R$" /></td>
								<td><c:out value="${p.status}" /></td>
								<td><c:out value="${p.quantidade}" /></td>
								<td><c:out value="${p.refEstoque}" /></td>
								<td><fmt:formatDate value="${p.data}" pattern="dd/MM/yyyy" /></td>
								<td>
									<button
										onclick="window.location.href='insumosProduto?produto=${p.codigo}'"
										class="btn btn-info">Adicionar</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>
	</div>
	<div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>
