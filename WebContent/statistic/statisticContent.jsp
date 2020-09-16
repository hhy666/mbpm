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
<link href="<%=request.getContextPath() %>/js/main.css?_v_=1571425236994" rel="stylesheet" >
<link href='<%=request.getContextPath() %>/js/dash.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/js/fx_pc_all.css' rel="stylesheet"></link>
<title>Insert title here</title>
<style type="text/css">
label{
		height: 30px;
		line-height: 30px;
		font-size: 14px;
		font-weight: 700;
		color:black
	}
	
.config-block {
    line-height: 30px;
 
}	

.chart-image{
	content: '';
    display: inline-block;
    width: 100%;
    height: 100%;
    background-image: url(../images/statistic/chart-icon.png);
    background-size: 42px;
    background-repeat: no-repeat;
    /*border: 1px solid #999;*/
  }
  
</style>
<script type="text/javascript">
	//记录授权的组织机构编码
	var authUser = {};
	
	window.onload = function(){
		initMeasutr();
		initDimensionItem();
		initChart();
		
		//模板样式初始赋值
		var colorStyle = "${StatisticsDiagram.colorStyle}";
		if(colorStyle!=null&&colorStyle.trim().length>0)
			$("#colorStyle option[value='"+colorStyle+"']").attr("selected","selected"); 
		
		//是否启用初始赋值
		var isEnable = "${StatisticsDiagram.isEnable}";
		if(isEnable!=null&&isEnable.trim().length>0)
			$("#isEnable option[value='"+isEnable+"']").attr("selected","selected"); 
		
		//图表类型点击选中
		$(".chart-type").click(function(){
			/* $(".chart-type").css('background','#0182c6');
			$(this).css('background','#0DB3A6'); */
			$(".chart-type").removeClass("select");
			$(this).addClass("select");
			parent.save();
		});
		
		var diagramId = $('#diagramId').val();		
		$('#chart').attr('src','<%=path %>/matrix.rform?statisticsDiagramId='+diagramId+'&mIsStatisticsDiagram=true&mHtml5Flag=true');

	}
	
	//图表类型初始化
	function initChart(){
		var type = $('#type').val();
		$('#chartType'+type).addClass("select");
	}
	
	//统计范围项初始化
	function initDimensionItem(){
		var html = "";
		var dimensionItem = $('#dimensionItem').val();
		if(dimensionItem!=null&&dimensionItem!=""){
			var dimensionItemJson = eval('('+dimensionItem+')');
			for(var i=0;i<dimensionItemJson.length;i++){
				html += "<li ondragenter='dimensionDragen(event)' draggable='true' ondrop='diagramItemDrop(event)' ondragover='allowDrop(event)' ondragstart='drag(event)' id='"+dimensionItemJson[i].id+"' class='axis-tag fx_dash_field_dimension' style='min-width:50px;display:inline-block;margin-left: 5px;margin-top: 5px;margin-right: 5px'>";
				html += "<div class='field-config fui_tag closable' style='height: 24px; line-height: 24px;'>";
				html += "<div style='padding-left: 16px' class='tag-wrapper style-custom'>";
				html += "<span style='max-width:150px;overflow:hidden' class='tag-text'>"+dimensionItemJson[i].name+"</span>";
				html += "<i id='"+dimensionItemJson[i].id+"_i' class='icon-close-circle' onclick='deleteDimensionItemli(this)''>";
				html += "</i>";
				html += "</div>";
				html += "</div>";
				html += "</li>";
			}
			$('#dimensionUl').append(html);
		}
	}
	
	//测量值初始化
	function initMeasutr(){
		var ids = "";
		var html = "";
		var measure = $('#measure').val();
		if(measure!=null&&measure!=""){
			var measureJson = eval('('+measure+')');
			for(var i=0;i<measureJson.length;i++){
				ids += measureJson[i].id + ',';
				html += "<li ondragenter='measureDragen(event)' draggable='true' ondrop='measureDrop(event)' ondragover='allowDrop(event)' ondragstart='drag(event)' id='"+measureJson[i].id+"' class='axis-tag fx_dash_field_dimension' style='min-width:50px;display:inline-block;margin-left: 5px;margin-top: 5px;margin-right: 5px'>";
				html += "<div class='field-config fui_tag closable' style='height: 24px; line-height: 24px;'>";
				html += "<div style='padding-left: 16px' class='tag-wrapper style-custom'>";
				html += "<span id='"+measureJson[i].id+"_span' style='max-width:150px;overflow:hidden' class='tag-text'>"+measureJson[i].name+"</span>";
				html += "<i id='"+measureJson[i].id+"_i' class='icon-close-circle' onclick='deleteMeasureli(this)''>";
				html += "</i>";
				html += "</div>";
				html += "</div>";
				html += "</li>";
			}
			ids = ids.substring(0,ids.length-1);
			$('#measureIds').val(ids);
			$('#measureUl').append(html);
		}
	}
	
	//供子页面获取对象
	function getWindow(){
		return this;
	}

	//获取子页面对象
	function setWindow(window){
		iframeWindow = window;
	}
	
	//子页面添加范围项回调
	function onAddDimensionItemClose(data){
		if(data!=null){
			iframeWindow.$('#DataGrid001_table').bootstrapTable('refresh');
			iframeWindow.Matrix.success('添加成功！');
			parent.save();
		}		
	}
	
	//子页面修改范围项回调
	function onEditDimensionItemClose(data){
		if(data!=null){
			iframeWindow.$('#DataGrid001_table').bootstrapTable('refresh');
			iframeWindow.Matrix.success('修改成功！');
			parent.save();
		}		
	}

	//用户输入条件
	var dynamicCondititonArr = []; 
	
	//添加测量值字段回调
	function onChooseEntityProClose(data){
		var type = data.type;
		iframeWindow.$('#entityProType').val(type);
		iframeWindow.$('#entityProName').val(data.name);
		iframeWindow.$('#entityProId').val(data.mid);
		var name = iframeWindow.$('#name').val();
		if(name==null||name==''){
			iframeWindow.$('#name').val(data.name);
		}
		var entity = data.entity;
		var json = {};
		json.entity = entity;
		$.ajax({
			type:'post',
			url:'<%=path %>/statistic/statisticAction_chooseEntityBack.action',
			data:json,
			dataType:'text',
			success:function(data){
				iframeWindow.$('#tableName').val(data);
			}
		});
		if(type==1||type==7){//字符和时间类型
			iframeWindow.$('#computeWay option[value="0"]').css('display','none')
			iframeWindow.$('#computeWay option[value="1"]').css('display','')
			iframeWindow.$('#computeWay option[value="2"]').css('display','none')
			iframeWindow.$('#computeWay option[value="3"]').css('display','none')
			iframeWindow.$('#computeWay option[value="4"]').css('display','none')
			iframeWindow.$('#computeWay').val('1');
		}else if(type==2||type==3||type==4||type==5||type==9){//数字类型
			iframeWindow.$('#computeWay option[value="0"]').css('display','')
			iframeWindow.$('#computeWay option[value="1"]').css('display','')
			iframeWindow.$('#computeWay option[value="2"]').css('display','')
			iframeWindow.$('#computeWay option[value="3"]').css('display','')
			iframeWindow.$('#computeWay option[value="4"]').css('display','')
			iframeWindow.$('#resultFormat').val('#.00');
		}
	}

	//弹出系统查询条件窗口
	function showExpressions(){ 
		var flag = Matrix.getFormItemValue('flag');
		var expressions = Matrix.getFormItemValue('expressions');
	    var formId = $('#formId').val();
		var formFlag = formId + "EntityVar";
	    //parent.iframeJs = this;
	    layer.open({
	    	id:'Expressions',
			type : 2,
			
			title : ['设置系统查询条件'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '75%', '90%' ],
			content : "<%=path%>/condition/condition_loadConditionSet.action?iframewindowid=Expressions&entrance=Stastistic&formFlag="+formFlag+"&flag="+flag+"&formId="+formId+"&firstCondition="+encodeURI(expressions)
		});			
	}
	
	//系统查询条件回调
    function onExpressionsClose(data){
		if(data!=null && data!=""){
	      	Matrix.setFormItemValue('expressions',data.conditionText);
			Matrix.setFormItemValue('expressionsId',data.conditionVal);
			parent.save();
	    }
    }
	
  	//弹出用户输入条件窗口
	function showDynamicCondititon(){ 
		var string = Matrix.getFormItemValue('dynamicCondititon');
		var value = Matrix.getFormItemValue('dynamicCondititonId');
    	var sortName = string.split(",");
    	var flag = Matrix.getFormItemValue('flag');
    	var dynamicCondititonId = value.split(",");
    	if(string!=null&&string!=""){
    		var list = [];
			for(var i=0;i<sortName.length;i++){
				var newdata={};
				if(sortName[i]!=""&&typeof(sortName[i])!="undefined"&&dynamicCondititonId[i]!=""&&typeof(dynamicCondititonId[i])!="undefined"){
					var resl=dynamicCondititonId[i].split(":");
		  			newdata.name=sortName[i];
		  			newdata.formId=resl[0];
		  			newdata.operator=resl[1];
		  			list.push(newdata);
	  			}
	  		}
			dynamicCondititonArr = list;
  		}
	    var formId = $('#formId').val();
		var formFlag = formId + "EntityVar";
	    //parent.iframeJs = this;
	    layer.open({
	    	id:'DynamicCondititon',
			type : 2,
			
			title : ['设置用户输入条件'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '75%', '90%' ],
			content : "<%=path%>/statistic/term.jsp?iframewindowid=DynamicCondititon&formFlag="+formFlag+"&flag="+flag+"&formId="+formId
		});			
	}
	
	//用户输入条件回调
    function onDynamicCondititonClose(selectedItems){
    	if(selectedItems!=null && selectedItems!=""){
			if(selectedItems!=true){
				var data="";
				var value="";
				var sign = Matrix.getFormItemValue('flag');
				for(var i=0;i<selectedItems.length;i++){
					if(sign==""||sign==null||sign=='undefined'){
						var arr=selectedItems[i].formId.split(".");
						if(arr[0]!='${param.formFlag}'){
							Matrix.setFormItemValue('flag',arr[0]);
						}
					}
					if(i==selectedItems.length-1){
						data+=selectedItems[i].name;
						value+=selectedItems[i].formId;
						value+=':';
						if(selectedItems[i].operator!="undefined"){
							value+=selectedItems[i].operator;
						}else{
							value+="";
						}
						value+=',';
					}else{
						data+=selectedItems[i].name;
						data+=',';
						value+=selectedItems[i].formId;
						value+=':';
						if(selectedItems[i].operator!="undefined"){
							value+=selectedItems[i].operator;
						}else{
							value+="";
						}
						value+=',';
					}
				}
		      	Matrix.setFormItemValue('dynamicCondititon',data);
				Matrix.setFormItemValue('dynamicCondititonId',value);
			}else{
				Matrix.setFormItemValue('dynamicCondititon',"");
				Matrix.setFormItemValue('dynamicCondititonId',"");
	  		}  
	  		parent.save();
     	}
    }
	
	//弹出测量值选择窗口
	function showMeasure(){
		var templateId = $('#templateId').val();
		var formId = $('#formId').val();
		layer.open({
			id:'Measure',
			type : 2,
			
			title : ['测量值列表'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '60%', '75%' ],
			content : "<%=path%>/statistic/statisticMeasure.jsp?iframewindowid=Measure&formId="+formId+"&templateId="+templateId
		});
	}
	
	//测量值选择回调
	function onMeasureClose(data){
		if(data!=null && data!=""){
			var html = "";
			var measureIds = $('#measureIds').val();
			var ids;
			if(measureIds!=null&&measureIds.trim().length>0&&measureIds.replaceAll(',','')!="")
				ids = measureIds + ',';
			else
				ids = '';
			for(var i=0;i<data.length;i++){
				if(measureIds.indexOf(data[i].id)==-1){
					ids += data[i].id + ',';
					html += "<li ondragenter='measureDragen(event)' draggable='true' ondrop='measureDrop(event)' ondragover='allowDrop(event)' ondragstart='drag(event)' id='"+data[i].id+"' class='axis-tag fx_dash_field_dimension' style='min-width:50px;display:inline-block;margin-left: 5px;margin-top: 5px;margin-right: 5px'>";
					html += "<div class='field-config fui_tag closable' style='height: 24px; line-height: 24px;'>";
					html += "<div style='padding-left: 16px' class='tag-wrapper style-custom'>";
					html += "<span style='max-width:150px;overflow:hidden' class='tag-text'>"+data[i].name+"</span>";
					html += "<i id='"+data[i].id+"_i' class='icon-close-circle' onclick='deleteMeasureli(this)''>";
					html += "</i>";
					html += "</div>";
					html += "</div>";
					html += "</li>";
				}
			}
			ids = ids.substring(0,ids.length-1);
			$('#measureIds').val(ids);
			$('#measureUl').append(html);
			Matrix.success('添加成功！');
			parent.save();
	    }
	}
	
	
	//弹出统计范围选择窗口
	function showDimension(){
		var formId = $('#formId').val();
		var dimensionId = $('#dimensionId').val();
		layer.open({
			id:'Dimension',
			type : 2,
			
			title : ['统计范围项列表'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '60%', '75%' ],
			content : "<%=path%>/statistic/editDimension.jsp?iframewindowid=Dimension&formId="+formId+"&dimensionId="+dimensionId
		});
	}
	
	//点击删除当前测量值li
	function deleteMeasureli(dom){
		//dom.stopPropagation();
		var measureIds = $('#measureIds').val();
		var id = dom.id;
		id = id.substring(0,id.length-2);
		measureIds = measureIds.replace(id,'');
		$('#measureIds').val(measureIds);
		dom.parentNode.parentNode.parentNode.remove();
		parent.save();
	}
	
	//点击删除当前统计范围li
	function deleteDimensionItemli(dom){
		//dom.stopPropagation();
		//var dimensionIds = $('#dimensionIds').val();
		//dimensionIds = dimensionIds.replace(id,'');
		//$('#dimensionIds').val(dimensionIds);
		var id = dom.id;
		id = id.substring(0,id.length-2);
		var json = {};
		json.ids = id;
		$.ajax({
			type:'post',
			url:'<%=path %>/statistic/statisticAction_deleteDimensionItem.action',
			data:json,
			dataType:'text',
			success:function(){
				dom.parentNode.parentNode.parentNode.remove();
				parent.save();
			}
		});
	}
	
	//添加统计范围回调
	function onAddDimensionClose(data){
		if(data!=null){
			iframeWindow.Matrix.success('添加成功！');
			iframeWindow.$('#DataGrid001_table').bootstrapTable('refresh');
			parent.save();
		}
	}

	//修改统计范围回调
	function onEditDimensionClose(data){
		if(data!=null){
			iframeWindow.Matrix.success('修改成功！');
			iframeWindow.$('#DataGrid001_table').bootstrapTable('refresh');
			parent.save();
		}
	}
	
	//弹出应用授权窗口
   function showAddAuthority(){
	    authUser.areaIds = document.getElementById("authId").value;      //编码
		authUser.areaName = Matrix.getFormItemValue("authority");  //名称
	    layer.open({
		    id:'AddAuthority',
			type : 2,
			
			title : ['设置应用授权'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '70%', '80%' ],
			content : '<%=request.getContextPath()%>/office/html5/select/MixSelect.jsp?iframewindowid=AddAuthority'
	   });
	}
	   
 	//弹出应用授权窗口回调
	function onAddAuthorityClose(data){
		if(data!=null && data!=''){
			var userNames = data.allNames;
	        var adminId = data.allIds;
	        Matrix.setFormItemValue('authId',adminId);
	        Matrix.setFormItemValue('authority',userNames);
			parent.save();
		}
	}
 	
 	//存入拖拽li元素ID
	function drag(ev){
		ev.dataTransfer.setData("Text",ev.target.id);
	}

	function allowDrop(ev){
		ev.preventDefault();
	}
	
	//测量值拖动完成事件
	function measureDrop(ev){
		ev.preventDefault();
		var data=ev.dataTransfer.getData("Text");
		var element = ev.target.parentNode;
		for(var i=0;i<5;i++){
			var id = element.id;
			if(id!=null&&id!=""){
				//交换位置和重置编码
				$("#"+data).insertBefore($("#"+id));
				$('.li_flag').empty();
				var liArr = $("#measureUl li");
				var newMeasureIds = '';
				for(var i = 0; i < liArr.length; i++){
					newMeasureIds += liArr[i].id + ',';
				}
				newMeasureIds = newMeasureIds.substring(0,newMeasureIds.length-1);
				$('#measureIds').val(newMeasureIds);
				parent.save();
				break;
			}else{
				element = element.parentNode;
			}
		}
	}
	
	//统计范围项拖动完成事件
	function diagramItemDrop(ev){
		ev.preventDefault();
		var data=ev.dataTransfer.getData("Text");
		var element = ev.target.parentNode;
		var json = {};
		for(var i=0;i<5;i++){
			var id = element.id;
			if(id!=null&&id!=""){
				//交换位置和重置编码
				$("#"+data).insertBefore($("#"+id));
				$('.li_flag').empty();
				var liArr = $("#dimensionUl li");
				var newDimensionItemIds = '';
				for(var i = 0; i < liArr.length; i++){
					newDimensionItemIds += liArr[i].id + ',';
				}
				newDimensionItemIds = newDimensionItemIds.substring(0,newDimensionItemIds.length-1);
				$('#dimensionItemIds').val(newDimensionItemIds);
				json.dimensionItemIds = newDimensionItemIds;
				$.ajax({
					type:'post',
					url:'<%=path %>/statistic/statisticAction_updateDimensionItemIndex.action',
					data:json,
					dataType:'text',
					success:function(data){
						if(data=="false"){
							//break;
							Matrix.warn('保存失败！请与管理员联系！');
						}else{
							parent.save();
						}
					}
				});
				break;
			}else{
				element = element.parentNode;
			}
		}
	}
	
	
	//统计项移入事件
	function dimensionDragen(event){
		event.stopPropagation();
 		//构造提示标识
		var li = document.createElement('li');
		li.className = 'li_flag';
		li.style.display = 'inline-block';
		var div = document.createElement('div');
		div.className = "div_flag";
		li.appendChild(div);
		//根据进入不同元素显示隐藏提示标识和变色
		if(event.target.className == "field-config fui_tag closable"){
			$('.li_flag').remove();
			document.getElementById('dimensionUl').insertBefore(li,event.target.parentNode);
			if(event.target.childNodes[1]!=null&&event.target.childNodes[1]!="undefined")
				event.target.childNodes[1].classList.add("active");
		}
		if(event.target.className == "tag-wrapper style-custom"){
			$('.li_flag').remove();
			document.getElementById('dimensionUl').insertBefore(li,event.target.parentNode.parentNode);
			event.target.classList.add("active");
		}
		if(event.target.className == "tag-text"){
			$('.li_flag').remove();
			document.getElementById('dimensionUl').insertBefore(li,event.target.parentNode.parentNode.parentNode);
			event.target.parentNode.classList.add("active");
		}
	}
	
	//测量值移入事件
	function measureDragen(event){
		event.stopPropagation();
		//构造提示标识
		var li = document.createElement('li');
		li.className = 'li_flag';
		li.style.display = 'inline-block';
		var div = document.createElement('div');
		div.className = "div_flag";
		li.appendChild(div);
		//根据进入不同元素显示隐藏提示标识和变色
		if(event.target.className == "field-config fui_tag closable"){
			$('.li_flag').remove();
			document.getElementById('measureUl').insertBefore(li,event.target.parentNode);
			if(event.target.childNodes[1]!=null&&event.target.childNodes[1]!="undefined")
				event.target.childNodes[1].classList.add("active");
		}
		if(event.target.className == "tag-wrapper style-custom"){
			$('.li_flag').remove();
			document.getElementById('measureUl').insertBefore(li,event.target.parentNode.parentNode);
			event.target.classList.add("active");
		}
		if(event.target.className == "tag-text"){
			$('.li_flag').remove();
			document.getElementById('measureUl').insertBefore(li,event.target.parentNode.parentNode.parentNode);
			event.target.parentNode.classList.add("active");
		}
	}
	
	//ul移入事件
	function ulDragen(event){
		event.preventDefault();
		$('.li_flag').remove();
		$('.tag-wrapper.style-custom').removeClass('active');
	}
	
	//测量值ul移入完成事件
	function measureUlDrop(event){
		event.preventDefault();
		$('.li_flag').remove();
		$('.tag-wrapper.style-custom').removeClass('active');
	}
	
	//范围项ul移入完成事件
	function dimensionUlDrop(event){
		event.preventDefault();
		$('.li_flag').remove();
		$('.tag-wrapper.style-custom').removeClass('active');
	}
	
	//是否启用保存
	function isEnableChange(){
		parent.save();
	}
	
	//模板样式保存
	function colorStyleChange(){
		parent.save();
	}
</script>
</head>
<body style="background: rgb(236, 234, 234)">
	<!-- 标志-->
	<input name="flag" id="flag" type="hidden" />
	<input type="hidden" id="authId" name="authId" value="${StatisticsDiagram.authId}">
	<input type="hidden" id="dimensionId" name="dimensionId" value="${dimensionId}">
	<input type="hidden" id="expressionsId" name="expressionsId" value="${StatisticsDiagram.expressionsId}">
	<input type="hidden" id="dynamicCondititonId" name="dynamicCondititonId" value="${StatisticsDiagram.dynamicCondititonId}">
	<input type="hidden" id="measureIds" name="measureIds" value="${measureIds}">
	<input type="hidden" id="dimensionIds" name="dimensionIds" value="${dimensionIds}">
	<input type="hidden" id="templateId" name="templateId" value="${param.templateId}">
	<input type="hidden" id="formId" name="formId" value="${param.formId}">
	<input type="hidden" id="diagramId" name="diagramId" value="${StatisticsDiagram.id}">
	<input type="hidden" id="measure" name="measure" value="${measure}">
	<input type="hidden" id="dimensionItem" name="dimensionItem" value="${dimensionItem}">
	<input type="hidden" id="dimensionItemIds" name="dimensionItemIds" value="${dimensionItemIds}">
	<input type="hidden" id="type" name="type" value="${StatisticsDiagram.type}">
	<div style="width:25%;height:100%;display: inline;float: left;background: white;border: 3px solid #eee;">
		<div style="padding:10px">
			<div><label>编码:</label></div>
			<div>
				<input id="alias" name="alias" type="text" value="${StatisticsDiagram.alias}" class="form-control" style="height:100%;width:100%;" readonly="readonly" autocomplete="off">	
			</div>
			<div><label>名称:</label></div>
			<div>
				<input placeholder="请输入名称" id="name" name="name" type="text" value="${StatisticsDiagram.name}" class="form-control" style="height:100%;width:100%;" autocomplete="off" onblur="parent.save()">
			</div>
			<div><label>测量值:</label></div>
			<div>
				<div class="input-group" style="width:100%;">
					<ul	ondragenter='ulDragen(event)' ondrop='measureUlDrop(event)' ondragover='allowDrop(event)' id="measureUl" style="min-height:66px;background:#eee;border: 1px solid #ccc;padding-bottom:5px" class="drag-target draggable has-tag" >
					</ul>
					<span class="input-group-addon addon-udSelect udSelect" onclick="showMeasure()"><i class="fa fa-search"></i></span>
				</div>
			</div>
			<div><label>范围项:</label></div>
			<div>
				<div class="input-group" style="width:100%;">
					<ul ondragenter='ulDragen(event)' ondrop='dimensionUlDrop(event)' ondragover='allowDrop(event)' id="dimensionUl" style="min-height:66px;background:#eee;border: 1px solid #ccc;padding-bottom:5px" class="drag-target draggable has-tag" >
					</ul>					
					<span class="input-group-addon addon-udSelect udSelect" onclick="showDimension()"><i class="fa fa-search"></i></span>
				</div>
			</div>
			<div><label>系统查询条件:</label></div>
			<div>
				<div class="input-group" style="width:100%;">
					<input id="expressions" name="expressions" type="text" value="${expressionsName}" class="form-control" style="height:66px;width:100%;" readonly="readonly" autocomplete="off" >	
					<span class="input-group-addon addon-udSelect udSelect" onclick="showExpressions()"><i class="fa fa-search"></i></span>
				</div>
			</div>
			<div><label>用户输入条件:</label></div>
			<div>
				<div class="input-group" style="width:100%;">
					<input id="dynamicCondititon" name="dynamicCondititon" type="text" value="${StatisticsDiagram.dynamicCondititon}" class="form-control" style="height:66px;width:100%;" readonly="readonly" autocomplete="off" >	
					<span class="input-group-addon addon-udSelect udSelect" onclick="showDynamicCondititon()"><i class="fa fa-search"></i></span>
				</div>
			</div>
			<%-- <div><label>是否定时刷新:</label></div>
			<div>
				<input id="isRefresh" name="isRefresh" type="checkbox" value="${StatisticsDiagram.isRefresh}" class="box">	
			</div>
			<div><label>刷新间隔:</label></div>
			<div>
				<input id="durationTime" name="durationTime" type="number" value="${StatisticsDiagram.durationTime}" class="form-control" style="height:100%;width:100%;" autocomplete="off">	
			</div> --%>
			<div><label>描述:</label></div>
			<div>
				<textarea id="description" name="description" class="form-control" style="resize: none;height:99px;width:100%;" autocomplete="off" onblur="parent.save();">${StatisticsDiagram.description}</textarea>	
			</div>
		</div>
	</div>
	<div style="width:55%;height:100%;display: inline;float: left;background: white;border: 3px solid #eee;padding: 10px;">
		<iframe id="chart" style="width:100%;height:100%;" frameborder="0" src="">
		</iframe>
	</div>
	<div style="width:20%;height:100%;display: inline;float: left;background: white;border: 3px solid #eee;padding:5px">
		<div class="config-block">
			<div class="block-head"><label>图表类型:</label></div>
			<div class="config-type" style="text-align:center">
				<div id="chartType1" class="chart-type" data-type="metric_table" title="折线图">
					<div class="chart-image chart-type-1" ></div>
				</div>
				<div id="chartType2" class="chart-type" data-type="pivot_table" title="柱状图">
					<div class="chart-image chart-type-2"></div>
				</div>
				<div id="chartType3" class="chart-type" data-type="column_chart" title="条形图">
					<div class="chart-image chart-type-3"></div>
				</div>
				<div id="chartType4" class="chart-type" data-type="bar_chart" title="饼状图">
					<div class="chart-image chart-type-4"></div>
				</div>
				<div id="chartType5" class="chart-type" data-type="line_chart" title="散点图">
					<div class="chart-image chart-type-5"></div>
				</div>
				<div id="chartType6" class="chart-type" data-type="area_chart" title="雷达图">
					<div class="chart-image chart-type-6"></div>
				</div>
				<div id="chartType7" class="chart-type" data-type="multi_axes_chart" title="漏斗图">
					<div class="chart-image chart-type-7"></div>
				</div>
				<div id="chartType8" class="chart-type" data-type="multi_axes_chart" title="列表图">
					<div class="chart-image chart-type-8"></div>
				</div>
			</div>
		</div>
		<div><label>颜色：</label></div>
		<div>
			<select id="colorStyle" name="colorStyle" class="form-control select2-accessible" onchange="colorStyleChange()">
				<option value="1">花园色调</option>
				<option value="2">沙漠色调	</option>
				<option value="3">海洋色调</option>
				<option value="4">深秋色调</option>
			</select>		
		</div>
		<div><label>授权范围：</label></div>
		<div>
			<div class="input-group" style="width:100%;">
				<textarea id="authority" name="authority" class="form-control" rows="2"  style="resize: none;height:66px" readonly="readonly">${StatisticsDiagram.authority}</textarea>
				<span class="input-group-addon addon-udSelect udSelect" onclick="showAddAuthority()"><i class="fa fa-search"></i></span>
			</div>
		</div>
		<div><label>是否启用：</label></div>
		<div>
			<select id="isEnable" name="isEnable" class="form-control select2-accessible" onchange="isEnableChange()">
				<option value="0">停用</option>
				<option value="1">启用</option>
			</select>		
		</div>
	</div>
</body>
</html>