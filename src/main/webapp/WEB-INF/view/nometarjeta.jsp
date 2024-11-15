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
	src="${pageContext.request.contextPath}/resources/js/nomeTarjeta.js"></script>
<title>Nomes Tarjetas</title>

</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<c:if test="${nivelAcesso == 'admin'}">
			<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
				<div class="container-fluid py-1">
					<h1 class="display-6 fw-bold">Manutenção de Nomes de Tarjetas</h1>

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

					<form action="nometarjeta" method="post" class="row g-3 mt-3"
						onsubmit="return validarFormulario(event);">
						<!-- Primeira Linha: Código, Nome, Preço de Custo -->
						<div class="row g-3">
							<div class="col-md-4">
								<div class="form-floating">
									<input class="form-control" type="number" min="0" step="1"
										id="codigo" name="codigo" placeholder="Código"
										value='<c:out value="${nometarjeta.codigo}"></c:out>'>
									<label for="codigo">Código</label>
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-floating">
									<input class="form-control" type="text" id="nome" name="nome"
										placeholder="Nome" maxlength="100"
										value='<c:out value="${nometarjeta.nome}"></c:out>'> <label
										for="nome">Nome</label>
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
									<select id="tipoSanguineo" name="tipoSanguineo"
										class="form-select">
										<option value="">Escolha um Tipo Sanguíneo</option>
										<option value="A"
											<c:if test="${nometarjeta.tipoSanguineo == 'A'}">selected</c:if>>A</option>
										<option value="B"
											<c:if test="${nometarjeta.tipoSanguineo == 'B'}">selected</c:if>>B</option>
										<option value="AB"
											<c:if test="${nometarjeta.tipoSanguineo == 'AB'}">selected</c:if>>AB</option>
										<option value="O"
											<c:if test="${nometarjeta.tipoSanguineo == 'O'}">selected</c:if>>O</option>
									</select> <label for="tipoSanguineo">Tipo Sanguíneo</label>
								</div>
							</div>
						</div>

						<!-- Segunda Linha: Preço de Venda, Quantidade, Unidade -->
						<div class="row g-3 mt-2">
							<div class="col-md-4">
								<div class="form-floating">
									<select id="fatorRH" name="fatorRH" class="form-select">
										<option value="">Escolha um Fator RH</option>
										<option value="Positivo"
											<c:if test="${nometarjeta.fatorRH == 'Positivo'}">selected</c:if>>Positivo</option>
										<option value="Negativo"
											<c:if test="${nometarjeta.fatorRH == 'Negativo'}">selected</c:if>>Negativo</option>
									</select> <label for="fatorRH">Fator RH</label>
								</div>
							</div>

							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="quantidade" name="quantidade"
										class="form-control" placeholder="Quantidade"
										value='<c:out value="${nometarjeta.quantidade}"></c:out>'
										oninput="formatarQuantidade(this)"> <label
										for="quantidade">Quantidade</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<select id="patente" name="patente" class="form-select">
										<option value="0">Escolha um Patente</option>
										<c:forEach var="p" items="${patentes}">
											<option value="${p.codigo}"
												<c:if test="${p.codigo eq nometarjeta.patente.codigo}">selected</c:if>>
												<c:out value="${p}" />
											</option>
										</c:forEach>
									</select> <label for="patente">Patente</label>
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

	<div class="container py-4 text-center d-flex justify-content-center"
		align="center">
		<div class="table-responsive w-100">
			<form id="formEditar"
				action="${pageContext.request.contextPath}/nometarjeta"
				method="post">
				<input type="hidden" id="codigoEditar" name="codigo" value="" /> <input
					type="hidden" name="botao" value="Selecionar" />
			</form>
			<form id="formExcluir"
				action="${pageContext.request.contextPath}/nometarjeta"
				method="post">
				<input type="hidden" id="codigoExcluir" name="codigo" value="" /> <input
					type="hidden" name="botao" value="Excluir" />
			</form>
			<form id="formSalvarTodos"
				action="${pageContext.request.contextPath}/nometarjeta"
				method="post">
				<table class="table table-striped">
					<thead>
						<tr>
							<th class="titulo-tabela" colspan="11"
								style="text-align: center; font-size: 35px;">Lista de Nomes
								Tarjetas</th>
						</tr>
						<tr class="table-dark">
							<th></th>
							<th>Código</th>
							<th>Nome</th>
							<th>Tipo Sanguíneo</th>
							<th>Fator RH</th>
							<th>Quantidade</th>
							<th>Patente</th>
							<th>Excluir</th>
						</tr>
					</thead>
					<tbody class="table-group-divider">
						<c:forEach var="nt" items="${nomesTarjetas}" varStatus="status">
							<tr>
								<td style="text-align: center;">
									<button type="button" class="btn btn-outline-dark"
										onclick="editarNomeTarjeta('${nt.codigo}')">
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
								<td><input type="text" name="codigo[${status.index}]"
									value="${nt.codigo}" readonly style="width: 80px;" /></td>
								<td><input type="text" name="nome[${status.index}]"
									value="${nt.nome}" /></td>
								<td><select name="tipoSanguineo[${status.index}]"
									class="form-select" style="min-width: 80px;">
										<option value=""></option>
										<option value="A" ${nt.tipoSanguineo == 'A' ? 'selected' : ''}>A</option>
										<option value="B" ${nt.tipoSanguineo == 'B' ? 'selected' : ''}>B</option>
										<option value="AB"
											${nt.tipoSanguineo == 'AB' ? 'selected' : ''}>AB</option>
										<option value="O" ${nt.tipoSanguineo == 'O' ? 'selected' : ''}>O</option>
								</select></td>
								<td><select name="fatorRH[${status.index}]"
									class="form-select" style="min-width: 80px;">
										<option value="">Escolha um Fator RH</option>
										<option value="Positivo"
											${nt.fatorRH == 'Positivo' ? 'selected' : ''}>Positivo</option>
										<option value="Negativo"
											${nt.fatorRH == 'Negativo' ? 'selected' : ''}>Negativo</option>
								</select></td>
								<td><input type="number" name="quantidade[${status.index}]"
									value="${nt.quantidade}" style="width: 80px;" /></td>
								<td><select name="patente[${status.index}]"
									class="form-select">
										<c:forEach var="pat" items="${patentes}">
											<option value="${pat.codigo}"
												${nt.patente.codigo eq pat.codigo ? 'selected' : ''}>${pat.nome}</option>
										</c:forEach>
								</select></td>
								<td style="text-align: center;">
									<button type="button" class="btn btn-danger"
										onclick="excluirNomeTarjeta('${nt.codigo}')">Excluir</button>
								</td>
							</tr>
						</c:forEach>
						<!-- Linha para adicionar um novo registro -->
						<tr>
							<td colspan="2" style="text-align: center;">
								<button type="submit" class="btn btn-success" name="botao"
									value="Salvar Novo" onclick="return validarSalvarNovo()">Salvar
									Novo</button>

							</td>
							<td><input type="text" name="novoNome"
								placeholder="Novo Nome" /></td>
							<td><select name="novoTipoSanguineo" class="form-select"
								style="min-width: 80px;">
									<option value="">Tipo Sanguíneo</option>
									<option value="A">A</option>
									<option value="B">B</option>
									<option value="AB">AB</option>
									<option value="O">O</option>
							</select></td>
							<td><select name="novoFatorRH" class="form-select"
								style="min-width: 80px;">
									<option value="">Fator RH</option>
									<option value="Positivo">Positivo</option>
									<option value="Negativo">Negativo</option>
							</select></td>
							<td><input type="number" name="novoQuantidade"
								placeholder="Quantidade" style="width: 80px;" /></td>
							<td><select name="novoPatente" class="form-select">
									<c:forEach var="pat" items="${patentes}">
										<option value="${pat.codigo}">${pat.nome}</option>
									</c:forEach>
							</select></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<button type="submit" class="btn btn-primary" name="botao"
					value="Salvar Todos">Salvar Todos</button>
			</form>
		</div>
	</div>

	<div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>
