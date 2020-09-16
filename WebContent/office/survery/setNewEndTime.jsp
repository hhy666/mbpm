<%@page pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.commonservice.data.DataService"%>
<%@page import="java.util.List"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.matrix.api.identity.*"%>
<%@page import="java.util.Map"%>
<%@page import="com.matrix.office.investigation.common.CommonHelper"%>
<!DOCTYPE HTML>

<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<title>设置结束时间</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
</head>	
<body>
<div style="width: 100%; height: 100%; overflow: auto; position: relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post" action=""
	style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" value="form0" /> 
	<input type="hidden" id="invesInfoId" name="invesInfoId" value="${param.invesInfoId }"/>
	<table id="table001" class="tableLayout" style="width: 100%;">
		<tr id="tr001">
			<td id="td001" class="maintain_form_label" style="width: 25%;">
				<label id="label001" name="label001" class="control-label"> 结束日期：</label>
			</td>
			<td id="td002" class="tdLayout" style="width:75%;">
				<div id="inputDate001_div" class="date-default-width col-md-12  input-prepend input-group" style="vertical-align: middle;width: 100%">
				<input id="inputDate001" name="inputDate001" class="form-control layer-date  " autocomplete="off" style="width:100%;height:100%;padding-left: 5px;" onclick="if(document.getElementById('inputDate001').readOnly == false){laydate({istime:false, format: 'YYYY-MM-DD hh:mm:ss'})}">
				<span class="input-group-addon addon-udSelect udSelect" id="inputDate001_btn"><i class="fa fa-calendar"></i></span>
			    </div>
			</td>
		</tr>
		<tr id="tr002">
			<td id="td007" class="cmdLayout" colspan="2" rowspan="1">
					<button type="button" id="button001" class="x-btn ok-btn ">确认</button>
					<button type="button" id="button002" class="x-btn cancel-btn ">取消</button>	
	<script type="text/javascript">
	//开启调查
	$('#button001').click(function(){
		document.getElementById('button001').disabled = true;
		var invesInfoId = Matrix.getFormItemValue("invesInfoId");
		if(invesInfoId!=null && invesInfoId.length>0 && invesInfoId!='null'){
			var endTimeStr = document.getElementById('inputDate001').value;
			var endTime = new Date(endTimeStr);
			if(endTime!=null && endTime.getTime() && endTime!='null'){
				var url = "<%=path%>/investigation/investigation_startInvestigation.action";
				var synJson = isc.JSON.decode("{'invesInfoId':'"+invesInfoId+"','endTime':'"+endTime.getTime()+"'}");
				Matrix.sendRequest(url,synJson,function(data){
					document.getElementById('button001').disabled = false;
					if(data){
						if(data.data!= null && data.data!=''){
							var result = isc.JSON.decode(data.data);
							if(result.result){
								//提交按钮隐藏
		  						var submitBtn = window.parent.document.getElementById("submit");
		  						if(submitBtn!=null){
		  							submitBtn.style.display="";
		  						}
		  						//结束调查按钮隐藏
		  						var overInves = window.parent.document.getElementById("overInves")
		  						if(overInves!=null){
			  						overInves.style.display="";
		  						}
		  						//开启调查按钮显示
		  						var startInves = window.parent.document.getElementById("startInves");
		  						if(startInves!=null){
		  							startInves.style.display="none";
		  						}
		  						//调查已经结束
		  						var font = window.parent.document.getElementById("font");
		  						if(font!=null){
		  							font.style.display="none";
		  						}
		  						var joinFont = window.parent.document.getElementById("joinFont");
		  						if(joinFont!=null){
		  							font.style.display="";
		  						}
		  						//刷新父窗口  关闭当前窗口
		  						window.parent.location.href = window.parent.location.href;
		  						window.close();
							}
						}
					}
				});
	
			}else{
				document.getElementById('button001').disabled = false;
				Matrix.warn("请选择结束日期!");
				return false;
			}
		}else{
		   //没有传递过invesInfoId来
		   document.getElementById('button001').disabled = false;
			Matrix.warn("系统异常，请联系管理员！");
			return false;
		}
		return true;
	});
	
	$('#button002').click(function() {
		 var index = parent.layer.getFrameIndex(window.name);
		 parent.layer.close(index);
	});

</script>			
			</td>
		</tr>
		<tr id="tr003">
			<td id="td004" class="tdLayout" colspan="2" style="width: 100%;text-align:center;">
				<label id="label002" name="label002" id="label002" style="color:red;">开启后的调查结果将与原调查结果合并，您确定重新开放调查吗？</label>
			</td>
		</tr>
	</table>
</form>
</div>
</body>

</html>
