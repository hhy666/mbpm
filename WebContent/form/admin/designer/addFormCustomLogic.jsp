<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML >
<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>自定义逻辑服务</title>
	<jsp:include page="/form/admin/common/taglib.jsp" />
	<jsp:include page="/form/admin/common/resource.jsp" />

<script type="text/javascript">

		function convertJsonData(){
			//var opType =parent.MDialog0.opType;
			var opType ="${param.opType}";
	   		var eventType = document.getElementById("eventType").value;//服务类
	    	var ajaxEventType = document.getElementById("ajaxEventType").value;//服务类
            var service =Matrix.getMatrixComponentById("service").getValue();
            var content =document.getElementById("content").value;
            var data=null;
          
            if(opType!=null&&opType=="add"){//添加
            
           	 data = {'name':service,'service':service,'content':content,'ajaxEventType':ajaxEventType,'type':'custom','eventType':eventType};//自定义逻辑类型为4
            
            }else  if(opType!=null&&opType=="update"){
           		 var type = document.getElementById("type").value;
              	  data = {'name':service,'service':service,'content':content,'eventType':eventType,'ajaxEventType':ajaxEventType,'type':type};
            }
           
           return data;
        }
	
	</script>
</head>
<body>
	<jsp:include page="/form/admin/common/loading.jsp"/>
	<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%; overflow: auto">
<script> 
var MForm0=isc.MatrixForm.create({
			ID:"MForm0",
			name:"MForm0",
			position:"absolute",
			action:"",
			fields:[{name:'Form0_hidden_text',width:0,height:0,displayId:'Form0_hidden_text_div'}]
		});</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
		<input type="hidden" id="eventType" name="eventType" value="${param.eventType}" />
	<input type="hidden" id="ajaxEventType" name="ajaxEventType" value="${param.ajaxEventType}" />
	<input type="hidden" name="type" id="type" value="${operation.type}" />
	<input id="iframewindowid" type="hidden" name="iframewindowid" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>

<table id="j_id2" jsId="j_id2" class="maintain_form_content" style="width:100%;height:100%;">

	<tr id="j_id3" jsId="j_id3">
		<td id="j_id4" jsId="j_id4" class="maintain_form_label" style="width: 20%;height:30px;">
			<label id="j_id5" name="j_id5"
				style="margin-left: 10px"> 名&nbsp;&nbsp;&nbsp;&nbsp;称：</label>
		</td>
		
		<td id="j_id6" jsId="j_id6" class="maintain_form_input">
		<div id="service_div" eventProxy="MForm0" class="matrixInline" style="float:left"></div>
		<script> 
		var service=isc.TextItem.create({
					ID:"Mservice",
					name:"service",
					editorType:"TextItem",
					displayId:"service_div",
					position:"relative",
					width:320,
					required:true,
					value:"${operation.service}"==""?"处理逻辑":"${operation.service}"
				});
				MForm0.addField(service);
				</script>
				<span id="MultiLabel0" style="width: 20px; height: 20px; color: #FF0000; font-weight:blod;">*</span>
		 </td>
	</tr>
	<tr id="j_id8" jsId="j_id8">
		<td id="j_id9" jsId="j_id9" class="maintain_form_label" >
			<label id="j_id10" name="j_id10"
			style="margin-left: 10px;"> 内&nbsp;&nbsp;&nbsp;&nbsp;容：</label>
		</td>
		
		<td class="maintain_form_input" style="height:90%;">
	
		 <textarea id="content" name="content" rows="" cols=""  style="width:100%;height:100%;line-height:20px;border:1px;">${operation.content}</textarea>
		 				
		 </td>
	</tr>
	<tr >
		<td class="maintain_form_command" style="margin-bottom:2px;"
			colspan="2" >
			
		<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;width: 100px; height: 22px;">
			<script>
			isc.Button.create({
					ID:"MdataFormSubmitButton",
					name:"dataFormSubmitButton",
					title:"保存",
					displayId:"dataFormSubmitButton_div",
					position:"absolute",
					top:0,
					left:0,
					width:"100%",
					height:"100%",
					icon:Matrix.getActionIcon("save"),
					showDisabledIcon:false,
					showDownIcon:false,
					showRollOverIcon:false
			});
			MdataFormSubmitButton.click=function(){
			Matrix.showMask();
			if(!MForm0.validate()){
				Matrix.hideMask();
				 return false;
			}
			//组织数据
			var data = convertJsonData();
			Matrix.closeWindow(data);
            Matrix.hideMask();
            };</script></div>
		<div id="dataFormCancelButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;">
			<script>
			isc.Button.create({
					ID:"MdataFormCancelButton",
					name:"dataFormCancelButton",
					title:"关闭",
					displayId:"dataFormCancelButton_div",
					position:"absolute",
					top:0,left:0,width:"100%",height:"100%",
					icon:Matrix.getActionIcon("exit"),
					showDisabledIcon:false,
					showDownIcon:false,
					showRollOverIcon:false
					});
					MdataFormCancelButton.click=function(){
						Matrix.showMask();
						Matrix.closeWindow();
						Matrix.hideMask();
					};
					</script>
				</div>
		</td>
	</tr>
</table>

</form>
<script>MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script></div>

</body>
</html>