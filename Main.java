public class Main {
	public static void main(String[] args) {
 		System.out.println("1!");
		Assignment2 a2 = new Assignment2();
 		System.out.println("2!");
		a2.connectDB("jdbc:postgresql://localhost:5432/csc343h-c4fridma", "c4fridma", "b3njam1nb3njam1n");
 		System.out.println("3!");
		a2.insertCountry(9, "Placeistan", 9, 800301);
		System.out.println(a2.getCountriesNextToOceanCount(001));
		a2.chgHDI(2, 2006, (float) 0.1);
		System.out.println(a2.listCountryLanguages(1));
		a2.disconnectDB();
	}
}
