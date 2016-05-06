/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package images;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.io.*;

/**
 *
 * @author Austen
 */
@WebServlet(name="GettingImage", urlPatterns={"/GettingImage"})
public class GettingImage extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int img_id = Integer.parseInt(request.getParameter("img_id"));
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        OutputStream oImage;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snaplist", "root", "");
            pstmt = con.prepareStatement("select photo from items where item_id= ?;");
            pstmt.setInt(1, img_id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                byte barray[] = rs.getBytes(1);
                response.setContentType("image/gif");
                oImage = response.getOutputStream();
                oImage.write(barray);
                oImage.flush();
                oImage.close();
            }
        } catch (Exception ex) {
    //ex.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
                // ex.printStackTrace();
            }
        }
    }
}
