<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/relatorio.js"></script>
<title>Relatórios</title>

</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-1">
				<h1 class="display-6 fw-bold">Gerar Relatório</h1>
				<form action="relatorioCategoria" method="post" class="row g-3 mt-3" target="_blank">			
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
