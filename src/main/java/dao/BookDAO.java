package dao;


import models.BookModel;
import models.UserModel;
import utils.PasswordHash;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BookDAO {
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
    public static int addBook(BookModel book) {
        String query = "INSERT INTO book (bookName, authorName, price, bookCategory, available, photo) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, book.getBookName());
            ps.setString(2, book.getAuthor());
            ps.setDouble(3, book.getPrice());
            ps.setString(4, book.getCategory());
            ps.setString(5, book.getStatus());
            ps.setString(6, book.getPhoto());

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
    // Get All Books
    public static List<BookModel> getAllBooks() {
        List<BookModel> books = new ArrayList<>();
        String query = "SELECT * FROM book";

        try (Connection connection = getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                BookModel book = new BookModel();
                book.setBookId(rs.getInt("bookId"));
                book.setBookName(rs.getString("bookName"));
                book.setAuthor(rs.getString("authorName"));
                book.setPrice(rs.getDouble("price"));
                book.setCategory(rs.getString("bookCategory"));
                book.setStatus(rs.getString("available"));
                book.setPhoto(rs.getString("photo"));
                books.add(book);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving books", e);
        }
        return books;
    }

    // Get Book by ID
    public static BookModel getBookById(int bookId) {
        String query = "SELECT * FROM book WHERE bookId = ?";

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, bookId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BookModel book = new BookModel();
                    book.setBookId(rs.getInt("bookId"));
                    book.setBookName(rs.getString("bookName"));
                    book.setAuthor(rs.getString("authorName"));
                    book.setPrice(rs.getDouble("price"));
                    book.setCategory(rs.getString("bookCategory"));
                    book.setStatus(rs.getString("available"));
                    book.setPhoto(rs.getString("photo"));
                    return book;
                }
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving book", e);
        }
    }

    // Update Book
    public static boolean updateBook(BookModel book) {
        String query = "UPDATE book SET bookName = ?, authorName = ?, price = ?, bookCategory = ?, available = ?, photo = ? WHERE bookId = ?";

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, book.getBookName());
            ps.setString(2, book.getAuthor());
            ps.setDouble(3, book.getPrice());
            ps.setString(4, book.getCategory());
            ps.setString(5, book.getStatus());
            ps.setString(6, book.getPhoto());
            ps.setInt(7, book.getBookId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating book", e);
        }
    }

    // Delete Book
    public static boolean deleteBook(int bookId) {
        String query = "DELETE FROM book WHERE bookId = ?";

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, bookId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting book", e);
        }
    }

    // Search Books
    public static List<BookModel> searchBooks(String keyword) {
        List<BookModel> books = new ArrayList<>();
        String query = "SELECT * FROM book WHERE bookName LIKE ? OR authorName LIKE ?";

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BookModel book = new BookModel();
                    book.setBookId(rs.getInt("bookId"));
                    book.setBookName(rs.getString("bookName"));
                    book.setAuthor(rs.getString("authorName"));
                    book.setPrice(rs.getDouble("price"));
                    book.setCategory(rs.getString("bookCategory"));
                    book.setStatus(rs.getString("available"));
                    book.setPhoto(rs.getString("photo"));
                    books.add(book);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error searching books", e);
        }
        return books;
    }
}
