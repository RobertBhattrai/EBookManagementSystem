package models;

public class Book {
    private int bookId;
    private String bookName;
    private String author;
    private double price;
    private String category;
    private String status;
    private String photo;
    private int uploadedBy; // FK to User

    public Book(int bookId, String bookName, double price, String author, String category, String status, String photo, int uploadedBy) {
        this.bookId = bookId;
        this.bookName = bookName;
        this.price = price;
        this.author = author;
        this.category = category;
        this.status = status;
        this.photo = photo;
        this.uploadedBy = uploadedBy;
    }

    // Getters and Setters
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    public String getBookName() { return bookName; }
    public void setBookName(String bookName) { this.bookName = bookName; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPhoto() { return photo; }
    public void setPhoto(String photo) { this.photo = photo; }

    public int getUploadedBy() { return uploadedBy; }
    public void setUploadedBy(int uploadedBy) { this.uploadedBy = uploadedBy; }
}

