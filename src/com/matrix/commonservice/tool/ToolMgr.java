/*
 * file : UtilMgr.java
 * create by mbi at Fri Jan 09 14:44:32 CST 2009
 */
package com.matrix.commonservice.tool;

import com.matrix.annotation.MMethod;
import com.matrix.annotation.MParam;
import com.matrix.annotation.MReturn;
import com.matrix.app.api.BizException;
import commonj.sdo.DataObject;

public interface ToolMgr {

	/**
	 * 往application中添加属性
	 * @param key(属性关键字)
	 *
	 * @param o(属性对象)
	 *
	 */
	@MMethod("往application中添加属性")
	@MParam(name="属性关键字,属性对象",type="String, http://www.w3.org/2001/XMLSchema:anySimpleType")
	public void addApplicationAttribute(String key,Object o);
	

	/**
	 * 往session中添加属性
	 * @param key(属性关键字)
	 *
	 * @param o(属性对象)
	 *
	 */
	@MMethod("往session中添加属性")
	@MParam(name="属性关键字,属性对象",type="String, Object")
	public void addSessionAttribute(String key,Object o);

	/**
	 * 往request中添加一个属性
	 * @param key(属性关键字)
	 *
	 * @param o(属性对象)
	 *
	 */
	@MMethod("往request中添加属性")
	@MParam(name="属性关键字,属性对象",type="String, Object")
	public void addRequestAttribute(String key,Object o);

	/**
	 * 得到application中属性的值
	 * @param key(属性关键字)
	 *
	 * @return o(属性对象)
	 */
	@MMethod("得到application中属性的值")
	@MParam(name="属性关键字",type="String")
	@MReturn(name="属性对象",type="Object")
	public Object getApplicationAttribute(String key);

	/**
	 * 得到session中属性的值
	 * @param key(属性关键字)
	 *
	 * @return o(属性对象)
	 */
	@MMethod("得到session中属性的值")
	@MParam(name="属性关键字",type="String")
	@MReturn(name="属性对象",type="Object")
	public Object getSessionAttribute(String key);

	/**
	 * 得到request中属性的值
	 * @param key(属性关键字)
	 *
	 * @return o(属性对象)
	 */
	@MMethod("得到request中属性的值")
	@MParam(name="属性关键字",type="String")
	@MReturn(name="属性对象",type="Object")
	public Object getRequestAttribute(String key);

	/**
	 * 移除application中属性的值
	 * @param key(属性关键字)
	 *
	 */
	@MMethod("移除application中属性的值")
	@MParam(name="属性关键字",type="String")
	public void removeApplicationAttribute(String key);

	/**
	 * 流转页面
	 * @param url(页面连接)
	 *
	 */
	@MMethod("forward页面")
	@MParam(name="页面连接",type="String")
	public void forward(String url);

	/**
	 * 流转页面
	 * @param url(页面连接)
	 *
	 */
	@MMethod("redirect页面")
	@MParam(name="页面连接",type="String")
	public void redirect(String url);

	/**
	 * 移除session中属性的值
	 * @param key(属性关键字)
	 *
	 */
	@MMethod("移除session中属性的值")
	@MParam(name="属性关键字",type="String")
	public void removeSessionAttribute(String key);

	/**
	 * 移除request中属性的值
	 * @param key(属性关键字)
	 *
	 */
	@MMethod("移除request中属性的值")
	@MParam(name="属性关键字",type="String")
	public void removeRequestAttribute(String key);

	/**
	 * 创建DataObject对象
	 * @param entityName(实体名称)
	 *
	 * @return reDataObject(DataObject对象)
	 */
	@MMethod("创建DataObject对象")
	@MParam(name="实体名称",type="String")
	@MReturn(name="属性对象",type="DataObject")
	public DataObject createDataObject(String entityName);

	/**
	 * 往JSF的上下文中添加错误消息
	 * @param id(编码) : 绑定控件编码
	 * @param msg(错误信息)
	 */
	@MMethod("往上下文中添加错误消息")
	@MParam(name="错误信息",type="String")
	public void addErrorMessage(String msg);

	@MMethod("往上下文中添加警告消息")
	@MParam(name="警告信息",type="String")
	public void addWarnMessage(String msg);

	/**
	 * 往JSF的上下文中添加提示消息
	 * @param id(编码) : 绑定控件编码
	 * @param msg(提示信息)
	 */
	@MMethod("往上下文中添加提示消息")
	@MParam(name="提示信息",type="String")
	public void addInfoMessage(String msg);
	
	/**
	 * 复制一个DataObject对象
	 * @param fromObj:原对象
	 * @param toObj:目标对象
	 */
	@MMethod("复制一个DataObject对象")
	@MParam(name="原对象,目标对象",type="DataObject,DataObject")
	public void copyDataObject(DataObject fromObj, DataObject toObj)throws BizException;
	
	/**
	 * 将JSON字符串转换成DataObject对象
	 * @param entity:DataObject实体路径
	 * @param json:json字符串
	 */
	@MMethod("将JSON字符串转换成DataObject对象")
	@MParam(name="实体路径,json字符串",type="String,String")
	@MReturn(name="转换对象",type="DataObject")
	public DataObject converteJsonToDataObject(String entity,String json);
	
	/**
	 * 将DataObject对象转换成JSON字符串
	 * @param dataObject:转换对象
	 */
	@MMethod("将DataObject对象转换成JSON字符串")
	@MParam(name="转换对象",type="DataObject")
	@MReturn(name="json字符串",type="String")
	public String converteDataObjectToJson(DataObject dataObject);
	
	
	/**
	 * 异步调用输出结果数据
	 * @param dataObj:输出结果对象
	 */
	@MMethod("异步调用输出结果数据")
	@MParam(name="输出结果对象",type="Object")
	public void outputData(Object dataObj) throws Exception;
	
	//设置对象属性
	@MMethod("设置对象属性")
	@MParam(name="对象,属性名, 属性值",type="Object, String, Object")
	public void setDataProperty(Object data, String proName, Object value)throws BizException;
	
	//获取对象属性值
	@MMethod("获取对象属性值")
	@MParam(name="DaaObject对象,属性名",type="DataObject, String")
	@MReturn(name="属性值",type="Object")
	public Object getDataProperty(DataObject data, String proName);

	// 转换字符串内容中的el表达式
	@MMethod("转换字符串内容中的el表达式")
	@MParam(name="字符串内容",type="String")
	public String convertExpression(String content);

	// 转换接收到的异步请求数据
	@MMethod("转换接收到的异步请求数据")
	@MReturn(name="转换结果对象,格式为DataObject或者List",type="Object")
	public Object converteCustomAjaxData();
	
	// 将数据转换为Json格式并输出
	@MMethod("将数据转换为Json格式并输出")
	@MParam(name="输出数据,可以使String,DataObject List或者DataObject类型",type="Object")
	public void responseJsonData(Object dataObj);

	@MMethod("复制一个DataObject对象属性")
	@MParam(name="原对象,原对象属性,目标对象,目标对象属性",type="DataObject,String,DataObject,String")
	public void copyDataObjectProperty(DataObject fromObj, String fromPName, DataObject toObj, String toPName)throws BizException;

	
 }

