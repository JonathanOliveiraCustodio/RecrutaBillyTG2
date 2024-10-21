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
<title>Funcionário</title>
</head>
<body>
	<script
		src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/funcionario.js"></script>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<c:if test="${nivelAcesso == 'admin'}">
			<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
				<div class="container-fluid py-1">
					<h3 class="display-6 fw-bold">Manutenção de Funcionário</h3>
					<form action="funcionario" method="post"
						class="row g-3 mt-3 justify-content-center"
						onsubmit="return validarFormulario(event);">
						<!-- Primeira Linha: CPF, Nome, Data de Nascimento -->
						<div class="row g-3 justify-content-center">
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="CPF" name="CPF" class="form-control"
										placeholder="CPF"
										value='<c:out value="${funcionario.CPF}"></c:out>'> <label
										for="CPF">CPF</label>
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-floating">
									<input type="text" id="nome" name="nome" class="form-control"
										placeholder="Nome do Usuário" maxlength="100"
										value='<c:out value="${funcionario.nome}"></c:out>'> <label
										for="nome">Nome</label>
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
									<input type="date" id="dataNascimento" name="dataNascimento"
										class="form-control"
										value='<c:out value="${funcionario.dataNascimento}"></c:out>'>
									<label for="dataNascimento">Data de Nascimento</label>
								</div>
							</div>
						</div>

						<!-- Segunda Linha: Email, Senha, Confirmar Senha -->
						<div class="row g-3 mt-2 justify-content-center">
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="email" name="email" class="form-control"
										placeholder="Email" maxlength="100"
										value='<c:out value="${funcionario.email}"></c:out>'>
									<label for="email">Email</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input type="password" id="senha" name="senha"
										class="form-control" placeholder="Senha" maxlength="30"
										value='<c:out value="${funcionario.senha}"></c:out>'>
									<label for="senha">Senha</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input type="password" id="confirmarSenha"
										name="confirmarSenha" class="form-control"
										placeholder="Confirmar Senha" maxlength="30"> <label
										for="confirmarSenha">Confirmar Senha</label>
								</div>
							</div>
						</div>

						<!-- Terceira Linha: Cargo, Horário, Nível de Acesso -->
						<div class="row g-3 mt-2 justify-content-center">
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="cargo" name="cargo" class="form-control"
										placeholder="Cargo" maxlength="30"
										value='<c:out value="${funcionario.cargo}"></c:out>'>
									<label for="cargo">Cargo</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="horario" name="horario"
										class="form-control" placeholder="Ex: 12:40 às 16:40"
										maxlength="15"
										value='<c:out value="${funcionario.horario}"></c:out>'>
									<label for="horario">Horário</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<select class="form-select" id="nivelAcesso" name="nivelAcesso">
										<option value="">Escolha um Nível de Acesso</option>
										<option value="admin"
											<c:if test="${funcionario.nivelAcesso eq 'admin'}">selected</c:if>>admin</option>
										<option value="Funcionário"
											<c:if test="${funcionario.nivelAcesso eq 'Funcionário'}">selected</c:if>>Funcionário</option>
									</select> <label for="nivelAcesso">Nível de Acesso</label>
								</div>
							</div>
						</div>

						<!-- Quarta Linha: Salário, Data de Admissão, Data de Desligamento -->
						<div class="row g-3 mt-2 justify-content-center">
							<div class="col-md-4">
								<div class="form-floating">
									<input class="form-control" type="text" id="salario"
										name="salario" placeholder="Salário"
										value='<fmt:formatNumber value="${funcionario.salario}" type="currency" currencySymbol="R$" />'>
									<label for="salario">Salário:</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input type="date" id="dataAdmissao" name="dataAdmissao"
										class="form-control"
										value='<c:out value="${funcionario.dataAdmissao}"></c:out>'>
									<label for="dataAdmissao">Data de Admissão</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-floating">
									<input type="date" id="dataDesligamento"
										name="dataDesligamento" class="form-control"
										value='<c:out value="${funcionario.dataDesligamento}"></c:out>'>
									<label for="dataDesligamento">Data de Desligamento</label>
								</div>
							</div>
						</div>

						<!-- Quinta Linha: Telefone e Botões -->
						<div class="row g-3 mt-2 justify-content-center">
							<div class="col-md-4">
								<div class="form-floating">
									<input type="text" id="telefone" name="telefone"
										class="form-control" placeholder="Telefone" maxlength="15"
										value='<c:out value="${funcionario.telefone }"></c:out>'
										oninput="validarTelefone(this)"> <label for="telefone">Telefone</label>
								</div>
							</div>
							<div class="col-md-4 d-flex align-items-center">
								<button type="button"
									class="btn btn-outline-success btn-align d-flex align-items-center w-100"
									onclick="redirectToWhatsApp()">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										fill="currentColor" class="bi bi-whatsapp" viewBox="0 0 16 16"
										style="margin-right: 5px;">
                <path
											d="M13.601 2.326A7.85 7.85 0 0 0 7.994 0C3.627 0 .068 3.558.064 7.926c0 1.399.366 2.76 1.057 3.965L0 16l4.204-1.102a7.9 7.9 0 0 0 3.79.965h.004c4.368 0 7.926-3.558 7.93-7.93A7.9 7.9 0 0 0 13.6 2.326zM7.994 14.521a6.6 6.6 0 0 1-3.356-.92l-.24-.144-2.494.654.666-2.433-.156-.251a6.56 6.56 0 0 1-1.007-3.505c0-3.626 2.957-6.584 6.591-6.584a6.56 6.56 0 0 1 4.66 1.931 6.56 6.56 0 0 1 1.928 4.66c-.004 3.639-2.961 6.592-6.592 6.592m3.615-4.934c-.197-.099-1.17-.578-1.353-.646-.182-.065-.315-.099-.445.099-.133.197-.513.646-.627.775-.114.133-.232.148-.43.05-.197-.1-.836-.308-1.592-.985-.59-.525-.985-1.175-1.103-1.372-.114-.198-.011-.304.088-.403.087-.088.197-.232.296-.346.1-.114.133-.198.198-.33.065-.134.034-.248-.015-.347-.05-.099-.445-1.076-.612-1.47-.16-.389-.323-.335-.445-.34-.114-.007-.247-.007-.38-.007a.73.73 0 0 0-.529.247c-.182.198-.691.677-.691 1.654s.71 1.916.81 2.049c.098.133 1.394 2.132 3.383 2.992.47.205.84.326 1.129.418.475.152.904.129 1.246.08.38-.058 1.171-.48 1.338-.943.164-.464.164-.86.114-.943-.049-.084-.182-.133-.38-.232" />
            </svg>
									Contato WhatsApp
								</button>
							</div>
							<!-- Botão Endereço -->
							<div class="col-md-4 d-flex align-items-center">
								<button type="button" id="botaoEndereco"
									class="btn btn-outline-secondary btn-align w-100 d-flex justify-content-center align-items-center"
									onclick="validarERedirecionar()">Endereço</button>
							</div>
						</div>
						<!-- Sexta Linha: Observação -->
						<div class="row g-3 mt-2 justify-content-center">
							<div class="col-md-12">
								<div class="form-floating">
									<textarea id="observacao" name="observacao"
										class="form-control" placeholder="Observações" rows="3"><c:out
											value="${funcionario.observacao}"></c:out></textarea>
									<label for="observacao">Observação</label>
								</div>
							</div>
						</div>

						<!-- Linha dos Botões -->
						<div class="row g-3 mt-3 justify-content-center">
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
		<c:if test="${nivelAcesso == 'admin' && not empty funcionarios}">
			<div class="table-responsive w-100">
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th class="titulo-tabela" colspan="6"
								style="text-align: center; font-size: 35px;">Lista de
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
									<button class="btn btn-outline-dark" name="opcao"
										value="${f.CPF}" onclick="editarFuncionario(this.value)"
										${f.CPF eq codigoEdicao ? 'checked' : ''}>
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
								<td class="CPF-campo"><c:out value="${f.CPF}" /></td>
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
			</div>
		</c:if>
	</div>
	<div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>
