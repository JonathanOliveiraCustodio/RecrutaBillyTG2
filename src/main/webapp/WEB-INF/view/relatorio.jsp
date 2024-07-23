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
<title>Relatórios</title>
<script>
	function atualizarOpcoes() {
		var categoria = document.getElementById("categoria").value;
		var opcaoSelect = document.getElementById("opcao");

		// Limpa as opções existentes
		while (opcaoSelect.options.length > 0) {
			opcaoSelect.remove(0);
		}

		// Adiciona as novas opções dependendo da categoria selecionada
		if (categoria === "cliente") {
			opcaoSelect.add(new Option("Código", "codigo"));
			opcaoSelect.add(new Option("Nome", "nome"));
			opcaoSelect.add(new Option("Telefone", "telefone"));
			opcaoSelect.add(new Option("E-mail", "email"));
		} else if (categoria === "produto") {
			opcaoSelect.add(new Option("Código", "codigo"));
			opcaoSelect.add(new Option("Nome", "nome"));
		} else if (categoria === "equipamento") {
			opcaoSelect.add(new Option("Código", "codigo"));
			opcaoSelect.add(new Option("Nome", "nome"));
		} else if (categoria === "insumo") {
			opcaoSelect.add(new Option("Código", "codigo"));
			opcaoSelect.add(new Option("Nome", "nome"));
		} else if (categoria === "fornecedor") {
			opcaoSelect.add(new Option("Código", "codigo"));
			opcaoSelect.add(new Option("Nome", "nome"));
		} else if (categoria === "pedido") {

			opcaoSelect.add(new Option("Código", "codigo"));
			opcaoSelect.add(new Option("Nome", "nome"));
		} else if (categoria === "usuario") {

			opcaoSelect.add(new Option("CPF", "cpf"));
			opcaoSelect.add(new Option("Nome", "nome"));
		}
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
				<h1 class="display-6 fw-bold">Gerar Relatório</h1>
				<form action="relatorio" method="post" class="row g-3 mt-3">
					<!-- Linha do Formulário -->
					<div class="row g-3">
						<!-- Categoria -->
						<div class="col-md-4 d-flex align-items-center">
							<label for="categoria" class="form-label">Categoria:</label> <select
								class="form-select ms-2" id="categoria" name="categoria"
								onchange="atualizarOpcoes()">
								<option value="">Escolha uma Categoria</option>
								<option value="cliente">Cliente</option>
								<option value="produto">Produto</option>
								<option value="pedido">Pedido</option>
								<option value="fornecedor">Fornecedor</option>
								<option value="insumo">Insumo</option>
								<option value="equipamento">Equipamento</option>
								<option value="usuario">Usuário</option>
							</select>
						</div>

						<!-- Opção -->
						<div class="col-md-4 d-flex align-items-center">
							<label for="opcao" class="form-label">Opção:</label> <select
								class="form-select ms-2" id="opcao" name="opcao">
								<!-- As opções serão preenchidas dinamicamente com base na categoria selecionada -->
							</select>
						</div>

						<!-- Parâmetro de Pesquisa -->
						<div class="col-md-4 d-flex align-items-center">
							<label for="parametro" class="form-label">Parâmetro de
								Pesquisa:</label> <input type="text" id="parametro" name="parametro"
								class="form-control ms-2" placeholder="Digite o parâmetro">
						</div>
					</div>

					<!-- Linha do Botão -->

					<div class="row g-3 mt-3">
						<div class="col-md-5 d-grid text-center"></div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao"
								value="Gerar Relatório" class="btn btn-success">
						</div>

					</div>

				</form>

			</div>
		</div>
	</div>
	<div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>
