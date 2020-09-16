/** 
 * 流程定义服务实现
 * @author msg
 * 日期:2008-11-07
 */
package com.matrix.commonservice.process.processdef;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.matrix.faces.context.MFacesContext;
import javax.matrix.faces.context.MResponseWriter;

import com.matrix.annotation.MMethod;
import com.matrix.annotation.MParam;
import com.matrix.annotation.MReturn;
import com.matrix.api.MFExecutionService;
import com.matrix.api.data.BasicDataType;
import com.matrix.api.data.ProcessData;
import com.matrix.api.data.ReadWriteContainer;
import com.matrix.api.identity.MFPotentialOwner;
import com.matrix.api.instance.activity.ActivityInstance;
import com.matrix.api.security.PotentialOwners;
import com.matrix.api.template.activity.ActivityTemplate;
import com.matrix.api.template.activity.ActivityType;
import com.matrix.api.template.activity.AvailableTransition;
import com.matrix.api.template.process.ProcessTemplate;
import com.matrix.app.api.BizException;
import com.matrix.client.ClientConstants;
import com.matrix.engine.foundation.MFFoundationException;
import com.matrix.engine.util.CommonUtil;
import com.matrix.extention.DBHelper;
import com.matrix.form.util.DataObjectHelper;
import com.matrix.web.engine.util.SDOHelper;
import commonj.sdo.DataObject;
import commonj.sdo.Type;
import commonj.sdo.helper.TypeHelper2;
import commonj.sdo.impl.HelperProvider;


@SuppressWarnings("unchecked")
public class ProcessDefMgrImpl implements ProcessDefMgr {
	/**
	 * 创建流程实例
	 * 
	 * @throws MatrixException
	 */
	@MMethod("创建流程实例")
	@MParam(name="流程定义编码,流程输入数据",type="String,DataObject")
	@MReturn(name="流程实例编码",type="String")
	public String createProcessInstance(String pdid, DataObject input)
			throws BizException {
		MFExecutionService service = getExecutionService();
		ReadWriteContainer inputData = service.getProcessInContainer(pdid);
		if(input != null){
			for(Iterator iter=inputData.getMemberNames().iterator(); iter.hasNext(); ){
				String memberName = (String)iter.next();
				Object value = input.get(memberName);
				if(value != null)
					inputData.setAsActualType(memberName, value);
			}
		}
		
		return service.createProcessInstance(pdid, inputData);
	}

	/**
	 * 启动流程实例
	 * 
	 * @throws BizException
	 */
	@MMethod("启动流程实例")
	@MParam(name="流程实例编码",type="String")
	public void startProcessInstance(String piid) throws BizException {
		MFExecutionService service = getExecutionService();
		service.startProcessIns(piid);
	}

	//获取可用的流转
	//获取可用的流转
	@MMethod("获取可用的流转")
	@MParam(name="流程定义编码,活动实例编码",type="String, String")
	@MReturn(name="可能流转对象列表",type="List")
	public List getAvailableTransitions(String pdid, String aiid){
		MFExecutionService service = getExecutionService();

		boolean isFlowStartSelect = false;
		//如果aiid为空，则作为启动流程
		if(CommonUtil.isNullOrEmpty(aiid)){
			isFlowStartSelect = true;
		}
		
		// 流程转移集合
		List transitions = null;
		if(isFlowStartSelect){
			transitions = service.getAllTransitionsOfStartProc(pdid);
		}else{
			ActivityInstance actIns = service.getActivityInsById(aiid);
			if(actIns==null){
				return new ArrayList();
			}
			transitions = service.getAllTransitionsOfAct(actIns.getPiid(),actIns.getPtid(),actIns.getAdid());
		}
		
		List transitionList = new ArrayList();
		for (Iterator iter = transitions.iterator(); iter.hasNext();) {
			AvailableTransition transition = (AvailableTransition) iter.next();
			transitionList.add( this.convertTransition(transition));
		}

		return transitionList;
	}

	//获取可用的流转
	//获取可用的执行人
	@MMethod("获取可用的执行人")
	@MParam(name="流程实例编码,流程模板编码,流程定义编码,目标活动定义编码",type="String, String, String, String")
	public void outputPotentialOwners(String piid, String ptid, String pdid, String toActDid){
		MFExecutionService service = getExecutionService();

		List ownerList = new ArrayList();
		boolean isFlowStartSelect = false;
		//如果piid为空，则作为启动流程
		if(CommonUtil.isNullOrEmpty(piid)){
			isFlowStartSelect = true;
		}
		
		if(!isFlowStartSelect){
			// 运行时
			ownerList = service.getPotentialOwnersOfAct(piid, ptid, toActDid, null);
		}else{
			// 创建时
			ProcessData processData = service.getProcessInitialData(pdid);
			ownerList = service.getPotentialOwnersOfStartProc(pdid, toActDid, processData);
		}

		if(ownerList!=null && ownerList.size()>0){
			StringBuffer result = new StringBuffer();
			result.append("[");
			int flag = 0;
			for(Iterator it=ownerList.iterator();it.hasNext();){
				MFPotentialOwner owner = (MFPotentialOwner)it.next();
				if(flag>0){
					result.append(",");
				}
				result.append("{");
				result.append("id:");
				result.append("'");
				result.append(owner.getId());
				result.append("'");
				result.append(",");
				result.append("name:");
				result.append("'");
				result.append(owner.getName());
				result.append("'");
				result.append("}");
				flag++;
			}
			result.append("]");
			// 设置response相应参数及输出值
			MResponseWriter writer = MFacesContext.getCurrentInstance().getResponseWriter();
			try {
				writer.write(result.toString());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
	
	/**
	 * 取得流程的输入数�
	 * 
	 * @throws BizException
	 */
	@MMethod("取得流程的输入数据")
	@MParam(name="流程定义编码",type="String")
	@MReturn(name="流程初始数据",type="DataObject")
	public DataObject getCreateInstanceData(String pdid) throws BizException {
		MFExecutionService service = getExecutionService();
		ProcessTemplate processTmpl = service.getTemplateService().getLatestProcessTemplateByDID(pdid);
		ReadWriteContainer outData = service.getProcessInContainer(pdid);
		
	    //获取启动活动的输入数据
	    	String namespaceURI = "http://platform/process/"+processTmpl.getPTID();
	    	TypeHelper2 types = TypeHelper2.INSTANCE;			   
	        Type inputType = types.getType(namespaceURI, "InputData");
	        
		    if(inputType == null){
			    //构造创建流程的 SDO Type
			    DataObject dataType = SDOHelper.constructEmptyDataObject(namespaceURI, "InputData");

			    //通过fromParts输入值
				Collection toParts = outData.getMemberNames();
				    
				for(Iterator iter = toParts.iterator(); iter.hasNext(); ){
					 String fromVariable = (String)iter.next();

					 int variableType = outData.getType(fromVariable);
					 //根据类型构造并创建相应的Property
			    	Type type = constructTypeFromFlowType(variableType);
			    	
			        DataObject property = dataType.createDataObject("property");
			        property.set("name", fromVariable);
			        property.set("type", type);

				}
			    
			    TypeHelper2.INSTANCE.define(dataType);
			}
		    
		    //创建和新建对象定义的对象
		    DataObject data = HelperProvider.getDefaultContext().getDataFactory().create(namespaceURI,"InputData");
		    
		    return data;
		
	}
	
	public static Type constructTypeFromFlowType(int flowType){
        TypeHelper2 types = TypeHelper2.INSTANCE;
        Type type = null;
        if(flowType == BasicDataType._INT_TYPE)
        	type = types.getType("commonj.sdo", "Int");
        else if(flowType == BasicDataType._STRING_TYPE)
        	type = types.getType("commonj.sdo", "String");
        else if(flowType == BasicDataType._BOOLEAN_TYPE)
        	type = types.getType("commonj.sdo", "Boolean");
        else if(flowType == BasicDataType._DOUBLE_TYPE)
        	type = types.getType("commonj.sdo", "Double");
        else if(flowType == BasicDataType._DATETIME_TYPE)
        	type = types.getType("commonj.sdo", "Date");
        
        return type;
    }
	
	/**
	 * 创建和启动流程实
	 * 
	 * @param pdid,
	 *            流程定义编码
	 * @param inputData,
	 *            流程输入数据
	 * @return 流程实例编码
	 */
	@MMethod("创建和启动流程实例")
	@MParam(name="流程定义编码,流程初始数据",type="String,DataObject")
	@MReturn(name="流程实例编码",type="String")
	public String createAndStartProcessInstance(String pdid, DataObject inputData) throws BizException {
		MFExecutionService service = getExecutionService();
		ReadWriteContainer outData = service.getProcessInContainer(pdid);
		if(inputData != null){
			for(Iterator iter=outData.getMemberNames().iterator(); iter.hasNext(); ){
				String memberName = (String)iter.next();
				Object value = inputData.get(memberName);
				if(value != null){
					if((value instanceof java.util.Date) && !(value instanceof Timestamp)){
						Timestamp date2 = new Timestamp(((java.util.Date)value).getTime());
						value = new Timestamp(date2.getTime());
					}
					outData.setAsActualType(memberName, value);
				}
			}
		}
		
		return service.createAndStartProcessInstance(pdid, outData);
	}

	/**
	 * 创建并启动流程实例
	 * 
	 * @throws BizException
	 */
	@MMethod("创建和启动流程实例")
	@MParam(name="流程定义编码,选择流转路径编码,流程初始数据",type="String,String,DataObject")
	@MReturn(name="流程实例编码",type="String")
	public String createAndStartProcessInstance(String pdid, String selectedTid, DataObject inputMsg) throws BizException {
		MFExecutionService service = getExecutionService();
		ReadWriteContainer outData = service.getProcessInContainer(pdid);
		for(Iterator iter=outData.getMemberNames().iterator(); iter.hasNext(); ){
			String memberName = (String)iter.next();
			Object value = inputMsg.get(memberName);
			if(value != null)
				outData.setAsActualType(memberName, value);
		}
		
		return service.createAndStartProcessInstance(pdid,outData, selectedTid);
	}

	/**
	 * 创建并启动流程实例
	 * 
	 * @throws BizException
	 */
	@MMethod("创建和启动流程实例")
	@MParam(name="流程定义编码,选择流转路径编码,选择下一步执行人,流程初始数据",type="String, String, List, DataObject")
	@MReturn(name="流程实例编码",type="String")
	public String createAndStartProcessInstance(String pdid, String selectedTid, List potentialOwners, DataObject inputMsg)
			throws BizException {
		MFExecutionService service = getExecutionService();
		ReadWriteContainer outData = service.getProcessInContainer(pdid);
		for(Iterator iter=outData.getMemberNames().iterator(); iter.hasNext(); ){
			String memberName = (String)iter.next();
			Object value = inputMsg.get(memberName);
			if(value != null)
				outData.setAsActualType(memberName, value);
		}
		PotentialOwners owners = new PotentialOwners();
		if(potentialOwners!=null){
			if (!CommonUtil.isNullOrEmpty(potentialOwners)) {
				for (Iterator iter = potentialOwners.iterator(); iter.hasNext();) {
					String assignee = (String) iter.next();
					owners.addUser(assignee);
				}
			}
		}
		
		return service.createAndStartProcessInstance(pdid,outData, selectedTid, owners);

	}

	/**
	 * 将指定流程模板的未完成流程实例迁移到新的版本
	 * 
	 * @throws BizException
	 */
	@MMethod("将指定流程模板的未完成流程实例迁移到新的版本")
	@MParam(name="指定流程模板的编码,新的模板编码",type="String, String")
	public void migrate(String upgradePkgTmplId,String upgradeTargetPkgTmplId,Map adidMap){
		MFExecutionService executionService = getExecutionService();
		executionService.upgradeProcessTemplate(upgradePkgTmplId, upgradeTargetPkgTmplId, adidMap);
	}

	/**
	 * 取得启动流程可能的流
	 * 
	 * @param pdid,
	 *            流程定义编码
	 * @param inputMsg,
	 *            流程初始数据
	 * @return 可能流转对象(Transition)列表
	 * @throws BizException
	 */
	@MMethod("将指定流程模板的未完成流程实例迁移到新的版本2")
	@MParam(name="流程定义编码,流程初始数据",type="String, List")
	@MReturn(name="可能流转对象列表",type="List")
	public List getAvailableStartTransitions(String pdid,
			DataObject inputData) throws BizException {
		if (CommonUtil.isNullOrEmpty(pdid))
			throw new BizException(BizException.invalidInputData,
					"invalid process definition id");
		MFExecutionService executionService = getExecutionService();
		ProcessData outData = executionService.getProcessInitialData(pdid);
		for(Iterator iter=outData.getMemberNames().iterator(); iter.hasNext(); ){
			String memberName = (String)iter.next();
			Object value = inputData.get(memberName);
			if(value != null)
				outData.setAsActualType(memberName, value);
		}
		List transitions = executionService.getAvailableTransitionsOfStartProc(pdid,outData);
		List transitionList = new ArrayList();
		for (Iterator iter = transitions.iterator(); iter.hasNext();) {
			AvailableTransition transition = (AvailableTransition) iter.next();
			transitionList.add( this.convertTransition(transition));
		}
		return transitionList;
	}

	/**
	 * 取得启动流程可能的流转
	 * @param pdid(流程定义对象)
	 * @return transitionsObj(可能流转对象(Transition)列表 )
	 */
	@MMethod("将指定流程模板的未完成流程实例迁移到新的版本")
	@MParam(name="流程定义编码",type="String")
	@MReturn(name="可能流转对象列表",type="List")
	public List getAvailableStartTransitions(String pdid)throws BizException {
		if (CommonUtil.isNullOrEmpty(pdid))
			throw new BizException(BizException.invalidInputData, "invalid process definition id");
		MFExecutionService executionService = getExecutionService();
		List transitions = executionService.getAvailableTransitionsOfStartProc(pdid,null);
		List transitionList = new ArrayList();
		for (Iterator iter = transitions.iterator(); iter.hasNext();) {
			AvailableTransition transition = (AvailableTransition) iter.next();
			transitionList.add( this.convertTransition(transition));
		}
		return transitionList;
	}

	/**
	 * 获取指定版本流程的活动模板列表
	 * @param ptid(流程模板编码)
	 * @return activityTemplates(活动模板列表)
	 */
	@MMethod("获取指定版本流程的活动模板列表")
	@MParam(name="流程模板编码",type="String")
	@MReturn(name="活动模板列表",type="List")
	public List getActivityTemplatesByPTID(String ptid){
		MFExecutionService executionService = getExecutionService();
		List acttmpls = executionService.getTemplateService().getActivityTmplsByPTID(ptid);
		
		List list = new ArrayList();
		
		for(Iterator iter = acttmpls.iterator(); iter.hasNext(); ){
			ActivityTemplate actTmpl = (ActivityTemplate)iter.next();
			if(actTmpl.getActivityType().getValue() == ActivityType.IMPLEMENTATION_TYPE){
				DataObject actDO = this.convertActivityTemplate(actTmpl);
				list.add(actDO);
			}	
		}
		 return list;
	}

	/**
	 * 获取指定流程的活动模板列表
	 * @param pdid(流程定义编码)
	 * @return activityTemplates(活动模板列表)
	 */
	@MMethod("获取指定流程的活动模板列表")
	@MParam(name="流程定义编码",type="String")
	@MReturn(name="活动模板列表",type="List")
	public List getActivityTemplatesByPDID(String pdid){
		MFExecutionService executionService = getExecutionService();
		List acttmpls = executionService.getTemplateService().getActivityTmplsByPDID(pdid);
		
		List list = new ArrayList();
		
		for(Iterator iter = acttmpls.iterator(); iter.hasNext(); ){
			ActivityTemplate actTmpl = (ActivityTemplate)iter.next();
			if(actTmpl.getActivityType().getValue() == ActivityType.IMPLEMENTATION_TYPE){
				DataObject actDO = this.convertActivityTemplate(actTmpl);
				list.add(actDO);
			}	
		}
		 return list;
	}
	
	private DataObject convertActivityTemplate(ActivityTemplate actTmpl){
			DataObject actTmplDataObject = DataObjectHelper.getDataObjectOfEntity("com.matrix.commonservice.process.processdef.ActivityTemplate");
			String atid = actTmpl.getAtid();
			String adid = actTmpl.getAdid();
			String name = actTmpl.getName();
			String desc = actTmpl.getDescription();
			int type = actTmpl.getActivityType().getValue();
			
//			actTmplDataObject.set("atid", atid);
//			actTmplDataObject.set("adid", adid);
			actTmplDataObject.set("id", adid);
			actTmplDataObject.set("name", name);
			actTmplDataObject.set("desc", desc);
//			actTmplDataObject.set("type", type);
			
			return actTmplDataObject;
	}

	private DataObject convertTransition(AvailableTransition transition){
		DataObject transitionDO = DataObjectHelper.getDataObjectOfEntity("com.matrix.commonservice.process.processdef.ProcessTransition");
		String name = transition.getName();
		String tdid = transition.getTdid();
		String toAdid = transition.getToActDID();
		String toAtid = transition.getToActTID();
		
		transitionDO.set("toActTID", toAtid);
		transitionDO.set("toActDID", toAdid);
		transitionDO.set("name", name);
		transitionDO.set("tdid", tdid);
		transitionDO.set("isSelectPotentialOwnersByUser", transition.isSelectPotentialOwners());
		transitionDO.set("isMultiPotentialOwners", transition.isMultiPotentialOwners());
		
		return transitionDO;
	}

	private DataObject convertProcessTemplate(ProcessTemplate processTmpl){
			DataObject processTmplDO = DataObjectHelper.getDataObjectOfEntity("com.matrix.commonservice.process.processdef.ProcessTemplate");
			String ptid = processTmpl.getPTID();
			String pdid = processTmpl.getId();
			String name = processTmpl.getName();
			String desc = processTmpl.getDescription();
			Date createDate = processTmpl.getCreated();
			int priority = processTmpl.getPriority();
			Date validFromDate = processTmpl.getValidFrom();
			Date validToDate = processTmpl.getValidTo();
			String author = processTmpl.getAuthor();
			String version = processTmpl.getVersion();
			
			processTmplDO.set("ptid", ptid);
			processTmplDO.set("pdid", pdid);
			processTmplDO.set("name", name);
			processTmplDO.set("desc", desc);
			processTmplDO.set("priority", priority);
			processTmplDO.setDate("createDate",createDate);
			processTmplDO.setDate("validFrom",validFromDate);
			processTmplDO.setDate("validTo",validToDate);
			processTmplDO.setString("author", author);
			processTmplDO.setString("version", version);
			
			return processTmplDO;
	}

	/**
	 * 根据流程定义编码获取最新版流程模板
	 * @param pdid(流程定义编码)
	 * @return prcessTemplate(流程模板对象)
	 */
	@MMethod("根据流程定义编码获取最新版流程模板")
	@MParam(name="流程定义编码",type="String")
	@MReturn(name="流程模板对象",type="commonservice.processservice.processdefmgr.ProcessTemplate")
	public DataObject getLatestProcessTemplateByDID(String pdid){
		MFExecutionService executionService = getExecutionService();
		ProcessTemplate processTemplate = executionService.getTemplateService().getLatestProcessTemplateByDID(pdid);
		DataObject procTmplDO = this.convertProcessTemplate(processTemplate);
		
		 return procTmplDO;
	}

	/**
	 * 获取流程模板对象
	 * @param ptid(流程模板编码)
	 * @return processTemplate(流程模板对象)
	 */
	@MMethod("获取流程模板对象")
	@MParam(name="流程模板编码",type="String")
	@MReturn(name="流程模板对象",type="commonservice.processservice.processdefmgr.ProcessTemplate")
	public DataObject getProcessTemplateById(String ptid){
		MFExecutionService executionService = getExecutionService();
		ProcessTemplate processTemplate = executionService.getTemplateService().getProcessTemplateById(ptid);
		DataObject procTmplDO = this.convertProcessTemplate(processTemplate);
		
		 return procTmplDO;
	}
	
	@MMethod("获取流程模板列表")
	@MParam(name="查询条件,排序条件",type="String,String")
	@MReturn(name="流程模板列表",type="List")
	public List getProcessTemplates(String filter, String orderBy){

		List processTmpls = new ArrayList();
		 Connection conn = DBHelper.getConnection();
	        PreparedStatement stmt = null;
	        ResultSet rset = null;
	        try {
	    		StringBuffer  sql = new StringBuffer();
	    		sql.append("SELECT M_MID,M_NAME FROM MF_TMPL_CATALOG WHERE M_MID IN ");
	    		sql.append(" (SELECT PROCESS_DID FROM WF_TMPL_PROCESS WHERE PH_PUBLICATION_STATUS=3 )");
	    		if(filter != null && filter.trim().length()>0)
	    			sql.append(" AND "+filter);
	    		if(orderBy != null && orderBy.trim().length()>0){
	    			sql.append(" ORDER BY " + orderBy);
	    		}
	                stmt = conn.prepareStatement(sql.toString());
	                rset = stmt.executeQuery();
	                
	                while(rset.next()){
	                	String id = rset.getString(1);
	                	String name = rset.getString(2);
	        			DataObject processTmplDO = DataObjectHelper.getDataObjectOfEntity("com.matrix.commonservice.process.processdef.ProcessTemplate");
	        			processTmplDO.setString("pdid", id);
	        			processTmplDO.setString("name", name);
	        			processTmpls.add(processTmplDO);
	                }
	                
	        } catch (SQLException e) {
   	                throw new MFFoundationException("Unable to get publised process templates");
	        }finally{
	                try {
	                        if(rset != null)
	                                rset.close();
	                        if(stmt != null)
	                                stmt.close();
	                } catch (SQLException e1) {
	                          e1.printStackTrace();
	                }
	        }
	        
		return processTmpls;
	}

	/**
	 * 获取活动模板对象
	 * @param atid(活动模板编码)
	 * @return activityTemplate(活动模板对象)
	 */
	@MMethod("获取活动模板对象")
	@MParam(name="活动模板编码",type="String")
	@MReturn(name="活动模板对象",type="commonservice.processservice.processdefmgr.ActivityTemplate")
	public DataObject getActivityTemplateById(String atid){
		//如果需要，请在此处加入自己的处理
		MFExecutionService executionService = getExecutionService();
		ActivityTemplate actTmpl = executionService.getTemplateService().getActivityTemplateByATID(atid);
		DataObject actDO = this.convertActivityTemplate(actTmpl);
		
		 return actDO;
	}
	
	//获取流程执行服务
	private MFExecutionService getExecutionService(){
		Map map = MFacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		MFExecutionService service = (MFExecutionService)map.get(ClientConstants.EXECUTION_SERVICE);
		return service;
	}
	


}
