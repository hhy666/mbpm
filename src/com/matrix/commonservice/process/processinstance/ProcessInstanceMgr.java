/** 
 * 流程实例服务
 * @author msg
 * 日期:2008-11-07
 */
package com.matrix.commonservice.process.processinstance;

import java.util.List;

import com.matrix.annotation.MMethod;
import com.matrix.annotation.MParam;
import com.matrix.annotation.MReturn;
import com.matrix.app.api.BizException;
import com.matrix.app.api.Page;

import commonj.sdo.DataObject;

public interface ProcessInstanceMgr {
	/**
	 * 删除流程实例
	 * 
	 * @param piid --
	 *            流程实例编码
	 */
	@MMethod("删除流程实例")
	@MParam(name="流程实例编码",type="String")
	public void deleteProcessInstance(String piid)throws BizException;

	/**
	 * 终止流程实例
	 * 
	 * @param piid --
	 *            流程实例编码
	 */
	@MMethod("终止流程实例")
	@MParam(name="流程实例编码",type="String")
	public void terminateProcessInstance(String piid)throws BizException;

	/**
	 * 暂停流程实例
	 * 
	 * @param piid --
	 *            流程实例编码
	 */
	@MMethod("暂停流程实例")
	@MParam(name="流程实例编码",type="String")
	public void suspendProcessInstance(String piid)throws BizException;

	/**
	 * 恢复已暂停的流程实例
	 * 
	 * @param piid --
	 *            流程实例编码
	 */
	@MMethod("恢复已暂停的流程实例")
	@MParam(name="流程实例编码",type="String")
	public void resumeProcessInstance(String piid)throws BizException;

	/**
	 * 终止活动实例
	 * 
	 * @param aiid --
	 *            活动实例编码
	 */
	@MMethod("终止活动实例")
	@MParam(name="活动实例编码",type="String")
	public void terminateActivityInstance(String aiid)throws BizException;

	/**
	 * 修改实例变量
	 * 
	 * @param piid --
	 *            流程实例编码
	 * @param containerIId --
	 *            容器实例编码
	 * @param variableName --
	 *            变量名称
	 * @param variable --
	 *            变量
	 */
	@MMethod("修改实例变量")
	@MParam(name="流程实例编码,流程模板编码,变量名称,变量值",type="String, String, String, Object")
	public void updateInstanceVariableData(String piid, String ptid, String variableName, Object variable)throws BizException;

	/**
	 * 将指定流程实例迁移到新的版本
	 * 
	 * @param piid --
	 *            指定流程实例编码
	 * @param toPtid --
	 *            新的模板编码
	 */
	@MMethod("将指定流程实例迁移到新的版本")
	@MParam(name="流程实例编码,新的模板编码",type="String, String")
	public void migrate(String piid, String toPtid)throws BizException;

	/**
	 * 获取流程实例变量
	 * 
	 * @param piid --
	 *            流程实例编码
	 * @param ptid --
	 *            流程模板编码
	 * @param variableName --
	 *            变量名称
	 * @return anySimpleType -- 任意简单类型
	 */
	@MMethod("获取流程实例变量")
	@MParam(name="流程实例编码,流程模板编码,变量名称",type="String, String, String")
	@MReturn(name="流程初始数据",type="Object")
	public Object getInstanceVariableData(String piid, String containerIId,	String variableName)throws BizException;

	/**
	 * 查询流程实例
	 * 
	 * @param filter --
	 *            查询条件
	 * @param orderFilter --
	 *            排序条件
	 * @return anyType -- 任意对象
	 */
	@MMethod("查询流程实例")
	@MParam(name="查询条件,排序条件",type="String,String")
	@MReturn(name="流程实例DataObject列表",type="List")
	public List queryProcessInstances(String filter, String orderFilter)throws BizException;

	/**
	 * 分页查询流程实例
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
	@MMethod("分页查询流程实例")
	@MParam(name="查询条件,排序条件,开始行数,每页行数",type="String,String,int,int")
	@MReturn(name="分页对象",type="Page")
	public Page queryProcessInstancesPage(String filter,	String orderFilter, int startRow, int rowCount)throws BizException;

	/**
	 * 查询活动实例
	 * 
	 * @param filter --
	 *            查询条件
	 * @param orderFilter --
	 *            排序条件
	 * @return anyType -- 任意对象
	 */
	@MMethod("查询活动实例")
	@MParam(name="查询条件,排序条件",type="String,String")
	@MReturn(name="活动实例DataObject对象列表",type="List")
	public List queryActivityInstances(String filter, String orderFilter)throws BizException;

	/**
	 * 查询分页活动实例对象
	 * 
	 * @param filter --
	 *            查询条件
	 * @param orderFilter --
	 *            排序条件
	 * @param startRow --
	 *            开始行数
	 * @param rowCount --
	 *            页显示行数
	 * @return Page -- 分页对象
	 */
	@MMethod("查询分页活动实例对象")
	@MParam(name="查询条件,排序条件,开始行数,每页行数",type="String,String,int,int")
	@MReturn(name="分页对象",type="Page")
	public Page queryActivityInstancesPage(String filter,	String orderFilter, int startRow, int rowCount)throws BizException;

	/**
	 * 修改流程实例优先级
	 * @param piid(流程实例编码)
	 * @param priority(优先级)
	 */
	@MMethod("修改流程实例优先级")
	@MParam(name="流程实例编码,优先级",type="String, int")
	public void updateProcessInsPriority(String piid,int priority)throws BizException;

	/**
	 * 修改活动实例优先级
	 * @param aiid(活动实例编码)
	 * @return newPriority(新的优先级)
	 */
	@MMethod("修改活动实例优先级")
	@MParam(name="活动实例编码,新的优先级",type="String, int")
	public void updateActivityInsPriority(String aiid, int newPriority);

	/**
	 * 暂停活动实例
	 * @param aiid(活动实例编码)
	 */
	@MMethod("暂停活动实例")
	@MParam(name="活动实例编码",type="String")
	public void suspendActivityInstance(String aiid);

	/**
	 * 恢复暂停的活动实例
	 * @param aiid(活动实例编码)
	 */
	@MMethod("恢复暂停的活动实例")
	@MParam(name="活动实例编码",type="String")
	public void resumeActivityInstance(String aiid);

	/**
	 * 获取流程实例对象
	 * @param piid(流程实例编码)
	 * @return processInstance(流程实例对象2)
	 */
	@MMethod("获取流程实例对象")
	@MParam(name="流程实例编码",type="String")
	@MReturn(name="流程实例对象",type="commonservice.processservice.processinstancemgr.ProcessInstance")
	public DataObject getProcessInstance(String piid);

	/**
	 * 获取活动实例对象
	 * @param aiid(活动实例编码)
	 * @return actiovityModel(活动实例)
	 */
	@MMethod("获取活动实例对象")
	@MParam(name="活动实例编码",type="String")
	@MReturn(name="流程实例对象",type="commonservice.processservice.processinstancemgr.ActivityInstance")
	public DataObject getActivityInstance(String aiid)throws BizException;

}