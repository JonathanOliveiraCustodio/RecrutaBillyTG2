package br.edu.fatec.zl.RecrutaBillyTG2.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import br.edu.fatec.zl.RecrutaBillyTG2.persistence.LoginDao;
import br.edu.fatec.zl.RecrutaBillyTG2.util.SMSService;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

	@Autowired
	LoginDao loginDao;

	@RequestMapping(name = "login", value = "/login", method = RequestMethod.GET)
	public ModelAndView loginGet(ModelMap model) {
		return new ModelAndView("login");
	}

	@RequestMapping(name = "login", value = "/login", method = RequestMethod.POST)
	public ModelAndView loginPost(@RequestParam Map<String, String> allRequestParam, ModelMap model, HttpSession session) {
	    String email = allRequestParam.get("email");
	    
	    String senha = allRequestParam.get("senha");
	    String mensagem = "";
	    String cmd = allRequestParam.get("botao");

	    if ("Login".equals(cmd)) {
	    	
	        try {
	        //	SMSService.enviarCodigoRecuperacao("+5511956090706", "656412");
	            Map<String, String> resultado = loginDao.validarCredenciais(email, senha);
	            String nivelAcesso = resultado.get("nivelAcesso");

	            if ("Login bem-sucedido".equals(resultado.get("mensagem"))) {
	                session.setAttribute("usuarioLogado", email);
	                session.setAttribute("nivelAcesso", nivelAcesso);
	                return new ModelAndView("redirect:/index");
	            } else if ("Conta bloqueada. Um código de recuperação foi enviado.".equals(resultado.get("mensagem"))) {
	                // Se o login falhou por bloqueio de conta
	                String codigoRecuperacao = loginDao.obterCodigoRecuperacao(email);
	                String numeroTelefone = loginDao.obterNumeroTelefone(email); // Obtém o número de telefone

	                // Envia o SMS com o código
	                if (codigoRecuperacao != null && numeroTelefone != null) {
	                    SMSService.enviarCodigoRecuperacao(numeroTelefone, codigoRecuperacao); // Envia SMS
	                }

	                mensagem = "Conta bloqueada. Um código de recuperação foi enviado para o seu telefone.";
	            } else {
	                mensagem = resultado.get("mensagem");
	            }
	        } catch (Exception e) {
	            mensagem = "Ocorreu um erro: " + e.getMessage();
	        }

	        model.addAttribute("errorMessage", mensagem);
	        return new ModelAndView("login");
	    } else if ("Recuperar a Senha".equals(cmd)) {
	        return new ModelAndView("redirect:/esqueceuSenha");
	    } else {
	        model.addAttribute("errorMessage", "Ação não reconhecida.");
	        return new ModelAndView("login");
	    }
	}


}
