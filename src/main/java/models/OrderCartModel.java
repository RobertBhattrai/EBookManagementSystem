package models;

public class OrderCartModel {
    private int id;
    private int orderId;
    private String bookName;
    private String authorName;
    private int quantity;
    private double price;

    // No-arg constructor
    public OrderCartModel() {}

    // Constructor without id (used before insertion)
    public OrderCartModel(int orderId, String bookName, String authorName, int quantity, double price) {
        this.id = 0;
        this.orderId = orderId;
        this.bookName = bookName;
        this.authorName = authorName;
        this.quantity = quantity;
        this.price = price;
    }

    // Full constructor with id (used when fetching from DB)
    public OrderCartModel(int id, int orderId, String bookName, String authorName, int quantity, double price) {
        this.id = id;
        this.orderId = orderId;
        this.bookName = bookName;
        this.authorName = authorName;
        this.quantity = quantity;
        this.price = price;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public String getBookName() { return bookName; }
    public void setBookName(String bookName) { this.bookName = bookName; }

    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}
