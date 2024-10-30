<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List, java.util.Map, java.util.Arrays" %>

<%-- Definindo a lista de cores --%>
<%
    List<Map<String, String>> cores = Arrays.asList(
        Map.of("valor", "#FFFFFF", "nome", "Branco"),
        Map.of("valor", "#000000", "nome", "Preto"),
        Map.of("valor", "#FF0000", "nome", "Vermelho"),
        Map.of("valor", "#8B0000", "nome", "Vermelho Escuro"),
        Map.of("valor", "#FF7F7F", "nome", "Vermelho Claro"),
        Map.of("valor", "#00FF00", "nome", "Verde"),
        Map.of("valor", "#006400", "nome", "Verde Escuro"),
        Map.of("valor", "#90EE90", "nome", "Verde Claro"),
        Map.of("valor", "#0000FF", "nome", "Azul"),
        Map.of("valor", "#00008B", "nome", "Azul Escuro"),
        Map.of("valor", "#87CEFA", "nome", "Azul Claro"),
        Map.of("valor", "#FFFF00", "nome", "Amarelo"),
        Map.of("valor", "#FFD700", "nome", "Amarelo Escuro"),
        Map.of("valor", "#FFFFE0", "nome", "Amarelo Claro"),
        Map.of("valor", "#FFA500", "nome", "Laranja"),
        Map.of("valor", "#FF8C00", "nome", "Laranja Escuro"),
        Map.of("valor", "#FFE4B5", "nome", "Laranja Claro"),
        Map.of("valor", "#FFC0CB", "nome", "Rosa"),
        Map.of("valor", "#FF1493", "nome", "Rosa Escuro"),
        Map.of("valor", "#FFB6C1", "nome", "Rosa Claro"),
        Map.of("valor", "#A52A2A", "nome", "Marrom"),
        Map.of("valor", "#8B4513", "nome", "Marrom Escuro"),
        Map.of("valor", "#D2B48C", "nome", "Marrom Claro")
        // Adicione as outras cores conforme necessário
    );
%>
