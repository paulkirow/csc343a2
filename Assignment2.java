import java.sql.*;

public class Assignment2 {
    
  // A connection to the database  
  Connection connection;
  
  // Statement to run queries
  Statement sql;
  
  // Prepared Statement
  PreparedStatement ps;
  
  // Resultset for the query
  ResultSet rs;
  
  //CONSTRUCTOR
  Assignment2(){
  try {	//Load JDBC driver
	Class.forName("org.postgresql.Driver");
  } catch (ClassNotFoundException e) {
	return;
  }
  }
  
  //Using the input parameters, establish a connection to be used for this session. Returns true if connection is sucessful
  public boolean connectDB(String URL, String username, String password){
    try{ 
	connection = DriverManager.getConnection(URL,username,password);
	if (connection == null) {return false;}
	sql = connection.createStatement();
	} catch (SQLException e) {return false;}
	return true;
  }
  
  //Closes the connection. Returns true if closure was sucessful
  public boolean disconnectDB(){
	try {
		connection.close();  
		return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
  }
  
  public boolean insertCountry (int cid, String name, int height, int population) {
	String stmt = "INSERT INTO country " +
                   "VALUES (?, ?, ?, ?)";
	PreparedStatement preStmt = connection.preparedStatement(stmt);
	preStmt.setString(1,cid);
	preStmt.setString(2,name);
	preStmt.setString(3,height);
	preStmt.setString(4,population);
	try {preStmt.executeUpdate(sql);}
	catch (SQLException e) {return false;}
	return true;
  }

  public int int getCountriesNextToOceanCount(int oid) {
	String stmt = "SELECT COUNT(cid) AS num FROM oceanAccess " +
                   "WHERE oid=?";
	PreparedStatement preStmt = connection.preparedStatement(stmt);
	preStmt.setString(1,oid);
	try {
		ResultSet rs = preStmt.executeUpdate(sql);
		return re.getInt("num");
	}
	catch (SQLException e) {return -1;}
  
  public int getCountriesNextToOceanCount(int oid) {
	return -1;
  }
 
  public String getOceanInfo(int oid){
   return "";
  }

  public boolean chgHDI(int cid, int year, float newHDI){
   return false;
  }

  public boolean deleteNeighbour(int c1id, int c2id){
   return false;        
  }
  
  public String listCountryLanguages(int cid){
	return "";
  }
  
  public boolean updateHeight(int cid, int decrH){
    return false;
  }
    
  public boolean updateDB(){
	return false;    
  }
  
}
