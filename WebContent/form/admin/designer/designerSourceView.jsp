<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link rel="stylesheet" href="<%=request.getContextPath() %>/form/admin/designer/xmleditor/lib/codemirror.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/form/admin/designer/xmleditor/addon/hint/show-hint.css">
<script src="<%=request.getContextPath() %>/form/admin/designer/xmleditor/lib/codemirror.js"></script>
<script src="<%=request.getContextPath() %>/form/admin/designer/xmleditor/addon/hint/show-hint.js"></script>
<script src="<%=request.getContextPath() %>/form/admin/designer/xmleditor/addon/hint/xml-hint.js"></script>
<script src="<%=request.getContextPath() %>/form/admin/designer/xmleditor/mode/xml/xml.js"></script>
<script src="<%=request.getContextPath() %>/form/admin/designer/xmleditor/addon/selection/active-line.js"></script>

<title>表单源码视图</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
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

<script type="text/javascript">
	
	isc.Page.setEvent(isc.EH.KEY_PRESS,function(){
			var _key = isc.Event.getKey();
			if(_key=="Tab"){
				if(document.activeElement.id=='content'){
					var xmlContent = document.getElementById('content');
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
	    
	

	  //异步保存回调函数
      function callbackSaveFormModel(data){
      		var callStr = data.data;
      		if(callStr!=null){
      			var callJson = isc.JSON.decode(callStr);
      			var msg = callJson.message;
      			if(msg==true){
      				parent.isc.say("保存成功!",{title:'提示消息'});
      			}else if(msg=='encodingException'){
      				parent.isc.warn("数据转换异常!");
      			}else if(msg==false){
      				parent.isc.warn("保存时异常!");
      			}
      		}else{
      		    parent.isc.warn("保存失败!");
      		}
      } 
      
      
      
      //保存表单实体  走默认的action
      function saveFormModelInSView(){
        
        var  form0 =  document.getElementById("Form0");
        document.getElementById("modelXmlContent").value = editor.getValue();
     	form0.action = "<%=request.getContextPath()%>/form/formInfo_saveModelInSourceView.action";
      	 Matrix.send("Form0",null,callbackSaveFormModel);
      } 
      
      //同步模型 回调函数
      function callbackPreviewFormModel(data){
      	var callStr = data.data;
      		if(callStr!=null){
      			var callJson = isc.JSON.decode(callStr);
      			if(callJson.message==true){
      				parent.isc.say("模型同步成功!",{title:'提示消息'});
      			}else{
      				parent.isc.say("数据准备失败!");
      			}
      		}else{
      		    parent.isc.say("获取数据时异常!");
      		}
      
      
      }
      
      //源码模式下 同步模型
      function synFormModelInSView(){
      	  var  form0 =  document.getElementById("Form0");
     	  form0.action = "<%=request.getContextPath()%>/form/formInfo_synModelInSourceView.action";
      	 Matrix.send("Form0",null,callbackPreviewFormModel);
      }
     
	</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>

<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
<script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"MForm0",
	 		position:"absolute",
	 		action:"<%=request.getContextPath()%>/form/formInfo_saveModelInSourceView.action",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	  });
</script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
				action="<%=request.getContextPath()%>/form/formInfo_saveModelInSourceView.action" 
				style="margin:0px;height:100%;" 
				enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
<!-- commom cols -->
<input id="formUuid" type="hidden" name="formUuid" value="${requestScope.formUuid}"/>

  
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" 
		style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;"></div>

			
			       
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
					saveFormModelInSView();
		  			Matrix.hideMask();
			     	return;
			     }
			       </script> 
			       
			       <script>
			        isc.ToolStripButton.create({
			        		ID:"MToolBarItem5",
			        		icon:Matrix.getActionIcon("sync_model"),
			        		showDisabledIcon:false,
			        		showDownIcon:false
			         });
			         MToolBarItem5.click=function(){
			         	Matrix.showMask();
			         	   synFormModelInSView();
			         	Matrix.hideMask();
			         	return false;
			         	
			         }
			     </script>
<table style="width:100%;height:100%;">
<tr>
<td style=" height:25px;">			     
	<div id="j_id5_div" style="width:100%;overflow: hidden;z-index:99999;">
		<script>
			 isc.ToolStrip.create({
			 	ID:"Mj_id5",
			 	displayId:"j_id5_div",
			 	vertical: false,
			 	width: 36,
			 	height:"100%",
			 	members:[ 
				 	MToolBarItem6
//				 	MToolBarItem5
			 	]
			 });
			 
			 var isPublished = "${requestScope.isPublished}";
			 if(isPublished=="true"){//已经发布禁用操作
				 MToolBarItem6.setDisabled (true);
				 MToolBarItem5.setDisabled (true);
			 }
			 		    		 
			 isc.Page.setEvent(isc.EH.RESIZE,"Mj_id5.resizeTo(0,0);Mj_id5.resizeTo('100%','100%');",null);
		</script>
	</div>
</td>	
</tr>
<tr>	
<td style="width:100%;">
			<textarea id="content" name="content"  rows="" cols="" >${modelXmlContent}</textarea>
</td>
</tr>
</table>              
			
		
	

	<textarea style="width:0px;height:0px;display:none;" id="modelXmlContent" name="modelXmlContent"  rows="" cols="" ></textarea>

</form>
<script>
	MForm0.initComplete=true;
	MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
	
	
	
</script>


<script>

    var dummy = {
        attrs: {
          
          description: null
        },
        children: []
      };

      var tags = {
        "table": ["table"],
        "!attrs": {
          id: null,
          name: null,
		  style:null,
		  styleClass:null
        },
        table: {
          attrs: {
            lang: ["en", "de", "fr", "nl"],
            freeform: null
          },
          children: ["tr", "td"]
        },

        table: dummy, tr: dummy, td: dummy
      };

      function completeAfter(cm, pred) {
        var cur = cm.getCursor();
        if (!pred || pred()) setTimeout(function() {
          if (!cm.state.completionActive)
            cm.showHint({completeSingle: false});
        }, 100);
        return CodeMirror.Pass;
      }

      function completeIfAfterLt(cm) {
        return completeAfter(cm, function() {
          var cur = cm.getCursor();
          return cm.getRange(CodeMirror.Pos(cur.line, cur.ch - 1), cur) == "<";
        });
      }

      function completeIfInTag(cm) {
        return completeAfter(cm, function() {
          var tok = cm.getTokenAt(cm.getCursor());
          if (tok.type == "string" && (!/['"]/.test(tok.string.charAt(tok.string.length - 1)) || tok.string.length == 1)) return false;
          var inner = CodeMirror.innerMode(cm.getMode(), tok.state).state;
          return inner.tagName;
        });
      }

      var editor = CodeMirror.fromTextArea(document.getElementById("content"), {
        mode: "xml",
        lineNumbers: true,
        styleActiveLine: true,
  lineWrapping: true,
        extraKeys: {
          "'<'": completeAfter,
          "'/'": completeIfAfterLt,
          "' '": completeIfInTag,
          "'='": completeIfInTag,
          "Ctrl-Space": "autocomplete"
        },
        hintOptions: {schemaInfo: tags}
      });
      
</script>

	</div>

</body>
</html>