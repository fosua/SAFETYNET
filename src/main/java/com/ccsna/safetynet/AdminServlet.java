/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.safetynet;

import com.ccsna.ccsna.Agency;
import com.ccsna.ccsna.ServiceModel;
import com.ccsna.ccsna.MemberModel;
import com.ccsna.ccsna.AgencyModel;
import com.ccsna.ccsna.CountyModel;
import com.ccsna.ccsna.Member;
import com.ccsna.ccsna.Services;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;

/**
 *
 * @author Esther Amo-Nyarko <estelle_7@ymail.com>
 */
@WebServlet(name = "MemberServlet", urlPatterns = {"/member/add"})
public class AdminServlet extends HttpServlet {

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
            int option = Integer.parseInt(request.getParameter("option"));
            String act = request.getParameter("action");
            
            String message = "";
            Long pNo = 0l;
            Member loggedInMember = UserAuthenticator.loggedInUser(request.getSession());
            if (loggedInMember != null) {
                String createdBy = String.valueOf(loggedInMember.getMemberId());
                switch (Validation.Options.values()[option]) {
                    case MEMBER:
                        Agency agency = null;
                        int actions = Integer.parseInt(act);
                        String username = request.getParameter("emailAddress");
                        String password = request.getParameter("password");
                        String lastName = request.getParameter("lastName");
                        String firstName = request.getParameter("firstName");
                        if (Validation.checkNullity(firstName)) {
                            log.info("firstName empty");
                            message += " First name is empty";
                            dataValid = false;
                        }
                        String emailAddress = request.getParameter("emailAddress");
                        String phoneNumber = request.getParameter("phoneNumber");

                        log.info("phone number is : " + phoneNumber);

                        if (!Validation.checkNullity(phoneNumber)) {
                            phoneNumber = phoneNumber.replaceAll("\\s", "");
                            pNo = Long.parseLong(phoneNumber);
                        }
                        String role = request.getParameter("role");
                        if (Validation.checkNullity(role)) {
                            log.info("role empty");
                            message += "Role is empty";
                            dataValid = false;
                        }
                        String title = request.getParameter("title");
                        String agencyId = request.getParameter("agencyId");
                        String status = request.getParameter("status");

                        if (dataValid) {
                            switch (Validation.Actions.values()[actions]) {
                                case CREATE:

                                    if (Validation.checkNullity(lastName)) {
                                        log.info("lastName  empty");
                                        message += " Last Name is empty";
                                        dataValid = false;
                                    }
                                    if (Validation.checkNullity(username)) {
                                        log.info("username  empty");
                                        message += " Username is empty";
                                        //dataValid = false;
                                    }
                                    if (Validation.checkNullity(password)) {
                                        log.info("password  empty");
                                        message += " Password is empty";
                                        // dataValid = false;
                                    }
                                    if (Validation.checkNullity(agencyId)) {
                                        log.info("agency name empty");
                                        message += "No Agency selected ";
                                        //dataValid = false;
                                    } else {
                                        agency = new AgencyModel().findById(Integer.parseInt(agencyId));

                                        if (agency == null) {
                                            log.info("could not find selected agency");
                                            message += "Selected Agency was not found!";
                                            //dataValid = false;
                                        }
                                    }

                                    if (Validation.checkNullity(emailAddress)) {
                                        log.info("emailAddress empty");
                                        message += "Email address is empty";
                                        dataValid = false;
                                    } else {
                                        if (!Validation.checkEmail(emailAddress)) {
                                            log.info("Improper email address entered");
                                        }
                                    }
                                    //Creating a new member 
                                    log.info("member creation started ... in servlet.....");
                                    Member member = new MemberModel().addMember(username, agency, password, lastName, firstName, emailAddress, pNo, role, createdBy, title);
                                    if (member == null) {
                                        message += "New Member Creation Failed!";
                                        Validation.setAttributes(request, Validation.ERROR, message);
                                        response.sendRedirect(request.getContextPath() + "/admin/management.jsp");
                                    } else {
                                        log.info("Member successfully  created");
                                        message += "Member has been Successflly Added, Login with Email address and Password";
                                        Validation.setAttributes(request, Validation.SUCCESS, message);
                                        response.sendRedirect(request.getContextPath() + "/admin/management.jsp#membList");
                                    }
                                    break;
                                case UPDATE:
                                    log.info("upating member ..........................");
                                    int id = Integer.parseInt(request.getParameter("id"));
                                    member = new MemberModel().findById(id);
                                    if (member == null) {
                                        message += "Update Failed!";
                                        Validation.setAttributes(request, Validation.ERROR, message);
                                        response.sendRedirect(request.getContextPath() + "/admin/memberEdit.jsp?id=" + id);
                                    } else {
                                        log.info("Member found, starting update");
                                        String updatedBy = String.valueOf(member.getMemberId());
                                        boolean updated = new MemberModel().update(username, password, lastName, firstName, emailAddress, phoneNumber, role, createdBy, title, id, status);
                                        if (updated) {
                                            message += "Member has been successfully updated";
                                            Validation.setAttributes(request, Validation.SUCCESS, message);
                                            response.sendRedirect(request.getContextPath() + "/admin/management.jsp");
                                        } else {
                                            message += "Update Failed!";
                                            Validation.setAttributes(request, Validation.ERROR, message);
                                            response.sendRedirect(request.getContextPath() + "/admin/memberEdit.jsp?id=" + id);
                                        }
                                    }

                                    break;
                            }
                        } else {
                            log.warn("invalid data entered .... member creation/update failed... ");
                            String failMsg = "Unable To Complete Action, " + message;
                            Validation.setAttributes(request, Validation.ERROR, failMsg);
                            response.sendRedirect(request.getContextPath() + "/admin/management.jsp");
                        }
                        break;
                    case AGENCY:
                        log.info("agency ... ");
                        actions = Integer.parseInt(act);
                        Set serv = new HashSet();
                        Set cty = new HashSet();
                        Long zcode = 0l;
                        String agencyName = request.getParameter("fullName");
                        String webAddress = request.getParameter("website_Address");
                        if (!Validation.checkNullity(webAddress)) {
                            log.info("web address is not empty");
                            if (!Validation.checkUrl(webAddress)) {
                                message += ("Web address is invalid");
                                log.info("Web address is not valid");
                                dataValid = false;
                            }
                        }
                        emailAddress = request.getParameter("emailAddress");
                        password = request.getParameter("password");
                        String streetAddress = request.getParameter("streetAddress");
                        String apartmentNo = request.getParameter("apartmentNo");
                        String city = request.getParameter("city");
                        String state = request.getParameter("state");
                        String zipcode = request.getParameter("zipcode");
                        if (!Validation.checkNullity(zipcode)) {
                            zcode = Long.parseLong(zipcode);
                        }

                        String privatePhoneNumber = request.getParameter("private_Contact_Number");
                        if (!Validation.checkNullity(privatePhoneNumber)) {
                            pNo = Long.parseLong(privatePhoneNumber.replaceAll("\\s", ""));
                        }
                        Long ppNo = 0l;
                        String publicPhoneNumber = request.getParameter("public_Contact_Number");
                        if (!Validation.checkNullity(publicPhoneNumber)) {
                            ppNo = Long.parseLong(publicPhoneNumber.replaceAll("\\s", ""));
                        }
                        String mission = request.getParameter("mission");
                        String requiredVerification = request.getParameter("required_Verification");
                        String boardPositions = request.getParameter("board_Positions");
                        String hoursOfOperation = request.getParameter("hours_Of_Operation");
                        String[] counties = request.getParameterValues("counties_Served");
                        status = request.getParameter("status");
                        String[] services = request.getParameterValues("services");

                        if (dataValid) {
                            switch (Validation.Actions.values()[actions]) {
                                case CREATE:
                                    if (counties == null && counties.length == 0) {
                                        log.info("no counties was checked");
                                        dataValid = false;
                                        message += "County is Empty, Select at least one county";
                                        Validation.setAttributes(request, Validation.ERROR, message);
                                        response.sendRedirect(request.getContextPath() + "/admin/management.jsp#agcyList");
                                    } else {
                                        for (int i = 0; i < counties.length; i++) {
                                            cty.add(new CountyModel().getById(Integer.parseInt(counties[i])));
                                        }
                                    }
                                    if (Validation.checkNullity(agencyName)) {
                                        log.info("Agency Name is empty");
                                        message += "Agency Name is Empty";
                                        dataValid = false;
                                    }
                                    if (Validation.checkNullity(emailAddress)) {
                                        log.info("EmailAddress is Empty");
                                        message += "Email address is Empty";
                                        dataValid = false;
                                    }
                                    if (!Validation.checkEmail(emailAddress)) {
                                        log.info("emailAddress not valid");
                                        message += "Email Address is not valid";
                                        dataValid = false;
                                    }
                                    if (Validation.checkNullity(password)) {
                                        System.out.print("password is empty");
                                        message += "Password is emtpy";
                                    }

                                    if (services != null && services.length != 0) {
                                        for (int i = 0; i < services.length; i++) {
                                            serv.add(new ServiceModel().getById(Integer.parseInt(services[i])));
                                        }

                                    }
                                    log.info("creating new agency .... servlet .....");
                                    Agency newAgency = new AgencyModel().addAgency(agencyName, webAddress, emailAddress, streetAddress, apartmentNo, city, state, zcode, pNo, cty, serv, createdBy, mission, hoursOfOperation, boardPositions, requiredVerification, ppNo);
                                    if (newAgency != null) {
                                        log.info("agency created, creating agency admin");
                                        try {
                                            Member newMember = new MemberModel().addMember(emailAddress, newAgency, password, "", agencyName, emailAddress, pNo, Menu.AGENCY_ADMIN, createdBy, "");
                                            if (newMember == null) {
                                                log.info("Agency created but agency admin creation failed");
                                                message += "Agency Created, but unable to set up login info!, Contact Admin to set up Login Info";
                                                Validation.setAttributes(request, Validation.ERROR, message);
                                                response.sendRedirect(request.getContextPath() + "/admin/management.jsp#agcyList");
                                            } else {
                                                log.info("Agency has been successfully created");
                                                message += "Agency has been successfully created, Login with email address and password!";
                                                Validation.setAttributes(request, Validation.SUCCESS, message);
                                                response.sendRedirect(request.getContextPath() + "/admin/management.jsp#agcyList");
                                            }
                                        } catch (NoSuchAlgorithmException e) {
                                            log.info("Member creation for" + agencyName + "failed");
                                        }

                                    } else {
                                        log.info("Agency creation failed");
                                        String failMsg = "Agency creation failed! " + message;
                                        Validation.setAttributes(request, Validation.ERROR, failMsg);
                                        response.sendRedirect(request.getContextPath() + "/admin/management.jsp#agcy");
                                    }
                                    break;

                                case UPDATE:
                                    log.info("updating agency.....................");
                                    int id = Integer.parseInt(request.getParameter("id"));
                                    if (counties == null && counties.length == 0) {
                                        log.info("no counties was checked");
                                        dataValid = false;
                                        message += "County is Empty, Select at least one county";
                                        Validation.setAttributes(request, Validation.ERROR, message);
                                        response.sendRedirect(request.getContextPath() + "/admin/management.jsp#agcyList");
                                    } else {
                                        for (int i = 0; i < counties.length; i++) {
                                            cty.add(new CountyModel().getById(Integer.parseInt(counties[i])));
                                        }
                                    }
                                    agency = new AgencyModel().findById(id);
                                    if (agency == null) {
                                        message += "Update Failed!";
                                        Validation.setAttributes(request, Validation.ERROR, message);
                                        response.sendRedirect(request.getContextPath() + "/admin/agencyEdit.jsp?id=" + id);
                                    } else {
                                        log.info("Agency found, starting update");
                                        String updatedBy = "";//String.valueOf(member.getMemberId());
                                        boolean updated = new AgencyModel().update(agency.getAgencyId(), agencyName, streetAddress, apartmentNo, city, state, zcode, ppNo, webAddress, mission, hoursOfOperation, requiredVerification, boardPositions, status, emailAddress, ppNo, updatedBy, cty, services);
                                        if (updated) {
                                            message += "Agency has been successfully updated";
                                            Validation.setAttributes(request, Validation.SUCCESS, message);
                                            response.sendRedirect(request.getContextPath() + "/admin/management.jsp");
                                        } else {
                                            message += "Update Failed!";
                                            Validation.setAttributes(request, Validation.ERROR, message);
                                            response.sendRedirect(request.getContextPath() + "/admin/agencyEdit.jsp?id=" + id);
                                        }
                                    }
                                    break;
                                case CHANGESTATUS:
                                    log.info("updating agency.....................");
                                    id = Integer.parseInt(request.getParameter("id"));

                                    agency = new AgencyModel().findById(id);
                                    if (agency == null) {
                                        message += "Update Failed!";
                                        Validation.setAttributes(request, Validation.ERROR, message);
                                        response.sendRedirect(request.getContextPath() + "/admin/agencyEdit.jsp?id=" + id);
                                    } else {
                                        log.info("Agency found, starting update...");
                                        String updatedBy = String.valueOf(loggedInMember.getMemberId());
                                        boolean updated = new AgencyModel().updateStatus(agency.getAgencyId(), status);
                                        if (updated) {
                                            message += "Agency has been successfully updated";
                                            Validation.setAttributes(request, Validation.SUCCESS, message);
                                            response.sendRedirect(request.getContextPath() + "/admin/management.jsp");
                                        } else {
                                            message += "Update Failed!";
                                            Validation.setAttributes(request, Validation.ERROR, message);
                                            response.sendRedirect(request.getContextPath() + "/admin/agencyEdit.jsp?id=" + id);
                                        }
                                    }
                                    break;
                            }
                        } else {
                            String failMsg = "Unable to add Agency, " + message;
                            Validation.setAttributes(request, Validation.ERROR, failMsg);
                            response.sendRedirect(request.getContextPath() + "/admin/management.jsp#agcy");
                        }
                        break;

                    case SERVICES:
                        log.info("the case of service ...");
                        int action = Integer.parseInt(act);
                        String serviceName = request.getParameter("serviceName");
                        if (Validation.checkNullity(serviceName)) {
                            log.info("serviceName name not valid");
                            message += "Service Name is Empty!";
                            dataValid = false;
                        }
                        String servType = request.getParameter("type");
                        if (Validation.checkNullity(serviceName)) {
                            log.info("service Type name not valid");
                            message += "Service Type is Empty!";
                            dataValid = false;
                        }
                        if (dataValid) {
                            switch (Validation.Actions.values()[action]) {
                                case CREATE:
                                    //Creating a new member 
                                    Services service = new ServiceModel().addService(serviceName, createdBy, servType);
                                    if (service == null) {
                                        String failMsg = "Service creation failed! " + message;
                                        Validation.setAttributes(request, Validation.ERROR, failMsg);

                                    } else {
                                        log.info("Service creation successful!");
                                        message += " Service has been successfully added!";
                                        Validation.setAttributes(request, Validation.SUCCESS, message);
                                    }
                                    response.sendRedirect(request.getContextPath() + "/admin/management.jsp#serv");
                                    break;
                                case UPDATE:
                                    int id = Integer.parseInt(request.getParameter("id"));
                                    String updatedBy = "";
                                    boolean updated = new ServiceModel().updateService(id, serviceName, servType, updatedBy);
                                    if (!updated) {
                                        String failMsg = "Service Update failed! " + message;
                                        Validation.setAttributes(request, Validation.ERROR, failMsg);
                                        response.sendRedirect(request.getContextPath() + "/admin/serviceEdit.jsp");

                                    } else {
                                        log.info("Service Update successful!");
                                        message += " Service has been successfully updated!";
                                        Validation.setAttributes(request, Validation.SUCCESS, message);
                                        response.sendRedirect(request.getContextPath() + "/admin/management.jsp#serv");
                                    }
                                    break;
                            }
                        } else {
                            String failMsg = "Invalid input, Unable to add Service, " + message;
                            Validation.setAttributes(request, Validation.ERROR, failMsg);
                            response.sendRedirect(request.getContextPath() + "/admin/management.jsp#serv");
                        }
                        break;
                    case NEWS:
                        log.info("the case of news ...");
                        action = Integer.parseInt(act);
                        String newsTitle = request.getParameter("title");
                        String newsType = request.getParameter("type");
                        String content = request.getParameter("content");
                        Date startDate = null;//Menu.stringToDate(request.getParameter("start_Date"));
                        Date endDate = null;//Menu.stringToDate(request.getParameter("end_Date"));
                        status = Menu.ACTIVE;
                        Date dateCreated = new Date();
                        if (dataValid) {
                            switch (Validation.Actions.values()[action]) {
                                case CREATE:

                                    break;
                                case UPDATE:
                                    break;

                            }
                            break;
                        } else {
                            String failMsg = "Invalid input, Unable to add News Item, " + message;
                            Validation.setAttributes(request, Validation.ERROR, failMsg);
                            response.sendRedirect(request.getContextPath() + "/admin/management.jsp#newEvt");
                        }
                }
            } else {
                String failMsg = "Access Denied, Login with Valid Credentials";
                Validation.setAttributes(request, Validation.ERROR, failMsg);
                response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            }
        }catch (Exception e) {

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
            Logger.getLogger(AdminServlet.class.getName()).log(Level.FATAL, null, ex);
        } catch (InvalidKeySpecException ex) {
            Logger.getLogger(AdminServlet.class.getName()).log(Level.FATAL, null, ex);
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
            Logger.getLogger(AdminServlet.class.getName()).log(Level.FATAL, null, ex);
        } catch (InvalidKeySpecException ex) {
            Logger.getLogger(AdminServlet.class.getName()).log(Level.FATAL, null, ex);
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
