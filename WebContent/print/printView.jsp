<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.matrix.commonservice.data.DataService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="commonj.sdo.DataObject" %>
<%@ page import="com.matrix.form.api.MFormContext" %>
<%@ page import="java.text.SimpleDateFormat" %>
<html><head id="linkList">

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--签章控件需要在IE9模式下才能显示  -->
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9">
        <title>print</title>
        <script src="<%=path%>/resource/html5/js/jquery.min.js"></script>
        <script src="<%=path%>/resource/html5/js/jquery.jqprint-0.3.js"></script>
       <style>
            .body{
                border-top:10px #ededed solid;
                border-bottom:0px #ededed solid;
                margin:0px;
                background:#fff;
            }
            body, div, dl, dt, dd, pre, code, form, input, button, textarea, p, th, td, ul, li {
    margin: 0;
    padding: 0;
    font-family: "Microsoft YaHei",SimSun,Arial,Helvetica,sans-serif;
}
            .margin_b_5 {
    margin-bottom: 5px;
}
.margin_t_5 {
    margin-top: 5px;
}

.font_size12 {
    font-size: 12px;
}
            .common_button, .form_btn {
    font-size: 12px;
    border: 1px solid #CCC;
    color: #111;
    background: #EAEAEA;
    border-radius: 5px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 91px;
    display: inline-block;
    padding: 0 10px;
    line-height: 24px;
    height: 24px;
    vertical-align: middle;
    _vertical-align: baseline;
    display: inline-block;
}
         
            .common_button:HOVER, .form_btn:HOVER {
    font-size: 12px;
    border: 1px solid #CCC;
    color: #111;
    background: #F5F5F5;
    border-radius: 5px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 91px;
    display: inline-block;
    padding: 0 10px;
    line-height: 24px;
    height: 24px;
    vertical-align: middle;
    _vertical-align: baseline;
    display: inline-block;
}   
            /***全局样式干扰表单样式，此处需要重新定义这些样式***/
            #context div,#context form,#context input,#context textarea,#context p,#context th,#context td,#context ul,#context li{
				font-family: inherit;
			}
            .header{
                background:#ededed;
            }
            #context{
                background:#ffffff;
                margin:0px auto;
              /*  padding-left:35px;
                padding-right:35px;*/
                word-break: break-all;
            }
            /**input框被替换成了span导致input[type='text']无法适用于原来的input内容，所以添加此样式**/
            span[type="text"]{
				font-size:12px;
				height:auto;
				line-height: 20px;
				white-space: normal;
			}
            @media print{
                #header{
                    display:none;
                }
                .body{
                    border:1px;
                    margin:0px;
                }
                #iSignatureHtmlDiv{
                	display:none;
                }
            }
            
        </style>
                <script>
     
var contentType = "20";      
var viewState = "1";     

function thisclose(){
 window.close();
}
function printIt(n){
   var _WebBrowser = document.getElementById('WebBrowser');
  
	var z = document.getElementById('opinionTable').style.zoom;
  if(n==1){
	 //正常
	  $('#opinionTable').css("zoom",z);
	  $('#opinionTable').jqprint({ 
          debug: false,            
          importCSS: true,         
          printContainer: true,    
          operaSupport: false      
      });
  }else{
    try {
		document.all.time.ExecWB(n,1);
		frame.document.body.innerHTML = s;
    }catch(e){}
  }
}
var _currentZoom = 0;
function doChangeSize(changeType){
  //var content = document.getElementById("context") ;
  var content = document.getElementById('opinionTable');
  //var content = document.getElementById('time').contentWindow.document.getElementById("table001");
  if(content.style.zoom == "" || undefined || null ){
  content.style.zoom = '1';
  }
  if(changeType == "bigger") {
      thisMoreBig(content);
  }else if(changeType == "smaller"){
      thisSmaller(content);
  }else if(changeType == "self"){
      thisToSelf(content); 
  }else if(changeType == "customize"){
      thisCustomize(content) ;
  }
}
function thisMoreBig(content,size){
  if(!size){
    size = 0.05 ;
  }
  zoomIt(content,size);
}
function thisSmaller(content,size){
  if(!size){
    size = -0.05 ;
  }else {
    size = size * -1;
  }
  zoomIt(content,size);
}
function thisToSelf(content){
  zoomIt(content);
}
function thisCustomize(content){
  var print8 = document.getElementById("print8") ;
  
  if(content && print8 && print8.value != "" ){
      if(isNaN(print8.value)){
        alert("common.print.ratio.number.label") ;
         return ;
      }
      _currentZoom = 0;
      zoomIt(content, parseFloat(print8.value / 100) - 1);
  }
}
function zoomIt(content,size) {
  if(content){
    if(!size) {
      size = 0;
      _currentZoom = 0;
    }
    _currentZoom = _currentZoom + size;
    if(content.style.zoom) {
      content.style.zoom = 1 + _currentZoom ;
    }else {
   // document.getElementById('time').contentWindow.document.getElementById("table001").style.MozTransform='scale('+(1+_currentZoom)+')';
    document.getElementById('time').contentWindow.document.getElementsByTagName('form')[0].style.MozTransform='scale('+(1+_currentZoom)+')';
    //  document.getElementById('content').style.MozTransform='scale('+(1+_currentZoom)+')';
    }
    clearnText() ;
  }
}
function clearnText(){
    var print8 = document.getElementById("print8") ;
   //  var context = document.getElementById('time').contentWindow.document.body;
   var context = document.getElementById('opinionTable');
   // var context = document.getElementById("context") ;
    if(print8 &&  context){
      var size = 1+_currentZoom;
      print8.value = parseInt(size * 100);
      var zoom = context.style.zoom;
      
      var width = context.style.width;
      if(width.indexOf("%")>0){
      width = width.replace("%","");
      context.style.width = 100*parseFloat(zoom)+"%";
      }
    }
   
}


function initBodyHeight(iframename) {
 var selfHeight = document.body.scrollHeight-73;
 var selfWidth = document.body.clientWidth-20;
    var p_demo = window.top.document.getElementById(iframename);
   p_demo.height=selfHeight;
    p_demo.width=selfWidth;
    document.getElementById('opinionTable').style.height="";
    document.getElementById('opinionTable').style.width="";
    document.getElementById('opinionTable').align="center";
     if (!window.ActiveXObject || "ActiveXObject" in window) {
    $('#print2').hide();
    $('#print3').hide();
  }
  var context = document.getElementById('opinionTable');
  context.align = "center";
}

</script>

     
    </head>
    <body onload="initBodyHeight('opinionTable');" class="body">
        <div id="header" class="header">     
            <table width="100%" cellpadding="0" cellspacing="0">
                <tbody><tr onclick="">
                   <td style="padding-left:10px;">
                        <a id="print1" class="common_button common_button_gray" href="javascript:printIt(1);" target="_self" style="color: rgb(0, 0, 0); text-decoration: none; cursor: default;">打印</a>
                        <a id="print2" class="common_button common_button_gray" href="javascript:printIt(8);" target="_self" style=" color: rgb(0, 0, 0); text-decoration: none; cursor: default;">打印设置</a>
                        <a id="print3" class="common_button common_button_gray" href="javascript:printIt(7);" target="_self" style=" color: rgb(0, 0, 0); text-decoration: none; cursor: default;">打印预览</a>
                        <a id="print4" class="common_button common_button_gray" href="javascript:thisclose();" target="_self" style="color: rgb(0, 0, 0); text-decoration: none; cursor: default;">关闭</a>
                        <div class="margin_t_5 margin_b_5 font_size12" id="_showOrDisableButton">
                        <a id="print5" class="common_button common_button_gray" href="javascript:doChangeSize('bigger');" target="_self" style="color: rgb(0, 0, 0); text-decoration: none; cursor: default;">放大</a>
                        <a id="print6" class="common_button common_button_gray" href="javascript:doChangeSize('smaller');" target="_self" style="color: rgb(0, 0, 0); text-decoration: none; cursor: default;">缩小</a>
                        <a id="print7" class="common_button common_button_gray" href="javascript:doChangeSize('self');" target="_self" style="color: rgb(0, 0, 0); text-decoration: none; cursor: default;">还原</a>
                        <span class="margin_l_5" style="cursor: default;">自定义比例：</span><input type="text" id="print8" style="border:1px #b6b6b6 solid;height:24px;width:30px;" value="100" onblur="doChangeSize('customize')">%
                        </div>
                    </td>
                    <td style="padding-right:10px;">
                       
                    </td>
                </tr>
            </tbody></table>
        </div>  
       <div class="content" style="height:auto; width:100%;" id="context2" style="zoom:1;">
     		 <table id="opinionTable" width="100%" bordercolor="grey" style="border-collapse: collapse;border: hidden;" class="bg_color_white font_size12">
				  <%
				 String piid = request.getParameter("piid"); // 流程实例编码
				// if(piid==null||piid.length()==0)
				//{}
				 //else{
				 DataService dataService = MFormContext.getService("DataService");//数据服务
				 StringBuffer hql = new StringBuffer();
					hql.append(" from foundation.flow.Comment ");
					hql.append(" where piid='"+piid+"' and isSubmit=1 order by lastupdate_date ");
					List opinionList = dataService.queryList(hql.toString(),null);
					StringBuffer hql2 = new StringBuffer();
					hql2.append("from office.common.attach.FileBO");
					hql2.append(" where mainType=3 order by createdDate desc");
					List opinFileList = dataService.queryList(hql2.toString(),null);
					if(opinionList.isEmpty()){
					%>
					 <tr style="height: 22px;" class="align_center"><td style="color: #888888;">无意见附件显示</td></tr>
					<%
					}
					else if(opinionList!=null && opinionList.size()>0){
				
					for(int i=0;i<opinionList.size();i++){
					DataObject opinObj = (DataObject) opinionList.get(i);
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
						}else if ("6".equals(subjectValue)) {
							attitude = "【附言】";
						}
						else if ("7".equals(subjectValue)) {
							attitude = "【撤销】";
						}
				
				
					
				  String dateStr = sdf.format(date);
					%>
					
				   <tr  style="height: 22px;">
				  
				   <td colspan="3">&nbsp;&nbsp;&nbsp;<%=attitude%><%=contentValue==null?"":contentValue %></td>
				   </tr>
				   <tr>
				    <td  align="right" ><%=depName %>&nbsp;&nbsp;&nbsp;<%=userName %>
				   </td>
				    <td style="width: 20%;"  align="right">
				   <%=title %>
				   </td>
				  
				   <td  style="width: 20%;" align="right" >
				   <%=dateStr %>
				   </td>
				   </tr>
				   <tr>
				   <td colspan="3">
				   <hr/>
				   </td>
				   </tr>
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
					if(!set.isEmpty())
					{
					%>
					<tr>
					<td colspan="3">
					<div id="attachmentTRshowAttFile" class="margin_t_5">
					<%
					for(int k=0;k<set.size();k++){
						
					HashMap<String,String>  map =set.get(k);	
					 String fileName = (String)map.get("fileName");
					 String	fileType =(String) map.get("fileType");
					 Object	fileSize = (Object)map.get("fileSize");
					 String	uuid = (String)map.get("uuid");
					%>
					
					  	<div id="attachmentDiv_<%=aiid %>" style="float:left;height: 26px;  line-height: 26px;">
				  <% 
				   	if("xml".equals(fileType)||"doc".equals(fileType)||"pdf".equals(fileType)||"docx".equals(fileType)||"exe".equals(fileType)||"png".equals(fileType)||"jpg".equals(fileType)||"gif".equals(fileType)||"rar".equals(fileType)||"zip".equals(fileType)||"xls".equals(fileType)||"xlsx".equals(fileType)||"txt".equals(fileType)){
				   %>
				   
				   <span class="ico16 <%=fileType %>_16 margin_r_5"></span>
				   
				   <%
				   }
				   else{
				    %>
				     <span class="ico16 file_16 margin_r_5"></span>
				     <%} %>
				   <a style="cursor: hand;font-size:12px;" title="<%=fileName %>" onclick="downloadFile('<%=uuid %>');"><%=fileName %>(<%=fileSize %>B)
				   </div>
				   <%} %>
				   </div>
				   </td>
				  </tr>
				  <%} }}%>
				  
				   <%}
				    %>
			</table>
        </div>
        
        <OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 style="width:0px;height:0px;margin:0px;padding:0px"></OBJECT>   


</body>
</html>