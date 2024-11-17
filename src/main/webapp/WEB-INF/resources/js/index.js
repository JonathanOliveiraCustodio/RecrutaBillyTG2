function setEscolha(escolha) {
    localStorage.setItem('escolha', escolha);
    document.getElementById('escolhaInput').value = escolha;
    document.getElementById('index').submit();
}

document.addEventListener('DOMContentLoaded', function() {
    var escolha = localStorage.getItem('escolha');
    if (escolha) {
        var element = document.getElementById('tabelas');
        if (element) {
            element.scrollIntoView({ behavior: 'smooth' });
        }
        localStorage.removeItem('escolha'); // Remove a escolha do localStorage após a rolagem
    }
});