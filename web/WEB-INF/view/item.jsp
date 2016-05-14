<%-- 
    Document   : item
    Created on : May 6, 2016, 12:24:07 PM
    Author     : Austen
--%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>

        <div class="main">
        <%
            int quantity =0;
            String id = request.getParameter("id");
            Connection conn = null;
            Class.forName("com.mysql.jdbc.Driver");
            conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/snaplist", "root", "");
            PreparedStatement state = conn.prepareStatement("SELECT * FROM items WHERE item_id = ?");
            state.setString(1, id);
            ResultSet result = state.executeQuery();
            int i = 0;
            while (result.next()) {
        %>
            <br><img src="GettingImage?img_id=<%=result.getString("item_id")%>" width="70%" height="70%" align="center"/><br>
            <h3 class="text-center"><%=result.getString("title")%></h3>
            <h4 align="left" style="padding-left: 5%;">Description</h4>
            <p align="left" style="padding-left: 5%;"><%=result.getString("description")%></p>
            <p>$ <%=result.getString("price")%></p>      
            <form name="addform" method="POST" action="<%=request.getContextPath()%>/addToCart">
                <input type="hidden" name="id" value="<%=result.getString("item_id")%>" />
                <input type="hidden" name="name" value="<%=result.getString("title")%>" />
                <input type="hidden" name="quantity" value="1" />
                <input type="hidden" name="price" value="<%=result.getString("price")%>" />
                <input type="submit" value="Add To Cart" name="action"/>
            </form>
        <%
            }
            %>
        </div>
        <div class="right">
            <h4>Similar Items</h4>
            <br>
            <%
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM items WHERE category_id = (SELECT category_id FROM items WHERE item_id = ?) AND item_id != ? AND item_id NOT IN (SELECT item_id FROM purchased_items);"); 
                ps.setString(1, id);
                ps.setString(2, id);
                ResultSet rs = ps.executeQuery();
                int didIt=0;
                while(rs.next()){
            %>
            <a href="<%=request.getContextPath()%>/item?id=<%=rs.getString("item_id")%>"><img src="GettingImage?img_id=<%=rs.getString("item_id")%>" width="100" height="100" /></a>
            <h5><%=rs.getString("title")%></h5>
            <p>$ <%=rs.getString("price")%></p>
            <%      i++;
                    if (i > 4 && didIt == 0) {
                        didIt = 1;
            %>
                <style>
                    .right{
                        bottom: auto;
                    }
                </style>
            <%
                    }
                }
            %>
        </div>
    </body>
</html>
