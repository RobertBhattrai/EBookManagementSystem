package model;

public class Cart {
    private int cartId;
    private int userId;
    private int bookId;
    private int quantity;
    private double totalPrice;

    public Cart(int cartId, int userId, int bookId, int quantity, double totalPrice) {
        this.cartId = cartId;
        this.userId = userId;
        this.bookId = bookId;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
    }

    // Getters and Setters
    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
}

