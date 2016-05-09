<%-- 
    Document   : checkout
    Created on : May 3, 2016, 9:54:17 PM
    Author     : Austen
--%>

<%@page import="classes.ShoppingCart"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="main">
            <h4>Customer Information</h4><br>
            <form name="checkout" action="<%=request.getContextPath()%>/purchase" method="POST">
                First Name: <input type="text" name="firstName" value="" size="100" /><br><br>
                Last Name: <input type="text" name="lastName" value="" size="100" /><br><br>
                E-mail: <input type="text" name="email" value="" size="75" /><br><br>
                Phone: <input type="text" name="phone" value="" size="50" /><br><br>
                Address: <input type="text" name="address" value="" size="100" /><br><br>
                City: <input type="text" name="city" value="" size="50" /><br><br>
                State: <input type="text" name="state" value="" size="10" /><br><br>
                Zipcode: <input type="text" name="zipcode" value="" size="20" /><br><br>
                Credit Card Number: <input type="text" name="ccNum" value="" size="100" /><br>
                <input type="submit" value="Complete Order" name="order" /><br><br>
            </form>
        </div>
        <div class="right">
            <h4>Total</h4>
            <%
                synchronized (session) // lock session protect this from multiple threads
                {
                    ShoppingCart cart = (ShoppingCart) session.getAttribute("Cart");
                    if (cart == null) // new sesssion, just create a cart
                    {
                        cart = new ShoppingCart();
                        session.setAttribute("Cart", cart);
                    }
                    cart.showTotal(out);
                }
            %>
        </div>
    </body>
</html>
