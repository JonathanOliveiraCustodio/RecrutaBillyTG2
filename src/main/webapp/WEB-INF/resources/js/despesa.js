// despesa.js

function editarDespesa(codigo) {
		window.location.href = 'despesas?cmd=alterar&codigo=' + codigo;
	}
	
function excluirDespesa(codigo) {
	if (confirm("Tem certeza que deseja excluir esta Despesa?")) {
		window.location.href = 'despesas?cmd=excluir&codigo=' + codigo;
	}
}