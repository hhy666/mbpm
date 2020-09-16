package com.matrix.demo;

import com.matrix.api.MFException;
import com.matrix.api.integration.ComponentContext;
import com.matrix.api.integration.ComponentProvider;
import com.matrix.commonservice.data.DataService;
import com.matrix.form.api.MFormContext;

import commonj.sdo.DataObject;

public class LeaveCompleteService implements ComponentProvider {

//	@Override
//	public void execute(ComponentContext context) throws MFException {
//		//配置完成事件
//		DataService dataService = MFormContext.getService("DataService");
//		DataObject leaveAppInfo = (DataObject) 
//		MFormContext.getRequestAttribute("leaveAppInfo");
//		leaveAppInfo.set("mStatus", 3);
//		dataService.saveOrUpdate(leaveAppInfo);
//	}
	
	@Override
	public void execute(ComponentContext context) throws MFException {
		//配置完成事件
		DataService dataService = MFormContext.getService("DataService");
		DataObject leaveInfo = (DataObject)MFormContext.getRequestAttribute("leaveInfo");
		leaveInfo.set("mStatus", 3);
		dataService.saveOrUpdate(leaveInfo);
	}

}
