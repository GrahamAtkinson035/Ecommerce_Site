<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : index
    Created on : May 3, 2016, 9:53:19 PM
    Author     : Austen
--%>
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
                    PreparedStatement state = conn.prepareStatement("SELECT * FROM items WHERE item_id NOT IN (SELECT item_id FROM purchased_items) ORDER BY last_update DESC LIMIT 15;");
                    ResultSet result = state.executeQuery();
                    int i=0;
                    while(result.next()){
                        if(i == 0){
                %>
                <tr>
                    <td class="col-md-3" align="center" id="shadow">
                        <a href="<%=request.getContextPath()%>/item?id=<%=result.getString("item_id")%>" id="noblue"><img src="GettingImage?img_id=<%=result.getString("item_id")%>" width="200" height="150" align="center"/>
                        <h4><strong><%=result.getString("title")%></strong></h4>
                        <p>$ <%=result.getString("price")%></p></a>
                    </td>
                <%
                            i++;
                        }
                        else if(i%2 == 0){
                %>
                    <td class="col-md-1"></td>
                    <td class="col-md-3" align="center" id="shadow">
                        <a href="<%=request.getContextPath()%>/item?id=<%=result.getString("item_id")%>" id="noblue"><img src="GettingImage?img_id=<%=result.getString("item_id")%>" width="200" height="150" />
                            <h4><strong><%=result.getString("title")%></strong></h4>
                            <p>$ <%=result.getString("price")%></p>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td></td><td></td><td></td><td></td><td></td>
                </tr>


                <%      i=0;
                        }
                        else{
                %>
                    <td class="col-md-1"></td>
                    <td class="col-md-3" align="center" id="shadow">
                        <a href="<%=request.getContextPath()%>/item?id=<%=result.getString("item_id")%>" id="noblue"><img src="GettingImage?img_id=<%=result.getString("item_id")%>" width="200" height="150" align="center"/>
                        <h4><strong><%=result.getString("title")%></strong></h4>
                        <p>$ <%=result.getString("price")%></p></a>
                    </td>
                <%          i++;
                        } 
                        //else { %>

                <% //i=0; }
                } %>
            </tr>
            <tr>
                <td></td><td></td><td></td><td></td><td></td>
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
                        <a href="<%=request.getContextPath()%>/category?c_id=<%=rs.getString("category_id")%>"><%=rs.getString("name")%>(<%=rs.getString("total")%>)</a>
                        <br>
                        <br>
                        <%
                    }
                    %>

        </div>

    </body>
</html>
