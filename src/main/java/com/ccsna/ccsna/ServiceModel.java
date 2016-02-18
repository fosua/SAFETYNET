/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.ccsna;

import com.ccsna.safetynet.HibernateUtil;
import com.ccsna.safetynet.Validation;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Esther Amo-Nyarko <estelle_7@ymail.com>
 * Oct-07-2015 12:00:00 AM
 */
public class ServiceModel {

    private static final Logger log = Logger.getRootLogger();
    Services service = new Services();

    //add a new service 
    public Services addService(String serviceName, String createdBy, String type) {

        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        //Integer servId = null;
        try {
            tx = session.beginTransaction();
            System.out.println("creating new service...");
            service.setServiceName(serviceName);
            service.setCreatedBy(createdBy);
            service.setDateCreated(new Date());
            service.setService_Type(type);
            session.save(service);
            tx.commit();

        } catch (HibernateException he) {
            if (tx != null) {
                System.out.println("could't create new service, rolling back");
                tx.rollback();
            } else {

                System.out.println("the id for this service is :" + service.getServiceId());
            }
        } finally {
            session.close();
        }
        return service;
    }

    //get a list of all services in the database
    public List listServices() {

        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        List services = null;
        try {
            tx = session.beginTransaction();
            services = session.createQuery("FROM Services").list();
            tx.commit();
        } catch (HibernateException he) {
            if (tx != null) {
                System.out.println("could not retrieve list of services");
                tx.rollback();
            }
            he.printStackTrace();
        } finally {
            session.close();
        }
        return services;
    }

    //get list of services and returns as Services object
    public ArrayList<Services> serviceList() {
        ArrayList<Services> list = new ArrayList();
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            List services = session.createQuery("FROM Services ORDER BY service_ID DESC").list();
            for (Iterator iterator = services.iterator(); iterator.hasNext();) {
                Services serv = (Services) iterator.next();
                list.add(serv);
            }
            tx.commit();
        } catch (Exception he) {
            if (tx != null) {
                System.out.println("could not retrieve service list,  rolling back");
                tx.rollback();
            }

        } finally {
            session.close();
        }
        return list;
    }

    //get service object by id
    public Services getById(int id) {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            service = (Services) session.get(Services.class, id);
            tx.commit();
        } catch (Exception he) {
            if (tx != null) {
                System.out.println("unable to retrieve service with id " + id);
                tx.rollback();
            }
        } finally {
            session.close();
        }
        return service;
    }

    public boolean updateService(int id, String serviceName, String serviceType, String upDatedBy) {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            service = (Services) session.get(Services.class, id);
            if (service == null) {
                log.warn("could not find service with id:" + id);
                return false;
            } else {
                if (!Validation.checkNullity(serviceName)) {
                    service.setServiceName(serviceName);
                }
                if (!Validation.checkNullity(serviceType)) {
                    service.setService_Type(serviceType);
                }
                if (!Validation.checkNullity(upDatedBy)) {
                    service.setUpdatedBy(upDatedBy);
                }
                service.setDateUpdated(new Date());
            }
            session.update(service);
            tx.commit();
        } catch (HibernateException he) {
            log.warn("Unable to update service with id :" + id);
            return false;
        } finally {
            session.close();
        }
        return true;
    }

    //get list of agency services
    public ArrayList<Services> agencyServiceList(int agencyId) {
        ArrayList<Services> list = new ArrayList();
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query query = session.createQuery("SELECT s FROM Services s join s.agencies a where a.agencyId = :agencyId");
            query.setParameter("agencyId", agencyId);
            List services = query.list();
            for (Iterator iterator = services.iterator(); iterator.hasNext();) {
                Services serv = (Services) iterator.next();
                list.add(serv);
            }
            tx.commit();
        } catch (Exception he) {
            if (tx != null) {
                System.out.println("could not retrieve service list,  rolling back");
                tx.rollback();
            }
            he.printStackTrace();

        } finally {
            session.close();
        }
        return list;
    }

    //get list of services and returns as Services object
    public ArrayList<Services> nonAgencyServiceList(int agencyId) {
        ArrayList<Services> list = new ArrayList();
        ArrayList<Services> agencyList = agencyServiceList(agencyId);
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            List services = session.createQuery("FROM Services ORDER BY service_ID DESC").list();
            for (Iterator iterator = services.iterator(); iterator.hasNext();) {
                Services serv = (Services) iterator.next();
                if (!agencyList.contains(serv)) {
                    list.add(serv);
                }
            }
            tx.commit();
        } catch (Exception he) {
            if (tx != null) {
                System.out.println("could not retrieve service list,  rolling back");
                tx.rollback();
            }

        } finally {
            session.close();
        }
        return list;
    }

}
