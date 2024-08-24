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
<script src="${pageContext.request.contextPath}/resources/js/despesa.js"></script>
<title>Despesas</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<c:if test="${nivelAcesso == 'admin' }">
			<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
				<div class="container-fluid py-1">
					<h1 class="display-6 fw-bold">Gestão de Despesas</h1>
					<form action="despesas" method="post"
						class="row g-3 mt-3 justify-content-center"
						onsubmit="return validarFormulario(event);">
						<!-- Linha de visualização das métricas -->
						<div
							class="row g-2 justify-content-center align-items-center bg-body-secondary d-flex"
							style="min-height: 120px;">
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="entrada" name="entrada"
										class="form-control" placeholder="R$ 0,00" value="${entrada}"
										disabled> <label for="entrada">R$ de Entrada</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="gasto" name="gasto" class="form-control"
										placeholder="R$ 0,00" value="${gasto}" disabled> <label
										for="gasto">R$ de Saída</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="saldo" name="saldo" class="form-control"
										placeholder="R$ 0,00" value="${saldo}" disabled> <label
										for="saldo">Saldo Geral</label>
								</div>
							</div>
						</div>
						<!-- O resto para operação de CRUD -->
						<!-- Primeira Linha: Nome, Data, Data Vencimento -->
						<div class="row g-4 mt-2 justify-content-center">
							<input type="hidden" min="0" step="1" id="codigo" name="codigo"
								class="form-control" placeholder="Código"
								value='<c:out value="${despesa.codigo}"></c:out>'>

							<div class="col-md-3">
								<div class="form-floating">
									<input type="text" id="nome" name="nome" class="form-control"
										placeholder="Nome"
										value='<c:out value="${despesa.nome}"></c:out>'> <label
										for="nome">Nome</label>
								</div>
							</div>
														<div class="col-md-1">
								<button type="submit" id="botao" name="botao" value="Pesquisar"
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
									<input type="date" id="data" name="data" class="form-control"
										placeholder="Data"
										value='<c:out value="${despesa.data}"></c:out>'> <label
										for="data">Data</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input type="date" id="dataVencimento" name="dataVencimento"
										class="form-control" placeholder="Data de Vencimento"
										value='<c:out value="${despesa.dataVencimento}"></c:out>'>
									<label for="dataVencimento">Data de Vencimento</label>
								</div>
							</div>

						</div>
						<!-- Segunda Linha:  -->
						<div class="row g-3 mt-2 justify-content-center">
							<div class="col-md-4">
								<div class="form-floating">
									<select id="tipo" name="tipo" class="form-select">
										<option value="">Escolha o tipo de despesa</option>
										<option value="Entrada"
											<c:if test="${despesa.tipo eq 'Entrada'}">selected</c:if>>Entrada</option>
										<option value="Saida"
											<c:if test="${despesa.tipo eq 'Saida'}">selected</c:if>>Saida</option>
									</select> <label for="tipo">Tipo</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="valor" name="valor" class="form-control"
										placeholder="Valor"
										value='<c:out value="${despesa.valor}"></c:out>'
										oninput="formatarMoeda(this)"> <label
										for="valor">Valor</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<select id="estado" name="estado" class="form-select">
										<option value="">Escolha um Estado para a Despesa</option>
										<option value="Pendente"
											<c:if test="${despesa.estado eq 'Pendente'}">selected</c:if>>Pendente</option>
										<option value="Pago"
											<c:if test="${despesa.estado eq 'Pago'}">selected</c:if>>Pago</option>
									</select> <label for="estado">Estado</label>
								</div>
							</div>
						</div>
						<!-- Terceira Linha:  -->
						<div class="row g-3 mt-2">
							<div class="col-md-4">
								<div class="form-floating">
									<select id="pagamento" name="pagamento" class="form-select">
										<option value="">Escolha o tipo de pagamento</option>
										<option value="PIX"
											<c:if test="${despesa.pagamento eq 'PIX'}">selected</c:if>>PIX</option>
										<option value="Boleto"
											<c:if test="${despesa.pagamento eq 'Boleto'}">selected</c:if>>Boleto</option>
									</select> <label for="pagamento">Forma de Pagamento</label>
								</div>
							</div>
						</div>

						<!-- Linha dos Botões -->
						<div class="row g-3 mt-3">
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Cadastrar"
									class="btn btn-success" style="height: 55.5px;">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Alterar"
									class="btn btn-warning">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Excluir"
									class="btn btn-danger">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Listar" 
									class="btn btn-secondary"></div>
							<div class="col-md-2">
								<div class="form-floating">
									<select id="filtro" name="filtro" class="form-select">
										<option value="0">Todos</option>
										<option value="1">Janeiro</option>
										<option value="2">Fevereiro</option>
										<option value="3">Março</option>
										<option value="4">Abril</option>
										<option value="5">Maio</option>
										<option value="6">Junho</option>
										<option value="7">Julho</option>
										<option value="8">Agosto</option>
										<option value="9">Setembro</option>
										<option value="10">Outubro</option>
										<option value="11">Novembro</option>
										<option value="12">Dezembro</option>
									</select> <label for="filtro">Filtrar por</label>
								</div>
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao"
									value="Limpar Campos" class="btn btn-secondary">
							</div>
						</div>
						<div class="col-md-2 d-grid text-center"></div>
						
						
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
		<c:if test="${not empty despesas }">
			<table class="table table-striped">
				<thead>
					<tr>
						<th class="titulo-tabela" colspan="10"
							style="text-align: center; font-size: 35px;">Lista de
							Despesas</th>
					</tr>
					<tr class="table-dark">
						<td></td>
						<td>Código</td>
						<td>Nome</td>
						<td>Data Inicial</td>
						<td>Data de Vencimento</td>
						<td>Valor</td>
						<td>Tipo</td>
						<td>Forma de Pagamento</td>
						<td>Estado</td>
						<td>Excluir</td>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<c:forEach var="d" items="${despesas }">
						<tr>
							<td style="text-align: center;">
								<button class="btn btn-outline-dark" name="opcao"
									value="${d.codigo}" onclick="editarDespesa(this.value)"
									${d.codigo eq codigoEdicao ? 'checked' : ''}>
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
							<td><c:out value="${d.codigo }" /></td>
							<td><c:out value="${d.nome }" /></td>
							<td><fmt:formatDate value="${d.data}"
										pattern="dd/MM/yyyy" /></td>									
										<td><fmt:formatDate value="${d.dataVencimento}"
										pattern="dd/MM/yyyy" /></td>
							<td><fmt:formatNumber value="${d.valor }"
										type="currency" currencySymbol="R$" /></td>
							<td><c:out value="${d.tipo }" /></td>
							<td><c:out value="${d.estado }" /></td>
							<td><c:out value="${d.pagamento }" /></td>
							<td style="text-align: center;">
								<button class="btn btn-danger"
									onclick="excluirDespesa('${d.codigo}')">Excluir</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>