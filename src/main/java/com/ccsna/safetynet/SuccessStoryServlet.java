/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.safetynet;

import com.ccsna.ccsna.Member;
import com.ccsna.ccsna.SuccessStory;
import com.ccsna.ccsna.SuccessStoryModel;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "SuccessStoryServlet", urlPatterns = {"/add/successStory"})
public class SuccessStoryServlet extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try  {
            PrintWriter out = response.getWriter();
            String message = "";
            SuccessStory story = null;
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("emailAddress");
            String agency = request.getParameter("agency");
            String content = request.getParameter("content");
            int action = Integer.parseInt(request.getParameter("action"));

            switch (Validation.Actions.values()[action]) {
                case CREATE:
                    if (Validation.checkNullity(fullName)) {
                        log.info("fullname is empty");
                        message += "full name is empty";
                        dataValid = false;
                    }
                    if (Validation.checkNullity(email)) {
                        log.info("email is empty");
                        message += "email name is empty";
                        dataValid = false;
                    } else if (!Validation.checkEmail(email)) {
                        log.info("improper email format");
                        message += "Email format is incorrect";
                        dataValid = false;
                    }
                    if (Validation.checkNullity(content)) {
                        log.info("content is empty");
                        message += "content is empty";
                        dataValid = false;
                    }
                    if (dataValid) {
                        story = new SuccessStoryModel().addSuccessStory(fullName, email, agency, content, "1");
                        if (story != null) {
                            log.info("Success story successfully created...");
                            message += "Thank you for your submission. Your Story will be posted after review";
                            Validation.setAttributes(request, Validation.SUCCESS, message);
                            response.sendRedirect(request.getContextPath() + "/pages/successStory.jsp");
                        } else {
                            log.info("success story creating failed...");
                            message += "Sorry we could not save your story , Please try again later";
                            Validation.setAttributes(request, Validation.ERROR, message);
                            response.sendRedirect(request.getContextPath() + "/pages/successStory.jsp");
                        }
                    } else {
                        log.info("success story creating failed...");
                        message += "Sorry we could not add your story , Please review your inputs and try again later";
                        Validation.setAttributes(request, Validation.ERROR, message);
                        response.sendRedirect(request.getContextPath() + "/pages/successStory.jsp");
                    }
                    break;
                case UPDATE:

                    Member loggedInMember = UserAuthenticator.loggedInUser(request.getSession());
                    if (loggedInMember != null) {

                        String createdBy = String.valueOf(loggedInMember.getMemberId());
                        int id = Integer.parseInt(request.getParameter("id"));
                        String approval_Status = request.getParameter("approval_Status");

                        boolean updated = new SuccessStoryModel().update(id, content, approval_Status, createdBy);
                        if (updated) {
                            log.info("Success story successfully updated");
                            message += "Story has been successfully updated";
                            Validation.setAttributes(request, Validation.SUCCESS, message);
                            response.sendRedirect(request.getContextPath() + "/admin/reviewSuccessStory.jsp");
                        } else {
                            log.info("success story creating failed...");
                            message += "Sorry we are unable to update the story , Please try again later";
                            Validation.setAttributes(request, Validation.ERROR, message);
                            response.sendRedirect(request.getContextPath() + "/pages/editApprovalStatus.jsp");
                        }
                        break;
                    } else {
                        String failMsg = "Access Denied, Login with Valid Credentials";
                        Validation.setAttributes(request, Validation.ERROR, failMsg);
                        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
                    }
            }
        } catch (Exception e){
            
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
        processRequest(request, response);
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
        processRequest(request, response);
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
