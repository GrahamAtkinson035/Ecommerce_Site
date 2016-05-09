/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import classes.Item;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import javax.servlet.jsp.JspWriter;

/**
 *
 * @author Austen
 */
public class ShoppingCart {
    public ArrayList<Item> itemlist = new ArrayList<Item>();  // list of Items in the cart
    int numberOfItems;
    public int total;
    
    public ShoppingCart() {
        itemlist = new ArrayList<Item>();
        numberOfItems = 0;
        total = 0;

    }
    
    public String[] getItems(){
        String[] s = new String[itemlist.size()];
        for(int i=0; i<itemlist.size(); i++){
            Item currItem = itemlist.get(i);
            s[i] = currItem.id;
        }
        return s;
    }

    public void empty() {
        itemlist.clear();
        numberOfItems = 0;
        total = 0;
    }
    //
    // add an item to the cart
    // if its there already, just update the upc
    //   

    public void add(Item anitem) {

        for (int i = 0; i < itemlist.size(); i++) {
            Item item = itemlist.get(i);
            if (anitem.name.equals(item.name)) // already in the cart?
            {
                item.quantity += anitem.quantity; // yes, just update the quantity
                numberOfItems += item.quantity;
                return;
            }
        }
        itemlist.add(anitem); // no, add it as a new item
        numberOfItems += anitem.quantity;
    }

   //
    // Display the current contents of the cart as an html table
    // 
    public void display(JspWriter out) {
        try {
            java.text.DecimalFormat currency = new java.text.DecimalFormat("$ #,###,##0.00");
      //
            // start the table and output the header row
            //
            out.println("<div class='main'>");
            out.println("<h3>Item Just Added To Your Cart</h3>");
            out.println("<div class='container'><div class='row'><div class='col-md-10'>");
            out.println("<table class='table'");
            out.println("<tr><th class='text-center'></th><th class='text-center'>Name</th><th class='text-center'>Price</th><th class='text-center'>Quantity</th><th class='text-center'>Total</th></tr>");

            double total = 0;
      // 
            // output one item at a time from the cart, one item to a row table
            //
            for (int i = 0; i < itemlist.size(); i++) {
                Item item = (Item) itemlist.get(i);
                out.println("<tr><td align='center'><img src='GettingImage?img_id=" + item.id + "' width='100' height='100' /></td>"
                        + "<td align=center>" + item.name + "</td>"
                        + "<td align=center>" + currency.format(item.price) + "</td>"
                        + "<td align=center>" + item.quantity + "</td>"
                        + "<td align=center>" + currency.format(item.price * item.quantity) + "</td></tr>");
                total += item.price * item.quantity;
            }
      //
            // add summary information (total, tax, grand total)
            //
            out.println("</table>");
            out.println("<a href='/EcommerceSite/index.jsp' id='noblue'><input name='redirect' value='Continue Shopping' type='submit'/></a></div></div></div></div>");

        } catch (IOException ex) {
            // exception was thrown by the out object, so we can't really report it to the client
            System.err.println(ex.toString());  // just send the exception to the error log
        }
    }
    
    public void displayAll(JspWriter out){
        try {
            java.text.DecimalFormat currency = new java.text.DecimalFormat("$ #,###,##0.00");
            //
            // start the table and output the header row
            //
            out.println("<div class='main'>");
            out.println("<h3>Cart contents</h3>");
            out.println("<div class='container'><div class='row'><div class='col-md-10'>");
            out.println("<table class='table'");
            out.println("<tr><th class='text-center'></th><th class='text-center'>Name</th><th class='text-center'>Price</th><th class='text-center'>Quantity</th><th class='text-center'>Total</th></tr>");

            double total = 0;
            // 
            // output one item at a time from the cart, one item to a row table
            //
            for (int i = 0; i < itemlist.size(); i++) {
                Item item = (Item) itemlist.get(i);
                out.println("<tr><td align='center'><img src='GettingImage?img_id=" + item.id + "' width='100' height='100' /></td>"
                        + "<td align=center>" + item.name + "</td>"
                        + "<td align=center>" + currency.format(item.price) + "</td>"
                        + "<td align=center>" + item.quantity + "</td>"
                        + "<td align=center>" + currency.format(item.price * item.quantity) + "</td></tr>");
                total += item.price * item.quantity;
            }
            out.println("<tr><td colspan = 4>Total purchase</td>");
            out.println("<td align=center>" + currency.format(total) + "</td></tr>");
            out.println("<tr><td colspan = 4>Sales tax @8%</td>"
                    + "<td align=center>" + currency.format(total * .08) + "</td></tr>");
            out.println("<tr><td colspan = 4><strong>Amount due</strong></td>"
                    + "<td align=center>" + currency.format(total * 1.08) + "</td></tr>");
            out.println("</table></div></div></div></div>");
        
        } catch (IOException ex) {
            // exception was thrown by the out object, so we can't really report it to the client
            System.err.println(ex.toString());  // just send the exception to the error log
        }
    }
    
    public void showTotal(JspWriter out){
        try{
        java.text.DecimalFormat currency = new java.text.DecimalFormat("$ #,###,##0.00");
        out.println("<table class='table'");
        out.println("<tr><td colspan = 4>Total purchase</td>");
        out.println("<td align=center>" + currency.format(total) + "</td></tr>");
        out.println("<tr><td colspan = 4>Sales tax @8%</td>"
                + "<td align=center>" + currency.format(total * .08) + "</td></tr>");
        out.println("<tr><td colspan = 4><strong>Amount due</strong></td>"
                + "<td align=center>" + currency.format(total * 1.08) + "</td></tr>");
        out.println("</table></div></div></div></div>");
        } catch (IOException ex) {
            // exception was thrown by the out object, so we can't really report it to the client
            System.err.println(ex.toString());  // just send the exception to the error log
        }
    }
}
