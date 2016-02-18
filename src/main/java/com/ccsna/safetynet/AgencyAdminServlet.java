/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.safetynet;

import com.ccsna.ccsna.Agency;
import com.ccsna.ccsna.AgencyModel;
import com.ccsna.ccsna.CountyModel;
import com.ccsna.ccsna.Member;
import com.ccsna.ccsna.MemberModel;
import com.ccsna.ccsna.ServiceModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.HashSet;
import java.util.Set;
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
@WebServlet(name = "AgencyAdminServlet", urlPatterns = {"/agency/update"})
public class AgencyAdminServlet extends HttpServlet {

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
        try  {
            PrintWriter out = response.getWriter();
            /* TODO output your page here. You may use following sample code. */
            String message = "";
            int action = 0, id = 0;
            int option = Integer.parseInt(request.getParameter("option"));
            String act = request.getParameter("action");
            Long ppNo = 0l, pNo = 0l;
            Agency agency = null;
            if (!Validation.checkNullity(act)) {
                action = Integer.parseInt(act);
            }
            Member loggedInMember = UserAuthenticator.loggedInUser(request.getSession());
            if (loggedInMember != null) {
                switch (Validation.AdminActions.values()[option]) {
                    case AGENCY_PROFILE:
                        log.info(" updating agency ... ");
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
                        String emailAddress = request.getParameter("emailAddress");
                        String password = request.getParameter("password");
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
                        String publicPhoneNumber = request.getParameter("public_Contact_Number");
                        if (!Validation.checkNullity(publicPhoneNumber)) {
                            ppNo = Long.parseLong(publicPhoneNumber.replaceAll("\\s", ""));
                        }
                        String mission = request.getParameter("mission");
                        String requiredVerification = request.getParameter("required_Verification");
                        String boardPositions = request.getParameter("board_Positions");
                        String hoursOfOperation = request.getParameter("hours_Of_Operation");
                        String[] counties = request.getParameterValues("counties_Served");
                        String status = request.getParameter("status");
                        String[] services = request.getParameterValues("services");
                        if (counties != null && counties.length == 0) {
                            log.info("no counties was checked");
                            dataValid = false;
                            message += "Select at least one county";
                        } else {
                            for (int i = 0; i < counties.length; i++) {
                                cty.add(new CountyModel().getById(Integer.parseInt(counties[i])));
                            }
                        }

                        if (dataValid) {
                            switch (Validation.Actions.values()[action]) {
                                case CREATE:
                                    break;

                                case UPDATE:
                                    log.info("updating agency.....................");
                                    id = Integer.parseInt(request.getParameter("id"));
                                    agency = new AgencyModel().findById(id);
                                    if (agency == null) {
                                        message += "Update Failed!";
                                        Validation.setAttributes(request, Validation.ERROR, message);
                                        response.sendRedirect(request.getContextPath() + "/pages/agencyAdmin.jsp");
                                    } else {
                                        log.info("Agency found, starting update");
                                        String updatedBy = "";//String.valueOf(member.getMemberId());
                                        boolean updated = new AgencyModel().update(agency.getAgencyId(), agencyName, streetAddress, apartmentNo, city, state, zcode, ppNo, webAddress, mission, hoursOfOperation, requiredVerification, boardPositions, status, emailAddress, ppNo, updatedBy, cty, services);
                                        if (updated) {
                                            message += "Agency has been successfully updated";
                                            Validation.setAttributes(request, Validation.SUCCESS, message);
                                            response.sendRedirect(request.getContextPath() + "/pages/agencyAdmin.jsp");
                                        } else {
                                            message += "Update Failed!";
                                            Validation.setAttributes(request, Validation.ERROR, message);
                                            response.sendRedirect(request.getContextPath() + "/pages/agencyAdmin.jsp");
                                        }
                                    }
                                    break;
                            }
                        } else {
                            String failMsg = "Unable to add Agency, " + message;
                            Validation.setAttributes(request, Validation.ERROR, failMsg);
                            response.sendRedirect(request.getContextPath() + "/pages/agencyAdmin.jsp");
                        }
                        break;
                    case CHANGE_PASSWORD:
                        log.info("updating password ...........");
                        String username = request.getParameter("username");
                        String oldPassword = request.getParameter("oldPassword");
                        String newPassword = request.getParameter("newPassword");
                        id = Integer.parseInt(request.getParameter("id"));
                        Member member = new MemberModel().login(username, oldPassword);
                        if (member != null) {
                            boolean updated = new MemberModel().update(username, newPassword, "", "", "", "", "", "", "", id, "");
                            if (updated) {
                                message += "Password has been Successfully updated";
                                Validation.setAttributes(request, Validation.SUCCESS, message);
                                response.sendRedirect(request.getContextPath() + "/pages/agencyAdmin.jsp");
                            } else {
                                message += "Password update Failed, Try again later!";
                                Validation.setAttributes(request, Validation.ERROR, message);
                                response.sendRedirect(request.getContextPath() + "/pages/agencyAdmin.jsp");
                            }
                        } else {
                            message += "Password update Failed, Try again later!";
                            Validation.setAttributes(request, Validation.ERROR, message);
                            response.sendRedirect(request.getContextPath() + "/pages/agencyAdmin.jsp");
                        }
                        break;
                    case MEMBER:
                        int actions = Integer.parseInt(act);
                        username = request.getParameter("emailAddress");
                        password = request.getParameter("password");
                        String lastName = request.getParameter("lastName");
                        String firstName = request.getParameter("firstName");
                        if (Validation.checkNullity(firstName)) {
                            log.info("firstName empty");
                            message += " First name is empty";
                            dataValid = false;
                        }
                        emailAddress = request.getParameter("emailAddress");
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
                        status = request.getParameter("status");
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
                                    member = new MemberModel().addMember(username, agency, password, lastName, firstName, emailAddress, pNo, role, String.valueOf(loggedInMember.getMemberId()), title);
                                    if (member == null) {
                                        message += "New Member Creation Failed!";
                                        Validation.setAttributes(request, Validation.ERROR, message);
                                        response.sendRedirect(request.getContextPath() + "/pages/agencyAdmin.jsp");
                                    } else {
                                        log.info("Member successfully  created");
                                        message += "Member has been Successflly Added, Login with Email address and Password";
                                        Validation.setAttributes(request, Validation.SUCCESS, message);
                                        response.sendRedirect(request.getContextPath() + "/pages/agencyAdmin.jsp");
                                    }
                                    break;
                                case UPDATE:
                                    log.info("upating member ..........................");
                                    id = Integer.parseInt(request.getParameter("id"));
                                    member = new MemberModel().findById(id);
                                    if (member == null) {
                                        message += "Update Failed!";
                                        Validation.setAttributes(request, Validation.ERROR, message);
                                        response.sendRedirect(request.getContextPath() + "/pages/agencyAdmin.jsp?id=" + id);
                                    } else {
                                        log.info("Member found, starting update");
                                        String updatedBy = String.valueOf(member.getMemberId());
                                        boolean updated = new MemberModel().update(username, password, lastName, firstName, emailAddress, phoneNumber, role, String.valueOf(loggedInMember.getMemberId()), title, id, status);
                                        if (updated) {
                                            message += "Member has been successfully updated";
                                            Validation.setAttributes(request, Validation.SUCCESS, message);
                                            response.sendRedirect(request.getContextPath() + "/pages/agencyAdmin.jsp");
                                        } else {
                                            message += "Update Failed!";
                                            Validation.setAttributes(request, Validation.ERROR, message);
                                            response.sendRedirect(request.getContextPath() + "/pages/agencyMemberEdit.jsp?id=" + id);
                                        }
                                    }

                                    break;
                            }
                        } else {
                            log.warn("invalid data entered .... member creation/update failed... ");
                            String failMsg = "Unable To Complete Action, " + message;
                            Validation.setAttributes(request, Validation.ERROR, failMsg);
                            response.sendRedirect(request.getContextPath() + "/pages/agencyMemberEdit.jsp?id=" + id);
                        }
                        break;
                    case OUR_SERVICES:
                        log.info("updating/adding services ... ");
                        Set serv = new HashSet();
                        services = request.getParameterValues("ourServices");
                        id = Integer.parseInt(request.getParameter("id"));
                        if (services != null && services.length != 0) {
                            for (int i = 0; i < services.length; i++) {
                                if (services[i] != null && !(services[i].isEmpty())) {
                                    serv.add(new ServiceModel().getById(Integer.parseInt(services[i])));
                                }
                            }

                        }
                        if (serv.size() == 0) {
                            dataValid = false;
                        }
                        if (dataValid) {
                            boolean updated = new AgencyModel().update(id, serv);
                            if (updated) {
                                message += "Services has been successfully updated";
                                Validation.setAttributes(request, Validation.SUCCESS, message);
                                response.sendRedirect(request.getContextPath() + "/pages/agencyAdmin.jsp");
                            } else {
                                message += "Services update Failed";
                                Validation.setAttributes(request, Validation.ERROR, message);
                                response.sendRedirect(request.getContextPath() + "/pages/agencyAdmin.jsp");
                            }
                        } else {
                            message += "Invalid Data. Service Cannot be Empty, Services update Failed!";
                            Validation.setAttributes(request, Validation.ERROR, message);
                            response.sendRedirect(request.getContextPath() + "/pages/agencyAdmin.jsp");
                        }
                        break;
                }
            }
        }
        catch (Exception e) {

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
            java.util.logging.Logger.getLogger(AgencyAdminServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeySpecException ex) {
            java.util.logging.Logger.getLogger(AgencyAdminServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            java.util.logging.Logger.getLogger(AgencyAdminServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeySpecException ex) {
            java.util.logging.Logger.getLogger(AgencyAdminServlet.class.getName()).log(Level.SEVERE, null, ex);
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
