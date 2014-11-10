public class Main {
	public static void main(String[] args) {
 		System.out.println("1!");
		Assignment2 a2 = new Assignment2();
 		System.out.println("2!");
		a2.connectDB("jdbc:postgresql://localhost:5432/csc343h-c4fridma", "c4fridma", "b3njam1nb3njam1n");
 		System.out.println("3!");
		a2.insertCountry(10, "Placeistanistan", 19, 1800301);
		System.out.println(a2.getCountriesNextToOceanCount(002));
		System.out.println(a2.getOceanInfo(002));
		a2.chgHDI(2, 2006, (float) 0.1);
		a2.deleteNeighbour(1, 2);
		System.out.println(a2.listCountryLanguages(4));
 		a2.updateHeight(001, 4);
		a2.updateDB();
		a2.disconnectDB();
	}
}

//  java -cp /local/packages/jdbc-postgresql/postgresql-8.4-701.jdbc4.jar: