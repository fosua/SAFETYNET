/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.safetynet;

import com.ccsna.ccsna.Agency;
import com.ccsna.ccsna.County;
import com.ccsna.ccsna.ServiceModel;
import com.ccsna.ccsna.Services;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import javax.imageio.ImageIO;
import org.apache.log4j.Logger;

/**
 *
 * @author Esther Amo-Nyarko <estelle_7@ymail.com>
 * Oct-09-2015 12:00:00 AM
 */
public class Menu {

    private static final Logger log = Logger.getRootLogger();
    public static final String AGENCY_ADMIN = "Agency Admin";
    public static final String SUPER_ADMIN = "Super Admin";
    public static final String MEMBER = "Member";
    public static final String NEWS = "News";
    public static final String ALERT = "Alert";
    public static final String EVENT = "Event";
    public static final String ANNOUNCEMENT = "Announcement";
    public static final String INACTIVE = "Inactive";
    public static final String ACTIVE = "Active";
    public static final String EDUCATION = "Education";
    public static final String CLOTHING = "Clothing";
    public static final String CHILDREN = "Children";
    public static final String DISASTER_RELIEF_SERVICES = "Disaster Relief Services";
    public static final String FINANCIAL_ASSISTANCE = "Financial Assistance";
    public static final String FOOD = "Food";
    public static final String HEALTHCARE_DISABILITY = "Healthcare/Disability";
    public static final String OTHER = "Other";
    public static final String PERSONAL_CARE_ITEMS = "Personal Care Items";
    public static final String SHELTER = "Shelter";
    public static final String TRANSPORTATION = "Transportation";
    public static final String STRING_DATE_FORMAT = "MM-dd-yyyy";
    public static final String APPROVED = "Approved";
    public static final String DENIED = "Denied";
    public static final String PENDING = "Pending";
    public static final String PDF = "pdf";
    public static final String IMAGE = "image";

    private static String selected() {
        return " selected=\"selected\" ";
    }

    private static String isSelected(String value, String selected) {

        return (value.equalsIgnoreCase(selected)) ? selected() : "";
    }

    //get all the counties served and put in a drop down
    public static List<String> roles() {
        ArrayList<String> roles = new ArrayList();
        roles.add(AGENCY_ADMIN);
        roles.add(SUPER_ADMIN);
        roles.add(MEMBER);
        return roles;
    }

    public static List<String> approvalStatus() {
        ArrayList<String> approval_Status = new ArrayList();
        approval_Status.add(PENDING);
        approval_Status.add(APPROVED);
        approval_Status.add(DENIED);
        return approval_Status;
    }

    public static List<String> agencyRoles() {
        ArrayList<String> roles = new ArrayList();
        roles.add(AGENCY_ADMIN);
        roles.add(MEMBER);
        return roles;
    }

    public static String selectedRolesMenu(String selected) {
        String w = "";
        List<String> roles = roles();
        for (String rol : roles) {
            w += "<option value=\"" + rol + "\" " + isSelected(rol, selected) + ">" + rol + "</option>";
        }

        return w;
    }

    public static List<String> getServices() {
        ArrayList<String> services = new ArrayList();
        List serv = new ServiceModel().listServices();
        for (Iterator iterator = serv.iterator(); iterator.hasNext();) {
            Services servList = (Services) iterator.next();
            services.add(servList.getServiceName());

        }
        return services;
    }

    //get list of all services and put in a select box
    public static String servicesMenu(String selected) {
        String w = "";
        List serv = new ServiceModel().listServices();
        for (Iterator iterator = serv.iterator(); iterator.hasNext();) {
            Services servList = (Services) iterator.next();
            w += "<option value=\"" + servList.getServiceId() + "\" " + isSelected(String.valueOf(servList.getServiceId()), selected) + ">" + servList.getService_Type() + " - " + servList.getServiceName() + "</option>";

        }

        return w;
    }

    public static int numOfService() {
        return getServices().size() + 1;
    }

    public static List<String> newsType() {
        ArrayList<String> news = new ArrayList();
        news.add(NEWS);
        news.add(ALERT);
        return news;
    }

    public static String selectedNewsTypeMenu(String selected) {
        String w = "";
        List<String> news = newsType();
        for (String rol : news) {
            w += "<option value=\"" + rol + "\" " + isSelected(rol, selected) + ">" + rol + "</option>";
        }

        return w;
    }

    public static List<String> statusMenu() {

        ArrayList<String> status = new ArrayList();
        status.add(ACTIVE);
        status.add(INACTIVE);;
        return status;
    }

    public static String selectedStatusMenu(String selected) {
        String w = "";
        List<String> status = statusMenu();
        for (String statu : status) {
            w += "<option value=\"" + statu + "\" " + isSelected(statu, selected) + ">" + statu + "</option>";
        }

        return w;
    }

    public static String selectedApprovalStatus(String selected) {
        String w = "";
        List<String> status = approvalStatus();
        for (String statu : status) {
            w += "<option value=\"" + statu + "\" " + isSelected(statu, selected) + ">" + statu + "</option>";
        }

        return w;
    }

    public static Date stringToDate(String str, String format) {
        DateFormat sdf = new SimpleDateFormat(format);
        Date date = null;
        try {
            date = sdf.parse(str);
        } catch (ParseException ex) {
            log.info("unable to convert string to date");
            // ex.printStackTrace();
            //Logger.getLogger(Menu.class.getName()).log(Level.FATAL, null, ex);
        }
        return date;
    }

    public static Date convertDateToSqlDate(Date date) {
        java.sql.Date sqlStartDate = new java.sql.Date(date.getTime());
        return sqlStartDate;

    }

    public static Date convertStringToTime(String time) throws ParseException {
        DateFormat sdf = new SimpleDateFormat("hh:mm aa");
        Date date = sdf.parse(time);
        return date;
    }

    public static Time convertStringToSqlTime(String time) throws ParseException {
        DateFormat sdf = new SimpleDateFormat("hh:mm aa");
        long ms = sdf.parse(time).getTime();
        Time t = new Time(ms);
        return t;
    }

    public static String convertTimeToString(Time time) throws ParseException {
        DateFormat sdf = new SimpleDateFormat("hh:mm aa");
        String t = sdf.format(time);
        return t;
    }

    public static String convertDateToString(Date date, String format) {
        String sdf = new SimpleDateFormat(format).format(date);
        return sdf;
    }

    public static String agencyAddress(Agency agency) {
        String address = "";
        Long value = 0l;
        if (agency.getStreetAddress() != null && !agency.getStreetAddress().isEmpty()) {
            address += agency.getStreetAddress() + "<br>";
        }
        if (agency.getApartmentNo() != null && !agency.getApartmentNo().isEmpty()) {
            address += "Suite/APT#" + agency.getApartmentNo() + "<br>";
        }
        if (agency.getState() != null && !agency.getState().isEmpty()) {
            address += agency.getState() + ", ";
        }
        if (agency.getCity() != null && !agency.getCity().isEmpty()) {
            address += agency.getCity() + " ";
        }
        if (agency.getZipcode() != null && (agency.getZipcode().compareTo(value) == 1)) {
            address += agency.getZipcode();
        }
        return address;
    }

    public static List<String> serviceType() {
        ArrayList<String> serType = new ArrayList();
        serType.add(EDUCATION);
        serType.add(CHILDREN);
        serType.add(CLOTHING);
        serType.add(DISASTER_RELIEF_SERVICES);
        serType.add(EVENT);
        serType.add(FINANCIAL_ASSISTANCE);
        serType.add(FOOD);
        serType.add(HEALTHCARE_DISABILITY);
        serType.add(TRANSPORTATION);
        serType.add(SHELTER);
        serType.add(PERSONAL_CARE_ITEMS);
        return serType;
    }

    //service type menu
    public static String selectedServiceType(String selected) {
        String w = "";
        List<String> serviceType = serviceType();
        for (String statu : serviceType) {
            w += "<option value=\"" + statu + "\" " + isSelected(statu, selected) + ">" + statu + "</option>";
        }

        return w;
    }

    //resize an image
    public static boolean resizeImage(InputStream is, int pMaxWidth, File file) throws IOException {
        BufferedImage sourceImage = ImageIO.read(is);
        int width = sourceImage.getWidth();
        int height = sourceImage.getHeight();
        log.info("imageIcon width: " + width + "  height: " + height + "");
        // If the image is larger than the max width, we need to resize it
        if (pMaxWidth > 0 && width > pMaxWidth) {
            // Determine the shrink ratio
            double ratio = (double) pMaxWidth / sourceImage.getWidth();
            log.info("resize ratio: " + ratio);
            height = (int) (sourceImage.getHeight() * ratio);
            width = pMaxWidth;
            log.info("imageIcon post scale width: " + width + "  height: " + height + "");
        }

        Image thumbnail = sourceImage.getScaledInstance(width, height, Image.SCALE_SMOOTH);
        BufferedImage bufferedThumbnail = new BufferedImage(width,
                height,
                BufferedImage.TYPE_INT_RGB);
        bufferedThumbnail.getGraphics().drawImage(thumbnail, 0, 0, null);
        return ImageIO.write(bufferedThumbnail, "jpeg", file);

    }

    //get all agency counties
    public static ArrayList<County> agencyCounties(Agency agency) {
        ArrayList<County> list = new ArrayList();
        Set a = agency.getCounties();
        for (Iterator iterator = a.iterator(); iterator.hasNext();) {
            County cty = (County) iterator.next();
            list.add(cty);
        }
        return list;
    }

    public static String agencyServicesMenu(String selected, int agencyId) {
        String w = "";
        ArrayList<Services> servList = new ServiceModel().agencyServiceList(agencyId);
        if (!servList.isEmpty()) {
            for (Services s : servList) {
                w += "<option value=\"" + s.getServiceId() + "\" " + isSelected(String.valueOf(s.getServiceId()), selected) + ">" + s.getService_Type() + " - " + s.getServiceName() + "</option>";
            }
        } //else {
        //w += "<option value=\"" + " " + "\" " + " " + ">" + "No Record" +"</option>";
        //}
        return w;
    }

    public static String nonAgencyServicesMenu(String selected, int agencyId) {
        String w = "";
        ArrayList<Services> servList = new ServiceModel().nonAgencyServiceList(agencyId);
        if (!servList.isEmpty()) {
            for (Services s : servList) {
                w += "<option value=\"" + s.getServiceId() + "\" " + isSelected(String.valueOf(s.getServiceId()), selected) + ">" + s.getService_Type() + " - " + s.getServiceName() + "</option>";
            }
        } else {
            w += "<option value=\"" + " " + "\" " + "No Record" + ">" + "No Record" + "</option>";
        }
        return w;
    }

    public static ArrayList<Services> agencyServices(Agency agency) {
        ArrayList<Services> list = new ArrayList();
        Set s = agency.getServiceses();
        for (Iterator iterator = s.iterator(); iterator.hasNext();) {
            Services serv = (Services) iterator.next();
            list.add(serv);
        }
        return list;
    }

    public static String getServices(ArrayList<Services> agencyServs) {
        String w = "", e = "", cl = "", ch = "", d = "", fa = "", fd = "", hd = "", p = "", sh = "", t = "", o = "";
        int eCount = 0, clCount = 0, chCount = 0, dCount = 0, faCount = 0, fdCount = 0, hdCount = 0, pCount = 0, shCount = 0, tCount = 0, oCount = 0;
        for (Services s : agencyServs) {
            if (s.getService_Type().equalsIgnoreCase(EDUCATION)) {
                eCount++;
                if (eCount > 1) {
                    e += ", " + s.getServiceName();
                } else {
                    e += s.getServiceName();
                }
            }
            if (s.getService_Type().equalsIgnoreCase(CLOTHING)) {
                clCount++;
                if (clCount > 1) {
                    cl += ", " + s.getServiceName();;
                } else {
                    cl += s.getServiceName();
                }
            }
            if (s.getService_Type().equalsIgnoreCase(CHILDREN)) {
                chCount++;
                if (chCount > 1) {
                    ch += ", " + s.getServiceName();;
                } else {
                    ch += s.getServiceName();
                }
            }
            if (s.getService_Type().equalsIgnoreCase(DISASTER_RELIEF_SERVICES)) {
                dCount++;
                if (dCount > 1) {
                    d += ", " + s.getServiceName();;
                } else {
                    d += s.getServiceName();
                }
            }
            if (s.getService_Type().equalsIgnoreCase(FINANCIAL_ASSISTANCE)) {
                faCount++;
                if (dCount > 1) {
                    fa += ", " + s.getServiceName();;
                } else {
                    fa += s.getServiceName();
                }
            }
            if (s.getService_Type().equalsIgnoreCase(FOOD)) {
                fdCount++;
                if (fdCount > 1) {
                    fd += ", " + s.getServiceName();;
                } else {
                    fd += s.getServiceName();
                }
            }
            if (s.getService_Type().equalsIgnoreCase(HEALTHCARE_DISABILITY)) {
                hdCount++;
                if (hdCount > 1) {
                    hd += ", " + s.getServiceName();;
                } else {
                    hd += s.getServiceName();
                }
            }
            if (s.getService_Type().equalsIgnoreCase(PERSONAL_CARE_ITEMS)) {
                pCount++;
                if (pCount > 1) {
                    p += ", " + s.getServiceName();;
                } else {
                    p += s.getServiceName();
                }
            }
            if (s.getService_Type().equalsIgnoreCase(SHELTER)) {
                shCount++;
                if (shCount > 1) {
                    sh += ", " + s.getServiceName();;
                } else {
                    sh += s.getServiceName();
                }
            }
            if (s.getService_Type().equalsIgnoreCase(TRANSPORTATION)) {
                tCount++;
                if (tCount > 1) {
                    t += ", " + s.getServiceName();;
                } else {
                    t += s.getServiceName();
                }
            }
            if (s.getService_Type().equalsIgnoreCase(OTHER)) {
                oCount++;
                if (oCount > 1) {
                    o += ", " + s.getServiceName();;
                } else {
                    o += s.getServiceName();
                }
            }

        }
        if (!e.isEmpty()) {
            w += " <b>" + EDUCATION + "</b> (" + e + ")";
        }
        if (!ch.isEmpty()) {
            w += " <b>" + CHILDREN + "</b> (" + ch + ")";
        }
        if (!cl.isEmpty()) {
            w += " <b>" + CLOTHING + "</b> (" + cl + ")";
        }
        if (!d.isEmpty()) {
            w += " <b>" + DISASTER_RELIEF_SERVICES + "</b> (" + d + ")";
        }
        if (!fa.isEmpty()) {
            w += " <b>" + FINANCIAL_ASSISTANCE + "</b> (" + fa + ")";
        }
        if (!fd.isEmpty()) {
            w += " <b>" + FOOD + "</b> (" + fd + ")";
        }
        if (!hd.isEmpty()) {
            w += " <b>" + HEALTHCARE_DISABILITY + "</b> (" + hd + ")";
        }

        if (!p.isEmpty()) {
            w += " <b>" + PERSONAL_CARE_ITEMS + "</b> (" + p + ")";
        }
        if (!sh.isEmpty()) {
            w += " <b>" + SHELTER + "</b> (" + sh + ")";
        }
        if (!t.isEmpty()) {
            w += " <b>" + TRANSPORTATION + "</b> (" + t + ")";
        }
        if (!o.isEmpty()) {
            w += " <b>" + OTHER + "</b> (" + o + ")";
        }
        return w;

    }

    public static void uploadPdfFile(InputStream fileInputStream, File filename) throws Exception {
        try {
            int read = 0;
            byte[] bytes = new byte[1024];

            try {
                OutputStream out = new FileOutputStream(filename);
                while ((read = fileInputStream.read(bytes)) != -1) {
                    out.write(bytes, 0, read);
                }
                out.flush();
            } catch (IOException e) {
                e.printStackTrace();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
