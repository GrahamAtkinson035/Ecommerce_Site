<%-- 
    Document   : cart
    Created on : May 3, 2016, 9:54:07 PM
    Author     : Austen
--%>

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
            synchronized (session){
                ShoppingCart cart = (ShoppingCart)session.getAttribute("Cart");
                if (cart == null) // new sesssion, just create a cart
                    {
                        cart = new ShoppingCart();
                        session.setAttribute("Cart", cart);
                    }
                cart.displayAll(out);
            }
        %>
        <div class="right">
        <a href="<%=request.getContextPath()%>/checkout"><input type="submit" value="Checkout" name="checkout" />
        </div>
    </body>
</html>
