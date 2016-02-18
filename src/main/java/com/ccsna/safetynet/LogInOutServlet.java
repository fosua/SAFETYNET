/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.safetynet;

import com.ccsna.ccsna.MemberModel;
import com.ccsna.ccsna.Member;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.logging.Level;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author Esther Amo-Nyarko <estelle_7@ymail.com>
 */
@WebServlet(name = "LogInOutServlet", urlPatterns = {"/login/logout"})
public class LogInOutServlet extends HttpServlet {

    private static final Logger log = Logger.getRootLogger();
    public static final String SUPERADMIN_PAGE = "/admin/management.jsp";
    public static final String AGENCYADMIN_PAGE = "/pages/agencyAdmin.jsp";
    public static final String MEMBER_PAGE= "/pages/member.jsp";
    Member member = null;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.security.NoSuchAlgorithmException
     * @throws java.security.spec.InvalidKeySpecException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NoSuchAlgorithmException, InvalidKeySpecException {
        response.setContentType("text/html;charset=UTF-8");
        try  {
            PrintWriter out = response.getWriter();
            boolean dataValid = true;
            String responseMessage = "";
            int option = Integer.parseInt(request.getParameter("option"));
            log.info("option is: "+ option);
            switch (Validation.InOut.values()[option]) {
                case LOGIN:
                    //get the username
                    String username = request.getParameter("username");
                    if (Validation.checkNullity(username)) {
                        dataValid = false;
                        log.warn("username is empty");
                        responseMessage += "Email Address field is empty!";
                    }
                    //check if email is a valid email
                    if (!Validation.checkEmail(username)) {
                        dataValid = false;
                        log.warn("invalid email address entered");

                    }
                    //get the password
                    String password = request.getParameter("password");
                    if (Validation.checkNullity(password)) {
                        dataValid = false;
                        log.warn("password is empty");
                        responseMessage += "Password field is empty!";
                    }
                    //if every data entere is valid
                    if (dataValid) {
                        member = new MemberModel().login(username, password);
                        String redirectTo = null;
                        if (member != null && member.getStatus().equalsIgnoreCase(Menu.ACTIVE)) {
                            UserAuthenticator.setUser(request, member);
                            //responseMessage += "Login Successful!,  Welcome " + member.getFirstName();
                            if (member.getRole().equalsIgnoreCase(Menu.SUPER_ADMIN)) {
                                redirectTo = SUPERADMIN_PAGE;
                            } else if (member.getRole().equalsIgnoreCase(Menu.AGENCY_ADMIN)) {
                                redirectTo = AGENCYADMIN_PAGE;
                            } else if (member.getRole().equalsIgnoreCase(Menu.MEMBER)) {
                                redirectTo = MEMBER_PAGE;
                            } else {
                                responseMessage = "Cannot find user!";
                                redirectTo = "/admin/login.jsp";
                            }
                            
                            //Validation.setAttributes(request, Validation.SUCCESS, responseMessage);
                            response.sendRedirect(request.getContextPath() + redirectTo);
                        } else {
                            log.warn("Invalid credentials!");
                            responseMessage += " Invalid Username or Password!";
                            Validation.setAttributes(request, Validation.ERROR, responseMessage);
                            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
                        }
                    } else {

                        log.warn("Invalid data provided!");
                        responseMessage += " Invalid Username or Password!";
                        Validation.setAttributes(request, Validation.ERROR, responseMessage);
                        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
                    }
                    break;
                case LOGOUT:
                    boolean loggedOut = UserAuthenticator.logoutClient(request);
                    if (loggedOut){
                        response.sendRedirect(request.getContextPath() + "/index.jsp");
                    }
                    break;
            }
        }catch(Exception e){
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            java.util.logging.Logger.getLogger(LogInOutServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeySpecException ex) {
            java.util.logging.Logger.getLogger(LogInOutServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            java.util.logging.Logger.getLogger(LogInOutServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeySpecException ex) {
            java.util.logging.Logger.getLogger(LogInOutServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
