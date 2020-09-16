package com.matrix.demo;

import java.util.Map;

import javax.matrix.faces.context.MFacesContext;



import com.matrix.api.MFExecutionService;
import com.matrix.api.data.ReadWriteContainer;
import com.matrix.client.ClientConstants;
import com.matrix.commonservice.data.DataService;
import com.matrix.form.api.MFormContext;

import commonj.sdo.DataObject;

public class LeaveService {
	
//	public void startProcess() {
//		DataService dataService = MFormContext.getService("DataService");
//		DataObject leaveAppInfo = (DataObject) MFormContext.getRequestAttribute("leaveAppInfo");
//		dataService.saveOrUpdate(leaveAppInfo);
//		String appId = leaveAppInfo.getString("appId");
//		leaveAppInfo.set("appId", appId);
//		Map map = MFacesContext.getCurrentInstance().getExternalContext().getSessionMap();
//		MFExecutionService service = (MFExecutionService) map.get(ClientConstants.EXECUTION_SERVICE);
//		// 得到流程实例
//		ReadWriteContainer input = service.getProcessInContainer("leaveAppFlow"); 
//		// 将主表主键存入
//		input.setString("mBizId", appId);
//		String piid = service.createAndStartProcessInstance("leaveAppFlow", input);
//		leaveAppInfo.set("piid", piid);
//		leaveAppInfo.set("mStatus", 2);
//		dataService.saveOrUpdate(leaveAppInfo);
//	}
//
//	public void sendProcess() {
//		Map map = MFacesContext.getCurrentInstance().getExternalContext().getSessionMap();
//		MFExecutionService service = (MFExecutionService) map.get(ClientConstants.EXECUTION_SERVICE); 
//		// 提交流程实例
//		String taskId = MFormContext.getParameter("taskId");
//		service.claimTask(taskId);
//		service.completeTask(taskId);
//	}

	public void startProcess(){
		DataService dataService = MFormContext.getService("DataService");
		DataObject leaveInfo = (DataObject) MFormContext.getRequestAttribute("leaveInfo");
		dataService.saveOrUpdate(leaveInfo);
		String appId = leaveInfo.getString("appId");
		leaveInfo.set("appId", appId);
		Map map = MFacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		MFExecutionService service = (MFExecutionService) map.get(ClientConstants.EXECUTION_SERVICE);
		//得到流程实例
		ReadWriteContainer input = service.getProcessInContainer("leaveFlow");
		//将主表主键存入
		input.setString("mBizId", appId);
		String piid = service.createAndStartProcessInstance("leaveFlow",input);
		leaveInfo.set("piid", piid);
		leaveInfo.set("mStatus", 2);
		dataService.saveOrUpdate(leaveInfo);
		}
	public void sendProcess(){
		Map map = MFacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		MFExecutionService service = (MFExecutionService) 
		map.get(ClientConstants.EXECUTION_SERVICE);
		//提交流程实例
		String taskId = MFormContext.getParameter("taskId");
		service.claimTask(taskId);
		service.completeTask(taskId);
		}
}
