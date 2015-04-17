package com.eastteam.myprogram.service;

import com.ibm.swat.password.ReturnCode;
import com.ibm.swat.password.cwa2;

public class AccountServiceTest {
	public static void main(String[] args) {
		try {
			// add by1102
			cwa2 cwa = new cwa2();
			String ldaphost = "bluepages.ibm.com";
			ReturnCode rc = cwa.authenticate("lichlei@cn.ibm.com", "lcl13647211580p2", ldaphost);
			//ReturnCode rc = cwa.authenticate(ldaphost, USERNAME, PASSWORD);

			System.out.println("Return Code is : " +rc.getCode());

			if (rc.getCode() == 0) {
				System.out.println("bluepage authentication successfully:"+rc);
			} else {
				System.out.println("bluepage authentication wrong with error: "+rc);
				throw new RuntimeException("Invalid username or password!");
			}			
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Error " +  e.getMessage());
		}
	}

}
