package com.matrix.form.api;

import javax.matrix.faces.context.MExternalContext;
import javax.matrix.faces.context.MFacesContext;
import javax.servlet.http.HttpSession;

import com.matrix.api.identity.MFUser;
import com.matrix.app.api.AppContext;
import com.matrix.extention.SessionContextHolder;
import com.matrix.extention.SpringContextHolder;
import com.matrix.form.engine.FormConstants;
import com.matrix.form.engine.foundation.MFormPropertiesImpl;


public class MFormContext {
	

	//获取服务
	public static <T> T getService(String name) {
		if(name.indexOf(".")>=0)
			return null;
		
		if(SpringContextHolder.getApplicationContext().containsBean(name)){
			return SpringContextHolder.getBean(name);
		}else{
			return AppContext.getService(name);
		}
	}
	
	//获取当前的表单变量
	public static Object getFormVariable(String variableName)throws MFormException{
		// TODO Auto-generated method stub
		MExternalContext context = MFacesContext.getCurrentInstance().getExternalContext();
		if(context != null){
			return context.getRequestMap().get(variableName);
		}
		return null;
	}
	//修改当前的表单变量
	public static void updateFormVariable(String variableName, Object variableValue)throws MFormException{
		MExternalContext context = MFacesContext.getCurrentInstance().getExternalContext();
		if(context != null){
			if(variableValue != null)
				context.getRequestMap().put(variableName, variableValue);
			else
				context.getRequestMap().remove(variableName);
		}else{
			throw new MFormException("invalid form context, context is null!");
		}
	}

	//获取表单配置
	public static MFormProperties getFormProperties(){
		return MFormPropertiesImpl.getInstance();
	}
	
	//获取参数
	static public String getParameter(String paraName){
	      //获取parameter attribute 并返回
	      String value = SessionContextHolder.getRequest().getParameter(paraName);
	      if(value == null && MFacesContext.getCurrentInstance()!=null){
	  		MExternalContext context = MFacesContext.getCurrentInstance().getExternalContext();
	  		if(context != null){
	  			return context.getRequestParameterMap().get(paraName);
	  		}
	      }

	  	   return value;
	}
	
	//获取参数
	static public String[] getParameterValues(String paraName){
	      //获取parameter attribute 并返回
		return SessionContextHolder.getRequest().getParameterValues(paraName);

	}
	
	//获取requestAttribute value
	static public Object getRequestAttribute(String attrName){
		//获取parameter value 并返回
	      return SessionContextHolder.getRequest().getAttribute(attrName);
	}
	
	//获取sessionAttribute
	static public Object getSessionAttribute(String attrName){
		  //获取session attribute 并返回
	      return SessionContextHolder.getSession().getAttribute(attrName);
	}
	
	//设置RequestAttribute
	static public void setRequestAttribute(String attrName, Object value){
		 if(value != null)
		      SessionContextHolder.getRequest().setAttribute(attrName, value);
	}
	
	//设置SessionAttribute
	static public void setSessionAttribute(String attrName, Object value){
		if(value != null)
	    	  SessionContextHolder.getSession().setAttribute(attrName, value);
	}
	
	static public String getTenantId(){
		return "root";
	}
	
	static public String getDefaultTenantId(){
		return "root";
	}
	
//	//获取流水号
//	static public String getNextSeqId(String seqId){
//		return getExecutionService().getNextSeqId(seqId);
//	}
	
	//获取当前用户信息
	public static MFUser  getUser(){
		HttpSession httpSession = SessionContextHolder.getSession();
		
		//看是否能够获取HttpSession
		if(httpSession != null){ //如果能获取到httpSession,将当前会话存在HttpSession中
			return (MFUser)httpSession.getAttribute(FormConstants.MATRIX_USER);
		}	
		
		return null;
	}
	
	/*
	 * 设置当前正在使用的用户信息
	 * 
	 * @param user, 当前用户信息
	 */
	public static void setUser(MFUser user) throws MFormException{
		HttpSession httpSession = SessionContextHolder.getSession();
		if(user == null)
			httpSession.removeAttribute(FormConstants.MATRIX_USER);
		httpSession.putValue(FormConstants.MATRIX_USER, user);
	}

	//获取表单执行服务对象
	public static MFormExecutionService getExecutionService(){
		return (MFormExecutionService)SpringContextHolder.getBean("matrixFormService");
	}
	
	public static void setPhaseId(int phaseId){
		HttpSession httpSession = SessionContextHolder.getSession();
		httpSession.setAttribute("matrix_phaseId", phaseId);
	}
	
	public static int getPhaseId(){
		HttpSession httpSession = SessionContextHolder.getSession();
		try{
			Integer phaseId = (Integer)httpSession.getAttribute("matrix_phaseId");
			if(phaseId == null )
				phaseId = 0;
			return phaseId;
		}catch(Exception e){
			return 0;
		}
	}
	
	//是否集成的外部组织机构，不用本身的组织机构表
	public static boolean isOutterOrg(){
		return false;
	}
	
	

}
