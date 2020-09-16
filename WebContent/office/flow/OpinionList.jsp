<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.matrix.commonservice.data.DataService"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HTML5+CSS3响应式垂直时间轴</title>
<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<style type="text/css">
h2.top_title{border-bottom:none;background:none;text-align:center;line-height:32px; font-size:20px}
h2.top_title span{font-size:12px; color:#666;font-weight:500}

/* -------------------------------- 

Primary style

-------------------------------- */
html * {
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

*, *:after, *:before {
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
}

body {
  font-size: 100%;
  color: #7f8c97;
  background-color: #f8f8f8;
}



img {
  max-width: 100%;
}

/* -------------------------------- 

Modules - reusable parts of our design

-------------------------------- */
.cd-container {
  /* this class is used to give a max-width to the element it is applied to, and center it horizontally when it reaches that max-width */
  width: 90%;
  max-width: 1170px;
  margin: 0 auto;
}
.cd-container::after {
  /* clearfix */
  content: '';
  display: table;
  clear: both;
}

/* -------------------------------- 

Main components 

-------------------------------- */

#cd-timeline {
  position: relative;
  padding: 2em 0;
  margin-top: 2em;
  margin-bottom: 2em;
}
#cd-timeline::before {
  /* this is the vertical line */
  content: '';
  position: absolute;
  top: 0;
  left: 18px;
  height: 100%;
  width: 4px;
  background: #d7e4ed;
}
@media only screen and (min-width: 1170px) {
  #cd-timeline {
    margin-top: 3em;
    margin-bottom: 3em;
  }
  #cd-timeline::before {
    left: 50%;
    margin-left: -2px;
  }
}

.cd-timeline-block {
  position: relative;
  margin: 2em 0;
}
.cd-timeline-block:after {
  content: "";
  display: table;
  clear: both;
}
.cd-timeline-block:first-child {
  margin-top: 0;
}
.cd-timeline-block:last-child {
  margin-bottom: 0;
}
@media only screen and (min-width: 1170px) {
  .cd-timeline-block {
    margin: 4em 0;
  }
  .cd-timeline-block:first-child {
    margin-top: 0;
  }
  .cd-timeline-block:last-child {
    margin-bottom: 0;
  }
}

.cd-timeline-img {
  position: absolute;
  top: 0;
  left: 0;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  box-shadow: 0 0 0 4px white, inset 0 2px 0 rgba(0, 0, 0, 0.08), 0 3px 0 4px rgba(0, 0, 0, 0.05);
}
.cd-timeline-img img {
  display: block;
  width: 24px;
  height: 24px;
  position: relative;
  left: 50%;
  top: 50%;
  margin-left: -12px;
  margin-top: -12px;
}
.cd-timeline-img.cd-picture {
  background: #45a5ce;
}
.cd-timeline-img.cd-movie {
  background: #c03b44;
}
.cd-timeline-img.cd-location {
  background: #f0ca45;
}
@media only screen and (min-width: 1170px) {
  .cd-timeline-img {
    width: 60px;
    height: 60px;
    left: 50%;
    margin-left: -30px;
    /* Force Hardware Acceleration in WebKit */
    -webkit-transform: translateZ(0);
    -webkit-backface-visibility: hidden;
  }
  .cssanimations .cd-timeline-img.is-hidden {
    visibility: hidden;
  }
  .cssanimations .cd-timeline-img.bounce-in {
    visibility: visible;
    -webkit-animation: cd-bounce-1 0.6s;
    -moz-animation: cd-bounce-1 0.6s;
    animation: cd-bounce-1 0.6s;
  }
}

.cd-timeline-content {
  position: relative;
  margin-left: 60px;
  background: white;
  border-radius: 0.25em;
  padding: 1em;
  box-shadow: 0 3px 0 #d7e4ed;
}
.cd-timeline-content:after {
  content: "";
  display: table;
  clear: both;
}
/*
.cd-timeline-content h3 {
  color: #303e49;
}
*/
.cd-timeline-content p, .cd-timeline-content .cd-read-more, .cd-timeline-content .cd-date {
  font-size: 13px;
  font-size: 0.8125rem;
}
.cd-timeline-content .cd-read-more, .cd-timeline-content .cd-date {
  display: inline-block;
}
.cd-timeline-content p {
  margin: 1em 0;
  line-height: 1.6;
  color:black;
}
.cd-timeline-content .cd-read-more {
  float: right;
  padding: .8em 1em;
  background: white;
  color: blue;
  border-radius: 0.25em;
  font-weight: bold;
}
.no-touch .cd-timeline-content .cd-read-more:hover {
  background-color: #bac4cb;  
}
a.cd-read-more:hover{text-decoration:none; background-color: #424242;  }
.cd-timeline-content .cd-date {
  float: left;
  padding: .8em 0;
  opacity: .7;
  color: black;
  font-weight: bold;
}
.cd-timeline-content::before {
  content: '';
  position: absolute;
  top: 16px;
  right: 100%;
  height: 0;
  width: 0;
  border: 7px solid transparent;
  border-right: 7px solid white;
}
@media only screen and (min-width: 768px) {
  .cd-timeline-content h2 {
    font-size: 20px;
    font-size: 1.25rem;
  }
  .cd-timeline-content p {
    font-size: 16px;
    font-size: 1rem;
  }
  .cd-timeline-content .cd-read-more, .cd-timeline-content .cd-date {
    font-size: 14px;
    font-size: 0.875rem;
  }
}
@media only screen and (min-width: 1170px) {
  .cd-timeline-content {
    margin-left: 0;
    padding: 0.4em 1.6em;
    width: 45%;
  }
  .cd-timeline-content::before {
    top: 24px;
    left: 100%;
    border-color: transparent;
    border-left-color: white;
  }
  .cd-timeline-content .cd-read-more {
    float: left;
  }
  .cd-timeline-content .cd-date {
    position: absolute;
    width: 100%;
    left: 122%;
    top: 6px;
    font-size: 16px;
    font-size: 1rem;
  }
  .cd-timeline-block:nth-child(even) .cd-timeline-content {
    float: right;
  }
  .cd-timeline-block:nth-child(even) .cd-timeline-content::before {
    top: 24px;
    left: auto;
    right: 100%;
    border-color: transparent;
    border-right-color: white;
  }
  .cd-timeline-block:nth-child(even) .cd-timeline-content .cd-read-more {
    float: right;
  }
  .cd-timeline-block:nth-child(even) .cd-timeline-content .cd-date {
    left: auto;
    right: 122%;
    text-align: right;
  }
  .cssanimations .cd-timeline-content.is-hidden {
    visibility: hidden;
  }
  .cssanimations .cd-timeline-content.bounce-in {
    visibility: visible;
    -webkit-animation: cd-bounce-2 0.6s;
    -moz-animation: cd-bounce-2 0.6s;
    animation: cd-bounce-2 0.6s;
  }
}

@media only screen and (min-width: 1170px) {
  /* inverse bounce effect on even content blocks */
  .cssanimations .cd-timeline-block:nth-child(even) .cd-timeline-content.bounce-in {
    -webkit-animation: cd-bounce-2-inverse 0.6s;
    -moz-animation: cd-bounce-2-inverse 0.6s;
    animation: cd-bounce-2-inverse 0.6s;
  }
}
.ico16 {
  display: inline-block;
  vertical-align: middle;
  height: 16px;
  width: 16px;
  line-height: 16px;
  background: url(<%=path%>/image/icon16.png) no-repeat;
 
  cursor: pointer;
}

.margin_t_5 {
  margin-top: 5px;
}
</style>
<script type="text/javascript">
    
    //下载附件
	function downloadFile(uuid){
			window.location.href = "<%=path%>/uploadFileHelperServlet?entity=office.common.attach.FileBO&name=fileName&mappingType=fileType&contents=fileContent&id=uuid&idValue="+uuid+"&type=downLoad&storeType=file";
	}
    
	//打印
	function printFunction(){
         var piid = "${param.piid}";
         if(piid){
        	 window.open("<%=path%>/print/printView.jsp?piid="+piid,"_blank");
         }
	}

</script>

</head>
<body>
<section id="cd-timeline" class="cd-container">
	  <div style="padding-left:20px;padding-right:20px;display:none;">
        <image width="16" height="16" src="<%=path %>/resource/images/print.png"></image>
        <a id="link001" name="link001" style="width:100px;height:20px;text-decoration:none;cursor:pointer;" onclick="printFunction();">打印 </a>
      </div>
	<%
		DataService dataService = MFormContext.getService("DataService");
		String piid = MFormContext.getParameter("piid");  //流程实例编码
		//查询所有意见
		StringBuffer hql = new StringBuffer();
		hql.append(" from foundation.flow.Comment ");
		hql.append(" where piid='"+piid+"' and ( isSubmit=1 or isSubmit=2 ) order by lastupdate_date ");
		List opinionList = dataService.queryList(hql.toString(),null);
		
		
		//查询所有附件
		StringBuffer hql2 = new StringBuffer();
		hql2.append("from office.common.attach.FileBO");
		hql2.append(" where mainType=3 order by createdDate desc");
		List opinFileList = dataService.queryList(hql2.toString(),null);
	    
	    if(opinionList.isEmpty()){
	%>
	        <tr style="height: 22px;" class="align_center"><td style="color: #888888;">无</td></tr>
	<%
	    }else if(opinionList!=null && opinionList.size()>0){
	    	for(int i=0;i<opinionList.size();i++){
	    		DataObject opinObj = (DataObject) opinionList.get(i);
	    		String title = opinObj.getString("activityName"); //标题
	    		String userId = opinObj.getString("userId");//用户编码
	    		String adid = opinObj.getString("adid");
	    		int isSubmit = opinObj.getInt("isSubmit");
	    		if(adid != null && adid.startsWith("Cus") && isSubmit == 1){
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
    			}else if ("6".equals(subjectValue)) {
    				attitude = "【附言】";
    			}
    			else if ("7".equals(subjectValue)) {
    				attitude = "【撤销】";
    			}	
	    	    String dateStr = sdf.format(date);
	    	    
	%>
		<div class="cd-timeline-block">
			<div class="cd-timeline-img cd-picture">
				<img src="<%=path%>/image/cd-icon-picture.svg" alt="Picture">
			</div>
	
			<div class="cd-timeline-content">
				<h4><%=title %></h4>
				<p><%=attitude%>&nbsp;&nbsp;<%=contentValue==null?"无":contentValue %></p>
				<%
				if(opinFileList!=null && opinFileList.size()>0){
					List<HashMap<String,String>> set = new ArrayList<HashMap<String,String>>();
					for(int j=0;j<opinFileList.size();j++){
						DataObject fileObj =(DataObject) opinFileList.get(j);
						
						if(aiid.equals(fileObj.getString("mFlowBizId"))&&userId.equals(fileObj.getString("creator"))){
							HashMap<String,String> map = new HashMap<String,String>();
							String fileName = fileObj.getString("fileName");
							String fileType = fileObj.getString("fileType");
							long fileSize = fileObj.getLong("fileSize");
							String uuid = fileObj.getString("uuid");
							map.put("fileName",fileName);
							map.put("fileType",fileType);
							map.put("fileSize",Long.toString(fileSize));
							map.put("uuid",uuid);
							set.add(map);
					    }
				   }	
				   if(!set.isEmpty()){
						
				%>
					<div id="attachmentTRshowAttFile" class="margin_t_5">
					<%
						for(int k=0;k<set.size();k++){
							 HashMap<String,String>  map =set.get(k);	
							 String fileName = (String)map.get("fileName");
							 String	fileType =(String) map.get("fileType");
							 Object	fileSize = (Object)map.get("fileSize");
							 String	uuid = (String)map.get("uuid");
					%>
							<div id="attachmentDiv_<%=aiid %>" style="height: 26px;  line-height: 26px;">	
								
							<%
							if("xml".equals(fileType)||"doc".equals(fileType)||"pdf".equals(fileType)||"docx".equals(fileType)||"exe".equals(fileType)||"png".equals(fileType)||"jpg".equals(fileType)||"gif".equals(fileType)||"rar".equals(fileType)||"zip".equals(fileType)||"xls".equals(fileType)||"xlsx".equals(fileType)||"txt".equals(fileType)){
							%>
							<span class="ico16 <%=fileType %>_16 margin_r_5" onclick="downloadFile('<%=uuid %>');"></span>
							<%  
							}else{
							%>
							<span class="ico16 file_16 margin_r_5" onclick="downloadFile('<%=uuid %>');"></span>
							<%
							}
							%>
							<a style="cursor: hand;font-size:12px;" title="<%=fileName %>" onclick="downloadFile('<%=uuid %>');"><%=fileName %>(<%=fileSize %>B)</a>
							</div>	
					<%
					    }
					 %>	
					</div>
			 <%
	             }
			   }
	         %>
				<div class="cd-read-more" target="_blank"><%=userName %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=depName %></div>
				<span class="cd-date"><%=dateStr %></span>
			</div>
		</div>
	
	<%
	        }
	    } 
	%>
	
</section>
</body>
</html>