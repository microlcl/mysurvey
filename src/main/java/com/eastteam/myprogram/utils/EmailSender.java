package com.eastteam.myprogram.utils;
import java.util.Date;  
import java.util.Properties;  
 
import javax.mail.Authenticator;  
import javax.mail.Multipart;  
import javax.mail.PasswordAuthentication;  
import javax.mail.internet.InternetAddress;  
import javax.mail.internet.MimeBodyPart;  
import javax.mail.internet.MimeMultipart;  

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.eastteam.myprogram.service.survey.SurveyService;
 
 
public class EmailSender {  
	private static Logger logger = LoggerFactory.getLogger(SurveyService.class);
	private static final String EMAIL="18661014104@163.com";
	private static final String EPASW="gongbinfeng123";
	private static final String SMTP="smtp.163.com";
	
    public boolean sendmail(String subject, Object[] to,  
            String description, String paperURL, String mimeType) {  
        try {  
             String servername = EMAIL; 
             String serverpaswd = EPASW;
             
             Properties props = new Properties();  
             props = java.lang.System.getProperties();
             props.put("mail.smtp.host", SMTP); 
             props.put("mail.smtp.auth", "true"); 
 
             javax.mail.Session mailSession = null; 
             javax.mail.internet.MimeMessage mimeMsg = null;
            
            SmtpAuthenticator myEmailAuther = new SmtpAuthenticator(servername,serverpaswd);  
          
            mailSession = javax.mail.Session.getInstance(props,  
                    (Authenticator) myEmailAuther);  
           
            javax.mail.Transport transport = mailSession.getTransport("smtp");  
          
           mimeMsg = new javax.mail.internet.MimeMessage(mailSession);  
           if (null != EMAIL && !"".equals(EMAIL)) {  
               InternetAddress sentFrom = new InternetAddress(EMAIL);  
               mimeMsg.setFrom(sentFrom);
           }  
 
           InternetAddress[] sendTo = new InternetAddress[to.length];  
           for (int i = 0; i < to.length; i++) {  
               logger.info("send email to:" + to[i].toString());  
               sendTo[i] = new InternetAddress(to[i].toString());  
           }  
 
           mimeMsg.setRecipients(  
                   javax.mail.internet.MimeMessage.RecipientType.TO, sendTo);  
           mimeMsg.setSubject(subject, "gb2312");  
 
           MimeBodyPart messageBodyPart1 = new MimeBodyPart();  
           // messageBodyPart.setText(UnicodeToChinese(text));  
           messageBodyPart1.setContent(description+"<br>"+paperURL, mimeType);  
 
           Multipart multipart = new MimeMultipart();  
           multipart.addBodyPart(messageBodyPart1);  
 
//           for (int i = 0; i < filenames.length; i++) {  
//               MimeBodyPart messageBodyPart2 = new MimeBodyPart();  
// 
//               String filename = filenames[i].split(";")[0];  
//               String displayname = filenames[i].split(";")[1];  
//               FileDataSource fds = new FileDataSource(filename);  
//               messageBodyPart2.setDataHandler(new DataHandler(fds));  
//               messageBodyPart2.setFileName(MimeUtility  
//                       .encodeText(displayname));  
//               multipart.addBodyPart(messageBodyPart2);  
//           }  
           
           mimeMsg.setContent(multipart);  
           mimeMsg.setSentDate(new Date());  
           mimeMsg.saveChanges();  
           transport.send(mimeMsg);  
           transport.close();  
           logger.info("sending email task completed");
           return true;
       } catch (Exception e) {  
           e.printStackTrace();  
           return false;
       }  
   }  
 
    
//   public static void main(String[] args) throws Exception {  
//	   System.setProperty("java.net.preferIPv4Stack", "true");  
//       String title = "hello";
//       String from = "";
//       String sendTo[] = { "" };
//       String content = "test java send mail !!!!!!";  
//     String fileNames[] = { "c:\\sig.jpg;sig.jpg" };  
//
//     EmailSender test = new EmailSender();  
//     try {  
//         test.sendmail(title, from, sendTo, content, fileNames,  
//                 "text/html;charset=gb2312");  
//     } catch (Exception ex) {  
//         ex.printStackTrace();  
//     }  
// }  

   
 class SmtpAuthenticator extends Authenticator {  
     String username = null;  
     String password = null;  

      
     public SmtpAuthenticator(String username, String password) {  
         super();  
         this.username = username;  
         this.password = password;  
     }  

     public PasswordAuthentication getPasswordAuthentication() {  
         return new PasswordAuthentication(this.username, this.password);  
       }  
   }  
}