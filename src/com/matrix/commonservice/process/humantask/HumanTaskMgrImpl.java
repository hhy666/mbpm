/** 
 * 人工活动服务实现
 * @author msg
 * 日期:2008-11-07
 */
package com.matrix.commonservice.process.humantask;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.matrix.faces.context.MFacesContext;

import com.matrix.annotation.MMethod;
import com.matrix.annotation.MParam;
import com.matrix.annotation.MReturn;
import com.matrix.api.MFExecutionService;
import com.matrix.api.data.ExAttributes;
import com.matrix.api.identity.MFUser;
import com.matrix.api.instance.task.Task;
import com.matrix.api.security.PotentialOwners;
import com.matrix.app.api.BizException;
import com.matrix.app.api.Page;
import com.matrix.app.api.model.PageVO;
import com.matrix.client.ClientConstants;
import com.matrix.engine.util.CommonUtil;
import com.matrix.extention.SessionContextHolder;
import com.matrix.form.util.DataObjectHelper;
import commonj.sdo.DataObject;


@SuppressWarnings("unchecked")
public class HumanTaskMgrImpl implements HumanTaskMgr {
	/**
	 * 查询工作任务
	 * @throws MatrixException 
	 */
	@MMethod("查询工作任务")
	@MParam(name="查询条件,排序条件",type="String,String")
	@MReturn(name="Task DataObject对象列表",type="List")
	public List queryTasks(String filter, String orderFilter) throws BizException {
		MFExecutionService executionService = getExecutionService();
		List tasks = executionService.queryTasks(filter, orderFilter);
		List taskDOs = new ArrayList();
		for(Iterator iter = tasks.iterator(); iter.hasNext(); ){
			Task task = (Task)iter.next();
			DataObject actInsDO = convertTask(task);
			taskDOs.add(actInsDO);
		}
		
		return taskDOs;

	}

	/**
	 * 分页查询待办任务
	 * @throws BizException 
	 */
	@MMethod("分页查询待办任务")
	@MParam(name="查询条件,排序条件,开始行数,每页行数",type="String,String,int,int")
	@MReturn(name="分页对象",type="Page")
	public Page queryTasksPage(String filter, String orderFilter,	int startRow, int rowCount) throws BizException {
		MFExecutionService executionService = getExecutionService();
		com.matrix.api.util.Page page = executionService.queryTasks(filter, orderFilter, startRow, rowCount);
		List tasks = page.getDataList();
		List taskDOs = new ArrayList();
		for(Iterator iter = tasks.iterator(); iter.hasNext(); ){
			Task task = (Task)iter.next();
			DataObject actInsDO = convertTask(task);
			taskDOs.add(actInsDO);
		}
		Page result = new PageVO(taskDOs, startRow, rowCount, Integer.valueOf(page.getTotalSize()+""));

		
		return result;
	}

	private MFUser getLogonedUser() throws BizException{

		MFExecutionService service = getExecutionService();
		MFUser user = service.getMFUser();
		if(user == null)
			throw new BizException(BizException.nonLogonedUser, "current no logoned user" );
		
		return user;
	}

	/**
	 * 创建新的浏览工作任务项
	 * @param aiid(人工活动实例编码)
	 * @param newOwner(新工作任务的拥有者)
	 */
	@MMethod("创建新的浏览工作任务项")
	@MParam(name="人工任务相关活动实例编码,新工作任务的用户编码",type="String,String")
	public void createViewTask(String aiid,String newOwner) throws BizException {
		MFExecutionService service = getExecutionService();
		service.createViewTask(aiid, newOwner);
	}

	/**
	 * 锁定工作任务
	 * @param taskId(工作任务项编码)
	 */
	@MMethod("锁定工作任务")
	@MParam(name="工作任务项编码",type="String")
	public void claimTask(String taskId) throws BizException {
		MFExecutionService service = getExecutionService();
		service.claimTask(taskId);
	}

	/**
	 * 取消对工作任务的锁定
	 * @param taskId(工作任务项编码)
	 */
	@MMethod("取消对工作任务的锁定")
	@MParam(name="工作任务项编码",type="String")
	public void releaseTask(String taskId) throws BizException {
		MFExecutionService service = getExecutionService();
		service.releaseTask(taskId);
	}

	/**
	 * 转交工作任务
	 * @param taskId(工作任务项编码)
	 * @param targetUserId(目标拥有者编码)
	 */
	@MMethod("转交工作任务")
	@MParam(name="工作任务项编码,目标用户编码",type="String,String")
	public void transferTask(String taskId,String targetUserId) throws BizException {
		MFExecutionService service = getExecutionService();
		service.transferTask(taskId, targetUserId);
	}

	/**
	 * 取消转交工作任务
	 * @param taskId(工作任务项编码)
	 */
	@MMethod("取消转交工作任务")
	@MParam(name="工作任务项编码",type="String")
	public void cancelTransferedTask(String taskId) throws BizException {
		MFExecutionService service = getExecutionService();
		service.cancelTransferedTask(taskId);
	}

	/**
	 * 完成工作任务项
	 * @param taskId(工作任务项编码)
	 */
	@MMethod("完成工作任务项")
	@MParam(name="工作任务项编码",type="String")
	public void completeTask(String taskId) throws BizException {
		MFExecutionService service = getExecutionService();
		service.completeTask(taskId);
	}

	/**
	 * 退回任务
	 * @param taskId(工作任务项编码)
	 */
	@MMethod("退回任务")
	@MParam(name="工作任务项编码",type="String")
	public void gobackTask(String taskId){
		//[开始]=============下方代码平台自动生成，请勿修改===============
		MFExecutionService service = getExecutionService();
		service.gobackTask(taskId);
	}
	
	//获取流程执行服务
	private MFExecutionService getExecutionService(){
//		Map map = MFacesContext.getCurrentInstance().getExternalContext().getSessionMap();
//		MFExecutionService service = (MFExecutionService)map.get(ClientConstants.EXECUTION_SERVICE);
		MFExecutionService service = (MFExecutionService)SessionContextHolder.getSession().getAttribute(ClientConstants.EXECUTION_SERVICE);
		return service;
	}

	/**
	 * 创建新的工作任务项
	 * @param aiid(活动实例编码)
	 * @param newOwner(新的拥有者用户编码)
	 */
	@MMethod("创建新的工作任务项")
	@MParam(name="活动实例编码, 新的拥有者用户编码",type="String,String")
	public void createNewTask(String aiid,String newOwner){
		MFExecutionService service = getExecutionService();
		service.createNewTask(aiid, newOwner);
	}

	/**
	 * 创建新的协作任务项
	 * @param aiid(活动实例编码)
	 * @param newOwner(新的拥有者用户编码)
	 */
	@MMethod("创建新的协作任务项")
	@MParam(name="活动实例编码, 新的拥有者用户编码",type="String,String")
	public void createAssistTask(String aiid,String newOwner){
		MFExecutionService service = getExecutionService();
		service.createAssistTask(aiid, newOwner);
	}

	private DataObject convertTask(Task task){
		DataObject taskDO = DataObjectHelper.getDataObjectOfEntity("com.matrix.commonservice.process.humantask.Task");
		taskDO.setString("taskId", task.getTaskId());
		taskDO.setString("aiid", task.getAiid());
		taskDO.setString("adid", task.getAdid());
		taskDO.setString("atid", task.getAtid());
		taskDO.setString("pdid", task.getPdid());
		taskDO.setString("piid", task.getPiid());
		taskDO.setString("ptid", task.getPtid());
		taskDO.setString("processName", task.getProcessName());
		taskDO.setString("biid", task.getBiid());
		taskDO.setString("blockName", task.getBlockName());
		taskDO.setString("activityName", task.getActivityName());
		taskDO.setString("desc", task.getDesc());
		taskDO.setInt("taskType", task.getTaskTypeInt());
		taskDO.setInt("assignType", task.getAssignTypeInt());
		taskDO.setInt("priority", task.getPriority());
		taskDO.setString("starterId", task.getStarterId());
		taskDO.setString("targetUserId", task.getTargetUserId());
		taskDO.setString("targetUserName", task.getTargetUserName());
		taskDO.setString("owner", task.getOwner());
		taskDO.setString("starterId", task.getStarterId());
		taskDO.setString("starterName", task.getStarterName());
		if(taskDO.getType().getProperty("completeType") != null && task.getCompleteType()!=null){
			taskDO.setInt("completeType", task.getCompleteType().getValue());
		}
		if(task.getStartedDate() != null){
			Date startedDate = new Date(task.getStartedDate().getTime());
			taskDO.setDate("startedDate", startedDate);
		}
		if(task.getReceivedDate() != null){
			Date completedDate = new Date(task.getReceivedDate().getTime());
			taskDO.setDate("receivedDate", completedDate);
		}
		if(task.getExpiredDate()!= null){
			Date expiredDate = new Date(task.getExpiredDate().getTime());
			taskDO.setDate("expiredDate", expiredDate);
		}
		if(task.getLastModifiedDate()!= null){
			Date lastModifiedDate = new Date(task.getLastModifiedDate().getTime());
			taskDO.setDate("lastModifiedDate", lastModifiedDate);
		}
		taskDO.setInt("status", task.getStatus().getValue());
		taskDO.setString("exeURL", task.getExeURL());
		taskDO.setString("assistURL", task.getAssistURL());
		taskDO.setString("viewURL", task.getViewURL());
		taskDO.setBoolean("isGoBack", task.isGoBack());
		taskDO.setString("desc", task.getDesc());
		taskDO.setString("exAttributeA", task.getExAttributes().getExAttributeA());
		taskDO.setString("exAttributeB", task.getExAttributes().getExAttributeB());
		taskDO.setString("exAttributeC", task.getExAttributes().getExAttributeC());
		taskDO.setString("exAttributeD", task.getExAttributes().getExAttributeD());
		taskDO.setString("exAttributeE", task.getExAttributes().getExAttributeE());
		taskDO.setString("exAttributeF", task.getExAttributes().getExAttributeF());
		taskDO.setString("exAttributeG", task.getExAttributes().getExAttributeG());
		taskDO.setString("exAttributeH", task.getExAttributes().getExAttributeH());
		
//		DataObject exDO = convertExAttributes(task.getExAttributes());
//		taskDO.setDataObject("exAttributes", exDO);
		
		return taskDO;
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

	/**
	 * 删除任务
	 * @param taskId(任务编码)
	 */
	@MMethod("删除任务")
	@MParam(name="任务编码",type="String")
	public void deleteTask(String taskId) throws BizException {
		MFExecutionService service = getExecutionService();
		service.deleteTask(taskId);
	}

	/**
	 * 取消委托工作任务
	 * @param taskId(任务编码)
	 */
	@MMethod("取消委托工作任务")
	@MParam(name="任务编码",type="String")
	public void cancelDelegation(String taskId) throws BizException {
		MFExecutionService service = getExecutionService();
		service.cancelSubstitutedTask(taskId);
	}

	/**
	 * 撤回工作任务
	 * @param taskId(任务编码)
	 */
	@MMethod("撤回工作任务")
	@MParam(name="任务编码",type="String")
	public void withdraw(String taskId) throws BizException {
		MFExecutionService service = getExecutionService();
		service.withdrawTask(taskId);
	}

	/**
	 * 完成任务
	 * @param taskId(任务编码)
	 * @param selectedTdid(选择的转移编码)
	 * @param potentialOwners(选择的人员)
	 */
	@MMethod("完成任务")
	@MParam(name="任务编码,选择的转移编码,选择的人员编码列表",type="String,String,List")
	public void completeTask(String taskId,String selectedTdid,List potentialOwners){
		MFExecutionService service = getExecutionService();
		PotentialOwners owners = new PotentialOwners();
		if(potentialOwners!=null){
			if (!CommonUtil.isNullOrEmpty(potentialOwners)) {
				for (Iterator iter = potentialOwners.iterator(); iter.hasNext();) {
					String assignee = (String) iter.next();
					owners.addUser(assignee);
				}
			}
		}
		
		service.completeTask(taskId, selectedTdid, owners);
	}
	
}