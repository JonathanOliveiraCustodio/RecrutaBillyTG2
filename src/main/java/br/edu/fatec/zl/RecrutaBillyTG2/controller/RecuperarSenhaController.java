package br.edu.fatec.zl.RecrutaBillyTG2.controller;

import java.sql.SQLException;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import br.edu.fatec.zl.RecrutaBillyTG2.model.Funcionario;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.FuncionarioDao;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.RecuperarSenhaDao;
import br.edu.fatec.zl.RecrutaBillyTG2.util.SMSService;
import br.edu.fatec.zl.RecrutaBillyTG2.util.Util;
import jakarta.servlet.http.HttpSession;

@Controller
public class RecuperarSenhaController {

	@Autowired
	RecuperarSenhaDao recuperasenhaDao;

	@Autowired
	FuncionarioDao fDao;

	@RequestMapping(name = "recuperarsenha", value = "/recuperarsenha", method = RequestMethod.GET)
	public ModelAndView recuperasenhaGet(ModelMap model, HttpSession session) {
		return new ModelAndView("recuperarsenha");
	}

	@RequestMapping(name = "recuperarsenha", value = "/recuperarsenha", method = RequestMethod.POST)
	public ModelAndView recuperasenhaPost(@RequestParam Map<String, String> allRequestParam, ModelMap model,
			HttpSession session) throws ClassNotFoundException, SQLException {
		String email = allRequestParam.get("email");
		String CPF = allRequestParam.get("CPF");
		String novaSenha = allRequestParam.get("novaSenha");
		String confirmarSenha = allRequestParam.get("confirmarSenha");
		String codigoRecuperacao = allRequestParam.get("codigoRecuperacao");
		String mensagem = "";

		CPF = Util.removerMascara(CPF);

		Funcionario f = new Funcionario();
		f.setCPF(CPF);
		f = fDao.findBy(f);

		if (!novaSenha.equals(confirmarSenha)) {
			mensagem = "A nova senha e a confirmação de senha não coincidem.";
			model.addAttribute("erro", mensagem);
			return new ModelAndView("recuperarsenha");
		}

		try {
			Map<String, String> resultado = recuperasenhaDao.alterarSenha(email, CPF, novaSenha, codigoRecuperacao);
			mensagem = resultado.get("mensagem");
		} catch (Exception e) {
			mensagem = "Erro ao alterar a senha: " + e.getMessage();
		}

		if ("Senha alterada com sucesso".equals(mensagem)) {
			model.addAttribute("saida", mensagem);
		} else {
			model.addAttribute("erro", mensagem);
		}

		return new ModelAndView("recuperarsenha");
	}

	@RequestMapping(name = "solicitarCodigo", value = "/solicitarCodigo", method = RequestMethod.POST)
	public ModelAndView solicitarCodigo(@RequestParam Map<String, String> allRequestParam, ModelMap model) throws ClassNotFoundException, SQLException {
		
		String cpfOuEmail = allRequestParam.get("cpfOuEmail"); // CPF ou e-mail fornecido
		Funcionario funcionario = new Funcionario();

		// Verifique se é CPF ou e-mail
		if (Util.isEmail(cpfOuEmail)) {
			funcionario.setEmail(cpfOuEmail); // Se for um e-mail
		} else {
			String cpf = Util.removerMascara(cpfOuEmail); // Remover máscara se for CPF
			funcionario.setCPF(cpf); // Se for CPF
		}

		// Verifique se o funcionário existe
		funcionario = fDao.findBy(funcionario);

		if (funcionario == null) {
			model.addAttribute("erro", "O CPF ou e-mail não pertence a nenhum cliente.");
			return new ModelAndView("recuperarsenha");
		}

		// Se o funcionário existir, gere um código de recuperação
		String codigoRecuperacao = gerarCodigoRecuperacao(); // Gere um código aleatório

		// Envie o código via SMS ou e-mail, dependendo do que você quiser
		SMSService.enviarCodigoRecuperacao(funcionario.getTelefone(), codigoRecuperacao); // Envie SMS usando o número do funcionário

		fDao.atualizarCodigoRecuperacao(cpfOuEmail, codigoRecuperacao);
		
		model.addAttribute("saida", "Código de recuperação enviado com sucesso!");
		return new ModelAndView("recuperarsenha");
	}

	private String gerarCodigoRecuperacao() {
		// Gere um código de 6 dígitos aleatórios
		Random random = new Random();
		return String.format("%06d", random.nextInt(1000000));
	}

}