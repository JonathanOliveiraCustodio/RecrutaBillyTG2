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
	src="${pageContext.request.contextPath}/resources/js/relatorio.js"></script>
<title>Relatórios</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-1">
				<h1 class="display-6 fw-bold">Gerar Relatório</h1>
				<form action="relatorio" method="post" class="row g-3 mt-3"
					id="form-relatorio">
					<!-- Linha do Formulário -->
					<div class="row g-3">
						<!-- Categoria -->
						<div class="col-md-4 d-flex align-items-center">
							<label for="categoria" class="form-label">Categoria:</label> <select
								class="form-select ms-2" id="categoria" name="categoria"
								onchange="atualizarOpcoes()">
								<option value="">Escolha uma Categoria</option>
								<option value="cliente"
									${categoria == 'cliente' ? 'selected' : ''}>Cliente</option>
								<option value="equipamento"
									${categoria == 'equipamento' ? 'selected' : ''}>Equipamento</option>
								<option value="fornecedor"
									${categoria == 'fornecedor' ? 'selected' : ''}>Fornecedor</option>
								<option value="funcionario"
									${categoria == 'funcionario' ? 'selected' : ''}>Funcionário</option>
								<option value="insumo"
									${categoria == 'insumo' ? 'selected' : ''}>Insumo</option>
								<option value="pedido"
									${categoria == 'pedido' ? 'selected' : ''}>Pedido</option>
								<option value="produto"
									${categoria == 'produto' ? 'selected' : ''}>Produto</option>
							</select>
						</div>

						<!-- Opção -->
						<div class="col-md-4 d-flex align-items-center">
							<label for="opcao" class="form-label">Opção:</label> <select
								class="form-select ms-2" id="opcao" name="opcao">
								<!-- As opções serão preenchidas dinamicamente com base na categoria selecionada -->
								<option value="${opcao}" selected>${opcao}</option>
							</select>
						</div>

						<!-- Parâmetro de Pesquisa -->
						<div class="col-md-4 d-flex align-items-center">
							<label for="parametro" class="form-label">Filtro de
								Pesquisa:</label> <input type="text" id="parametro" name="parametro"
								class="form-control ms-2" placeholder="Digite o Filtro"
								value="${parametro}">
						</div>
					</div>
					<!-- Linha dos Botões -->
					<div class="row g-3 mt-3 justify-content-center">
						<div class="col-md-2 d-grid text-center">
							<input type="button" id="botaoPdf" name="botaoPdf"
								value="Gerar Relatório" class="btn btn-success"
								onclick="gerarRelatorioPDF()">
						</div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao"
								value="Visualizar Relatório" class="btn btn-warning"
								onclick="resetarFormulario()">
						</div>

						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Limpar"
								class="btn btn-secondary" onclick="resetarFormulario()">
						</div>
					</div>
				</form>
			</div>
		</div>
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
	<br />

	<div class="container py-4 text-center d-flex justify-content-center"
		align="center">
		<c:choose>
			<c:when test="${categoria eq 'cliente'}">
				<c:if test="${not empty clientes}">
					<table class="table table-striped">
						<thead>
							<tr>
								<th class="titulo-tabela" colspan="6"
									style="text-align: center; font-size: 23px;">Lista de
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
				</c:if>

			</c:when>
			<c:when test="${categoria eq 'fornecedor'}">
				<c:if test="${not empty fornecedores}">
					<table class="table table-striped">
						<thead>
							<tr>
								<th class="titulo-tabela" colspan="14"
									style="text-align: center; font-size: 23px;">Lista de
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
				</c:if>
			</c:when>
			<c:when test="${categoria eq 'insumo'}">
				<c:if test="${not empty insumos }">
					<table class="table table-striped">
						<thead>
							<tr>
								<th class="titulo-tabela" colspan="9"
									style="text-align: center; font-size: 23px;">Lista de
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
				</c:if>
			</c:when>
			<c:when test="${categoria eq 'equipamento'}">
				<c:if test="${not empty equipamentos }">
					<table class="table table-striped">
						<thead>
							<tr>
								<th class="titulo-tabela" colspan="6"
									style="text-align: center; font-size: 23px;">Lista de
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
				</c:if>
			</c:when>
			<c:when test="${categoria eq 'funcionario'}">
				<c:if test="${not empty funcionarios}">
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th class="titulo-tabela" colspan="4"
									style="text-align: center; font-size: 32px;">Lista de
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
				</c:if>

			</c:when>
			<c:when test="${categoria eq 'pedido'}">
				<c:if test="${not empty pedidos }">
					<table class="table table-striped">
						<thead>
							<tr>
								<th class="titulo-tabela" colspan="8"
									style="text-align: center; font-size: 23px;">Lista de
									Pedidos</th>
							</tr>
							<tr class="table-dark">

								<th>Código</th>
								<th>Nome Pedido</th>
								<th>Código Cliente</th>
								<th>Nome Cliente</th>
								<th>Data Pedido</th>
								<th>Produtos</th>
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
									<td><c:out value="${p.cliente.codigo}" /></td>
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
				</c:if>
			</c:when>
			<c:when test="${categoria eq 'produto'}">
				<c:if test="${not empty produtos}">
					<table class="table table-striped">
						<thead>
							<tr>
								<th class="titulo-tabela" colspan="8"
									style="text-align: center; font-size: 23px;">Lista de
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
				</c:if>
			</c:when>
		</c:choose>
	</div>

	<div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>