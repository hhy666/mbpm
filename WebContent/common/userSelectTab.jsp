<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>三标签单选人员</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<style>
			font{
				font-size:14px;
				margin-left:10px;
				font-weight:bold;
			}
			#td001{
				width:100%;
				height:30px;
				background:#dedede;
			}
			#td002{
				width:100%;
				height:94%;
			}
		</style>
		
		<script type="text/javascript">
		/*
			var select = {};
			//确认
 			function saveUser(){
    			if(select!=null && select.userId!=null){
            		Matrix.closeWindow(select);
        		}else{
               		Matrix.warn("请选择人员！");
                    return false;
        		}
   			}
   		*/
		</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
 var MForm0=isc.MatrixForm.create({
 				ID:"MForm0",
 				name:"MForm0",
 				position:"absolute",
 				action:"/form",//
 				fields:[{
 					name:'Form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'Form0_hidden_text_div'
 				}]
  });
  </script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
	<input name="version" id="version" type="hidden">
	<input type="hidden" id="opt" name="opt" value="1"/>
	<input type="hidden" id="iframewindowid" name="iframewindowid" value="${param.iframewindowid }">
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0 top: 0; left: 0; display: none;"></div>
<table id="table001" class="tableLayout" style="width:100%;height:100%">
	
	<tr id="tr002">
		<td id="td002" class="tdLayout" style="height:94%">
<div id="tabContainer0_div" class="matrixComponentDiv"
	style="width: 100%; height: 100%;; position: relative;">
	
	<script> 
		var MtabContainer0 = isc.TabSet.create({
				ID:"MtabContainer0",
				displayId:"tabContainer0_div",
				height: "100%",
				width: "100%",
				position: "relative",
				align: "center",
				tabBarPosition: "top",
				tabBarAlign: "left",
				showPaneContainerEdges: false,
				showTabPicker: true,
				showTabScroller: true,
				selectedTab: 2,
				tabBarControls : [
					isc.MatrixHTMLFlow.create({
						ID:"MtabContainer0Bar0",
						width:"30px",
						contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
					})
				 ],
				 tabs: [ 
				 	{
				 	title: "按部门",
				 		pane:isc.HTMLPane.create({
				 		ID:"MtabContainer0Panel0",height: "100%",
				 		overflow: "hidden",
				 		autoDraw: false,
				 		showEdges:false,
				 		click:"Matrix.setFormItemValue('opt',1);",
				 		contentsType:"page",
				 		contentsURL:""})
				 	},{
				 	title: "按角色",
				 		pane:isc.HTMLPane.create({
				 		ID:"MtabContainer0Panel1",height: "100%",
				 		overflow: "hidden",
				 		autoDraw: false,
				 		showEdges:false,
				 		click:"Matrix.setFormItemValue('opt',3);",
				 		contentsType:"page",
				 		contentsURL:""})
				 	},{
				 	title: "按人员",
				 		pane:isc.HTMLPane.create({
				 		ID:"MtabContainer0Panel2",height: "100%",
				 		overflow: "hidden",
				 		autoDraw: false,
				 		showEdges:false,
				 		click:"Matrix.setFormItemValue('opt',4);",
				 		contentsType:"page",
				 		contentsURL:""})
				 	}
				  ] 
		});
	document.getElementById('tabContainer0_div').style.display='none';MtabContainer0.selectTab(0);
	isc.Page.setEvent("load","MtabContainer0.selectTab(0);");
	</script>
</div>
</td>
	</tr>
</table>
<div id="tabContainer0Bar0_div2" style="text-align: right" class="matrixInline"></div>
<script>
document.getElementById('tabContainer0Bar0_div').appendChild(document.getElementById('tabContainer0Bar0_div2'));
	//flag  1：按部门选择  2 按角色选择 3 按人员选择
	MtabContainer0Panel0.setContentsURL('orgSelectUserPage.jsp?selectType=single&iframewindowid=${param.iframewindowid}');
	MtabContainer0Panel1.setContentsURL('roleSelectUserPage.jsp?selectType=single&iframewindowid=${param.iframewindowid}');
	MtabContainer0Panel2.setContentsURL('<%=request.getContextPath()%>/select/user_queryUserInfoList.action?selectType=single&iframewindowid=${param.iframewindowid}');
	document.getElementById('tabContainer0_div').style.display='';
</script>
</form>
<script>
	MForm0.initComplete=true;MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>


</div>

</body>
</html>