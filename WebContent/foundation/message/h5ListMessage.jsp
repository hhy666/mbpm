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
<link href='<%=path %>/resource/html5/css/style.min.css' rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/css/flat/blue.css'	rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/css/square/blue.css' rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/css/bootstrap-select.css' rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/css/select2.css' rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/assets/toastr-master/toastr.min.css' rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/css/clockpicker.css' rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/css/filecss.css' rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/css/range/ion.rangeSlider.css'	rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/css/range/ion.rangeSlider.skinHTML5.css' rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/assets/bootstrap-table/src/bootstrap-table.css' rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/css/google-code-prettify/bin/prettify.min.css'	rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/css/custom.css' rel="stylesheet"></link>
<link href='<%=path%>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<link rel='stylesheet' href='<%=path%>/resource/html5/themes/default/style.min.css' />
<SCRIPT SRC='<%=path%>/resource/html5/js/jquery.min.js'></SCRIPT>
<SCRIPT SRC='<%=path%>/resource/html5/js/matrix_runtime.js'></SCRIPT>
<SCRIPT SRC='<%=path%>/resource/html5/js/filejs.js'></SCRIPT>
<SCRIPT SRC='<%=path%>/resource/html5/js/range/ion.rangeSlider.min.js'></SCRIPT>
<script src='<%=path%>/resource/html5/js/suggest/bootstrap-suggest.min.js'></script>
<SCRIPT	SRC='<%=path%>/resource/html5/assets/toastr-master/toastr.min.js'></SCRIPT>
<script type="text/javascript" src="<%=path%>/resource/js/office.js"></script>

<SCRIPT>
	var webContextPath = "/mofficeV3";
</SCRIPT>
<title>消息列表</title>
<head>

<script type="text/javascript">
	<%-- var jsonStr = <%=request.getAttribute("lists")%>;
	//var jsonObj = JSON.parse(jsonStr);
		alert(jsonStr[1].subjectValue); --%>
	/* function lookForm(){
		var select = Matrix.getDataGridSelection('DataGrid001');
		alert(selsct);
	} */
	
	function ReadMessage(){
		var selects = Matrix.getGridSelections("DataGrid001"); 
		if(selects.length != 0){
			if(selects.length > 1){
				Matrix.warn('只能选中一条！')
			}else{
				doubleClickReadMessage(selects[0].url,selects[0].messageId);
			}
		}else{
			Matrix.warn('未选中消息!');
		}			
	}
	
	function doubleClickReadMessage(url,messageId){
		if(url == null || url == ""){ 
        	/* url = 'message_infoMessage.action?readMessage=true&messageId=' + messageId;
        	window.open(url,
        			'height =  100,',
        			'wigth = 400'		
        	);*/			
			url="foundation/message_infoMessage.action?readMessage=true";
        	var initSrc = "<%=path%>/"+url+"&flag=1&messageId="+messageId;
			//window.open(initSrc,'_blank','height=450px,wigth=800px');
        	openCtpWindow({'url':initSrc,'title':'消息内容'});
		}else if(url!=null &&url.indexOf("readMessage=true")>=0){//单纯的发消息
			var initSrc = "<%=path%>/"+url+"&flag=1&messageId="+messageId;
			//window.open(initSrc,'_blank','height=450px,wigth=800px');
			openCtpWindow({'url':initSrc,'title':'消息内容'});
		}else{
			if(url.indexOf("FlowFrame")>=0){
				var tindex = url.indexOf("taskId=");
				var mindex = url.indexOf("&mBizId");
				var value = url.substring(tindex+7,mindex);
				var getStatusUrl = "<%=path%>/foundation/message_getByTaskId.action?taskId="+value;
				Matrix.sendRequest(getStatusUrl,null,function(data){
					if(data!=null&&data.data!="")
							if(data.data==1){
								urlValue = "<%=path%>/"+url+"&mHtml5Flag=true";
								openCtpWindow({'url':urlValue,'title':'消息内容'});
							}if(data.data==2){
								Matrix.warn("该任务正在被别人处理！");
								return false;
							}if(data.data==3){
								Matrix.warn("该任务已被处理！");
								return false;
							}if(data.data==4){
								Matrix.warn("该任务已被别人处理！");
								return false;
							}
					});
				}else{
						urlValue = "<%=request.getContextPath()%>/"+url+"&mHtml5Flag=true";
								openCtpWindow({'url':urlValue,'title':'消息内容'}); 
				}
				//打开之后 修改为已读
				if(messageId!=null && messageId.length>0){
					var updateStatusUrl = "<%=request.getContextPath()%>/foundation/message_updateMessageStatus.action?messageId="+messageId;
					Matrix.sendRequest(updateStatusUrl,null,function(){
						Matrix.refreshDataGridData('DataGrid001');
					});
				}
			}
		}	
		
	function quaryBy(){
		<%-- 
		var updateStatusUrl = '<%=path%>/foundation/message_bootStrapTable.action?subjectValue=' + subjectValue + '&conditionType=' + conditionType;
		Matrix.sendRequest(updateStatusUrl,null,function(){
		});  --%>
			Matrix.refreshDataGridData('DataGrid001');
	}
		  <%-- $(function(){
			 $("#MtoolBarItem").click(function(){
				 $.ajax({
					 type:"get",
					 url:"'<%=path%>/foundation/message_bootStrapTable.action?subjectValue=' + subjectValue + '&conditionType=' + conditionType",
					 success: function(data){
	                       alert(123);
	                  }
				 });
			 });
		 });  --%>
	
	function deleteButton(){
		//var selects = Matrix.getGridSelections(DataGrid001);
	 	var selects = Matrix.getGridSelections("DataGrid001"); 
		var messageIds=[];
		var flag = true;//默认都已读 
		var data="{'messageIds':'";
		if(selects.length == 0){
			Matrix.warn('未选中消息!');
			return;
		}else{
			for(var i=0;i<selects.length;i++){
				if(selects[i].isReaded!=1){
					flag = false;
				}
				data+=selects[i].messageId;
				if(i!=selects.length-1){
					data+=",";
				}
			}
			data+="'}";
			confirmFlag(flag,data,selects.length);
		}
	}
	
	function confirmFlag(flag,data,rows){
		if(flag == false){
			Matrix.confirm("有未读的消息,确认删除这"+rows+"条消息吗?",function(value){
				if(!value){
					deleteMessages(data);
				}
			});
		}else{
			Matrix.confirm("确认删除这"+rows+"条消息吗?",function(value){
				if(!value){
					deleteMessages(data);
				}
			});
		}
	}
	
	function deleteMessages(data){
		var url ="<%=path%>/foundation/message_deleteMessage.action";
		var synJson = eval('(' + data + ')');
		Matrix.sendRequest(url,synJson,function(data){
		    var json = eval('(' + data.data + ')');
			if(json.result == true){
				Matrix.refreshDataGridData('DataGrid001');
				Matrix.warn("删除成功!");
			}else{
				Matrix.warn("未能删除!");
			}
		});
	}
</script>
</head>
<body>
	<div style="width: 100%; height: 100%; overflow: auto; position: relative;">
		<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="form0" value="form0" />
			<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid001"/>
			<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
			<input type="hidden" id="messageId" value="${param.messageId }">
			<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
			<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
			<div style="display: block">
				<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
					<tr style=" height: 0px">
						<td class="query_form_toolbar" icolspan="2" style="padding: 3px">
							<div style="height:40px;padding:4px;background: #f8f8f8;text-align: left;border: 1px solid #E6E9ED ">
								<label style="padding-left: 5px">主题:</label>
								<div style="padding-right: 5px;display: inline-block;vertical-align: middle;">
									<input class="form-control" type="text" style="" name="subjectValue" id="subjectValue" >
								</div>
								<label style="padding-left: 5px">状态:</label>
								<div style="padding-right: 5px;display: inline-block;vertical-align:middle;">
									<select class="form-control select2-accessible" name="conditionType" id="conditionType">
										<option value="0" selected="selected">未读</option>
										<option value="1">已读</option>
										<option value="-1">全部</option>
									</select>
								</div>
								<div style="padding-right: 5px;display: inline-block;vertical-align:middle;">
									<input type="button" value="查询" class="btn  btn-default toolBarItem" id="MtoolBarItem" style="border:0;background: transparent" onclick="quaryBy()">
								</div>
								<div style="padding-right: 5px;display: inline-block;vertical-align:middle;">
									<input type="button" value="查看" class="btn  btn-default toolBarItem" id="MtoolBarItem001" style="border:0;background: transparent" onclick="ReadMessage()">
								</div>
								<div style="padding-right: 5px;display: inline-block;vertical-align:middle;">
									<input type="button" value="删除" class="btn  btn-default toolBarItem" id="MtoolBarItem002" style="border:0;background: transparent" onclick="deleteButton()" / >
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="border-style:none;width:100%;margin:0px;padding:0px;vertical-align: top;">
							
						</td>
					</tr>
				</table>
			</div>
			<div style="display: block;height: 80%;overflow: auto;">
				<table id="DataGrid001_table" style="width:100%;height:100%;">
							<script>
								$(document).ready(function(){
									/* var subjectValue = document.getElementById('subjectValue').value;
									var conditionType = document.getElementById('conditionType').value; */
									$("#DataGrid001_table").bootstrapTable({
										classes:'table table-bordered table-striped',
										method:'post',
										url:'<%=path%>/foundation/message_h5listMessage.action',
										search: false, 
										sidePagination: "server", 
										singleSelect: false,
										clickToSelect: true, 
										sortable: false,   
										pagination: true,
										onDblClickRow:function(row){
											doubleClickReadMessage(row.url,row.messageId);
										},
										queryParams: function(params){
											var param = {
												offset: params.offset,
												limit:params.limit
											}
											param["subjectValue"] = document.getElementById('subjectValue').value;
											param["conditionType"] = document.getElementById('conditionType').value;
								            var form = document.getElementById('form0');
								            var tagElements = form.getElementsByTagName('input');
								            for (var j = 0; j < tagElements.length; j++) {
								                param[tagElements[j].name] = tagElements[j].value;
								            };
								            var tagElements2 = form.getElementsByTagName('select');
								            for (var j = 0; j < tagElements2.length; j++) {
								                param[tagElements2[j].name] = tagElements2[j].value;
								            };
											return param;
										},
										//singleSelect:true,
										//sortable:false,
										pageSize:10,
										pageList:[10,20,30,40],
										formatLoadingMessage: function() {
							            return '请稍等，正在加载中...';
								        },
								        formatNoMatches: function() {
								            return '无符合条件的记录';
								        },
										columns:[{
											title:' ',
								            checkbox: true
								        },{
											title:'&nbsp;',
											 formatter: function (value, row, index) { 
												var pageSize = $("#DataGrid001_table").bootstrapTable('getOptions').pageSize;
												var pageNumber = $("#DataGrid001_table").bootstrapTable('getOptions').pageNumber;
						                            return pageSize * (pageNumber - 1) + index + 1;  
						                        }
										},{
											field:'subjectValue',
											title:'主题',
											editorType:'Text',
											clickToSelect: true,
											type:'text'
										},{
											field:'createdDate',
											title:'创建时间',
											editorType:'Text',
											clickToSelect: true,
											type:'Text'
										},{
											field:'isReaded',
											title:'是否已读',
											editorType:'Text',
											clickToSelect: true,
											type:'text',
											formatter: function (value, row, index){ // 单元格格式化函数
												var text = '-';
												if (value == 1) {
												    text = "已读";
												} else if (value == 0) {
												    text = "未读";
												}
												return text;
											}
										}]
										
									});
								});
							</script>
						</table>
			</div>
			
		</form>
	</div>
			
			
			<%-- <table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
				<tr style=" height: 0px">
					<td class="query_form_toolbar"icolspan="2">
						<div style="height:40px;padding:4px;background: #f8f8f8;text-align: left; ">
							<label style="padding-left: 5px">主题:</label>
							<div style="padding-right: 5px;display: inline-block;">
								<input type="text" style="width: 140px;height: 20px;" name="subjectValue" >
							</div>
							<label style="padding-left: 5px">状态:</label>
							<div style="padding-right: 5px;display: inline-block;">
								<select name="conditionType">
									<option value="0" selected="selected">未读</option>
									<option value="1">已读</option>
									<option value="-1">全部</option>
								</select>
							</div>
							<button class="btn  btn-default toolBarItem" id="MtoolBarItem" style="border:0;background: transparent" onclick="">
								查询
							</button>
							<button class="btn  btn-default toolBarItem" id="MtoolBarItem001" style="border:0;background: transparent" onclick="lookForm()">
								查看
							</button>
							<button class="btn  btn-default toolBarItem" id="MtoolBarItem002" style="border:0;background: transparent" onclick="">
								删除
							</button>
						</div>
					</td>
				</tr>
				<tr>
					<td style="border-style:none;width:100%;margin:0px;padding:0px;vertical-align: top;">
						<table id="table001" class="table table-hover table-no-bordered table-striped" style="height: 100%;width: 100%">
							<thead>
								<tr style="background: #b5dbeb;">
									<th style="width: 2%;">
										<div>&nbsp;</div>
									</th>
									<th style="width: 40%;"
										<div>主题</div>
									</th>
									<th style="width: 29%;">
										<div>接收时间</div>
									</th>
									<th style="width: 29%;">
										<div>是否已读</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<script>
									var jsonStr = <%=request.getAttribute("lists")%>;
									var curPageNum = <%=request.getAttribute("curPageNum")%>;
									var pageSize = <%=request.getAttribute("pageSize")%>;
									for(var i=(curPageNum-1)*10;i<pageSize;i++){
										document.write("<tr>");
										document.write("<td>"+(i+1)+"</td>");
										document.write("<td>"+jsonStr[i].subjectValue+"</td>");
										document.write("<td>"+jsonStr[i].createdDate+"</td>");
										document.write("<td>"+jsonStr[i].isReaded+"</td>");
										document.write("<tr>");
									}
								</script>
							</tbody>
						</table>
					</td>
				</tr>
			</table> --%>
				
	<SCRIPT SRC='<%=path %>/resource/html5/js/jquery.inputmask.bundle.min.js'></SCRIPT>
	<SCRIPT	SRC='<%=path %>/resource/html5/css/bootstrap/dist/js/bootstrap.min.js'></SCRIPT>
	<SCRIPT	SRC='<%=path %>/resource/html5/js/icheck.min.js'></SCRIPT>
	<SCRIPT	SRC='<%=path %>/resource/html5/js/bootstrap-select.js'></SCRIPT>
	<SCRIPT	SRC='<%=path %>/resource/html5/js/select2.js'></SCRIPT>
	<SCRIPT	SRC='<%=path %>/resource/html5/js/content.min.js'></SCRIPT>
	<SCRIPT	SRC='<%=path %>/resource/html5/js/layer.min.js'></SCRIPT>
	<SCRIPT	SRC='<%=path %>/resource/html5/js/autosize.min.js'></SCRIPT>
	<SCRIPT	SRC='<%=path %>/resource/html5/js/laydate/laydate.js'></SCRIPT>
	<SCRIPT	SRC='<%=path %>/resource/html5/js/clockpicker.js'></SCRIPT>
	<SCRIPT	SRC='<%=path %>/resource/html5/js/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js'></SCRIPT>
	<SCRIPT	SRC='<%=path %>/resource/html5/js/jquery.hotkeys/jquery.hotkeys.js'></SCRIPT>
	<SCRIPT	SRC='<%=path %>/resource/html5/css/google-code-prettify/src/prettify.js'></SCRIPT>
	<SCRIPT	SRC='<%=path %>/resource/html5/js/validator.js'></SCRIPT>
	<script	src='<%=path %>/resource/html5/js/jstree.min.js'></script>
	<script	src='<%=path %>/resource/html5/assets/bootstrap-table/src/bootstrap-table.js'></script>
</body>
</html>