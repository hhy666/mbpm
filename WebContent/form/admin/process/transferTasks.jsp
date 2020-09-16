<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
	<html>
		<head>
			<meta charset='utf-8'/>
			<link href='<%=path %>/resource/html5/css/style.min.css' rel="stylesheet"></link>
			<link href='<%=path %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
			<link href='<%=path %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
			<link href='<%=path %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
			<link href='<%=path %>/resource/html5/css/flat/blue.css' rel="stylesheet"></link>
			<link href='<%=path %>/resource/html5/css/square/blue.css' rel="stylesheet"></link>
			<link href='<%=path %>/resource/html5/css/bootstrap-select.css' rel="stylesheet"></link>
			<link href='<%=path %>/resource/html5/css/select2.css' rel="stylesheet"></link>
			<link href='<%=path %>/resource/html5/css/clockpicker.css' rel="stylesheet"></link>
			<link href='<%=path %>/resource/html5/css/filecss.css' rel="stylesheet"></link>
			<link href='<%=path %>/resource/html5/assets/bootstrap-table/src/bootstrap-table.css'	rel="stylesheet"></link>
			<link href='<%=path %>/resource/html5/css/google-code-prettify/bin/prettify.min.css' rel="stylesheet"></link>
			<link href='<%=path %>/resource/html5/css/custom.css' rel="stylesheet"></link>
			<link href='<%=path %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
			<link rel='stylesheet' href='<%=path %>/resource/html5/themes/default/style.min.css'/>
			<SCRIPT SRC='<%=path %>/resource/html5/js/jquery.min.js'></SCRIPT>
			<SCRIPT SRC='<%=path %>/resource/html5/js/matrix_runtime.js'></SCRIPT>
			<SCRIPT SRC='<%=path %>/resource/html5/js/filejs.js'></SCRIPT>
			<script src='<%=path %>/resource/html5/js/suggest/bootstrap-suggest.min.js'></script>

		</head>
<script type="text/javascript">
		function selectSendUser(){
				layer.open({
			    	id:'layerCreate',
					type : 2,//iframe 层 
					
					title : ['选择交接人'],
					closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '50%', '85%' ],
					content : '<%=request.getContextPath()%>/office/html5/select/SingleSelectPerson.jsp?iframewindowid=layerSend',
				});
			}
		function onlayerSendClose(data){
      		if(data!=null){
      		var names = data.names;
      		var ids = data.ids;
      		document.getElementById('popupSelectDialog001').value=names;
      		document.getElementById('sendPerson').value=ids;
      		}else{
      		//document.getElementById('input001').value='11';
      		}
      	}
		
		function selectReceiveUser(){
			layer.open({
		    	id:'layerCreate',
				type : 2,//iframe 层 
				
				title : ['选择接收人'],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '50%', '85%' ],
				content : '<%=request.getContextPath()%>/office/html5/select/SingleSelectPerson.jsp?iframewindowid=layerReceive',
			});
		}
		function onlayerReceiveClose(data){
	  		if(data!=null){
	  		var names = data.names;
	  		var ids = data.ids;
	  		document.getElementById('popupSelectDialog002').value=names;
	  		document.getElementById('receivePerson').value=ids;
	  		}else{
	  		//document.getElementById('input001').value='11';
	  		}
	  	}
</script>
<body>

<div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;zoom:1;padding:10px 10px;" id="context">
<form id="form0" name="form0" eventProxy="Mform0" method="post" action="#" style="margin:0px;position:relative;overflow:auto;width:80%;height:100%;margin-left:10%;" enctype="application/x-www-form-urlencoded">
<input type="hidden" name="form0" value="form0" />
<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<div class="col-md-12" id="TitlePanel001_div"  style="width:100%;;position:relative;padding-right: 1px;padding-left: 1px; ">
     <div class="ibox float-e-margins  " style="width:100%;height:100%;">
          <div class="ibox-title"><h5>工作交接 </h5><div class="ibox-tools">
     </div>
 </div>
 <div class="ibox-content"  style=" min-height:300px;">
   <table id="table001" class="tableLayout" style="width:100%;"><tr id="tr001"><td id="td001" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label001" name="label001" id="label001" class="control-label ">
交接人：</label></td>
<td id="td002" class="tdLayout" style="width:60%;">
<div class="col-md-12 input-group " style="width:70%">
<input id="popupSelectDialog001"  type="text" class="form-control has-feedback-right " style=" width:100%;height:100%;" />
<input id="sendPerson" name="transferUserId" type="hidden">
<span class="input-group-addon addon-udSelect udSelect" onclick="selectSendUser()">
	<i class="fa fa-search" aria-hidden="true" ></i>
</span>
</div>
</td>
</tr>
<tr id="tr002"><td id="td003" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label002" name="label002" id="label002" class="control-label ">
接受人：</label></td>
<td id="td004" class="tdLayout" style="width:60%;">
<div class="col-md-12 input-group " style="width:70%">
<input id="popupSelectDialog002" type="text" class="form-control has-feedback-right " style=" width:100%;height:100%;" />
<input id="receivePerson" name="transferTargetUserId" type="hidden">
<span class="input-group-addon addon-udSelect udSelect"  onclick="selectReceiveUser()">
	<i class="fa fa-search" aria-hidden="true"></i>
</span>
</div>
 </td>
</tr>
<tr id="tr004" ><td id="td007" class="tdLayout " colspan="2" rowspan="1" align="center" style="border: none; " >
	<button type="button"  id="button001" class="x-btn ok-btn " >提交</button>
	
	<script>
		$('#button001').click(function(){
			var send = $('#sendPerson').val();
			var receive = $('#receivePerson').val();
			if(send == "" || receive == ""){
				alert("请选择交接人和接受人！");
				return;
			}else{
				if(send == receive){
					alert("交接人和接受人不能相同！");
				}else{
					
					$.ajax({
							url:'<%=request.getContextPath() %>/process/processTmplAction_transferTasks.action',
							data:$('#form0').serialize(),
							type:'post',
							dataType:'text',
							error:function(request){
								alert("任务交接失败！");
							},
							success:function(data){
								alert("任务交接成功！");
							}
						});
				}
			}
		});
		
		
		$('#button002').click(function(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		});
	</script></td>
</tr>

</table>
    </div> </div>
    </div>
  </div>


</form></div>
<SCRIPT SRC='<%=path %>/resource/html5/js/jquery.inputmask.bundle.min.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/css/bootstrap/dist/js/bootstrap.min.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/icheck.min.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/bootstrap-select.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/select2.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/content.min.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/layer.min.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/autosize.min.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/laydate/laydate.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/clockpicker.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js'></SCRIPT>
 <SCRIPT SRC='<%=path %>/resource/html5/js/jquery.hotkeys/jquery.hotkeys.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/css/google-code-prettify/src/prettify.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/validator.js'></SCRIPT>
<script src='<%=path %>/resource/html5/js/jstree.min.js'></script>
<script src='<%=path %>/resource/html5/assets/bootstrap-table/src/bootstrap-table.js'></script>

</body>
</html>
