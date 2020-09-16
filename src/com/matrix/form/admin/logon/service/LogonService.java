package com.matrix.form.admin.logon.service;

import com.matrix.api.identity.MFUser;

public interface LogonService {

	public MFUser logon(String logonName,String password);
	public boolean logoff();
	
}
