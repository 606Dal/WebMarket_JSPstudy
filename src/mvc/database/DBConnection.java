package mvc.database;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	
	public static Connection getConnection() {
		
		Connection conn = null;
		
		String url = "jdbc:mysql://localhost:3306/webmarketdb";
		String user = "";
		String password = "";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("데이터베이스에 연결 되었습니다.");
		} catch (Exception e) {
			System.out.println("데이터베이스 연결이 실패되었습니다.");
			System.out.print("예외 이유 : ");
			e.printStackTrace();
		}
		
		return conn;
	}

}
