<%-- 
    Document   : category
    Created on : May 4, 2016, 1:23:34 AM
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
            <div class="container">
                <div class="row">
                    <div class="col-md-10">
                        
                        <table class="table">
                            <tbody>
        <%
            String c_id = request.getParameter("c_id");
            Connection conn = null;
            Class.forName("com.mysql.jdbc.Driver");
            conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/snaplist", "root", "");
            PreparedStatement state;
            
            if(c_id.equals("all")){
                state = conn.prepareStatement("SELECT category_id, category.name, COUNT(category_id) as total from items JOIN category on id=category_id GROUP BY category_id ORDER BY total desc;");
                %>
                            <h3>Categories</h3>
                <%
                    
            }
            else{
                state = conn.prepareStatement("SELECT * FROM items WHERE category_id=? AND item_id NOT IN (SELECT item_id FROM purchased_items)");
                state.setString(1, c_id);
                PreparedStatement ps = conn.prepareStatement("SELECT name FROM category WHERE id=?");
                ps.setString(1, c_id);
                ResultSet r = ps.executeQuery();
                while(r.next()){
                %>
                <h3>${selectedCategory.name} Items</h3>
                <%
                }
            }

            ResultSet rs = state.executeQuery();
            int i=0;
            while (rs.next()){
                if(c_id.equals("all")){
                    if(i==0){
                        %>
                        <tr>
                            <td>
                                <a href="<%=request.getContextPath()%>/category?c_id=<%=rs.getString("category_id")%>">
                                    <h4><%=rs.getString("name")%> (<%=rs.getString("total")%>)</h4>
                                </a>
                            </td>
                            <%
                            i++;
                    }
                    else if(i%2 == 0){
                        %>
                        <td>
                            <a href="<%=request.getContextPath()%>/category?c_id=<%=rs.getString("category_id")%>" >
                                <h4><%=rs.getString("name")%> (<%=rs.getString("total")%>)</h4>
                            </a>
                        </td>
                        </tr>
                        <tr>
                            <td></td><td></td><td></td><td></td>
                        </tr>
                        <%
                        i=0;
                    }
                    else{
                        %>
                        <td>
                            <a href="<%=request.getContextPath()%>/category?c_id=<%=rs.getString("category_id")%>">
                                <h4><%=rs.getString("name")%> (<%=rs.getString("total")%>)</h4>
                            </a>
                        </td>
                        <%
                        i++;
                    }
                }
                else{
                    if (i == 0) {
                        %>
                <tr>
                    <td class="col-md-3" align="center" id="shadow">
                        <a href="<%=request.getContextPath()%>/item?id=<%=rs.getString("item_id")%>" id="noblue"><img src="GettingImage?img_id=<%=rs.getString("item_id")%>" width="200" height="150"/>
                            <h4><strong><%=rs.getString("title")%></strong></h4>
                        <p>$ <%=rs.getString("price")%></p></a>
                    </td>
                        <%
                            i++;
                    }
                    else if (i % 2 == 0) {
                        %>
                        <td class="col-md-1"></td>
                        <td class="col-md-3" align="center" id="shadow">
                            <a href="<%=request.getContextPath()%>/item?id=<%=rs.getString("item_id")%>" id="noblue"><img src="GettingImage?img_id=<%=rs.getString("item_id")%>" width="200" height="150"/>
                                <h4><strong><%=rs.getString("title")%></strong></h4>
                                <p>$ <%=rs.getString("price")%></p>
                            </a>
                        </td>
                </tr>
                <tr>
                    <td></td><td></td><td></td><td></td><td></td>
                </tr>


                        <%      i = 0;
                    }
                    else {
                        %>
                    <td class="col-md-1"></td>
                    <td class="col-md-3" align="center" id="shadow">
                        <a href="<%=request.getContextPath()%>/item?id=<%=rs.getString("item_id")%>" id="noblue"><img src="GettingImage?img_id=<%=rs.getString("item_id")%>" width="200" height="150" align="center"/>
                        <h4><strong><%=rs.getString("title")%></strong></h4>
                        <p>$ <%=rs.getString("price")%></p></a>
                    </td>
                        <%          i++;
                    } 
                }
            }
            %>
            <tr><td></td></tr>
        </tbody></table>
        </div></div></div></div>
        <div class="right">
            <h4>Recently Posted Items</h4>
            <br>
            <%
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
