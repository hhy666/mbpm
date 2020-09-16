<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>

<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>editListQuery!</title>
<jsp:include page="/form/admin/common/resource.jsp" />
</head>
<script>
		/*******************************asynchronous common method begin***************************************/
	 function dataSend(data,url,method,callbackFun,errorFun) {
	    method=method?method:"POST";
      	RPCManager.sendRequest({params:data,callback:callbackFun,handleError:errorFun,httpMethod:method,actionURL:url});      
     }
	
	 function update(command){
		         var componentType = document.getElementById("componentType").value;
                 var data ="{'componentType':'"+componentType+"','command':'update'}";
                 var url = '<%=request.getContextPath()%>/formdesigner.daction';
	    	     var synJson = isc.JSON.decode(data);
	     		 dataSend(synJson,url,"POST",function(data){
	     		 },null);
		  
		  }
	
</script>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%; overflow: hidden;">
<script> var MForm0=isc.MatrixForm.create({ID:"MForm0",name:"MForm0",position:"absolute",action:"<%=request.getContextPath()%>/jsp/console/formmanager/formdesign/BasicInputText.form",fields:[{name:'Form0_hidden_text',width:0,height:0,displayId:'Form0_hidden_text_div'}]});</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/jsp/console/formmanager/formdesign/BasicInputText.form"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
<table style="border-collapse:collapse;border-spacing:0px;width: 100%; height: 100%">
	<tr>
		<td>
		<div id="tabContainer0_div" class="matrixComponentDiv"
			style="width: 100%; height: 100%;; position: relative;">
			<script> var MtabContainer0 = isc.TabSet.create({
				ID:"MtabContainer0",overflow:'auto',
				displayId:"tabContainer0_div",height: "100%",width: "100%",position: "relative",
				align: "center",tabBarPosition: "top",tabBarAlign: "left",showPaneContainerEdges: false,
				showTabPicker: true,showTabScroller: true,selectedTab: 4,
				tabBarControls : [
				],
				tabs: [ 
					{title: "单项查询",
						pane:isc.HTMLPane.create({
							ID:"MtabContainer0Panel0",height: "100%",
							overflow: "hidden",autoDraw: false,
							showEdges:false,contentsType:"page",
							contentsURL:"<%=request.getContextPath()%>/form.daction?componentType=QueryField&command=list&mode=propertyedit&level=subItem"
						})
					},
					{title: "组合查询",
						pane:isc.HTMLPane.create({
							ID:"MtabContainer0Panel3",height: "100%",
							autoDraw: false,showEdges:false,contentsType:"page",
							contentsURL:"",overflow:'auto'
						})
					},
					{title: ''}  
				] 
			});
			document.getElementById('tabContainer0_div').style.display='none';
			//MtabContainer0.selectTab(0);
			//isc.Page.setEvent("load","MtabContainer0.selectTab(0);MtabContainer0.removeTab(MtabContainer0.tabs.length-1);");
			</script>
		</div>
		<script>document.getElementById('tabContainer0_div').style.display='';
			isc.Page.setEvent(isc.EH.LOAD,
                 	function(){
                 		MtabContainer0.resizeTo(0,0);MtabContainer0.resizeTo('100%','100%');
                  },
                  null
               );
		</script>
		</td>
	</tr>
</table>
<input id="iframewindowid" type="hidden" name="iframewindowid" value="" />
</form>
<script>

//MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);

</script></div>


</body>
</html>