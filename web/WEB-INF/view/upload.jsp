<%-- 
    Document   : upload
    Created on : May 5, 2016, 12:40:26 AM
    Author     : Austen
--%>

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
            <h3>Add Your Own Item</h3><br>
        <div class="container">
        <div class="row">
        <div class ="col-md-10">
        <center>
            <form action="uploadServlet" method="POST" enctype="multipart/form-data">
                <table border="0">
                    <tbody>
                    <tr>
                        <td>Item: </td>
                        <td><input type="text" name="title" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Description: </td>
                        <td><textarea name="description" rows="10" cols="50">
                            </textarea></td>
                    </tr>
                    <tr>
                        <td>Item Photo: </td>
                        <td><input type="file" name="photo" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Price: $</td>
                        <td><input type="text" name="price" value="" size="10" /></td>
                    </tr>
                    <tr>
                        <td>Category: </td>
                        <td><select name="category">
                                <option>Casual Shoes</option>
                                <option>Dress Shoes</option>
                                <option>Basketball Shoes</option>
                                <option>Sportswear</option>
                                <option>T-shirts</option>
                                <option>Long Sleeve Shirts</option>
                                <option>Dress Shirts</option>
                                <option>Dress Pants</option>
                                <option>Casual Pants</option>
                                <option>Shorts</option>
                                <option>Winter Jackets/Pants</option>
                                <option>Hats</option>
                                <option>Jackets</option>
                                <option>Accessories</option>
                                <option>Electronics</option>
                                <option>Bikes</option>
                                <option>Furniture</option>
                                <option>Electronic Accessories</option>
                                <option>House Hold Items</option>
                                <option>Cars</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" value="Upload" />
                        </td>
                    </tr>
                    <tr><td></td></tr>
                    </tbody>
                </table>
            </form>
        </center>
        </div></div></div></div>
        <div class="right">
            <h4>Recently Posted Items</h4>
            <br>
            <%  
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/snaplist", "root", "");
                Statement st = conn.createStatement();
                ResultSet result = st.executeQuery("SELECT * FROM items WHERE item_id NOT IN (SELECT item_id FROM purchased_items) ORDER BY last_update DESC LIMIT 5;");
                while (result.next()){
                    %>
                    <a href="<%=request.getContextPath()%>/item?id=<%=result.getString("item_id")%>" id="noblue"><img src="GettingImage?img_id=<%=result.getString("item_id")%>" width="100" height="100" />
                        <h6><strong><%=result.getString("title")%></strong></h6>
                        <p>$ <%=result.getString("price")%></p>
                    </a>
                    <%
                }
            %>
            <style>
                .right{
                    bottom:auto;
                }
            </style>
        </div>
    </body>
</html>
