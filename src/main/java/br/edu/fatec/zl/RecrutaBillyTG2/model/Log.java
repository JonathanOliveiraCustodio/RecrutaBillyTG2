package br.edu.fatec.zl.RecrutaBillyTG2.model;

import java.sql.Time;
import java.time.LocalDateTime;
import java.time.ZoneId;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Log {
    int codigo;
    String CPF;
    LocalDateTime dataLogin;
    LocalDateTime dataLogout;
    Time duracaoSessao;
    String ipAddress;
    String dispositivo;
    String navegador;
    Funcionario funcionario;

    public java.util.Date getDataLoginAsDate() {
        return dataLogin != null ? java.util.Date.from(dataLogin.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }
    
    public java.util.Date getDataLogoutAsDate() {
        return dataLogout != null ? java.util.Date.from(dataLogout.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }
}