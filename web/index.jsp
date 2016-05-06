<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : index
    Created on : May 3, 2016, 9:53:19 PM
    Author     : Austen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="bootstrap-3.3.6-dist/css/bootstrap.css" />
        <link rel="stylesheet" href="bootstrap-3.3.6-dist/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/stylesheet.css" />
        <title>JSP Page</title>
    </head>
    <body>
        <div class="top">
            <div id="photo">
                <a href="index.jsp">
                    <img src="images/logodesign.jpg" id="logo" alt="Snap Exchange">
                </a>
            </div>
            <div id="searchBar">
                Search: <input type="text" name="search" value="" size="100" />
                <button type="button" class="btn" id="searchingBtn">
                    <snap class="glyphicon glyphicon-search"></snap>
                </button>
            </div>
            <div id="cart">
                <form name="shoppingcart" action="WEB-INF/view/cart.jsp">
                    <button type="button" class="btn">
                        <span class="glyphicon glyphicon-shopping-cart" type="submit" ></span> View Cart
                    </button>
                </form>
            </div>
            <div class="menu">
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="category.jsp">Categories</a></li>
                    <li><a href="upload.jsp">Sell Item</a></li>
                    <li><a href="contact.jsp">Contact Us</a></li>
                    <li><a href="account.jsp">My Account</a></li>
                </ul>
            </div>
        </div>
        <div class="left">
            <h4>Sell Your Own Item!</h4>
            <br>
            <br>
            <p>Click <a href="upload.jsp">here</a> if you would like to upload your own item to sell to others near you!</p>
        </div>
        <div class="main">

            <div class="container">
                <div class="row">
                    <div class="col-md-10">
            <h3>Most Recent Items Posted</h3>
            <table class="table" id="t2">
                <tbody>
                <%
                    Connection conn = null;
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/snaplist", "root", "");
                    PreparedStatement state = conn.prepareStatement("SELECT * FROM items ORDER BY last_update DESC LIMIT 15;");
                    ResultSet result = state.executeQuery();
                    int i=0;
                    while(result.next()){
                        if(i == 0){
                %>
                <tr>
                    <td class="col-md-3" align="center" id="shadow">
                        <img src="GettingImage?img_id=<%=result.getString("item_id")%>" width="200" height="200" align="center"/>
                        <p><strong><%=result.getString("title")%></strong></p>
                        <p><%=result.getString("price")%></p>
                    </td>
                <%
                            i++;
                        }
                        else if(i%3 == 0){
                %>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>


                <%      i=0;
                        }
                        else{
                %>
                    <td class="col-md-1"></td>
                    <td class="col-md-3" align="center" id="shadow">
                        <img src="GettingImage?img_id=<%=result.getString("item_id")%>" width="200" height="200" align="center"/>
                        <p><strong><%=result.getString("title")%></strong></p>
                        <p>$ <%=result.getString("price")%></p>
                    </td>
                <%          i++;
                        } 
                        //else { %>

                <% //i=0; }
                } %>
            </tr>
                </tbody>
            </table>
        </div></div></div></div>

        <div class="right">
            <h4>Popular Categories</h4>

            <%
                    PreparedStatement ps = conn.prepareStatement("SELECT category_id, category.name, COUNT(category_id) as total from items JOIN category on id=category_id GROUP BY category_id ORDER BY total desc;");
                    ResultSet rs = ps.executeQuery();
                    while(rs.next()){
                        %>
                        <a><%=rs.getString("name")%>(<%=rs.getString("total")%>)</a>
                        <br>
                        <br>
                        <%
                    }
                    %>

        </div>

    </body>
</html>
