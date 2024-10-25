package br.edu.fatec.zl.RecrutaBillyTG2.util;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

public class SMSService {
	
	// Account SID do Twilio
	public static final String ACCOUNT_SID = "";
	
	// Auth Token do Twilio
	public static final String AUTH_TOKEN = "";
	
	// Número de telefone Twilio
	public static final String TWILIO_PHONE_NUMBER = "";

	public static void enviarCodigoRecuperacao(String telefone, String codigo) {
		// Inicializa o Twilio com as credenciais
		Twilio.init(ACCOUNT_SID, AUTH_TOKEN);

		// Criação da mensagem SMS
		Message message = Message.creator(new PhoneNumber("+55" + telefone), // Número do destinatário
				new PhoneNumber(TWILIO_PHONE_NUMBER), // Seu número Twilio
				"Recruta Billy, Seu código de recuperação de senha é: " + codigo) // Mensagem
				.create();

		System.out.println("SMS enviado com sucesso! SID: " + message.getSid());
	}
}
