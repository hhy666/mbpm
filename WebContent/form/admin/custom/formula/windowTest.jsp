<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<jsp:include page="/foundation/common/taglib.jsp" />
	<jsp:include page="/foundation/common/resource.jsp" />
	<script type="text/javascript">
		function showWindow(){
			var setType = document.getElementById("setType").value;
			if(setType=='0'){ //普通设置
				var content = document.getElementById("formulaSet").value;
				Mtest.initSrc = "<%=request.getContextPath()%>/formula/formula_loadNormalSet.action?content="+content;
				Mtest.src = "<%=request.getContextPath()%>/formula/formula_loadNormalSet.action?content="+content;
			}else{  //高级设置
				Mtest.initSrc = "<%=request.getContextPath()%>/form/admin/custom/formula/betweenLayer.jsp"
				Mtest.src = "<%=request.getContextPath()%>/form/admin/custom/formula/betweenLayer.jsp"
			}
			Matrix.showWindow('test');
		}
		function ontestClose(data){
			if(data!=null){
				if(data.setType=='0'){
					document.getElementById("formulaSet").value = data.conditionText ;
					document.getElementById("formulaSetId").value = data.conditionVal;
				}
				if(data.setType=='1'){
					var formulaSet = JSON.stringify(data.conditionText);
					var formulaSetId = JSON.stringify(data.conditionVal);
					document.getElementById("formulaSet").value = "【高级设置】" ;
					document.getElementById("formulaSetId").value = formulaSetId ;
				}
				document.getElementById("setType").value = data.setType;
			}
		}
	</script>
  </head>
  
  <body>
    <input type="button" onclick="showWindow();" value="弹出窗口" />
    <input name="formulaSet" id="formulaSet" type="text" onclick="showWindow();" />
    <input name="formulaSetId" id="formulaSetId" type="hidden" />
    <input name="setType" id="setType" type="hidden" value="0" /> <!-- 0 为普通设置，1为高级设置 -->
    
    <script>
		isc.Window.create( {
			ID : "Mtest",
			id : "test",
			name : "test",
			autoCenter : true,
			position : "absolute",
			height : "84%",
			width : "48%",
			canDragReposition : true,
			showMinimizeButton : false,
			showMaximizeButton : true,
			showCloseButton : true,
			showModalMask : false,
			modalMaskOpacity : 0,
			isModal : true,
			autoDraw : false,
			headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
					"maximizeButton", "closeButton" ],
			showFooter : false
		});
		</script>
		<script>
			Mtest.hide();
		</script>
  </body>
</html>
