<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<title>Adicionar Insumos</title>
<script>
	function updateUnidade() {
		var insumoSelect = document.getElementById('insumo');
		var selectedOption = insumoSelect.options[insumoSelect.selectedIndex];
		var unidade = selectedOption.getAttribute('data-unidade');
		document.getElementById('unidade').value = unidade;
	}

	function validarFormulario(event) {
		var botao = event.submitter.value;
		if (botao === "Cadastrar") {
			var campos = [ "insumo" ];
			for (var i = 0; i < campos.length; i++) {
				var campo = document.getElementById(campos[i]).value.trim();
				if (campo === "") {
					alert("Por favor, preencha todos os campos.");
					event.preventDefault();
					return false;
				}
			}
		} else if (botao === "Excluir") {
			var insumo = document.getElementById("insumo").value.trim();
			if (insumo === "" || isNaN(insumo) || parseInt(insumo) <= 0) {
				alert("Por favor, preencha o campo de código.");
				event.preventDefault();
				return false;
			}
		}
		return true;
	}
</script>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-1">
				<h1 class="display-6 fw-bold">Gerenciar Insumos</h1>
				<form action="insumosProduto" method="post"
					onsubmit="return validarFormulario(event);" class="row g-3 mt-3">
					<input type="hidden" id="produto" name="produto"
						value='<c:out value="${produto.codigo}"></c:out>'>

					<!-- Linha do Formulário -->
					<div class="row g-3">
						<!-- Insumo -->
						<div class="col-md-4 d-flex align-items-center">
							<label for="insumo" class="form-label">Insumo:</label> <select
								class="form-select ms-2" id="insumo" name="insumo"
								onchange="updateUnidade()">
								<option value="0" data-unidade="">Escolha um Insumo</option>
								<c:forEach var="i" items="${insumos}">
									<c:if
										test="${empty produtoInsumo or i.codigo ne produtoInsumo.insumo.codigo}">
										<option value="${i.codigo}" data-unidade="${i.unidade}">
											<c:out value="${i}" />
										</option>
									</c:if>
									<c:if test="${i.codigo eq produtoInsumo.insumo.codigo}">
										<option value="${i.codigo}" data-unidade="${i.unidade}"
											selected="selected">
											<c:out value="${i}" />
										</option>
									</c:if>
								</c:forEach>
							</select>
						</div>

						

						<!-- Quantidade -->
						<div class="col-md-4 d-flex align-items-center">
							<label for="quantidade" class="form-label">Quantidade:</label> <input
								class="form-control ms-2" type="number" min="0" step="1"
								id="quantidade" name="quantidade" placeholder="Quantidade"
								value='<c:out value="${produtoInsumo.quantidade}"></c:out>'>
						</div>
						
						<!-- Unidade -->
						<div class="col-md-4 d-flex align-items-center">
							<label for="unidade" class="form-label">Unidade:</label> <input
								class="form-control ms-2" type="text" id="unidade"
								name="unidade" placeholder="Unidade"
								value='<c:out value="${produtoInsumo.insumo.unidade}"></c:out>'
								readonly>
						</div>
					</div>

					<!-- Linha dos Botões -->
					<div class="row g-3 mt-3">
						<div class="col-md-4 d-grid text-center"></div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Cadastrar"
								class="btn btn-success">
						</div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Excluir"
								class="btn btn-danger">
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
			<c:if test="${not empty insumosProduto}">
				<table class="table table-striped">
					<thead>
						<tr>
							<th class="titulo-tabela" colspan="5"
								style="text-align: center; font-size: 23px;">Lista de
								Insumos do Produto</th>
						</tr>
						<tr class="table-dark">
							<th>Código Insumo</th>
							<th>Nome Insumo</th>
							<th>Unidade</th>
							<th>Quantidade</th>
							<th>Ação</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="ai" items="${insumosProduto}">
							<tr>
								<td><c:out value="${ai.insumo.codigo}" /></td>
								<td><c:out value="${ai.insumo.nome}" /></td>
								<td><c:out value="${ai.insumo.unidade}" /></td>
								<td><c:out value="${ai.quantidade}" /></td>
								<td>
									<form action="insumosProduto" method="post">
										<input type="hidden" name="produto"
											value="${ai.codigoProduto}"> <input type="hidden"
											name="insumo" value="${ai.insumo.codigo}"> <input
											type="hidden" name="nome" value="${ai.insumo.nome}">
										<input type="hidden" name="quantidade"
											value="${ai.quantidade}"> <input type="hidden"
											name="botao" value="Excluir">
										<button type="submit" class="btn btn-danger">Excluir</button>
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
