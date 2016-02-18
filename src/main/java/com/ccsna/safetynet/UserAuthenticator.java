/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.safetynet;

import com.ccsna.ccsna.Member;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

public class UserAuthenticator {

    private static final Logger log = Logger.getRootLogger();
    public static final String LOGGEDIN_USER = "loggedInUser";
    public static final String USERNAME = "memName";
    public static final String ROLE = "role";

    /**
     * This function returns the mem who has logged in
     *
     * @param session
     * @return Member
     */
    public static Member loggedInUser(HttpSession session) {
        try {

            Member mem = (Member) session.getAttribute(LOGGEDIN_USER);
            return mem;
        } catch (Exception e) {
            log.info("logged in mem not found");
        }
        return null;
    }

    public static void setUser(HttpServletRequest request, Member mem) {
        HttpSession session = request.getSession();
        try {
            
            session.setAttribute(LOGGEDIN_USER, mem);

        } catch (Exception e) {
        }

    }

    /**
     * This function returns the mem who has logged in
     *
     * @param request
     * @return memberID
     */
    public static Member getUserSession(HttpServletRequest request) {
        HttpSession session = request.getSession();
        try {
            //Get the User who has login in the current session
            Member mem = loggedInUser(session);
            if (mem != null) {
                return mem; //Returns the memId
            }
        } catch (Exception e) {
        }
        //Return null if no mem is found
        return null;
    }

    /**
     * indicates whether a mem is logged in
     *
     * @param session
     * @return boolean indicated if login/not
     */
    public static boolean hasLogin(HttpSession session) {
        boolean isLoggedIn = true;
        try {

            //Get the User
            Member mem = loggedInUser(session);
            //If Null
            if (mem == null) {
                return false;//Temp value
            } else {
                //Return the status of the mem
                return isLoggedIn;
            }
        } catch (Exception e) {
        }
        return false; //temp value
    }

    //destroys session when a member logs out
    public static boolean logoutClient(HttpServletRequest request) {
        log.info("Requested to Logout");
        // Date logOutDate = DateTimeUtil.getCurSqlDate();
        try {
            HttpSession session = request.getSession();
            session.invalidate();
        } catch (Exception e) {
            log.info("Logout Failed");
            return false;
        }
        log.info("Logout Successful");
        return true;
    }
    
    //check if user is logged in otherwise redirect to login page;
    

}
