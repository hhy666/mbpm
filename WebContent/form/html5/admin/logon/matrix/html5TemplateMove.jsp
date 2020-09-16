<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset='utf-8' />
<%@ include file="/form/html5/admin/html5Head.jsp"%>
</head>
<body>

	<div
		style="width: 100%; height: 100%; overflow: auto; position: relative; margin: 0 auto; zoom: 1; padding: 10px 10px;"
		id="context">
		<form id="form0" name="form0" eventProxy="Mform0" method="post"
			action="<%=request.getContextPath()%>/templet/tem_templateMove.action"
			style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
			enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="form0" value="form0" />
			<div type="hidden" id="form0_hidden_text_div"
				name="form0_hidden_text"
				style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
			<table id="table001" class="tableLayout" style="width: 100%;">
				<tr id="tr0021">
					<td id="td0031" class="tdLayout"
						style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)"><label
						id="label0021" name="label0021" id="label0021"
						class="control-label "> 目标路径：</label></td>
					<td id="td0041" class="tdLayout" style="width: 60%;">
						<div id="input0021_div" class="input-group col-md-12 "
							style="display: inline-table; vertical-align: middle; width: 80%;">
							<input id="popupSelectDialog001" name="popupSelectDialog001"
								type="text" class="form-control has-feedback-right "
								style="width: 100%; height: 100%;" readonly="readonly"/> 
							<span
								class="input-group-addon addon-udSelect udSelect" onclick="showDialog();"> 
								<i class="fa fa-search" " aria-hidden="true"></i>
							</span>
						</div> 
						<script>
							function showDialog() {
								var templateType = $('#templateType').val();//公文还是协同
								layer.open({
							    	id:'dir',
									type : 2,//iframe 层
									
									title : ['选择目标目录'],
									closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
									shadeClose: false, //开启遮罩关闭
									area : [ '50%', '90%' ],
									content : '<%=request.getContextPath()%>/form/html5/admin/logon/matrix/html5TemplateSelectTree.jsp?isCopyTime=1&templateType='+ templateType+'&iframewindowid=dir'
								});
							}
							//选择目录窗口关闭回调
							function ondirClose(data){
								$('#popupSelectDialog001').val(data.pathStr);
								$('#parentId').val(data.id);
							}
						</script>
					</td>
				</tr>
				<tr id="tr004">
					<td id="td007" class="cmdLayout" colspan="2" rowspan="1">
						<button type="button" id="button001" class="x-btn ok-btn ">保存</button>
						<button type="button" id="button002" class="x-btn cancel-btn ">取消</button>

						<input id="parentId" type="hidden" name="parentId"  /> 
						<input id="id" type="hidden" name="id" value="${param.nodeid }">
						<input id="templateType" type="hidden" name="templateType" value="${param.templateType }">
						<script>
							$('#button001')
									.click(
											function() {
												parent.document.getElementById('maskDiv').style.display='block';
												$('#form0').submit();
											});

							$('#button002').click(
									function() {
										var index = parent.layer
												.getFrameIndex(window.name);
										parent.layer.close(index);
									});
						</script>
					</td>
				</tr>

			</table>

		</form>
	</div>
</body>
</html>
