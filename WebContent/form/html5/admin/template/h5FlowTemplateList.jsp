<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//Ddiv HTML 4.01 Transitional//EN" "http://www.w3.org/div/html4/loose.ddiv">
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
		

	//工具按钮点击事件
	function showList(div){
		//将当前ID赋到隐藏于中
		var	uuid = $(div).parent().attr('id');
		var	text = $(div).parent().children(".moveDiv").text();
		if(text.trim()=='文化建设'){
			$('.liDelete').css('display','none');
			$('#toolList').css('height','135px');
		}else{
			$('.liDelete').css('display','');
			$('#toolList').css('height','180px');
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
	
	//工具菜单隐藏
	function hideList(){
		var div = $("#toolList");
        div.css("display", "none");
	}
	
	
	//刷新
	function refreshData(data){
		//2协同事项 3基础数据
		var templateType = $("#templateType").val();
		var json = {};
		json.templateType = templateType;
		if(data!=null){
			json.data = data;
		}
		$.ajax({
			type:'post',
			url:'<%=path %>/templet/tem_h5LoadDataList.action',
			data:json,
			dataType:'json',
			success:function(data){
				var f = document.getElementById("mainDiv"); 
				while(f.hasChildNodes()) //当div下还存在子节点时 循环继续
				{
				    f.removeChild(f.firstChild);
				}

				if(data!=null){
					//var color = ['#f96d64','#ac92ec','#52ce87','#f5c547','#5d9cee'];
					var templateType = $('#templateType').val();
					var html = '';
					html += '<div id="title" style="height: 10%;">';
					html += '<div style="position:relative;left: 70px;top: 50px;display: inline-table;">';
					html += '<div>';
					if(templateType=="2"){
						html += '<span style="font-size: 18px">协同模块管理</span>';
					}else if(templateType=="3"){
						html += '<span style="font-size: 18px">基础数据模块管理</span>';
					}
					html += '</div>';
					html += '</div>';
					html += '<div style="top: 50px;float:right;display: inline-table;right: 50px;">';
					html += '<div style="position: relative;top:50px;right:80px">';
					html += '<img src="<%=path %>/image/query.png" style="position: absolute;left: 10px;top: 12px"/>';
					html += '<input id="search" type="text" placeholder="  输入名称搜索" style="padding:7px 30px;background: #EAECED;width: 250px;height: 40px;border: 0px;border-radius:30px"/>';
					html += '</div>';
					html += '</div>';
					html += '</div>';
					html += '<div style="vertical-align: top;text-align:left;width:100%;padding-left:50px">';
					html += '<div onclick="createTemplate();" class="templateMain" style="transition-property: all;transition-duration: 218ms;width:205px;display:inline-table;background:#fff;line-height:125px;height:130px;box-shadow:2px 2px 5px rgba(185,185,185,.3);border-radius:5px;position: relative;margin: 30px;float: left;text-align: center;">';
					html += '<a style="font-size: 15px;vertical-align: middle;height: 100%">';
					html += '➕新建模块';
					html += '</a>';
					html += '</div>';
					for(var i=0;i<data.length;i++){
						var id = data[i].id;
						var color = data[i].color;
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
						html += '<div tabindex="0" class="templateMain" onclick="clickTem(this);" id="tem'+ num + '_' + id +'" style="transition-property: all;transition-duration: 218ms;width:205px;display:inline-table;background:#fff;height:130px;text-align: center;box-shadow:2px 2px 5px rgba(185,185,185,.3);border-radius:5px;position: relative;margin: 30px;float:left">';
						html += '<div style="width: 100%;height: 8px;background: '+color+'"></div>';
						html += '<div style="transition-property: all;transition-duration: 218ms;margin:20px;background: '+ color +';height: 50px;width: 50px;border-radius:10px;display: inline-table;">';
						<%-- html += '<img src="<%=path %>/image/Option.png" style="background:transparent;margin:10px;height: 30px;width: 30px;"/>'; --%>
						html += '</div>';
						html += '<div class="moveDiv" style="transition-property: all;transition-duration: 218ms;font-size: 15px;width:100px;overflow:hidden;text-overflow:ellipsis;margin:auto;">';
						html += data[i].text;
						html += '</div>';
						html += '<img class="imgButton" tabIndex="'+i+'" src="<%=path %>/image/test1.jpg" style="display:none;height: 15px;width: 15px;position: absolute;right: 8px;bottom: 8px" onclick="showList(this);"/>';
						html += '</div>';
					}
					html += '</div>';
					$("#mainDiv").append(html);
					
					
					//监听显示工具按钮
					$("div[id^='tem']").mouseover(function(){
						$(this).children(".imgButton").css("display","");
					});
					
					$("div[id^='tem']").mouseleave(function(){
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
					
					//div指针变型监听
					$("div[id^=tem]").mouseover(function(){
						$(this).css("cursor","pointer");
					});
						
					$("div[id^=tem]").mouseleave(function(){
						$("li").css("cursor","default");
					});
					
					//div鼠标移过动画效果
					$(".templateMain").mouseover(function(){
						$(this).css("transform","translate(0,-5px)");
						$(this).css("cursor","pointer");
					});
					
					$(".templateMain").mouseleave(function(){
						$(this).css("transform","translate(0,0)");
						$(this).css("cursor","default");

					});
				}
			}
		});
	}

	//删除数据
	function deleteData(){
		var templateId = $("#templateId").val();
		var json = {};
		json.nodeId = templateId;
		json.nodeType = 'directory';
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
							refreshData();
							Matrix.success('删除成功！');
						}
					}
				});
			}
		});
	}
	
	
	//新建子目录
	function createTemplate(){
		var templateType = $("#templateType").val();
		var parentId = '';
		if(templateType=='2'){//协同事项
			parentId = 'flowRoot';
		}else if(templateType=='3'){//基础数据
			parentId = 'yewudibiao';
		}
		layer.open({
	    	id:'layerNewsubdirectory',
			type : 2,//iframe 层
			
			shade: [0.1, '#000'],
			title : ['新建模块'],
			closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '50%', '60%' ],
			content : '<%=request.getContextPath()%>/form/html5/admin/flow/addTemplateList.jsp?addType=dir&parentId='+parentId+'&type='+templateType,
			end	: function(){
				refreshData();
			}
		});
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
			json.templateType = '1';
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
			json.templateType = '1';
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
	
	//修改
	function editTemplate(){
		var templateId = $("#templateId").val();
		layer.open({
	    	id:'layerNewsubdirectory',
			type : 2,//iframe 层
			
			shade: [0.1, '#000'],
			title : ['编辑模块'],
			closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '50%', '50%' ],
			content : '<%=path%>/templet/tem_loadToEditPage.action?status=now&uuid='+templateId,
			end	: function(){
				hideList();
				refreshData();
			}
		});
	}
	
	//点击进入底表列表
	function clickTem(data){
		var templateType = $("#templateType").val();
		var nodeId = data.id;
		nodeId = nodeId.substring(7,nodeId.length);
		window.location.href = "<%=path%>/form/html5/admin/template/h5FormList.jsp?templateType="+templateType+"&nodeId="+nodeId;
	}
	
	

</script>
</head>
<body>
	<%-- <input type="hidden" id="templateType" name="templateType" value="${param.templateType}"> --%>
	<input type="hidden" id="templateType" name="templateType" value="${param.templateType}">
	<input type="hidden" id="templateId" name="templateId">
	<div tabindex="0" onblur="hideList();" id="toolList" style="z-index:999999;position:absolute;display: none;height:180px;width:160px;background:#fff;box-shadow:2px 2px 5px rgba(185,185,185,.3)">
		<ul>
			<li style="height: 45px;line-height: 45px;font-size: 15px;padding-left: 10px;" onclick="editTemplate();">修改</li>
			<li class="liDelete" style="height: 45px;line-height: 45px;font-size: 15px;padding-left: 10px;" onclick="deleteData();">删除</li>
			<li style="height: 45px;line-height: 45px;font-size: 15px;padding-left: 10px;" onclick="goMove();">前移</li>
			<li style="height: 45px;line-height: 45px;font-size: 15px;padding-left: 10px;" onclick="backMove();">后移</li>
		</ul>
	</div>
	<div style="width: 100%;height: 100%;overflow:auto;background: rgba(245,245,247,.9)">
		<div id="mainDiv" style="background: rgba(245,245,247,.9);width: 70%;height:100%;margin:auto;">
			<%-- <div id="title" style="height: 10%;">
				<div style="position:relative;left: 70px;top: 30px;display: inline-table;">
					<div>
						<span style="font-size: 30px">协同子项</span>
					</div>
				</div>
				<div id='search' style="top: 30px;float:right;display: inline-table;right: 50px;">
					<div style="position: relative;top:30px;right:80px">
						<img src="<%=path %>/image/query.png" style="position: absolute;left: 10px;top: 12px"/>
						<input type="text" placeholder="  输入名称搜索" style="padding:7px 30px;background: #EAECED;width: 200px;height: 40px;border: 0px;border-radius:30px"/>
					</div>
				</div>
			</div> --%>
			<%-- <div style="vertical-align: top;text-align:left;width:100%;padding-left:50px">
				<div style="width:205px;display:inline-table;background:#fff;line-height:125px;height:130px;box-shadow:2px 2px 5px rgba(185,185,185,.3);border-radius:5px;position: relative;margin: 20px;float: left;text-align: center;">
					<a style="font-size: 15px;vertical-align: middle;height: 100%">
						➕创建新应用
					</a>
				</div>
				<div id="tem1" style="width:205px;display:inline-table;background:#fff;height:130px;text-align: center;box-shadow:2px 2px 5px rgba(185,185,185,.3);border-radius:5px;position: relative;margin: 20px;float:left">
					<div style="width: 100%;height: 8px;background: #5d9cee"></div>
					<div style="margin:20px;background: #5d9cee;height: 50px;width: 50px;border-radius:10px;display: inline-table;">
						<img src="<%=path %>/image/timg2.jpg" style="background:transparent;margin:10px;height: 30px;width: 30px;"/>
					</div>
					<div style="font-size: 15px;">
						模板1
					</div>
					<img class="imgButton" tabIndex="1" src="<%=path %>/image/test1.png" style="display:none;height: 15px;width: 15px;position: absolute;right: 8px;bottom: 8px" onclick="showList();"/>
				</div>
			</div> --%>
		</div>
	</div>
</body>
</html>