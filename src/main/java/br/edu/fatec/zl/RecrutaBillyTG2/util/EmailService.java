package br.edu.fatec.zl.RecrutaBillyTG2.util;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailService {
    
    // Configurações de e-mail SMTP para Yahoo
    private static final String HOST = "smtp.mail.yahoo.com"; // SMTP do Yahoo
    private static final String PORT = "465"; // Porta SMTP para SSL
    private static final String USERNAME = "";
    private static final String PASSWORD = "";
    
    // Método para enviar o código de recuperação de senha
    public static void enviarCodigoRecuperacao(String destinatario, String codigo) {
        // Configura as propriedades do servidor SMTP
        Properties props = new Properties();
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.socketFactory.port", PORT);
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); // Requerido para SSL

        // Inicia a sessão de e-mail com autenticação
        Session session = Session.getInstance(props,
            new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(USERNAME, PASSWORD);
                }
            });

        try {
            // Cria a mensagem de e-mail
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USERNAME)); // Remetente
            message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(destinatario) // Destinatário
            );
            message.setSubject("Código de recuperação de senha - Recruta Billy");
            message.setText("Olá, seu código de recuperação de senha é: " + codigo);

            // Envia a mensagem
            Transport.send(message);
            System.out.println("E-mail enviado com sucesso!");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
