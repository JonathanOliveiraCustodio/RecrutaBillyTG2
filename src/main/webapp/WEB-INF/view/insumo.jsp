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
<title>Insumo</title>
<script>
	function consultarInsumo(codigo) {
		window.location.href = 'consulta?codigo=' + codigo;
	}

	function editarInsumo(codigo) {
		window.location.href = 'insumo?cmd=alterar&codigo=' + codigo;
	}

	function excluirInsumo(codigo) {
		if (confirm("Tem certeza que deseja excluir este insumo?")) {
			window.location.href = 'insumo?cmd=excluir&codigo=' + codigo;
		}
	}

	function validarBusca() {
		var codigo = document.getElementById("codigo").value;
		if (codigo.trim() === "") {
			alert("Por favor, insira um Código.");
			return false;
		}
		return true;
	}
	function validarFormulario(event) {
		var botao = event.submitter.value;
		if (botao === "Cadastrar" || botao === "Alterar") {
			var campos = [ "nome", "valor", "quantidade", "fornecedor" ];
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
					<h1 class="display-6 fw-bold">Manutenção de Insumo</h1>
					<form action="insumo" method="post" class="row g-3 mt-3"
						onsubmit="return validarFormulario(event);">
						<!-- Primeira Linha: Código, Nome, Valor -->
						<div class="row g-3">
							<div class="col-md-1 d-flex align-items-center">
								<label for="codigo" class="form-label">Código:</label>
							</div>
							<div class="col-md-2">
								<input class="form-control" type="number" min="0" step="1"
									id="codigo" name="codigo" placeholder="Código"
									value='<c:out value="${insumo.codigo}"></c:out>'>
							</div>
							<div class="col-md-1">
								<input type="submit" id="botaoBuscar" name="botao"
									class="btn btn-primary mb-3" value="Buscar"
									onclick="return validarBusca()">
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="nome" class="form-label">Nome:</label>
							</div>
							<div class="col-md-3">
								<input class="form-control" type="text" id="nome" name="nome"
									placeholder="Nome"
									value='<c:out value="${insumo.nome}"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="valor" class="form-label">Valor:</label>
							</div>
							<div class="col-md-3">
								<input type="text" id="valor" name="valor" class="form-control"
									placeholder="Valor do insumo"
									value='<c:out value="${insumo.valor}"></c:out>'>
							</div>
						</div>

						<!-- Segunda Linha: Quantidade, Unidade, Fornecedor -->
						<div class="row g-3 mt-2">
							<div class="col-md-1 d-flex align-items-center">
								<label for="quantidade" class="form-label">Quantidade:</label>
							</div>
							<div class="col-md-3">
								<input type="number" id="quantidade" name="quantidade"
									class="form-control" placeholder="Quantidade"
									value='<c:out value="${insumo.quantidade}"></c:out>'>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="unidade" class="form-label">Unidade:</label>
							</div>
							<div class="col-md-3">
								<select id="unidade" name="unidade" class="form-select">
									<option value="">Escolha uma Unidade</option>
									<option value="ml"
										<c:if test="${insumo.unidade eq 'ml'}">selected</c:if>>ml</option>
									<option value="kg"
										<c:if test="${insumo.unidade eq 'kg'}">selected</c:if>>kg</option>
									<option value="unidade"
										<c:if test="${insumo.unidade eq 'unidade'}">selected</c:if>>unidade</option>
									<option value="m²"
										<c:if test="${insumo.unidade eq 'm²'}">selected</c:if>>m²</option>
								</select>
							</div>

							<div class="col-md-1 d-flex align-items-center">
								<label for="fornecedor" class="form-label">Fornecedor:</label>
							</div>
							<div class="col-md-3">
								<select id="fornecedor" name="fornecedor" class="form-select">
									<option value="0">Escolha um Fornecedor</option>
									<c:forEach var="f" items="${fornecedores}">
										<option value="${f.codigo}"
											<c:if test="${f.codigo eq insumo.fornecedor.codigo}">selected</c:if>>
											<c:out value="${f}" />
										</option>
									</c:forEach>
								</select>
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
		<c:if test="${not empty insumos }">
			<table class="table table-striped">
				<thead>
					<tr>
						<th class="titulo-tabela" colspan="8"
							style="text-align: center; font-size: 23px;">Lista de
							Insumos</th>
					</tr>
					<tr class="table-dark">
						<th> </th>
						<th>Código</th>
						<th>Nome</th>
						<th>Valor</th>
						<th>Quantidade</th>
						<th>Unidade</th>
						<th>Fornecedor</th>
						<th>Excluir</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<c:forEach var="i" items="${insumos}">
						<tr>
							<td style="text-align: center;">
								<button class="btn btn-outline-info" name="opcao" value="${i.codigo}"
									onclick="editarInsumo(this.value)"
									${i.codigo eq codigoEdicao ? 'checked' : ''}>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
									</svg>
								</button>
							</td>
							<td><c:out value="${i.codigo}" /></td>
							<td><c:out value="${i.nome}" /></td>
							<td><c:out value="${i.valor}" /></td>
							<td><c:out value="${i.quantidade}" /></td>
							<td><c:out value="${i.unidade}" /></td>
							<td><c:out value="${i.fornecedor.nome}" /></td>
							<td style="text-align: center;">
								<button class="btn btn-danger"
									onclick="excluirInsumo('${i.codigo}')">Excluir</button>
							</td>
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
