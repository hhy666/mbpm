<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>单选人员</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<style type="text/css">
	#td102{
		background:#dedede;
		text-align:center;
	}
	#table101{
		/**border:3px #dedede solid;*/
	}
	#td103{
		width:35%;
		height:100%;
		border:3px #dedede solid;
	}
	#td104{
		width:65%;
		height:100%;
		border:3px #dedede solid;
	}
	/**表格的背景色**/
	
	
</style>
		<script type="text/javascript">
		//单击选中
		function getSelection(){
			var select = MDataGrid004.getSelection();
			if(select!=null && select.length>0){
				parent.select = select[0];
			}
		}
		//双击选择
		function doubleClick2Select(record){
			if(record!=null){
				var userNode = parent.document.getElementById('userId');
				if(userNode!=null){
					userNode.value = record.userId;
				}
				record.clientId = document.getElementById('clientId').value;
				record.id = document.getElementById('id2').value;
				Matrix.closeWindow(record);
				
			}else{
				Matrix.warn("您选择的数据不存在!");
			}
			
		}
		var select = {};
			//确认
 			function saveUser(){
    			if(select!=null && select.userId!=null){
					select.clientId = document.getElementById('clientId').value;
					select.id = document.getElementById('id2').value;
            		Matrix.closeWindow(select);
        		}else{
               		Matrix.warn("请选择人员！");
                    return false;
        		}
   			}
		
		//---------------键盘监听事件-----开始-----------------
		isc.Page.setEvent(isc.EH.KEY_PRESS,function(){
        	var _key = isc.Event.getKey();
        	if(_key=="Enter" && MQueryField002==MQueryField002.form.getFocusItem()){
         	   MtoolBarItem002.click();
       		}
    	});
		//---------------键盘监听事件-----结束-----------------
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
 				action:"",
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
	<input name="version" id="version" type="hidden"/>
	<input name="clientId" id="clientId" type="hidden"  value="${param.clientId}"/>
	<input name="id2" id="id2" type="hidden" value="${param.id}"/>
	<input type="hidden" id="iframewindowid" name="iframewindowid" value="${param.iframewindowid }"/>
	<input type="hidden" id="X-Requested-With" name="X-Requested-With" value="XMLHttpRequest">
	<!-- dataGridId必须有 -->
	<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid004"/>
	<!-- 子页面的隐藏字段 -->
	
	
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0 top: 0; left: 0; display: none;"></div>
	<table id="table001" class="tableLayout" style="width:100%;height:100%;">
	<tr>
		<td id="td103" name="td103" style="width:35%;height:94%">
		<div class="main" style="width:100%;height:100%;">
    		<iframe id="main_iframe" src="userSelectTab.jsp?selectType=single&iframewindowid=${param.iframewindowid }" style="width:100%;height:100%;" frameborder="0"></iframe>
    	</div>
		</td>
	
	<tr>
	<td id="td004" class="cmdLayout" style="width:100%;height:30px;text-align:center;" colspan="2">
		<div id="button003_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
				<script>isc.Button.create({
								ID:"Mbutton003",
								name:"button003",
								title:"确认",
								displayId:"button003_div",
								position:"absolute",
								top:0,left:0,
								width:"100%",
								height:"100%",
								showDisabledIcon:false,
								showDownIcon:false,
								showRollOverIcon:false
							});
							Mbutton003.click=function(){
									Matrix.showMask();
									var x = eval("saveUser();");
									if(x!=null && x==false){
										Matrix.hideMask();
										Mbutton003.enable();
										return false;
									}
									Matrix.hideMask();
								};
				</script>
		</div>
		<div id="button004_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
			<script>isc.Button.create({
						ID:"Mbutton004",
						name:"button004",
						title:"关闭",
						displayId:"button004_div",
						position:"absolute",
						top:0,left:0,
						width:"100%",
						height:"100%",
						showDisabledIcon:false,
						showDownIcon:false,
						showRollOverIcon:false
					});
					Mbutton004.click=function(){
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
<script>
	MForm0.initComplete=true;MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>


</div>

</body>
</html>