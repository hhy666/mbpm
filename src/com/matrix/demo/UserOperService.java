package com.matrix.demo;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.matrix.faces.context.MFacesContext;
import javax.servlet.http.HttpServletResponse;

import com.matrix.app.api.SysException;
import com.matrix.commonservice.data.DataService;
import com.matrix.form.admin.common.utils.CommonUtil;
import com.matrix.form.api.MFormContext;
import com.matrix.form.util.DataObjectHelper;


import commonj.sdo.DataObject;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class UserOperService {
	/**
	 * 保存用户和用户详情
	 */
	public void saveUserAndDetail() throws Exception {
		DataService dataService = MFormContext.getService("DataService");
		// 先保存用户
		DataObject user = (DataObject) MFormContext.getRequestAttribute("user");
		
		try {
			dataService.saveOrUpdate(user);
		} catch (Exception e) {
			System.out.println("用户主表信息保存失败 ！ " + e);
			throw e;
		}
	
		// 判断 user 的id 是否为null 不为空保存 用户详细信息
		String uid = user.getString("id");
		
		// 再保存用户详细信息
		DataObject userDetail = (DataObject) MFormContext.getRequestAttribute("userDetail");
		
		if(uid != null && !uid.equals("") 
				&& (userDetail.getString("id") == null || userDetail.getString("id").equals(""))) {
			//设置外键fid
			userDetail.set("fid", Integer.parseInt(uid));
		}
		
		try {
			dataService.saveOrUpdate(userDetail);
		} catch (Exception e) {
			System.out.println("用户从表信息保存失败 ！ " + e);
			throw e;
		}
	}
	
	/**
	 * 	批量删除用户和用户详情信息		
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void deleteBatchUserAndDetail(List list) throws Exception {
		// 获取数据服务
		DataService dataService = MFormContext.getService("DataService");
		
		List userDetailList = new ArrayList<DataObject>();
		List userlList = new ArrayList<DataObject>();
		
		// 组织id字符数组
//		StringBuffer ids = new StringBuffer();
		
		for (int i = 0; i < list.size(); i++) {
			DataObject dataObject = (DataObject) list.get(i);
			// 用户对象
			DataObject user = com.matrix.form.util.DataObjectHelper.getDataObjectOfEntity("userMsg.userDetailMsg.tuser");
			
			user.set("id", dataObject.getInt("id"));
			
			userlList.add(user);
			
			// 用户详情对象
			DataObject userDetail = com.matrix.form.util.DataObjectHelper.getDataObjectOfEntity("userMsg.userDetailMsg.tuserDetail");
			
			userDetail.set("id", dataObject.getInt("detailId"));
			
			userDetailList.add(userDetail);
			
//			ids.append(",").append(dataObject.getString("id"));
		}
		
		dataService.deleteBatch(userDetailList);
		dataService.deleteBatch(userlList);
		
		// sql
//		String udhql = "delete from m_t_user_detail where M_T_FID in ("+ids.toString().substring(1)+")";
//		// 执行删除并返回
//		try {
//			dataService.executeSql(udhql, null, "mbpm");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			throw e;
//		}
//		
//		// 然后删除用户表
//		// sql
//		String uhql = "delete from m_t_user where M_T_ID in ("+ids.toString().substring(1)+")";
//		// 执行删除并返回
//		try {
//			dataService.executeSql(uhql, null, "mbpm");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			throw e;
//		}
	}
	
	/**
	 * 返回所有字段值下拉列表
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes" })
	public String selectAllAttrValue() throws Exception{
		// 获取数据服务
		DataService dataService = MFormContext.getService("DataService");
		
		String sql = "select M_T_ID, concat(M_T_ID,'-',M_T_ALIAS,'-',M_T_PSWD) from m_t_user";
		
		List list = dataService.querySqlList(sql, null, "mbpm");
		
		JSONArray ja = new JSONArray();
//		List res = new ArrayList<DataObject>();
//		List ddd = (List) MFormContext.getRequestAttribute("selectOptions");
		
		for (int i = 0; i < list.size(); i++) {
//			DataObject dataObject = DataObjectHelper.getDataObjectOfEntity("userMsg.userDetailMsg.AllAttrValue");
			
			Object[] listi = (Object[]) list.get(i);
			
//			dataObject.set("value", listi[0].toString());
//			dataObject.set("text", listi[1].toString());
			
//			res.add(dataObject);
			
			JSONObject jo = new JSONObject();
			
			jo.put("id", listi[0].toString());
			jo.put("text", listi[1].toString());
			
			ja.add(jo);
		}
		
//		MFormContext.setRequestAttribute("selectOptions", res);
//		ddd = (List) MFormContext.getRequestAttribute("selectOptions");
		
//		ToolMgr toolMgr = MFormContext.getService("ToolMgr");
		
//		toolMgr.responseJsonData(res);
		
		MFacesContext context = MFacesContext.getCurrentInstance();
    	HttpServletResponse response = (HttpServletResponse)context.getExternalContext().getResponse();
		
    	PrintWriter pw = response.getWriter();
    	
    	pw.append(ja.toString());
//    	pw.flush();
    	
		return null;
	}
	
	@SuppressWarnings({ "unchecked" })
	public String findAddressSelect() throws Exception {
		// 获取other1的值
		Integer other1 = Integer.parseInt(MFormContext.getParameter("other1").toString());
		// 获取数据服务
		DataService dataService = MFormContext.getService("DataService");
		// 查询sql
//		String sql = "select M_T_ID,concat(M_T_SEX,'-',M_T_AGE) FROM m_t_user_detail WHERE M_T_FID="+other1;

//		List res = dataService.querySqlList(sql, null, "mbpm");
		
		String hql = "from userMsg.userDetailMsg.tuserDetail td  where td.fid=?";
		
		List<DataObject> res = dataService.queryList(hql, new Object[] {other1});
		
		JSONArray ja = new JSONArray();

		for (int i = 0; i < res.size(); i++) {
			DataObject listi = (DataObject) res.get(i);

			JSONObject jo = new JSONObject();
			
			jo.put("id", listi.getInt("id"));
			jo.put("text", listi.getString("address").concat('_'+listi.getString("sex")));
			
			ja.add(jo);
		}
		
		MFacesContext context = MFacesContext.getCurrentInstance();
    	HttpServletResponse response = (HttpServletResponse)context.getExternalContext().getResponse();
		
    	PrintWriter pw = response.getWriter();
    	
    	pw.append(ja.toString());
		
		return null;
	}
	
	/**
	 * 保存用户信息
	 * @throws Exception
	 */
	public void saveUserInfo() throws Exception{
		DataService dataService = MFormContext.getService("DataService");
		// 获取表单变量
		DataObject userInfo = (DataObject) MFormContext.getRequestAttribute("userInfo");
		// 组装user对象
		DataObject user = DataObjectHelper.getDataObjectOfEntity("userMsg.userDetailMsg.tuser");
		
		user.set("alias", userInfo.getString("alias"));
		user.set("pswd", userInfo.getString("pswd"));
		
		if(userInfo.getString("id") != null && !userInfo.getString("id").equals("")) {
			user.set("id", userInfo.getInt("id"));
		}
		
		dataService.saveOrUpdate(user);
		
		// 判断是否存储成功user对象
		if(user.getInt("id") <= 0) {
			throw new SysException();
		}
		
		// 组装user对象
		DataObject userDetail = DataObjectHelper.getDataObjectOfEntity("userMsg.userDetailMsg.tuserDetail");
		
		userDetail.set("fid", user.getInt("id"));
		userDetail.set("sex", userInfo.getInt("sex1"));
		userDetail.set("age", userInfo.getInt("age"));
		userDetail.set("address", userInfo.getString("address"));
		
		if(userInfo.getString("detailId") != null && !userInfo.getString("detailId").equals("")) {
			userDetail.set("id", userInfo.getInt("detailId"));
		}
		
		dataService.saveOrUpdate(userDetail);
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
