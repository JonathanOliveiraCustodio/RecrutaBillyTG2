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
<title>Equipamento</title>
</head>
<body>
	<script
		src="${pageContext.request.contextPath}/resources/js/equipamento.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<c:if test="${nivelAcesso == 'admin'}">
			<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
				<div class="container-fluid py-1">
					<h1 class="display-6 fw-bold">Manutenção de Equipamento</h1>
					<form action="equipamento" method="post" class="row g-3 mt-3"
						onsubmit="return validarFormulario(event);">
						<!-- Primeira Linha: Código, Nome, Fabricante -->
						<div class="row g-3">
							<div class="col-md-4">
								<div class="form-floating">
									<input type="number" min="0" step="1" id="codigo" name="codigo"
										class="form-control" placeholder="Código"
										value='<c:out value="${equipamento.codigo }"></c:out>'
										readonly> <label for="codigo">Código</label>
								</div>
							</div>

							<div class="col-md-3">
								<div class="form-floating">
									<input type="text" id="nome" name="nome" class="form-control"
										placeholder="Nome" maxlength="100"
										value='<c:out value="${equipamento.nome }"></c:out>'>
									<label for="nome">Nome</label>
								</div>
							</div>
							<div class="col-md-1">
								<button type="submit" id="botao" name="botao" value="Buscar"
									class="btn btn-outline-primary btn-align w-100 d-flex justify-content-center align-items-center"
									onclick="return validarBusca()">
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
									<input type="text" id="fabricante" name="fabricante"
										class="form-control" placeholder="Fabricante" maxlength="50"
										value='<c:out value="${equipamento.fabricante }"></c:out>'>
									<label for="fabrincante">Fabricante</label>
								</div>
							</div>
						</div>

						<!-- Segunda Linha: Descrição -->
						<div class="row g-3 mt-2">
							<div class="col-md-12">
								<div class="form-floating">
									<textarea class="form-control" id="descricao" name="descricao"
										placeholder="Descrição" maxlength="100">${equipamento.descricao}</textarea>
									<label for="descricao">Descrição</label>
								</div>
							</div>
						</div>
						<!-- Terceira Linha: Data de Manutenção -->
						<div class="row g-3 mt-2">
							<div class="col-md-4">
								<div class="form-floating">
									<input type="date" id="dataAquisicao" name="dataAquisicao"
										class="form-control"
										value='<c:out value="${equipamento.dataAquisicao}"></c:out>'>
									<label for="dataAquisicao">Data de Aquisição</label>
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
									class="btn btn-danger btn-align"
									onclick="return confirmarExclusao()">
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

	<div class="container py-4 text-center d-flex justify-content-center"
		align="center">
		<c:if test="${nivelAcesso == 'admin' && not empty equipamentos}">
			<div class="table-responsive">
				<table class="table table-striped">
					<thead>
						<tr>
							<th class="titulo-tabela" colspan="8"
								style="text-align: center; font-size: 35px;">Lista de
								Equipamentos</th>
						</tr>
						<tr class="table-dark">
							<th></th>
							<th>Código</th>
							<th>Nome</th>
							<th>Descrição</th>
							<th>Fabricante</th>
							<th>Data Aquisição</th>
							<th>Manutenções</th>
							<th>Excluir</th>
						</tr>
					</thead>
					<tbody class="table-group-divider">
						<c:forEach var="e" items="${equipamentos}">
							<tr>
								<td style="text-align: center;">
									<button class="btn btn-outline-dark" name="opcao"
										value="${e.codigo}" onclick="editarEquipamento(this.value)"
										${e.codigo eq codigoEdicao ? 'checked' : ''}>
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
								<td><c:out value="${e.codigo}" /></td>
								<td><c:out value="${e.nome}" /></td>
								<td><c:out value="${e.descricao}" /></td>
								<td><c:out value="${e.fabricante}" /></td>
								<td><fmt:formatDate value="${e.dataAquisicao}"
										pattern="dd/MM/yyyy" /></td>
								<td>
									<button
										onclick="window.location.href='manutencoesEquipamento?equipamento=${e.codigo}'"
										class="btn btn-info">Adicionar</button>
								</td>
								<td style="text-align: center;">
									<button class="btn btn-danger"
										onclick="excluirEquipamento('${e.codigo}')">Excluir</button>
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
