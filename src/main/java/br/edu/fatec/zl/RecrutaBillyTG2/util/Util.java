package br.edu.fatec.zl.RecrutaBillyTG2.util;

public class Util {
    public static String removerMascara(String valor) {
        if (valor != null) {
            return valor.replaceAll("\\D", ""); // Remove todos os caracteres não numéricos
        }
        return null;
    }
}