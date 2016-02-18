/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.ccsna;

import com.ccsna.safetynet.HibernateUtil;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author estelle
 */
public class CountyModel {

    County county = null;
    private static final Logger log = Logger.getRootLogger();

    public County getById(int id) {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            county = (County) session.get(County.class, id);
            tx.commit();
        } catch (Exception he) {
            if (tx != null) {
                System.out.println("unable to retrieve county with id " + id);
                tx.rollback();
            }
        } finally {
            session.close();
        }
        return county;
    }

    public ArrayList<County> listCounty() {
        ArrayList<County> list = null;
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            List counties = session.createQuery("FROM County").list();
            for (Iterator iterator = counties.iterator(); iterator.hasNext();) {
                County agcy = (County) iterator.next();
                list.add(agcy);
            }
            tx.commit();
        } catch (Exception he) {
            if (tx != null) {
                System.out.println("could not retrieve county list,  rolling back");
                tx.rollback();
            }

        } finally {
            session.close();
        }
        return list;
    }

    //list counties that do not belong to an agency
    public ArrayList<County> listAgencyCounty(int agencyId) {
        ArrayList<County> list = new ArrayList();
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query query = session.createQuery("SELECT c from Agency a JOIN a.counties c where a.agencyId = :agencyId");
            query.setParameter("agencyId", agencyId);
            List counties = query.list();
            for (Iterator iterator = counties.iterator(); iterator.hasNext();) {
                County agcy = (County) iterator.next();
                list.add(agcy);
            }
            tx.commit();
        } catch (Exception he) {
            he.printStackTrace();
            if (tx != null) {
                System.out.println("could not retrieve county list,  rolling back");
                tx.rollback();
            }

        } finally {
            session.close();
        }
        return list;
    }

    public ArrayList<County> nonAgencyCounty(int agencyId) {
        ArrayList<County> agcyCounties = listAgencyCounty(agencyId);
        ArrayList<County> list = new ArrayList();
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            List counties = session.createQuery("FROM County").list();
            for (Iterator iterator = counties.iterator(); iterator.hasNext();) {
                County agcy = (County) iterator.next();
                if (!agcyCounties.contains(agcy)) {
                    list.add(agcy);
                }
            }
            tx.commit();
        } catch (Exception he) {
            if (tx != null) {
                System.out.println("could not retrieve county list,  rolling back");
                tx.rollback();
            }

        } finally {
            session.close();
        }
        return list;
    }
}
