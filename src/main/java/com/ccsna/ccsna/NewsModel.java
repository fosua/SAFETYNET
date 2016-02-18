/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.ccsna;

import com.ccsna.safetynet.HibernateUtil;
import com.ccsna.safetynet.Menu;
import com.ccsna.safetynet.SendEmail;
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
public class NewsModel {

    private static Logger log = Logger.getRootLogger();

    public News addNews(String title, String newsType, String content, Date startDate, Date endDate, Date dateCreated, String createdBy, String status, String largeFileName, String fileType, String fullPath) {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        News newNews = null;

        try {
            tx = session.beginTransaction();
            System.out.println("creating new announcement/news/alert/event...");
            newNews = new News(title, newsType, content, startDate, endDate, dateCreated, createdBy, status, largeFileName, fileType);
            session.save(newNews);
            tx.commit();

            if (newsType.equalsIgnoreCase(Menu.ALERT)) {
                String from = new MemberModel().findById(Integer.parseInt(createdBy)).getEmailAddress();
                List<String> toEmails = new MemberModel().getToEmails(from);
                SendEmail.sendEmail(from, title, toEmails, content, fullPath, fileType);
            }

        } catch (HibernateException he) {
            if (tx != null) {
                System.out.println("could't create new News, rolling back");
                tx.rollback();
            }
        } finally {
            session.close();
        }

        return newNews;
    }

    public ArrayList<News> newsList() {
        ArrayList<News> list = new ArrayList();
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            List newsList = session.createQuery("FROM News ORDER BY news_ID DESC").list();
            for (Iterator iterator = newsList.iterator(); iterator.hasNext();) {
                News news = (News) iterator.next();
                list.add(news);
            }
            tx.commit();
        } catch (Exception he) {
            if (tx != null) {
                System.out.println("could not retrieve news list,  rolling back");
                tx.rollback();
            }

        } finally {
            session.close();
        }
        return list;
    }

    //check if title already exist
    public News titleExist(String newsTitle) {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        News newNews = null;
        try {
            tx = session.beginTransaction();
            Query qry = session.createQuery("from News where title = :title");
            qry.setParameter("title", newsTitle);
            newNews = (News) qry.uniqueResult();
            System.out.println("news with title " + newsTitle + "found");
            tx.commit();
            return newNews;
        } catch (HibernateException he) {
            he.printStackTrace();
            log.info("Unable to find news title");
        } finally {
            session.close();
        }
        return newNews;

    }

    //update news item
    public boolean updateNews(int id, String title, String newsType, String content, Date startDate, Date endDate, String upDatedBy, String status, String largeFileUrl, String smallFileUrl, java.sql.Time startTime, java.sql.Time endTime) {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            News news = (News) session.get(News.class, id);
            if (news == null) {
                log.warn("could not find news with id:" + id);
                return false;
            } else {
                if (!Validation.checkNullity(newsType)) {
                    news.setNewsType(newsType);
                }
                if (!Validation.checkNullity(title)) {
                    news.setTitle(title);
                }
                if (!Validation.checkNullity(content)) {
                    news.setContent(content);
                }
                if (startDate != null) {
                    news.setStartDate(startDate);
                }
                if (endDate != null) {
                    news.setEndDate(endDate);
                }
                if (!Validation.checkNullity(upDatedBy)) {
                    news.setUpdatedBy(upDatedBy);
                }
                if (!Validation.checkNullity(status)) {
                    news.setStatus(status);
                }
                if (!Validation.checkNullity(largeFileUrl)) {
                    news.setLarge_File_Name(largeFileUrl);
                }
                news.setDateUpdated(new Date());
            }
            session.update(news);
            tx.commit();
        } catch (HibernateException he) {
            log.warn("Unable to update news with id :" + id);
            he.printStackTrace();
            return false;
        } finally {
            session.close();
        }
        return true;
    }

    public News findByParameter(String fieldName, String fieldValue) {
        log.info("finding " + fieldName + " by " + fieldValue);
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        News newNews = null;
        try {
            tx = session.beginTransaction();
            Query qry = session.createQuery("from News where " + fieldName + " = :" + fieldName);
            qry.setParameter(fieldName, fieldValue);
            newNews = (News) qry.uniqueResult();
            tx.commit();
            return newNews;
        } catch (HibernateException he) {
            log.info("Unable to find news title with field name :" + fieldName);
        } finally {
            session.close();
        }
        return newNews;

    }

    //find member by id
    public News findById(Integer id) {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        News news = null;
        try {
            tx = session.beginTransaction();
            news = (News) session.get(News.class, id);
            tx.commit();
            return news;
        } catch (HibernateException he) {
            //he.printStackTrace();
            log.info("Unable to find news with id :" + id);
        } finally {
            session.close();
        }
        return news;

    }

    public ArrayList<News> findNewsList(String fieldName, String fieldValue, int start, int limit) {
        ArrayList<News> list = new ArrayList();
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        News newNews = null;
        try {
            tx = session.beginTransaction();
            Query qry = session.createQuery("from News where " + fieldName + " = :" + fieldName + " and status = :status" + " ORDER BY date_Created DESC ").setFirstResult(start).setMaxResults(limit);
            qry.setParameter(fieldName, fieldValue);
            qry.setParameter("status", Menu.ACTIVE);
            List newsList = qry.list();
            log.info("number of news item is : " + newsList.size());
            for (Iterator iterator = newsList.iterator(); iterator.hasNext();) {
                News news = (News) iterator.next();
                list.add(news);
            }
            tx.commit();
        } catch (HibernateException he) {
            log.info("Unable to find news title with field name :" + fieldName);
        } finally {
            session.close();
        }
        return list;

    }

    public ArrayList<News> findNewsList(String fieldName, String fieldValue) {
        ArrayList<News> list = new ArrayList();
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        News newNews = null;
        try {
            tx = session.beginTransaction();
            Query qry = session.createQuery("from News where " + fieldName + " = :" + fieldName + " ORDER BY date_Created DESC ");
            qry.setParameter(fieldName, fieldValue);
            List newsList = qry.list();
            for (Iterator iterator = newsList.iterator(); iterator.hasNext();) {
                News news = (News) iterator.next();
                list.add(news);
            }
            tx.commit();
        } catch (HibernateException he) {
            log.info("Unable to find news title with field name :" + fieldName);
        } finally {
            session.close();
        }
        return list;

    }

    public ArrayList<News> findByCreatedBy(String newType, String createdById) {
        log.info("created by id is : " + createdById);
        ArrayList<News> list = new ArrayList();
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        News newNews = null;
        try {
            tx = session.beginTransaction();
            Query qry = session.createQuery("from News where news_Type = :news_Type and created_By = :createdById ORDER BY date_Created DESC ");
            qry.setParameter("news_Type", newType);
            qry.setParameter("createdById", createdById);
            List newsList = qry.list();
            for (Iterator iterator = newsList.iterator(); iterator.hasNext();) {
                News news = (News) iterator.next();
                list.add(news);
            }
            tx.commit();
        } catch (HibernateException he) {
            he.printStackTrace();
            log.info("Unable to find news list");
        } finally {
            session.close();
        }
        return list;

    }
}
