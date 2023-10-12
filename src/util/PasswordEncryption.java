
package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordEncryption {

	public static String encryptPassword(String password) {
		try {
			// Create an instance of the MD5 algorithm
			MessageDigest md = MessageDigest.getInstance("MD5");

			// Convert the password string to bytes
			byte[] passwordBytes = password.getBytes();

			// Compute the MD5 hash
			byte[] hashBytes = md.digest(passwordBytes);

			// Convert the hash bytes to a hexadecimal string representation
			StringBuilder hexString = new StringBuilder();
			for (byte hashByte : hashBytes) {
				String hex = Integer.toHexString(0xff & hashByte);
				if (hex.length() == 1)
					hexString.append('0');
				hexString.append(hex);
			}

			// Return the hashed password as a string
			return hexString.toString();
		} catch (NoSuchAlgorithmException e) {
			// Handle the exception if the MD5 algorithm is not available
			e.printStackTrace();
		}

		return null;
	}
	
	public static void main(String[] args) {
		System.out.println(PasswordEncryption.encryptPassword("123"));
	}

}
