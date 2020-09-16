<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<title>Insert title here</title>
<script type="text/javascript">

	window.onload = function(){
		refreshData();

		//菜单栏变色变指针
		$("li").mouseover(function(){
			$(this).css("background","rgba(13,179,166,.1)");
			$(this).css("cursor","pointer");
		});

		$("li").mouseleave(function(){
			$("li").css("background","#fff");
			$("li").css("cursor","default");
		});
	}

	//加载下拉框模板目录
	function getModule(){
		var templateType = $("#templateType").val();
		var json = {};
		json.templateType = templateType;
		$.ajax({
			type:'post',
			url:'<%=path %>/templet/tem_getModule.action',
			data:json,
			dataType:'json',
			success:function(data){
				for (var i = 0; i < data.length; i++) {
					$("#module").append("<option value='"+ data[i].templateId +"'>" + data[i].templateName + "</option>");
				}
				//显示当前模板目录
				$("#module").val($("#nodeId").val());
			}
		});
	}
	
	//刷新
	function refreshData(data){
		var json = {};
		var nodeId = $("#nodeId").val();
		json.nodeId = nodeId;
		if(data!=null){
			json.data = data;
		}
		$.ajax({
			type:'post',
			url:'<%=path %>/templet/tem_h5LoadTemplate.action',
			data:json,
			dataType:'json',
			success:function(data){
				var f = document.getElementById("mainDiv"); 
				while(f.hasChildNodes()) //当div下还存在子节点时 循环继续
				{
				    f.removeChild(f.firstChild);
				}

				if(data!=null){
					var templateType = $('#templateType').val();
					//var color = ['#f96d64','#ac92ec','#52ce87','#f5c547','#5d9cee'];
					var html = '';
					html += '<div id="title" style="height: 12%;">';
					<%-- html += '<img onclick="backList();" id="back" src="<%=path %>/image/back.jpg" style="width:20px;height:20px;position: absolute;left: 10px;top: 12px"/>'; --%>
					html += '<i onclick="backList();" class="fa fa-angle-left" style="color: black;top: 10px;left:15px;font-size: 30px;position: absolute;"></i>';					
					html += '<div style="position:relative;left: 70px;top: 55px;display: inline-table;">';
					if(templateType=="2"){
						html += '<span style="font-size: 18px">协同事项</span>';
					}else if(templateType=="3"){
						html += '<span style="font-size: 18px">基础数据</span>';
					}
					html += '</div>';
					html += '<div style="display: inline;top: 55px;position: absolute;margin: auto;left: 0px;right: 0px;text-align: center;">';
					if(templateType=="2"){
						html += '<span style="font-size: 15px">协同模块：</span>';
					}else if(templateType=="3"){
						html += '<span style="font-size: 15px">基础模块：</span>';
					}
					html += '<select onchange="changeModule();" class="form-control select2-accessible" id="module" style="display:inline;text-overflow: ellipsis;overflow: hidden;width: 300px;">';
					html += '</select>';
					html += '</div>';
					html += '<div style="top: 30px;float:right;display: inline-table;right: 50px;">';
					html += '<div style="position: relative;top:55px;right:80px">';
					html += '<img src="<%=path %>/image/query.png" style="position: absolute;left: 10px;top: 12px"/>';
					html += '<input id="search" type="text" placeholder="  输入名称搜索" style="padding:7px 30px;background: #EAECED;width: 250px;height: 40px;border: 0px;border-radius:30px"/>';
					html += '</div>';
					html += '</div>';
					html += '</div>';
					html += '<div style="vertical-align: top;text-align:left;width:100%;padding-left:50px">';
					html += '<div onclick="createTemplate();" class="dataDiv" style="transition-property: all;transition-duration: 218ms;width:240px;display:inline-table;background:#fff;line-height:80px;height:80px;box-shadow:2px 2px 5px rgba(185,185,185,.3);border-radius:5px;position: relative;margin: 15px;float: left;text-align: center;">';
					html += '<a style="font-size: 15px;vertical-align: middle;height: 100%" >';
					if(templateType=="2"){
						html += '➕新建协同事项'
					}else if(templateType=="3"){
						html += '➕新建基础数据'
					}
					html += '</a>';
					html += '<img class="imgButton" id="importCoor" src="<%=path %>/image/test1.jpg" style="display:none;height: 15px;width: 15px;position: absolute;right: 8px;bottom: 8px" onclick="showList(this);"/>';
					html += '</div>';
					for(var i=0;i<data.length;i++){
						var id = data[i].id;
						var color = data[i].color;
						$('#data').val(JSON.stringify(data));
						if(i!=0&&i%5==0){
							html += '</div>';
							html += '<div style="vertical-align: top;text-align:left;width:100%;padding-left:50px">';
						}
						//判断模板号
						var num = '';
						if(i.toString().length==1){
							num = '00'+ i;
						}else if(i.toString().length==2){
							num = '0'+ i;
						}else if(i.toString().length==3){
							num = i;
						}
						html += '<div class="dataDiv" onclick="clickForm(this,'+i+')" id="tem'+ num + '_' + id +'" style="transition-property: all;transition-duration: 218ms;width:240px;display:inline-table;background:#fff;height:80px;box-shadow:2px 2px 5px rgba(185,185,185,.3);border-radius:5px;position: relative;margin: 15px;float:left">';
						html += '<div style="position:absolute;left:20px;top:16px;background:'+ (color==null?"rgb(91, 155, 213)":color) +';height: 50px;width: 50px;border-radius:10px;display: inline-table;">';
						<%-- html += '<img src="<%=path %>/image/timg2.jpg" style="background:transparent;margin:10px;height: 30px;width: 30px;"/>'; --%>
						html += '</div>';
						html += '<div class="text-div" title="'+ data[i].text+'" style="height:60px;word-break: break-all;font-size: 14px;position: absolute;top: 0px;bottom:0px;left: 85px;text-overflow:ellipsis;overflow:hidden;width:140px;">';
						html += data[i].text;
						html += '</div>';
						html += '<img class="imgButton" tabIndex="'+i+'" src="<%=path %>/image/test1.jpg" style="display:none;height: 15px;width: 15px;position: absolute;right: 8px;bottom: 8px" onclick="showList(this);"/>';
						html += '</div>';
					}
					html += '</div>';
					$("#mainDiv").append(html);

					//数据加载完后加载下拉框模板目录
					getModule();
					
					//监听显示工具按钮
					$("div[id^='tem']").mouseover(function(){
						$(this).children(".imgButton").css("display","");
					});
					
					$("div[id^='tem']").mouseleave(function(){
						$(".imgButton").css("display","none");
					});
					
					$("div[class='dataDiv']").mouseover(function(){
						$(this).children(".imgButton").css("display","");
					});
					
					$("div[id='dataDiv']").mouseleave(function(){
						$(".imgButton").css("display","none");
					});
					
					//监听工具栏失焦隐藏
					$("#toolList").blur(function(){
						$("#toolList").css("display","none");
					});
					
					//监听回车执行查询
					 $('#search').bind('keyup', function(event) {
				        if (event.keyCode == "13") {
				        	var data = $("#search").val();
				        	refreshData(data);
				        }
				    });
					
					//返回键变指针
					$("#back").mouseover(function(){
						$("#back").css("cursor","pointer");
					});
					
					$("#back").mouseleave(function(){
						$("#back").css("cursor","default");
					});
					
					//div指针变型监听
					$("div[id^=tem]").mouseover(function(){
						$(this).css("cursor","pointer");
					});
						
					$("div[id^=tem]").mouseleave(function(){
						$("li").css("cursor","default");
					});
					
					//后退变型监听
					$(".fa-angle-left").mouseover(function(){
						$(this).css("cursor","pointer");
					});
						
					$(".fa-angle-left").mouseleave(function(){
						$(this).css("cursor","default");
					});
					
					//根据文字长度设定文字内容div位置
					var count = $(".text-div").length;
					for(var i=0;i<count;i++){
						//初始长度
						var strlenght = 0;
						//文本区
						var str = $(".text-div")[i].innerHTML;
						for(var a=0;a<str.trim().length;a++){
							var pattern = new RegExp("[\u4E00-\u9FA5]+");//中文验证
							var pattern2 = new RegExp("[A-Za-z]+");//英文验证
							var pattern3 = new RegExp("[0-9]+");//数字验证
							//if (isCN(str.charAt(i)) == true) {
							if (pattern.test(str.charAt(i))) {
								strlenght = strlenght + 2; //中文为两个字符两
							} else if(pattern2.test(str.charAt(i))||pattern3.test(str.charAt(i))){
								strlenght = strlenght + 1; //英文或数字一个字符
							}
						}
						if(strlenght<21){
							$(".text-div")[i].style.top = '30px';
						}else if(strlenght>=21&&strlenght<=42){
							$(".text-div")[i].style.top = '20px';
						}else if(strlenght>42){
							$(".text-div")[i].style.top = '10px';
						}
					}
					
					//div鼠标移过动画效果
					$(".dataDiv").mouseover(function(){
						$(this).css("transform","translate(0,-5px)");
						$(this).css("cursor","pointer");
					});
					
					$(".dataDiv").mouseleave(function(){
						$(this).css("transform","translate(0,0)");
						$(this).css("cursor","default");
					});
				}
			}
		});
	}
	
	//判断是不是中文
	function isCN(str) { 
		var regexCh = /[u00-uff]/;
		return !regexCh.test(str);
	}
	
	//模板目录下拉框change事件
	function changeModule(){
		var nodeId = $('#module option:selected').val();
		var nodeName = $('#module option:selected').text();
		$("#nodeId").val(nodeId);
		$("#nodeName").val(nodeName);
		refreshData();
	}
	
	//工具按钮点击事件
	function showList(div){
		if($(div).attr('id') == 'importCoor'){ //导入协同事项
			$('.liImport').css('display','');
			$('.liImport').siblings().css('display','none');
			$('#toolList').css('height','45px');
			var div = $("#toolList");
	        if (div.is(":hidden")){
	            div.show();
	            div.css("display", "");
	            div.css("left", document.body.scrollLeft + event.clientX - 149);
	            div.css("top", document.body.scrollLeft + event.clientY + 15);
	            div.focus();
	        } else {
	            div.hide();
	        }
	        e = window.event;
	        if (e.stopPropagation) {
	            e.stopPropagation();      //阻止div点击事件 冒泡传播
	        } else {
	            e.cancelBubble = true;   //ie兼容
	        }
		}else{
			//将当前ID赋到隐藏于中
			var	uuid = $(div).parent().attr('id');
			var	text = $(div).parent().children(".text-div").text();
			$('.liImport').css('display','none');
			$('.liImport').siblings().css('display','');
			if(text.trim()=='行政新闻审批'){
				$('.liDelete').css('display','none');
				$('#toolList').css('height','180px');
			}else{
				$('.liDelete').css('display','');
				$('#toolList').css('height','225px');
			}
			$("#templateId").val(uuid);
			var div = $("#toolList");
	        if (div.is(":hidden")){
	            div.show();
	            div.css("display", "");
	            div.css("left", document.body.scrollLeft + event.clientX - 149);
	            div.css("top", document.body.scrollLeft + event.clientY + 15);
	            div.focus();
	        } else {
	            div.hide();
	        }
	        e = window.event;
	        if (e.stopPropagation) {
	            e.stopPropagation();      //阻止div点击事件 冒泡传播
	        } else {
	            e.cancelBubble = true;   //ie兼容
	        }
		}
	}
	
	//工具菜单隐藏
	function hideList(){
		var div = $("#toolList");
        div.css("display", "none");
	}
	
	//前移
	function goMove(){
		//拿到当前div id
		var templateId = $("#templateId").val();
		var index = templateId.substring(3,6);
		//根据当前div查找前一个div的ID
		var num = parseInt(index,10);
		var lastNum = num - 1;
		var lastTemId = "";
		if(lastNum.toString().length==1){
			lastTemId = '00'+ lastNum;
		}else if(lastNum.toString().length==2){
			lastTemId = '0'+ lastNum;
		}else if(lastNum.toString().length==3){
			lastTemId = lastNum;
		}
		//判断是否为第一个
		var last = $("div[id^=tem"+lastTemId+"_]");
		if(last.length==0){
			Matrix.warn("首位不能前移！");
		}else{
			var json = {};
			json.now = templateId;
			json.last = last[0].id;
			json.templateType = '2';
			$.ajax({
				type:'post',
				url:'<%=path %>/templet/tem_goMove.action',
				data:json,
				dataType:'json',
				success:function(data){
					if(data==true){
						hideList();
						refreshData();
					}
				}
			});
		}
	}
	
	//后移
	function backMove(){
		//拿到当前div id
		var templateId = $("#templateId").val();
		var index = templateId.substring(3,6);
		//根据当前div查找后一个div的ID
		var num = parseInt(index,10);
		var nextNum = num + 1;
		var nextTemId = "";
		if(nextNum.toString().length==1){
			nextTemId = '00'+ nextNum;
		}else if(nextNum.toString().length==2){
			nextTemId = '0'+ nextNum;
		}else if(nextNum.toString().length==3){
			nextTemId = nextNum;
		}
		//判断是否为最后一个
		var next = $("div[id^=tem"+nextTemId+"_]");
		if(next.length==0){
			Matrix.warn("末位不能后移！");
		}else{
			var json = {};
			json.now = templateId;
			json.next = next[0].id;
			json.templateType = '2';
			$.ajax({
				type:'post',
				url:'<%=path %>/templet/tem_backMove.action',
				data:json,
				dataType:'json',
				success:function(data){
					if(data==true){
						hideList();
						refreshData();
					}
				}
			});
		}
	}
	
	//新建模板
	function createTemplate(){
		var templateType = $("#templateType").val();
		var nodeid = $("#nodeId").val();
		var title = '';
		if(templateType=="2"){
			title = '新建协同事项';
		}else if(templateType=="3"){
			title = '新建基础数据';
		}
		layer.open({
	    	id:'layerNewmodule',
			type : 2,//iframe 层
			
			shade: [0.1, '#000'],
			title : [title],
			closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '45%', '60%' ],
			content : '<%=request.getContextPath()%>/form/html5/admin/flow/addTemplateList.jsp?addType=template&parentId='+nodeid+'&type='+templateType+'&tempCls='+templateType,
			end	: function(){
				hideList();
				refreshData();
			}
		});
	}
	
	//删除数据
	function deleteData(){
		var templateId = $("#templateId").val();
		var json = {};
		json.nodeId = templateId;
		json.nodeType = 'template';
		json.status = 'now';
		Matrix.confirm('确定要删除吗？',function(value){
			if(true){
				$.ajax({
					type:'post',
					url:'<%=path %>/templet/tem_deleteNode.action',
					data:json,
					dataType:'json',
					success:function(data){
						if(data==true){
							hideList();
							refreshData();
							Matrix.success('删除成功！');
						}
					}
				});
			}
		});
	}
	
	//复制
	function copyTemplate(){
		var templateType = $('#templateType').val();
		var templateId = $('#templateId').val();
		templateId = templateId.substring(7,templateId.length);
		layer.open({
	    	id:'copy',
			type : 2,//iframe 层
			
			title : ['模版复制'],
			closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '60%', '70%' ],
			content : '<%=request.getContextPath()%>/templet/tem_toCopyPage.action?templateType='+templateType+'&nodeid='+templateId,
			end:function(){
				hideList();
				refreshData();
			}
		});
	}
	
	//返回模板目录界面
	function backList(){
		var templateType = $("#templateType").val();
		window.location.href = "<%=path%>/form/html5/admin/template/h5FlowTemplateList.jsp?templateType="+templateType;
	}
	
	//点击进入详细信息
	function clickForm(div,count){
		var json = $('#data').val();
		var data = JSON.parse(json)[count];
		var name = data.text;
		var node = data.node;
		var isTem = data.isTem;
		var formMid = data.formMid;
		var isFormTemplate = data.isFormTemplate;
		var templateType = $("#templateType").val();
		if(isTem){
			var type = data.type;
			var docType = '';
			var flowOrDoc = '';
			if(templateType == '2'){
				flowOrDoc = '1';
			}else if(templateType == '1'){
				docType = '1';
			}else if(templateType == '3'){//底表
				
			}
		}
		var nodeId = $("#nodeId").val();
		var templateId = div.id;
		templateId = templateId.substring(7,templateId.length);
		top.childWindow = window;
		top.layer.open({
			type:2,
			title:false,
			area:['100%','100%'],
			content:"<%=path%>/templet/tem_h5ToCompositePage.action?iframewindowid=CompositePage&mBizId="+templateId+"&templateType="+templateType+"&nodeId="+nodeId+"&docType="+docType+"&type="+type+"&flowOrDoc="+flowOrDoc+"&isFormTemplate="+isFormTemplate+"&mid="+formMid+"&tempCls="+templateType+"&name="+name
		});
	}
	
	//导出协同事项
	function exportCoordination(){
		var templateId = $('#templateId').val();
		var uuid = templateId.substring(templateId.indexOf('_')+1);     //该协同事项表单模板主键
		var nodeId = $('#nodeId').val();	//协同模块主键  即协同事项表单模板的父节点
		var templateType = $('#templateType').val();   //1公文  2协同  3基础数据
		
		layer.confirm("确定要导出？", {
			btn: ['确定','取消'],  //按钮
			closeBtn:0
	    },function(index){
	    	var url = '<%=path %>/ImpAndExpTempServlet?templateId='+uuid+'&nodeId='+nodeId+'&templateType='+templateType+'&flag=export';
	    	$('#form0').attr("action", url);
			$('#form0').submit();
			
			layer.close(index);
	    })
	}
	
	//导入协同事项
	function importCoordination(){
		var nodeId = $('#nodeId').val();	//协同模块主键  即协同事项表单模板的父节点
		var templateType = $('#templateType').val();   //1公文  2协同  3基础数据
		layer.open({
	    	id:'importTemplate',
			type : 2,
			
			title : ['导入协同事项'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '50%', '50%' ],
			content : '<%=path %>/form/html5/admin/template/importTemplate.jsp?iframewindowid=importTemplate&nodeId='+nodeId+'&templateType='+templateType+''
		});			
	}
	
	//记录iframe中的一级弹出窗口
	var iframeJs;
	
	function onshareFormClose(data){
		iframeJs.onshareFormClose(data);
	}
	
</script>
</head>
<body>
	<form id="form0" name="form0" eventProxy="Mform0" method="post" style="margin:0px;position:relative;width:100%;height:100%;" enctype="application/x-www-form-urlencoded" >
		<input type="hidden" id="data" name="data">
		<!-- 当前模板ID -->
		<input type="hidden" id="templateId" name="templateId">
		<input type="hidden" id="nodeName" name="nodeName" value="${param.nodeName}">
		<!-- 父节点ID -->
		<input type="hidden" id="nodeId" name="nodeId" value="${param.nodeId}">
		<input type="hidden" id="templateType" name="templateType" value="${param.templateType}">
		<div tabindex="0" onblur="hideList();" id="toolList" style="z-index:999999;position:absolute;display: none;height:240px;width:160px;background:#fff;box-shadow:2px 2px 5px rgba(185,185,185,.3)">
		<ul>
			<li style="height: 45px;line-height: 45px;font-size: 15px;padding-left: 10px;" onclick="copyTemplate();">复制</li>
			<li class="liDelete" style="height: 45px;line-height: 45px;font-size: 15px;padding-left: 10px;" onclick="deleteData();">删除</li>
			<li style="height: 45px;line-height: 45px;font-size: 15px;padding-left: 10px;" onclick="goMove();">前移</li>
			<li style="height: 45px;line-height: 45px;font-size: 15px;padding-left: 10px;" onclick="backMove();">后移</li>
			<li style="height: 45px;line-height: 45px;font-size: 15px;padding-left: 10px;" onclick="exportCoordination();">导出</li>
			<li class="liImport" style="height: 45px;line-height: 45px;font-size: 15px;padding-left: 10px;" style="display:none;" onclick="importCoordination();">导入事项</li>
		</ul>
		</div>
		<div style="width: 100%;height: 100%;background: rgba(245,245,247,.9);overflow:auto">
			<div id="mainDiv" style="background: rgba(245,245,247,.9);width: 90%;height:100%;margin:auto;">
			</div>
		</div>
	</form>
</body>
</html>