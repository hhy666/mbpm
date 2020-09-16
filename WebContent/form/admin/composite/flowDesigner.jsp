<%@page pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>Insert title here</title>
<style type="text/css">
	.dropdown-menu {
	    position: absolute;
	    top: 100%;
	    left: 0;
	    z-index: 1000;
	    display: none;
	    float: left;
	    min-width: 100px;
	    padding: 5px 0;
	    margin: 2px 0 0;
	    font-size: 14px;
	    text-align: left;
	    list-style: none;
	    background-color: #fff;
	    -webkit-background-clip: padding-box;
	    background-clip: padding-box;
	    border: 1px solid #ccc;
	    border: 1px solid rgba(0, 0, 0, .15);
	    border-radius: 4px;
	    -webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
	    box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
	}
	.dropdown-menu.operation> li > a:hover, .dropdown-menu.operation > li > a:focus {
	    color: #262626;
	    text-decoration: none;
	    background-color: rgba(13,179,166,.1);
	}
</style>
<script type="text/javascript">

	window.onload = function(){
		getData();
		
		//菜单栏变色变指针
		$(".flowTools").mouseover(function(){
			$(this).css("cursor","pointer");
		});
		
		$(".flowTools").mouseleave(function(){
			$(this).css("cursor","default");
		});
		
		parent.$("#content").css('display','');
		parent.$("#main").css('display','');
		//parent.$('#loading').css('display','none');
		parent.Matrix.hideMask2();
		parent.layer.close(parent.layer.load());//关闭加载层
	}
	
	//下拉框改变事件
	function changeModule(){
		//获取下拉框流程模板
		getFlowVersion();
	}
	
	//判断有无流程模板
	function getData(editType,index){
		debugger;
		var parentId1 = $('#parentId1').val();
		var json = {};
		json.parentId1 = parentId1;
		$.ajax({
			type:'post',
			url:'<%=path %>/templateAction_getFlowTemplate.action',
			data:json,
			dataType:'json',
			success:function(data){
				if(data.data=='none'){
					$('#web1').css('display','');
					$('#web2').css('display','none');
				}else{
					$('#web1').css('display','none');
					$('#web2').css('display','');
					var html = "";
					html += '<div id="templateSelect" style="height: 35px;line-height: 50px;float:left;padding-left: 20px;">';
					html += '<label style="font-size:14px;color:rgb(22, 105, 171);padding-right:10px">流程模板：</label>';
					html += '<select onchange="changeModule();" class="form-control select2-accessible" id="module" style="display:inline;text-overflow: ellipsis;overflow: hidden;width: 300px;">';
					html += '</div>';
					for(var i=0;i<data.length;i++){
						var mBizId = data[i].mBizId;
						var flowUuid = data[i].flowUuid;
						var templateName = data[i].templateName;
						html += '<option class="templateOption" value=\''+ flowUuid +'_'+ mBizId +'\'';
						if(editType=="add"){
							if(i==data.length-1){
								html += ' selected = selected';
							}
						}if(editType=="edit"){
							if(i==index){
								html += ' selected = selected';
							}
						}else{
							if(i==0){
								html += ' selected = selected';
							}
						}
						html += '>'+ templateName +'</option>';				
					}
					html += '</select>';
					$('#top').prepend(html);
					
					if(editType=="edit"){
						//表单设计器
						getFlowVersion(data[index].flowUuid);
					}else if(editType=="add"){
						getFlowVersion(data[data.length-1].flowUuid);
					}else{
						getFlowVersion(data[0].flowUuid);
					}
				}
			}
		});
	}
	
	//根据下拉框选项 获取流程设计版本
	function getFlowVersion(flowUuid){
		debugger;
		var pdid = '';
		if(flowUuid!=null&&flowUuid.trim().length>0){
			pdid = flowUuid;
		}else{
			var str = $("#module").val().split('_');
			pdid = str[0];
		}
		$('#processId').val(pdid);  //记录选中流程的编码
		
		var processType = $("#processType").val();
		var json = {};
		json.pdid = pdid;
		$.ajax({
			type:'post',
			url:'<%=path %>/templateAction_getFlowVersion.action',
			data:json,
			dataType:'json',
			success:function(data){
				if(data){
					var ptid = data.ptid; 
					var version = data.version; //版本号
					$('#version').val(version);
					//设置当前版本号
					var version = $('#version').val();
					$('#versionNum').text("(V"+ version +")");
					
					$('#content').attr('src','<%=path%>/editor/flowdesigner.jsp?pdid='+pdid+'&ptid='+ptid+'&containerType=process&containerId='+pdid+'&mode=flow&initFlag=true&processType='+processType);
				}
				
			}
		});
	}
	
	//没有流程模板时新增
	function createNew(){
		addFlowTemplate();
	}
	
	//添加流程模板
	function addFlowTemplate(){
		var formId1 = Matrix.getFormItemValue('formId1');
		var parentId1 = Matrix.getFormItemValue('parentId1');
		var formUuid = Matrix.getFormItemValue('formUuid');
		var tempCls = Matrix.getFormItemValue('tempCls');
		var startType = 0;
		var docType = Matrix.getFormItemValue('docType');
		var type = Matrix.getFormItemValue('type');
		layer.open({
			id:'addTemplateDialog',
			type : 2,
			
			title : ['新增流程模板'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '55%', '80%' ],
			content : "<%=path%>/templet/crtPro_createFlowTemplate4Id.action?formId1="+formId1+"&parentId1="+parentId1+"&formUuid="+formUuid+"&tempCls="+tempCls+"&startType="+startType+"&docType="+docType+"&type="+type,
		});
	}
	
	//添加流程模板回调
	function onaddTemplateDialogClose(data){
		if(data){
			Matrix.success('添加成功！');
			$('#web1').css('display','none');
			$('#web2').css('display','');
			//先删除再重新加载
			$("#templateSelect").remove();
			getData("add");
		}
	}
	
	//复制流程模板
	function copyFlowTemplate(){
		if($("#module").val()!=null){
			var str = $("#module").val().split('_');
			var templateId = str[1];
			var templateName = $("#module").find("option:selected").text();
			//弹出流程模板复制窗口
			layer.open({
				id:'copyFlowTemplateDialog',
				type : 2,//iframe 层
				
				title : ['流程模版复制'],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shade: [0.1, '#000'],
				shadeClose: false, //开启遮罩关闭
				area : [ '60%', '60%' ],
				content : '<%=path%>/templet/tem_toCopyFlowTemPage.action?templateId='+templateId+'&templateName='+templateName,
			});
		}else{
			Matrix.warn('流程模板为空不能复制！');
		}
	}

	//复制流程模板
	function oncopyFlowTemplateDialogClose(){
		Matrix.success('复制成功！');
		//先删除再重新加载
		$("#templateSelect").remove();
		getData();
	}
	
	//编辑流程模板
	function editFlowTemplate(){
		if($("#module").val()!=null){
			var str = $("#module").val().split('_');
			var mBizId = str[1];
			var mFlowBizId = str[1];
			var flowOrDoc = 1;
			var formUuid = Matrix.getFormItemValue('formUuid');
			layer.open({
				id:'edittheTemplateDialog',
				type : 2,
				
				title : ['编辑流程模板'],
				shade: [0.1, '#000'],
				shadeClose: false, //开启遮罩关闭
				area : [ '55%', '80%' ],
				content : "<%=path%>/templet/crtPro_editFlowTemplate4Id.action?mBizId="+mBizId+"&flowOrDoc="+flowOrDoc+"&formUuid="+formUuid+"&mFlowBizId="+mFlowBizId
		   });
		}else{
			Matrix.warn('流程模板为空不能编辑！');
		}
	}

	//编辑流程模板回调
	function onedittheTemplateDialogClose(data){
		if(data){
			Matrix.success('修改成功！');
			var index = $('#module').prop('selectedIndex');
			//先删除再重新加载
			$("#templateSelect").remove();
			getData("edit",index);		
		}
	}
	
	//删除流程模板
	function deleteTemplate(){
		Matrix.confirm("删除流程模板将删除所有相关的流程实例数据，是否继续?",function(value){
			if(true){
				if($("#module").val()!=null){
					var str = $("#module").val().split('_');
					var flowUuid = str[0];
					var templateId = str[1];
					var processId = $('#processId').val();
					var json = {};
					json.templateId = templateId;
					json.flowUuid = flowUuid;
					json.processId = processId;
					$.ajax({
						type:'post',
						url:'<%=path %>/templateAction_deleteTemplate.action',
						data:json,
						dataType:'text',
						success:function(data){
							if(data=='true'){
								Matrix.success('删除成功！');
								//先删除再重新加载
								$("#templateSelect").remove();
								getData();
							}else if(data=='zero'){//模板下没有版本则展示添加页面
								$('#web1').css('display','');
								$('#web2').css('display','none');
							}
						}
					});
				}else{
					Matrix.warn('流程模板为空不能删除！');
				}
			}
		})
	}
	
	//打开流程版本列表窗口
	function openFlowVersion(){
		var processId = $('#processId').val();
		var processType = $('#processType').val();
		layer.open({
			id:'flowVersion',
			type : 2,
			
			title : ['流程版本列表'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '45%', '55%' ],
			content : "<%=path%>/form/admin/process/h5ProcessList.jsp?iframewindowid=flowVersion&processId="+processId+"&processType="+processType
	   });
	}
	
	//流程版本列表窗口回调
	function onflowVersionClose(data){
		if(data!=null && data!=''){
			var opType = data.opType;   //操作类型
			var version = data.version;  //版本号
			$('#version').val(version);
			$('#versionNum').text("(V"+ version +")");
			
			if(opType == 'add'){
				Matrix.say('添加成功！');
			}else if(opType == 'update'){
				layer.msg('编辑流程中！');
			}else if(opType == 'copy'){
				Matrix.say('复制成功！');
			}
		}
		
	}
</script>
</head>
<body>
	<input type="hidden" id="parentId1" name="parentId1" value="${param.parentId1}">
	<input type="hidden" id="formId1" name="formId1" value="${param.formId1}">
	<input type="hidden" id="formUuid" name="formUuid" value="${param.formUuid}">
	<input type="hidden" id="tempCls" name="tempCls" value="${param.tempCls}">
	<input type="hidden" id="docType" name="docType" value="${param.docType}">
	<input type="hidden" id="type" name="type" value="${param.type}">
	<input type="hidden" id="processType" name="processType" value="${param.processType}">
	<!-- 记录的当前选中流程的编码-->
	<input type="hidden" id="processId" name="processId" value="">
	<input type="hidden" name="version" id="version">
	<!-- <iframe id="content" style="width: 100%;height: 100%" src=""></iframe> -->
	<div id="web1" style="width: 100%;height: 100%;text-align: center;display: none;">
		<img src="<%=path %>/image/flow_chart_empty.jpg" style="width: 300px;height: 200px;margin: 70px auto 0;"/>
		<div style="padding:38px 0 12px">绘制上图所示流程图，设定数据流转方式，即可搭建线上工作流</div>
		<input type="button" class="x-btn ok-btn " value="新建" style="width:110px;height: 36px" onclick="createNew()">
	</div>
	<div id="web2" style="position: absolute;width: 100%;height: 100%;display: none;">
		<div id="top" style="height: 50px;width:85%;margin:10px auto;border:1px solid rgb(231, 234, 236);background:white;box-shadow:0 2px 4px 0 rgba(0,0,0,.08)">
			<div id="toolbar" style="float:right;padding-top: 2px;display: -webkit-inline-box;">
				<div style="height: 35px;line-height: 50px;">
					<label style="color:rgb(22, 105, 171);font-size: 14px;cursor: pointer;" onclick="openFlowVersion()">版本<span id="versionNum" style="color:rgb(252, 182, 51) "></span></label>
				</div>
				<ul class="nav" style="padding-top: 10px;">
					<li class="dropdown">					  
		               <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" style="color:black;">
		               		<label style="vertical-align: middle;cursor: pointer;font-size: 14px;color:rgb(22, 105, 171);">操作&nbsp;</label><span><img class="imgButton" tabindex="0" src="<%=path %>/image/test1.jpg" style="height: 15px; width: 15px;"></span>
		               </a>
		               <ul class="dropdown-menu operation">
		                <li><a href="#" onclick="addFlowTemplate()">添加</a></li>
		                <li><a href="#" onclick="copyFlowTemplate()">复制</a></li>          
		                <li><a href="#" onclick="editFlowTemplate()">修改</a></li>	           
		                <li><a href="#" onclick="deleteTemplate()">删除</a></li>
		               </ul>
		            </li>
	            </ul>
			</div>
		</div>
		<div style="margin:auto;margin-top:10px;width:85%;height: calc(100% - 80px);background:white;box-shadow:0 2px 4px 0 rgba(0,0,0,0.16), 0 2px 8px 0 rgba(0,0,0,0.12)";>
			<iframe id="content" style="border:1px solid rgb(231, 234, 236);width:100%;height:100%;" frameborder="0" src="">
			</iframe>
		</div>
	</div>
</body>
</html>