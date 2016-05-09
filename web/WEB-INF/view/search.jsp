<%-- 
    Document   : search
    Created on : May 6, 2016, 2:27:49 PM
    Author     : Austen
--%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<div class="main">
    <div class="container">
        <div class="row">
            <div class="col-md-10">
                <table class="table">
                    <tbody>
                        <%
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/snaplist", "root", "");
                                PreparedStatement state = conn.prepareStatement("SELECT * FROM items WHERE title = ?;");
                                state.setString(1, request.getParameter("search"));
                                ResultSet rs = state.executeQuery();
                                while (rs.next()){
                                    %>
                                    <tr>
                                        <td>
                                            <img src="GettingImage?img_id=<%=rs.getString("item_id")%>" />
                                            <h5><%=rs.getString("title")%></h5>
                                            <p>$ <%=rs.getString("price")%></p>
                                        </td>
                                    </tr>
                               <% }%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
    </body>
</html>
