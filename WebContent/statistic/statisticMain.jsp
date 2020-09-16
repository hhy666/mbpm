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
<script type="text/javascript">
	
	window.onload = function(){
		$('#web2').css('display','');
		parent.Matrix.hideMask2();
		parent.layer.close(parent.layer.load());//关闭加载层
		getData();
	}
	
	
	//判断有无查询设置  有则加载初始化下拉框  无则显示添加界面
	function getData(type){
		var templateId = $('#templateId').val();
		var json = {};
		json.templateId = templateId;
		$.ajax({
			type:'post',
			url:'<%=path %>/statistic/statisticAction_getStatisticList.action',
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
					for(var i=0;i<data.length;i++){
						var id = data[i].id;
						var mBizId = data[i].mBizId;
						var name = data[i].name;
						html += '<option value=\''+mBizId+'\'';
						//新添加时则跳转到新添加的统计模型
						if(type=='create'){
							if(i==data.length-1){
								html += ' selected = selected';
							}
						}else{
							if(i==0){
								html += ' selected = selected';
							}
						}
						html += '>'+ name +'</option>';				
					}
					$('#statisticSelect').empty();
					$('#statisticSelect').append(html);
					if(type=='create'){
						getStatisticContent(data[data.length-1].mBizId,data[data.length-1].type);
					}else{
						getStatisticContent(data[0].mBizId,data[0].type);
					}
				}
			}
		});
	}
	
	//根据下拉框选项 获取内容页
	function getStatisticContent(mBizId,type){
		var templateId = $('#templateId').val();
		var formId = $('#formId').val();
		$('#diagramId').val(mBizId);
		$('#content').attr('src','<%=path%>/statistic/statisticAction_statisticContent.action?mBizId='+mBizId+'&type='+type+'&formId='+formId+'&templateId='+templateId);
	}
	
	//新建统计模型
	function createStatistic(){
		var templateId = $('#templateId').val();
		var formId = $('#formId').val();
		layer.open({
			id:'CreateStatistic',
			type : 2,
			
			title : ['新建统计模型'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '40%' ],
			content : "<%=path%>/statistic/statisticCreate.jsp?iframewindowid=CreateStatistic&templateId="+templateId+"&formId="+formId
		});
	}
	
	//新建统计模型回调
	function onCreateStatisticClose(data){		
		if(data!=null){
			$('#web1').css('display','none');
			$('#web2').css('display','');
			Matrix.success('添加成功!');
			getData("create");
			//getStatisticContent(data.mBizId,data.type);
		}
	}
	
	//保存
	function save(){
		var formId = $('#formId').val();
		var windowDom = $("#content")[0].contentWindow;
		var alias = windowDom.$('#alias').val();
		var name = windowDom.$('#name').val();
		var expressions = windowDom.$('#expressions').val();
		var expressionsId = windowDom.$('#expressionsId').val();
		var dynamicCondititon = windowDom.$('#dynamicCondititon').val();
		var dynamicCondititonId = windowDom.$('#dynamicCondititonId').val();
		var measureIds = windowDom.$('#measureIds').val();
		var diagramId = windowDom.$('#diagramId').val();
		var description = windowDom.$('#description').val();
		var colorStyle = windowDom.$('#colorStyle').val();
		var authId = windowDom.$('#authId').val();
		var authority = windowDom.$('#authority').val();
		var isEnable = windowDom.$('#isEnable').val();
		//获取选择图表样式
		var chartId = windowDom.$(".chart-type.select")[0].id;
		var type = chartId.substring(chartId.length-1,chartId.length);
		json = {};
		json.alias = alias;
		json.name = name;
		json.expressions = expressions;
		json.expressionsId = expressionsId;
		json.dynamicCondititon = dynamicCondititon;
		json.dynamicCondititonId = dynamicCondititonId;
		json.measureIds = measureIds;
		json.diagramId = diagramId;
		json.formId = formId;
		json.description = description;
		json.type = type;
		json.colorStyle = colorStyle;
		json.authId = authId;
		json.authority = authority;
		json.isEnable = isEnable;
		$.ajax({
			type:'post',
			url:'<%=path %>/statistic/statisticAction_saveStatisticDiagram.action',
			data:json,
			dataType:'text',
			success:function(data){
				if(data!=null){
					windowDom.$('#chart').attr('src','<%=path %>/matrix.rform?statisticsDiagramId='+diagramId+'&mIsStatisticsDiagram=true&mHtml5Flag=true');
				}
			}
		});
	}
	
	//新建
	function create(){
		createStatistic();
	}
	
	//切换下拉框选项
	function changeStatistic(win){
		var diagramId = win.value;
		$('#diagramId').val(diagramId);
		getStatisticContent(diagramId,1)
	}
	
	//删除当前统计模型
	function deleteStatistic(){
		Matrix.showMask2();
		layer.confirm('您确定要删除该模型吗?',{btn: ['确定', '取消'],title:"提示"}, function(){
			var diagramId = $('#diagramId').val();
			var json = {};
			json.diagramId = diagramId;
			$.ajax({
				type:'post',
				url:'<%=path %>/statistic/statisticAction_deleteStatistic.action',
				data:json,
				dataType:'json',
				success:function(data){
					getData();
					Matrix.success('删除成功！');
					Matrix.hideMask2();
					layer.close(layer.index);
				}
			});
		});
	}
</script>
</head>
<body>

	<input type="hidden" id="templateId" name="templateId" value="${param.templateId}">
	<input type="hidden" id="formId" name="formId" value="${param.formId}">
	<input type="hidden" id="diagramId" name="diagramId">
	<div id="web1" style="width: 100%;height: 100%;text-align: center;display: none;">
		<img src="<%=path %>/image/statistic_empty.png" style="width: 300px;height: 200px;margin: 70px auto 0;"/>
		<div style="padding:38px 0 12px">暂无统计分析模型，点击添加！</div>
		<input type="button" class="x-btn ok-btn " value="新建" style="width:110px;height: 36px" onclick="createStatistic()">
	</div>
	<div id="web2" style="position: absolute;width: 100%;height: 100%;display: none;">
		<div id="top" style="height: 50px;width:85%;margin:10px auto;border:1px solid rgb(231, 234, 236);background:white;box-shadow:0 2px 4px 0 rgba(0,0,0,.08)">
			<div id="templateSelect" style="height: 35px;line-height: 50px;float:left;padding-left: 20px;">
				<label style="font-size:14px;color:rgb(22, 105, 171);padding-right:10px">统计模型：</label>
				<select onchange="changeStatistic(this);" class="form-control select2-accessible" id="statisticSelect" style="display:inline;text-overflow: ellipsis;overflow: hidden;width: 300px;">
				</select>
			</div>
			<div id="toolbar" style="float:right;padding-top: 2px;display: -webkit-inline-box;">
				<div style="/* padding:4px; */text-align: left;vertical-align: middle;height: 44px;line-height: 44px;">
					<div style="padding-right: 15px;display: inline-block;">
						<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/new.png">
						<input type="button" value="新建" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="create()">
					</div>	
					<div style="padding-right: 15px;display: inline-block;">
						<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/deletex.png">
						<input type="button" value="删除" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="deleteStatistic()" / >
					</div>
					<%-- <div style="padding-right: 15px;display: inline-block;">
						<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/editflow.png">
						<input type="button" value="保存" class="btn  btn-default toolBarItem" id="MtoolBarItemUpdate" style="padding:0px;margin:0px;border:0;background: transparent" onclick="save()">
					</div> --%>
				</div>
			</div>
		</div>
		<div style="margin:auto;margin-top:10px;width:85%;height: calc(100% - 80px);background:white;box-shadow:0 2px 4px 0 rgba(0,0,0,.08)";>
			<iframe id="content" style="border:1px solid rgb(231, 234, 236);width:100%;height:100%;" frameborder="0" src="">
			</iframe>
		</div>
	</div>
</body>
</html>