<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fornecedor</title>
</head>
<body>
	<script
		src="${pageContext.request.contextPath}/resources/js/fornecedor.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<c:if test="${nivelAcesso == 'admin'}">
			<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
				<div class="container-fluid py-1">
					<h1 class="display-6 fw-bold">Manutenção de Fornecedor</h1>
					<form action="fornecedor" method="post" class="row g-3 mt-3"
						onsubmit="return validarFormulario(event);">
						<!-- Primeira Linha: Código, Nome, Telefone -->
						<div class="row g-3">
							<div class="col-md-4">
								<div class="form-floating">
									<input type="number" min="0" step="1" id="codigo" name="codigo"
										class="form-control" placeholder="Código"
										value='<c:out value="${fornecedor.codigo}"></c:out>' readonly>
									<label for="codigo">Código</label>
								</div>
							</div>

							<div class="col-md-3">
								<div class="form-floating">
									<input type="text" id="nome" name="nome" class="form-control"
										placeholder="Nome"
										value='<c:out value="${fornecedor.nome}"></c:out>'> <label
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
									<input type="text" id="telefone" name="telefone"
										class="form-control" placeholder="Telefone"
										value='<c:out value="${fornecedor.telefone}"></c:out>'>
									<label for="telefone">Telefone</label>
								</div>
							</div>
						</div>

						<!-- Segunda Linha: Email, Empresa, CEP -->
						<div class="row g-3 mt-2">
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="email" name="email" class="form-control"
										placeholder="E-mail"
										value='<c:out value="${fornecedor.email}"></c:out>'> <label
										for="email">Email</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="empresa" name="empresa"
										class="form-control" placeholder="Empresa"
										value='<c:out value="${fornecedor.empresa}"></c:out>'>
									<label for="empresa">Empresa</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="CEP" name="CEP" class="form-control"
										placeholder="CEP" maxlength="9"
										value='<c:out value="${fornecedor.CEP }"></c:out>'
										onblur="buscarEndereco()"> <label for="cep">CEP</label>
								</div>
							</div>
						</div>

						<!-- Terceira Linha: Logradouro, Número, Bairro -->
						<div class="row g-3 mt-2">
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="logradouro" name="logradouro"
										class="form-control" placeholder="Logradouro"
										value='<c:out value="${fornecedor.logradouro}"></c:out>'readonly>
									<label for="logradouro">Logradouro</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="bairro" name="bairro"
										class="form-control" placeholder="Bairro"
										value='<c:out value="${fornecedor.bairro}"></c:out>'readonly>
									<label for="bairro">Bairro</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="cidade" name="cidade"
										class="form-control" placeholder="Localidade"
										value='<c:out value="${fornecedor.cidade}"></c:out>'readonly>
									<label for="cidade">Cidade</label>
								</div>

							</div>
						</div>

						<!-- Quarta Linha: Complemento, Cidade, UF -->
						<div class="row g-3 mt-2">
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="UF" name="UF" class="form-control"
										placeholder="UF"
										value='<c:out value="${fornecedor.UF}"></c:out>'readonly> <label
										for="UF">UF</label>
								</div>

							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="complemento" name="complemento"
										class="form-control" placeholder="Complemento"
										value='<c:out value="${fornecedor.complemento}"></c:out>'>
									<label for="complemento">Complemento</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="numero" name="numero"
										class="form-control" placeholder="Número"
										value='<c:out value="${fornecedor.numero}"></c:out>'>
									<label for="numero">Número</label>
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
		</c:if>
	</div>

	<br />

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
		<c:if test="${not empty fornecedores }">
			<table class="table table-striped">
				<thead>
					<tr>
						<th class="titulo-tabela" colspan="14"
							style="text-align: center; font-size: 35px;">Lista de
							Fornecedores</th>
					</tr>
					<tr class="table-dark">
						<th></th>
						<th>Código</th>
						<th>Nome</th>
						<th>Telefone</th>
						<th>E-mail</th>
						<th>Empresa</th>
						<th>CEP</th>
						<th>Logradouro</th>
						<th>Número</th>
						<th>Empresa</th>
						<th>Cidade</th>
						<th>UF</th>
						<th>Excluir</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<c:forEach var="f" items="${fornecedores}">
						<tr>
							<td style="text-align: center;">
								<button class="btn btn-outline-dark" name="opcao"
									value="${f.codigo}" onclick="editarFornecedor(this.value)"
									${f.codigo eq codigoEdicao ? 'checked' : ''}>
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
							<td><c:out value="${f.codigo}" /></td>
							<td><c:out value="${f.nome}" /></td>
							<td><c:out value="${f.telefone}" /></td>
							<td><c:out value="${f.email}" /></td>
							<td><c:out value="${f.empresa}" /></td>
							<td><c:out value="${f.CEP}" /></td>
							<td><c:out value="${f.logradouro}" /></td>
							<td><c:out value="${f.numero}" /></td>
							<td><c:out value="${f.bairro}" /></td>
							<td><c:out value="${f.cidade}" /></td>
							<td><c:out value="${f.UF}" /></td>
							<td style="text-align: center;">
								<button class="btn btn-danger"
									onclick="excluirFornecedor('${f.codigo}')">Excluir</button>
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