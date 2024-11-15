<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/includes/listaCores.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/styles.css">
<title>Tarjeta</title>

</head>
<body>
	<script
		src="${pageContext.request.contextPath}/resources/js/scriptsBootStrap.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/tarjeta.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-1">
				<h1 class="display-6 fw-bold">Manutenção de Tarjetas</h1>

				<div align="center">
					<!-- Mensagem de Erro -->
					<c:if test="${not empty erro}">
						<div class="alert alert-danger fs-5" role="alert">
							<c:out value="${erro}" />
						</div>
					</c:if>

					<!-- Mensagem de Sucesso -->
					<c:if test="${not empty saida}">
						<div class="alert alert-success fs-5" role="alert">
							<c:out value="${saida}" />
						</div>
					</c:if>
				</div>

				<form action="tarjeta" method="post"
					onsubmit="return validarFormulario(event);" class="row g-3 mt-3">
					<!-- Primeira Linha: -->
					<div class="row g-3">
						<div class="col-md-4">
							<div class="form-floating">
								<input type="number" min="0" step="1" id="codigo" name="codigo"
									class="form-control" placeholder="Código"
									value='<c:out value="${tarjeta.codigo }"></c:out>' readonly>
								<label for="codigo">Código</label>
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-floating">
								<input type="text" id="nome" name="nome" class="form-control"
									placeholder="Nome" maxlength="100"
									value='<c:out value="${tarjeta.nome }"></c:out>'> <label
									for="nome">Nome</label>
							</div>
						</div>
						<div class="col-md-1">
							<button type="submit" id="botao" name="botao" value="Buscar"
								class="btn btn-outline-primary btn-align w-100 d-flex justify-content-center align-items-center"
								onclick="return validarBusca()">
								<!-- Ícone SVG dentro do botão -->
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
            <path
										d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
        </svg>
							</button>
						</div>

						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="text" id="descricao"
									name="descricao" placeholder="Descrição"
									value='<c:out value="${tarjeta.descricao}"></c:out>'> <label
									for="descricao">Descrição</label>
							</div>
						</div>
					</div>

					<!-- Segunda Linha: -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="text" id="valorProduto"
									name="valorProduto" placeholder="Valor Produto"
									value='<fmt:formatNumber value="${tarjeta.valorProduto}" type="currency" currencySymbol="R$" />'>
								<label for="valorProduto">Valor Produto:</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<select class="form-select" id="status" name="status">
									<option value="">Escolha um Status</option>
									<option value="Não Aplicável"
										<c:if test="${tarjeta.status eq 'Não Aplicável'}">selected</c:if>>Não
										Aplicável</option>
									<option value="Em Produção"
										<c:if test="${tarjeta.status eq 'Em Produção'}">selected</c:if>>Em
										Produção</option>
									<option value="Disponível"
										<c:if test="${tarjeta.status eq 'Disponível'}">selected</c:if>>Disponível</option>
								</select> <label for="status">Status</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input class="form-control" type="text" id="refEstoque"
									name="refEstoque" placeholder="Referência no Estoque"
									value='<c:out value="${tarjeta.refEstoque}"></c:out>'>
								<label for="refEstoque">Referência no Estoque</label>
							</div>
						</div>
					</div>

					<!-- Terceira Linha:  -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<select id="categoria" name="categoria" class="form-select">
									<option value="0">Escolha uma Categoria</option>
									<c:forEach var="c" items="${categorias }">
										<option value="${c.codigo}"
											<c:if test="${c.codigo eq tarjeta.categoria.codigo}">selected</c:if>>
											<c:out value="${c}" />
										</option>
									</c:forEach>
								</select> <label for="categoria">Categoria</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="tamanhoTarjeta" name="tamanhoTarjeta"
									class="form-control" placeholder="Tamanho Emborrachado"
									maxlength="20"
									value="<c:out value='${tarjeta.tamanhoTarjeta}'/>"> <label
									for="tamanhoTarjeta">Tamanho Tarjeta</label>
							</div>
						</div>

						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="tamanhoLetra" name="tamanhoLetra"
									class="form-control" placeholder="Tamanho Letra" maxlength="20"
									value="<c:out value='${tarjeta.tamanhoLetra}'/>"> <label
									for="tamanhoLetra">Tamanho Letra</label>
							</div>
						</div>
					</div>

					<!-- Quarta Linha:  -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="espacoEntreLinhas"
									name="espacoEntreLinhas" class="form-control"
									placeholder="Espaçamento Entre as Linhas" maxlength="20"
									value="<c:out value='${tarjeta.espacoEntreLinhas}'/>">
								<label for="espacoEntreLinhas">Espaçamento Entre as
									Linhas</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<select class="form-select" id="fardaColete" name="fardaColete">
									<option value="">Escolha uma Opção</option>
									<option value="Farda"
										<c:if test="${tarjeta.fardaColete eq 'Farda'}">selected</c:if>>Farda</option>
									<option value="Colete"
										<c:if test="${tarjeta.fardaColete eq 'Colete'}">selected</c:if>>Colete</option>
								</select> <label for="fardaColete">Para Farda/Colete</label>
							</div>
						</div>

						<div class="col-md-4">
							<div class="form-floating">
								<select class="form-select" id="formato" name="formato">
									<option value="">Escolha um Formato</option>
									<option value="Quadrado"
										<c:if test="${tarjeta.formato eq 'Quadrado'}">selected</c:if>>Quadrado</option>
									<option value="Retangular"
										<c:if test="${tarjeta.formato eq 'Retangular'}">selected</c:if>>Retangular</option>
									<option value="Redondo"
										<c:if test="${tarjeta.formato eq 'Redondo'}">selected</c:if>>Redondo</option>
								</select> <label for="formato">Formato</label>
							</div>
						</div>
					</div>

					<!-- Quinta Linha:  -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="corFundo" name="corFundo"
									class="form-control" placeholder="Cor de Fundo"
									value="<c:out value='${tarjeta.corFundo}'/>"> <label
									for="corFundo">Cor de Fundo</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="corBordas" name="corBordas"
									class="form-control" placeholder="Cor das Bordas"
									value="<c:out value='${tarjeta.corBordas}'/>"> <label
									for="corBordas">Cor das Bordas</label>
							</div>
						</div>

						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="corLetras" name="corLetras"
									class="form-control" placeholder="Cor das Letras"
									value="<c:out value='${tarjeta.corLetras}'/>"> <label
									for="corLetras">Cor das Letras</label>
							</div>
						</div>

					</div>

					<!-- Sexta Linha:  -->
					<div class="row g-3 mt-2">
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="corTipoSanguineo" name="corTipoSanguineo"
									class="form-control" placeholder="Cor Tipo Sanguineo"
									value="<c:out value='${tarjeta.corLetras}'/>"> <label
									for="corTipoSanguineo">Cor Tipo Sanguineo</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-floating">
								<input type="text" id="corFatorRH" name="corFatorRH"
									class="form-control" placeholder="Cor corFator RH"
									value="<c:out value='${tarjeta.corFatorRH}'/>"> <label
									for="corTipoSanguineo">Cor Fator RH</label>
							</div>
						</div>
					</div>
					<div
						class="container py-4 text-center d-flex justify-content-center"
						align="center">
						<div class="table-responsive w-100">
							<table class="table table-striped">
								<thead>
									<tr>
										<th class="titulo-tabela" colspan="10"
											style="text-align: center; font-size: 35px;">Lista de
											Nomes Tarjetas</th>
									</tr>
									<tr class="table-dark">
										<th>Código</th>
										<th>Nome</th>
										<th>Tipo Sanguíneo</th>
										<th>Fator RH</th>
										<th>Quantidade</th>
										<th>Patente</th>
										<th>Remover</th>
									</tr>
								</thead>
								<tbody class="table-group-divider">
									<c:forEach var="nt" items="${nomesTarjetas}" varStatus="status">
										<tr>

											<td><input type="text" name="codigo[${status.index}]"
												value="${nt.codigo}" readonly style="width: 80px;" /></td>
											<td><input type="text" name="nome[${status.index}]"
												value="${nt.nome}" /></td>
											<td><select name="tipoSanguineo[${status.index}]"
												class="form-select" style="min-width: 80px;">
													<option value=""></option>
													<option value="A"
														${nt.tipoSanguineo == 'A' ? 'selected' : ''}>A</option>
													<option value="B"
														${nt.tipoSanguineo == 'B' ? 'selected' : ''}>B</option>
													<option value="AB"
														${nt.tipoSanguineo == 'AB' ? 'selected' : ''}>AB</option>
													<option value="O"
														${nt.tipoSanguineo == 'O' ? 'selected' : ''}>O</option>
											</select></td>
											<td><select name="fatorRH[${status.index}]"
												class="form-select" style="min-width: 80px;">
													<option value="">Escolha um Fator RH</option>
													<option value="Positivo"
														${nt.fatorRH == 'Positivo' ? 'selected' : ''}>Positivo</option>
													<option value="Negativo"
														${nt.fatorRH == 'Negativo' ? 'selected' : ''}>Negativo</option>
											</select></td>
											<td><input type="number"
												name="quantidade[${status.index}]" value="${nt.quantidade}"
												style="width: 80px;" /></td>
											<td><select name="patente[${status.index}]"
												class="form-select">
													<c:forEach var="pat" items="${patentes}">
														<option value="${pat.codigo}"
															${nt.patente.codigo eq pat.codigo ? 'selected' : ''}>${pat.nome}</option>
													</c:forEach>
											</select></td>
											<td style="text-align: center;">
												<button type="button" class="btn btn-danger"
													value="excluirNomeTarjeta"
													onclick="excluirNomeTarjeta('${nt.codigo}')">Remover</button>
											</td>
										</tr>
									</c:forEach>
									<!-- Linha para adicionar um novo registro -->
									<tr>
										<td colspan="1" style="text-align: center;">
											<button type="submit" class="btn btn-success" name="botao"
												value="Novo" onclick="return validarNovo()">Novo</button>

										</td>
										<td><input type="text" name="novoNome"
											placeholder="Novo Nome" /></td>
										<td><select name="novoTipoSanguineo" class="form-select"
											style="min-width: 80px;">
												<option value="">Tipo Sanguíneo</option>
												<option value="A">A</option>
												<option value="B">B</option>
												<option value="AB">AB</option>
												<option value="O">O</option>
										</select></td>
										<td><select name="novoFatorRH" class="form-select"
											style="min-width: 80px;">
												<option value="">Fator RH</option>
												<option value="Positivo">Positivo</option>
												<option value="Negativo">Negativo</option>
										</select></td>
										<td><input type="number" name="novoQuantidade"
											placeholder="Quantidade" style="width: 80px;" /></td>
										<td><select name="novoPatente" class="form-select">
												<c:forEach var="pat" items="${patentes}">
													<option value="${pat.codigo}">${pat.nome}</option>
												</c:forEach>
										</select></td>
										<td></td>
									</tr>
								</tbody>
							</table>
							<button type="submit" class="btn btn-primary" name="botao"
								value="Salvar Todos">Salvar Todos</button>
						</div>
					</div>


					<!-- Linha dos Botões -->
					<div class="row g-3 mt-3">
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Cadastrar"
								class="btn btn-success btn-align">
						</div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Alterar"
								class="btn btn-warning btn-align">
						</div>

						<div class="col-md-2 d-grid text-center"></div>
						<div class="col-md-2 d-grid text-center"></div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Listar"
								class="btn btn-dark btn-align">
						</div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Limpar"
								class="btn btn-secondary btn-align">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="container py-4 text-center d-flex justify-content-center"
		align="center">
		<c:if test="${not empty tarjetas}">
			<div class="table-responsive">
				<table class="table table-striped">
					<thead>
						<tr>
							<th class="titulo-tabela" colspan="13"
								style="text-align: center; font-size: 35px;">Lista de
								Tarjetas</th>
						</tr>
						<tr class="table-dark">
							<th></th>
							<th>Código</th>
							<th>Nome</th>
							<th>Valor</th>
							<th>Status</th>
							<th>Data</th>
							<th>Tamanho</th>
							<th>Tamanho Letra</th>
							<th>Espaçamento</th>
							<th>Farda/Colete</th>
							<th>Formato</th>
							<th>Insumos</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="t" items="${tarjetas}">
							<tr>
								<td style="text-align: center;">
									<button class="btn btn-outline-dark" name="opcao"
										value="${t.codigo}" onclick="editarTarjeta(this.value)"
										${t.codigo eq codigoEdicao ? 'checked' : ''}>
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
								<td><c:out value="${t.codigo}" /></td>
								<td><c:out value="${t.nome}" /></td>
								<td><fmt:formatNumber value="${t.valorProduto}"
										type="currency" currencySymbol="R$" /></td>
								<td><c:out value="${t.status}" /></td>
								<td><fmt:formatDate value="${t.data}" pattern="dd/MM/yyyy" /></td>
								<td><c:out value="${t.tamanhoTarjeta}" /></td>
								<td><c:out value="${t.tamanhoLetra}" /></td>
								<td><c:out value="${t.espacoEntreLinhas}" /></td>
								<td><c:out value="${t.fardaColete}" /></td>
								<td><c:out value="${t.formato}" /></td>
								<td>
									<button
										onclick="window.location.href='tarjeta?tarjeta=${e.codigo}'"
										class="btn btn-info">Adicionar</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>
	</div>
	<div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>
