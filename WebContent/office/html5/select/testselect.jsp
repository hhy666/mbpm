<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
	<script src='<%=path %>/resource/html5/js/layer.min.js'></script>

  </head>
     <!-- Bootstrap -->
    <link href="<%=path %>/css/bootstrap.min.css" rel="stylesheet">
   <link href="<%=path %>/resource/html5/css/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="<%=path %>/resource/html5/css/custom.min.css" rel="stylesheet">
   
<body style="background-color:#ffffff;">
<div class="col-md-5">
					<input type="search" class="form-control has-feedback-right" id="search" placeholder="Search"/>
	  				<span class="fa fa-search form-control-feedback right" id="query" aria-hidden="true"></span>
				</div>
<table style="width:100%;">
<tr>
  <td class="tdLayout2" style="width:30%;text-align:right;padding-right:20px;">
 	 <label class="control-label">申请部门：</label></td>
 <td class="tdLayout2">
 <input type="text" class="form-control" id="input001" name="input001" placeholder="请选择部门"> </input>
 <input type="hidden" id="ids" name="ids"/>
 </td>
 </tr>
 <tr>
  <td class="tdLayout2" style="width:30%;text-align:right;padding-right:20px;">
 	 <label class="control-label">多选部门：</label></td>
 <td class="tdLayout2">
 <input type="text" class="form-control" id="input002" name="input002" placeholder="请选择部门"> </input>
 <input type="hidden" id="ids2" name="ids2"/>
 </td>
 </tr>
  <tr>
  <td class="tdLayout2" style="width:30%;text-align:right;padding-right:20px;">
 	 <label class="control-label">单选用户：</label></td>
 <td class="tdLayout2">
 <input type="text" class="form-control" id="input003" name="input003" placeholder="请选择用户"> </input>
 <input type="hidden" id="ids3" name="ids3"/>
 </td>
 </tr>
  <tr>
  <td class="tdLayout2" style="width:30%;text-align:right;padding-right:20px;">
 	 <label class="control-label">多选用户：</label></td>
 <td class="tdLayout2">
 <input type="text" class="form-control" id="input004" name="input004" placeholder="请选择用户"> </input>
 <input type="hidden" id="ids4" name="ids4"/>
 </td>
 </tr>
 
 <tr>
  <td class="tdLayout2" style="width:30%;text-align:right;padding-right:20px;">
 	 <label class="control-label">选择角色：</label></td>
 <td class="tdLayout2">
 <input type="text" class="form-control" id="input005" name="input005" placeholder="请选择角色"> </input>
 <input type="hidden" id="ids5" name="ids5"/>
 </td>
 </tr>
 </table>
	<script>
	function onlayer01Close(data){
	if(data!=null){
	var names = data.names;
	var ids = data.ids;
	document.getElementById('input001').value=names;
	document.getElementById('ids').value=ids;
	}else{
	//document.getElementById('input001').value='11';
	}
	}
	function onlayer02Close(data){
	if(data!=null){
	var names = data.names;
	var ids = data.ids;
	document.getElementById('input002').value=names;
	document.getElementById('ids2').value=ids;
	}else{
	//document.getElementById('input001').value='11';
	}
	}
	function onlayer03Close(data){
	if(data!=null){
	var names = data.names;
	var ids = data.ids;
	document.getElementById('input003').value=names;
	document.getElementById('ids3').value=ids;
	}else{
	//document.getElementById('input001').value='11';
	}
	}
	function onlayer04Close(data){
	if(data!=null){
	var names = data.names;
	var ids = data.ids;
	document.getElementById('input004').value=names;
	document.getElementById('ids4').value=ids;
	}else{
	//document.getElementById('input001').value='11';
	}
	}
	
	function onlayer05Close(data){
	if(data!=null){
	var names = data.names;
	var ids = data.ids;
	document.getElementById('input005').value=names;
	document.getElementById('ids5').value=ids;
	}else{
	//document.getElementById('input001').value='11';
	}
	}
	
		!function() {

		//关于
			$('#input001').on('click', function() {
			    var pageii = layer.open({
			    id:'layer01',
				type : 2,
				
				title : ['请选择'],
				closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '300px', '500px' ],
				content : 'SingleSelectDep.jsp?iframewindowid=layer01'
			});
		
			});
	$('#input002').on('click', function() {
			    var pageii = layer.open({
			    id:'layer02',
				type : 2,
				
				title : ['请选择'],
				closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '800px', '600px' ],
				content : 'MultiSelectDep.jsp?iframewindowid=layer02'
			});
		
			});
				$('#input003').on('click', function() {
			    var pageii = layer.open({
			    id:'layer03',
				type : 2,
				
				title : ['请选择'],
				closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '800px', '600px' ],
				content : 'SingleSelectPerson.jsp?iframewindowid=layer03'
			});
		
			});
				$('#input004').on('click', function() {
			    var pageii = layer.open({
			    id:'layer04',
				type : 2,
				
				title : ['请选择'],
				closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '800px', '600px' ],
				content : 'MultiSelectPerson.jsp?iframewindowid=layer04'
			});
		
			});
			//选择角色 onclick事件
			$('#input005').on('click', function() {
			    var pageii = layer.open({
				    id:'layer05',
					type : 2,
					
					title : ['请选择'],
					closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '800px', '600px' ],
					content : 'SingleSelectRole.jsp?iframewindowid=layer05'
				});
			});
		}();
	</script>
	

</body>
</html>
