<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
<title>Página Temporariamente Indisponível - Erro 503</title>
</head>
<body>
    <div class="container py-4">
        <h1 class="display-4 text-center">Serviço Temporariamente Indisponível</h1>
        <h2 class="display-4 text-center">Erro 503</h2>
        <p class="lead text-center">Desculpe, o serviço está temporariamente indisponível. Estamos trabalhando para resolver o problema o mais rápido possível.</p>
        <p class="text-center">Por favor, tente novamente mais tarde. Você pode voltar para a <a href="${pageContext.request.contextPath}/index">página inicial</a> </p>

        <div class="container">
            <!-- Aqui você pode adicionar qualquer outro conteúdo relevante, como links para outras seções ou informações de contato -->
        </div>
    </div>

    <div>
        <jsp:include page="footer.jsp" />
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-2m7dTgB0zr7FOpnlzr43I2k1vF8h5U9pFT0f3qlv1M4kv+4iTbiTY18VJhGtp7tt"
        crossorigin="anonymous"></script>
</body>
</html>
