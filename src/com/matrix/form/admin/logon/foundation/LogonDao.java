package com.matrix.form.admin.logon.foundation;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.matrix.form.admin.common.foundation.BaseDao;
import com.matrix.form.admin.common.model.MatrixUser;

@Repository("logonDao")
public class LogonDao extends BaseDao {

	public MatrixUser logon(String logonName,String password){
		StringBuffer hql = new StringBuffer();
		hql.append(" from com.matrix.form.admin.common.model.MatrixUser ");
		hql.append(" where logonName=? and password=?");
		List params = new ArrayList();
		params.add(logonName);
		params.add(password);
		MatrixUser user = (MatrixUser)this.queryHql(hql.toString(), params);
		return user;
	}
}
