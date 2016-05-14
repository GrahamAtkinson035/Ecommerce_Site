<%-- 
    Document   : confirmorder
    Created on : May 3, 2016, 9:54:43 PM
    Author     : Austen
--%>

<%@page import="java.util.Random"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="classes.Item"%>
<%@page import="classes.ShoppingCart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Confirmed</title>
    </head>
    <body>
        <%
            String name = request.getParameter("firstName") + " " + request.getParameter("lastName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String location = request.getParameter("city") + ", " + request.getParameter("state") + " " + request.getParameter("zipcode");
            String ccNum = request.getParameter("ccNum");
            Random random = new Random();
            int conf_num = random.nextInt(999999999);
            
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/snaplist", "root", "");
            int size = 0;
            PreparedStatement st = conn.prepareStatement("SELECT COUNT(*) FROM `order`");
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                size = rs.getInt("COUNT(*)");
            }
            int[] used_nums = new int[size];
            PreparedStatement p = conn.prepareStatement("SELECT `confirmation_number` FROM `order`");
            ResultSet r = p.executeQuery();
            int i = 0;
            while (r.next()){
                used_nums[i] = r.getInt("confirmation_number");
                i++;
            }
            for(i=0; i<size; i++){
                if(used_nums[i] == conf_num){
                    conf_num = random.nextInt(999999999);
                    i=0;
                }
            }
           
        synchronized (session){
            ShoppingCart cart = (ShoppingCart) session.getAttribute("Cart");
            if (cart == null) // new sesssion, just create a cart
            {
                cart = new ShoppingCart();
                session.setAttribute("Cart", cart);
            }
            
            PreparedStatement state = conn.prepareStatement("INSERT INTO customer (name, email, phone, address, location, cc_number) VALUES (?,?,?,?,?,?) ON DUPLICATE KEY UPDATE `name`=`name`;");
            state.setString(1, name);
            state.setString(2, email);
            state.setString(3, phone);
            state.setString(4, address);
            state.setString(5, location);
            state.setString(6, ccNum);
            state.execute();
            
            PreparedStatement ps = conn.prepareStatement("INSERT INTO `order` (total, confirmation_number, customer_id) VALUES (?, ?, (SELECT customer_id from customer WHERE name=?));");
            ps.setDouble(1, cart.total);
            ps.setInt(2, conf_num);
            ps.setString(3, name);
            ps.execute();
            
            ArrayList<Item> items = cart.itemlist;
            for(i=0; i<items.size(); i++){
                Item itm = (Item) items.get(i);
                PreparedStatement pre = conn.prepareStatement("insert into `ordered_item` (`order_id`, `item_id`, `quantity`) VALUES ((SELECT order_id from `order` JOIN customer on `order`.customer_id=customer.customer_id WHERE name=? ORDER BY `order_id` DESC LIMIT 1),?,?);");
                %>
                
                <%
                pre.setString(1, name);
                pre.setString(2, itm.id);
                pre.setInt(3, itm.quantity);
                pre.execute();
                
                PreparedStatement pst = conn.prepareStatement("Insert into `purchased_items` (item_id) VALUES(?)");
                pst.setString(1, itm.id);
                pst.execute();
            }
        }
        %>
        <div class="main">
            <h4>Confirmed!</h4>
            <p>Congratulations! You're order has been placed. Your confirmation number is <%= conf_num %>. This number will also be sent to your email, and your order will be processed as soon as possible, enjoy!</p>
        </div>
        <div class="right">
            <h4>Recently Posted Items</h4>
            <br>
            <%
                Statement ste = conn.createStatement();
                ResultSet result = ste.executeQuery("SELECT * FROM items WHERE item_id NOT IN (SELECT item_id FROM purchased_items) ORDER BY last_update DESC LIMIT 5;");
                while (result.next()) {
            %>
            <a href="<%=request.getContextPath()%>/item?id=<%=result.getString("item_id")%>" id="noblue"><img src="GettingImage?img_id=<%=result.getString("item_id")%>" width="100" height="100" />
                <h6><strong><%=result.getString("title")%></strong></h6>
                <p>$ <%=result.getString("price")%></p>
            </a>
            <style>
                .right{
                    bottom: auto;
                }
            </style>
            <%
                }
            %>
        </div>
    </body>
</html>
