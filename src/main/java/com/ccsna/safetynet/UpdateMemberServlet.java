/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.safetynet;

import com.ccsna.ccsna.Member;
import com.ccsna.ccsna.MemberModel;
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
 * @author estelle
 */
@WebServlet(name = "UpdateMemberServlet", urlPatterns = {"/member/edit"})
public class UpdateMemberServlet extends HttpServlet {

    private static final Logger log = Logger.getRootLogger();
    boolean dataValid = true;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NoSuchAlgorithmException, InvalidKeySpecException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            String message = "";
            Member loggedInMember = UserAuthenticator.loggedInUser(request.getSession());
            if (loggedInMember == null) {
                log.warn("invalid logged user session");
                message += "Invalid Access, Please login with username and password!";
                Validation.setAttributes(request, Validation.ERROR, message);
                response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            } else {
                log.info("user logged in , id is :" + loggedInMember.getMemberId());
                int option = Integer.parseInt(request.getParameter("option"));
                String username = request.getParameter("username");
                log.info("the username entered is :"+ username);
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String emailAddress = request.getParameter("username");
                String phoneNumber = request.getParameter("phoneNumber");
                String oldPassword = request.getParameter("oldPassword");
                String newPassword = request.getParameter("newPassword");
                int id = Integer.parseInt(request.getParameter("id"));
                String upDatedBy = String.valueOf(loggedInMember.getMemberId());

                String title = request.getParameter("title");
                switch (Validation.MemberActions.values()[option]) {
                    case PERSONAL_INFO:
                        log.info("updating personal info");
                        Member member = new MemberModel().emailExist(emailAddress);
                        if (member == null || (member.getMemberId().compareTo(id) == 0)) {

                            boolean updated = new MemberModel().update(username, "", lastName, firstName, emailAddress, phoneNumber, "", upDatedBy, title, id, "");
                            if (updated) {
                                message += "Your Info has been Successfully updated";
                                Validation.setAttributes(request, Validation.SUCCESS, message);
                                response.sendRedirect(request.getContextPath() + "/pages/member.jsp");
                            } else {
                                message += "Update Failed, Try again later!";
                                Validation.setAttributes(request, Validation.ERROR, message);
                                response.sendRedirect(request.getContextPath() + "/pages/member.jsp");
                            }
                        } else {

                            message += "Member with email address already exist, Please enter a different email";
                            Validation.setAttributes(request, Validation.ERROR, message);
                            response.sendRedirect(request.getContextPath() + "/pages/member.jsp");
                        }
                        break;
                    case RESET_PASSWORD:
                        log.info("updating password ...........");
                        member = new MemberModel().login(username, oldPassword);
                        if (member != null) {
                            boolean updated = new MemberModel().update(username, newPassword, lastName, firstName, emailAddress, phoneNumber, "", upDatedBy, title, id, "");
                            if (updated) {
                                message += "Password has been Successfully updated";
                                Validation.setAttributes(request, Validation.SUCCESS, message);
                                response.sendRedirect(request.getContextPath() + "/pages/member.jsp");
                            } else {
                                message += "Password update Failed, Try again later!";
                                Validation.setAttributes(request, Validation.ERROR, message);
                                response.sendRedirect(request.getContextPath() + "/pages/member.jsp");
                            }
                        } else {
                            message += "Password update Failed, Try again later!";
                            Validation.setAttributes(request, Validation.ERROR, message);
                            response.sendRedirect(request.getContextPath() + "/pages/member.jsp");
                        }
                        break;

                }
            }
        }catch (Exception e){
            
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
            java.util.logging.Logger.getLogger(UpdateMemberServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeySpecException ex) {
            java.util.logging.Logger.getLogger(UpdateMemberServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            java.util.logging.Logger.getLogger(UpdateMemberServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeySpecException ex) {
            java.util.logging.Logger.getLogger(UpdateMemberServlet.class.getName()).log(Level.SEVERE, null, ex);
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
