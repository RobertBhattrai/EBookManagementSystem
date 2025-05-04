package dao;

import models.OrderModel;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
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

    // Add new order
    public static int addOrder(OrderModel order) {
        String query = "INSERT INTO orderlist (userId, price, paymentMethod, status, name, phone, address1, address2, landmark, city, pincode) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            setOrderParameters(ps, order);
            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error inserting order", e);
        }
        return -1;
    }

    // Get all orders
    public static List<OrderModel> getAllOrders() {
        List<OrderModel> orders = new ArrayList<>();
        String query = "SELECT * FROM orderlist";

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                OrderModel order = new OrderModel();
                order.setOrderId(rs.getInt("orderId"));
                order.setUserId(rs.getInt("userId"));
                order.setTime(rs.getTimestamp("time"));
                order.setPrice(rs.getInt("price"));
                order.setPaymentMethod(rs.getString("paymentMethod"));
                order.setStatus(rs.getString("status"));
                order.setName(rs.getString("name"));
                order.setPhone(rs.getString("phone"));
                order.setAddress1(rs.getString("address1"));
                order.setAddress2(rs.getString("address2"));
                order.setLandmark(rs.getString("landmark"));
                order.setCity(rs.getString("city"));
                order.setPincode(rs.getString("pincode"));

                orders.add(order);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving orders", e);
        }
        return orders;
    }

    // Get all orders with sorting capability
    public static List<OrderModel> getAllOrders(String sortBy, String sortOrder) {
        List<OrderModel> orders = new ArrayList<>();
        String query = "SELECT * FROM orderlist";

        if (sortBy != null && !sortBy.isEmpty()) {
            query += " ORDER BY " + sortBy + " " + (sortOrder != null ? sortOrder : "ASC");
        } else {
            query += " ORDER BY time DESC";
        }

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving orders", e);
        }
        return orders;
    }

    // Get orders by status
    public static List<OrderModel> getOrdersByStatus(String status) {
        List<OrderModel> orders = new ArrayList<>();
        String query = "SELECT * FROM orderlist WHERE status = ? ORDER BY time DESC";

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    orders.add(extractOrderFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving orders by status", e);
        }
        return orders;
    }

    // Search orders by various fields
    public static List<OrderModel> searchOrders(String searchTerm) {
        List<OrderModel> orders = new ArrayList<>();
        String query = "SELECT * FROM orderlist WHERE " +
                "orderId LIKE ? OR " +
                "name LIKE ? OR " +
                "phone LIKE ? OR " +
                "city LIKE ? OR " +
                "pincode LIKE ? " +
                "ORDER BY time DESC";

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            String likeTerm = "%" + searchTerm + "%";
            for (int i = 1; i <= 5; i++) {
                ps.setString(i, likeTerm);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    orders.add(extractOrderFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error searching orders", e);
        }
        return orders;
    }

    // Get orders by user ID
    public static List<OrderModel> getOrdersByUser(int userId) {
        List<OrderModel> orders = new ArrayList<>();
        String query = "SELECT * FROM orderlist WHERE userId = ? ORDER BY time DESC";

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    orders.add(extractOrderFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving user orders", e);
        }
        return orders;
    }

    // Get single order by ID
    public static OrderModel getOrderById(int orderId) {
        String query = "SELECT * FROM orderlist WHERE orderId = ?";

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractOrderFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving order by ID", e);
        }
        return null;
    }

    // Update order status
    public static boolean updateOrderStatus(int orderId, String status) {
        String query = "UPDATE orderlist SET status = ? WHERE orderId = ?";

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating order status", e);
        }
    }

    // Delete order by ID
    public static boolean deleteOrder(int orderId) {
        String query = "DELETE FROM orderlist WHERE orderId = ?";

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting order", e);
        }
    }

    // Helper method to set order parameters in PreparedStatement
    private static void setOrderParameters(PreparedStatement ps, OrderModel order) throws SQLException {
        ps.setInt(1, order.getUserId());
        ps.setInt(2, order.getPrice());
        ps.setString(3, order.getPaymentMethod());
        ps.setString(4, order.getStatus());
        ps.setString(5, order.getName());
        ps.setString(6, order.getPhone());
        ps.setString(7, order.getAddress1());
        ps.setString(8, order.getAddress2());
        ps.setString(9, order.getLandmark());
        ps.setString(10, order.getCity());
        ps.setString(11, order.getPincode());
    }

    // Helper method to extract order from ResultSet
    private static OrderModel extractOrderFromResultSet(ResultSet rs) throws SQLException {
        OrderModel order = new OrderModel();
        order.setOrderId(rs.getInt("orderId"));
        order.setUserId(rs.getInt("userId"));
        order.setTime(rs.getTimestamp("time"));
        order.setPrice(rs.getInt("price"));
        order.setPaymentMethod(rs.getString("paymentMethod"));
        order.setStatus(rs.getString("status"));
        order.setName(rs.getString("name"));
        order.setPhone(rs.getString("phone"));
        order.setAddress1(rs.getString("address1"));
        order.setAddress2(rs.getString("address2"));
        order.setLandmark(rs.getString("landmark"));
        order.setCity(rs.getString("city"));
        order.setPincode(rs.getString("pincode"));
        return order;
    }
}