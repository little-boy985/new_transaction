package com.example.thing.entity;

public class Item {
    private int id;
    private String name;
    private String description;
    private double price;
    private String contact;
    private int userId;

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}