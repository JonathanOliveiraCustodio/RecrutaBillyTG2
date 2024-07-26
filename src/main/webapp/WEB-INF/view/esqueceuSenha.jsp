<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
<title>Recuperação de Senha</title>
</head>
<body>
    <div>
        <jsp:include page="menuLogin.jsp" />
    </div>
    <div class="container py-4">
        <div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
            <div class="container-fluid py-1">
                <h1 class="display-6 fw-bold">Recuperação de Senha</h1>
                <form action="esqueceuSenha" method="post" onsubmit="return validarFormulario(event);" class="row g-3 mt-3">
                    <div class="col-md-6">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="col-md-6">
                        <label for="cpf" class="form-label">CPF</label>
                        <input type="text" class="form-control" id="cpf" name="cpf" required>
                    </div>
                    <div class="col-md-6">
                        <label for="novaSenha" class="form-label">Nova Senha</label>
                        <input type="password" class="form-control" id="novaSenha" name="novaSenha" required>
                    </div>
                    <div class="col-md-6">
                        <label for="confirmarSenha" class="form-label">Confirmar Nova Senha</label>
                        <input type="password" class="form-control" id="confirmarSenha" name="confirmarSenha" required>
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn btn-primary">Alterar Senha</button>
                    </div>
                </form>
            </div>
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
    <div>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>
