<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/usuario.js"></script>
<title>Usuário</title>

</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<c:if test="${nivelAcesso == 'admin'}">
			<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
				<div class="container-fluid py-1">
					<h3 class="display-6 fw-bold">Manutenção de Usuário</h3>
					<form action="usuario" method="post" class="row g-3 mt-3"
						onsubmit="return validarFormulario(event);">
						<!-- Primeira Linha: CPF, Nome, Nível de Acesso -->
						<div class="row g-3">
							<div class="col-md-1 d-flex align-items-center">
								<label for="CPF" class="form-label">CPF:</label>
							</div>
							<div class="col-md-2">
								<input type="number" min="1" step="1" id="CPF" name="CPF"
									class="form-control" placeholder="CPF"
									value='<c:out value="${usuario.CPF}"></c:out>'>
							</div>
							<div class="col-md-1">
								<input type="submit" id="botaoBuscar" name="botao"
									value="Buscar" class="btn btn-primary mb-3"
									onclick="return validarBusca()">
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="nome" class="form-label">Nome:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="nome" name="nome" class="form-control"
									placeholder="Nome do Usuário" maxlength="100"
									value='<c:out value="${usuario.nome}"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="nivelAcesso" class="form-label">Nível de
									Acesso:</label>
							</div>
							<div class="col-md-3">
								<select class="form-select" id="nivelAcesso" name="nivelAcesso">
									<option value="">Escolha um Nível de Acesso</option>
									<option value="admin"
										<c:if test="${usuario.nivelAcesso eq 'admin'}">selected</c:if>>admin</option>
									<option value="Funcionário"
										<c:if test="${usuario.nivelAcesso eq 'Funcionário'}">selected</c:if>>Funcionário</option>
								</select>
							</div>
						</div>

						<!-- Segunda Linha: Email, Senha, Confirmar Senha -->
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="email" class="form-label">Email:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="email" name="email" class="form-control"
									placeholder="Email" maxlength="100"
									value='<c:out value="${usuario.email}"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="senha" class="form-label">Senha:</label>
							</div>
							<div class="col-md-3">
								<input type="password" id="senha" name="senha"
									class="form-control" placeholder="Senha"
									value='<c:out value="${usuario.senha}"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="confirmarSenha" class="form-label">Confirmar
									Senha:</label>
							</div>
							<div class="col-md-3">
								<input type="password" id="confirmarSenha" name="confirmarSenha"
									class="form-control" placeholder="Confirmar Senha">
							</div>
						</div>

						<!-- Linha dos Botões -->
						<div class="row g-3 mt-3">
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botaoCadastrar" name="botao"
									value="Cadastrar" class="btn btn-success"
									onclick="return validarSenhas()">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botaoAlterar" name="botao"
									value="Alterar" class="btn btn-warning">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botaoExcluir" name="botao"
									value="Excluir" class="btn btn-danger">
							</div>
							<div class="col-md-2 d-grid text-center"></div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botaoListar" name="botao"
									value="Listar" class="btn btn-dark">
							</div>
							<div class="col-md-2 d-grid text-center">
								<input type="submit" id="botaoLimpar" name="botao"
									value="Limpar" class="btn btn-secondary">
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
		<c:if test="${not empty usuarios}">
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th class="titulo-tabela" colspan="6"
							style="text-align: center; font-size: 32px;">Lista de
							Usuários</th>
					</tr>
					<tr class="table-dark">
						<th> </th>
						<th>CPF</th>
						<th>Nome</th>
						<th>Nv. Acesso</th>
						<th>E-mail</th>
						<th>Excluir</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="u" items="${usuarios}">
						<tr>
							<td style="text-align: center;">
								<button class="btn btn-outline-info" name="opcao" value="${u.CPF}"
									onclick="editarUsuario(this.value)"
									${u.CPF eq codigoEdicao ? 'checked' : ''}>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
									</svg>
								</button>
							</td>
							<td><c:out value="${u.CPF}" /></td>
							<td><c:out value="${u.nome}" /></td>
							<td><c:out value="${u.nivelAcesso}" /></td>
							<td><c:out value="${u.email}" /></td>
							<td style="text-align: center;">
								<button class="btn btn-danger"
									onclick="excluirUsuario('${u.CPF}')">Excluir</button>
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
