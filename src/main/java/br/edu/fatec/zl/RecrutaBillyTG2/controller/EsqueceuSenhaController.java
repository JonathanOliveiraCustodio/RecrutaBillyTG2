package br.edu.fatec.zl.RecrutaBillyTG2.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fatec.zl.RecrutaBillyTG2.persistence.EsqueceuSenhaDao;
import jakarta.servlet.http.HttpSession;

@Controller
public class EsqueceuSenhaController {

    @Autowired
    EsqueceuSenhaDao esqueceuSenhaDao;

    @RequestMapping(name = "esqueceuSenha", value = "/esqueceuSenha", method = RequestMethod.GET)
    public ModelAndView esqueceuSenhaGet(ModelMap model, HttpSession session) {
        return new ModelAndView("esqueceuSenha");
    }

    @RequestMapping(name = "esqueceuSenha", value = "/esqueceuSenha", method = RequestMethod.POST)
    public ModelAndView esqueceuSenhaPost(@RequestParam Map<String, String> allRequestParam, ModelMap model, HttpSession session) {
        String email = allRequestParam.get("email");
        String cpf = allRequestParam.get("cpf");
        String novaSenha = allRequestParam.get("novaSenha");
        String confirmarSenha = allRequestParam.get("confirmarSenha");
        String mensagem = "";

        if (!novaSenha.equals(confirmarSenha)) {
            mensagem = "A nova senha e a confirmação de senha não coincidem.";
            model.addAttribute("erro", mensagem);
            return new ModelAndView("esqueceuSenha");
        }

        try {
            Map<String, String> resultado = esqueceuSenhaDao.alterarSenha(email, cpf, novaSenha);
            mensagem = resultado.get("mensagem");
        } catch (Exception e) {
            mensagem = "Erro ao alterar a senha: " + e.getMessage();
        }

        if ("Senha alterada com sucesso".equals(mensagem)) {
            model.addAttribute("saida", mensagem);
        } else {
            model.addAttribute("erro", mensagem);
        }

        return new ModelAndView("esqueceuSenha");
    }
}