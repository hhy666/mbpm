package com.matrix.form.admin.logon.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.matrix.api.identity.BasicMFUser;
import com.matrix.api.identity.MFUser;
import com.matrix.form.admin.common.model.MatrixUser;
import com.matrix.form.admin.logon.foundation.LogonDao;

@Service @Transactional
public class LogonServiceImpl implements LogonService {
	@Resource(name="logonDao")
	LogonDao logonDao;
	
	
	public boolean logoff() {
		// TODO Auto-generated method stub
		return true;
	}

	
	public MFUser logon(String logonName, String password) {
		// TODO Auto-generated method stub
		MatrixUser user = logonDao.logon(logonName, password);
		BasicMFUser mfuser = new BasicMFUser();
		mfuser.setUserId(user.getUserId());
		
		return mfuser;
	}

	public LogonDao getLogonDao() {
		return logonDao;
	}

	public void setLogonDao(LogonDao logonDao) {
		this.logonDao = logonDao;
	}

}
