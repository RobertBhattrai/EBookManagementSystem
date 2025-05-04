package dao;

import utils.PasswordHash;
import models.UserModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/ebook_database";
    private static final String USER = "root";
    private static final String PASS = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    // Add User
    public static int addUser(UserModel user) {
        String query = "INSERT INTO User (name, email, phone, address, username, password, role) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getUsername());
            ps.setString(6, user.getPassword());
            ps.setString(7, user.getRole());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // Return the new user ID
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return -1;
    }

    // Authenticate User
    public static UserModel getUserByEmailOrUsername(String emailOrUsername, String password) {
        String query = "SELECT * FROM User WHERE email = ? OR username = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, emailOrUsername);
            ps.setString(2, emailOrUsername);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("password");

                // Debug logs (remove in production)

                System.out.println("Input password: " + password);
                System.out.println("Stored hashed password: " + hashedPassword);
                System.out.println("Password match: " + PasswordHash.verifyPassword(password, hashedPassword));

                // Compare the plaintext input password with the hashed password from DB
                if (PasswordHash.verifyPassword(password, hashedPassword)) {
                    return new UserModel(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            rs.getString("username"),
                            hashedPassword,
                            rs.getString("role")
                    );
                }
            }

        } catch (SQLException e) {
            System.err.println("Error in getUserByEmailOrUsername: " + e.getMessage());
        }

        return null; // If user not found or password doesn't match
    }


    public static UserModel userLogin(String email, String password) {
        try (Connection conn = getConnection();) {

            String ePassword = PasswordHash.hashPassword(password);
            String query = "select * from useraccount where email = ? and password = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setString(1, email);
            pt.setString(2, ePassword);
            ResultSet rs = pt.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("password");
                return new UserModel(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("username"),
                        hashedPassword,
                        rs.getString("role")
                );
            } else {
                return null;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }


    // Update User Info (name, phone, address, password)
    public static boolean updateUser(UserModel user) {
        String query = "UPDATE User SET username = ?, name = ?, phone = ?, address = ? WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getName());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setInt(5, user.getId());

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return false;
    }

    // Update password securely
    public static boolean updatePassword(int userId, String currentPassword, String newPassword) {
        String verifyQuery = "SELECT password FROM User WHERE id = ?";
        String updateQuery = "UPDATE User SET password = ? WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement psVerify = conn.prepareStatement(verifyQuery);
             PreparedStatement psUpdate = conn.prepareStatement(updateQuery)) {

            psVerify.setInt(1, userId);
            ResultSet rs = psVerify.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");

                if (PasswordHash.verifyPassword(currentPassword, storedPassword)) {
                    String newHashed = PasswordHash.hashPassword(newPassword);
                    psUpdate.setString(1, newHashed);
                    psUpdate.setInt(2, userId);

                    int affectedRows = psUpdate.executeUpdate();
                    return affectedRows > 0;
                }
            }

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }

        return false;
    }

    // Delete user after verifying password (For self User)
    public static boolean deleteUser(String emailOrUsername, String password) {
        String queryCheck = "SELECT id, password FROM User WHERE email = ? OR username = ?";
        String queryDelete = "DELETE FROM User WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement psCheck = conn.prepareStatement(queryCheck);
             PreparedStatement psDelete = conn.prepareStatement(queryDelete)) {

            psCheck.setString(1, emailOrUsername);
            psCheck.setString(2, emailOrUsername);
            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("id");
                String storedPassword = rs.getString("password");

                if (!PasswordHash.verifyPassword(password, storedPassword)) {
                    System.out.println("Incorrect password. User deletion failed.");
                    return false;
                }

                psDelete.setInt(1, userId);
                int affectedRows = psDelete.executeUpdate();
                return affectedRows > 0;
            } else {
                System.out.println("User not found with that username/email.");
            }

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return false;
    }

    // Delete User by ID (For Admin)
    public static boolean deleteUser(int userId) {
        String query = "DELETE FROM User WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting user: " + e.getMessage());
            return false;
        }
    }


    public static List<UserModel> getAllUsers() {
        List<UserModel> users = new ArrayList<>();
        String query = "SELECT * FROM User";

        try (Connection connection = getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                UserModel user = new UserModel();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setUsername(rs.getString("username"));
//                user.setPassword(rs.getString("password")); // Optional
                user.setRole(rs.getString("role"));

                users.add(user);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error getting all users", e);
        }
        return users;
    }

}

