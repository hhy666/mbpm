<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil" %>
	<%  
		int curPhase = CommonUtil.getCurPhase();

	%>
<html>
<head>

<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<title>添加权限范围基础信息</title>
<script type="text/javascript">
	//保存权限范围基本信息
	function saveSecScopeBasic(){
		var name = Matrix.getMatrixComponentById("name2").getValue();
		if(name==undefined||name.replace(/\s/g, "")==""||name==null){
			isc.warn("名称不能为空!");
			return false;
		}
		var desc = Matrix.getMatrixComponentById("desc").getValue();
		var uuid = document.getElementById("uuid").value;		  
		var preScopeName = document.getElementById("preScopeName").value;
		var formUuid = document.getElementById("formUuid").value;
		var oType = document.getElementById("oType").value;
		if(desc==null)desc="";
		var submitJsonData = {'name':name,'desc':desc,'formUuid':formUuid};
		var curPhase = "<%=curPhase%>";
		if(oType=="update"){
			if(curPhase=="2"){//设计开发
				submitJsonData.uuid = preScopeName;
				submitJsonData.formUuid = formUuid;
			}else{
				submitJsonData.uuid = uuid;
				submitJsonData.formUuid = formUuid;
			}
		}
		
		var validJson = {'data':submitJsonData};
		//if(curPhase=="2"){//设计开发
			var modulePath = document.getElementById("modulePath").value;	
			validJson.modulePath = 	modulePath;
		//}
		
		
		//异步校验
	    var url = "<%=request.getContextPath()%>/security/formSecScope_validateScopeName.action";
		
			dataSend(validJson, url, "POST",function(data){
					var backData = data.data;
					
					if(backData!=null){
						var jsonData = isc.JSON.decode(backData);
						//服务端添加成功
						if(jsonData.message=='true'){
						
						 // Matrix.closeWindow(submitJsonData, oType);
						  var iframewindowid = document.getElementById('iframewindowid').value;
			        	   var closeFunction = eval("parent.on"+iframewindowid+"Close");
			        	   parent.layer.close(parent.layer.getFrameIndex(window.name));
			        	   closeFunction(submitJsonData,oType);
						  
						}else if(jsonData.message=='repeat'){
							isc.warn("授权范围名称重复!");
		    	 			return false;
						}else{
							isc.warn("数据异常!");
		    	 			return false;
						}
						
					}
					
				
			} ,null);
		
	
	}
</script>

</head>
<body>
	<input type="hidden" id="iframewindowid" name="iframewindowid" value="${iframewindowid}">
		
<%

com.matrix.form.test.render.PropertiesRender render2 = new com.matrix.form.test.render.PropertiesRender();
	String content = render2.render(request, response);
	out.print(content);	
%>


</body>
</html>