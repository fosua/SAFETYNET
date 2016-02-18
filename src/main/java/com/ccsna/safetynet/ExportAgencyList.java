/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.safetynet;

import com.ccsna.ccsna.Agency;
import com.ccsna.ccsna.AgencyModel;
import com.ccsna.ccsna.County;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Objects;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

/**
 *
 * @author estelle
 */
@WebServlet(name = "ExportAgencyList", urlPatterns = {"/export/agency"})
public class ExportAgencyList extends HttpServlet {

//We are making use of a single instance to prevent multiple write access to same file.
    private static final ExportAgencyList INSTANCE = new ExportAgencyList();

    public static ExportAgencyList getInstance() {
        return INSTANCE;
    }

    private static final String file_Name = "agency.xls";
    private static final org.apache.log4j.Logger log = org.apache.log4j.Logger.getRootLogger();

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
            throws ServletException, IOException, RowsExceededException, WriteException {

        try //PrintWriter out = response.getWriter()) 
        {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "attachment;filename=" + file_Name);

            ArrayList<Agency> agencyList = new AgencyModel().listAgency();
            //create workbook and work sheet
            WritableWorkbook writableWorkbook = Workbook.createWorkbook(response.getOutputStream());
            WritableSheet writableSheet = writableWorkbook.createSheet("Sheet1", 0);
            writableSheet.getSettings().setDefaultColumnWidth(25);

            //add cells in the rows and columns
            int i = 0;
            writableSheet.addCell(new Label(i++, 0, "NAME"));
            writableSheet.addCell(new Label(i++, 0, "CONTACT NUMBER"));
            writableSheet.addCell(new Label(i++, 0, "EMAIL ADDRESS"));
            writableSheet.addCell(new Label(i++, 0, "WEBSITE"));
            writableSheet.addCell(new Label(i++, 0, "COUNTIES SERVED"));
            writableSheet.addCell(new Label(i++, 0, "STATUS"));
            int row = 1;

            for (Agency agency : agencyList) {
                int column = 0;
                Long value = 0l;
                String website = "", pno = "";
                if (!Objects.equals(agency.getPrivateContactNumber(), value)) {
                    pno = String.valueOf(agency.getPrivateContactNumber());
                }
                if (agency.getWebsiteAddress() != null) {
                    website = agency.getWebsiteAddress();
                }
                writableSheet.addCell(new Label(column++, row, agency.getFullname()));
                writableSheet.addCell(new Label(column++, row, pno));
                writableSheet.addCell(new Label(column++, row, agency.getEmailAddress()));
                writableSheet.addCell(new Label(column++, row, website));
                String countyList = "";
                Set cList = agency.getCounties();
                int cty_Size = 0;
                for (Iterator itr = cList.iterator(); itr.hasNext();) {
                    cty_Size++;
                    County c = (County) itr.next();
                    if (cty_Size != cList.size()) {
                        countyList += c.getCountyName() + ", ";

                    } else {
                        countyList += c.getCountyName();

                    }

                }
                writableSheet.addCell(new Label(column++, row, countyList));
                writableSheet.addCell(new Label(column++, row, agency.getStatus()));

                row++;
            }
            writableWorkbook.write();
            writableWorkbook.close();
        } catch (WriteException e) {
            //throw new ServletException("exception in excel servlet " + e);
        } /*finally {
         if (out != null) {
         out.close();
         }
         }*/

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
        } catch (WriteException ex) {
            Logger.getLogger(ExportAgencyList.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (WriteException ex) {
            Logger.getLogger(ExportAgencyList.class.getName()).log(Level.SEVERE, null, ex);
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
