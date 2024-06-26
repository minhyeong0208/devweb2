package pack.member;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;


public class MailSender {
	// 발송자 계정 정보 입력, encoding 설정
	private final String user = ""; // 발송자 이메일
	private final String password = "/"; // 발송자 메일계정 비밀번호
	private final String ENC_TYPE = "EUC-KR"; // 내용 인코딩

	private Properties prop; // SMTP 설정 정보
	
	public MailSender() {
		this.prop = getProperties();
	}
	
	private Properties getProperties() {
		Properties prop = new Properties();
		// 발송자 메일계정이 네이버인 경우
		prop.put("mail.smtp.host", "smtp.naver.com"); //
		prop.put("mail.smtp.port", 587); // 
		prop.put("mail.smtp.auth", "true");
//		prop.put("mail.smtp.ssl.enable", "true");
//		prop.put("mail.smtp.ssl.trust", "smtp.naver.com" );
		return prop;
	}
	
	// SMTP 정보 기반으로 인증받아 Session(javax.mail) 생성
	private Session getSession() {
		return Session.getDefaultInstance(prop, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
	}
	
	// 메일 전송 메서드
	public void send(String tempPassword, String userEmail) {
		try {
			Session session = getSession();
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			// 수신자 메일
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));
			
			// 메일 제목
			message.setSubject("임시 비밀번호 안내");
			
			// 메일 내용
			MimeBodyPart content = new MimeBodyPart();
			content.setText("임시 비밀번호는 " + tempPassword + "입니다!");
			
			// Multipart - 메일에 파일도 첨부가능
			Multipart mp = new MimeMultipart();
			mp.addBodyPart(content);
			message.setContent(mp);
			
			// 메일 전송
			Transport.send(message);
			System.out.println("send success");
			
		} catch (Exception e) {
			System.out.println("send error");
			e.printStackTrace();
		}
	}

}
