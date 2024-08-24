<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cliente</title>
</head>
<body>
	<script
		src="${pageContext.request.contextPath}/resources/js/endereco.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">

		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-1">
				<h1 class="display-6 fw-bold">Manutenção de Endereço</h1>
				<form action="endereco" method="post" class="row g-3 mt-3"
					onsubmit="return validarFormulario(event);">
					<input type="hidden" id="funcionario" name="funcionario"
						value='<c:out value="${funcionario.CPF}"></c:out>'>
					<input type="hidden" id="codigo" name="codigo"
						value='<c:out value="${endereco.codigo}"></c:out>'>

					<!-- Primeira Linha: CEP, Logradouro, Bairro -->
					<div class="row g-3">
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="CEP" name="CEP" class="form-control"
									placeholder="CEP" maxlength="9"
									value='<c:out value="${endereco.CEP }"></c:out>'
									onblur="buscarEndereco()"> <label for="cep">CEP</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="logradouro" name="logradouro"
									class="form-control" placeholder="Logradouro" maxlength="100"
									value='<c:out value="${endereco.logradouro }"></c:out>'
									readonly> <label for="logradouro">Logradouro</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="bairro" name="bairro"
									class="form-control" placeholder="Bairro" maxlength="100"
									value='<c:out value="${endereco.bairro }"></c:out>' readonly>
								<label for="bairro">Bairro</label>
							</div>
						</div>
					</div>

					<!-- Quarta Linha: UF, Localidade, Numero -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="UF" name="UF" class="form-control"
									placeholder="UF" maxlength="2"
									value='<c:out value="${endereco.UF }"></c:out>' readonly>
								<label for="uf">UF</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="localidade" name="localidade"
									class="form-control" placeholder="Localidade" maxlength="100"
									value='<c:out value="${endereco.localidade }"></c:out>'
									readonly> <label for="localidade">Localidade</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="numero" name="numero"
									class="form-control" placeholder="Número" maxlength="10"
									value='<c:out value="${endereco.numero }"></c:out>'> <label
									for="numero">Número</label>
							</div>
						</div>
					</div>

					<!-- Quinta Linha: Complemento, Tipo de Endereço -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="complemento" name="complemento"
									class="form-control" placeholder="Complemento"
									value='<c:out value="${endereco.complemento }"></c:out>'>
								<label for="complemento">Complemento</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<select class="form-select" id="tipoEndereco"
									name="tipoEndereco">
									<option value="">Escolha um Tipo de Endereço</option>
									<option value="Residencial"
										<c:if test="${endereco.tipoEndereco eq 'Residencial'}">selected</c:if>>Residencial</option>
									<option value="Comercial"
										<c:if test="${endereco.tipoEndereco eq 'Comercial'}">selected</c:if>>Comercial</option>
								</select> <label for="tipoEndereco">Tipo de Endereço</label>
							</div>
						</div>
					</div>

					<!-- Linha dos Botões -->
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
		<c:if test="${not empty enderecos }">
			<table class="table table-striped">
				<thead>
					<tr>
						<th class="titulo-tabela" colspan="12"
							style="text-align: center; font-size: 35px;">Lista de
							Endereço</th>
					</tr>
					<tr class="table-dark">
						<th></th>
						<th>Código</th>
						<th>CPF</th>
						<th>CEP</th>
						<th>Logradouro</th>
						<th>Bairro</th>
						<th>UF</th>
						<th>Localidade</th>
						<th>Número</th>
						<th>Complemento</th>
						<th>Tipo Endereco</th>
						<th>Excluir</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<c:forEach var="e" items="${enderecos }">
						<tr>
							<td style="text-align: center;">
								<button class="btn btn-outline-dark" name="opcao"
									value="${e.codigo}"
									onclick="editarEndereco(${e.codigo}, '${e.funcionario.CPF}')">
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
							<td><c:out value="${e.codigo }" /></td>
							<td><c:out value="${e.funcionario.CPF }" /></td>
							<td><c:out value="${e.CEP }" /></td>
							<td><c:out value="${e.logradouro }" /></td>
							<td><c:out value="${e.bairro }" /></td>
							<td><c:out value="${e.UF }" /></td>
							<td><c:out value="${e.localidade }" /></td>
							<td><c:out value="${e.numero }" /></td>
							<td><c:out value="${e.complemento }" /></td>
							<td><c:out value="${e.tipoEndereco }" /></td>
							<td style="text-align: center;">
								<form action="endereco" method="post">
									<input type="hidden" name="codigo" value="${e.codigo}" /> <input
										type="hidden" name="funcionario" value="${e.funcionario.CPF}" />
									<button class="btn btn-danger" type="submit">Excluir</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

		</c:if>
	</div>
	<div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>
