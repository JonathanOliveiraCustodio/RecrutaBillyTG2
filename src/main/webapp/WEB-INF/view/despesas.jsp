<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
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
					
					<form action="despesas" method="post" class="row g-3 mt-3">
					
						<!-- Linha de visualização das métricas -->
						<div class="row g-3 justify-content-center bg-body-secondary">
							<div class="col-md-1 d-flex align-items-center">
								<label for="entrada" class="form-label">R$ de Entrada:</label>
							</div>
							<div class="col-md-2">
								<input type="text" id="entrada" name="entrada" class="form-control" placeholder="R$ 0,00" disabled >
							</div> 
							
							<div class="col-md-1 d-flex align-items-center">
								<label for="gasto" class="form-label">R$ de Saída:</label>
							</div>
							<div class="col-md-2">
								<input type="text" id="gasto" name="gasto" class="form-control" placeholder="R$ 0,00" disabled >
							</div>
							
							<div class="col-md-1 d-flex align-items-center">
								<label for="saldo" class="form-label">Saldo Geral:</label>
							</div>
							<div class="col-md-1">
								<input type="text" id="saldo" name="saldo" class="form-control" placeholder="R$ 0,00" disabled >
							</div>
						</div>
						
						<!-- O resto para operação de CRUD -->
						<div class="row g-4 mt-2">
							<div class="cod-md-1 d-flex align-items-center">
								<label for="codigo" class="form-label"></label>
							</div>
							<div class="col-md-3">
								<input type="number" min="0" step="1" id="codigo" name="codigo"
									class="form-control" placeholder="Código"
									value='<c:out value="${despesa.codigo}"></c:out>'>
							</div>
							<div class="col-md-1">
								<input type="submit" id="botao" name="botao" value="Buscar" class="btn btn-info">
							</div>
							
							<div class="col-md-1 d-flex align-items-center">
								<label for="nome" class="form-label">Nome</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="nome" name="nome" class="form-control" 
								placeholder="Nome" value='<c:out value="${despesa.nome}"></c:out>'>
							</div>
							
							<div class="col-md-1 d-flex align-items-center">
								<label for="data" class="form-label">Data</label>
							</div>
							<div class="col-md-3">
								<input type="date" id="data" name="data" class="form-control" 
								placeholder="Data" value='<c:out value="${despesa.data}"></c:out>'>
							</div>
							
							<div class="col-md-1 d-flex align-items-center">
								<label for="dataVencimento" class="form-label">Data de Vencimento</label>
							</div>
							<div class="col-md-3">
								<input type="date" id="dataVencimento" name="dataVencimento" class="form-control"
								placeholder="Data de Vencimento" value='<c:out value="${despesa.dataVencimento }"></c:out>'>
							</div>
							<div class="col-md-1 d-flex align-items-center">
								<label for="pagamento" class="form-label">Forma de Pagamento:</label>
							</div>
							<div class="col-md-3">
								<select id="pagamento" name="pagamento" class="form-select">
									<option value="">Escolha o tipo de pagamento</option>
									<option value="PIX"
										<c:if test="${despesa.pagamento eq 'PIX'}">selected</c:if>>PIX</option>
									<option value="Boleto"
										<c:if test="${despesa.pagamento eq 'Boleto'}">selected</c:if>>Boleto</option>
								</select>
							</div>
							
						</div>
						
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="tipo" class="form-label">Tipo:</label>
							</div>
							<div class="col-md-3">
								<select id="tipo" name="tipo" class="form-select">
									<option value="">Escolha o tipo de despesa</option>
									<option value="Entrada"
										<c:if test="${despesa.tipo eq 'Entrada'}">selected</c:if>>Entrada</option>
									<option value="Saida"
										<c:if test="${despesa.tipo eq 'Saida'}">selected</c:if>>Saida</option>
								</select>
							</div>
							
							<div class="col-md-1 d-flex align-items-center">
								<label for="valor" class="form-label">Valor</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="valor" name="valor" class="form-control" 
								placeholder="Nome" value='<c:out value="${despesa.valor}"></c:out>'>
							</div>
							
							<div class="col-md-1 d-flex align-items-center">
								<label for="estado" class="form-label">Estado:</label>
							</div>
							<div class="col-md-3">
								<select id="estado" name="estado" class="form-select">
									<option value="">Escolha um Estado para a Despesa</option>
									<option value="Pendente"
										<c:if test="${despesa.estado eq 'Pendente'}">selected</c:if>>Pendente</option>
									<option value="Pago"
										<c:if test="${despesa.tipo eq 'Pago'}">selected</c:if>>Pago</option>
								</select>
							</div>
						</div>
						
						<div class="row g-3 mt-3 align-items-right">
							<div class="col-md-1 d-flex align-items-center">
								<label for="filtro" class="form-label">Filtrar por:</label>
							</div>
							<div class="col-md-2 d-grid text-center">
								<select id="filtro" name="filtro" class="form-select">
									<option value="0">Mês</option>
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
								</select>
							</div>
						</div>
						
						<div class="row g-3 mt-3">
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Cadastrar"
									class="btn btn-success">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Alterar"
									class="btn btn-warning">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botao" name="botao" value="Excluir"
									class="btn btn-danger">
							</div>
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
	<br />
		<div class="container py-4 text-center d-flex justify-content-center"
		align="center">
		<c:if test="${not empty despesas }">
			<table class="table table-striped">
				<thead>
					<tr>
						<th class="titulo-tabela" colspan="8"
							style="text-align: center; font-size: 23px;">Lista de
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
								<button class="btn btn-info" name="opcao" value="${d.codigo}"
									onclick="editarDespesa(this.value)"
									${d.codigo eq codigoEdicao ? 'checked' : ''}>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									  <path
											d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
									</svg>
								</button>
							</td>
							<td><c:out value="${d.codigo }" /></td>
							<td><c:out value="${d.nome }" /></td>
							<td><c:out value="${d.data }" /></td>
							<td><c:out value="${d.dataVencimento }" /></td>
							<td><c:out value="${d.valor }" /></td>
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