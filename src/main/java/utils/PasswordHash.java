package utils;


import org.mindrot.jbcrypt.BCrypt;

public class PasswordHash {

    // Hash a plain text password
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    // Verify the password against the hashed password
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        System.out.println("Manually checking password hash...");
        System.out.println(BCrypt.checkpw("abcd1234", "$2a$10$IHqnr92ndqVp0D3nB2K5duN01a5kdSrnr1wL0ECOBpDW./jmrXZVG"));
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}

