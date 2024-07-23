<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<title>Equipamento</title>
<script>
	function consultarEquipamento(codigo) {
		window.location.href = 'consulta?codigo=' + codigo;
	}

	function editarEquipamento(codigo) {
		window.location.href = 'equipamento?cmd=alterar&codigo=' + codigo;
	}

	function excluirEquipamento(codigo) {
		if (confirm("Tem certeza que deseja excluir este equipamento?")) {
			window.location.href = 'equipamento?cmd=excluir&codigo=' + codigo;
		}
	}

	function validarBusca() {
		var codigo = document.getElementById("codigo").value;
		if (codigo.trim() === "") {
			alert("Por favor, insira um código.");
			return false;
		}
		return true;
	}

	function validarFormulario(event) {
		var botao = event.submitter.value;
		if (botao === "Cadastrar" || botao === "Alterar") {
			var campos = [ "nome", "valor", "descricao", "fabricante",
					"dataManutencao" ];
			for (var i = 0; i < campos.length; i++) {
				var campo = document.getElementById(campos[i]).value.trim();
				if (campo === "") {
					alert("Por favor, preencha todos os campos.");
					event.preventDefault();
					return false;
				}
			}
		} else if (botao === "Excluir") {
			var codigo = document.getElementById("codigo").value.trim();
			if (codigo === "" || isNaN(codigo) || parseInt(codigo) <= 0) {
				alert("Por favor, preencha o campo de código.");
				event.preventDefault();
				return false;
			}
		}
		// Se todos os campos estiverem preenchidos, permitir o envio do formulário
		return true;
	}
</script>

</head>
<body>
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
							<div class="col-md-1 d-flex align-items-center">
								<label for="codigo" class="form-label">Código:</label>
							</div>
							<div class="col-md-2">
								<input type="number" min="0" step="1" id="codigo" name="codigo"
									class="form-control" placeholder="Código"
									value='<c:out value="${equipamento.codigo}"></c:out>'>
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
									placeholder="Nome do insumo" maxlength="100"
									value='<c:out value="${equipamento.nome}"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="fabricante" class="form-label">Fabricante:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="fabricante" name="fabricante"
									class="form-control" placeholder="Fabricante" maxlength="100"
									value='<c:out value="${equipamento.fabricante}"></c:out>'>
							</div>
						</div>

						<!-- Segunda Linha: Descrição -->
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="descricao" class="form-label">Descrição:</label>
							</div>
							<div class="col-md-11">
								<textarea class="form-control" id="descricao" name="descricao"
									placeholder="Descrição">${equipamento.descricao}</textarea>
							</div>
						</div>

						<!-- Terceira Linha: Data de Manutenção -->
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="dataManutencao" class="form-label">Manutenção:</label>
							</div>
							<div class="col-md-3">
								<input type="date" id="dataManutencao" name="dataManutencao"
									class="form-control"
									value='<c:out value="${equipamento.dataManutencao}"></c:out>'>
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
		<c:if test="${not empty equipamentos }">
			<table class="table table-striped">
				<thead>
					<tr>
						<th class="titulo-tabela" colspan="7"
							style="text-align: center; font-size: 23px;">Lista de
							Equipamentos</th>
					</tr>
					<tr class="table-dark">
						<th> </th>
						<th>Código</th>
						<th>Nome</th>
						<th>Descrição</th>
						<th>Fabricante</th>
						<th>Manutenção</th>
						<th>Excluir</th>

					</tr>
				</thead>
				<tbody class="table-group-divider">
					<c:forEach var="e" items="${equipamentos}">
						<tr>
							<td style="text-align: center;">
								<button class="btn btn-info" name="opcao" value="${e.codigo}"
									onclick="editarEquipamento(this.value)"
									${e.codigo eq codigoEdicao ? 'checked' : ''}>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
									</svg>
								</button>
							</td>
							<td><c:out value="${e.codigo}" /></td>
							<td><c:out value="${e.nome}" /></td>
							<td><c:out value="${e.descricao}" /></td>
							<td><c:out value="${e.fabricante}" /></td>

							<td><fmt:formatDate value="${e.dataManutencao}"
									pattern="dd/MM/yyyy" /></td>

							<td style="text-align: center;">
								<button class="btn btn-danger"
									onclick="excluirEquipamento('${e.codigo}')">Excluir</button>
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
