public class Main {
	public static void main(String[] args) {
 		System.out.println("1!");
		Assignment2 a2 = new Assignment2();
 		System.out.println("2!");
		a2.connectDB("jdbc:postgresql://localhost:5432/csc343h-c4fridma", "c4fridma", "b3njam1nb3njam1n");
 		System.out.println("3!");
		a2.disconnectDB();
	}
}
