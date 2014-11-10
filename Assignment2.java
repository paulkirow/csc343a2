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
	System.out.println("this is starting to be initialized");
	Class.forName("org.postgresql.Driver");
	System.out.println("this initialized");
  } catch (ClassNotFoundException e) {
	System.out.println("this is not initialized");
	return;
  }
  }
  
  //Using the input parameters, establish a connection to be used for this session. Returns true if connection is sucessful
  public boolean connectDB(String URL, String username, String password){
    try{ 
	System.out.println("this started.");
	connection = DriverManager.getConnection(URL,username,password);
	System.out.println("this connected! 2");
	if (connection == null) {System.out.println("this failed to connect 1!");
	return false;}
	sql = connection.createStatement();
	System.out.println("this connected!");
	} catch (SQLException e) {	System.out.println("this failed to connect 2!");
	return false;}
	return true;
  }
  
  //Closes the connection. Returns true if closure was sucessful
  public boolean disconnectDB(){
	try {
 		System.out.println("this is starting to close!");
		connection.close();
 		System.out.println("this closed!");
		return true;
		} catch (SQLException e) {
			return false;
		}
  }
    
  public boolean insertCountry (int cid, String name, int height, int population) {
   return false;
  }
  
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
