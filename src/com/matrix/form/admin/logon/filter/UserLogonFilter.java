package com.matrix.form.admin.logon.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import com.matrix.api.MFExecutionAgent;
import com.matrix.api.MFExecutionService;
import com.matrix.api.identity.MFUser;
import com.matrix.client.ClientConstants;
import com.matrix.commonservice.data.DataService;
import com.matrix.engine.util.Base64;
import com.matrix.extention.SessionContextHelper;
import com.matrix.form.admin.common.utils.CommonUtil;
import com.matrix.form.api.MFormContext;
import com.matrix.form.engine.FormConstants;
import com.matrix.form.engine.container.ResourceContainer;
import com.matrix.office.OaPasswordUtils;
import commonj.sdo.DataObject;

public class UserLogonFilter implements Filter {

	public void destroy() {
		

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException 
	{
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;		

		SessionContextHelper.setRequest(httpRequest);

//		IdentityMgr identityMgr=null;
//	    identityMgr=(IdentityMgr)MatrixWebEngine.getService("IdentityMgr");
		HttpSession httpSession=httpRequest.getSession();
		
		/**
		 * 通过SID 取得session zhangyi 2017-12-30 为公文金格组件 跨域访问session
		 */
		MFUser identityMgr =null;
		
		try{
			String sid = httpRequest.getParameter("_JSESSIONID");
			if (StringUtils.isNotEmpty(sid)){
				HttpSession httpSessionNew=SessionContextHelper.getSession4Map(sid);
				
				if (httpSessionNew!=null){
	 
					identityMgr= (MFUser)httpSessionNew.getAttribute(FormConstants.MATRIX_USER);
					MFExecutionService executionService  = (MFExecutionService)httpSessionNew.getAttribute(ClientConstants.EXECUTION_SERVICE);
					
					httpSession.setAttribute(FormConstants.MATRIX_USER, identityMgr);
					httpSession.setAttribute(ClientConstants.EXECUTION_SERVICE, executionService);
					
					String KGBParamString = (String)httpSessionNew.getAttribute("KGBParamString");
					httpSession.setAttribute("KGBParamString", KGBParamString);

				}
			}else{
				identityMgr = MFormContext.getUser();
			}
		}catch(Exception e){
			identityMgr = MFormContext.getUser();
		}
		
		/**
		 * 
		 */
		 
		
		
	    try {
	    	if(httpSession==null || httpSession.getAttribute(ClientConstants.EXECUTION_SERVICE)==null || identityMgr==null){
	    		String mLogonName = httpRequest.getParameter("mLogonName");
				if(mLogonName != null && mLogonName.trim().length()>0){
					try{
						mLogonName = OaPasswordUtils.decode(mLogonName);
						String hql = " from  com.matrix.client.foundation.password.model.MUser where logonName = '"+mLogonName+"'";
						DataService dataService = MFormContext.getService("DataService");
						List users = dataService.queryList(hql, null);
						DataObject userObj = null;
						if(users.size()>0)
							userObj = (DataObject)users.get(0);
						if(userObj != null){
							String psd = userObj.getString("password");
							psd = Base64.decodeToString(psd);
							MFExecutionService executionService = MFExecutionAgent.getExecutionService();
							executionService.logon(userObj.getString("logonName"), psd);
							MFUser user = executionService.getMFUser();
							if(user!=null){
								httpSession.setAttribute(ClientConstants.EXECUTION_SERVICE,executionService);
								MFormContext.setUser(user);
								identityMgr = MFormContext.getUser();
							}
						}
					}catch(Exception e){
						
					}
				}
	    	}
	    	
			if(identityMgr==null)
			{
				
				if(httpRequest.getRequestURI().indexOf("/ImageServlet")==-1){
					// 非验证码请求
					
					if(httpRequest.getParameter("username")!=null){
						MFExecutionService executionService = MFExecutionAgent.getExecutionService();
						executionService.logon(httpRequest.getParameter("username"), "");
						MFUser user = executionService.getMFUser();
						if(user!=null){
							httpSession.setAttribute(ClientConstants.EXECUTION_SERVICE,executionService);
							MFormContext.setUser(user);
						}
					}else{
						
						if(!(httpRequest.getRequestURI().endsWith("/logon.jsp")
								|| httpRequest.getRequestURI().endsWith("/logon_logon.action")
								|| httpRequest.getRequestURI().endsWith("/auth_logon.action")
						)){
							
							if("true".equals(httpSession.getAttribute("matrix_logoff_flag"))){
								httpSession.removeAttribute("matrix_logoff_flag");
								return;
							}
							httpRequest.setCharacterEncoding("UTF-8");
							//						httpResponse.sendRedirect(httpRequest.getContextPath()+"/foundation/identifyvalidator/LogonFlow.flow");
							if(this.isAjaxRequest(httpRequest)){
								httpResponse.setStatus(5000);
								httpResponse.addHeader("matrixstatus", "Timeout");
								if(this.isMobile(request)){
									httpResponse.addHeader("matrixurl", httpRequest.getContextPath()+"/login.jsp");
								}else{
									httpResponse.addHeader("matrixurl", httpRequest.getContextPath()+"/form/admin/logon/"+CommonUtil.getFormUser()+"/logon.jsp");
								}	
							}else{
								if(this.isMobile(request)){
									httpRequest.getRequestDispatcher("/login.jsp").forward(httpRequest,httpResponse);
								}else{
									httpRequest.getRequestDispatcher("/form/admin/logon/"+CommonUtil.getFormUser()+"/logon.jsp").forward(httpRequest,httpResponse);
								}
							}
							return;
						}
					}
					
				}
				
			}else{
				if((httpRequest.getContextPath()!=null&&!"".equals(httpRequest.getContextPath()))&&(httpRequest.getRequestURI().endsWith(httpRequest.getContextPath()) || httpRequest.getRequestURI().endsWith(httpRequest.getContextPath()+"/"))){
					if(this.isMobile(request)){
						httpRequest.getRequestDispatcher("/login.jsp").forward(httpRequest,httpResponse);
					}else{	
						httpResponse.sendRedirect(httpRequest.getContextPath()+"/form/admin/logon/"+CommonUtil.getFormUser()+"/logon.jsp");
					}	
					return;
				}

				
				if(httpRequest.getRequestURI().endsWith("index.jsp")){
					this.initFunctionsOfUser(httpRequest,identityMgr);
					httpRequest.setAttribute("userName", identityMgr.getUserName());
				}
				
//				//校验菜单权限
//				String requestURI = ((HttpServletRequest)request).getRequestURL().toString();
//				String contextPath = ((HttpServletRequest)request).getContextPath();
//				int index = requestURI.indexOf(contextPath);
//				requestURI = requestURI.substring(index+contextPath.length());
//				String priUrl = "";
//				if(requestURI.indexOf("matrix.rform")<0){
//					
//					int pos = requestURI.indexOf("?");
//			        if (pos > -1) {
//			        	priUrl = requestURI.substring(0, pos);
//			        }else{
//			        	priUrl = requestURI;
//			        }
//				}	
//				
//				String functionId = (String)ResourceContainer.getInstance().getFunctionMap().get(priUrl);
//				boolean isChecked = false;
//				if(functionId != null && functionId.trim().length()>0){//菜单，需要校验权限
//					List roleIds = identityMgr.getTotalRoleIds();
//					List<DataObject> roleHasFunctions = ResourceContainer.getInstance().getFuncRoleList();
//					for(DataObject o:roleHasFunctions){
//						String roleId = o.getString("roleId");
//						String funId = o.getString("functionId");
//						if(functionId.equals(funId) && roleIds.contains(roleId)){
//							isChecked = true;
//						}
//					}
//					
//				}else{
//					isChecked = true;
//				}
//				
//				if(isChecked == false){
//					if(this.isMobile(request)){
//						httpRequest.getRequestDispatcher("/login.jsp").forward(httpRequest,httpResponse);
//					}else{	
//						httpResponse.sendRedirect(httpRequest.getContextPath()+"/form/admin/logon/"+CommonUtil.getFormUser()+"/logon.jsp");
//					}	
//					return;
//				}
				
				
//				List roleIds = identityMgr.getList("roleIds");
//				boolean b = FunctionAndRoleModel.getInstance().checkAuthorization(httpRequest.getServletPath().toString(), roleIds);
//				if(!b){
//					if(this.isAjaxRequest(httpRequest)){
//						httpResponse.setStatus(5000);
//						httpResponse.addHeader("matrixstatus", "NoAccess");
//						httpResponse.addHeader("matrixurl", httpRequest.getContextPath()+"/foundation/identifyvalidator/LogonFlow.flow");
//					}else{
//						httpResponse.sendRedirect(httpRequest.getContextPath()+"/foundation/identifyvalidator/LogonFlow.flow");
//					}
//					return;
////					httpRequest.getRequestDispatcher("/foundation/identifyvalidator/LogonFlow.flow").forward(httpRequest,httpResponse);
//				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	    
	   
	    
		httpResponse.setHeader("Pragma","No-cache");
		httpResponse.setHeader("Cache-Control","no-cache");
		httpResponse.setDateHeader("Expires", 0);
		
		if(chain != null){		
            chain.doFilter(request, response);        	
		}

	}

	private boolean isAjaxRequest(ServletRequest request){
		boolean isAjax = false;
        String ajaxValue = request.getParameter("X-Requested-With");
        if(ajaxValue!=null){
        	if ("XMLHttpRequest".equals(ajaxValue)){
				 isAjax = true;
        	}
        }
        return isAjax;
	}
	
	/**
	 * 初始权限集合
	 * @param httpRequest
	 */
	private void initFunctionsOfUser(HttpServletRequest httpRequest,MFUser user){
		//功能集合
		List items = new ArrayList();
		//用户拥有角色
		List roles = user.getRoleIds();
		String adminSec = MFormContext.getFormProperties().getAdminSec();//系统管理员
//		if(adminSec!=null && adminSec.trim().length()>0 && roles.contains(adminSec)){
		if(adminSec==null || adminSec.trim().length()==0 || roles.contains(adminSec)){
			//系统管理员
			if(CommonUtil.USER_MATRIX.equals(CommonUtil.getFormUser())){
				items.add("\"requirement\"");
				items.add("\"insMgr\"");
			}else if(CommonUtil.USER_ZR.equals(CommonUtil.getFormUser())){
				items.add("\"development\"");
			}
			items.add("\"implement\"");
			items.add("\"customize\"");
			items.add("\"sysMgr\"");
		}else{
			if(CommonUtil.USER_MATRIX.equals(CommonUtil.getFormUser())){
				String requirementSec = MFormContext.getFormProperties().getRequirementSec();//需求建模授权角色
				if(requirementSec!=null && requirementSec.trim().length()>0){
					if(roles.contains(requirementSec)){
						items.add("\"requirement\"");
					}
				}
			}else if(CommonUtil.USER_ZR.equals(CommonUtil.getFormUser())){
				String implementSec = MFormContext.getFormProperties().getImplementSec();  //实施建模授权角色
				if(implementSec!=null && implementSec.trim().length()>0){
					if(roles.contains(implementSec)){
						items.add("\"implement\"");
					}
				}
			}
			
			String developmentSec = MFormContext.getFormProperties().getDevelopmentSec();  //开发建模授权角色
			if(developmentSec!=null && developmentSec.trim().length()>0){
				if(roles.contains(developmentSec)){
					if(CommonUtil.USER_MATRIX.equals(CommonUtil.getFormUser())){
						items.add("\"implement\"");
					}else if(CommonUtil.USER_ZR.equals(CommonUtil.getFormUser())){
						items.add("\"development\"");
					}
				}
			}
			
			String businessSec = MFormContext.getFormProperties().getBusinessSec();  //业务定制建模授权角色
			if(businessSec!=null && businessSec.trim().length()>0){
				if(roles.contains(businessSec)){
					items.add("\"customize\"");
				}
			}
		}
		
		httpRequest.setAttribute("mfunctions", items.toString());
		
	}
	
	private boolean isMobile(ServletRequest request){
		String agent = ((HttpServletRequest)request).getHeader( "USER-AGENT" );
		if(agent == null)
			return false;
		
		String userAgent = agent.toLowerCase();
		
		//移动端
		if(userAgent.indexOf("iphone")>0 || userAgent.indexOf("mobile")>0){
			return true;
		}
		
		return false;
	}
	
	
	public void init(FilterConfig arg0) throws ServletException {
	

	}

}
