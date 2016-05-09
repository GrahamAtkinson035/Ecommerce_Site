<%-- 
    Document   : confirmorder
    Created on : May 3, 2016, 9:54:43 PM
    Author     : Austen
--%>

<%@page import="java.util.Random"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="classes.Item"%>
<%@page import="classes.ShoppingCart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String name = request.getParameter("firstName") + " " + request.getParameter("lastName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String location = request.getParameter("city") + ", " + request.getParameter("state") + " " + request.getParameter("zipcode");
            String ccNum = request.getParameter("ccNum");
            Random random = new Random();
            int conf_num = random.nextInt(999999999);
        synchronized (session){
            ShoppingCart cart = (ShoppingCart) session.getAttribute("Cart");
            if (cart == null) // new sesssion, just create a cart
            {
                cart = new ShoppingCart();
                session.setAttribute("Cart", cart);
            }
            String[] item_ids = cart.getItems();
            
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/snaplist", "root", "");
            PreparedStatement state = conn.prepareStatement("INSERT INTO customer (name, email, phone, address, location, cc_number) VALUES (?,?,?,?,?,?);");
            state.setString(1, name);
            state.setString(2, email);
            state.setString(3, phone);
            state.setString(4, address);
            state.setString(5, location);
            state.setString(6, ccNum);
            state.execute();
            
            PreparedStatement ps = conn.prepareStatement("INSERT INTO `order` (total, confirmation_number, customer_id) VALUES (?, ?, (SELECT customer_id from customer WHERE name=?));");
            ps.setInt(1, cart.total);
            ps.setInt(2, conf_num);
            ps.setString(3, name);
            ps.execute();
            
            ArrayList<Item> items = cart.itemlist;
            for(int i=0; i<items.size(); i++){
                Item itm = items.get(i);
                PreparedStatement p = conn.prepareStatement("insert into ordered_item (order_id, item_id, quantity) VALUES ((SELECT order_id from `order` JOIN customer on `order`.customer_id=customer.customer_id WHERE name=?),?,?);");
                p.setString(1, name);
                p.setString(2, itm.id);
                p.setInt(3, itm.quantity);
                p.execute();
            }
        }        
        %>
        <div class="main">
            <h4>Confirmed!</h4>
            <p>Congratulations! You're order has been placed. Your confirmation number is <%= conf_num %>. This number will also be sent to your email, and your order will be processed as soon as possible, enjoy!</p>
        </div>
    </body>
</html>
