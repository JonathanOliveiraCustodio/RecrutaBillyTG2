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
	src="${pageContext.request.contextPath}/resources/js/manutencoesEquipamento.js"></script>
<title>Gerenciar Insumos Produto</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-1">
				<h1 class="display-6 fw-bold">Gerenciar Manutenções de um
					Equipamento</h1>
				<form action="manutencoesEquipamento" method="post"
					onsubmit="return validarFormulario(event);" class="row g-3 mt-3">
					<input type="hidden" id="equipamento" name="equipamento"
						value='<c:out value="${equipamento.codigo}"></c:out>'>

					<!-- Linha do Formulário -->
					<div class="row justify-content-center g-3">
						<!-- Descrição -->
						<div class="col-md-6">
							<div class="form-floating">
								<input class="form-control" type="text" id="descricao"
									name="descricao" placeholder="Descrição"
									value='<c:out value="${manutencaoEquipamento.descricao}"></c:out>'>
								<label for="descricao">Descrição</label>
							</div>
						</div>
					</div>

					<!-- Linha dos Botões -->
					<div class="row justify-content-center g-3 mt-3">
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Cadastrar"
								class="btn btn-success">
						</div>
					</div>
				</form>
			</div>
		</div>

		<div align="center">
			<c:if test="${not empty erro}">
				<h2 style="color: #dc3545;">
					<b><c:out value="${erro}" /></b>
				</h2>
			</c:if>
		</div>
		<div align="center">
			<c:if test="${not empty saida}">
				<h2 style="color: #198754;">
					<b><c:out value="${saida}" /></b>
				</h2>
			</c:if>
		</div>

		<div align="center" class="mt-4">
			<c:if test="${not empty equipamentoManutencoes}">
				<table class="table table-striped">
					<thead>
						<tr>
							<th class="titulo-tabela" colspan="5"
								style="text-align: center; font-size: 35px;">Lista de
								Manutenções de um Equipamento</th>
						</tr>
						<tr class="table-dark">
							<th>Nome Equipamento</th>
							<th>Codigo Manutencao</th>
							<th>Descrição</th>
							<th>Data</th>
							<th>Ação</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="em" items="${equipamentoManutencoes}">
							<tr>
								<td><c:out value="${em.equipamento.nome}" /></td>
								<td><c:out value="${em.codigoManutencao}" /></td>
								<td><c:out value="${em.descricao}" /></td>
								<td><fmt:formatDate value="${em.dataManutencao}"
										pattern="dd/MM/yyyy" /></td>
								<td>
									<form action="manutencoesEquipamento" method="post"
										onsubmit="return validarFormulario(event);">
										<input type="hidden" name="equipamento"
											value="${em.codigoEquipamento}"> <input type="hidden"
											name="equipamento" value="${em.equipamento.codigo}">
										<input type="hidden" name="codigoManutencao"
											value="${em.codigoManutencao}"> <input type="hidden"
											name="botao" value="Excluir">
										<button type="submit" class="btn btn-danger" value="Excluir">Excluir</button>
									</form>
								</td>
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