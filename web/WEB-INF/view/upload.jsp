<%-- 
    Document   : upload
    Created on : May 5, 2016, 12:40:26 AM
    Author     : Austen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <center>
            <form action="uploadServlet" method="POST" enctype="multipart/form-data">
                <table border="0">
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
                </table>
            </form>
        </center>
    </body>
</html>
