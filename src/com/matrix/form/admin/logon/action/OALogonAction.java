package com.matrix.form.admin.logon.action;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.cfg.Configuration;
import org.hibernate.mapping.Column;
import org.hibernate.mapping.PersistentClass;
import org.hibernate.mapping.Property;
import org.springframework.context.annotation.Scope;
import org.springframework.orm.hibernate3.LocalSessionFactoryBean;
import org.springframework.stereotype.Controller;

import com.matrix.api.MFExecutionAgent;
import com.matrix.api.MFExecutionService;
import com.matrix.api.identity.MFUser;
import com.matrix.commonservice.data.DataService;
import com.matrix.dasservice.DASAgent;
import com.matrix.dasservice.DASService;
import com.matrix.engine.proxy.SpringAdapter;
import com.matrix.form.admin.common.action.BaseAction;
import com.matrix.form.admin.common.utils.CommonUtil;
import com.matrix.form.admin.common.utils.CompTypeConstant;
import com.matrix.form.admin.logon.service.LogonService;
import com.matrix.form.api.MFormContext;
import com.matrix.office.common.oplog.AuditInfoHelper;

@Controller
@Scope("prototype")
public class OALogonAction extends BaseAction {
	@Resource
	LogonService logonService;

	/**
	 * 登陆
	 * 
	 * @return
	 */
	public String logon() {
		String formUser = CommonUtil.getFormUser();
		AuditInfoHelper ah = new AuditInfoHelper();
		boolean isMobile = this.isMobile();
//		if (!isMobile) { // 移动端不校验验证码
//			// 验证码验证
//			String code = request.getParameter("code");
//			
//			if (code == null
//					|| this.request.getSession().getAttribute("matrix_verify_code") ==null ||  !code.toLowerCase().equals(this.request.getSession().getAttribute(
//							"matrix_verify_code").toString().toLowerCase())) {
//				this.request.setAttribute("InvalidCode", "true");
//				return formUser + "_" + this.ERROR;
//			}
//		}

		// 登陆
		String logonName = request.getParameter("logonName");
		String password = request.getParameter("password");
		String objSql;
		String numHql;
		if (logonName != null && logonName.trim().length() > 0) {
			try {
				logonName = logonName.trim();
				// MFUser user = logonService.logon(logonName, password);
				MFExecutionService executionService = MFExecutionAgent
						.getExecutionService();
				executionService.logon(logonName, password);

				MFUser user = executionService.getMFUser();
				String userName = user.getUserName();
				if (user != null) {
					this.setMFExecutionService(executionService);
					MFormContext.setUser(user);
					DataService dataService = MFormContext
							.getService("DataService");
					List<String> roleIds = user.getRoleIds();
					objSql = "UPDATE MF_ORG_USER set FLAG='1' where USER_ID = '" + user.getUserId() + "'";
					numHql = "select count(*) from foundation.org.User where flag=1";
					if (roleIds.contains("designer")) {// 是desginer角色
						MFormContext.setPhaseId(CompTypeConstant.PHASE_IMPLEMENT);
						// 设置在线标志
						dataService.executeSql(objSql, null, null);
						Object num = (Object) dataService.queryObject(numHql,
								null);
						int n = 0;
						if (num != null) {
							n = Integer.valueOf(num.toString());

						}
						MFormContext.setSessionAttribute("Logon_User_Num", n);
						// request.setAttribute("num",n);
						 ah.saveAudit("登陆成功");
						return formUser;
					} else if (roleIds.contains("SysAdmin")
							|| roleIds.contains("SubSysAdmin")) {
						MFormContext.setPhaseId(CompTypeConstant.PHASE_IMPLEMENT);
						// 系统管理员 or 二级管理员
						dataService.executeSql(objSql, null, null);
						int n = 0;
						Object num = (Object) dataService.queryObject(numHql, null);
						if (num != null) {
							n = Integer.valueOf(num.toString());

						}
						
						
						ah.saveAudit("登陆成功");
						// request.setAttribute("num",n);
						MFormContext.setSessionAttribute("Logon_User_Num", n);
						request.setAttribute("userName", userName);
						return "config";
					}else{
						//普通用户
						MFormContext.setPhaseId(CompTypeConstant.PHASE_CUSTOMIZE);
					}
					dataService.executeSql(objSql, null, null);
					int n = 0;
					Object num = (Object) dataService.queryObject(numHql, null);
					if (num != null) {
						n = Integer.valueOf(num.toString());

					}
					ah.saveAudit("登陆成功");
					MFormContext.setSessionAttribute("Logon_User_Num", n);
					// request.setAttribute("num",n);
					request.setAttribute("userName", userName);



					return "index";// 不是设计人员角色 不是系统管理员就跳转到主页面
					
				} else {

					this.request.setAttribute("InvalidUser", "true");
					return formUser + "_" + this.ERROR;
				}
			} catch (Exception e) {

				e.printStackTrace();
				this.request.setAttribute("InvalidPsd", "true");
				return formUser + "_" + this.ERROR;
			}
		}
		return formUser + "_" + this.ERROR;
	}

	/**
	 * 注销
	 * 
	 * @return
	 */
	public String logoff() {
		String formUser = CommonUtil.getFormUser();
		AuditInfoHelper ah = new AuditInfoHelper();
		String objsql;
		MFExecutionService executionService = this.getMFExecutionService();
		DataService dataService = MFormContext.getService("DataService");
		MFUser user = executionService.getMFUser();
		// 设置在线标志
		objsql = "UPDATE MF_ORG_USER set FLAG='0' where USER_ID = '"
				+ user.getUserId() + "'";
		dataService.executeSql(objsql, null, null);
//		ah.saveAudit("注销成功");
		try {
			if (executionService != null && executionService.isValidSession()) {
				executionService.logoff();
			}
			this.setMFExecutionService(null);
			MFormContext.setUser(null);
		} catch (Exception e) {
		}
		return formUser + "_logoff";
	}

	public LogonService getLogonService() {
		return logonService;
	}

	public void setLogonService(LogonService logonService) {
		this.logonService = logonService;
	}

	private boolean isMobile() {
		String userAgent = this.getRequest().getHeader("USER-AGENT")
				.toLowerCase();

		// 移动端
		if (userAgent.indexOf("iphone") > 0 && userAgent.indexOf("mobile") > 0) {
			return true;
		}

		return false;
	}

	// ------------------
	private String convertHql(String entityName, String hql) {

		if (hql == null)
			return hql;

		DASService dass = DASAgent.getFormDASService();
		LocalSessionFactoryBean configBean = (LocalSessionFactoryBean) (SpringAdapter
				.getBean("&sessionFactory"));
		Configuration conf = configBean.getConfiguration();
		// Configuration conf = dass.getConfiguration(entityName);
		// get persistent class of entity
		PersistentClass pCls = conf.getClassMapping(entityName);

		String tableName = pCls.getTable().getName();
		int index = hql.indexOf(entityName);
		hql = hql.substring(0, index) + tableName + " "
				+ hql.substring(index + entityName.length());
		// get common column of entity
		Iterator pIte = pCls.getPropertyIterator();
		HashMap colNames = new HashMap();
		while (pIte.hasNext()) {
			Property property = (Property) pIte.next();
			String pName = property.getName();
			Iterator colIter = property.getColumnIterator();
			if (colIter.hasNext()) {
				Column col = (Column) colIter.next();
				String cName = col.getName();
				colNames.put(pName, col.getName());

				String name = pName + " ";
				int index2 = hql.indexOf(name);
				if (index2 >= 0)
					hql = hql.substring(0, index2) + col.getName() + " "
							+ hql.substring(index2 + name.length());

			}
		}

		// get identifier of entity
		Property identifierProperty = pCls.getIdentifierProperty();
		Iterator kIte = identifierProperty.getColumnIterator();
		while (kIte.hasNext()) {
			Column col = (Column) kIte.next();
			String cName = col.getName();

			String name = identifierProperty.getName() + " ";
			int index2 = hql.indexOf(identifierProperty.getName());
			if (index2 >= 0)
				hql = hql.substring(0, index2) + col.getName() + " "
						+ hql.substring(index2 + name.length());
		}

		return hql;
	}

	// ------------------
}
