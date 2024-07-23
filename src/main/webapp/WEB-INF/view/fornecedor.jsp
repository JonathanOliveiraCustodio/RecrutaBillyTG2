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
<title>Fornecedor</title>
<script>
	function consultarFornecedor(codigo) {
		window.location.href = 'consulta?codigo=' + codigo;
	}

	function editarFornecedor(codigo) {
		window.location.href = 'fornecedor?cmd=alterar&codigo=' + codigo;
	}

	function excluirFornecedor(codigo) {
		if (confirm("Tem certeza que deseja excluir este funcionario?")) {
			window.location.href = 'fornecedor?cmd=excluir&codigo=' + codigo;
		}
	}
	function validarBusca() {
		var codigo = document.getElementById("codigo").value;
		if (codigo.trim() === "") {
			alert("Por favor, insira um codigo.");
			return false;
		}
		return true;
	}
	
	function validarFormulario(event) {
	    var botao = event.submitter.value;
	    if (botao === "Cadastrar" || botao === "Alterar") {
	        var campos = ["nome", "endereco", "telefone", "email","empresa"];
	        for (var i = 0; i < campos.length; i++) {
	            var campo = document.getElementById(campos[i]).value.trim();
	            if (campo === "") {
	                alert("Por favor, preencha todos os campos.");
	                event.preventDefault();
	                return false;
	            }
	        }
	    } else if (botao === "Excluir" ) {
	        var codigo = document.getElementById("codigo").value.trim();
	        if (codigo === "" || isNaN(codigo) || parseInt(codigo) <= 0) {
	            alert("Por favor, preencha o campo de c�digo.");
	            event.preventDefault();
	            return false;
	        }
	    }
	    // Se todos os campos estiverem preenchidos, permitir o envio do formul�rio
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
                <h1 class="display-6 fw-bold">Manuten��o de Fornecedor</h1>
                <form action="fornecedor" method="post" class="row g-3 mt-3" onsubmit="return validarFormulario(event);">
                    <label for="codigo" class="form-label col-md-1">C�digo:</label>
                    <div class="col-md-2">
                        <input type="number" min="0" step="1" id="codigo" name="codigo" class="form-control" placeholder="C�digo" value='<c:out value="${fornecedor.codigo }"></c:out>'>
                    </div>
                    <div class="col-md-1">
                        <input type="submit" id="botao" name="botao" value="Buscar" class="btn btn-primary mb-3" onclick="return validarBusca()">
                    </div>

                    <label for="nome" class="form-label col-md-1">Nome:</label>
                    <div class="col-md-3">
                        <input type="text" id="nome" name="nome" class="form-control" placeholder="Nome" value='<c:out value="${fornecedor.nome }"></c:out>'>
                    </div>

                    <label for="endereco" class="form-label col-md-1">Endere�o:</label>
                    <div class="col-md-3">
                        <input type="text" id="endereco" name="endereco" class="form-control" placeholder="Endere�o" value='<c:out value="${fornecedor.endereco }"></c:out>'>
                    </div>

                    <label for="telefone" class="form-label col-md-1">Telefone:</label>
                    <div class="col-md-3">
                        <input type="text" id="telefone" name="telefone" class="form-control" placeholder="Telefone" value='<c:out value="${fornecedor.telefone }"></c:out>'>
                    </div>

                    <label for="email" class="form-label col-md-1">Email:</label>
                    <div class="col-md-3">
                        <input type="text" id="email" name="email" class="form-control" placeholder="E-mail" value='<c:out value="${fornecedor.email }"></c:out>'>
                    </div>

                    <label for="empresa" class="form-label col-md-1">Empresa:</label>
                    <div class="col-md-3">
                        <input type="text" id="empresa" name="empresa" class="form-control" placeholder="Empresa" value='<c:out value="${fornecedor.empresa }"></c:out>'>
                    </div>
                    
                    <div class="col-md-0"></div>

                    <div class="col-md-2 d-grid text-center">
                        <input type="submit" id="botao" name="botao" value="Cadastrar" class="btn btn-success">
                    </div>
                    <div class="col-md-2 d-grid text-center">
                        <input type="submit" id="botao" name="botao" value="Alterar" class="btn btn-warning">
                    </div>
                    <div class="col-md-2 d-grid text-center">
                        <input type="submit" id="botao" name="botao" value="Excluir" class="btn btn-danger">
                    </div>
                    <div class="col-md-2 d-grid text-center"></div>
                    <div class="col-md-2 d-grid text-center">
                        <input type="submit" id="botao" name="botao" value="Listar" class="btn btn-dark">
                    </div>
                    <div class="col-md-2 d-grid text-center">
                        <input type="submit" id="botao" name="botao" value="Limpar" class="btn btn-secondary">
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
						<th class="titulo-tabela" colspan="8"
							style="text-align: center; font-size: 23px;">Lista de
							Fornecedores</th>
					</tr>
					<tr class="table-dark">
						<th> </th>
						<th>C�digo</th>
						<th>Nome</th>
						<th>Endere�o</th>
						<th>Telefone</th>
						<th>E-mail</th>
						<th>Empresa</th>
						<th>Excluir</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<c:forEach var="f" items="${fornecedores}">
						<tr>
							<td style="text-align: center;">
								<button class="btn btn-info" name="opcao" value="${f.codigo}"
									onclick="editarFornecedor(this.value)"
									${f.codigo eq codigoEdicao ? 'checked' : ''}>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
									</svg>
								</button>
							</td>
							<td><c:out value="${f.codigo}" /></td>
							<td><c:out value="${f.nome}" /></td>
							<td><c:out value="${f.endereco}" /></td>
							<td><c:out value="${f.telefone}" /></td>
							<td><c:out value="${f.email}" /></td>
							<td><c:out value="${f.empresa}" /></td>
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