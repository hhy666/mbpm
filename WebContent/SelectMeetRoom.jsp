<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>会议室申请</title>
<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
<script type="text/javascript" charset="UTF-8" src="<%=request.getContextPath()%>/resource/html5/js/jquery.min.js"></script>

<!-- 图形化会议室插件js -->
<script src="codebase/dhtmlxscheduler.js" type="text/javascript" charset="utf-8"></script>
<script src="apps_res/plugin/meetingroom/sources/locale_cn.js" type="text/javascript" charset="utf-8"></script>
<script src="apps_res/plugin/meetingroom/sources/locale_recurring_cn.js" type="text/javascript" charset="utf-8"></script>
<script src="codebase/ext/dhtmlxscheduler_tooltip.js"></script>
<script src="codebase/ext/dhtmlxscheduler_timeline.js"></script>
<script src="meeting/i18n/zh-cn.js"></script>
<script src="codebase/ext/dhtmlxscheduler_minical.js"></script><!-- 时间 -->
<script type="text/javascript" charset="UTF-8" src="meeting/js/V3X.js"></script>

<link rel="stylesheet" href="codebase/dhtmlxscheduler_glossy.css" type="text/css" title="no title" charset="utf-8"/>

<link href="meeting/css/skin.css" type="text/css" rel="stylesheet">
    
<style type="text/css" media="screen"> 
	body{
		margin:0px;
		padding:0px;
		height:100%;
		overflow:hidden;
		position:absolute;
		left:0;
		width:100%;
	}	
	.one_line{
		white-space:nowrap;
		overflow:hidden;
		padding-top:5px; 
		padding-left:5px;
		text-align:left!important;
	}
	.dhx_cal_event_line,.dhx_cal_event_line1,.dhx_cal_event_line2 {
		height:85%;
		/**filter: Alpha(Opacity=70);设置拖动DIV的背景透明 */
	}
</style>

<script type="text/javascript" charset="utf-8">

//初始化js Ajax-------------------------------Start
var request = false;
try {
   	request = new XMLHttpRequest();
 } catch (trymicrosoft) {
   	try {
     		request = new ActiveXObject("Msxml2.XMLHTTP");
   	} catch (othermicrosoft) {
     	try {
       		request = new ActiveXObject("Microsoft.XMLHTTP");
   		} catch (failed) {
     		request = false;
   		}  
   	}
 }
 if (!request){
   	alert("初始化XMLHttpRequest的错误!");
 }
//初始化js Ajax-------------------------------End
  	
var old_id = "";//记录上一次选择的时间段自动生成的Id
var oldRoomAppId = null;//记录回显时的Id
var currentdate = "";//当前的时间,不一定是当前,可以是随意选择的时间
var deleteStatusId = "";//删除状态,在移动已经申请过的会议室时,要给它赋上值

/******************************** 初始化数据 start **************************************/
<%
Object meets = request.getAttribute("meets");
%>
function init() {
	var sections = <%=meets%>;
	if(sections=="1"){
		//alert("管理员还未添加会议室,请联系管理员!");
		//window.close();
		document.getElementById("scheduler_here").style.display = 'none';
		document.getElementById("roomButtomDiv").style.display = 'none';
		document.getElementById("noRoomMsgDiv").style.display = '';
		return;
	}
	
	scheduler.locale.labels.timeline_tab = "时间";
	scheduler.locale.labels.section_custom="会议室申请";
	scheduler.config.details_on_create=true;
	scheduler.config.details_on_dblclick=true;
	scheduler.config.xml_date="%Y-%m-%d %H:%i";
	scheduler.createTimelineView({
		name:"timeline",
		x_unit:"minute",
		x_date:"%H:%i",
		x_step:15,
		x_size:63.9,//判断时间长度
		x_start:32,
		x_length:96,
		y_unit:sections,
		y_property:"section_id",
		render:"bar",
		dy:10
	});
			
	//------------------------------------------------------------将时间设置成整小时
	<%
	Object meeting = request.getAttribute("meeting");
	%>
	scheduler._render_x_header = function (a, b, c, d) {
		var e = document.createElement("DIV");
		e.className = "dhx_scale_bar";
		this.set_xy(e, this._cols[a] - 1, this.xy.scale_height - 2, b, 0);
		var timeVar=this.templates[this._mode + "_scale_date"](c, this._mode);
		
		if(timeVar.substring(3)=="00") {
			e.innerHTML ="&nbsp;&nbsp;&nbsp;"+timeVar;
			d.appendChild(e);
		}
	};
	scheduler.init('scheduler_here',null,"timeline");
	var jsonMeeting=<%=meeting%>;
	scheduler.parse(jsonMeeting, "json");//加载从数据库中读取的会议室申请记录

	//会议修改时，勾选上之前申请的会议室复选框
	

	
	//-----------------------------回显手动选择的会议室------------------------------------start
	var returnMrs=null;//在没入库前,点击再次进入时要显示回显的数据
	var meetingRoom = document.getElementById('meetingRoom').value;
	if(meetingRoom!=null&&meetingRoom.length>0){
	var startDate = document.getElementById('startDate').value;
	var endDate = document.getElementById('endDate').value;
	returnMrs = [{id:""+meetingRoom+"",start_date: ""+startDate+"", end_date: ""+endDate+"",section_id:""+meetingRoom+""}];//在没入库前,点击再次进入时要显示回显的数据

	if(returnMrs!=null&&""!=returnMrs&&"null"!=returnMrs){
		$("#start_time").val(returnMrs[0].start_date);
		$("#end_time").val(returnMrs[0].end_date);
		

			scheduler.parse(returnMrs, "json");//加载选择的记录
			var roomM = document.getElementById("room_"+returnMrs[0].section_id);
			if(roomM){
				roomM.checked = true;
				room_obj = document.getElementById("room_"+returnMrs[0].section_id);
			}
	
			}
	}
	//-----------------------------回显手动选择的会议室------------------------------------end
	else if(window.opener || window.dialogArguments){
		var _parentWindow = window.opener || window.dialogArguments.parentWin;
		if(_parentWindow.document.getElementById("beginDate") && _parentWindow.document.getElementById("endDate")){
			$("#start_time").val(_parentWindow.document.getElementById("beginDate").value);
			$("#end_time").val(_parentWindow.document.getElementById("endDate").value);
		}
	}
			
	//----------------------------------------------------------------------移动后触发
	scheduler.attachEvent("onEventChanged", function(event_id, event_object){
	    var id = event_object.id;
	    var text = event_object.text;
	    var convert = scheduler.date.date_to_str("%Y-%m-%d %H:%i");
	    var start_date = convert(event_object.start_date);
	    var end_date = convert(event_object.end_date);
        var section_id = event_object.section_id;
        var status=event_object.status;
        if(status==2){//如果拖动从数据库读出的时间段,则把新拖动的给删除掉
		    scheduler.deleteEvent(old_id);//删除上一个新建的时间段
		    scheduler.deleteEvent(oldRoomAppId);//删除回显的时间段
		    deleteStatusId=id;
        	//old_id=id;
		}
	        
        document.getElementById("meetingRoom").value=section_id;
		document.getElementById("startDate").value=start_date;
		document.getElementById("endDate").value=end_date;
	    //这里使用true刷心主窗口
	    return true;
	});
			
	//--------------------------------------------------------------------拖动时触发
	scheduler.attachEvent("onBeforeEventChanged", function (a) {
		//用来记录是添加还是修改的标记(如果是添加则不能拖动任何的时间段,如果是修改,再去判断拖动的是否是当前的会议,如果是则可拖动,否则不难拖动)
		var action="create";
		//修改的时候取得会议的ID用来判断只许修改当前ID的会议
		var meetId="";
		//添加,时不能修改其他的会议时间段,如果meetingid!=null的话就表示当前是拖动的其他时间段,如果是新增的这个是不会有值的
		if(action=="create" && a.meetingid!=null){
			alert("不能修改已申请的时间段。");
			return false;
		}
		//修改时meetId会有值,判断当前拖动的会议时间段是不是属于当前会议室
		if(a.meetingid!=null){
			if(action=="edit" && meetId!=a.meetingid){
				alert("对不起,此时间段不属于当前会议。");
				return false;
			}
		}
		//检查当选择的时间是否小于系统时间，如查小于系统时间则不允许选择会议室
		var convert1 = scheduler.date.date_to_str("%Y-%m-%d");
		if(currentdate!=null&&""!=currentdate){
			var curdate=convert1(currentdate);
			var nowdate=convert1(new Date());
			if(curdate<nowdate){
				//alert("选择的时间不能小于系统当天时间。");
				alert("选择的时间不能小于系统当前时间!");
				return false;
			}
		}
		var id = a.id;
		var status=a.status;//判断是否有权限修改 1不是本人添加的时间,2是本人添加,3其他情况
		var timeout=a.timeout;
	    var convert = scheduler.date.date_to_str("%Y-%m-%d %H:%i");
	    var start_date = convert(a.start_date);
	    var end_date = convert(a.end_date);
	    if(convert(new Date())>start_date){
			alert("开始时间不能小于系统当前时间!");//开始时间不能小于系统当前时间
		    return false;
		}
        var section_id = a.section_id;
		var flag=false;
        if(status==1){//没有权限
			alert("对不起,只能修改自己添加的会议室！!");
			return false;
		}
		if(timeout==2){//会议已经开始
			alert("会议已经开始不能修改!");
			return false;
		}
		if(timeout==3){//会议已经结束
			alert("会议已经结束不能修改!");
			return false;
		}
		if(status==2||status==null||""==status||"undefined"==status){//有权限或者是新建都,要去后台查询是否被占用
			flag = checkRoomDisabled(start_date, end_date, section_id);
		}else{//其他情况
			alert("Error");
		}
		//同步到上方的时间框和右侧的勾选框
		$("#start_time").val(start_date);
		$("#end_time").val(end_date);
		disableCheckBox();
		room_obj = document.getElementById("room_"+section_id);
		if(!room_obj.checked){
			room_obj.checked = true;
		}else {
			room_obj.checked = false;
		}
		return flag;
	});
	
	//－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－绘制出图形时触发的事件(弹出框)
	scheduler.showLightbox = function(id){
		var ev = scheduler.getEvent(id);
	    var convert = scheduler.date.date_to_str("%Y-%m-%d %H:%i");
	    var start_date = convert(ev.start_date);
	    var end_date = convert(ev.end_date);
	    //判断用户选反时间是否是>=30分钟,如果超过三十分钟则进行其他操作,不到三十分钟则提示并删除当前选择项
	    //if(((getDateTimeStamp(end_date))-(getDateTimeStamp(start_date)))>=1800000){
	    	var section_id=ev.section_id;
			//在绘制新的时间段时,要先恢复以前拖动的时间段---------------------------------------------Start
			if(currentdate==null||""==currentdate||"undefined"==currentdate){
				currentdate=new Date();
			}
			timebutton(currentdate);
		  	//如果在绘制新的时间段时,要先恢复以前拖动的时间段---------------------------------------------End
		  	//在绘制新的时间段时,删除原来"回显"时绘制的时间段---------------------------------------------Statr
			if(oldRoomAppId!=null&&""!=oldRoomAppId&&"null"!=oldRoomAppId){
				scheduler.deleteEvent(oldRoomAppId);
			}
			//在绘制新的时间段时,删除原来"回显"时绘制的时间段---------------------------------------------End
			//如果用户选择第二个时间段时清除上一个新建的时间段--------------------------------------------Start
			if((""!=old_id)||(null!=old_id)){
				scheduler.deleteEvent(old_id);
			}
			//如果用户选择第二个时间段时清除上一个选择的时间段--------------------------------------------End
			old_id=id;
		    document.getElementById("meetingRoom").value=section_id;
			document.getElementById("startDate").value=start_date;
			document.getElementById("endDate").value=end_date;
			
			//原来的方法保留并做修改(注销)
			if (id && this.callEvent("onBeforeLightbox", [id])) {
				var b = this._get_lightbox();
				//this.showCover(b);//去掉弹出的框
				this._fill_lightbox(id, b);
				this.callEvent("onLightbox", [id]);
		    }
		    //保存
			scheduler.save_lightbox();

			//同步信息到上面的时间框里面
			$("#start_time").val(start_date);
			$("#end_time").val(end_date);
			disableCheckBox();
			room_obj = document.getElementById("room_"+section_id);
			if(!room_obj.checked){
				room_obj.checked = true;
			}else {
				room_obj.checked = false;
			}
		//}else{
			//alert("会议时间必须超过三十分钟");
			//scheduler.deleteEvent(id);
		//}
	}
	
	//鼠标放在上边提示的信息
	scheduler.templates.tooltip_text = function (b, d, c) {
		var status=c.status;//鼠标放在上边就为隐藏表单赋值
		if(status==2||status==null||""==status||"undefined"==status){
			//这里赋值是为了区分在删除的时候,是删除数据库还是删除刚新建的会议室
			document.getElementById("mtid").value=c.mtappid;
			document.getElementById("boxid").value=c.id;
		}
		var startdate=scheduler.templates.tooltip_date_format(b);
		var enddate=scheduler.templates.tooltip_date_format(d);
		var startdates=startdate.split(" ");
		var enddates=enddate.split(" ");
		var time=startdates[1]+"—"+enddates[1];
		var text=c.text_hid;
		var tooltipMsg="";
		if(null!=c.createUserName && ""!=c.createUserName && "undefined" != c.createUserName){
		tooltipMsg+="<div style='height:18px;'>&nbsp;&nbsp;&nbsp;<b>申请人:</b> "+c.createUserName+"</div>";
		}
		tooltipMsg+="<b>会议时间:</b> " + time;
		return tooltipMsg;
	};
}

function disableCheckBox(){
	var _allCheckBox = document.getElementsByName("autoSelectRoom");
	if(_allCheckBox){
		for(var i=0; i<_allCheckBox.length; i++){
			document.getElementById(_allCheckBox[i].getAttribute("id")).checked = false;
		}
	}
}

//会议时候被占用
function checkRoomDisabled(start_date, end_date, section_id){
	var _result = false;
	var url =webContextPath+ "/meetingroom/MeetRoomAction_validateTimeOccupy.action?startDate="+start_date+"&endDate="+end_date+"&roomId="+section_id+"&date="+new Date();
	request.open("GET", url, false);
	request.onreadystatechange = function(){
		if (request.readyState == 4) {
			if (request.status == 200) {
				var response = request.responseText;
				response=response.trim();
				if(response=='Y'){//如果允许托动的话,则把新的时间段和会议室赋值
					document.getElementById("meetingRoom").value=section_id;
					document.getElementById("startDate").value=start_date;
				    document.getElementById("endDate").value=end_date;
					_result=true;
				}else if(response=='N'){
					alert("该时间段被占用");
				}
			}else{
		}
		}else{
		}
	};
	request.send(null);
	return _result;
}
/******************************** 初始化数据 end **************************************/	

//点击删除时弹出提示框,点击确定则删除,否则取消删除
var deleteFlag = false;/** xiangfan 修复GOV-3901，默认为false */
function showDelete(){
	var initW = typeof(dialogArguments)=='undefined'?null:dialogArguments; //获得父窗口对象
	var roomAppId=document.getElementById("mtid").value;
	var boxid=document.getElementById("boxid").value;
	var flag=confirm("您确定要删除吗?");
	if(flag){
		if(roomAppId!=""&&roomAppId!=null&&"undefined"!=roomAppId){//如果不是从数据库读出的数据则不需要进入后台删除数据
			var meetingId = initW==null?'':initW.document.getElementById("meetingId").value;
			var sendType = initW==null?'':initW.document.getElementById("sendType").value;//如果会议申请转会议通知时sendType=publishAppToMt,其他情况为空值
			var appType = initW==null?'':initW.document.getElementById("appType").value;//xiangfan 添加， 会议室申请有两个入口【申请会议室】和【新建会议通知】RoomApp表示入口是【申请会议室】 MtMeeting表示入口是【新建会议通知】
			var url = "?method=deleteMeetingRoomById&roomId="+roomAppId+"&date="+new Date()+"&meetingId="+meetingId+"&sendType="+sendType+"&appType="+appType;
		    request.open("GET", url, true);
		    request.onreadystatechange = function(){
		    	if (request.readyState == 4) {
			    	if (request.status == 200) {
			        	var response = request.responseText;
			        	response=response.trim();
			        	if(response==0){
			        		document.getElementById("meetingRoom").value="";
			        		scheduler.deleteEvent(boxid);//提示删除成功
			        		//xiangfan 添加删除后清除遗留数据，修复 删除会议室还能提交会议通知的错误
			        		if(appType != "RoomApp" && appType != "PortalRoomApp"){
								//当删除之前申请的会议室时，需要将父页面的 关于会议室的参数都清空				        		
			        			cleanParentMeetingParams();
			        		}
					        alert("删除成功");
					        deleteFlag = true;/** xiangfan 修复GOV-3901，如果是真删，设置为 true */
				        }else if(response==2){
					        alert("不允许删除不属于当前会议的会议室！");
					        return null; 
				        }else{//提示删除失败
					        alert("删除失败");
					    }
			       }else{
			       }
			   	}else{
				}
			};
		    request.send(null);
		}else{
			//清除父页面的值(调用父页面的函数)
			try{
				//window.parent.dialogArguments.cleanMt();
				cleanParentMeetingParams();
			}catch(err){
			}
			document.getElementById("meetingRoom").value="";
			scheduler.deleteEvent(boxid);
			disableCheckBox();
		}
	}
}

function cleanParentMeetingParams(){
	var initW = typeof(dialogArguments)=='undefined'?null:dialogArguments; //获得父窗口对象
	if(initW && initW.document.getElementById("selectRoomType").options){
		initW.document.getElementById("portalRoomAppId").value = "";
		initW.document.getElementById("meetingPlace").value = "";
		initW.document.getElementById("isFromPortal").value = "";
		initW.document.getElementById("hasMeetingRoom").value = "";
		initW.document.getElementById("oldRoomAppId").value = "";
		initW.document.getElementById("roomAppId").value = "";
		initW.document.getElementById("selectedRoomName").value = "";
		initW.document.getElementById("meetingroomId").value = "";
		initW.document.getElementById("meetingroomName").value = "";
		initW.document.getElementById("needApp").value = "";
		initW.document.getElementById("roomAppBeginDate").value = "";
		initW.document.getElementById("roomAppEndDate").value = "";
		initW.document.getElementById("selectRoomType").options[0].text = "<请选择已申请会议室或录入地点>";
	}
}


//显示时间图标
function show_minical(){
	if (scheduler.isCalendarVisible()){
		scheduler.destroyCalendar();
	}else{
		scheduler.renderCalendar({
			position:"dhx_minical_icon",
			date:scheduler._date,
			navigation:true,
			handler:function(date,calendar){
				//根据选择的日期查询出申请记录
				timebutton(date);
				scheduler.setCurrentView(date);
				scheduler.destroyCalendar();
			}
		});
	}
}
		
//确定事件
function OK(){
	//如果是拖动从数据库读出的已申请的会议室,则先删除
	var meetingRoom = document.getElementById("meetingRoom").value;
	if(meetingRoom!=null && meetingRoom!="") {
		if(deleteStatusId!=null && ""!=deleteStatusId){
			var flag = confirm("您确定要修改已申请的会议室?");
			if(flag){
				var url = "?method=deleteMeetingRoomById&roomId="+deleteStatusId+"&date="+new Date();
			    request.open("GET", url, true);
			    request.onreadystatechange = function(){
			    	if (request.readyState == 4) {
				    	if (request.status == 200) {
				        	var response = request.responseText;
				        	response=response.trim();
				        	if(response==0){
				        		deleteStatusId="";//重新赋值
				        		okSetValue();//删除成功后,将值传递到调用页面
					        }else{//提示删除失败
						        alert("删除失败");
						    }
				       }else{
				       }
				   	}else{
					}
				};
			    request.send(null);
			}else{
				//点击取消,一切都得还原
				document.getElementById("meetingRoom").value="";
				document.getElementById("startDate").value="";
				document.getElementById("endDate").value="";
				deleteStatusId="";
				if(currentdate==null||""==currentdate||"undefined"==currentdate){
					currentdate=new Date();
				}
				timebutton(currentdate);
			}
		}else{
			//如果不是拖动原来的时间段,则直接将值传递到调用页面
			okSetValue();
		}
	}else{
		alert("请选择会议室和会议时间");
	}
}
		
//将值传递给调用的页面
function okSetValue(){
	var meetingRoom=document.getElementById("meetingRoom").value;
	var startDate=document.getElementById("startDate").value;
	var endDate=document.getElementById("endDate").value;
    // if(startDate < convert(new Date())){
   //   alert("开始时间不能小于系统当前时间！");
  //    return ;
   // }
    
	if(meetingRoom!=null&&meetingRoom!=""){//将会议室ID转换成会议室名称
            var url = webContextPath+"/MeetingServlet?method=getMeetingRoomById&roomId="+meetingRoom;
            var newData = {};
            Matrix.sendRequest(url,newData,function(data){
            var resultObj = isc.JSON.decode(data.data);
            var roomId = meetingRoom;//会议室ID
            var roomName = resultObj.meetRoomName;//会议室名称
            var useNeedAudit = resultObj.useNeedAudit;//使用前需要申请
            var reData = {};
            reData["roomId"]= roomId;
            reData["roomName"]=roomName;
            reData["startDate"]=startDate;
            reData["endDate"]=endDate;
            reData["useNeedAudit"]=useNeedAudit;
            Matrix.closeWindow(reData);
            });
		
	}else{
		alert("请选择会议室和会议时间");
	}
}
		
//取消事件
function Cancel(){
	
	//commonDialogClose('win123');
	scheduler.deleteEvent(old_id);//删除上一个新建的时间段
	scheduler.deleteEvent(oldRoomAppId);//删除回显的时间段
	
	if(deleteFlag){
		if(!confirm("会议室已被取消，是否不再将此会议绑定会议室？")){/** 修复GOV-3901，如果编辑一个已经选择了所登记的会议室，删除后，在'取消'时应该弹出该提示框 */
			return;
		}
		deleteFlag = false;
	}
	//commonDialogClose('win123');
	Matrix.closeWindow();
}

String.prototype.trim=function(){
	return this.replace(/(^\s*)|(\s*$)/g,"");
} 
//点击选择时间调用方法
function timebutton(date){
	var action="create";
	var meetId="";
	//格試化日期
	var time=formatDate(date);
	currentdate=date;
	var url=webContextPath+"/MeetingServlet?method=create&timepams="+time;
	var newData = {};
	//newData['timepams'] = time;
	Matrix.sendRequest(url,newData,function(data){
 if(data!=null&&data.data!=null){
 debugger;
 var jsonMeeting=data.data;
 var jsonMeetJson = JSON.parse(jsonMeeting);
	scheduler.parse(jsonMeetJson, "json");
 }

	
	});
	
   // var url = "?method=mtroomAjax&timepams="+time+"&action="+action+"&meetingId="+meetId+"&date="+new Date();
    //request.open("GET", url, true);
   // request.onreadystatechange = timebuttonFun;
   // request.send(null);    
}

var room_obj;
function timebuttonFun() {
   	if (request.readyState == 4) {
    	if (request.status == 200) {
        	var response = request.responseText;
           	var time=formatDate(currentdate);
        	var start_time = $("#start_time").val();
			var end_time = $("#end_time").val();
         	scheduler.parse(jsonMeeting, "json");
         	disableCheckBox();
         	if(room_obj){
        		document.getElementById(room_obj.getAttribute("id")).checked = true;
			}

       }
   	}
}
	   
//日期转换，将date日期转换为yyyy-mm-dd类型
function formatDate(v){
   if(typeof v == 'string') v = parseDate(v);
   if(v instanceof Date){
     var y = v.getFullYear();
     var m = v.getMonth() + 1;
     var d = v.getDate();
     var h = v.getHours();
     var i = v.getMinutes();
     var s = v.getSeconds();
     var ms = v.getMilliseconds();
     if(ms>0) return y + '-' + m + '-' + d + ' ' + h + ':' + i + ':' + s + '.' + ms;   
     if(h>0 || i>0 || s>0) return y + '-' + m + '-' + d + ' ' + h + ':' + i + ':' + s;     
     if(m<10)m = "0"+m;
     if(d<10)d = "0"+d;
     return y + '-' + m + '-' + d;     
   }
   return '';
}

//将时间字符串转换成毫秒
function getDateTimeStamp(dateStr){
	return Date.parse(dateStr.replace(/-/gi,"/"));
}

//点击会议室弹出会议室详细信息
function showMTInfo(mtId){
	var w = 500;
	var h1 = 500;//半个窗口高
	var h2 = 700;//整个窗口高
    var l = (screen.width - w)/2;
    var t = (screen.height - h2)/2;
    
   
}

function loadUE() {
	if("" != "portalRoomApp"){
		$('body').height("100%");
	}else {//二级栏目
		$('#scheduler_here').height("83%");
	}
	
		var _body = $('body').width(); //这里的判断主要是时间安排portal的周视图窄栏处理
		if (_body < 690) {
			$('body').width(1052);
		}
	
}


var save_old_section_id = "";//当拖动的蓝色区域直接删除时，要记录删除的对应的section_id
function selectMtRoom(obj, from){
	//如果是勾选
	if(document.getElementById(obj.getAttribute("id")).checked){
		//当时间为空时，勾选一个会议室，需要将其他的取消掉
		disableCheckBox();
		document.getElementById(obj.getAttribute("id")).checked = true;
	}
	
	var periodicityDates = "";
	if(window.dialogArguments){
		var p = dialogArguments.parentWin;
		if(p.document.getElementById("periodicityDates")){
			periodicityDates = p.document.getElementById("periodicityDates").value;
		}
	}
	var id_str = obj.getAttribute("id");
	id_str = id_str.split("_")[1];
	var start_time = $("#start_time").val();
	var end_time = $("#end_time").val();
	
	var convert = scheduler.date.date_to_str("%Y-%m-%d %H:%i");
	if(start_time == "" || end_time == ""){
		return false;
	}else if(convert(new Date())>start_time){
		/*
		if(periodicityDates==""){
			alert("开始时间不能小于系统当前时间!");//开始时间不能小于系统当前时间
			obj.checked = false;
		    return false;
		}*/
	}
	//校验会议室是否已经被占用了
	if(from != "timeWidget" && !checkRoomDisabled(start_time, end_time, id_str)){
		obj.checked = false;
		return false;
	}

	if(start_time != '' && end_time != ''){
		var old_section_id = "";
		var jsonDate = [{id:id_str,start_date: start_time, end_date: end_time,section_id:id_str}
		                ];
		for(var i in scheduler._events){
			if(!scheduler._events[i].createUserName && !scheduler._events[i].mtappid ){
				old_id = i;
				break;
			}
		}
		if(old_id != null && old_id != ""){
			try{
				old_section_id = scheduler._events[old_id].section_id;
			}catch(e){
				old_section_id = save_old_section_id;
			}
			//document.getElementById("room_"+old_section_id).checked = false;
			scheduler.deleteEvent(old_id);
			old_id = "";
		}
		
		if(from != "timeWidget" && obj.getAttribute("id") == ("room_"+old_section_id) &&
		 !document.getElementById(obj.getAttribute("id")).checked){
			document.getElementById("room_"+old_section_id).checked = false;
			document.getElementById("meetingRoom").value="";
			document.getElementById("startDate").value="";
			document.getElementById("endDate").value="";
			/*  下面代码会将会议通知页面的 时间和地点清空，不清楚老代码为什么要这样做，这样有问题啊
			if(window.opener || window.dialogArguments){
				var _p = window.opener || window.dialogArguments;
				if(_p.cleanMt)
					_p.cleanMt();
			}*/
			return ;
		}

		
    	var time=$("#start_time").val().substr(0,10);
    	var flag = false;
    	if(periodicityDates!=""){
        	//当是周期性会议时，需要判断当前日期 是否在周期性里面，在才显示出来
    		if(periodicityDates.indexOf(time)>-1){
        		flag = true;
    		}
    	}else{
        	flag = true;
    	}

		if(flag){
			scheduler.parse(jsonDate, "json");
			for(var i in scheduler._events){
				if(!scheduler._events[i].createUserName && !scheduler._events[i].mtappid ){
					old_id = i;
					save_old_section_id = old_id;
					break;
				}
			}
			
			document.getElementById("meetingRoom").value=id_str;
			document.getElementById("startDate").value=start_time;
			document.getElementById("endDate").value=end_time;
	
			//原来的方法保留并做修改(注销)
			if (old_id && scheduler.callEvent && scheduler.callEvent("onBeforeLightbox", [old_id])) {
				var b = scheduler._get_lightbox();
				//this.showCover(b);//去掉弹出的框
				scheduler._fill_lightbox(old_id, b);
				scheduler.callEvent("onLightbox", [old_id]);
			}
			
			//保存
			scheduler.save_lightbox();
		}
	}
	
	disableCheckBox();
	if(!document.getElementById(obj.getAttribute("id")).checked){
		document.getElementById(obj.getAttribute("id")).checked = true;
		room_obj = obj;
	}
	resetDate(start_time);
	
}

function resetDate(start_time){
	var convert = scheduler.date.date_to_str("%Y-%m-%d");
	var nowDate = convert(new Date());
	var selected_start_Date = start_time.split(" ")[0];
	//if(nowDate != selected_start_Date){
		//var interval_date = (new Date(selected_start_Date) - new Date(nowDate))/1000/60/60/24;
		timebutton(new Date(selected_start_Date.replace(/-/g,"/")));
		scheduler.setCurrentView(new Date(selected_start_Date.replace(/-/g,"/")));
	//}
}
function selectEndTime(){
Matrix.setFormItemValue('componentId','end_time');
Matrix.showWindow('TimeDialog2');
}
function selectTime(){
Matrix.setFormItemValue('componentId','start_time');
Matrix.showWindow('TimeDialog');
}
function onTimeDialogClose(time){
if(typeof(time)!='undefined')
document.getElementById('start_time').value=time;
else{
Matrix.setFormItemValue('start_time',"");
}
}
function onTimeDialog2Close(time){
if(typeof(time)!='undefined')
document.getElementById('end_time').value=time;
else{
Matrix.setFormItemValue('end_time',"");
}
}
</script>
</head>

<body onload="loadUE();init();"  width="100%" style="overflow:auto;overflow-y:hidden;background-color:#f3f3f3">
<input type="hidden" id="meetingRoom" name="meetingRoom" value="${param.meetingRoom}"/>
<input type="hidden" id="startDate" name="startDate" value="${param.startDate}"/>
<input type="hidden" id="endDate" name="endDate" value="${param.endDate}"/>
<input type="hidden" id="mtid" name="mtid"/>
<input type="hidden" id="boxid" name="boxid"/>
	
	<div id="scheduler_here" class="dhx_cal_container" style='width:100%;height:91%'>
		<div class="dhx_cal_navline" style="background-color:white">
			<div class="dhx_cal_prev_button" style=" margin-top: 3px; ">&nbsp;</div>
			<div class="dhx_cal_next_button" style=" margin-top: 3px; ">&nbsp;</div>
			<div class="dhx_cal_today_button" style="display:none;"></div>
			<div class="dhx_cal_date" style=" margin-top: 3px; "></div>
			<div class="dhx_minical_icon" id="dhx_minical_icon" onclick="show_minical()" style=" margin-top: 3px; ">&nbsp;</div><!--时间图标-->
			<div class="dhx_cal_tab" name="timeline_tab" style="right:20px; display:none;"></div>
			<div style=" margin-left: 230px;">
				开始时间:<input type="text" style=" width: 120px; " id="start_time" name="textfield" class="" onclick="selectTime();" readonly="">
				结束时间:<input type="text" style=" width: 120px; " id="end_time" name="textfield" class="" onclick="selectEndTime();" readonly="">
			<script> var Mform0=isc.MatrixForm.create({
									ID:"Mform0",
									name:"Mform0",
									position:"absolute",
									//action:"<%=request.getContextPath()%>/matrix.rform",
									canSelectText: true,
									fields:[{
										name:'form0_hidden_text',
										width:0,height:0,
										displayId:'form0_hidden_text_div'}]});
			</script>
			
<input type="hidden" name="form0" value="form0" />
<script>function getParamsForTimeDialog2(){var params='&';var value;value=null;try{value=eval("Matrix.getFormItemValue('componentId');");}catch(error){value="Matrix.getFormItemValue('componentId');"}if(value!=null){value="componentId="+value;params+=value;}return params;}isc.Window.create({ID:"MTimeDialog2",id:"TimeDialog2",name:"TimeDialog2",autoCenter: true,position:"absolute",height: "50%",width: "50%",title: "选择时间",canDragReposition: false,showMinimizeButton:false,showMaximizeButton:false,showCloseButton:true,showModalMask: false,modalMaskOpacity:0,isModal:true,autoDraw: false,headerControls:["headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"],getParamsFun:getParamsForTimeDialog2,initSrc:"<%=request.getContextPath()%>/SelectDate.rform",src:"<%=request.getContextPath()%>/SelectDate.rform",showFooter: false });</script><script>MTimeDialog2.hide();</script>
<script>function getParamsForTimeDialog(){var params='&';var value;value=null;try{value=eval("Matrix.getFormItemValue('componentId');");}catch(error){value="Matrix.getFormItemValue('componentId');"}if(value!=null){value="componentId="+value;params+=value;}return params;}isc.Window.create({ID:"MTimeDialog",id:"TimeDialog",name:"TimeDialog",autoCenter: true,position:"absolute",height: "50%",width: "50%",title: "选择时间",canDragReposition: false,showMinimizeButton:false,showMaximizeButton:false,showCloseButton:true,showModalMask: false,modalMaskOpacity:0,isModal:true,autoDraw: false,headerControls:["headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"],getParamsFun:getParamsForTimeDialog,initSrc:"<%=request.getContextPath()%>/SelectDate.rform",src:"<%=request.getContextPath()%>/SelectDate.rform",showFooter: false });</script><script>MTimeDialog.hide();</script><input id="componentId" type="hidden" name="componentId" />
</form>
			</div>
			<div style="right:25px;">
				<table>
					<tr>
						<td>图例说明：</td>
						<td width="20"><div style="width:15px;height:15px;background-color:#ffffff; border:1px solid #000;"></div></td>
						<td>空闲</td>
						<td width="20"><div style="width:15px;height:15px;background-color:#7f7f7f; border:1px solid #000;"></div></td>
						<td>已预订</td>
						<td width="20"><div style="width:15px;height:15px;background-color:#64be0f; border:1px solid #000;"></div></td>
						<td>申请中</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="dhx_cal_header"></div>
		<div class="dhx_cal_data"></div>		
	</div>
		
	<div id="roomButtomDiv" align='right' class="bg-advance-bottom" style="background-color:#f3f3f3;background-image:none;">
        <span style="font-size: 12px; margin-right: 420px;">使用说明：点击空闲区域拖动鼠标选择相应会议室及时段<td>&nbsp;提示：视图中每小格为15分钟</td></span>
		<input type="button" class="button-default-2" value="确定" onclick="OK();">
		<input type="button" class="button-default-2" value="取消" onclick="Cancel();">
	</div>
	
	<div id="resourceMsg" style="display:none"></div>
	<input type="hidden" id="roomAppId" />
	
	<div id="noRoomMsgDiv" style="text-align:center;margin-top:90px; display:none;font-size: 15px;color: #B6B6B6">
        <img style="vertical-align: middle;" src="meeting/css/images/zszx_empty.png">
        管理员还未添加会议室,请联系管理员
	</div>
	
</body>
</html>
