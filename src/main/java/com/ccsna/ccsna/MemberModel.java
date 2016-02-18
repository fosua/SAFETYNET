/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.ccsna;

import com.ccsna.safetynet.Cryptography;
import com.ccsna.safetynet.HibernateUtil;
import com.ccsna.safetynet.Menu;
import com.ccsna.safetynet.Validation;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
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
 * Sep-28-2015 12:00:00 AM
 */
public class MemberModel {

    private static final Logger log = Logger.getRootLogger();
    Member member = new Member();

    //create a member
    /**
     *
     * @param username
     * @param agency
     * @param password
     * @param lastName
     * @param firstName
     * @param emailAddress
     * @param phoneNumber
     * @param role
     * @param createdBy
     * @param title
     * @return
     * @throws java.security.NoSuchAlgorithmException
     * @throws java.security.spec.InvalidKeySpecException
     */
    public Member addMember(String username, Agency agency, String password, String lastName, String firstName, String emailAddress, Long phoneNumber, String role, String createdBy, String title) throws NoSuchAlgorithmException, InvalidKeySpecException {

        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            log.info("creating new member...");
            password = Cryptography.createHash(password);
            member = new Member(username, agency, password, lastName, firstName, title, role, phoneNumber, createdBy, new Date(), Menu.ACTIVE);
            session.save(member);
            tx.commit();

        } catch (HibernateException he) {
            //he.printStackTrace();
            if (tx != null) {
                log.info("could't create new member, rolling back");
                tx.rollback();
            }
        } finally {
            session.close();
        }

        return member;

    }

    public Member login(String usrname, String password) throws NoSuchAlgorithmException, InvalidKeySpecException {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query qry = session.createQuery("from Member where username = :username");
            qry.setParameter("username", usrname);
            member = (Member) qry.uniqueResult();
            if (member != null) {
                String storedPs = member.getPassword();
                boolean validPassword = Cryptography.validatePassword(password, storedPs);
                if (!validPassword) {
                    return null;
                }
            } else {
                return null;
            }
        } catch (HibernateException he) {
            he.printStackTrace();
            log.warn("could not find user with username :" + usrname);
        } finally {
            session.close();
        }
        return member;

    }

    public ArrayList<Member> memberList() {
        ArrayList<Member> list = null;
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            List counties = session.createQuery("FROM Member ORDER BY memberID DESC").list();
            for (Iterator iterator = counties.iterator(); iterator.hasNext();) {
                Member mem = (Member) iterator.next();
                list.add(mem);
            }
            tx.commit();
        } catch (Exception he){ 
            he.printStackTrace();
            if (tx != null) {
                log.info("could not retrieve member list,  rolling back");
                tx.rollback();
            }

        } finally {
            session.close();
        }
        return list;
    }

    public Member emailExist(String emailAddress) {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query qry = session.createQuery("from Member where emailAddress = :email");
            qry.setParameter("email", emailAddress);
            member = (Member) qry.uniqueResult();
            tx.commit();
            return member;
        } catch (HibernateException he) {
            log.info("Unable to find email");
        } finally {
            session.close();
        }
        return member;

    }

    //find member by id
    public Member findById(Integer id) {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            member = (Member) session.get(Member.class, id);
            tx.commit();
            return member;
        } catch (HibernateException he) {
            //he.printStackTrace();
            log.info("Unable to find user with id :" + id);
        } finally {
            session.close();
        }
        return member;

    }

    public boolean update(String username, String password, String lastName, String firstName, String emailAddress, String phoneNumber, String role, String updatedBy, String title, int memberId, String status) throws NoSuchAlgorithmException {
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            member = (Member) session.get(Member.class, memberId);
            if (member == null) {
                log.warn("could not find user with id:" + memberId);
                return false;
            } else {
                if (!Validation.checkNullity(username)) {
                    member.setUsername(username);
                }
                if (!Validation.checkNullity(password)) {
                    try {
                        password = Cryptography.createHash(password);
                    } catch (InvalidKeySpecException e) {
                        log.warn("unable to hash password");
                        return false;
                    }
                    member.setPassword(password);
                }
                if (!Validation.checkNullity(lastName)) {
                    member.setLastName(lastName);
                }
                if (!Validation.checkNullity(firstName)) {
                    member.setFirstName(firstName);
                }
                if (!Validation.checkNullity(emailAddress)) {
                    member.setEmailAddress(emailAddress);
                }
                if (!Validation.checkNullity(phoneNumber)) {
                    member.setPhoneNumber(Long.parseLong(phoneNumber));
                }
                if (!Validation.checkNullity(title)) {
                    member.setTitle(title);
                }
                if (!Validation.checkNullity(updatedBy)) {
                    member.setUpdatedBy(updatedBy);
                }
                member.setDateUpdated(new Date());
                if (!Validation.checkNullity(status)) {
                    member.setStatus(status);
                }
            }
            session.update(member);
            tx.commit();
        } catch (HibernateException he) {
            log.warn("Unable to update user with id :" + memberId);
            return false;
        } finally {
            session.close();
        }
        return true;
    }

    //find members of an agency
    public ArrayList<Member> AgencyMemberList(int agencyId) {
        ArrayList<Member> list = new ArrayList();
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query qry = session.createQuery("FROM Member where agencyID = :agencyID ORDER BY dateCreated DESC");
            qry.setParameter("agencyID", agencyId);
            List memb = qry.list();
            for (Iterator iterator = memb.iterator(); iterator.hasNext();) {
                Member mem = (Member) iterator.next();
                list.add(mem);
            }
            tx.commit();
        } catch (Exception he) {
            he.printStackTrace();
            if (tx != null) {
                log.info("could not retrieve member list,  rolling back");
                tx.rollback();
            }

        } finally {
            session.close();
        }
        return list;
    }

    //find members of an agency
    public ArrayList<String> getToEmails(String emailAddress) {
        ArrayList<String> list = new ArrayList();
        Session session = HibernateUtil.sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query qry = session.createQuery("FROM Member where emailAddress != :emailAddress ");
            qry.setParameter("emailAddress", emailAddress);
            List memb = qry.list();
            for (Iterator iterator = memb.iterator(); iterator.hasNext();) {
                Member mem = (Member) iterator.next();
                list.add(mem.getEmailAddress());
            }
            tx.commit();
        } catch (Exception he) {
            he.printStackTrace();
            if (tx != null) {
                log.info("could not retrieve email list,rolling back");
                tx.rollback();
            }

        } finally {
            session.close();
        }
        return list;
    }

}
