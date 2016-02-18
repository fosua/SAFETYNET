/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.safetynet;

import com.ccsna.ccsna.Member;
import com.ccsna.ccsna.News;
import com.ccsna.ccsna.NewsModel;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

/**
 *
 * @author estelle
 */
@WebServlet(name = "NewsServlet", urlPatterns = {"/news/add"})
public class NewsServlet extends HttpServlet {

    private static final Logger log = Logger.getRootLogger();
    private final static String JPEG = "image/jpeg";
    private final static String JPG = "image/jpg";
    private final static String PDF = "application/pdf";
    private final static String JPEG_EXTENSION = "jpg";
    private final static String PDF_EXTENSION = "pdf";

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
            String smallUrl = "", largeUrl = "", message = "", title = "", content = "", startDate = "", endDate = "", newsType = "", st = "", endTime = "", startTime = "", fileType = null;

            Date sDate = null, eDate = null;
            Time eTime = null, sTime = null;
            int action = 0, newsId = 0;
            boolean dataValid = true;
            News news = null;
            String fullPath = null;
            Member loggedInMember = UserAuthenticator.loggedInUser(request.getSession());
            if (loggedInMember != null) {
                String createdBy = String.valueOf(loggedInMember.getMemberId());
                boolean isMultipart = ServletFileUpload.isMultipartContent(request);
                log.info("isMultipart :" + isMultipart);
                if (isMultipart) {
                    FileItemFactory factory = new DiskFileItemFactory();
                    ServletFileUpload upload = new ServletFileUpload(factory);
                    String appPath = request.getServletContext().getRealPath("");

                    //String glassfishInstanceRootPropertyName = "com.sun.aas.instanceRoot";
                    //String instanceRoot = System.getProperty(glassfishInstanceRootPropertyName) + "/applications/user-pix/";
                    try {
                        List items = upload.parseRequest(request);
                        Iterator iterator = items.iterator();
                        while (iterator.hasNext()) {
                            FileItem item = (FileItem) iterator.next();
                            if (!item.isFormField()) {
                                //log.info("item is form field");
                                String fileName = item.getName();
                                //log.info("the name of the item is :" + fileName);
                                String contentType = item.getContentType();
                                //log.info("the content type is :" + contentType);
                                if (item.getContentType().equalsIgnoreCase(JPEG) || item.getContentType().equalsIgnoreCase(JPG) || item.getContentType().equalsIgnoreCase(PDF)) {
                                    String root = appPath;
                                    log.info("pdf content recognised");
                                    log.info("root path is :" + appPath);
                                    //String smallLoc = "/uploads/small";
                                    String largeLoc = "/uploads/large";
                                    log.info("largeLoc:" + largeLoc);
                                    //File pathSmall = new File(root + smallLoc);
                                    File pathLarge = new File(root + largeLoc);
                                    //log.info("small image path :" + pathSmall);
                                    log.info("large image path :" + pathLarge);
                                    if (!pathLarge.exists()) {
                                        // boolean status = pathSmall.mkdirs();
                                        pathLarge.mkdirs();
                                    }
                                    if (item.getContentType().equalsIgnoreCase(PDF)) {
                                        log.info("loading pdf file");
                                        fileType = Menu.PDF;
                                        fileName = createdBy + "_" + System.currentTimeMillis() + "." + PDF_EXTENSION;

                                        //File uploadedFileSmall = new File(pathSmall + "/" + fileName);
                                        File uploadedFileLarge = new File(pathLarge + "/" + fileName);
                                        Menu.uploadPdfFile(item.getInputStream(), uploadedFileLarge);

                                    } else {
                                        fileType = Menu.IMAGE;
                                        fileName = createdBy + "_" + System.currentTimeMillis() + "." + JPEG_EXTENSION;

                                        log.info("filename is : " + fileName);
                                        // File uploadedFileSmall = new File(pathSmall + "/" + fileName);
                                        File uploadedFileLarge = new File(pathLarge + "/" + fileName);
                                        //Menu.resizeImage(item.getInputStream(), 160, uploadedFileSmall);
                                        Menu.resizeImage(item.getInputStream(), 160, uploadedFileLarge);
                                    }
                                    //smallUrl = smallLoc + "/" + fileName + "";
                                    largeUrl = largeLoc + "/" + fileName + "";
                                    log.info("largeUrl image url is :" + largeUrl);
                                    
                                    fullPath = request.getContextPath() + "/" +largeUrl;

                                }
                            } else {
                                if (item.getFieldName().equalsIgnoreCase("newsTitle")) {
                                    title = item.getString();
                                    log.info("title is :" + title);
                                }
                                if (item.getFieldName().equalsIgnoreCase("type")) {
                                    newsType = item.getString();
                                    log.info("newsType is :" + newsType);
                                }
                                if (item.getFieldName().equalsIgnoreCase("content")) {
                                    content = item.getString();
                                    log.info("content is :" + content);
                                }
                                if (item.getFieldName().equalsIgnoreCase("start_Date")) {
                                    startDate = item.getString();
                                    if (startDate != null && !startDate.isEmpty()) {
                                        sDate = Menu.convertDateToSqlDate(Menu.stringToDate(startDate, "yyyy-MM-dd"));
                                    }
                                    log.info("startDate is :" + startDate);
                                }
                                if (item.getFieldName().equalsIgnoreCase("end_Date")) {
                                    endDate = item.getString();
                                    if (endDate != null && !endDate.isEmpty()) {
                                        eDate = Menu.convertDateToSqlDate(Menu.stringToDate(endDate, "yyyy-MM-dd"));
                                    }
                                    log.info("endDate is :" + endDate);
                                }
                                if (item.getFieldName().equalsIgnoreCase("action")) {
                                    action = Integer.parseInt(item.getString());
                                    log.info("the action is :" + action);
                                }
                                if (item.getFieldName().equalsIgnoreCase("newsId")) {
                                    newsId = Integer.parseInt(item.getString());
                                    log.info("the newsid is :" + newsId);
                                }
                                if (item.getFieldName().equalsIgnoreCase("status")) {
                                    st = item.getString();
                                    log.info("the status is :" + st);
                                }
                                if (item.getFieldName().equalsIgnoreCase("end_Time")) {
                                    endTime = item.getString();
                                    if (endTime != null && !endTime.isEmpty()) {
                                        eTime = Menu.convertStringToSqlTime(endTime);
                                    }
                                    log.info("eTime is :" + eTime);

                                }

                                if (item.getFieldName().equalsIgnoreCase("start_Time")) {
                                    startTime = item.getString();
                                    if (startTime != null && !startTime.isEmpty()) {
                                        sTime = Menu.convertStringToSqlTime(startTime);
                                    }
                                    log.info("sTime is :" + sTime);

                                }
                            }
                        }
                    } catch (FileUploadException e) {
                        e.printStackTrace();
                    }
                }
                switch (Validation.Actions.values()[action]) {
                    case CREATE:
                        log.info("creating new serlvet ................");
                {
                  
                    news = new NewsModel().addNews(title, newsType, content, sDate, eDate, new Date(), createdBy, Menu.ACTIVE, largeUrl, fileType, fullPath);
                }
                        if (news != null) {
                            log.info("news successfully created...");
                            message += "News item has been successfully added";
                            Validation.setAttributes(request, Validation.SUCCESS, message);
                            response.sendRedirect(request.getContextPath() + "/admin/management.jsp");
                        } else {
                            log.info("news creating failed...");
                            message += "Unable to add news item";
                            Validation.setAttributes(request, Validation.ERROR, message);
                           response.sendRedirect(request.getContextPath() + "/admin/management.jsp");
                        }
                        break;
                    case UPDATE:
                        log.info("updating news ...");
                        if (title != null && !title.isEmpty()) {
                            news = new NewsModel().findByParameter("title", title);
                        }

                        if (news != null && (news.getNewsId() == newsId)) {
                            log.info("news is :" + news.getNewsId());
                            dataValid = true;
                        } else {
                            dataValid = false;
                        }
                        if (news == null) {
                            dataValid = true;
                        }

                        log.info("dataValid is :" + dataValid);

                        if (dataValid) {
                            boolean newsUpdated = new NewsModel().updateNews(newsId, title, newsType, content, sDate, eDate, createdBy, st, largeUrl, smallUrl, sTime, eTime);
                            if (newsUpdated) {
                                message += "News/Alert has been successfully updated";
                                Validation.setAttributes(request, Validation.SUCCESS, message);
                                response.sendRedirect(request.getContextPath() + "/admin/management.jsp");

                            } else {
                                message += "Unable to update news item";
                                Validation.setAttributes(request, Validation.ERROR, message);
                                response.sendRedirect(request.getContextPath() + "/admin/newsEdit.jsp?id=" + newsId);
                            }
                        } else {
                            message += "News with same title already exist, Enter a different title";
                            Validation.setAttributes(request, Validation.ERROR, message);
                            response.sendRedirect(request.getContextPath() + "/admin/newsEdit.jsp?id=" + newsId);
                        }
                        break;
                }
            } else {
                message += "Session expired, Kindly login with username and password";
                Validation.setAttributes(request, Validation.ERROR, message);
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        } catch (Exception e) {

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
