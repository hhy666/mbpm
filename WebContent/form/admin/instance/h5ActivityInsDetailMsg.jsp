<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
	<script>
		window.onload = function(){
			var activityInsBiid = document.getElementById('activityInsBiid').value;
			if(activityInsBiid!=null && activityInsBiid.trim().length()>0){
				document.getElementById('j_id4').style.display="";
				document.getElementById('j_id9').style.display="";
			}
		}
	</script>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
</head>
<body>
	<form id="Form0" name="Form0" method="post"  action="" style="margin: 0px; height: 100%;overflow: auto" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
	<input type="hidden" id="activityInsBiid" name="activityInsBiid" value="${activityIns.biid}"/>
	<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
	<div style="text-valign: center; position: relative ;top:5px;height: 100%">
		<table id="j_id3" jsId="j_id3" class="maintain_form_content" style="height:100%">
			<tr id="j_id4" jsId="j_id4">
				<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
					rowspan="1" style="width: '20%';height:7%"><label
					id="j_id6" name="j_id6" style="margin-left: 10px"> 活动实例编码：</label>
				</td>
				<td id="j_id7" jsId="j_id7" class="maintain_form_input insRight" style="height:7%" colspan="1" rowspan="1">
					${actInsId}
				</td>
			</tr>
			<tr id="j_id9" jsId="j_id9">
				<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
					rowspan="1" style="width: '20%';height:7%">
					<label id="j_id11" name="j_id11" style="margin-left: 10px"> 活动名称：</label></td>
				<td id="j_id12" jsId="j_id12" class="maintain_form_input insRight" style="height:7%" colspan="1" rowspan="1">
					${actInsName}
				</td>
			</tr>
		
			<tr id="j_id14" jsId="j_id14">
				<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%';height:7%">
				<label id="j_id16" name="j_id16" style="margin-left: 10px"> 描述：</label>
				</td>
				<td id="j_id17" jsId="j_id17" class="maintain_form_input insRight" style="height:7%" colspan="1" rowspan="1">
					${actInsDesc}
				</td>
			</tr>
			<tr id="j_id114" jsId="j_id114">
					<td id="j_id115" jsId="j_id115" class="maintain_form_label" colspan="1" rowspan="1">
						<label id="j_id116" name="j_id116" style="margin-left:10px">流程实例编码：</label>
					</td>
					<td id="j_id117" jsId="j_id117" class="maintain_form_input insRight" style="height:7%" colspan="1" rowspan="1">
						
					${actInsPiid}
					  
					  </td>
				</tr>
				
			<tr id="j_id20" jsId="j_id20">
				<td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%';height:7%"><label
					id="j_id22" name="j_id22" style="margin-left: 10px"> 流程名称：</label></td>
				<td id="j_id23" jsId="j_id23" class="maintain_form_input insRight" style="height:7%" colspan="1"
					rowspan="1">
				${processName}
				
			</td>
			</tr>
				<tr id="j_id4" jsId="j_id4" style="display: none;">
					<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
						rowspan="1" style="width: '20%';height:7%"><label
						id="j_id6" name="j_id6" style="margin-left: 10px"> 活动集编码：</label>
					</td>
					<td id="j_id7" jsId="j_id7" class="maintain_form_input insRight" style="height:7%" colspan="1" rowspan="1">
					${activityIns.biid}
					</td>
				</tr>
				<tr id="j_id9" jsId="j_id9" style="display: none;">
					<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
						rowspan="1" style="width: '20%';height:7%">
						<label id="j_id11" name="j_id11" style="margin-left: 10px"> 活动集名称：</label></td>
					<td id="j_id12" jsId="j_id12" class="maintain_form_input insRight" style="height:7%" colspan="1" rowspan="1">
						${activityIns.blockName}
					</td>
				</tr>
			<tr id="j_id4" jsId="j_id4">
				<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
					rowspan="1" style="width: '20%';height:7%"><label
					id="j_id6" name="j_id6" style="margin-left: 10px"> 启动方式：</label>
				</td>
				<td id="j_id7" jsId="j_id7" class="maintain_form_input insRight" style="height:7%" colspan="1" rowspan="1">
				${actStartMode}
				</td>
			</tr>
			<tr id="j_id9" jsId="j_id9">
				<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
					rowspan="1" style="width: '20%';height:7%">
					<label id="j_id11" name="j_id11" style="margin-left: 10px"> 完成方式：</label></td>
				<td id="j_id12" jsId="j_id12" class="maintain_form_input insRight" style="height:7%" colspan="1" rowspan="1">
					${actFinishMode}
				</td>
			</tr>
			
		
			<tr id="j_id14" jsId="j_id14">
				<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%';height:7%">
				<label id="j_id16" name="j_id16" style="margin-left: 10px"> 活动类型：</label>
				</td>
				<td id="j_id17" jsId="j_id17" class="maintain_form_input insRight" style="height:7%" colspan="1" rowspan="1">
				${actTypeStr }
				</td>
			</tr>
			<tr id="j_id114" jsId="j_id114">
					<td id="j_id115" jsId="j_id115" class="maintain_form_label" colspan="1" rowspan="1">
						<label id="j_id116" name="j_id116" style="margin-left:10px">状态：</label>
					</td>
					<td id="j_id117" jsId="j_id117" class="maintain_form_input insRight" style="height:7%" colspan="1" rowspan="1">
						${actStatus}
					  </td>
				</tr>
				
			<tr id="j_id20" jsId="j_id20">
				<td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%';height:7%"><label
					id="j_id22" name="j_id22" style="margin-left: 10px"> 优先级：</label></td>
				<td id="j_id23" jsId="j_id23" class="maintain_form_input insRight" style="height:7%" colspan="1"
					rowspan="1">
				${actPriority }
			</td>
			</tr>
			
			<tr id="j_id4" jsId="j_id4">
				<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
					rowspan="1" style="width: '20%';height:7%"><label
					id="j_id6" name="j_id6" style="margin-left: 10px"> 启动人：</label>
				</td>
				<td id="j_id7" jsId="j_id7" class="maintain_form_input insRight" style="height:7%" colspan="1" rowspan="1">
				${actStarter}
				</td>
			</tr>
			<tr id="j_id9" jsId="j_id9">
				<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
					rowspan="1" style="width: '20%';height:7%">
					<label id="j_id11" name="j_id11" style="margin-left: 10px"> 启动时间：</label></td>
				<td id="j_id12" jsId="j_id12" class="maintain_form_input insRight" style="height:7%" colspan="1" rowspan="1">
					${actStartedDate}
				</td>
			</tr>
			
			<tr id="j_id43" jsId="j_id43">
				<td id="j_id53" jsId="j_id53" class="maintain_form_label" colspan="1"
					rowspan="1" style="width: '20%';height:7%"><label
					id="j_id63" name="j_id63" style="margin-left: 10px"> 最后修改时间：</label>
				</td>
				<td id="j_id73" jsId="j_id73" class="maintain_form_input insRight" style="height:7%" colspan="1" rowspan="1">
				${actLastModifiedDate}
				</td>
			</tr>
			<tr id="j_id93" jsId="j_id93">	
				<td id="j_id103" jsId="j_id103" class="maintain_form_label" colspan="1"
					rowspan="1" style="width: '20%';height:7%">
					<label id="j_id11" name="j_id11" style="margin-left: 10px"> 完成时间：</label></td>
				<td id="j_id1233" jsId="j_id1233" class="maintain_form_input insRight" style="height:7%" colspan="1" rowspan="1">
					${actCompletedDate}
				</td>
			</tr>
		</table>
	</div>
</body>
</html>