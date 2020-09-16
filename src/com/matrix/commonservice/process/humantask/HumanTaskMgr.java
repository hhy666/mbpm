/** 
 * 人工活动服务
 * @author msg
 * 日期:2008-11-07
 */
package com.matrix.commonservice.process.humantask;

import java.util.List;

import com.matrix.annotation.MMethod;
import com.matrix.annotation.MParam;
import com.matrix.annotation.MReturn;
import com.matrix.app.api.BizException;
import com.matrix.app.api.Page;

import commonj.sdo.DataObject;

public interface HumanTaskMgr {
	/**
	 * 查询工作任务
	 * 
	 * @param filter --
	 *            查询条件
	 * @param orderFilter --
	 *            排序条件
	 * @return anyType -- 任意对象
	 */
	@MMethod("查询工作任务")
	@MParam(name="查询条件,排序条件",type="String,String")
	@MReturn(name="Task DataObject对象列表",type="List")
	public List queryTasks(String filter, String orderFilter)throws BizException;

	/**
	 * 分页查询待办任务
	 * 
	 * @param filter --
	 *            查询条件
	 * @param orderFilter --
	 *            排序条件
	 * @param startRow --
	 *            开始行数
	 * @param rowCount --
	 *            每页行数
	 * @return Page -- 分页对象
	 */
	@MMethod("分页查询待办任务")
	@MParam(name="查询条件,排序条件,开始行数,每页行数",type="String,String,int,int")
	@MReturn(name="分页对象",type="Page")
	public Page queryTasksPage(String filter, String orderFilter,int startRow, int rowCount)throws BizException;


	/**
	 * 创建新的浏览工作任务项
	 * @param aiid(人工活动实例编码)
	 * @param newOwner(新工作任务的拥有者)
	 */
	@MMethod("创建新的浏览工作任务项")
	@MParam(name="人工任务相关活动实例编码,新工作任务的用户编码",type="String,String")
	public void createViewTask(String aiid,String newOwner)throws BizException;

	/**
	 * 锁定工作任务
	 * @param taskId(工作任务项编码)
	 */
	@MMethod("锁定工作任务")
	@MParam(name="工作任务项编码",type="String")
	public void claimTask(String taskId)throws BizException;

	/**
	 * 取消对工作任务的锁定
	 * @param taskId(人工活动实例编码)
	 */
	@MMethod("取消对工作任务的锁定")
	@MParam(name="工作任务项编码",type="String")
	public void releaseTask(String taskId)throws BizException;

	/**
	 * 转交工作任务
	 * @param taskId(工作任务项编码)
	 * @param targetUserId(目标用户编码)
	 */
	@MMethod("转交工作任务")
	@MParam(name="工作任务项编码,目标用户编码",type="String,String")
	public void transferTask(String taskId,String targetUserId)throws BizException;

	/**
	 * 取消转交工作任务
	 * @param taskId(工作任务项编码)
	 */
	@MMethod("取消转交工作任务")
	@MParam(name="工作任务项编码",type="String")
	public void cancelTransferedTask(String taskId)throws BizException;

	/**
	 * 完成工作任务项
	 * @param taskId(工作任务项编码)
	 */
	@MMethod("完成工作任务项")
	@MParam(name="工作任务项编码",type="String")
	public void completeTask(String taskId)throws BizException;

	/**
	 * 退回任务
	 * @param taskId(工作任务项编码)
	 */
	@MMethod("退回任务")
	@MParam(name="工作任务项编码",type="String")
	public void gobackTask(String taskId)throws BizException;

	/**
	 * 创建新的工作任务项
	 * @param aiid(活动实例编码)
	 * @param newOwner(新的拥有者用户编码)
	 */
	@MMethod("创建新的工作任务项")
	@MParam(name="活动实例编码, 新的拥有者用户编码",type="String,String")
	public void createNewTask(String aiid,String newOwner)throws BizException;

	/**
	 * 创建新的协作任务项
	 * @param aiid(活动实例编码)
	 * @param newOwner(新的拥有者用户编码)
	 */
	@MMethod("创建新的协作任务项")
	@MParam(name="活动实例编码, 新的拥有者用户编码",type="String,String")
	public void createAssistTask(String aiid,String newOwner)throws BizException;

	/**
	 * 删除任务
	 * @param taskId(任务编码)
	 */
	@MMethod("删除任务")
	@MParam(name="任务编码",type="String")
	public void deleteTask(String taskId)throws BizException;

	/**
	 * 取消委托工作任务
	 * @param taskId(任务编码)
	 */
	@MMethod("取消委托工作任务")
	@MParam(name="任务编码",type="String")
	public void cancelDelegation(String taskId)throws BizException;

	/**
	 * 撤回工作任务
	 * @param taskId(任务编码)
	 */
	@MMethod("撤回工作任务")
	@MParam(name="任务编码",type="String")
	public void withdraw(String taskId)throws BizException;

	/**
	 * 完成任务
	 * @param taskId(任务编码)
	 * @param selectedTdid(选择的转移编码)
	 * @param potentialOwners(选择的人员)
	 */
	@MMethod("完成任务")
	@MParam(name="任务编码,选择的转移编码,选择的人员编码列表",type="String,String,List")
	public void completeTask(String taskId,String selectedTdid,List potentialOwners)throws BizException;
	
}