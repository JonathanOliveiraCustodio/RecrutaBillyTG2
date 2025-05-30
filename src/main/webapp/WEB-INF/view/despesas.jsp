<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/styles.css">
<script
	src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/despesa.js"></script>
<title>Despesas</title>

<script>
	function buscarPessoa() {
		document.forms[0].submit(); // Submete o primeiro formulário da página
	}
</script>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<c:if test="${nivelAcesso == 'admin' }">
			<div class="p-5 mb-4 bg-light rounded-3 text-center shadow">
				<div class="container-fluid py-1">
					<h1 class="display-6 fw-bold">Gestão de Despesas</h1>

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

					<form action="despesas" method="post"
						class="row g-3 mt-3 justify-content-center"
						onsubmit="return validarFormulario(event);">
						<!-- Linha de visualização das métricas -->
						<div
							class="row g-2 justify-content-center align-items-center bg-light d-flex"
							style="min-height: 120px;">
							<div class="col-md-4">
								<h5 class="text-center-custom">R$ de Entrada</h5>
								<div class="form-floating">
									<input class="form-control text-center" type="text"
										id="entrada" name="entrada" placeholder="R$ 0,00"
										value='<fmt:formatNumber value="${entrada}" type="currency" currencySymbol="R$" />'
										disabled /> <label for="entrada"></label>
								</div>
							</div>
							<div class="col-md-4">
								<h5 class="text-center-custom">R$ de Saída</h5>
								<div class="form-floating">
									<input type="text" id="gasto" name="gasto"
										class="form-control text-center" placeholder="R$ 0,00"
										value='<fmt:formatNumber value="${gasto}" type="currency" currencySymbol="R$" />'
										disabled> <label for="gasto"></label>
								</div>
							</div>
							<div class="col-md-4">
								<h5 class="text-center-custom">Saldo Geral</h5>
								<div class="form-floating">
									<input type="text" id="saldo" name="saldo"
										class="form-control text-center" placeholder="R$ 0,00"
										value='<fmt:formatNumber value="${saldo}" type="currency" currencySymbol="R$" />'
										disabled> <label for="saldo"></label>
								</div>
							</div>
						</div>

						<!-- Primeira Linha: Nome, Data, Data Vencimento -->
						<div class="row g-3">
							<div class="col-md-4">
								<div class="form-floating">
									<input type="number" min="0" step="1" id="codigo" name="codigo"
										class="form-control" placeholder="Código"
										value='<c:out value="${despesa.codigo }"></c:out>' readonly>
									<label for="codigo">Código</label>
								</div>
							</div>
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
										for="data">Data de Registro</label>
								</div>
							</div>
						</div>

						<!-- Segunda Linha: Data de Vencimento, Tipo, Valor -->
						<div class="row g-3 mt-2 justify-content-center">
							<div class="col-md-4">
								<div class="form-floating">
									<input type="date" id="dataVencimento" name="dataVencimento"
										class="form-control" placeholder="Data de Vencimento"
										value='<c:out value="${despesa.dataVencimento}"></c:out>'>
									<label for="dataVencimento">Data de Vencimento</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<select id="tipo" name="tipo" class="form-select">
										<option value="">Escolha o tipo de despesa</option>
										<option value="Entrada"
											<c:if test="${despesa.tipo eq 'Entrada'}">selected</c:if>>Entrada</option>
										<option value="Saída"
											<c:if test="${despesa.tipo eq 'Saída'}">selected</c:if>>Saída</option>
									</select> <label for="tipo">Tipo</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input class="form-control" type="text" id="valor" name="valor"
										placeholder="Valor"
										value='<fmt:formatNumber value="${despesa.valor}" type="currency" currencySymbol="R$" />'>
									<label for="valor">Valor Total:</label>
								</div>
							</div>
						</div>

						<!-- Terceira Linha: Estado, Forma de Pagamento, Filtro -->
						<div class="row g-3 mt-2">
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
							<div class="col-md-4">
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
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Excluir"
									class="btn btn-danger btn-align">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Listar"
									class="btn btn-dark btn-align">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao"
									value="Limpar Campos" class="btn btn-secondary">
							</div>
							<div class="col-md-2 d-grid text-center">
								<!-- Botão para abrir o modal de visualização de material -->
								<button type="button" class="btn btn-purple btn-align"
									onclick="abrirModalCliente('${cliente.codigo}')">Ver
									Detalhes</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</c:if>
	</div>

	<div class="container py-4 text-center d-flex justify-content-center"
		align="center">
		<c:if test="${nivelAcesso == 'admin' && not empty despesas }">
			<div class="table-responsive w-100">
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
								<td><fmt:formatDate value="${d.data}" pattern="dd/MM/yyyy" /></td>
								<td><fmt:formatDate value="${d.dataVencimento}"
										pattern="dd/MM/yyyy" /></td>
								<td><fmt:formatNumber value="${d.valor }" type="currency"
										currencySymbol="R$" /></td>
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
			</div>
		</c:if>
	</div>
	<div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>