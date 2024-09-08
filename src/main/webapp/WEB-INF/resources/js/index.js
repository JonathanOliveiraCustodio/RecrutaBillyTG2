// Variável para armazenar a escolha
let escolha = "";

// Função para definir a escolha com base no clique
function setEscolha(valor) {
	escolha = valor;
	console.log("Escolha selecionada: " + escolha);

}

function setEscolha(valor) {
	document.getElementById('escolhaInput').value = valor; // Define o valor do campo oculto
	document.getElementById('index').submit(); // Submete o formulário
}