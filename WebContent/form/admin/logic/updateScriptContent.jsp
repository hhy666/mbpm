<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>内容</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
	<script type="text/javascript">
      function callbackFun(data){
		isc.say(data.data);
      }  
      
 
	isc.Page.setEvent(isc.EH.KEY_PRESS,function(){
			var _key = isc.Event.getKey();
			if(_key=="Tab"){
				if(document.activeElement.id=='modelXmlContent'){
					var xmlContent = document.getElementById('modelXmlContent');
					var start = xmlContent.selectionStart, end = xmlContent.selectionEnd;
					if(start==null||end==null||isNaN(start)||isNaN(end)){
						return false;
					}
			        var text = xmlContent.value;
			        var tab = '    ';
				    text = text.substr(0, start) + tab + text.substr(start);
					
			        xmlContent.value = text;
			        xmlContent.selectionStart = start + tab.length;
			        xmlContent.selectionEnd = end + tab.length;
				}
			
				return false;
			}
	    });
	</script>
	
	<style type="text/css">
		textarea{
			width:100%;
			height:100%;
			line-height:20px;
			border:1px solid BBBBBB;
			border-top:0px;
			padding-left:5px;
		
		}
	
	
	</style>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>

<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
<script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"MForm0",
	 		position:"absolute",
	 		action:"./",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	  });
</script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
				action="./logic/logicContent_updateLogicContent.action" style="margin:0px;height:100%;" 
				enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
<!-- commom cols -->

<input type="hidden" id="logicUuid" name="logicUuid" value="${logicContent.logicUuid}"/>
<input type="hidden" id="uuid" name="uuid" value="${logicContent.uuid}"/>
<input type="hidden" id="resourceType" name="resourceType" value="${logicContent.resourceType}"/>
<input type="hidden" id="fileLocation" name="fileLocation" value="${logicContent.fileLocation}"/>

<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" 
		style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;"></div>
<table id="dataTable" jsId="dataTable" cellpadding="0px" cellspacing="0px" style="width:100%;height:100%;">
	<tr id="j_id2" jsId="j_id2">
		
		<td id="j_id4" jsId="j_id4" class="Toolbar" colspan="4" rowspan="1"
			style="border-style: none;">
			<script>
			     	isc.ToolStripButton.create({
			     		ID:"MToolBarItem6",
			icon:Matrix.getActionIcon("save"),
			     		title: "保存",
			     		showDisabledIcon:false,
			     		showDownIcon:false 
			     	});
			     	MToolBarItem6.click=function(){
			     		Matrix.showMask();
			     		
					if(!MForm0.validate()){
						Matrix.hideMask();
				   		 return false;
					}
					
					Matrix.convertFormItemValue('Form0');
		  			Matrix.send("Form0",null,callbackFun);//异步保存
		  			Matrix.hideMask();
			     	return;
			     }
			       </script> 
			       
			       <script>
			        isc.ToolStripButton.create({
			        		ID:"MToolBarItem5",
			        		icon:Matrix.getActionIcon("delete"),
			        		title: "清空",
			        		showDisabledIcon:false,
			        		showDownIcon:false
			         });
			         MToolBarItem5.click=function(){
			         	Matrix.showMask();
			         	var textArea = document.getElementById("modelXmlContent");
			         	
				        textArea.value="";
				       
			         	Matrix.hideMask();
			         	return false;
			         	
			         }
			     </script>
			     <script>
			        isc.ToolStripButton.create({
			        		ID:"MToolBarItem4",
			        		icon:Matrix.getActionIcon("save_hd"),
			        		title: "格式化",
			        		showDisabledIcon:false,
			        		showDownIcon:false
			         });
			         MToolBarItem4.click=function(){
			         	Matrix.showMask();
				       
			         	Matrix.hideMask();
			         	return false;
			         	
			         }
			     </script>
		<div id="j_id5_div" style="width: 100%; overflow: hidden;"><script>
			 		    		   	isc.ToolStrip.create({
			 		    		   		ID:"Mj_id5",
			 		    		   		displayId:"j_id5_div",
			 		    		   		width: "100%",
			 		    		   		height: "*",
			 		    		   		position: "relative",members:[ 
			 		    		   			    MToolBarItem5,
			 		    		   			    MToolBarItem4,
			 		    		   				MToolBarItem6
			 		    		   		 ]
			 		    		     });
			 		    		 
			 		    		   		 isc.Page.setEvent(isc.EH.RESIZE,"Mj_id5.resizeTo(0,0);Mj_id5.resizeTo('100%','100%');",null);
			 		    		   		</script></div>
		</td>
		
	</tr>
	<tr id="j_id7" jsId="j_id7">
		
		<td id="j_id9" jsId="j_id9" colspan="4" rowspan="1"
			style="border-style: none; width: 100%; height: 100%"><!-- 在此添加文本域 -->
		<div id="modelXmlContent_div" eventProxy="MForm0" class="matrixInline"
			style="width: 100%;height:100%;">
			<textarea id ="modelXmlContent" name="modelXmlContent" rows="" cols="">${contentStr}</textarea>
			
			</div>

			
		</td>
	</tr>
</table>
</form>
<script>
  
	MForm0.initComplete=true;
	MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>

	</div>

</body>
</html>