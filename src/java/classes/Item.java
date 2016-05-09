/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

/**
 *
 * @author Austen
 */
public class Item {
    public String id = "";
    String name = "";
    public int quantity = 0;
    double price = 0;
    
    public Item()
    {
        
    }
    
    public Item(String id, String name, int quantity, double price)
    {
     this.id = id;
     this.name = name;
     this.quantity = quantity;
     this.price = price;
    }
}
