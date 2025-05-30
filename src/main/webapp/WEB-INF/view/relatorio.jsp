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
<script
	src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/relatorio.js"></script>
<title>Relatórios</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<c:if test="${nivelAcesso == 'admin' }">
			<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
				<div class="container-fluid py-1">
					<h1 class="display-6 fw-bold">Gerar Relatório</h1>
					
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
					
					<form action="relatorio" method="post" class="row g-3 mt-3"
						id="form-relatorio">
						<!-- Campos ocultos para armazenar a categoria e a opção selecionada -->
						<input type="hidden" id="categoriaSelecionada"
							name="categoriaSelecionada" value="${categoria}"> <input
							type="hidden" id="opcaoSelecionada" name="opcaoSelecionada"
							value="${opcao}">

						<!-- Linha do Formulário -->
						<div class="row g-3">
							<!-- Categoria -->
							<div class="col-md-4">
								<div class="form-floating">
									<select class="form-select" id="categoria" name="categoria"
										onchange="atualizarOpcoes()">
										<option value="">Escolha uma Categoria</option>
										<option value="cliente"
											${categoria == 'cliente' ? 'selected' : ''}>Cliente</option>
										<option value="despesa"
											${categoria == 'despesa' ? 'selected' : ''}>Despesas</option>
										<option value="equipamento"
											${categoria == 'equipamento' ? 'selected' : ''}>Equipamento</option>
										<option value="fornecedor"
											${categoria == 'fornecedor' ? 'selected' : ''}>Fornecedor</option>
										<option value="funcionario"
											${categoria == 'funcionario' ? 'selected' : ''}>Funcionário</option>
										<option value="insumo"
											${categoria == 'insumo' ? 'selected' : ''}>Insumo</option>
										<option value="orcamento"
											${categoria == 'orcamento' ? 'selected' : ''}>Orçamento</option>
										<option value="pedido"
											${categoria == 'pedido' ? 'selected' : ''}>Pedido</option>
										<option value="produto"
											${categoria == 'produto' ? 'selected' : ''}>Produto</option>

									</select> <label for="categoria">Categoria:</label>
								</div>
							</div>

							<!-- Opção -->
							<div class="col-md-4">
								<div class="form-floating">
									<select class="form-select" id="opcao" name="opcao">
										<!-- As opções serão preenchidas dinamicamente com base na categoria selecionada -->
										<option value="${opcao}" selected>${opcao}</option>
									</select> <label for="opcao">Opção:</label>
								</div>
							</div>

							<!-- Parâmetro de Pesquisa -->
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="parametro" name="parametro"
										class="form-control" placeholder="Digite o Filtro"
										value="${parametro}"> <label for="parametro">Filtro
										de Pesquisa:</label>
								</div>
							</div>
						</div>
						<!-- Linha dos Botões -->
						<div class="row g-3 mt-3 justify-content-center">
							<div class="col-md-2 d-grid text-center">
								<input type="button" id="botaoPdf" name="botaoPdf"
									value="Gerar Relatório" class="btn btn-success btn-align"
									onclick="gerarRelatorioPDF()">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao"
									value="Visualizar Relatório" class="btn btn-warning btn-align"
									onclick="resetarFormulario()">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Limpar"
									class="btn btn-secondary btn-align"
									onclick="resetarFormulario()">
							</div>
						</div>
					</form>
				</div>
			</div>
		</c:if>
	</div>

	<div class="container py-4 text-center d-flex justify-content-center"
		align="center">
		<c:choose>
			<c:when test="${categoria eq 'cliente'}">
				<c:if test="${not empty clientes}">
					<div class="table-responsive w-100">
						<table class="table table-striped">
							<thead>
								<tr>
									<th class="titulo-tabela" colspan="6"
										style="text-align: center; font-size: 35px;">Lista de
										Clientes</th>
								</tr>
								<tr class="table-dark">
									<td>Código</td>
									<td>Nome</td>
									<td>Telefone</td>
									<td>Email</td>
									<td>Tipo do Documento</td>
									<td>Documento</td>
								</tr>
							</thead>
							<tbody class="table-group-divider">
								<c:forEach var="c" items="${clientes}">
									<tr>
										<td><c:out value="${c.codigo}" /></td>
										<td><c:out value="${c.nome}" /></td>
										<td><c:out value="${c.telefone}" /></td>
										<td><c:out value="${c.email}" /></td>
										<td><c:out value="${c.tipo}" /></td>
										<td><c:out value="${c.documento}" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:if>

			</c:when>
			<c:when test="${categoria eq 'fornecedor'}">
				<c:if test="${not empty fornecedores}">
					<div class="table-responsive w-100">
						<div class="table-responsive">
							<table class="table table-striped">
								<thead>
									<tr>
										<th class="titulo-tabela" colspan="14"
											style="text-align: center; font-size: 35px;">Lista de
											Fornecedores</th>
									</tr>
									<tr class="table-dark">
										<th>Código</th>
										<th>Nome</th>
										<th>Telefone</th>
										<th>E-mail</th>
										<th>Empresa</th>
										<th>CEP</th>
										<th>Logradouro</th>
										<th>Número</th>
										<th>Empresa</th>
										<th>Complemento</th>
										<th>Cidade</th>
										<th>UF</th>
									</tr>
								</thead>
								<tbody class="table-group-divider">
									<c:forEach var="f" items="${fornecedores}">
										<tr>
											<td><c:out value="${f.codigo}" /></td>
											<td><c:out value="${f.nome}" /></td>
											<td><c:out value="${f.telefone}" /></td>
											<td><c:out value="${f.email}" /></td>
											<td><c:out value="${f.empresa}" /></td>
											<td><c:out value="${f.CEP}" /></td>
											<td><c:out value="${f.logradouro}" /></td>
											<td><c:out value="${f.numero}" /></td>
											<td><c:out value="${f.bairro}" /></td>
											<td><c:out value="${f.complemento}" /></td>
											<td><c:out value="${f.cidade}" /></td>
											<td><c:out value="${f.UF}" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</c:if>
			</c:when>
			<c:when test="${categoria eq 'insumo'}">
				<c:if test="${not empty insumos }">
					<div class="table-responsive w-100">
						<table class="table table-striped">
							<thead>
								<tr>
									<th class="titulo-tabela" colspan="9"
										style="text-align: center; font-size: 35px;">Lista de
										Insumos</th>
								</tr>
								<tr class="table-dark">
									<th>Código</th>
									<th>Nome</th>
									<th>Preço Custo</th>
									<th>Preço Venda</th>
									<th>Quantidade</th>
									<th>Unidade</th>
									<th>Fornecedor</th>
									<th>Data Compra</th>
								</tr>
							</thead>
							<tbody class="table-group-divider">
								<c:forEach var="i" items="${insumos}">
									<tr>
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
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:if>
			</c:when>
			<c:when test="${categoria eq 'equipamento'}">
				<c:if test="${not empty equipamentos }">
					<div class="table-responsive w-100">
						<table class="table table-striped">
							<thead>
								<tr>
									<th class="titulo-tabela" colspan="6"
										style="text-align: center; font-size: 35px;">Lista de
										Equipamentos</th>
								</tr>
								<tr class="table-dark">
									<th>Código</th>
									<th>Nome</th>
									<th>Descrição</th>
									<th>Fabricante</th>
									<th>Data Aquisição</th>
								</tr>
							</thead>
							<tbody class="table-group-divider">
								<c:forEach var="e" items="${equipamentos}">
									<tr>
										<td><c:out value="${e.codigo}" /></td>
										<td><c:out value="${e.nome}" /></td>
										<td><c:out value="${e.descricao}" /></td>
										<td><c:out value="${e.fabricante}" /></td>

										<td><fmt:formatDate value="${e.dataAquisicao}"
												pattern="dd/MM/yyyy" /></td>

									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:if>
			</c:when>
			<c:when test="${categoria eq 'funcionario'}">
				<c:if test="${not empty funcionarios}">
					<div class="table-responsive w-100">
						<table class="table table-striped table-hover">
							<thead>
								<tr>
									<th class="titulo-tabela" colspan="4"
										style="text-align: center; font-size: 35px;">Lista de
										Funcionário</th>
								</tr>
								<tr class="table-dark">
									<th>CPF</th>
									<th>Nome</th>
									<th>Nv. Acesso</th>
									<th>E-mail</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="f" items="${funcionarios}">
									<tr>
										<td><c:out value="${f.CPF}" /></td>
										<td><c:out value="${f.nome}" /></td>
										<td><c:out value="${f.nivelAcesso}" /></td>
										<td><c:out value="${f.email}" /></td>

									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:if>

			</c:when>
			<c:when test="${categoria eq 'pedido'}">
				<c:if test="${not empty pedidos }">
					<div class="table-responsive w-100">
						<table class="table table-striped">
							<thead>
								<tr>
									<th class="titulo-tabela" colspan="6"
										style="text-align: center; font-size: 35px;">Lista de
										Pedidos</th>
								</tr>
								<tr class="table-dark">
									<th></th>
									<th>Código</th>
									<th>Nome Pedido</th>
									<th>Nome Cliente</th>
									<th>Data Pedido</th>
									<th>Valor Total</th>
									<th>Estado Atual</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="p" items="${pedidos }">
									<tr>
										<td style="text-align: center;">
										<td><c:out value="${p.codigo}" /></td>
										<td><c:out value="${p.nome}" /></td>
										<td><c:out value="${p.cliente.nome}" /></td>
										<td><fmt:formatDate value="${p.dataPedido}"
												pattern="dd/MM/yyyy" /></td>
										<td><fmt:formatNumber value="${p.valorTotal}"
												type="currency" currencySymbol="R$" /></td>
										<td><c:out value="${p.estado}" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:if>
			</c:when>
			<c:when test="${categoria eq 'produto'}">
				<c:if test="${not empty produtos}">
					<div class="table-responsive w-100">
						<table class="table table-striped">
							<thead>
								<tr>
									<th class="titulo-tabela" colspan="8"
										style="text-align: center; font-size: 35px;">Lista de
										Produtos</th>
								</tr>
								<tr class="table-dark">
									<th>Código</th>
									<th>Nome</th>
									<th>Categoria</th>
									<th>Descrição</th>
									<th>Valor</th>
									<th>Status</th>
									<th>Quantidade</th>
									<th>Ref Est</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="p" items="${produtos}">
									<tr>
										<td><c:out value="${p.codigo}" /></td>
										<td><c:out value="${p.nome}" /></td>
										<td><c:out value="${p.categoria}" /></td>
										<td><c:out value="${p.descricao}" /></td>
										<td><fmt:formatNumber value="${p.valorUnitario}"
												type="currency" currencySymbol="R$" /></td>
										<td><c:out value="${p.status}" /></td>
										<td><c:out value="${p.quantidade}" /></td>
										<td><c:out value="${p.refEstoque}" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:if>
			</c:when>

			<c:when test="${categoria eq 'orcamento'}">
				<c:if test="${not empty orcamentos }">
					<div class="table-responsive w-100">
						<table class="table table-striped">
							<thead>
								<tr>
									<th class="titulo-tabela" colspan="9"
										style="text-align: center; font-size: 35px;">Lista de
										Orçamentos</th>
								</tr>
								<tr class="table-dark">
									<th></th>
									<th>Código</th>
									<th>Nome Orçamento</th>
									<th>Descrição</th>
									<th>Nome Cliente</th>
									<th>Data Orçamento</th>
									<th>Forma Pagamento</th>
									<th>Valor Total</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="o" items="${orcamentos }">
									<tr>
										<td style="text-align: center;"></td>
										<td><c:out value="${o.codigo}" /></td>
										<td><c:out value="${o.nome}" /></td>
										<td><c:out value="${o.descricao}" /></td>
										<td><c:out value="${o.cliente.nome}" /></td>
										<td><fmt:formatDate value="${o.dataOrcamento}"
												pattern="dd/MM/yyyy" /></td>
										<td><c:out value="${o.formaPagamento}" /></td>
										<td><fmt:formatNumber value="${o.valorTotal}"
												type="currency" currencySymbol="R$" /></td>

										<td><c:out value="${o.status}" /></td>
										<td>
										<td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:if>
			</c:when>
			<c:when test="${categoria eq 'despesa'}">
				<c:if test="${not empty despesas }">
					<div class="table-responsive w-100">
						<table class="table table-striped">
							<thead>
								<tr>
									<th class="titulo-tabela" colspan="8"
										style="text-align: center; font-size: 35px;">Lista de
										Despesas</th>
								</tr>
								<tr class="table-dark">
									<td>Código</td>
									<td>Nome</td>
									<td>Data Inicial</td>
									<td>Data de Vencimento</td>
									<td>Valor</td>
									<td>Tipo</td>
									<td>Forma de Pagamento</td>
									<td>Estado</td>
								</tr>
							</thead>
							<tbody class="table-group-divider">
								<c:forEach var="d" items="${despesas }">
									<tr>
										<td><c:out value="${d.codigo }" /></td>
										<td><c:out value="${d.nome }" /></td>
										<td><fmt:formatDate value="${d.data}"
												pattern="dd/MM/yyyy" /></td>
										<td><fmt:formatDate value="${d.dataVencimento}"
												pattern="dd/MM/yyyy" /></td>
										<td><fmt:formatNumber value="${d.valor }" type="currency"
												currencySymbol="R$" /></td>
										<td><c:out value="${d.tipo }" /></td>
										<td><c:out value="${d.estado }" /></td>
										<td><c:out value="${d.pagamento }" /></td>

										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:if>
			</c:when>

		</c:choose>
	</div>
	<div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>