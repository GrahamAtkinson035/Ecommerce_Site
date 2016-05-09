<%-- 
    Document   : header
    Created on : May 6, 2016, 12:35:33 PM
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
                <form name="searchBar" action="<%=request.getContextPath()%>/search" method="POST">
                    Search: <input type="text" name="search" value="" size="100" />
                    <button type="submit" class="btn" id="searchingBtn">
                            <span class="glyphicon glyphicon-search"></span>
                        </button>
                </form>
            </div>
            <div id="cart">
                <a href="<%=request.getContextPath()%>/viewCart" id="noblue"><button type="button" class="btn" >
                    <span class="glyphicon glyphicon-shopping-cart" ></span> View Cart
                    </button></a>
            </div>
            <div class="menu">
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="<%=request.getContextPath()%>/category?c_id=all">Categories</a></li>
                    <li><a href="<%=request.getContextPath()%>/upload">Sell Item</a></li>
                    <li><a href="<%=request.getContextPath()%>/contact">Contact Us</a></li>
                    <li><a href="<%=request.getContextPath()%>/account">My Account</a></li>
                </ul>
            </div>
        </div>
        <div class="left">
            <h4>Sell Your Own Item!</h4>
            <br>
            <br>
            <p>Click <a href="<%=request.getContextPath()%>/upload">here</a> if you would like to upload your own item to sell to others near you!</p>
        </div>
