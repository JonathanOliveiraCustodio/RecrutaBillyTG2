package br.edu.fatec.zl.RecrutaBillyTG2.persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

@Repository
public class GenericDao {
	private Connection c;
	
	public Connection getConnection() throws ClassNotFoundException, SQLException{
		String hostname = "localhost";
		String port = "1433";
		String db = "RecrutaBillyTG2";
		String user ="sa";
		String pass ="123456";
		String host = "jdbc:jtds:sqlserver://";
		String uri = host+hostname+":"+port+";databaseName="+db+";user="+user+";password="+pass;
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		c = DriverManager.getConnection(uri);
		return c;
	}
}
