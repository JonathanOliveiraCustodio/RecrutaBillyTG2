<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/styles.css">
<title>Logs de Acesso</title>
</head>
<body>
	<script src="${pageContext.request.contextPath}/resources/js/log.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
	<div>
		<jsp:include page="menu.jsp" />
	</div>

	<div class="container py-4">
		<h3 class="display-6 fw-bold text-center">Lista de Logs de Acesso</h3>
		<br>

		<c:if test="${nivelAcesso == 'admin' && not empty logs}">
			<div class="table-responsive">
				<table class="table table-striped">
					<thead>
						<tr class="table-dark">
							<th>Código</th>
							<th>CPF</th>
							<th>Nome</th>
							<th>Data de Login</th>
							<th>Data de Logout</th>
							<th>Duração da Sessão</th>
							<th>IP Address</th>
							<th>Dispositivo</th>
							<th>Navegador</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="log" items="${logs}">
							<tr>
								<td><c:out value="${log.codigo}" /></td>
								<td><c:out value="${log.CPF}" /></td>
								<td><c:out value="${log.funcionario.nome}" /></td>
								<td><fmt:formatDate value="${log.dataLoginAsDate}"
										pattern="dd/MM/yyyy HH:mm:ss" /></td>
								<td><fmt:formatDate value="${log.dataLogoutAsDate}"
										pattern="dd/MM/yyyy HH:mm:ss" /></td>		

								<td><c:choose>
										<c:when test="${not empty log.duracaoSessao}">
											<c:out value="${log.duracaoSessao}" />
										</c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose></td>
								<td><c:out value="${log.ipAddress}" /></td>
								<td><c:out value="${log.dispositivo}" /></td>
								<td><c:out value="${log.navegador}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>

		<c:if test="${empty logs}">
			<div class="alert alert-warning">Nenhum log encontrado.</div>
		</c:if>
	</div>

	<div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>