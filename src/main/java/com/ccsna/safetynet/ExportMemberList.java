/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.safetynet;

import com.ccsna.ccsna.Member;
import com.ccsna.ccsna.MemberModel;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Objects;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import org.apache.log4j.Logger;

@WebServlet(name = "ExportMemberList", urlPatterns = {"/export/excel"})
public class ExportMemberList extends HttpServlet {

    private static final String file_Name = "member.xls";
    private static final Logger log = Logger.getRootLogger();

//We are making use of a single instance to prevent multiple write access to same file.
    private static final ExportMemberList INSTANCE = new ExportMemberList();

    public static ExportMemberList getInstance() {
        return INSTANCE;
    }

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
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + file_Name);
        try {
            log.info("it hits the servlet");
            ArrayList<Member> memberList = new ArrayList();
            String agencyID = request.getParameter("agency");
            if (agencyID != null) {
                log.info("the id is : " + agencyID);
                int id = Integer.parseInt(request.getParameter("agency"));
                memberList = new MemberModel().AgencyMemberList(id);
            } else {
                memberList = new MemberModel().memberList();
                log.info("get all the agency list");
            }

            //create workbook and work sheet
            WritableWorkbook writableWorkbook = Workbook.createWorkbook(response.getOutputStream());
            WritableSheet writableSheet = writableWorkbook.createSheet("Sheet1", 0);
            //set the width of the column
            writableSheet.getSettings().setDefaultColumnWidth(25);

            //add cells in the rows and columns for the header
            int i = 0;
            writableSheet.addCell(new Label(i++, 0, "NAME"));
            writableSheet.addCell(new Label(i++, 0, "EMAIL ADDRESS"));
            writableSheet.addCell(new Label(i++, 0, "PHONE NUMBER"));
            if (agencyID != null && !agencyID.isEmpty()) {
            } else {
                writableSheet.addCell(new Label(i++, 0, "AGENCY"));

            }
            writableSheet.addCell(new Label(i++, 0, "ROLE"));
            writableSheet.addCell(new Label(i++, 0, "STATUS"));
            int row = 1;

            for (Member member : memberList) {
                int column = 0;
                Long value = 0l;
                String website = "", pno = "";
                if (member.getTitle() != null && !member.getTitle().isEmpty()) {
                    writableSheet.addCell(new Label(column++, row, member.getTitle() + " " + member.getFirstName() + " " + member.getLastName()));
                } else {
                    writableSheet.addCell(new Label(column++, row, member.getFirstName() + " " + member.getLastName()));
                }
                if (!Objects.equals(member.getPhoneNumber(), value)) {
                    pno = String.valueOf(member.getPhoneNumber());
                }
                writableSheet.addCell(new Label(column++, row, member.getEmailAddress()));
                writableSheet.addCell(new Label(column++, row, pno));
                if (agencyID != null && !agencyID.isEmpty()) {

                } else {
                    writableSheet.addCell(new Label(column++, row, member.getAgency().getFullname()));
                }
                writableSheet.addCell(new Label(column++, row, member.getRole()));
                writableSheet.addCell(new Label(column++, row, member.getStatus()));
                row++;
            }
            writableWorkbook.write();
            writableWorkbook.close();
        } catch (Throwable e) {
            e.printStackTrace();
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
