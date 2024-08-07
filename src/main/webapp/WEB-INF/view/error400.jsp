<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
<title>Solicita��o Inv�lida - Erro 400</title>
</head>
<body>
    <div class="container py-4">
        <h1 class="display-4 text-center">Solicita��o Inv�lida</h1>
        <h2 class="display-4 text-center">Erro 400</h2>
        <p class="lead text-center">Desculpe, a solicita��o que voc� enviou � inv�lida ou malformada.</p>
        <p class="text-center">Verifique os dados que voc� enviou e tente novamente. Se voc� continuar encontrando problemas, entre em contato com o suporte.</p>
        <p class="text-center">Voc� pode voltar para a <a href="${pageContext.request.contextPath}/index">p�gina inicial</a> ou visitar a nossa <a href="${pageContext.request.contextPath}/support">p�gina de suporte</a>.</p>

        <div class="container">
            <!-- Adicione informa��es adicionais se necessario -->
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
