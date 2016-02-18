/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.safetynet;

import com.ccsna.ccsna.SuccessStory;
import com.ccsna.ccsna.SuccessStoryModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@WebServlet(name = "SuccessStoryDynaLoadServlet", urlPatterns = {"/successStory/load"})
public class SuccessStoryDynaLoadServlet extends HttpServlet {

    private static final Logger log = Logger.getRootLogger();

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
        try {
             PrintWriter out = response.getWriter();
            int row = Integer.parseInt(request.getParameter("row"));
            //log.info("row is : " + row);
            int numberOfRecords = row + 3;
            //log.info("column is : " + numberOfRecords);
            String result = "", agency = "";
            int counter = 1;
            ArrayList<SuccessStory> storyList = new SuccessStoryModel().successStoryList(row, numberOfRecords);
            if (storyList != null && !storyList.isEmpty()) {
               // log.info("length of story list is :" + storyList.size());
                for (SuccessStory story : storyList) {
                    if (story.getAgency() != null && !story.getAgency().isEmpty()) {
                        agency = story.getAgency();
                    }
                    if (counter % 2 == 0) {
                        result += "<div class=\"ssStory\"  style=\"background-color: #F9F9FF\">\n"
                                + "                    <p>" + story.getContent() + "</p>\n"
                                + "                    <p> <b><i>-&Tab;" + story.getFull_name() + agency + "</i></b></p>\n"
                                + "                </div> <br>";
                    } else {
                        result += "<div class=\"ssStory\" style=\"background-color: #d9edf7\">\n"
                                + "                    <p>" + story.getContent() + "</p>\n"
                                + "                    <p> <b><i>-&Tab;" + story.getFull_name() + agency + "</i></b></p>\n"
                                + "                </div> <br>";

                    }
                    counter++;

                }
            }
            if (!result.isEmpty()) {
                out.write(result);
            } else {
                out.write("");
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
