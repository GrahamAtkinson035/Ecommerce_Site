/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import classes.ShoppingCart;
import entity.Category;
import entity.Items;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import session.CategoryFacade;

/**
 *
 * @author Austen
 */
@WebServlet(name="/controller", urlPatterns={"/category", "/viewCart", "/addToCart", "/updateCart", "/checkout", "/purchase", "/item", "/search", "/upload"})
public class ControllerServlet extends HttpServlet {
    private ShoppingCart cart;
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

        String userPath = request.getServletPath();

        // if category page is requested
        if (userPath.equals("/category")) {
            // get categoryId from request
//            String categoryId = request.getQueryString();
//           if (categoryId != null) {
//                // get selected category
//                Category selectedCategory = categoryFacade.find(Short.parseShort(categoryId));
//
//                // place selected category in request scope
//                request.setAttribute("selectedCategory", selectedCategory);
//                
//                Collection<Items> categoryProducts = selectedCategory.getItemsCollection();
//                
//                request.setAttribute("categoryProducts", categoryProducts);
//            }

        // if cart page is requested
        } else if (userPath.equals("/viewCart")) {
            // TODO: Implement cart page request

            userPath = "/cart";
        // if checkout page is requested
        } else if (userPath.equals("/checkout")) {
            // TODO: Implement checkout page request

        // if user switches language
        } else if (userPath.equals("/search")){
            
        } else if (userPath.equals("/upload")){
            
        }
        // use RequestDispatcher to forward request internally
        String url = "/WEB-INF/view" + userPath + ".jsp";

        try {
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        String userPath = request.getServletPath();

        // if addToCart action is called
        if (userPath.equals("/addToCart")) {
            // TODO: Implement add product to cart action
            userPath = "/editCart";
        // if updateCart action is called
        } else if (userPath.equals("/updateCart")) {
            // TODO: Implement update cart action
            userPath = "/editCart";
        // if purchase action is called
        } else if (userPath.equals("/purchase")) {
            // TODO: Implement purchase action
            userPath = "/confirmorder";
        }

        // use RequestDispatcher to forward request internally
        String url = "/WEB-INF/view" + userPath + ".jsp";

        try {
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}
