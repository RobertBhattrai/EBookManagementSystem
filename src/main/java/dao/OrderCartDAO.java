package dao;

import models.OrderCartModel;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderCartDAO {
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

    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    // Add a cart item
    public static int addOrderCart(OrderCartModel cart, int itemCount) {
        String query = "INSERT INTO ordercart (orderId, bookName, authorName, quantity, price) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, cart.getOrderId());
            ps.setString(2, cart.getBookName());
            ps.setString(3, cart.getAuthorName());
            ps.setInt(4, cart.getQuantity());
            ps.setDouble(5, cart.getPrice());

            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error inserting cart item", e);
        }
        return -1;
    }


    public static boolean addOrderCartItems(List<OrderCartModel> orderCartItems) {
        String query = "INSERT INTO ordercart (orderId, bookName, authorName, quantity, price) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            for (OrderCartModel item : orderCartItems) {
                ps.setInt(1, item.getOrderId());
//                ps.setInt(2, item.getBookId());
                ps.setString(2, item.getBookName());
                ps.setString(3, item.getAuthorName());
                ps.setInt(4, item.getQuantity());
                ps.setDouble(5, item.getPrice());
                ps.addBatch();
            }

            int[] results = ps.executeBatch();
            for (int result : results) {
                if (result <= 0) {
                    return false;
                }
            }
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all cart items
    public static List<OrderCartModel> getAllOrderCarts() {
        List<OrderCartModel> carts = new ArrayList<>();
        String query = "SELECT * FROM ordercart";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                carts.add(extractFromResultSet(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving cart items", e);
        }
        return carts;
    }

    // Get cart items by orderId
    public static List<OrderCartModel> getCartsByOrderId(int orderId) {
        List<OrderCartModel> carts = new ArrayList<>();
        String query = "SELECT * FROM ordercart WHERE orderId = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    carts.add(extractFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving cart by orderId", e);
        }
        return carts;
    }

    // Delete a cart item by ID
    public static boolean deleteOrderCart(int id) {
        String query = "DELETE FROM ordercart WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting cart item", e);
        }
    }

    // Delete all items for a given order
    public static boolean deleteCartsByOrderId(int orderId) {
        String query = "DELETE FROM ordercart WHERE orderId = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting cart items by orderId", e);
        }
    }

    // Helper to map ResultSet to OrderCartModel
    private static OrderCartModel extractFromResultSet(ResultSet rs) throws SQLException {
        return new OrderCartModel(
                rs.getInt("id"),
                rs.getInt("orderId"),
                rs.getString("bookName"),
                rs.getString("authorName"),
                rs.getInt("quantity"),
                rs.getInt("price")
        );
    }
}
