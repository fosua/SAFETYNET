/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.ccsna;

import com.ccsna.safetynet.HibernateUtil;
import com.ccsna.safetynet.Menu;
import com.ccsna.safetynet.Validation;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author estelle
 */
public class AgencyModel {

    private static final Logger log = Logger.getRootLogger();
    Agency agency = new Agency();

    //add a new service 
    public Agency addAgency(String agencyName, String webAddress, String emailAddress, String streetAddress, String apartmentNo, String city,
            String state, Long zipcode, Long privateContactNo, Set counties, Set services, String createdBy, String mission, String hoursOfOperation, String boardPositions, String requiredVerification, Long publicContactNumber) {

        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            log.info("creating new agency...");
            agency = new Agency(agencyName, streetAddress, apartmentNo, city, state, zipcode, privateContactNo, webAddress, new Date(), createdBy, mission, hoursOfOperation, requiredVerification, boardPositions, Menu.ACTIVE, publicContactNumber, emailAddress);
            //agency.setServiceses(services);
            agency.setCounties(counties);
            session.save(agency);
            tx.commit();

        } catch (HibernateException he) {
            //he.printStackTrace();
            if (tx != null) {
                log.info("could't create new agency, rolling back");
                tx.rollback();
            }
        } finally {
            session.close();
        }
        return agency;
    }

    //get the list of all agencies
    public ArrayList<Agency> listAgency() {
        ArrayList<Agency> list = new ArrayList();
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            List agencies = session.createQuery("FROM Agency ORDER BY date_Created DESC").list();
            if (null != agencies && !agencies.isEmpty()) {
                for (Iterator iterator = agencies.iterator(); iterator.hasNext();) {
                    Agency agcy = (Agency) iterator.next();
                    list.add(agcy);
                }
            } else {
                return null;
            }
            tx.commit();
        } catch (Exception he) {
            if (tx != null) {
                log.info("could not retrieve agency list,  rolling back");
                tx.rollback();
            }

        } finally {
            session.close();
        }
        return list;
    }

    //get agency by id
    public Agency findById(int id) {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            agency = (Agency) session.get(Agency.class, id);
            tx.commit();
        } catch (Exception he) {
            if (tx != null) {
                log.info("unable to retrieve agency with id " + id);
                tx.rollback();
            }
        } finally {
            session.close();
        }
        return agency;
    }

    //update agency 
    public boolean update(int id, String fullName, String streetAddress, String aptNo, String city, String state, Long zipcode,
            Long privateContactNo, String webUrl, String mission, String hours_Of_Operation, String required_Verification,
            String boardPostions, String status, String emailAddress, Long publicPhoneNo, String updatedBy, Set counties, String[] services) {

        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        long value = 0l;
        try {
            tx = session.beginTransaction();
            agency = findById(id);
            if (agency == null) {
                log.warn("could not find agency with id:" + id);
                return false;
            } else {
                log.info("beginning update ... ");
                if (!Validation.checkNullity(fullName)) {
                    agency.setFullname(fullName);
                }
                if (!Validation.checkNullity(streetAddress)) {
                    agency.setStreetAddress(streetAddress);
                }
                if (!Validation.checkNullity(aptNo)) {
                    agency.setApartmentNo(aptNo);
                }
                if (!Validation.checkNullity(city)) {
                    agency.setCity(city);
                }
                if (!Validation.checkNullity(state)) {
                    agency.setState(state);
                }
                if (zipcode != null && (zipcode.compareTo(value)) == 1) {
                    agency.setZipcode(zipcode);
                }
                if (privateContactNo != null && (privateContactNo.compareTo(value)) == 1) {
                    agency.setPrivateContactNumber(privateContactNo);
                }
                if (!Validation.checkNullity(webUrl)) {
                    agency.setWebsiteAddress(webUrl);
                }
                if (!Validation.checkNullity(mission)) {
                    agency.setMission(mission);
                }
                if (!Validation.checkNullity(hours_Of_Operation)) {
                    agency.setHoursOfOperation(hours_Of_Operation);
                }
                if (!Validation.checkNullity(required_Verification)) {
                    agency.setRequiredVerification(required_Verification);
                }
                if (!Validation.checkNullity(boardPostions)) {
                    agency.setBoardPositions(boardPostions);
                }
                if (!Validation.checkNullity(status)) {
                    agency.setStatus(status);
                }
                if (!Validation.checkNullity(emailAddress)) {
                    agency.setEmailAddress(emailAddress);
                }
                if (publicPhoneNo != null && (publicPhoneNo.compareTo(value)) == 1) {
                    agency.setPublicContactNumber(publicPhoneNo);
                }
                agency.setUpdatedBy(updatedBy);
                agency.setDateUpdated(new Date());
                //clear all the counties
                agency.getCounties().clear();

                //add all the counties
                if (counties != null && !counties.isEmpty()) {
                    agency.setCounties(counties);
                }
            }
            session.update(agency);
            tx.commit();
        } catch (Exception he) {
            if (tx != null) {
                log.info("unable to update agency with " + id);
                tx.rollback();
                return false;
            }
        } finally {
            session.close();
        }
        return true;
    }

//delete agency counties
    public Agency delAgencyCounty(Agency agency) {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            agency.getCounties().clear();
            session.update(agency);
            tx.commit();
        } catch (Exception he) {
            if (tx != null) {
                log.info("unable to delete agency counties");
                tx.rollback();
            }
        } finally {
            session.close();
        }
        return agency;
    }

    //update services
    public boolean update(int id, Set services) {

        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        long value = 0l;
        try {
            tx = session.beginTransaction();
            agency = findById(id);
            if (agency == null) {
                log.warn("could not find agency with id:" + id);
                return false;
            } else {
                log.info("beginning update ... ");
                agency.getServiceses().clear();

                //add all the services
                agency.setServiceses(services);
            }
            session.update(agency);
            tx.commit();
        } catch (Exception he) {
            if (tx != null) {
                log.info("unable to update agency with " + id);
                tx.rollback();
                return false;
            }
        } finally {
            session.close();
        }
        return true;
    }

    //update agency 
    public boolean updateStatus(int id, String status) {

        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        long value = 0l;
        try {
            tx = session.beginTransaction();
            agency = findById(id);
            if (agency == null) {
                log.warn("could not find agency with id:" + id);
                return false;
            } else {
                log.info("updating status ... ");
                if (!Validation.checkNullity(status)) {
                    agency.setStatus(status);
                }
            }
            session.update(agency);
            tx.commit();
        } catch (Exception he) {
            if (tx != null) {
                log.info("unable to update agency with " + id);
                tx.rollback();
                return false;
            }
        } finally {
            session.close();
        }
        return true;
    }

}
