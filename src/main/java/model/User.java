package model;

public class User {
    private int userId;
    private String name;
    private String email;
    private String contact;
    private String password;
    private String address;
    private String landmark;
    private String city;
    private String state;
    private String role;

    public User(int userId, String name, String email, String contact, String password, String address, String landmark, String city, String state, String role) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.contact = contact;
        this.password = password;
        this.address = address;
        this.landmark = landmark;
        this.city = city;
        this.state = state;
        this.role = role;
    }

    public User(String name, int userId, String email, String contact, String password, String address, String landmark, String city, String state, String role) {
        this.name = name;
        this.userId = userId;
        this.email = email;
        this.contact = contact;
        this.password = password;
        this.address = address;
        this.landmark = landmark;
        this.city = city;
        this.state = state;
        this.role = role;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getLandmark() { return landmark; }
    public void setLandmark(String landmark) { this.landmark = landmark; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}

