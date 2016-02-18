/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.safetynet;

import java.util.Date;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.List;
import java.util.Properties;
import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

public class SendEmail {

    private static final Logger log = Logger.getRootLogger();
    private static final String SMTP_HOST_NAME = "";
    private static final String SMTP_AUTH_USER = "";
    private static final String SMTP_AUTH_PWD = "";

    public static void sendEmail(String fromEmail, String subject, List<String> emailToAddresses, String emailBodyText, String fileName, String fileType) {

        // We will put some properties for smtp configurations
        Properties props = new Properties();

        // do not change - start
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.user", "username");
        props.put("mail.smtp.host", SMTP_HOST_NAME);
        props.put("mail.smtp.port", 587);
        // props.put("mail.debug", "true");
        props.put("mail.smtp.auth", "true");
        // do not change - end

        // we authentcate using your email and password and on successful
        // we create the session
        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(SMTP_AUTH_USER, SMTP_AUTH_PWD);
                    }
                });
        String emails = null, fileFormat = null;
        byte[] attachmentData = null; 
        HttpServletRequest request = null;
        try {
            // we create new message
            Message message = new MimeMessage(session);
            // set the from 'email address'
            message.setFrom(new InternetAddress(fromEmail));
            // set email subject
            message.setSubject(subject);

           

            //form the html content
            String content = "<html>\n<body>\n";
            content += "        <div style=\"text-align: left; font-size: 13px; width: 500px;\" >\n"
                    + "            <h3 style=\"color: red; \">Alert!!!</h3>\n"
                    + emailBodyText
                    + "            <p style=\"margin-top: 50px; margin-bottom: 30px;\">  Regards,<br>"
                    + "                CCSNA Team</p>"
                    + "            <div style=\"width: 600px; height: 30px; background-color:#f6a828; color: #fff; padding: 10px;\" > &#169 " + Menu.convertDateToString(new Date(), "yyyy") + " Clermont County Safety Net Alliance |"
                    + "                3003 Hospital Dr. Batavia, OH 45103<br>"
                    + "                Contact : (513)372-8353 | Email : ccsafetynet@gmail.com"
                    + "\n"
                    + "            </div>\n"
                    + "        </div>\n";
            content += "</body>\n</html>";
            
            //specify the fileFormat
           /* if (fileType.equalsIgnoreCase(Menu.PDF)){
                fileFormat = "application/pdf";
            }
            else if (fileType.equalsIgnoreCase(Menu.IMAGE)){
                fileFormat = "image/jpeg";
            }*/
            
             //add attachmemt
            /*Multipart mp = new MimeMultipart();

            MimeBodyPart htmlPart = new MimeBodyPart();
            htmlPart.setContent(content, "text/html");
            mp.addBodyPart(htmlPart);

            MimeBodyPart attachment = new MimeBodyPart();
            InputStream attachmentDataStream = new ByteArrayInputStream(attachmentData);
            
            attachment.setFileName(fileName);
            attachment.setContent(attachmentDataStream, fileFormat);
            mp.addBodyPart(attachment);
            message.setContent(mp);*/
            
            // set email message
            message.setContent(content, "text/html");

            // form all emails in a comma separated string
            StringBuilder sb = new StringBuilder();
            int i = 0;
            for (String email : emailToAddresses) {
                sb.append(email);
                i++;
                if (emailToAddresses.size() > i) {
                    sb.append(", ");
                }
            }
            emails = sb.toString();

            // set 'to email address'
            // you can set also CC or TO for recipient type
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(sb.toString()));

            log.info("Sending Email to " + emails + " from "
                    + fromEmail + " with Subject - " + subject);

            // send the email
            Transport.send(message);

            log.info("Email successfully sent to " + emails);

        } catch (MessagingException e) {
            log.info("Email sending failed to " + emails);
            log.info(e);
        }

    }
}
