<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>内容</title>

<link rel="stylesheet" href="<%=request.getContextPath() %>/xmleditor/lib/codemirror.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/xmleditor/addon/hint/show-hint.css">
<script src="<%=request.getContextPath() %>/xmleditor/lib/codemirror.js"></script>
<script src="<%=request.getContextPath() %>/xmleditor/addon/hint/show-hint.js"></script>
<script src="<%=request.getContextPath() %>/xmleditor/addon/selection/active-line.js"></script>
<script src="<%=request.getContextPath() %>/xmleditor/addon/hint/xml-hint.js"></script>
<script src="<%=request.getContextPath() %>/xmleditor/mode/xml/xml.js"></script>


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
				if(document.activeElement.id=='contentStr'){
					var xmlContent = document.getElementById('contentStr');
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

      function callbackFun(data){
			  isc.say(data.data);
      } 
      
      //保存实体内容
      function saveEntityContent(){
      	document.getElementById("saveAndPublish").value = "false";
      	var content = document.getElementById('contentStr').value;
      	document.getElementById("contentStr").value = editor.getValue();
      	
      	 Matrix.send("Form0",null,callbackFun);
      } 
      //保存并发布实体内容
      function saveAndPublishEntityContent(){
      	   document.getElementById("saveAndPublish").value = "true";
      	   parent.isc.confirm("保存并发布该查询对象?",confirmCallback);
      }
      
      function confirmCallback(data){
      	if(data){
	      	document.getElementById("contentStr").value = editor.getValue();
      		 Matrix.send("Form0",null,callbackFun);
      	}
      }
      
      //初始化表单内容[根据配置信息]
      function initEntityContent(){
	      var  form0 = document.getElementById("Form0");
	      var url = "entity/entityContent_initMybatisContent.action";
	      form0.action = url;
	      form0.submit();
     
      }
      
      function initCallback(data){
      
      
         var callbackData = data.data;
       	 if(callbackData!=null){
        	var jsonData = isc.JSON.decode(callbackData);
        	if(jsonData.message){//初始化成功
        	  var textArea =document.getElementById("contentStr");
        	 var initContent = jsonData.initContent;
        	  var formatText = initContent.replaceAll(">",">\n");
        	  textArea.value=formatText;
        	}else{
        		parent.isc.warn('初始化异常!');
        	}
        
        }
      	
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
	 		action:"entity/entityContent_updateEntityContent.action",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	  });
</script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
				action="entity/entityContent_updateEntityContent.action" style="margin:0px;height:100%;" 
				enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
<!-- commom cols -->
<input id="entityUuid" type="hidden" name="entityUuid" value="${entityContent.entityUuid}"/>
<input id="uuid" type="hidden" name="uuid" value="${entityContent.uuid}"/>
<input id="type" type="hidden" name="type" value="${entityContent.type}"/>
<input id="resourceType" type="hidden" name="resourceType" value="${entityContent.resourceType}"/>
<input id="fileLocation" type="hidden" name="fileLocation" value="${entityContent.fileLocation}"/>
<input type="hidden" id="gridListName" name="gridListName" />
<input type="hidden" id="entity" name="entity" value="${requestScope.entity}"/><!-- 实体全路径-->
<input type="hidden" id="mid" name="mid" value="${mid}"/><!-- 实体编码1 -->
<!-- 标识保存和保存按钮操作 -->
<input type="hidden" id="saveAndPublish" name="saveAndPublish" />

  
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" 
		style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<table id="dataTable" jsId="dataTable" cellpadding="0px" cellspacing="0px" style="width:100%;height:100%;">
	<tr id="j_id2" jsId="j_id2">
		
		<td id="j_id4" jsId="j_id4" class="Toolbar" colspan="4" rowspan="1"
			style="border-style: none;">
			<script>
			     	isc.ToolStripButton.create({
			     		ID:"MToolBarItem4",
			icon:Matrix.getActionIcon("save"),
			     		title: "初始化",
			     		showDisabledIcon:false,
			     		showDownIcon:false 
			     	});
			     	MToolBarItem4.click=function(){
			     		Matrix.showMask();
			     
					initEntityContent();
		  			Matrix.hideMask();
			     	return;
			     }
			       </script> 
			       
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
					saveEntityContent();
		  			Matrix.hideMask();
			     	return;
			     }
			       </script> 
			       
			       <script>
			        isc.ToolStripButton.create({
			        		ID:"MToolBarItem5",
			        		icon:Matrix.getActionIcon("save_hd"),
			        		title: "保存并发布",
			        		showDisabledIcon:false,
			        		showDownIcon:false
			         });
			         MToolBarItem5.click=function(){
			         	Matrix.showMask();
			         	   saveAndPublishEntityContent();
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
			 		    		   			   MToolBarItem4,
			 		    		   			   MToolBarItem6,
			 		    		   			   MToolBarItem5
			 		    		   		 ]
			 		    		     });
			 		    		 
			 		    		   		 isc.Page.setEvent(isc.EH.RESIZE,"Mj_id5.resizeTo(0,0);Mj_id5.resizeTo('100%','100%');",null);
			 		    		   		</script></div>
		</td>
		
	</tr>
	<tr id="j_id7" jsId="j_id7">
		
		<td id="j_id9" jsId="j_id9" colspan="3" rowspan="1"
			style="border-style: none; width: 100%; height: 100%"><!-- 在此添加文本域 -->
		
			<textarea id="content" name="content" rows="" cols="" >${contentStr}</textarea>
			
			<textarea id="contentStr" style="widht:0px;height:0px;" name="contentStr" rows="" cols="" ></textarea>
		</td>
	</tr>
</table>
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
       mode: "application/xml",
  styleActiveLine: true,
  lineNumbers: true,
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