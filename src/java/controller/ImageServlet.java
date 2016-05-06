/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import java.io.*;
import java.sql.*;


/**
 *
 * @author Austen
 */

public class ImageServlet{
    
    public byte[] getImageURL(String img_id){
    Blob image = null;
    Connection con = null;
    byte[] imgData = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/snaplist", "root", "");
        stmt = con.prepareStatement("select photo from items where item_id = ?");
        stmt.setString(1, img_id);
        rs = stmt.executeQuery();
        if (rs.next()) {
            image = rs.getBlob(1);
            imgData = image.getBytes(1, (int) image.length());
        } else {
            System.out.println("Display Blob Example");
            System.out.println("image not found for given id>");
        }

        // display the image
//        response.setContentType("image/gif");
//        OutputStream o = response.getOutputStream();
//        o.write(imgData);
//        o.flush();
//        o.close();
    }
    catch (Exception e) {
        System.out.println("Unable To Display image");
        System.out.println("Image Display Error=" + e.getMessage());
    }
    
    finally {
        try {
            rs.close();
            stmt.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    return imgData;
    }
}