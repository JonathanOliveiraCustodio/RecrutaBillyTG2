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
	src="${pageContext.request.contextPath}/resources/js/funcionario.js"></script>
<title>Funcionário</title>

</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<c:if test="${nivelAcesso == 'admin'}">
			<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
				<div class="container-fluid py-1">
					<h3 class="display-6 fw-bold">Manutenção de Funcionário</h3>
					<form action="funcionario" method="post" class="row g-3 mt-3"
						onsubmit="return validarFormulario(event);">
						<!-- Primeira Linha: CPF, Nome, Data de Nascimento -->
						<div class="row g-3">
							<div class="col-md-1 d-flex align-items-center">
								<label for="CPF" class="form-label">CPF:</label>
							</div>
							<div class="col-md-3">
								<input type="number" min="1" step="1" id="CPF" name="CPF"
									class="form-control" placeholder="CPF"
									value='<c:out value="${funcionario.CPF}"></c:out>'>
							</div>
							<div class="col-md-1 d-flex align-items-center">
								<label for="nome" class="form-label">Nome:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="nome" name="nome" class="form-control"
									placeholder="Nome do Usuário" maxlength="100"
									value='<c:out value="${funcionario.nome}"></c:out>'>
							</div>
							<div class="col-md-1 d-flex align-items-center">
								<label for="dataNascimento" class="form-label">Data de
									Nascimento:</label>
							</div>
							<div class="col-md-3">
								<input type="date" id="dataNascimento" name="dataNascimento"
									class="form-control"
									value='<c:out value="${funcionario.dataNascimento}"></c:out>'>
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
									value='<c:out value="${funcionario.email}"></c:out>'>
							</div>
							<div class="col-md-1 d-flex align-items-center">
								<label for="senha" class="form-label">Senha:</label>
							</div>
							<div class="col-md-3">
								<input type="password" id="senha" name="senha"
									class="form-control" placeholder="Senha"
									value='<c:out value="${funcionario.senha}"></c:out>'>
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

						<!-- Terceira Linha: Cargo, Horário, Nível de Acesso -->
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="cargo" class="form-label">Cargo:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="cargo" name="cargo" class="form-control"
									placeholder="Cargo" maxlength="50"
									value='<c:out value="${funcionario.cargo}"></c:out>'>
							</div>
							<div class="col-md-1 d-flex align-items-center">
								<label for="horario" class="form-label">Horário:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="horario" name="horario"
									class="form-control" placeholder="Ex: 12:40 às 16:40"
									maxlength="50"
									value='<c:out value="${funcionario.horario}"></c:out>'>
							</div>
							<div class="col-md-1 d-flex align-items-center">
								<label for="nivelAcesso" class="form-label">Nível de
									Acesso:</label>
							</div>
							<div class="col-md-3">
								<select class="form-select" id="nivelAcesso" name="nivelAcesso">
									<option value="">Escolha um Nível de Acesso</option>
									<option value="admin"
										<c:if test="${funcionario.nivelAcesso eq 'admin'}">selected</c:if>>admin</option>
									<option value="Funcionário"
										<c:if test="${funcionario.nivelAcesso eq 'Funcionário'}">selected</c:if>>Funcionário</option>
								</select>
							</div>
						</div>

						<!-- Quarta Linha: Salário, Data de Admissão, Data de Desligamento -->
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="salario" class="form-label">Salário:</label>
							</div>
							<div class="col-md-3">
								<input type="number" step="0.01" id="salario" name="salario"
									class="form-control" placeholder="Salário"
									value='<c:out value="${funcionario.salario}"></c:out>'>
							</div>
							<div class="col-md-1 d-flex align-items-center">
								<label for="dataAdmissao" class="form-label">Data de
									Admissão:</label>
							</div>
							<div class="col-md-3">
								<input type="date" id="dataAdmissao" name="dataAdmissao"
									class="form-control"
									value='<c:out value="${funcionario.dataAdmissao}"></c:out>'>
							</div>
							<div class="col-md-1 d-flex align-items-center">
								<label for="dataDesligamento" class="form-label">Data de
									Desligamento:</label>
							</div>
							<div class="col-md-3">
								<input type="date" id="dataDesligamento" name="dataDesligamento"
									class="form-control"
									value='<c:out value="${funcionario.dataDesligamento}"></c:out>'>
							</div>
						</div>

						<!-- Quinta Linha: Telefone, Endereço -->
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="telefone" class="form-label">Telefone:</label>
							</div>
							<div class="col-md-3">
								<input type="tel" id="telefone" name="telefone"
									class="form-control" placeholder="Telefone"
									value='<c:out value="${funcionario.telefone}"></c:out>'>
							</div>
							<div class="col-md-1 d-flex align-items-center">
								<label for="endereco" class="form-label">Endereço:</label>
							</div>
							<div class="col-md-3 d-grid text-center">
								<input type="submit" id="botaoEndereco" name="botao"
									value="Visualizar" class="btn btn-outline-success">
							</div>
						</div>

						<!-- Sexta Linha: Observação -->
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="observacao" class="form-label">Observação:</label>
							</div>
							<div class="col-md-11">
								<textarea id="observacao" name="observacao" class="form-control"
									placeholder="Observações" rows="3"><c:out
										value="${funcionario.observacao}"></c:out></textarea>
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
		<c:if test="${not empty funcionarios}">
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th class="titulo-tabela" colspan="6"
							style="text-align: center; font-size: 32px;">Lista de
							Funcionário</th>
					</tr>
					<tr class="table-dark">
						<th></th>
						<th>CPF</th>
						<th>Nome</th>
						<th>Nv. Acesso</th>
						<th>E-mail</th>
						<th>Excluir</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="f" items="${funcionarios}">
						<tr>
							<td style="text-align: center;">
								<button class="btn btn-outline-info" name="opcao"
									value="${f.CPF}" onclick="editarFuncionario(this.value)"
									${f.CPF eq codigoEdicao ? 'checked' : ''}>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									  <path
											d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
									</svg>
								</button>
							</td>
							<td><c:out value="${f.CPF}" /></td>
							<td><c:out value="${f.nome}" /></td>
							<td><c:out value="${f.nivelAcesso}" /></td>
							<td><c:out value="${f.email}" /></td>
							<td style="text-align: center;">
								<button class="btn btn-danger"
									onclick="excluirFuncionario('${f.CPF}')">Excluir</button>
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
