package GUIpackage;
import java.sql.*;

public class DBconnect {

	private static final String DB_USER = "scott";
	private static final String DB_PASSWORD = "tiger";
	private static final String ORACLE_URL = "jdbc:oracle:thin:@localhost:1521/orcl";
	private static final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";

	public static Connection getConnect() throws SQLException, ClassNotFoundException {
		System.out.println("Checking JDBC...");		
		Class.forName(JDBC_DRIVER);
		System.out.println("Connecting to database...");
		return DriverManager.getConnection(ORACLE_URL, DB_USER, DB_PASSWORD);
	}

	public static void closeConnect(Connection con) {
		try {
			con.close();
			System.out.println("Successfully close connection");
		} catch (SQLException e) {
			System.err.println("Fail to close connection");
		}
	}
}
