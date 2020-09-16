/** 
 * 流程定义服务
 * @author msg
 * 日期:2008-11-07
 */
package com.matrix.commonservice.process.processdef;
import java.util.List;
import java.util.Map;

import com.matrix.annotation.MMethod;
import com.matrix.annotation.MParam;
import com.matrix.annotation.MReturn;
import com.matrix.app.api.BizException;
import commonj.sdo.DataObject;

public interface ProcessDefMgr {
  /** 
 * 创建流程实例
 * @param pdid --
 * 流程定义编码
 * @param input --
 * 流程输入数据
 * @return string -- 字符串
 */
	@MMethod("创建流程实例")
	@MParam(name="流程定义编码,流程输入数据",type="String,DataObject")
	@MReturn(name="流程实例编码",type="String")
  public String createProcessInstance(  String pdid,  DataObject input) throws BizException ;
  /** 
 * 启动流程实例
 * @param piid --
 * 流程实例编码
 */
	@MMethod("启动流程实例")
	@MParam(name="流程实例编码",type="String")
  public void startProcessInstance(  String piid) throws BizException ;
  /** 
 * 取得流程的输入数据
 * @param pdid --
 * 流程定义编码
 * @return anyType -- 任意对象
 */
	@MMethod("取得流程的输入数据")
	@MParam(name="流程定义编码",type="String")
	@MReturn(name="流程初始数据",type="DataObject")
  public DataObject getCreateInstanceData(  String pdid) throws BizException ;
  /** 
 * 创建和启动流程实例
 * @param pdid, 流程定义编码
 * @param inputData, 流程输入数据
 * @return 流程实例编码
 */
	@MMethod("创建和启动流程实例")
	@MParam(name="流程定义编码,流程初始数据",type="String,DataObject")
	@MReturn(name="流程实例编码",type="String")
  public String createAndStartProcessInstance(  String pdid,  DataObject inputData) throws BizException ;
  /** 
 * 创建并启动流程实例
 * @param pdid --
 * 流程定义对象编码
 * @param selectedTid --
 * 选择路径编码
 * @param inputMsg --
 * 流程输入数据
 * @return string -- 字符串
 */
	@MMethod("创建和启动流程实例")
	@MParam(name="流程定义编码,选择流转路径编码,流程初始数据",type="String,String,DataObject")
	@MReturn(name="流程实例编码",type="String")
  public String createAndStartProcessInstance(  String pdid,  String selectedTid,  DataObject inputMsg) throws BizException ;
  /** 
 * 创建并启动流程实例3
 * @param pdid --
 * 流程定义对象编码
 * @param selectedTid --
 * 选择路径编码
 * @param assigneeObj --
 * 选择下一步执行人
 * @param inputMsg --
 * 流程输入数据
 * @return string -- 字符串
 */
	@MMethod("创建和启动流程实例")
	@MParam(name="流程定义编码,选择流转路径编码,选择下一步执行人,流程初始数据",type="String, String, List, DataObject")
	@MReturn(name="流程实例编码",type="String")
  public String createAndStartProcessInstance(  String pdid,  String selectedTid,  List potentialOwners,  DataObject inputData) throws BizException ;
  /** 
 * 将指定流程模板的未完成流程实例迁移到新的版本
 * @param fromPtid --
 * 指定流程模板的编码
 * @param toPtid --
 * 新的模板编码
 */
	@MMethod("将指定流程模板的未完成流程实例迁移到新的版本")
	@MParam(name="指定流程模板的编码,新的模板编码",type="String, String")
	public void migrate(String fromPtid,String toPtid,Map adidMap)throws BizException ;
  /** 
 * 取得启动流程可能的流转路径
 * @param pdid, 流程定义编码
 * @param inputMsg, 流程初始数据
 * @return 可能流转对象(Transition)列表
 * @throws BizException
 */
	@MMethod("将指定流程模板的未完成流程实例迁移到新的版本2")
	@MParam(name="流程定义编码,流程初始数据",type="String, List")
	@MReturn(name="可能流转对象列表",type="List")
  public List getAvailableStartTransitions(  String pdid,  DataObject inputData) throws BizException ;
/**
 * 取得启动流程可能的流转路径
 * @param pdid(流程定义对象)
 * @return transitionsObj(可能流转对象(Transition)列表 )
 */
	@MMethod("将指定流程模板的未完成流程实例迁移到新的版本")
	@MParam(name="流程定义编码",type="String")
	@MReturn(name="可能流转对象列表",type="List")
public List getAvailableStartTransitions(String pdid)throws BizException;
/**
 * 获取指定版本流程的活动模板列表
 * @param ptid(流程模板编码)
 * @return activityTemplates(活动模板列表)
 */
	@MMethod("获取指定版本流程的活动模板列表")
	@MParam(name="流程模板编码",type="String")
	@MReturn(name="活动模板列表",type="List")
public List getActivityTemplatesByPTID(String ptid);
/**
 * 获取指定流程的活动模板列表
 * @param pdid(流程定义编码)
 * @return activityTemplates(活动模板列表)
 */
	@MMethod("获取指定流程的活动模板列表")
	@MParam(name="流程定义编码",type="String")
	@MReturn(name="活动模板列表",type="List")
public List getActivityTemplatesByPDID(String pdid);
/**
 * 根据流程定义编码获取最新版流程模板
 * @param pdid(流程定义编码)
 * @return prcessTemplate(流程模板对象)
 */
	@MMethod("根据流程定义编码获取最新版流程模板")
	@MParam(name="流程定义编码",type="String")
	@MReturn(name="流程模板对象",type="commonservice.processservice.processdefmgr.ProcessTemplate")
public DataObject getLatestProcessTemplateByDID(String pdid);
/**
 * 获取流程模板对象
 * @param ptid(流程模板编码)
 * @return processTemplate(流程模板对象)
 */
	@MMethod("获取流程模板对象")
	@MParam(name="流程模板编码",type="String")
	@MReturn(name="流程模板对象",type="commonservice.processservice.processdefmgr.ProcessTemplate")
public DataObject getProcessTemplateById(String ptid);
/**
 * 获取活动模板对象
 * @param atid(活动模板编码)
 * @return activityTemplate(活动模板对象)
 */
	@MMethod("获取活动模板对象")
	@MParam(name="活动模板编码",type="String")
	@MReturn(name="活动模板对象",type="commonservice.processservice.processdefmgr.ActivityTemplate")
public DataObject getActivityTemplateById(String atid);
  
	//获取可用的流转
	@MMethod("获取可用的流转")
	@MParam(name="流程定义编码,活动实例编码",type="String, String")
	@MReturn(name="可能流转对象列表",type="List")
public List getAvailableTransitions(String pdid, String aiid);

	//获取可用的执行人
	@MMethod("获取可用的执行人")
	@MParam(name="流程实例编码,流程模板编码,流程定义编码,目标活动定义编码",type="String, String, String, String")
public void outputPotentialOwners(String piid, String ptid, String pdid, String toActDid);

	//获取流程模板列表
	@MMethod("获取流程模板列表")
	@MParam(name="查询条件,排序条件",type="String,String")
	@MReturn(name="流程模板列表",type="List")
	public List getProcessTemplates(String filter, String orderBy);

}
