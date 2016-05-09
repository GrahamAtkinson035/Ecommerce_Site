<%-- 
    Document   : addItem
    Created on : May 8, 2016, 7:16:26 PM
    Author     : Austen
--%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="classes.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%
         //
            // set the session's inactive interval
            //
            session.setMaxInactiveInterval(1800); // 30 minutes

        //
            // get the action
            //
            String action = request.getParameter("action");
            if (action.equals("Add To Cart")) // process add item 
            {
          //
                // first get the data from the html form
                //     
                try {
                    String id = request.getParameter("id");
                    String name = request.getParameter("name");
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    double price = Double.parseDouble(request.getParameter("price"));
         //
                    // create an item to add to the cart
                    //
                    Item item = new Item(id, name, quantity, price);
         //
                    // now access the cart and add the item
                    //
                    synchronized (session) // lock session protect this from multiple threads
                    {
                        ShoppingCart cart = (ShoppingCart) session.getAttribute("Cart");
                        if (cart == null) // new sesssion, just create a cart
                        {
                            cart = new ShoppingCart();
                            session.setAttribute("Cart", cart);
                        }
                        cart.add(item); // cart uses ArrayList which is not thread safe so we locked
                        cart.display(out); // tell the cart to send its contents to the browser
                    } // end synchronization lock
                } catch (Exception ex) {
                    out.println(ex.toString()); // show the exception for now
                }
            } else if (action.equals("Empty")) {
                synchronized (session) // lock session protect this from multiple threads
                {
                    ShoppingCart cart = (ShoppingCart) session.getAttribute("Cart");
                    if (cart == null) // new sesssion, just create a cart
                    {
                        cart = new ShoppingCart();
                        session.setAttribute("Cart", cart);
                    }
                    cart.empty(); // cart uses ArrayList which is not thread safe so we locked
                    cart.display(out); // tell the cart to send its contents to the browser
                } // end synchronization lock  
            }
        %>
        <div class="right">
            <h4>Recently Posted Items</h4>
            <br>
            <%
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/snaplist", "root", "");
                Statement st = conn.createStatement();
                ResultSet result = st.executeQuery("SELECT * FROM items ORDER BY last_update DESC LIMIT 5;");
                while (result.next()){
                    %>
                    <a href="<%=request.getContextPath()%>/item?id=<%=result.getString("item_id")%>" id="noblue"><img src="GettingImage?img_id=<%=result.getString("item_id")%>" width="100" height="100" />
                        <h6><strong><%=result.getString("title")%></strong></h6>
                        <p>$ <%=result.getString("price")%></p>
                    </a>
                    <%
                }
            %>
        </div>
    </body>
</html>
