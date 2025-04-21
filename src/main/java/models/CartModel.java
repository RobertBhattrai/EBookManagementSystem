/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

/**
 *
 * @author chetan
 */
public class CartModel {

    private int bookId;
    private String bookName;
    private String authorName;
    private String photo;
    private int price;
    private int quantity;

    public CartModel(int bookId, String bookName, String authorName, String photo, int price, int quantity) {
        this.bookId = bookId;
        this.bookName = bookName;
        this.authorName = authorName;
        this.photo = photo;
        this.price = price;
        this.quantity = quantity;
    }

    public CartModel() {}

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }



}
