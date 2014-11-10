public class Main {
    public static void main(String[] args) {
		connectDB("jdbc:postgresql://localhost:5432/csc343h-c4fridma", "c4fridma", "password");
		disconnectDB();
	}
}