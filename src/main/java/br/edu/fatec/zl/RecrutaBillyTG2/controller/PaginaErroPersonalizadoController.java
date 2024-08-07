package br.edu.fatec.zl.RecrutaBillyTG2.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class PaginaErroPersonalizadoController implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        String errorPage = "error";

        if (status != null) {
            int statusCode = Integer.parseInt(status.toString());

            switch (statusCode) {
                case 400:
                    errorPage = "error400";
                    break;
                case 401:
                    errorPage = "error401";
                    break;
                case 403:
                    errorPage = "error403";
                    break;
                case 404:
                    errorPage = "error404";
                    break;
                case 500:
                    errorPage = "error500";
                    break;
                case 503:
                    errorPage = "error503";
                    break;    
                default:
                    errorPage = "error";
                    break;
            }
        }

        return errorPage; // Nome da JSP sem a extensão .jsp
    }

    public String getErrorPath() {
        return "/error";
    }
}

