/** 
 * 流程实例服务实现
 * @author msg
 * 日期:2008-11-07
 */
package com.matrix.commonservice.process.processinstance;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import com.matrix.annotation.MMethod;
import com.matrix.annotation.MParam;
import com.matrix.annotation.MReturn;
import com.matrix.api.MFExecutionService;
import com.matrix.api.data.ExAttributes;
import com.matrix.api.instance.activity.ActivityInstance;
import com.matrix.api.instance.process.ProcessInstance;
import com.matrix.app.api.BizException;
import com.matrix.app.api.Page;
import com.matrix.app.api.model.PageVO;
import com.matrix.client.ClientConstants;
import com.matrix.dasservice.DASHelper;
import com.matrix.extention.SessionContextHolder;
import com.matrix.form.util.DataObjectHelper;
import commonj.sdo.DataObject;
public class ProcessInstanceMgrImpl implements ProcessInstanceMgr {
	/**
	 * 删除流程实例
	 * @throws MatrixException 
	 */
	@MMethod("删除流程实例")
	@MParam(name="流程实例编码",type="String")
	public void deleteProcessInstance(String piid) throws BizException {
		MFExecutionService service = getExecutionService();
		service.deleteProcessInstance(piid);
	}

	/**
	 * 终止流程实例
	 * @throws BizException 
	 */
	@MMethod("终止流程实例")
	@MParam(name="流程实例编码",type="String")
	public void terminateProcessInstance(String piid) throws BizException {
		if(piid == null || piid.trim().length()==0)
			return;
		
		MFExecutionService service = getExecutionService();
		service.terminateProcessIns(piid);
	}

	/**
	 * 暂停流程实例
	 * @throws BizException 
	 */
	@MMethod("暂停流程实例")
	@MParam(name="流程实例编码",type="String")
	public void suspendProcessInstance(String piid) throws BizException {
		MFExecutionService service = getExecutionService();
		service.suspendProcessIns(piid, true);
	}

	/**
	 * 恢复已暂停的流程实例
	 * @throws BizException 
	 */
	@MMethod("恢复已暂停的流程实例")
	@MParam(name="流程实例编码",type="String")
	public void resumeProcessInstance(String piid) throws BizException {
		MFExecutionService service = getExecutionService();
		service.resumeProcessIns(piid, true);
	}

	/**
	 * 终止活动实例
	 * @throws BizException 
	 */
	@MMethod("终止活动实例")
	@MParam(name="活动实例编码",type="String")
	public void terminateActivityInstance(String aiid) throws BizException {
		MFExecutionService service = getExecutionService();
		service.terminateActivityIns(aiid);
	}

	/**
	 * 修改实例变量
	 * @throws BizException 
	 */
	@MMethod("修改实例变量")
	@MParam(name="流程实例编码,流程模板编码,变量名称,变量值",type="String, String, String, Object")
	public void updateInstanceVariableData(String piid, String ptid,
			String variableName, Object variable) throws BizException {
		MFExecutionService service = getExecutionService();
		service.updateProcessInsVariable(piid, ptid, variableName, variable);
	}

	/**
	 * 将指定流程实例迁移到新的版本
	 * @throws BizException 
	 */
	@MMethod("将指定流程实例迁移到新的版本")
	@MParam(name="流程实例编码,新的模板编码",type="String, String")
	public void migrate(String piid, String toPtid) throws BizException {
		MFExecutionService service = getExecutionService();
		service.upgradeProcessInstance(piid, toPtid);
	}

	/**
	 * 获取流程实例变量
	 * @throws BizException 
	 */
	@MMethod("获取流程实例变量")
	@MParam(name="流程实例编码,流程模板编码,变量名称",type="String, String, String")
	@MReturn(name="流程初始数据",type="Object")
	public Object getInstanceVariableData(String piid, String ptid,
			String variableName) throws BizException {
		MFExecutionService service = getExecutionService();
		return service.getProcessInsVariable(piid, variableName);
	}

	/**
	 * 查询流程实例
	 */
	@MMethod("查询流程实例")
	@MParam(name="查询条件,排序条件",type="String,String")
	@MReturn(name="流程实例DataObject列表",type="List")
	public List queryProcessInstances(String filter, String orderFilter) {
		MFExecutionService executionService = getExecutionService();
		List list = executionService.queryProcessInses(filter, orderFilter, true);
		DataObject listObj = DASHelper.getList();

		List processInsDOs = new ArrayList();
		for(Iterator iter = list.iterator(); iter.hasNext(); ){
			ProcessInstance processIns = (ProcessInstance)iter.next();
			DataObject procInsDO = convertProcessInstance(processIns);
			processInsDOs.add(procInsDO);
		}

		return processInsDOs;
	}

	/**
	 * 分页查询流程实例
	 */
	@MMethod("分页查询流程实例")
	@MParam(name="查询条件,排序条件,开始行数,每页行数",type="String,String,int,int")
	@MReturn(name="分页对象",type="Page")
	public Page queryProcessInstancesPage(String filter,String orderFilter, int startRow, int rowCount) {
		MFExecutionService executionService = getExecutionService();
		com.matrix.api.util.Page page = executionService.queryProcessInses(filter, orderFilter, true, startRow, rowCount);
		
		List processInsDOs = new ArrayList();
		for(Iterator iter = page.getDataList().iterator(); iter.hasNext(); ){
			ProcessInstance processIns = (ProcessInstance)iter.next();
			DataObject procInsDO = convertProcessInstance(processIns);
			processInsDOs.add(procInsDO);
		}
		
		Page result = new PageVO(processInsDOs, startRow, rowCount, Integer.valueOf(page.getTotalSize()+""));
		
		return result;
	}

	/**
	 * 查询活动实例
	 */
	@MMethod("查询活动实例")
	@MParam(name="查询条件,排序条件",type="String,String")
	@MReturn(name="活动实例DataObject对象列表",type="List")
	public List queryActivityInstances(String filter, String orderFilter) {
		MFExecutionService executionService = getExecutionService();
		List list = executionService.queryActivityInses(filter, orderFilter, true);
		DataObject listObj = DASHelper.getList();
		List actInsDOs = new ArrayList();
		for(Iterator iter = list.iterator(); iter.hasNext(); ){
			ActivityInstance actIns = (ActivityInstance)iter.next();
			DataObject actInsDO = convertActivityInstance(actIns);
			actInsDOs.add(actInsDO);
		}

		return actInsDOs;
	}

	/**
	 * 查询分页活动实例对象
	 */
	@MMethod("查询分页活动实例对象")
	@MParam(name="查询条件,排序条件,开始行数,每页行数",type="String,String,int,int")
	@MReturn(name="分页对象",type="Page")
	public Page queryActivityInstancesPage(String filter,String orderFilter, int startRow, int rowCount) {
		MFExecutionService executionService = getExecutionService();
		com.matrix.api.util.Page page = executionService.queryActivityInses(filter, orderFilter, true, startRow, rowCount);
		
		DataObject pageObj = DASHelper.getPage();
		List actInses = page.getDataList();
		List actInsDOs = new ArrayList();
		for(Iterator iter = actInses.iterator(); iter.hasNext(); ){
			ActivityInstance actIns = (ActivityInstance)iter.next();
			DataObject actInsDO = convertActivityInstance(actIns);
			actInsDOs.add(actInsDO);
		}
		
		Page result = new PageVO(actInsDOs, startRow, rowCount, Integer.valueOf(page.getTotalSize()+""));

		return result;
	}

	/**
	 * 修改流程实例优先级
	 * @param piid(流程实例编码)
	 * @param priority(优先级)
	 */
	@MMethod("修改流程实例优先级")
	@MParam(name="流程实例编码,优先级",type="String, int")
	public void updateProcessInsPriority(String piid,int priority) throws BizException {
		MFExecutionService executionService = getExecutionService();
		executionService.updateProcessInsPriority(piid, priority);
	}

	/**
	 * 修改活动实例优先级
	 * @param aiid(活动实例编码)
	 * @return newPriority(新的优先级)
	 */
	@MMethod("修改活动实例优先级")
	@MParam(name="活动实例编码,新的优先级",type="String, int")
	public void updateActivityInsPriority(String aiid, int newPriority){
		MFExecutionService executionService = getExecutionService();
		executionService.updateProcessInsPriority(aiid, newPriority);
	}

	/**
	 * 暂停活动实例
	 * @param aiid(活动实例编码)
	 */
	@MMethod("暂停活动实例")
	@MParam(name="活动实例编码",type="String")
	public void suspendActivityInstance(String aiid){
		MFExecutionService service = getExecutionService();
		service.suspendActivityIns(aiid);
	}

	/**
	 * 恢复暂停的活动实例
	 * @param aiid(活动实例编码)
	 */
	@MMethod("恢复暂停的活动实例")
	@MParam(name="活动实例编码",type="String")
	public void resumeActivityInstance(String aiid){
		MFExecutionService service = getExecutionService();
		service.resumeActivityIns(aiid);
	}

	/**
	 * 获取流程实例对象
	 * @param piid(流程实例编码)
	 * @return processInstance(流程实例对象2)
	 */
	@MMethod("获取流程实例对象")
	@MParam(name="流程实例编码",type="String")
	@MReturn(name="流程实例对象",type="commonservice.processservice.processinstancemgr.ProcessInstance")
	public DataObject getProcessInstance(String piid){
		MFExecutionService executionService = getExecutionService();
		ProcessInstance processIns = executionService.getProcessInsById(piid);
		
		DataObject procInsDO = convertProcessInstance(processIns);
	
		return procInsDO;
	}

	/**
	 * 获取活动实例对象
	 * @param aiid(活动实例编码)
	 * @return actiovityModel(活动实例)
	 */
	@MMethod("获取活动实例对象")
	@MParam(name="活动实例编码",type="String")
	@MReturn(name="流程实例对象",type="commonservice.processservice.processinstancemgr.ActivityInstance")
	public DataObject getActivityInstance(String aiid)throws BizException{	
		MFExecutionService executionService = getExecutionService();
		ActivityInstance actIns = executionService.getActivityInsById(aiid);
		
		DataObject actInsDO = convertActivityInstance(actIns);
	
		return actInsDO;
	}
	
	//获取流程执行服务
	private MFExecutionService getExecutionService(){
//		Map map = MFacesContext.getCurrentInstance().getExternalContext().getSessionMap();
//		MFExecutionService service = (MFExecutionService)map.get(ClientConstants.EXECUTION_SERVICE);
		MFExecutionService service = (MFExecutionService)SessionContextHolder.getSession().getAttribute(ClientConstants.EXECUTION_SERVICE);
		return service;
	}
	
	private DataObject convertActivityInstance(ActivityInstance actIns){
		DataObject actInsDO = DataObjectHelper.getDataObjectOfEntity("com.matrix.commonservice.process.processinstance.ActivityInstance");
		actInsDO.setString("aiid", actIns.getAiid());
		actInsDO.setString("adid", actIns.getAdid());
		actInsDO.setString("atid", actIns.getAtid());
		actInsDO.setString("pdid", actIns.getPdid());
		actInsDO.setString("piid", actIns.getPiid());
		actInsDO.setString("ptid", actIns.getPtid());
		actInsDO.setString("processName", actIns.getProcessName());
		actInsDO.setString("btid", actIns.getBtid());
		actInsDO.setString("biid", actIns.getBiid());
		actInsDO.setString("blockName", actIns.getBlockName());
		actInsDO.setString("activityName", actIns.getActivityName());
		actInsDO.setString("desc", actIns.getDesc());
		actInsDO.setInt("insideType", actIns.getInsideType());
		actInsDO.setInt("activityType", actIns.getActivityType().getValue());
		actInsDO.setInt("priority", actIns.getPriority());
		actInsDO.setString("starterId", actIns.getStarterId());
		actInsDO.setString("executorId", actIns.getExecutorId());
		actInsDO.setString("starterName", actIns.getStarterName());
		actInsDO.setString("executorName", actIns.getExecutorName());
		if(actIns.getStartedDate() != null){
			Date startedDate = new Date(actIns.getStartedDate().getTime());
			actInsDO.setDate("startedDate", startedDate);
		}
		if(actIns.getActivedDate() != null){
			Date activedDate = new Date(actIns.getActivedDate().getTime());
			actInsDO.setDate("activedDate", activedDate);
		}
		if(actIns.getExecutedDate() != null){
			Date executedDate = new Date(actIns.getExecutedDate().getTime());
			actInsDO.setDate("executedDate", executedDate);
		}
		if(actIns.getCompletedDate() != null){
			Date completedDate = new Date(actIns.getCompletedDate().getTime());
			actInsDO.setDate("completedDate", completedDate);
		}
		if(actIns.getExpiredDate()!= null){
			Date expiredDate = new Date(actIns.getExpiredDate().getTime());
			actInsDO.setDate("expiredDate", expiredDate);
		}
		if(actIns.getLastModifiedDate()!= null){
			Date lastModifiedDate = new Date(actIns.getLastModifiedDate().getTime());
			actInsDO.setDate("lastModifiedDate", lastModifiedDate);
		}
		if(actIns.getContainerExpiredDate() != null){
			Date containerExpiredDate = new Date(actIns.getContainerExpiredDate().getTime());
			actInsDO.setDate("containerExpiredDate", containerExpiredDate);
		}
		actInsDO.setInt("status", actIns.getStatus().getValue());
		actInsDO.setString("subflowTID", actIns.getSubflowTID());
		actInsDO.setString("subflowIID", actIns.getSubflowIID());
		actInsDO.setString("parallelID", actIns.getParallelID());
		actInsDO.setLong("workDuration", actIns.getWorkDuration());
		actInsDO.setString("fromActInsId", "");
		actInsDO.setBoolean("isGoBack", actIns.isGoBack());
		
		DataObject exDO = convertExAttributes(actIns.getExAttributes());
		actInsDO.setDataObject("exAttributes", exDO);
		
		return actInsDO;
	}
	
	private DataObject convertProcessInstance(ProcessInstance processIns){
		DataObject procInsDO = DataObjectHelper.getDataObjectOfEntity("com.matrix.commonservice.process.processinstance.ProcessInstance");
		
		procInsDO.setString("piid", processIns.getPiid());
		procInsDO.setString("ptid", processIns.getPtid());
		procInsDO.setString("pdid", processIns.getPdid());
		procInsDO.setString("processName", processIns.getProcessName());
		procInsDO.setString("desc", processIns.getDesc());
		procInsDO.setString("creator", processIns.getCreator());
		procInsDO.setString("starter", processIns.getStarter());
		procInsDO.setInt("priority", processIns.getPriority());
		procInsDO.setInt("status", processIns.getStatus().getValue());
		procInsDO.setString("parentPtid", processIns.getParentPtid());
		procInsDO.setString("parentPiid", processIns.getParentPiid());
		procInsDO.setString("parentProcessName", processIns.getParentPName());
		if(processIns.getStartedDate() != null){
			Date startedDate = new Date(processIns.getStartedDate().getTime());
			procInsDO.setDate("startedDate", startedDate);
		}
		if(processIns.getCreatedDate() != null){
			Date createdDate = new Date(processIns.getCreatedDate().getTime());
			procInsDO.setDate("createdDate", createdDate);
		}
		if(processIns.getCompletedDate() != null){
			Date completedDate = new Date(processIns.getCompletedDate().getTime());
			procInsDO.setDate("completedDate", completedDate);
		}
		if(processIns.getLastModifiedDate()!= null){
			Date lastModifiedDate = new Date(processIns.getLastModifiedDate().getTime());
			procInsDO.setDate("lastModifiedDate", lastModifiedDate);
		}
		if(processIns.getExpiredDate()!= null){
			Date expiredDate = new Date(processIns.getExpiredDate().getTime());
			procInsDO.setDate("expiredDate", expiredDate);
		}
		procInsDO.setString("topPiid", processIns.getTopPiid());
		procInsDO.setString("topPtid", processIns.getTopPtid());
		procInsDO.setString("topProcessName", processIns.getTopPName());
		procInsDO.setLong("workDuration", processIns.getWorkDuration());
		procInsDO.setString("exAttributeA", processIns.getExAttributes().getExAttributeA());
		procInsDO.setString("exAttributeB", processIns.getExAttributes().getExAttributeB());
		procInsDO.setString("exAttributeC", processIns.getExAttributes().getExAttributeC());
		procInsDO.setString("exAttributeD", processIns.getExAttributes().getExAttributeD());
		procInsDO.setString("exAttributeE", processIns.getExAttributes().getExAttributeE());
		procInsDO.setString("exAttributeH", processIns.getExAttributes().getExAttributeH());
//		DataObject exDO = convertExAttributes(processIns.getExAttributes());
//		procInsDO.setDataObject("exAttributes", exDO);
	
		return procInsDO;
	}
	
	private DataObject convertExAttributes(ExAttributes exAttributes){
		DataObject exDO = DataObjectHelper.getDataObjectOfEntity("com.matrix.commonservice.process.processinstance.ExAttributes");
		
		if(exAttributes == null)
			return exDO;
			
		exDO.setString("ExAttributeA", exAttributes.getExAttributeA());
		exDO.setString("ExAttributeB", exAttributes.getExAttributeB());
		exDO.setString("ExAttributeC", exAttributes.getExAttributeC());
		exDO.setString("ExAttributeD", exAttributes.getExAttributeD());
		exDO.setString("ExAttributeE", exAttributes.getExAttributeE());
		exDO.setString("ExAttributeF", exAttributes.getExAttributeF());
		exDO.setString("ExAttributeG", exAttributes.getExAttributeG());
		exDO.setString("ExAttributeH", exAttributes.getExAttributeH());
		
		return exDO;
	}
	

}