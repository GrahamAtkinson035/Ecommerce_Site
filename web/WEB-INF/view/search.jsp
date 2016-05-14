<%-- 
    Document   : search
    Created on : May 6, 2016, 2:27:49 PM
    Author     : Austen
--%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<div class="main">
    <h3>Related Items to "<%=request.getParameter("search")%>"</h3>
    <div class="container">
        <div class="row">
            <div class="col-md-10">
                <table class="table">
                    <tbody>
                        <%
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/snaplist", "root", "");
                                PreparedStatement state = conn.prepareStatement("SELECT * FROM items WHERE title = ? AND item_id NOT IN (SELECT item_id FROM purchased_items);");
                                state.setString(1, request.getParameter("search"));
                                ResultSet rs = state.executeQuery();
                                int i = 0;
                                while (rs.next()){
                                    if(i == 0){
                                %>
                                <tr>
                                    <td class="col-md-3" align="center" id="shadow">
                                        <a href="<%=request.getContextPath()%>/item?id=<%=rs.getString("item_id")%>" id="noblue"><img src="GettingImage?img_id=<%=rs.getString("item_id")%>" width="200" height="150" align="center"/>
                                        <h4><strong><%=rs.getString("title")%></strong></h4>
                                        <p>$ <%=rs.getString("price")%></p></a>
                                    </td>
                                <%
                                            i++;
                                        }
                                        else if(i%2 == 0){
                                %>
                                    <td class="col-md-1"></td>
                                    <td class="col-md-3" align="center" id="shadow">
                                        <a href="<%=request.getContextPath()%>/item?id=<%=rs.getString("item_id")%>" id="noblue"><img src="GettingImage?img_id=<%=rs.getString("item_id")%>" width="200" height="150" />
                                            <h4><strong><%=rs.getString("title")%></strong></h4>
                                            <p>$ <%=rs.getString("price")%></p>
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
                                        <a href="<%=request.getContextPath()%>/item?id=<%=rs.getString("item_id")%>" id="noblue"><img src="GettingImage?img_id=<%=rs.getString("item_id")%>" width="200" height="150" align="center"/>
                                        <h4><strong><%=rs.getString("title")%></strong></h4>
                                        <p>$ <%=rs.getString("price")%></p></a>
                                    </td>
                                <%          i++;
                                        }
                                }
                                String search = request.getParameter("search");
                                StringTokenizer st = new StringTokenizer(search, " ");
                                while(st.hasMoreTokens()){
                                    String token = st.nextToken(); //Here you will get A, sg, fall as separated tokens
                                    PreparedStatement ps = conn.prepareStatement("SELECT * FROM items WHERE INSTR(`title`, ?)");
                                    ps.setString(1, token);
                                    ResultSet result = ps.executeQuery();
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
                                }
                            }
                               %>
                               <tr><td></td></tr>    
                </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="right">
    <h4>Recently Posted Items</h4>
    <br>
    <%
        Statement ste = conn.createStatement();
        ResultSet result = ste.executeQuery("SELECT * FROM items WHERE item_id NOT IN (SELECT item_id FROM purchased_items) ORDER BY last_update DESC LIMIT 5;");
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
