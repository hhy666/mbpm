package com.matrix.commonservice.data;

/**
 * 数据访问实现
 * @author msg
 * 日期:2008-11-07
 */

import java.io.Serializable;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.matrix.annotation.MMethod;
import com.matrix.annotation.MParam;
import com.matrix.annotation.MReturn;
import com.matrix.app.api.Page;
import com.matrix.dasservice.DASAgent;
import com.matrix.dasservice.DASException;
import com.matrix.dasservice.DASHelper;
import com.matrix.dasservice.DASService;
import com.matrix.form.api.MFormContext;
import com.matrix.form.model.config.FormContentHelper;
import commonj.sdo.DataObject;

@SuppressWarnings("unchecked")
public class DataServiceImpl implements DataService {
	
	private DASService getDASService(DataObject obj){
 		String formType = MFormContext.getFormProperties().getType();
		if(!"platform".equalsIgnoreCase(formType)){ //如果不是在平台中,直接用表单服务
			return getDASService();
		}
		String entityname=DASHelper.getEntityName(obj);
		return getDASServiceByEntityName2(entityname);
	}
	
	private DASService getDASService(String hql){
 		String formType = MFormContext.getFormProperties().getType();
		if(!"platform".equalsIgnoreCase(formType)){ //如果不是在平台中,直接用表单服务
			return getDASService();
		}
		String entityname=DASHelper.getEntityName(hql);
		return getDASServiceByEntityName2(entityname);
	}
	
	private DASService getDASServiceByEntityName(String entityName){
		String formType = MFormContext.getFormProperties().getType();
		if(!"platform".equalsIgnoreCase(formType)){ //如果不是在平台中,直接用表单服务
			return getDASService();
		}
		
		boolean isFormEntity = true;
		if(!(MFormContext.getFormProperties().getEntityAndDSNameMap().containsKey(entityName)))
			isFormEntity = false;
		DASService service = null;
		if(isFormEntity)
			service = DASAgent.getFormDASService();
		else
			service = DASAgent.getDASService();
		return service;
	}

	//内部调用,已经判断过是否为平台类型了
	private DASService getDASServiceByEntityName2(String entityName){
		
		boolean isFormEntity = true;
		if(!(MFormContext.getFormProperties().getEntityAndDSNameMap().containsKey(entityName)))
			isFormEntity = false;
		DASService service = null;
		if(isFormEntity)
			service = DASAgent.getFormDASService();
		else
			service = DASAgent.getDASService();
		return service;
	}
	
	private DASService getDASService(){
		DASService service = DASAgent.getFormDASService();
		return service;
	}

	
	/**
	 * 保存
	 * 
	 * @param o --
	 *            对象
	 */
	@MMethod("保存")
	@MParam(name="任意类型的对象",type="Object")
	public void save(Object o) {
		getDASService((DataObject)o).save(o);
	}

	/**
	 * 批量保存
	 */
	@MMethod("批量保存")
	@MParam(name="list类型的dataObject",type="List")
	public void saveBatch(List list) {
		if(list == null || list.size()==0)
			return;
		
		getDASService((DataObject)list.get(0)).saveBatch(list);
	}

	/**
	 * 更新
	 */
	@MMethod("更新")
	@MParam(name="任意类型的对象",type="Object")
	public void update(Object o) {
		getDASService((DataObject)o).update(o);
	}

	/**
	 * 保存或更新
	 */
	@MMethod("保存或更新")
	@MParam(name="任意对象",type="Object")
	public void saveOrUpdate(Object o) {
		getDASService((DataObject)o).saveOrUpdate(o);
	}

	/**
	 * 批量保存或更新
	 */
	@MMethod("批量保存或更新")
	@MParam(name="DataObject对象列表",type="List")
	public void saveOrUpdateBatch(List list) {
		if(list == null || list.size() == 0)
			return;

		DASService service = getDASService((DataObject)list.get(0));
		for (Iterator it = list.iterator(); it.hasNext();) {
			Object o = it.next();
			service.saveOrUpdate(o);
		}
	}

	/**
	 * 批量更新对象
	 */
	@MMethod("批量更新对象")
	@MParam(name="DataObject对象列表",type="List")
	public void updateBatch(List list) {
		if(list == null || list.size() == 0)
			return;

		getDASService((DataObject)list.get(0)).updateBatch(list);
	}

	/**
	 * 删除对象
	 */
	@MMethod("删除对象")
	@MParam(name="任意类型对象",type="Object")
	public void delete(Object o) {
		if(o == null)
			return;
		
		getDASService((DataObject)o).delete(o);
	}

	/**
	 * 批量删除对象
	 */
	@MMethod("批量删除对象")
	@MParam(name="DataObject对象列表",type="List")
	public void deleteBatch(List list) {
		if(list == null || list.size() == 0)
			return;

			DASService service = getDASService((DataObject)list.get(0));
			for (Iterator it = list.iterator(); it.hasNext();) {
				Object o = it.next();
				try{
					service.delete(o);
				}catch(Exception e){
					e.printStackTrace();
				}
			}
	}

	/**
	 * 以startIndex为开始索引查询maxResults个对象
	 */
	@MMethod("以startIndex为开始索引查询maxResults个对象")
	@MParam(name="查询脚本,查询参数值列表,开始行数,每页行数",type="String,Object,int,int")
	@MReturn(name="结果对象列表",type="List")
	public List queryList2(String hql, Object params, int startIndex, int maxResults) {
		hql = FormContentHelper.convertExpression(hql);
		return getDASService(hql).executeQuery(hql, params, startIndex, maxResults);
	}

	/**
	 * 执行sql查询对象
	 */
	@MMethod("执行sql查询对象")
	@MParam(name="sql查询语句,参数数组,数据源名称",type="String,Object,String")
	@MReturn(name="结果对象列表",type="List")
	public List querySqlList(String sql, Object params,	String dataSourceName) {
		sql = FormContentHelper.convertExpression(sql);
		return getDASService().querySQLList(sql, (Object[])params, dataSourceName);
	}

	/**
	 * 查询分析功能的结果
	 */
	@MMethod("查询分析功能的结果")
	@MParam(name="hql查询语句,参数数组",type="String,Object")
	@MReturn(name="结果值",type="Object")
	public Object queryValue(String hql, Object params) {
		hql = FormContentHelper.convertExpression(hql);
		return getDASService(hql).queryValue(hql, params);
	}

	/**
	 * 执行刷新
	 */
	@MMethod("执行hql修改")
	@MParam(name="修改语句,查询参数",type="String,Object")
	@MReturn(name="返回更新对象的个数",type="int")
	public int executeUpdate(String hql, Object params) {
		hql = FormContentHelper.convertExpression(hql);
		int count=getDASService(hql).executeUpdate(hql, params);
		return count;
	}

	@MMethod("执行sql")
	@MParam(name="sql语句,参数,数据源名称",type="String,Object,String")
	public void executeSql(String sql, Object params, String dataSourceName) {
		sql = FormContentHelper.convertExpression(sql);
		getDASService().executeSQL(sql, (Object[])params, dataSourceName);
	}

	@MMethod("执行hql")
	@MParam(name="执行hql语句,参数数组",type="String,Object")
	@MReturn(name="返回删除对象的个数",type="int")
	public int executeDelete(String hql, Object params) {
		hql = FormContentHelper.convertExpression(hql);
		int count=getDASService(hql).executeDelete(hql, params);
		return count;
	}

	/**
	 * 从session中删除一个对象
	 */
	@MMethod("从session中删除一个对象")
	@MParam(name="任意类型对象",type="Object")
	public void detach(Object o) {
		getDASService((DataObject)o).detach(o);
	}

	/**
	 * 提交session
	 */
	@MMethod("提交session")
	@MParam(name="实例对应的类路径名称",type="String")
	public void flush(String entityname) {
		getDASServiceByEntityName(entityname).flush(entityname);
	}

	/**
	 *刷新对象
	 */
	@MMethod("刷新对象")
	@MParam(name="已有的持久化对象",type="Object")
	@MReturn(name="DataObject类型的一个对象",type="Object")
	public Object refresh(Object oldData){
		getDASService((DataObject)oldData).refresh(oldData);
		return oldData;
	}

	/**
	 * 加载一个对象
	 * @param entityname(实体全路径名称)
	 *
	 * @param id(主键)
	 *
	 * @return resultEntity(加载对象)
	 */
	@MMethod("加载一个对象")
	@MParam(name="实例对应的类路径名称,实例在数据库中的标识",type="String,Object")
	@MReturn(name="DataObject类型的一个对象",type="DataObject")
	public DataObject load(String entityname,Object id) {
		System.out.println(id+"=============================== the entityname is:"+entityname);
		if(entityname==null || entityname.trim().length()==0){
			throw new DASException("invalide entityname, can not be null");
		}
		return (DataObject) getDASServiceByEntityName(entityname).load((Serializable) id, entityname);
	}

	/**
	 * 批量级联删除
	 * @param d(删除对象)
	 *
	 */
	@MMethod("批量级联删除")
	@MParam(name="list类型的DataObject",type="List")
	public void deleteCascadeBatch(List list){
		if(list == null || list.size()==0)
			return;

		DASService service = getDASService((DataObject)list.get(0));
		for (Iterator it = list.iterator(); it.hasNext();) {
			Object o = it.next();
			service.refresh(o);
			service.delete(o);
		}
	}

	/**
	 * 合并更新
	 * @param o(合并对象)
	 *
	 */
	@MMethod("合并更新")
	@MParam(name="处于脱管状态的任意对象",type="Object")
	public void merge(Object o){
		
		getDASService((DataObject)o).merge(o);
	}

	/**
	 * 查询唯一的对象
	 * @param hql(查询脚本)
	 *
	 * @param params(查询对象)
	 *
	 * @return resultData(查询结果)
	 */
	@MMethod("查询唯一的对象")
	@MParam(name="字符串类型的hibernate查询语句,参数",type="String,Object")
	@MReturn(name="结果对象",type="Object")
	public Object queryObject(String hql,Object params) {
		hql = FormContentHelper.convertExpression(hql);
		return getDASService(hql).queryObject(hql, params);
	}

	/**
	 * 修改数据表格
	 * @param saveOrUpdateObs(添加或修改对象列表)
	 * @param deleteObs(删除对象列表)
	 */
	@MMethod("修改数据列表")
	@MParam(name="新增和修改列表,删除列表",type="List,List")
	public void updateDataList(List saveOrUpdateObs,List deleteObs){
		saveOrUpdateBatch(saveOrUpdateObs);
		deleteBatch(deleteObs);
	}

	/**
	 * @param hql(字符串类型的hibernate查询语句,String)
	 * @param params(DataObject类型的对象列表,集合)
	 * @return resultData(list类型的DataObject,集合)
	 */
	@MMethod("查询对象集合")
	@MParam(name="字符串类型的hibernate查询语句,DataObject类型的对象列表",type="String,Object")
	@MReturn(name="list类型的DataObject",type="List")
	public List queryList(String hql,Object params) {
		hql = FormContentHelper.convertExpression(hql);
		List data = getDASService(hql).executeQuery(hql, params);
		return data;
	}

	@MMethod("执行分页查询")
	@MParam(name="字符串类型的hibernate查询语句,查询参数绑定到运行时实参,指定输出结果在整个结果集中的起始索引,指定输出结果的最大个数",type="String,Object,int,int")
	@MReturn(name="结果Page",type="Page")
	public Page queryPage(String hql, Object params, int startIndex,int maxResults) {
		hql = FormContentHelper.convertExpression(hql);
		
		return getDASService(hql).executeQueryPage(hql, params, startIndex, maxResults);
	}
	
	public Object querySqlValue(String sql, Object params, String sourceName){
		sql = FormContentHelper.convertExpression(sql);
		return getDASService().querySQLValue(sql, (Object[])params, sourceName);
	}
	
	
}