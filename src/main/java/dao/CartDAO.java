package dao;

import models.CartModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
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

    // Add item to cart
    public static int addToCart(CartModel cart) {
        String query = "INSERT INTO cart (userId, bookId, quantity) VALUES (?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, cart.getUserId());
            ps.setInt(2, cart.getBookId());
            ps.setInt(3, cart.getQuantity());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error adding to cart", e);
        }
        return -1;
    }

    // Get cart items by userId
    public static List<CartModel> getCartByUserId(int userId) {
        List<CartModel> cartList = new ArrayList<>();
        String query = "SELECT * FROM cart WHERE userId = ?";

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartModel cart = new CartModel();
                    cart.setId(rs.getInt("id"));
                    cart.setUserId(rs.getInt("userId"));
                    cart.setBookId(rs.getInt("bookId"));
                    cart.setQuantity(rs.getInt("quantity"));
                    cartList.add(cart);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving cart items", e);
        }
        return cartList;
    }

    // Update quantity
    public static boolean updateQuantity(int userId, int bookId, int quantity) {
        String query = "UPDATE cart SET quantity = ? WHERE userId = ? AND bookId = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, quantity);
            ps.setInt(2, userId);
            ps.setInt(3, bookId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating quantity", e);
        }
    }

    // Remove item from cart
    public static boolean removeFromCart(int userId, int bookId) {
        String query = "DELETE FROM cart WHERE userId = ? AND bookId = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, userId);
            ps.setInt(2, bookId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error removing item from cart", e);
        }
    }

    // Clear entire cart
    public static boolean clearCart(int userId) {
        String query = "DELETE FROM cart WHERE userId = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error clearing cart", e);
        }
    }
}
