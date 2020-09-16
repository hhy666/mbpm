<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>编辑多活动实例</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<script type="text/javascript">
		//弹出选择流程变量窗口
		function openpopupSelectDialog1(){
			var phase = '<%= session.getAttribute("matrix_phaseId")%>';
			if(phase == '4'){ //实施阶段	弹出源自变量的部门选择窗口
				 parent.openDeptLayer2(this);     //loadBasicActivityTreeNodePage.jsp弹出
			}else{
				 parent.openVariables8(this);     //loadBasicActivityTreeNodePage.jsp弹出
			}
		}
	</script>
</head>
<body>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
 <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/editor/editor_saveMultiActIns.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input name="uuid" id="uuid" type="hidden" value="${param.uuid }"/>
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input name="add" id="add" type="hidden" value="${param.add }"/>
	<input name="index" id="index" type="hidden" value="${param.index }"/>
	<table id="table001" class="tableLayout" style="width:100%;" >
		<tr id="tr107" name="tr107">
			<td id="td107" name="td107" class="tdLabelCls" colspan="1" style="width:25%;text-align:center;">
				变量名：
			</td>
			<td id="td108" name="td108" class="tdLabelCls" colspan="1" style="width:75%;">
				<div id="input002_div" class="input-group">
					 <input type="text" id="input002" name="input002" value="${name}"  class="form-control" readonly="readonly">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog1();"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr001">
			<td id="td001" class="tdLabelCls" style="width:25%;text-align:center;">
				<label id="label001" name="label001" id="label001">
					分隔符：
				</label>
			</td>
			<td id="td002" class="tdLabelCls" style="width:75%;">
				<div id="input001_div" class="input-group" style="width:100%;">
					 <input type="text" id="input001" name="input001" value="${seperatFlag=='null'?'':seperatFlag}"  class="form-control">
				</div>
			</td>
		</tr>
		<tr>
			<td class="cmdLayout" colspan="2" style="width:100%;text-align:center;">
				<input type="button" class="x-btn ok-btn" name="确定" value="确定" id="submit" >
				<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="btn" >
				<script type="text/javascript">
			        $(".ok-btn").on("click",function(){
			        	var variableId = Matrix.getFormItemValue("input002");
						var token = Matrix.getFormItemValue("input001");
						var add = Matrix.getFormItemValue('add');
						var index = Matrix.getFormItemValue('index');
						
						if(variableId==null||variableId==''||variableId=='undefined'){
							Matrix.warn("变量名称不能为空!");
							return false;
						}
						if(token==null||token==''||token=='undefined'){
							Matrix.warn("分隔符不能为空!");
							return false;
						}
						var data = {};
						data.add = add;
						data.index = index;
						data.variableId = variableId;
						data.token = token;
						
						if(data!=null){
							Matrix.closeWindow(data);
						}		
			        });
			        
			        $(".cancel-btn").on("click",function(){
			        	Matrix.closeWindow();
			        })
				</script>
			</td>
		</tr>
	</table>
  </form>
 </div>
</body>
</html>