<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.matrix.commonservice.data.DataService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="commonj.sdo.DataObject" %>
<%@ page import="com.matrix.form.api.MFormContext" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath = path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>OpinionListTimeLine.jsp</title>
    
	<meta charset='utf-8'/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href='<%=path %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
	<link href='<%=path %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
	<link href='<%=path %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
	<link href='<%=path %>/resource/html5/css/flat/blue.css' rel="stylesheet"></link>
	<link href='<%=path %>/resource/html5/css/square/blue.css' rel="stylesheet"></link>
	<link href='<%=path %>/resource/html5/css/bootstrap-select.css' rel="stylesheet"></link>
	<link href='<%=path %>/resource/html5/css/select2.css' rel="stylesheet"></link>
	<link href='<%=path %>/resource/html5/css/clockpicker.css' rel="stylesheet"></link>
	<link href='<%=path %>/css/filecss.css' rel="stylesheet"></link>
	<link href='<%=path %>/css/datatables.net-bs/css/dataTables.bootstrap.min.css'	rel="stylesheet"></link>
	<link href='<%=path %>/css/datatables.net-scroller-bs/css/scroller.bootstrap.min.css'	rel="stylesheet"></link>
	<link href='<%=path %>/office/html5/assets/bootstrap-table/src/bootstrap-table.css'	rel="stylesheet"></link>
	<link href='<%=path %>/resource/html5/css/google-code-prettify/bin/prettify.min.css' rel="stylesheet"></link>
	<link href='<%=path %>/resource/html5/css/custom.css' rel="stylesheet"></link>
	<link href='<%=path %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
	<SCRIPT SRC='<%=path %>/resource/html5/js/jquery.min.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/jquery.inputmask.bundle.min.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/css/bootstrap/dist/js/bootstrap.min.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/icheck.min.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/bootstrap-select.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/select2.js'></SCRIPT>
	<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
	<SCRIPT SRC='<%=path %>/resource/html5/js/autosize.min.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/laydate/laydate.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/matrix_runtime.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/clockpicker.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js'></SCRIPT>
	 <SCRIPT SRC='<%=path %>/resource/html5/js/jquery.hotkeys/jquery.hotkeys.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/css/google-code-prettify/src/prettify.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/validator.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/filejs.js'></SCRIPT>
	<link rel='stylesheet' href='<%=path %>/resource/html5/css/style.min.css' />
	<link rel='stylesheet' href='<%=path %>/css/themes/default/style.min.css'/>
	<script src='<%=path %>/resource/html5/js/jstree.min.js'></script>
	<SCRIPT>var webContextPath = "/mofficeV3";</SCRIPT>
	<script src='<%=path %>/office/html5/assets/bootstrap-table/src/bootstrap-table.js'></script>
	
	<style type="text/css">
		.date>font{
			color: #1ab394;
		}
		
	</style>
  </head>
  <body>
  	<div class="container">
  		<div class="row" style="margin-right: -15px; margin-left: -15px;">
		  	<div class="col-xs-12 ui-sortable">
		  		<div class="ibox float-e-margins" >
		  			<div class="ibox-content timeline" style="overflow: auto; height:100%;">
 <%
	 String piid = request.getParameter("piid"); // 流程实例编码
	 DataService dataService = MFormContext.getService("DataService");//数据服务
 

	//通过数据服务查询意见列表 
 	StringBuffer hql = new StringBuffer();
	hql.append(" from foundation.flow.Comment ");
	hql.append(" where piid='"+piid+"' and isSubmit=1 order by lastupdate_date ");
	List opinionList = dataService.queryList(hql.toString(),null);
	StringBuffer hql2 = new StringBuffer();
	if(opinionList.isEmpty()){
	%>
	 无意见附件显示
	<%
	}
	else if(opinionList!=null && opinionList.size()>0){

		for(int i=0;i<opinionList.size();i++){  //循环显示意见内容
			DataObject opinObj = (DataObject) opinionList.get(i);
		
		    //根据对象内容准备意见显示内容
			String title = opinObj.getString("activityName"); //标题
			String userId = opinObj.getString("userId");//用户编码
			String adid = opinObj.getString("adid");
			if(adid != null && adid.startsWith("Cus")){
				continue;
			}
			String userName = opinObj.getString("userName");  //用户名
			String depName = opinObj.getString("depName");  //用户名
			if(depName == null)
				depName = "";
		    Date date = opinObj.getDate("lastupdateDate"); //最后修改时间
		    String contentValue = opinObj.getString("contentValue");//意见内容
			String aiid = opinObj.getString("aiid");//活动编码
			 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				String subjectValue = opinObj.getString("subjectValue");// 态度
				String attitude = "";
				if ("1".equals(subjectValue)) {
					attitude = "【已阅】";
				} else if ("2".equals(subjectValue)) {
					attitude = "【同意】";
				} else if ("3".equals(subjectValue)) {
					attitude = "【不同意】";
				} else if ("4".equals(subjectValue)) {
					attitude = "【退回】";
				} else if ("5".equals(subjectValue)) {
					attitude = "【转交】";
				}
			
			  String dateStr = sdf.format(date);
	%>
			  				<div class="timeline-item">
			  					<div class="row" style="margin-right: -15px; margin-left: -15px;">
			  						<div class="col-xs-3 date ui-sortable">
			  							<i class="fa fa-briefcase">
			  							</i>
			  							<font><%=dateStr %></font>
			  							<br>
			  						</div>
			  						<div class="col-xs-7 content ui-sortable">
			  							<p class="m-b-xs">
			  								<strong><%=title %></strong>
			  							</p>
			  							<p style="color:00659C;"><%=depName %>&nbsp;&nbsp;&nbsp;<%=userName %></p>
			  						</div>
			  					</div>
			  				</div>
			 <%}} %>
		  			</div>
		  		</div>
		  	</div>
	  	</div>
  	</div>
  </body>
</html>
