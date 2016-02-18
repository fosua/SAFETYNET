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
import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author estelle
 */
public class SuccessStoryModel {
    
    private static final Logger log = Logger.getRootLogger();

    //add a success story
    public SuccessStory addSuccessStory(String fullname, String email, String agency, String content, String createdBy) {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        SuccessStory story = null;
        try {
            tx = session.beginTransaction();
            log.info("creating new success story .................");
            story = new SuccessStory(fullname, email, agency, content, new Date(), createdBy);
            session.save(story);
            tx.commit();
            
        } catch (HibernateException he) {
            //he.printStackTrace();
            if (tx != null) {
                log.info("couldn't add success story, rolling back");
                tx.rollback();
            }
            return null;
        } finally {
            session.close();
        }
        
        return story;
    }

    //list all success stories
    public ArrayList<SuccessStory> successStoryList() {
        ArrayList<SuccessStory> list = new ArrayList();
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            List stories = session.createQuery("FROM SuccessStory ORDER BY date_Created DESC").list();
            for (Iterator iterator = stories.iterator(); iterator.hasNext();) {
                SuccessStory stry = (SuccessStory) iterator.next();
                list.add(stry);
            }
            tx.commit();
        } catch (Exception he) {
           // he.printStackTrace();
            if (tx != null) {
                log.info("could not retrieve success story list,  rolling back");
                tx.rollback();
            }
            
        } finally {
            session.close();
        }
        return list;
    }
    
    public ArrayList<SuccessStory> successStoryList(int start, int limit) {
        ArrayList<SuccessStory> list = new ArrayList();
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query qry = session.createQuery("FROM SuccessStory where approval_Status = :approval_Status ORDER BY date_Created DESC ").setFirstResult(start).setMaxResults(limit);
            qry.setParameter("approval_Status", Menu.APPROVED);
            List stories = qry.list();
            //log.info("the length of the list is : "+ stories.size());
            for (Iterator iterator = stories.iterator(); iterator.hasNext();) {
                SuccessStory stry = (SuccessStory) iterator.next();
                list.add(stry);
            }
            tx.commit();
        } catch (Exception he) {
            //he.printStackTrace();
            if (tx != null) {
                log.info("could not retrieve success story list,  rolling back");
                tx.rollback();
            }
            
        } finally {
            session.close();
        }
        return list;
    }

    //get success story object by id
    public SuccessStory getById(int id) {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        SuccessStory story = null;
        try {
            tx = session.beginTransaction();
            story = (SuccessStory) session.get(SuccessStory.class, id);
            tx.commit();
        } catch (Exception he) {
            if (tx != null) {
                System.out.println("unable to retrieve success story  with id " + id);
                tx.rollback();
            }
        } finally {
            session.close();
        }
        return story;
    }
    
    public boolean update(int id, String content, String approvalStatus, String upDatedBy) {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        SuccessStory story = null;
        try {
            tx = session.beginTransaction();
            story = (SuccessStory) session.get(SuccessStory.class, id);
            if (story == null) {
                log.warn("could not find story with id:" + id);
                return false;
            } else {
                if (!Validation.checkNullity(content)) {
                    story.setContent(content);
                }
                if (!Validation.checkNullity(approvalStatus)) {
                    story.setApprovalStatus(approvalStatus);
                }
                if (!Validation.checkNullity(upDatedBy)) {
                    story.setUpdatedBy(upDatedBy);
                }
                story.setDateUpdated(new Date());
            }
            session.update(story);
            tx.commit();
        } catch (HibernateException he) {
            log.warn("Unable to update story with id :" + id);
            return false;
        } finally {
            session.close();
        }
        return true;
    }
    
    public ArrayList<SuccessStory> listApproved() {
        ArrayList<SuccessStory> list = new ArrayList();
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query qry = session.createQuery("FROM SuccessStory where approval_Status = :approval_Status ORDER BY date_Created DESC");
            qry.setParameter("approval_Status", Menu.APPROVED);
            List stories = qry.list();
            for (Iterator iterator = stories.iterator(); iterator.hasNext();) {
                SuccessStory stry = (SuccessStory) iterator.next();
                list.add(stry);
            }
            tx.commit();
        } catch (Exception he) {
            //he.printStackTrace();
            if (tx != null) {
                log.info("could not retrieve success story list,  rolling back");
                tx.rollback();
            }
            
        } finally {
            session.close();
        }
        return list;
    }
}
