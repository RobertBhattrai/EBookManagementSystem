package models;

public class CartItem {
    private BookModel book;
    private int quantity;

    public CartItem(BookModel book, int quantity) {
        this.book = book;
        this.quantity = quantity;
    }

    public BookModel getBook() {
        return book;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
