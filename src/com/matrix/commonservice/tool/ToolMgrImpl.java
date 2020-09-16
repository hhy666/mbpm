/*
 * file : UtilImpl.java
 * create by mbi at Fri Jan 09 14:44:32 CST 2009
 */
package com.matrix.commonservice.tool;


import java.io.IOException;
import java.io.InputStream;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.matrix.faces.MFacesException;
import javax.matrix.faces.application.MFacesMessage;
import javax.matrix.faces.context.MExternalContext;
import javax.matrix.faces.context.MFacesContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.matrix.annotation.MMethod;
import com.matrix.annotation.MParam;
import com.matrix.annotation.MReturn;
import com.matrix.app.api.BizException;
import com.matrix.extention.SessionContextHolder;
import com.matrix.form.api.MDebugger;
import com.matrix.form.engine.PageFlowEngine;
import com.matrix.form.model.config.FormContentHelper;
import com.matrix.form.render.util.SdoJsonConverter;
import com.matrix.form.util.DataObjectHelper;
import commonj.sdo.DataObject;
import commonj.sdo.Property;
import commonj.sdo.Type;
import commonj.sdo.impl.HelperProvider2;

public class ToolMgrImpl  implements  ToolMgr{

	/**
	 * 往application中添加属性
	 * @param key(属性关键字)
	 *
	 * @param o(属性对象)
	 *
	 */
	@MMethod("往application中添加属性")
	@MParam(name="属性关键字,属性对象",type="String, http://www.w3.org/2001/XMLSchema:anySimpleType")
	public void addApplicationAttribute(String key,Object o){
		MFacesContext.getCurrentInstance().getExternalContext().getApplicationMap().put(key, o);
	}

	/**
	 * 往session中添加属性
	 * @param key(属性关键字)
	 *
	 * @param o(属性对象)
	 *
	 */
	@MMethod("往session中添加属性")
	@MParam(name="属性关键字,属性对象",type="String, Object")
	public void addSessionAttribute(String key,Object o){
//		MFacesContext.getCurrentInstance().getExternalContext().getSessionMap().put(key, o);
		SessionContextHolder.getSession().setAttribute(key, o);
	}

	/**
	 * 往request中添加一个属性
	 * @param key(属性关键字)
	 *
	 * @param o(属性对象)
	 *
	 */
	@MMethod("往request中添加属性")
	@MParam(name="属性关键字,属性对象",type="String, Object")
	public void addRequestAttribute(String key,Object o){
//		MFacesContext.getCurrentInstance().getExternalContext().getRequestMap().put(key, o);
		SessionContextHolder.getRequest().setAttribute(key, o);
	}

	/**
	 * 得到application中属性的值
	 * @param key(属性关键字)
	 *
	 * @return o(属性对象)
	 */
	@MMethod("得到application中属性的值")
	@MParam(name="属性关键字",type="String")
	@MReturn(name="属性对象",type="Object")
	public Object getApplicationAttribute(String key){
		 return MFacesContext.getCurrentInstance().getExternalContext().getApplicationMap().get(key);
	}

	/**
	 * 得到session中属性的值
	 * @param key(属性关键字)
	 *
	 * @return o(属性对象)
	 */
	@MMethod("得到session中属性的值")
	@MParam(name="属性关键字",type="String")
	@MReturn(name="属性对象",type="Object")
	public Object getSessionAttribute(String key){
//		if(MFacesContext.getCurrentInstance() == null)
//			return null;
//		 return MFacesContext.getCurrentInstance().getExternalContext().getSessionMap().get(key);
		return SessionContextHolder.getSession().getAttribute(key);
	}

	@MMethod("forward页面")
	@MParam(name="页面连接",type="String")
	public void forward(String url){
		if(url == null || url.trim().length()==0)
			return;
		
		PageFlowEngine flowEngine = new PageFlowEngine();
		try {
			url = flowEngine.convertParameters(url);
		} catch (BizException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		HttpServletRequest request = (HttpServletRequest)MFacesContext.getCurrentInstance().getExternalContext().getRequest();
		HttpServletResponse response = (HttpServletResponse)MFacesContext.getCurrentInstance().getExternalContext().getResponse();
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(url);
	        
	        try {
	    		if (requestDispatcher == null) {
	                response.sendError(HttpServletResponse.SC_NOT_FOUND);
	                return;
	            }
	    		
	            requestDispatcher.forward(request, response);
	        } catch (Exception se) {
	            throw new MFacesException(se);
	        }
	}
	
	@MMethod("redirect页面")
	@MParam(name="页面连接",type="String")
	 public void redirect(String requestURI)  {
			HttpServletRequest request = (HttpServletRequest)MFacesContext.getCurrentInstance().getExternalContext().getRequest();
			HttpServletResponse response = (HttpServletResponse)MFacesContext.getCurrentInstance().getExternalContext().getResponse();
	        try {
				((HttpServletResponse) response).sendRedirect(requestURI);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        MFacesContext.getCurrentInstance().responseComplete();
	 }
	 

	/**
	 * 得到request中属性的值
	 * @param key(属性关键字)
	 *
	 * @return o(属性对象)
	 */
		@MMethod("得到request中属性的值")
		@MParam(name="属性关键字",type="String")
		@MReturn(name="属性对象",type="Object")
	public Object getRequestAttribute(String key){
//		 return MFacesContext.getCurrentInstance().getExternalContext().getRequestMap().get(key);
		 return SessionContextHolder.getRequest().getAttribute(key);
	}

	/**
	 * 移除application中属性的值
	 * @param key(属性关键字)
	 *
	 */
		@MMethod("移除application中属性的值")
		@MParam(name="属性关键字",type="String")
	public void removeApplicationAttribute(String key){
		MFacesContext.getCurrentInstance().getExternalContext().getApplicationMap().remove(key);
	}

	/**
	 * 移除session中属性的值
	 * @param key(属性关键字)
	 *
	 */
		@MMethod("移除session中属性的值")
		@MParam(name="属性关键字",type="String")
	public void removeSessionAttribute(String key){
//		MFacesContext.getCurrentInstance().getExternalContext().getSessionMap().remove(key);
		SessionContextHolder.getSession().removeAttribute(key);
	}

	/**
	 * 移除request中属性的值
	 * @param key(属性关键字)
	 *
	 */
		@MMethod("移除request中属性的值")
		@MParam(name="属性关键字",type="String")
	public void removeRequestAttribute(String key){
//		MFacesContext.getCurrentInstance().getExternalContext().getRequestMap().remove(key);
		SessionContextHolder.getRequest().removeAttribute(key);
	}

	/**
	 * 创建DataObject对象
	 * @param entityName(实体名称)
	 *
	 * @return reDataObject(DataObject对象)
	 */
		@MMethod("创建DataObject对象")
		@MParam(name="实体名称",type="String")
		@MReturn(name="属性对象",type="DataObject")
	public DataObject createDataObject(String entityName){
		if(entityName == null)
			return null;
		
	    String path=entityName.replaceAll("\\.", "/");
	    String uri="http://"+path.substring(0,path.lastIndexOf("/"));

	    //构造对应xsd文件path
//	    MFormContext.getFormProperties().get
//		String srcPrefix = MFormProperty.getInstance().getBasicProperty().getSrcPrefix();
	    String srcPrefix = null;
		if(srcPrefix != null && srcPrefix.trim().length()>0){
			if(! (entityName.startsWith("com.matrix.form.model/")
					|| entityName.startsWith("com.matrix.commonservice/")
			  || entityName.startsWith("commonservice.")
					|| entityName.startsWith("foundation.")
					|| entityName.startsWith("shareliberaries.") )){ //无前缀的通用服务
				srcPrefix = srcPrefix.replaceAll("/", ".");
				entityName = srcPrefix + "." + entityName;
			}
		}
		
		path=entityName.replaceAll("\\.", "/");
	    String xsdFile = path+ ".xsd";
	    String entityType=path.substring(path.lastIndexOf("/")+1);
	    Type type = HelperProvider2.getTypeHelper().getType(uri, entityType);
	    
	    if (type == null){
			InputStream in = getClass().getClassLoader().getResourceAsStream(xsdFile);
			defineType(in);
	    }   
	   
	    // 创建和新建对象定义的对象
	    DataObject data = 
	    	HelperProvider2.getDefaultContext().getDataFactory().create(uri, entityType);
	    return data;        
	}
	
    //有多线程并发问题,采用 synchronize 处理
    public synchronized List defineType(InputStream ins){ 
    	List types = HelperProvider2.getDefaultContext().getXSDHelper().define(ins, null);
    	return types;
   	}

	/**
	 * 往执行的上下文中添加错误消息
	 * @param msg(错误信息)
	 */
	@MMethod("往上下文中添加错误消息")
	@MParam(name="错误信息",type="String")
	public void addErrorMessage(String msg){
		MFacesMessage fm = new MFacesMessage();
		fm.setSeverity(MFacesMessage.SEVERITY_ERROR);
		fm.setSummary(msg);
		fm.setDetail(msg);
		MFacesContext.getCurrentInstance().addMessage("com", fm);
	}

	/**
	 * 往执行的上下文中添加警告消息
	 * @param msg(警告信息)
	 */
	@MMethod("往上下文中添加警告消息")
	@MParam(name="警告信息",type="String")
	public void addWarnMessage(String msg){
		MFacesMessage fm = new MFacesMessage();
		fm.setSeverity(MFacesMessage.SEVERITY_WARN);
		fm.setSummary(msg);
		fm.setDetail(msg);
		MFacesContext.getCurrentInstance().addMessage("com", fm);
	}

	/**
	 * 往执行的上下文中添加提示消息
	 * @param id(编码) : 绑定控件编码
	 * @param msg(提示信息)
	 */
	@MMethod("往上下文中添加提示消息")
	@MParam(name="提示信息",type="String")
	public void addInfoMessage(String msg){
		MFacesMessage fm = new MFacesMessage();
		
		fm.setSeverity(MFacesMessage.SEVERITY_INFO);
		fm.setSummary(msg);
		fm.setDetail(msg);
		
		MFacesContext.getCurrentInstance().addMessage("com", fm);
	}
	
	/**
	 * 复制一个DataObject对象
	 * @param fromObj:原对象
	 * @param toObj:目标对象
	 */
	@MMethod("复制一个DataObject对象")
	@MParam(name="原对象,目标对象",type="DataObject,DataObject")
	public void copyDataObject(DataObject fromObj, DataObject toObj)throws BizException{
		try{
		    List properties = fromObj.getType().getProperties();
		    for (Iterator iter = properties.iterator(); iter.hasNext();) {
		    	Property property = (Property)iter.next();
		    	if ((toObj.getType().getProperty(property.getName()) == null) 
		    		  || (property.isContainment()))
		    		continue;
		    	toObj.set(property.getName(), fromObj.get(property.getName()));
		    }
	    }catch(Exception e){
	    	throw new BizException(101);
	    }
	  }

	/**
	 * 复制一个DataObject对象属性
	 * @param fromObj:原对象
	 * @param toObj:目标对象
	 */
	@MMethod("复制一个DataObject对象属性")
	@MParam(name="原对象,原对象属性,目标对象,目标对象属性",type="DataObject,String,DataObject,String")
	public void copyDataObjectProperty(DataObject fromObj, String fromPName, DataObject toObj, String toPName)throws BizException{
		try{
		    Property fromProperty = fromObj.getType().getProperty(fromPName);
		    Property toProperty = toObj.getType().getProperty(toPName);
		    
		    if(fromProperty != null && toProperty != null){
		    	toObj.set(toProperty, fromObj.get(fromProperty));
		    }
		    
	    }catch(Exception e){
	    	throw new BizException(101);
	    }
	  }

	//设置对象属性
	@MMethod("设置对象属性")
	@MParam(name="对象,属性名, 属性值",type="Object, String, Object")
	public void setDataProperty(Object data, String proName, Object value)throws BizException{
		if(MDebugger.isLogEnable()){
			MDebugger.debug("set Object property, proName#"+proName+",value#"+value);
		}
		if(data == null || proName == null)
			return;
		if(data instanceof List){
			List list = (List)data;
			for(Iterator it=list.iterator();it.hasNext();){
				Object o = it.next();
				if(o instanceof DataObject){
					DataObject obj = (DataObject)o;
					if(obj.getType().getProperty(proName) == null)
						continue;
					obj.set(proName, value);
				}
			}
		}else if(data instanceof DataObject){
			DataObject obj = (DataObject)data;
			if(obj.getType().getProperty(proName) == null)
				return;
			obj.set(proName, value);
		}
		
	}
	
	//获取对象属性值
	@MMethod("获取对象属性值")
	@MParam(name="DaaObject对象,属性名",type="DataObject, String")
	@MReturn(name="属性值",type="Object")
	public Object getDataProperty(DataObject data, String proName){
		if(MDebugger.isLogEnable()){
			MDebugger.debug("get DataObject property, proName#"+proName);
		}
		
		Object value = null;
		if(data != null && proName != null){
			value = data.get(proName);
			if(MDebugger.isLogEnable()){
				MDebugger.debug("return value#"+value);
			}
		}

		return value;
	}

	/**
	 * 将JSON字符串转换成DataObject对象
	 * @param entity:DataObject实体路径
	 * @param json:json字符串
	 */
	@MMethod("将JSON字符串转换成DataObject对象")
	@MParam(name="实体路径,json字符串",type="String,String")
	@MReturn(name="转换对象",type="DataObject")
	public DataObject converteJsonToDataObject(String entity,String json){
		if(entity!=null && entity.trim().length()>0
			&& json!=null && json.trim().length()>0){
			JSONObject jsonObj = JSONObject.fromObject(json);
			DataObject dataObject = this.createDataObject(entity);
			List<Property> properties = dataObject.getType().getProperties();
			for (Property property : properties) {
				if(!property.getType().isDataType())  //非基本类型,继续后续处理
					continue;
				String propertyName = property.getName();
				if(jsonObj.has(propertyName)){
					dataObject.set(propertyName, SdoJsonConverter.convertDataObjectValue(property,jsonObj.get(propertyName)));
				}
			}
			return dataObject;
		}
		return null;
	}
	
	/**
	 * 将DataObject对象转换成JSON字符串
	 * @param dataObject:转换对象
	 */
	@MMethod("将DataObject对象转换成JSON字符串")
	@MParam(name="转换对象",type="DataObject")
	@MReturn(name="json字符串",type="String")
	public String converteDataObjectToJson(DataObject dataObject){
		if(dataObject!=null){
			return SdoJsonConverter.convertDataObjectToJsonString((DataObject)dataObject);
		}
		return null;
	}
	
	@MMethod("异步调用输出结果数据")
	@MParam(name="输出结果对象",type="Object")
	public void outputData(Object dataObj) throws Exception{
//		throw new BizException("101");
//		
		String resultStr = null;
		if(dataObj instanceof String)
			resultStr = (String)dataObj;
		else if(dataObj instanceof List){
			resultStr = SdoJsonConverter.convertListToJsonString((List)dataObj);
		}else if(dataObj instanceof Object){
			resultStr = SdoJsonConverter.convertDataObjectToJsonString((DataObject)dataObj);
		}
		
		if(resultStr!=null){
	        try{
				MFacesContext context = MFacesContext.getCurrentInstance();
	        	HttpServletRequest request = (HttpServletRequest)context.getExternalContext().getRequest();
	        	HttpServletResponse response = (HttpServletResponse)context.getExternalContext().getResponse();
	        	response.setCharacterEncoding(request.getCharacterEncoding());
				Writer writer = response.getWriter();
				writer.write(dataObj.toString());
				writer.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}

	}
	
	public Object converteCustomAjaxData() {
		MExternalContext context = MFacesContext.getCurrentInstance().getExternalContext();
		ServletRequest request = (ServletRequest)context.getRequest();
		ServletResponse response = (ServletResponse)context.getResponse();
		
		// 判断是否转换成list形式
		boolean isList = false;
		List dataList = null;
		String listKey = request.getParameter(CUSTOMAJAXDATALISTKEY);
		if(listKey!=null && listKey.trim().length()>0){
			isList = true;
			dataList = new ArrayList();
		}
		
		// 解析转换每个DataObject对象
		String[] datas = (String[])request.getParameterMap().get(CUSTOMAJAXDATAKEY);
		if(datas!=null && datas.length>0){
			for(int i=0;i<datas.length;i++){
				String dataInfo = datas[i];
				if(dataInfo!=null && dataInfo.trim().length()>0){
					JSONObject json = JSONObject.fromObject(dataInfo);
					if(json.has("entity") && json.has("data")){
						String entity = json.getString("entity");
						String dataStr = json.getString("data");
						JSONObject jsonData = JSONObject.fromObject(dataStr);
						
						// 构造空的DataObject对象
						DataObject dataObject = DataObjectHelper.getDataObjectOfEntity(entity);
						// 赋值DataObject对象属性
						List<Property> properties = dataObject.getType().getProperties();
						for (Property property : properties) {
//							if(!property.getType().isDataType())  //非基本类型,继续后续处理
//								continue;
							String propertyName = property.getName();
							if(jsonData.has(propertyName)){
//								dataObject.set(propertyName, SdoJsonConverter.convertDataObjectValue(property,jsonData.get(propertyName)));
								Object value = jsonData.get(propertyName);
								if(value!=null && (value instanceof JSONArray)){
									StringBuffer valueSB = new StringBuffer();
									for(int j =0;j<((JSONArray)value).size();j++){
										if(((JSONArray)value).getString(j)!=null){
											if(j!=0){
												valueSB.append(",");
											}
											valueSB.append(((JSONArray)value).getString(j));
										}
									}
									value = valueSB.toString();
								}
								dataObject.set(propertyName, SdoJsonConverter.convertDataObjectValue(property,value));
							}
						}
						
						if(isList){
							// 集合形式数据将DataObject数据放入集合中
							dataList.add(dataObject);
						}else{
							// 将单独的DataObject对象放入request中
//							if(json.has("key")){
//								String key = json.getString("key");
//								if(key!=null && key.trim().length()>0){
//									request.setAttribute(key, dataObject);
//								}
//							}
							return dataObject;
						}
					}
				}
			}
		}
		
//		// 将集合数据放入request中
//		if(isList){
//			request.setAttribute(listKey, dataList);
//		}
		return dataList;
		
	}
	
	public void responseJsonData(Object dataObj){
		MExternalContext context = MFacesContext.getCurrentInstance().getExternalContext();
		ServletRequest request = (ServletRequest)context.getRequest();
		ServletResponse response = (ServletResponse)context.getResponse();
		String resultStr = null;
		if(dataObj instanceof String)
			resultStr = (String)dataObj;
		else if(dataObj instanceof List){
			resultStr = SdoJsonConverter.convertListToJsonString((List)dataObj);
		}else if(dataObj instanceof Object){
			resultStr = SdoJsonConverter.convertDataObjectToJsonString((DataObject)dataObj);
		}
		
		if(resultStr!=null){
	        try{
	        	response.setCharacterEncoding(request.getCharacterEncoding());
				Writer writer = response.getWriter();
				writer.write(dataObj.toString());
				writer.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	private static String CUSTOMAJAXDATAKEY = "custom_ajax_data"; //提交转换DataObject数据标识
	private static String CUSTOMAJAXDATALISTKEY = "custom_ajax_data_list_key"; //转换成DataObject数据集合标识

	
	
	// 转换字符串内容中的el表达式
	@MMethod("转换字符串内容中的el表达式")
	@MParam(name="字符串内容",type="String")
	public String convertExpression(String content) {
		return FormContentHelper.convertExpression(content);
	}

   }

