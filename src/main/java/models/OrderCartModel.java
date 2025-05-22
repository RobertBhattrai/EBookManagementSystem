//package models;
//
//public class OrderCartModel {
//    private int id;
//    private int orderId;
//    private String bookName;
//    private String authorName;
//    private int quantity;
//    private double price;
//
//    // No-arg constructor
//    public OrderCartModel() {}
//
//    // Constructor without id (used before insertion)
//    public OrderCartModel(int orderId, String bookName, String authorName, int quantity, double price) {
//        this.id = 0;
//        this.orderId = orderId;
//        this.bookName = bookName;
//        this.authorName = authorName;
//        this.quantity = quantity;
//        this.price = price;
//    }
//
//    // Full constructor with id (used when fetching from DB)
//    public OrderCartModel(int id, int orderId, String bookName, String authorName, int quantity, double price) {
//        this.id = id;
//        this.orderId = orderId;
//        this.bookName = bookName;
//        this.authorName = authorName;
//        this.quantity = quantity;
//        this.price = price;
//    }
//
//    // Getters and setters
//    public int getId() { return id; }
//    public void setId(int id) { this.id = id; }
//
//    public int getOrderId() { return orderId; }
//    public void setOrderId(int orderId) { this.orderId = orderId; }
//
//    public String getBookName() { return bookName; }
//    public void setBookName(String bookName) { this.bookName = bookName; }
//
//    public String getAuthorName() { return authorName; }
//    public void setAuthorName(String authorName) { this.authorName = authorName; }
//
//    public int getQuantity() { return quantity; }
//    public void setQuantity(int quantity) { this.quantity = quantity; }
//
//    public double getPrice() { return price; }
//    public void setPrice(double price) { this.price = price; }
//}



package models;

public class OrderCartModel {
    private int id;
    private int orderId;
    private int bookId;  // Add bookId field
    private String bookName;
    private String authorName;
    private int quantity;
    private double price;
    private BookModel book;

    // Constructors
    public OrderCartModel() {}

    public OrderCartModel(int orderId, int bookId, String bookName, String authorName,
                          int quantity, double price) {
        this.orderId = orderId;
        this.bookId = bookId;
        this.bookName = bookName;
        this.authorName = authorName;
        this.quantity = quantity;
        this.price = price;
    }

    public OrderCartModel(int id, int orderId, int bookId, String bookName,
                          String authorName, int quantity, double price) {
        this(orderId, bookId, bookName, authorName, quantity, price);
        this.id = id;
    }

    // Safe getter for book
    public BookModel getBook() {
        BookModel book = new BookModel();
        if (book == null) {
            // Optionally load the book here if needed
            throw new IllegalStateException("Book reference not initialized");
        }
        return book;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    public String getBookName() { return bookName; }
    public void setBookName(String bookName) { this.bookName = bookName; }
    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public void setBook(BookModel book) {
        this.book = book;
        if (book != null) {
            this.bookId = book.getBookId();
        }
    }
}