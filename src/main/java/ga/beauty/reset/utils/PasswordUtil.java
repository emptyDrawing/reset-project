
package ga.beauty.reset.utils;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.stereotype.Component;


public class PasswordUtil {

	public String getEncryptSHA256(String orgin) throws NoSuchAlgorithmException {
		StringBuilder newStr = new StringBuilder();
		
		MessageDigest md = null;
        md = MessageDigest.getInstance("SHA-256");
        md.update(orgin.getBytes(), 0, orgin.length());
        newStr.append(new BigInteger(1, md.digest()).toString(16)); 
		return newStr.toString();
	}
	
	
}
