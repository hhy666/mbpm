package com.matrix.demo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.matrix.faces.context.MFacesContext;







import com.matrix.commonservice.data.DataService;
import com.matrix.form.api.MFormContext;
import com.matrix.form.api.MFormException;



import commonj.sdo.DataObject;

public class UserService {
	//用户添加与更新
      public void userStart() throws MFormException {
    	DataService dataService = MFormContext.getService("DataService");
  		DataObject use = (DataObject) MFormContext.getRequestAttribute("user");
	    dataService.saveOrUpdate(use);
  		String userId = use.getString("userId");
  		DataObject dUser=(DataObject)MFormContext.getRequestAttribute("dUser");
  		DataObject pro=(DataObject)MFormContext.getRequestAttribute("pro");
  		String p = pro.getString("mProvinceId");
  		String pname = "select p.mProvinceName from user.userapp.Province p where p.mProvinceId='"+p+"'";
  		String pvalue = (String) dataService.queryValue(pname, null);
   		DataObject ci=(DataObject)MFormContext.getRequestAttribute("ci");
  		String c = ci.getString("mCityId");
  		String cname = "select c.mCityName from user.userapp.City c where c.mCityId='"+c+"'";
  		String cValue = (String)dataService.queryValue(cname, null);
  		dUser.set("fid",userId);
		dUser.set("address",pvalue.concat('_'+cValue));
  		dataService.saveOrUpdate(dUser);
      }
      //执行用户批量删除
     @SuppressWarnings("rawtypes")  //可以标注在类，字段，方法，参数，构造方法，以及局部变量上。告诉编辑器忽略指定的警告，不用再编译完成后出现警告信息。@ SuppressWarnings(“ ") @ SuppressWarnings({ }) @ SuppressWarnings(value={})
      public void deleteUser(List list) throws MFormException {
    	  DataService dataService = MFormContext.getService("DataService");
   	      for (int i = 0; i < list.size(); i++) {
			DataObject objects = (DataObject) list.get(i);
			List userList = new ArrayList<DataObject>();
			List duserList = new ArrayList<DataObject>();
			DataObject duser = com.matrix.form.util.DataObjectHelper.getDataObjectOfEntity("user.userapp.UserTow");
			duser.set("uid",objects.getString("uid"));
			duserList.add(duser);
			dataService.deleteBatch(duserList);
			DataObject user = com.matrix.form.util.DataObjectHelper.getDataObjectOfEntity("user.userapp.userOne");
			user.set("userId",objects.getString("userId"));
			userList.add(user);
			dataService.deleteBatch(userList);
			
			
		}
    	
	}
      //执行用户点击链接删除
     public void deleteSelect() {
    	 DataService dataService = MFormContext.getService("DataService");
    	 DataObject duser = com.matrix.form.util.DataObjectHelper.getDataObjectOfEntity("user.userapp.UserTow");
    	 String uid = MFormContext.getParameter("uid");
    	 duser.set("uid",uid);
    	 dataService.delete(duser);
    	 DataObject user = com.matrix.form.util.DataObjectHelper.getDataObjectOfEntity("user.userapp.userOne");
    	 String userId = MFormContext.getParameter("userId");
    	 user.set("userId",userId);
    	 dataService.delete(user);
	}
     //执行链接删除2
     public void executeDelete() {
    	 DataService dataService = MFormContext.getService("DataService");
    	 //DataObject duser = com.matrix.form.util.DataObjectHelper.getDataObjectOfEntity("user.userapp.UserTow");
    	 String uid = MFormContext.getParameter("uid");
    	 String sql = "delete from user.userapp.UserTow a where a.uid='"+uid+"'";
    	 dataService.executeDelete(sql, null);
    	 //DataObject user = com.matrix.form.util.DataObjectHelper.getDataObjectOfEntity("user.userapp.userOne");
    	 String userId = MFormContext.getParameter("userId");
    	 String hsql = "delete from user.userapp.userOne b where b.userId='"+userId+"'";
    	 dataService.executeDelete(hsql, null);
	}
     
//	/**
//     * 保存用户和用户详情
//     */
//    public void saveUserAndDetail() throws Exception {
//            DataService dataService = MFormContext.getService("DataService");
//            // 先保存用户
//            DataObject user = (DataObject) MFormContext.getFormVariable("user");
//            
//            try {
//                    dataService.save(user);
//            } catch (Exception e) {
//                    System.out.println("用户主表信息保存失败 ！ " + e);
//                    throw e;
//            }
//    
//            // 判断 user 的id 是否为null 不为空保存 用户详细信息
//            String uid = user.getString("uid");
//            
//            if(uid != null && !uid.equals("")) {
//                    // 再保存用户详细信息
//                    DataObject userDetail = (DataObject) MFormContext.getFormVariable("dUser");
//                    
//                    //设置外键fid
//                    userDetail.set("fid", uid);
//                    
//                    try {
//                            dataService.save(userDetail);
//                    } catch (Exception e) {
//                            System.out.println("用户从表信息保存失败 ！ " + e);
//                            throw e;
//                    }
//            }
//    }
}
