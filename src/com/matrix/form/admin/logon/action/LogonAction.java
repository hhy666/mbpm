
package com.matrix.form.admin.logon.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

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
import com.matrix.engine.foundation.config.MFSystemProperties;
import com.matrix.engine.proxy.SpringAdapter;
import com.matrix.extention.SessionContextHolder;
import com.matrix.form.admin.common.action.BaseAction;
import com.matrix.form.admin.common.utils.CommonUtil;
import com.matrix.form.admin.common.utils.CompTypeConstant;
import com.matrix.form.admin.logon.service.LogonService;
import com.matrix.form.api.MFormContext;
import com.matrix.form.engine.FormConstants;
import com.matrix.office.FlowBizConcurrentHelper;
import com.matrix.office.common.oplog.AuditInfoHelper;


@Controller
@Scope("prototype")
public class LogonAction extends BaseAction {

	@Resource
	LogonService logonService;

	/**
	 * 登陆
	 * 
	 * @return
	 */
	public String logon() {
//		String formUser = CommonUtil.getFormUser();
		
		String formUser = "catalogH5";
		AuditInfoHelper ah = new AuditInfoHelper();
		boolean isMobile = this.isMobile();
		if (!isMobile) { // 移动端不校验验证码
			// 验证码验证
			String code = request.getParameter("code");
			
			if (code == null
					|| this.request.getSession().getAttribute("matrix_verify_code") ==null ||  !code.toLowerCase().equals(this.request.getSession().getAttribute(
							"matrix_verify_code").toString().toLowerCase())) {
				this.request.setAttribute("InvalidCode", "true");
				return  "matrix_" + this.ERROR;
			}
		}

		
		//登录前判断
		HttpSession httpSession = SessionContextHolder.getSession();
		Object userNa = httpSession.getValue(FormConstants.MATRIX_USER);
		if(userNa!=null){
			response.setContentType("text/html; charset=UTF-8"); //转码
		    PrintWriter out = null;
			try {
				out = response.getWriter();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		    out.flush();
		    out.println("<script type='text/javascript'>");
		    out.println("alert('已有账号登录，请注销后再登录此账号~!');");
		    out.println("</script>");
			
		}else{

		// 登陆
		String logonName = request.getParameter("logonName");
		String password = request.getParameter("password");
		String isChrome = request.getParameter("isChrome");
		
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
				
				String adminRole = MFSystemProperties.getInstance().getSystemAdmin();
				if (user != null) {
					this.setMFExecutionService(executionService);
					MFormContext.setUser(user);
					DataService dataService = MFormContext
							.getService("DataService");
					List<String> roleIds = user.getRoleIds();
					objSql = "UPDATE MF_ORG_USER set FLAG='1' where USER_ID = '" + user.getUserId() + "'";
					numHql = "select count(*) from foundation.org.User where flag=1";
					
					String designerRole = MFSystemProperties.getInstance().getSystemDesigner();  //设计开发人员角色编码
					
//					if (roleIds.contains(designerRole)) {// 是desginer角色
//						if("false".equals(isChrome)){
//						    this.request.setAttribute("isChrome", "false");
//							return "matrix" + "_" + this.ERROR;
//						    
//						}else{
//						
//							MFormContext.setPhaseId(CompTypeConstant.PHASE_IMPLEMENT);
//							// 设置在线标志
//							if(!MFormContext.isOutterOrg())
//								dataService.executeSql(objSql, null, null);
//							
//							Object num = (Object) dataService.queryObject(numHql,
//									null);
//							int n = 0;
//							if (num != null) {
//								n = Integer.valueOf(num.toString());
//	
//							}
//							MFormContext.setSessionAttribute("Logon_User_Num", n);
//							// request.setAttribute("num",n);
//							 ah.saveAudit("登陆成功");
//							return formUser;
//					    }
//					} else if (roleIds.contains(adminRole)
//							|| roleIds.contains("SubSysAdmin")) {
//						if("false".equals(isChrome)){
//						    this.request.setAttribute("isChrome", "false");
//							return "matrix" + "_" + this.ERROR;
//						    
//						}else{
//						
//		//					 MFormContext.setPhaseId(CompTypeConstant.PHASE_IMPLEMENT);
//							 MFormContext.setPhaseId(CompTypeConstant.PHASE_CUSTOMIZE);
//							 // 系统管理员 or 二级管理员
//							 if(!MFormContext.isOutterOrg())
//								 dataService.executeSql(objSql, null, null);
//							 int n = 0;
//							 Object num = (Object) dataService.queryObject(numHql, null);
//							 if (num != null) {
//								n = Integer.valueOf(num.toString());
//							 }
//								
//							 ah.saveAudit("登陆成功");
//							 // request.setAttribute("num",n);
//							 MFormContext.setSessionAttribute("Logon_User_Num", n);
//							 request.setAttribute("userName", userName);
//							 return "config";	
//						}
//					}else{
						//普通用户
						MFormContext.setPhaseId(CompTypeConstant.PHASE_CUSTOMIZE);
//					}
					
					if(!MFormContext.isOutterOrg())
						dataService.executeSql(objSql, null, null);
					
					int n = 0;
					Object num = (Object) dataService.queryObject(numHql, null);
					if (num != null) {
						n = Integer.valueOf(num.toString());

					}
					ah.saveAudit("登录成功");
					MFormContext.setSessionAttribute("Logon_User_Num", n);
					String getDepSpace = "select uuid,title from com.matrix.client.foundation.portal.model.Portal where type=3 order by index asc";
					List<Object[]> list = dataService.queryList(getDepSpace, null);
					// request.setAttribute("num",n);
					request.setAttribute("portals", list);
					request.setAttribute("userName", userName);
					request.setAttribute("logonMode", "user");   //直接登录默认登录方式是普通用户视图
					//皮肤类型
					String skin = (String) dataService.queryValue("select skin from SysInfo where uuid = 'mbpm'", null);
					if(skin != null && skin.trim().length() >0){
						request.getSession().setAttribute("skin", skin);
					}else{
						request.getSession().setAttribute("skin", "primary");  //默认皮肤
					}				
					return "index";// 不是设计人员角色 不是系统管理员就跳转到主页面
					
				} else {

					this.request.setAttribute("InvalidUser", "true");
//					return formUser + "_" + this.ERROR;
					return "matrix" + "_" + this.ERROR;
				}
			} catch (Exception e) {

//				e.printStackTrace();
				this.request.setAttribute("InvalidUser", "true");
				this.request.setAttribute("InvalidPsd", "true");
				return "matrix" + "_" + this.ERROR;
			}
		  }
		}
		return "matrix" + "_" + this.ERROR;
	}

	/**
	 * 注销
	 * 
	 * @return
	 */
	public String logoff() {
//		if(2>1)
//			return null;
		
		String formUser = CommonUtil.getFormUser();
		AuditInfoHelper ah = new AuditInfoHelper();
		String objsql;
		MFExecutionService executionService = this.getMFExecutionService();
		DataService dataService = MFormContext.getService("DataService");
		if(executionService!=null ){
			MFUser user = executionService.getMFUser();
			if(user != null){
				// 设置在线标志
				objsql = "UPDATE MF_ORG_USER set FLAG='0' where USER_ID = '"
						+ user.getUserId() + "'";
				if(!MFormContext.isOutterOrg())
					dataService.executeSql(objsql, null, null);
				
				//清除并发信息
				FlowBizConcurrentHelper.clearCurrentInfoOfUser();
				
				ah.saveAudit("注销成功");
				try {
					if (executionService != null && executionService.isValidSession()) {
						executionService.logoff();
					}
					this.setMFExecutionService(null);
					MFormContext.setUser(null);
				} catch (Exception e) {
				}
			}

		}
		boolean isMobile = this.isMobile();
		if(isMobile){//移动端
			return "mobileHome";
		}else{
			return formUser + "_logoff";
		}
	}
	
	/**
	 * 切换账号视图
	 * @return
	 */
	public String switchView() {
		DataService dataService = MFormContext.getService("DataService");
		String viewType = request.getParameter("viewType");  //切换视图类型  
		
		//获得当前流程服务对象
		MFExecutionService executionService = this.getMFExecutionService();
		MFUser user = executionService.getMFUser();
		String userName = user.getUserName();
		
		String resultView = null;
		if("user".equals(viewType)){   //普通用户
			MFormContext.setPhaseId(CompTypeConstant.ORDINARY_USER);
			//加载门户信息
			String getDepSpace = "select uuid,title from com.matrix.client.foundation.portal.model.Portal where type=3 order by index asc";
			List<Object[]> list = dataService.queryList(getDepSpace, null);
			request.setAttribute("portals", list);
			resultView = "index";
			
		}else if("admin".equals(viewType)){  //管理员
			 MFormContext.setPhaseId(CompTypeConstant.PHASE_CUSTOMIZE);
			 resultView = "config";
			 
		}else if("designer".equals(viewType)){   //设计人员
			MFormContext.setPhaseId(CompTypeConstant.PHASE_IMPLEMENT);
			resultView = "catalogH5";
			
		}else if("changeSkin".equals(viewType)){   //更换皮肤时自动刷新管理员界面  并展开皮肤管理子菜单
			request.setAttribute("operation", "changeSkin");
			viewType = "admin";
			MFormContext.setPhaseId(CompTypeConstant.PHASE_CUSTOMIZE);
			resultView = "config";
		}
		
		//统计当前在线人数
		String numHql = "select count(*) from foundation.org.User where flag=1";
		Object num = (Object) dataService.queryObject(numHql,null);
		int n = 0;
		if (num != null) {
			n = Integer.valueOf(num.toString());
		}
		MFormContext.setSessionAttribute("Logon_User_Num", n);
		request.setAttribute("userName", userName);
		request.setAttribute("logonMode", viewType);   //切换不同视图登录 user普通视图  admin管理员视图  designer设计开发视图
		return resultView;
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
		if (userAgent.indexOf("iphone") > 0 || userAgent.indexOf("mobile") > 0) {
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