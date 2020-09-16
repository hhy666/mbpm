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
	
	var templateType;  //1公文  2协同  3 基础数据 
	
	window.onload = function(){
		debugger;
		//判断是否支持移动表单
		var isHaveMobile = $('#isHaveMobile').val();
		if(isHaveMobile=="true"){
			$('#changeMo').css('display','');
			$('#changePC').css('display','none');
			$('#changeMoNo').css('display','none');
		}else if(isHaveMobile=="false"){
			$('#changeMo').css('display','none');
			$('#changePC').css('display','none');
			$('#changeMoNo').css('display','');
		}
		
		if(parent.document.getElementById('templateType')){
			templateType = parent.document.getElementById('templateType').value;   
			if(templateType == 3){
				$('#versionBtn').css('display','none');  //基础数据不支持多版本
				$('#deleteMo').css('display','');   //移动表单单独处理删除
			}
		}
		
		//菜单栏变指针
		$(".flowTools").mouseover(function(){
			$(this).css("cursor","pointer");
		});
		
		$(".flowTools").mouseleave(function(){
			$(this).css("cursor","default");
		});
		
		//刷新父页面
		parent.$("#main").css('height','calc(100% - 50px)');
		//parent.$('#loading').css('display','none');
		parent.Matrix.hideMask2();
		parent.layer.close(parent.layer.load());//关闭加载层
		
		//设置当前版本号
		var version = $('#version').val();
		$('#versionNum').text("(V"+ version +".0)");
	}

	//切换移动表单
	function changeMobile(){
		debugger;
		var formId = $('#formId').val();
		var json = {};
		json.formId = formId;
		//判断有无移动表单
		$.ajax({
			type:'post',
			url:'<%=path %>/templateAction_isSaveMobile.action',
			data:json,
			dataType:'json',
			success:function(data){
				$('#changeMo').css('display','none');
				$('#changePC').css('display','');
				$('#explainForm').text('当前为移动表单设计界面');
				if(data.flag=='false'){
					$('#web1').css('display','');
					$('#web2').css('display','none');
				}else if(data.flag=='true'){
					$('#web1').css('display','none');
					$('#web2').css('display','');
					$('#mobile_mid').val(data.mobile_mid);
					$('#mobile_uuid').val(data.mobile_uuid);
					$('#mobile_type').val(data.mobile_type);
					$('#mobile_parentUuid').val(data.mobile_parentUuid);
					$('#versionNum').text("(V"+ data.version +".0)");
					if(templateType == 3){
						$('#deleteBasicMo').css('display','');   //基础数据的移动表单支持删除 单独处理
					}
					$("#content").attr("src","<%=path%>/form/formInfo_loadFormMainPage.action?nodeUuid="+data.nodeId+"&type=1&processType=${param.templateClass}");
				}
			}
		});
	}
	
	//切换PC表单
	function changePC(){
		debugger;
		var nodeUuid = $('#nodeUuid').val();
		$('#explainForm').text('当前为PC表单设计界面');
		
		//判断是否支持移动表单
		var isHaveMobile = $('#isHaveMobile').val();
		if(isHaveMobile=="true"){
			$('#changeMo').css('display','');
			$('#changePC').css('display','none');
			$('#changeMoNo').css('display','none');
		}else if(isHaveMobile=="false"){
			$('#changeMo').css('display','none');
			$('#changePC').css('display','none');
			$('#changeMoNo').css('display','');
		}
		var json = {};
		json.nodeUuid = nodeUuid;
		$.ajax({
			type:'post',
			url:'<%=path %>/form/formInfo_getMaxFormVersion.action',
			data:json,
			dataType:'json',
			success:function(data){
				if(data){
					//设置当前版本号
					var version = data.version;
					$('#versionNum').text("(V"+ version +".0)");
					if(templateType == 3){
						$('#deleteBasicMo').css('display','none');   //基础数据的电脑表单不支持删除
					}
					$("#content").attr("src","<%=path%>/form/formInfo_loadFormMainPage.action?nodeUuid="+nodeUuid+"&type=1&processType=${param.templateClass}");
				}		
			}
		});	
	}
	
	//没有移动表单时新增
	function createNew(){
		var formId = $('#formId').val();
		$('#web1').css('display','none');
		$('#web2').css('display','');
		var json = {};
		json.formId = formId;
		$.ajax({
			type:'post',
			url:'<%=path %>/templet/tem_newDesignMobileForm.action',
			data:json,
			dataType:'json',
			success:function(data){
				debugger;
				if(data){
					$('#mobile_mid').val(data.mobile_mid);
					$('#mobile_uuid').val(data.mobile_uuid);
					$('#mobile_type').val(data.mobile_type);
					$('#mobile_parentUuid').val(data.mobile_parentUuid);
					$('#versionNum').text("(V1.0)");
					if(templateType == 3){
						$('#deleteBasicMo').css('display','');   //基础数据的移动表单支持删除 单独处理
					}
					$("#content").attr("src","<%=path%>/form/formInfo_loadFormMainPage.action?nodeUuid="+data.mobile_uuid+"&type=1&processType=${param.templateClass}");;
				}
			}
		});	
	}
	
	//删除最后一个移动表单版本时删除移动表单目录
	function deleteMobileForm(){
		var parentUuid = $('#mobile_parentUuid').val();
		var type = $('#mobile_type').val();
		var nodeUuid = $('#mobile_uuid').val();
		var formId = $('#mobile_mid').val();
		$.post(
			"<%=path%>/html5Catalog_deleteCatalog.action",
			{ entityId: nodeUuid, 
			  parentNodeId: parentUuid,
			  type: type,
			  mid: formId
			},
			function(data){   //删除成功切换移动表单
				changeMobile();
			}
		);
	}
	
	//基础数据删除移动表单(即删除目录+目录下所有的移动表单版本)
	function deleteBasicMoForm(){
		var nodeUuid = $('#mobile_uuid').val();  //移动表单Catalog目录主键编码
		var parentUuid = $('#mobile_parentUuid').val();
		var type = $('#mobile_type').val();
		var formId = $('#mobile_mid').val();  //移动表单编码
		
		var versionNum = $('#versionNum').text()
		var version = versionNum.substring(versionNum.indexOf('V')+1,versionNum.indexOf('.'));  //当前移动表单版本号
		
		//先校验表单版本是否已发布(已发布不能删)  再调用删除
		var json = {};
		json.nodeUuid = nodeUuid;
		json.version = version;
		$.ajax({
			type:'post',
			url:'<%=path%>/form/formInfo_getFormVersionState.action',  
			data:json,
			dataType:'json',
			success:function(data){
				if(data){
					var state = data.state;
					if(state==1){
		    			Matrix.warn("表单已发布，不能执行删除操作！");
		    			return;
		    		}else{
		    			layer.confirm("您确定要删除该表单版本？", {
		    				   btn: ['确定','取消'],  //按钮
		    				   closeBtn:0
	    		        },function(index){
	    		    		$.post(
	    		    			"<%=path%>/html5Catalog_deleteCatalog.action",
	    		    			{ entityId: nodeUuid, 
	    		    			  parentNodeId: parentUuid,
	    		    			  type: type,
	    		    			  mid: formId
	    		    			},
	    		    			function(data){   //删除成功切换移动表单
	    		    				changeMobile();
	    		    				Matrix.success('删除成功！');
	    		    			}
	    		    		);
	    					layer.close(index);
	    		        })
		    		}
				}
			}
		});	
	}
	
	
	//打开表单版本列表窗口
	function openFormVersion(){
		debugger;
		var formType;  //表单类型  pc电脑  mo移动
		var nodeUuid;
		if($("#changePC").is(":hidden")){   //电脑表单
			formType = "pc";
			nodeUuid = $('#nodeUuid').val();
		}else if($("#changeMo").is(":hidden")){   //移动表单
			formType = "mo";
			nodeUuid = $('#mobile_uuid').val();
		}
		layer.open({
			id:'formVersion',
			type : 2,
			
			title : ['表单版本列表'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '45%', '55%' ],
			content : "<%=path%>/form/formInfo_loadH5FormVersionsList.action?iframewindowid=formVersion&formType="+formType+"&nodeUuid="+nodeUuid
	   });
	}
	
	//表单版本列表窗口回调
	function onformVersionClose(data){
		if(data!=null && data!=''){
			var opType = data.opType;   //操作类型
			if(opType == 'update'){
				var version = data.version;  //版本号
				$('#versionNum').text("(V"+ version +".0)");
				layer.msg('编辑表单中！');
			}else if(opType == 'copy'){
				var version = data.version;  //版本号
				$('#versionNum').text("(V"+ version +".0)");
				Matrix.success('复制成功！');
			}else if(opType == 'delete'){
				Matrix.success('删除成功！');
			}
		}
	}
</script>
</head>
<body>
	<!-- 是否支持移动表单 -->
	<input type="hidden" name="isHaveMobile" id="isHaveMobile" value="${param.isHaveMobile}">
	<!-- 电脑表单信息（点击表单设计时URL带入） -->
	<input type="hidden" name="nodeUuid" id="nodeUuid" value="${param.nodeUuid}">
	<input type="hidden" name="processType" id="processType" value="${param.processType}">
	<input type="hidden" name="formId" id="formId" value="${param.formId}">
	<!-- 移动表单信息 （点击切换移动表单的时候初始）-->
	<input type="hidden" name="mobile_mid" id="mobile_mid">
	<input type="hidden" name="mobile_uuid" id="mobile_uuid" >
	<input type="hidden" name="mobile_type" id="mobile_type">
	<input type="hidden" name="mobile_parentUuid" id="mobile_parentUuid">
	<!-- 存放电脑表单的当前版本号 -->
	<input type="hidden" name="version" id="version" value="${version}">
	<div id="web1" style="width: 100%;height: 100%;text-align: center;display: none;">
		<img src="<%=path %>/image/flow_chart_empty.jpg" style="width: 400px;height: 250px;margin: 70px auto 0;"/>
		<div style="padding:38px 0 12px">当前没有移动表单,如有需要请新建</div>
		<input type="button" class="x-btn ok-btn " value="新建" style="width:110px;height: 36px" onclick="createNew()">
	</div>
	<div id="web2" style="width: 100%;height: 100%;position: relative;">
		<div id="head" style="position:relative;margin:auto;margin-top:10px;width:85%;height: 50px;border:1px solid rgb(231, 234, 236);background:white;box-shadow:0 2px 4px 0 rgba(0,0,0,.08)">
			<div style="top:0px;bottom:0px;left: 10px;padding-top: 15px;margin:auto;position: absolute;">
				<label style="color:rgb(252, 182, 51);font-size: 14px;padding-left: 10px;cursor: default;" >说明：</label>
				<label id="explainForm" style="color:rgb(22, 105, 171);font-size: 14px;padding-left: 10px;cursor: default;padding-right: 10px" >当前为PC表单设计界面</label>
			</div>
			<div style="top:0px;bottom:0px;right: 10px;padding-top: 15px;margin:auto;position: absolute;">
				<label class="flowTools" id="versionBtn" style="color:rgb(22, 105, 171);font-size: 14px;padding-left: 10px;cursor: default;" onclick="openFormVersion()">版本<span id="versionNum" style="color:rgb(252, 182, 51) "></span></label>
				<label id="changeMoNo" style="font-size: 14px;padding-left: 10px;cursor: default;padding-right: 10px">移动表单不可用</label>
				<label class="flowTools" id="changeMo" style="color:rgb(22, 105, 171);font-size: 14px;padding-left: 10px;cursor: default;padding-right: 10px" onclick="changeMobile()">切换至移动表单</label>
				<label class="flowTools" id="changePC" style="color:rgb(22, 105, 171);display:none;font-size: 14px;padding-left: 10px;cursor: default;padding-right: 10px" onclick="changePC()">切换至PC表单</label>
				<label class="flowTools" id="deleteBasicMo" style="color:rgb(22, 105, 171);display:none;font-size: 14px;padding-left: 10px;cursor: default;padding-right: 10px" onclick="deleteBasicMoForm()">删除</label>
			</div>
		</div>
		<div style="margin:auto;margin-top:10px;width:85%;height: calc(100% - 80px);background:white;box-shadow:0 2px 4px 0 rgba(0,0,0,.08)";>
			<iframe id="content" style="border:1px solid rgb(231, 234, 236);width:100%;height:100%;" frameborder="0" src="<%=path%>/form/formInfo_loadFormMainPage.action?nodeUuid=${param.nodeUuid}&type=1&processType=${param.templateClass}">
			</iframe>
		</div>
	</div>
</body>
</html>