<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Política de Privacidade</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            line-height: 1.6;
        }
        h1, h2, h3 {
            color: #333;
        }
        ul {
            margin-left: 20px;
        }
        .section {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <h1>Política de Privacidade</h1>

    <div class="section">
        <h2>1. Tipos de Dados Coletados</h2>
        <p>Nosso sistema coleta e armazena diferentes tipos de dados, dependendo da função desempenhada. Esses dados são usados exclusivamente para fins internos de gerenciamento e não são compartilhados com terceiros, exceto conforme necessário para o cumprimento das leis vigentes.</p>
        <ul>
            <li><strong>Dados de Funcionários</strong>: CPF, nome, e-mail, telefone, data de nascimento, cargo, nível de acesso, data de admissão, data de desligamento, salário, e observações.</li>
            <li><strong>Dados de Clientes</strong>: nome, e-mail, telefone, documento de identificação (CPF/CNPJ), endereço completo, e data de nascimento.</li>
            <li><strong>Dados de Fornecedores</strong>: nome, telefone, e-mail, empresa, e endereço completo.</li>
            <li><strong>Dados de Despesas</strong>: nome da despesa, data de vencimento, tipo de pagamento, e valor.</li>
            <li><strong>Dados de Equipamentos</strong>: nome, descrição, fabricante, e data de aquisição.</li>
            <li><strong>Dados de Pedidos e Produtos</strong>: cliente, valor total, estado do pedido, tipo de pagamento, status do pagamento, nome do produto, valor unitário, quantidade, e referência em estoque.</li>
        </ul>
    </div>

    <div class="section">
        <h2>2. Uso de APIs Externas</h2>
        <p>Nosso sistema não coleta dados diretamente de clientes externos. No entanto, utilizamos as seguintes APIs para funcionalidades específicas:</p>
        <ul>
            <li><strong>Twilio API</strong>: para envio de SMS, como códigos de recuperação de senha.</li>
            <li><strong>ViaCEP API</strong>: para consulta de endereços a partir do CEP informado, facilitando o preenchimento automático de endereços.</li>
        </ul>
    </div>

    <div class="section">
        <h2>3. Armazenamento de Dados</h2>
        <p>Os dados são armazenados em um banco de dados seguro e criptografado, fornecido por um provedor terceirizado, que oferece níveis adequados de proteção e conformidade com as regulamentações de segurança de dados.</p>
    </div>

    <div class="section">
        <h2>4. Controle e Acesso aos Dados</h2>
        <p>Os dados dos funcionários e fornecedores podem ser atualizados exclusivamente pelo administrador da empresa ou pelos gestores autorizados. O sistema mantém um log de atividade que registra:</p>
        <ul>
            <li>Data e hora de login</li>
            <li>Duração da sessão</li>
            <li>Dispositivo utilizado</li>
            <li>Endereço IP e navegador</li>
        </ul>
    </div>

    <div class="section">
        <h2>5. Compartilhamento de Dados</h2>
        <p>Não compartilhamos os dados armazenados no sistema com terceiros, exceto em casos de obrigação legal ou se for necessário para proteger os direitos da empresa.</p>
    </div>

    <div class="section">
        <h2>6. Segurança dos Dados</h2>
        <p>Nos comprometemos a proteger as informações armazenadas e aplicamos medidas técnicas e administrativas adequadas para evitar acessos não autorizados, violações de dados, ou uso indevido. Todas as senhas e informações confidenciais são criptografadas.</p>
    </div>

    <div class="section">
        <h2>7. Direitos dos Titulares dos Dados</h2>
        <p>De acordo com a LGPD, os titulares dos dados têm o direito de:</p>
        <ul>
            <li>Solicitar a confirmação da existência de tratamento de seus dados</li>
            <li>Acessar seus dados</li>
            <li>Corrigir dados incompletos, inexatos ou desatualizados</li>
            <li>Solicitar a exclusão de seus dados, exceto quando houver obrigação legal de mantê-los</li>
        </ul>
        <p>Para exercer esses direitos, o titular pode entrar em contato com o administrador do sistema.</p>
    </div>

    <div class="section">
        <h2>8. Alterações nesta Política</h2>
        <p>Esta política de privacidade pode ser alterada periodicamente para refletir mudanças nas práticas de tratamento de dados. Quando isso ocorrer, notificaremos os usuários por meio do sistema.</p>
    </div>

</body>
</html>