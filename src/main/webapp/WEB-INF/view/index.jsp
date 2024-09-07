<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pagina Inicial</title>
</head>
<body>
	<script
		src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>

	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-1">
				<h1 class="display-6 fw-bold">Bem-Vindo Recruta Billy</h1>
				<form action="index" method="post" class="row g-3 mt-3">
					<!-- Dashboard Section -->
        <div class="container mt-5">
            <h2 class="text-center mb-4">Dashboard de Operações</h2>
            <div class="row g-4">
                <!-- Quantos Orçamentos -->
                <div class="col-md-4">
                    <div class="card text-center shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title">Orçamentos</h5>
                            <p class="card-text display-6">
                                <c:out value="${totalOrcamentos}" />
                            </p>
                        </div>
                    </div>
                </div>
                <!-- Pedidos em Andamento -->
                <div class="col-md-4">
                    <div class="card text-center shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title">Pedidos em Andamento</h5>
                            <p class="card-text display-6">
                                <c:out value="${totalPedidoAndamento}" />
                            </p>
                        </div>
                    </div>
                </div>
                <!-- Pedidos Recebidos -->
                <div class="col-md-4">
                    <div class="card text-center shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title">Pedidos Recebidos</h5>
                            <p class="card-text display-6">
                                <c:out value="${totalPedidosRecebidos}" />
                            </p>
                        </div>
                    </div>
                </div>
                <!-- Pedidos Despachados -->
                <div class="col-md-4">
                    <div class="card text-center shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title">Pedidos Despachados</h5>
                            <p class="card-text display-6">
                                <c:out value="${totalPedidosDespachados}" />
                            </p>
                        </div>
                    </div>
                </div>
                
            
            
         
            </div>
        </div>
        <!-- End of Dashboard Section -->
				</form>


			</div>
		</div>

		<div class="text-center">
			<c:if test="${not empty erro}">
				<h2 class="text-danger">
					<b><c:out value="${erro}" /></b>
				</h2>
			</c:if>
		</div>

		<div class="text-center">
			<c:if test="${not empty saida }">
				<h2 class="text-success">
					<b><c:out value="${saida}" /></b>
				</h2>
			</c:if>
		</div>

		<div class="container py-4 text-center d-flex justify-content-center">
			<c:if test="${not empty pedidos }">
				<table class="table table-striped">
					<thead>
						<tr>
							<th class="titulo-tabela" colspan="10"
								style="text-align: center; font-size: 35px;">Lista de
								Pedidos</th>
						</tr>
						<tr class="table-dark">
							<th></th>
							<th>Código</th>
							<th>Nome Pedido</th>
							<th>Código Cliente</th>
							<th>Nome Cliente</th>
							<th>Data Pedido</th>
							<th>Produtos</th>
							<th>Valor Total</th>
							<th>Estado Atual</th>
							<th>Finalizar</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="p" items="${pedidos }">
							<tr>
								<td style="text-align: center;">
									<button class="btn btn-outline-dark" name="opcao"
										value="${p.codigo}" onclick="editarPedido(this.value)"
										${p.codigo eq codigoEdicao ? 'checked' : ''}>
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
								<td><c:out value="${p.codigo}" /></td>
								<td><c:out value="${p.nome}" /></td>
								<td><c:out value="${p.cliente.codigo}" /></td>
								<td><c:out value="${p.cliente.nome}" /></td>
								<td><fmt:formatDate value="${p.dataPedido}"
										pattern="dd/MM/yyyy" /></td>
								<td>
									<button
										onclick="window.location.href='produtosPedido?pedido=${p.codigo}'"
										class="btn btn-info">Adicionar</button>
								</td>


								<td><fmt:formatNumber value="${p.valorTotal}"
										type="currency" currencySymbol="R$" /></td>

								<td><c:out value="${p.estado}" /></td>
								<td>
									<form action="pedido" method="post"
										onsubmit="return confirmarFinalizacao()">
										<input type="hidden" name="codigo" value="${p.codigo}">
										<input type="hidden" name="cliente"
											value="${p.cliente.codigo}"> <input type="hidden"
											id="botao" name="botao" value="Finalizar Pedido">
										<button type="submit" class="btn btn-outline-dark">Finalizar
											Pedido</button>
									</form>
								<td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
	</div>
	
	 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-2m7dTgB0zr7FOpnlzr43I2k1vF8h5U9pFT0f3qlv1M4kv+4iTbiTY18VJhGtp7tt" crossorigin="anonymous"></script>
    <script>
        // Script to render the chart
        var ctx = document.getElementById('pedidosAndamentoChart').getContext('2d');
        var pedidosAndamentoChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
                datasets: [{
                    label: 'Pedidos em Andamento',
                    data: [12, 19, 3, 5, 2, 3, 7, 10, 15, 8, 6, 9], // Exemplo de dados
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
	<div>
		<jsp:include page="footer.jsp" />
	</div>

</body>
</html>
