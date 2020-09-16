<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title></title>
		<script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
		<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<script type="text/javascript">
		//电脑端弹出输出数据项窗口
		function openOutData(formFlag,mBizId,formId,flag){
			 layer.open({
				    id:'layer03',
					type : 2,
					
					title : ['电脑端设置输出数据项'],
					shadeClose: false, //开启遮罩关闭
					area : [ '90%', '90%' ],
					content : "<%=request.getContextPath()%>/form/admin/custom/utilization/outData.jsp?formFlag="+formFlag+"&flag="+flag+"&mBizId="+mBizId+"&formId="+formId+"&iframewindowid=layer03"
			 });
		}
		
		//移动端弹出输出数据项窗口回调
		function onlayer03Close(selectedItems){
			 var iframe = document.getElementsByTagName("iframe")[0].contentWindow;
			  if(selectedItems!=null && selectedItems!=""){
				if(selectedItems!=true){
				var data="";
				var value="["
				var sign=Matrix.getFormItemValue('flag');
				for(var i=0;i<selectedItems.length;i++){
					var resl=selectedItems[i].formId.split(".");
					if(sign==""||sign==null||sign=='undefined'){
					if(resl[0]!='${param.formFlag}'){
						Matrix.setFormItemValue('flag',resl[0]);
					}
				}
					if(i==selectedItems.length-1){
						data+=selectedItems[i].name;
					value+="{\'name\':\'"
					value+=selectedItems[i].name;
					value+="\',\'formId\':\'"	
					value+=selectedItems[i].formId;
					value+="\',\'enType\':\'"
					value+=selectedItems[i].enType;
					value+="\',\'edType\':\'"
					value+=selectedItems[i].edType;
					value+="\',\'style\':\'"
					if(selectedItems[i].style!=""&&selectedItems[i].style!=null&&selectedItems[i].style!='undefined'){
					value+=selectedItems[i].style;
					}
					value+="\',\'options\':\'"
					if(selectedItems[i].options!=""&&selectedItems[i].options!=null&&selectedItems[i].options!='undefined'){
					value+=selectedItems[i].options;
					}
					value+="\',\'width\':\'"
					if(selectedItems[i].width!=""&&selectedItems[i].width!=null&&selectedItems[i].width!='undefined'){
					value+=selectedItems[i].width;
					}
					value+="\',\'codeId\':\'"
					if(selectedItems[i].codeId!=""&&selectedItems[i].codeId!=null&&selectedItems[i].codeId!='undefined'){
					value+=selectedItems[i].codeId;
					}
					value+="\',\'dataType\':\'"
					if(selectedItems[i].dataType!=""&&selectedItems[i].dataType!=null&&selectedItems[i].dataType!='undefined'){
					value+=selectedItems[i].dataType;
					}
					value+="\'}";
					}else{
					data+=selectedItems[i].name;
					data+=',';
					value+="{\'name\':\'"
					value+=selectedItems[i].name;
					value+="\',\'formId\':\'"
					value+=selectedItems[i].formId;
					value+="\',\'enType\':\'"
					value+=selectedItems[i].enType;
					value+="\',\'edType\':\'"
					value+=selectedItems[i].edType;
					value+="\',\'style\':\'"
					if(selectedItems[i].style!=""&&selectedItems[i].style!=null&&selectedItems[i].style!='undefined'){
					value+=selectedItems[i].style;
					}
					value+="\',\'options\':\'"
					if(selectedItems[i].options!=""&&selectedItems[i].options!=null&&selectedItems[i].options!='undefined'){
					value+=selectedItems[i].options;
					}
					value+="\',\'width\':\'"
					if(selectedItems[i].width!=""&&selectedItems[i].width!=null&&selectedItems[i].width!='undefined'){
					value+=selectedItems[i].width;
					}
					value+="\',\'codeId\':\'"
					if(selectedItems[i].codeId!=""&&selectedItems[i].codeId!=null&&selectedItems[i].codeId!='undefined'){
					value+=selectedItems[i].codeId;
					}
					value+="\',\'dataType\':\'"
					if(selectedItems[i].dataType!=""&&selectedItems[i].dataType!=null&&selectedItems[i].dataType!='undefined'){
					value+=selectedItems[i].dataType;
					}
					value+="\'},";
					}
				}
				value+="]"
		      	iframe.Matrix.setFormItemValue('displayItems',data);
				iframe.Matrix.setFormItemValue('displayItemsVal',value);
			
			}else{
				iframe.Matrix.setFormItemValue('displayItems',"");
				iframe.Matrix.setFormItemValue('displayItemsVal',"");
				parent.showListName=[];
			}  
	      }
			
		}
		
		//移动端弹出输出数据项窗口
		function openMobileOutData(formFlag,mBizId,formId,flag){
			 layer.open({
				    id:'layer07',
					type : 2,
					
					title : ['设置移动端输出数据项'],
					shadeClose: false, //开启遮罩关闭
					area : [ '90%', '90%' ],
					content : "<%=request.getContextPath()%>/form/admin/custom/utilization/mobileOutData.jsp?formFlag="+formFlag+"&flag="+flag+"&mBizId="+mBizId+"&formId="+formId+"&iframewindowid=layer07"
			 });
		}
		
		//移动端弹出输出数据项窗口回调
		function onlayer07Close(selectedItems){
			 var iframe = document.getElementsByTagName("iframe")[0].contentWindow;
			  if(selectedItems!=null && selectedItems!=""){
				if(selectedItems!=true){
				var data="";
				var value="["
				var sign=Matrix.getFormItemValue('flag');
				for(var i=0;i<selectedItems.length;i++){
					var resl=selectedItems[i].formId.split(".");
					if(sign==""||sign==null||sign=='undefined'){
					if(resl[0]!='${param.formFlag}'){
						Matrix.setFormItemValue('flag',resl[0]);
					}
				}
					if(i==selectedItems.length-1){
						data+=selectedItems[i].name;
					value+="{\'name\':\'"
					value+=selectedItems[i].name;
					value+="\',\'formId\':\'"	
					value+=selectedItems[i].formId;
					value+="\',\'enType\':\'"
					value+=selectedItems[i].enType;
					value+="\',\'edType\':\'"
					value+=selectedItems[i].edType;
					value+="\',\'style\':\'"
					if(selectedItems[i].style!=""&&selectedItems[i].style!=null&&selectedItems[i].style!='undefined'){
					value+=selectedItems[i].style;
					}
					value+="\',\'options\':\'"
					if(selectedItems[i].options!=""&&selectedItems[i].options!=null&&selectedItems[i].options!='undefined'){
					value+=selectedItems[i].options;
					}
					value+="\',\'width\':\'"
					if(selectedItems[i].width!=""&&selectedItems[i].width!=null&&selectedItems[i].width!='undefined'){
					value+=selectedItems[i].width;
					}
					value+="\',\'codeId\':\'"
					if(selectedItems[i].codeId!=""&&selectedItems[i].codeId!=null&&selectedItems[i].codeId!='undefined'){
					value+=selectedItems[i].codeId;
					}
					value+="\',\'dataType\':\'"
					if(selectedItems[i].dataType!=""&&selectedItems[i].dataType!=null&&selectedItems[i].dataType!='undefined'){
					value+=selectedItems[i].dataType;
					}
					value+="\'}";
					}else{
					data+=selectedItems[i].name;
					data+=',';
					value+="{\'name\':\'"
					value+=selectedItems[i].name;
					value+="\',\'formId\':\'"
					value+=selectedItems[i].formId;
					value+="\',\'enType\':\'"
					value+=selectedItems[i].enType;
					value+="\',\'edType\':\'"
					value+=selectedItems[i].edType;
					value+="\',\'style\':\'"
					if(selectedItems[i].style!=""&&selectedItems[i].style!=null&&selectedItems[i].style!='undefined'){
					value+=selectedItems[i].style;
					}
					value+="\',\'options\':\'"
					if(selectedItems[i].options!=""&&selectedItems[i].options!=null&&selectedItems[i].options!='undefined'){
					value+=selectedItems[i].options;
					}
					value+="\',\'width\':\'"
					if(selectedItems[i].width!=""&&selectedItems[i].width!=null&&selectedItems[i].width!='undefined'){
					value+=selectedItems[i].width;
					}
					value+="\',\'codeId\':\'"
					if(selectedItems[i].codeId!=""&&selectedItems[i].codeId!=null&&selectedItems[i].codeId!='undefined'){
					value+=selectedItems[i].codeId;
					}
					value+="\',\'dataType\':\'"
					if(selectedItems[i].dataType!=""&&selectedItems[i].dataType!=null&&selectedItems[i].dataType!='undefined'){
					value+=selectedItems[i].dataType;
					}
					value+="\'},";
					}
				}
				value+="]"
		      	iframe.Matrix.setFormItemValue('mobileDisplayItems',data);
				iframe.Matrix.setFormItemValue('mobileDisplayItemsVal',value);
			
			}else{
				iframe.Matrix.setFormItemValue('mobileDisplayItems',"");
				iframe.Matrix.setFormItemValue('mobileDisplayItemsVal',"");
				parent.showMobileListName=[];
			}  
	      }
			
		}
		
		//弹出排序设置窗口
		function openSetSort(formFlag,mBizId,formId){
			 layer.open({
				    id:'layer02',
					type : 2,
					
					title : ['设置输出数据项排序'],
					shadeClose: false, //开启遮罩关闭
					area : [ '70%', '90%' ],
					content : "<%=request.getContextPath()%>/form/admin/custom/utilization/sortSet.jsp?formFlag="+formFlag+"&mBizId="+mBizId+"&formId="+formId+"&iframewindowid=layer02"
			 });
		}
		
		//弹出排序设置窗口回调
		function onlayer02Close(selectedItems){
			debugger;
			  var iframe = document.getElementsByTagName("iframe")[0].contentWindow;
			    if(selectedItems!=null && selectedItems!=""){
				if(selectedItems!=true){
					var data="";
					var value="";
					for(var i=0;i<selectedItems.length;i++){
					var resl="";
					if(selectedItems[i].formId.indexOf(".") != -1){
						resl=selectedItems[i].formId.split(".");
						data+=selectedItems[i].name;
						if(i!=selectedItems.length-1){
						data+=',';
						}
						value+=resl[1];
						value+=' ';
						value+=selectedItems[i].type;
						value+=',';
					}else{
						resl=selectedItems[i].formId;
						data+=selectedItems[i].name;
						if(i!=selectedItems.length-1){
						data+=',';
						}
						value+=resl;
						value+=' ';
						value+=selectedItems[i].type;
						value+=',';
					}
					}
		      		iframe.Matrix.setFormItemValue('sortSet',data);
					iframe.Matrix.setFormItemValue('sortSetVal',value);
					
				}else{
					iframe.Matrix.setFormItemValue('sortSet',"");
					iframe.Matrix.setFormItemValue('sortSetVal',"");
				} 
		      } 
			  parent.sortName=[];
		}
		
		//应用设置弹出系统查询条件
		function openUtilSysCondiation(formFlag,flag,formId,firstCondition){
			layer.open({
		    	id:'layer01',
				type : 2,
				
				title : ['设置系统查询条件'],
				//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '70%', '80%' ],
				content : "<%=path%>/utilization/form_condition.action?iframewindowid=layer01&formFlag="+formFlag+"&flag="+flag+"&formId="+formId+"&firstCondition="+encodeURI(firstCondition)
			});			
		}
		
		//应用设置弹出系统查询条件回调
	    function onlayer01Close(data){
			var iframe = document.getElementsByTagName("iframe")[0].contentWindow;
			if(data!=null && data!=""){
				var data=eval("("+data+")")
		      	iframe.Matrix.setFormItemValue('sysQueryCondition',data.conditionText);
				iframe.Matrix.setFormItemValue('sysQueryConditionVal',data.conditionVal);
		    }else if(typeof(data) == "undefined"){
			
			}else{
				iframe.Matrix.setFormItemValue('sysQueryCondition',"");
				iframe.Matrix.setFormItemValue("sysQueryConditionVal","");
			}
	    }
		
	  //弹出高级查询条件窗口
		function openhignCondition(formFlag,flag,formId){
			layer.open({
			    id:'layer05',
				type : 2,
				
				title : ['设置高级查询条件'],
				shadeClose: false, //开启遮罩关闭
				area : [ '70%', '90%' ],
				content : "<%=request.getContextPath()%>/form/admin/custom/utilization/seniorSelectCondition.jsp?formFlag="+formFlag+"&flag="+flag+"&formId="+formId+"&iframewindowid=layer05"
		 });
		}
	  
		//弹出高级查询条件窗口回调
		function onlayer05Close(selectedItems){
			var iframe = document.getElementsByTagName("iframe")[0].contentWindow;
			   if(selectedItems!=null && selectedItems!=""){
					if(selectedItems!=true){
					var data="";
					var value="";
					for(var i=0;i<selectedItems.length;i++){
						var arr=selectedItems[i].formId;
						if(i==selectedItems.length-1){
							data+=selectedItems[i].name;
							value+=selectedItems[i].formId;
									
					    }else{
							data+=selectedItems[i].name;
						    data+=',';
							value+=selectedItems[i].formId;
						    value+=',';
						}
				    }
			      	iframe.Matrix.setFormItemValue('sysSeniorCondition',data);
					iframe.Matrix.setFormItemValue('sysSeniorConditionVal',value);
					
				}else{
					iframe.Matrix.setFormItemValue('sysSeniorCondition',"");
					iframe.Matrix.setFormItemValue('sysSeniorConditionVal',"");
			  	}  
			  	
		      }
				parent.hignCondition=[];
		}
		
		//弹出应用授权窗口
		function openAddAuthority(){
			layer.open({
			    id:'layer06',
				type : 2,
				
				title : ['设置应用授权'],
				shadeClose: false, //开启遮罩关闭
				area : [ '70%', '90%' ],
				content : "<%=request.getContextPath()%>/MixSelect.rform?add=update&iframewindowid=layer06"
		 });
		}
		
		//弹出应用授权窗口回调
		function onlayer06Close(data){
			debugger;
			var iframe = document.getElementsByTagName("iframe")[0].contentWindow;
			if(data!=null){
				  var userNames = data.allNames;
		           var adminId = data.allIds;
		           iframe.Matrix.setFormItemValue('authId',adminId);
		           iframe.Matrix.setFormItemValue('authority',userNames);
			}else{
				//iframe.Matrix.setFormItemValue('authId',"");
				//iframe.Matrix.setFormItemValue('authority',"");
		    }
			parent.authUser = {};	
		}
		
    function add(){
    //清空回掉数据
    			parent.parent.data = [];
		parent.parent.sortName = [];
	parent.parent.showListName = [];
	parent.parent.userInputCondition=[];
	parent.parent.customCondition=[];
			var url = "<%=request.getContextPath()%>/query/query_getUUID.action";
							dataSend(null,url,"POST",function(data2){
						    var callbackStr = data2.data;
						    var callbackJson = isc.JSON.decode(callbackStr);
						    if(callbackJson!=null){
						    	// ("HorizontalContainer001Panel2").setContentsURL(src);
						      	  var src = webContextPath+"/form/admin/custom/utilization/utilizationSet.jsp?formFlag=${formFlag}&catalogId=${param.catalogId}&oType=add&formId=${param.formId}&uuid="+callbackJson.uuid;
            					 Matrix.getMatrixComponentById("HorizontalContainer001Panel2").setContentsURL(src);
						    }else{
						    	parent.isc.say('删除失败');
						    }
						    
							},null);
    }
    function editor(){
    		Matrix.refreshDataGridData('DataGrid001');
    		 var selectData=Matrix.getDataGridSelection('DataGrid001');
    		 if(selectData.size()==0||selectData.size()>1){
          		 Matrix.warn('请选择一行数据！');}
			else{
    		 var uuid=selectData[0].uuid;
             var src = webContextPath+"/utilization/utili_getListById.action?formFlag=${formFlag}&oType=update&catalogId=${param.catalogId}&formId=${param.formId}&uuid="+uuid;
             Matrix.getMatrixComponentById("HorizontalContainer001Panel2").setContentsURL(src);}
    }
    //点击跳转
    function onClick(){
    	parent.parent.data = [];
		parent.parent.sortName = [];
	parent.parent.showListName = [];
	parent.parent.userInputCondition=[];
	parent.parent.customCondition=[];
    var selectData= MDataGrid001.getSelection();
     if(selectData.size()!=0&&selectData!=null){
     var uuid=selectData[0].uuid;
             var src = webContextPath+"/utilization/utili_getListById.action?formFlag=${formFlag}&oType=update&catalogId=${param.catalogId}&formId=${param.formId}&uuid="+uuid;
             Matrix.getMatrixComponentById("HorizontalContainer001Panel2").setContentsURL(src);
     }
    }
     function del(){
    		 var selectList=Matrix.getDataGridSelection('DataGrid001');
    		  if(selectList.size()!=1){
          		 Matrix.warn('请选择一行数据！');}
			else{
    		 var uuid=selectList[0].uuid;
             var data2 = {'data':{'uuid':uuid}};
							var url = "<%=request.getContextPath()%>/utilization/utili_delete.action";
							dataSend(data2,url,"POST",function(data2){
						    var callbackStr = data2.data;
						    var callbackJson = isc.JSON.decode(callbackStr);
						    if(callbackJson!=null&&callbackJson.result==true){
						    	// parent.parent.Matrix.forceFreshTreeNode("Tree0", "${param.parentNodeId}");
							   	 	Matrix.refreshDataGridData('DataGrid001');
							   	 	var src = "<%=request.getContextPath()%>/editor/common/empty.html";
												Matrix.getMatrixComponentById("HorizontalContainer001Panel2").setContentsURL(src);
						      	  
						    }else{
						    	parent.isc.say('删除失败');
						    }
						    
							},null);}
    }
    function copyData(){
    		 var selectList=Matrix.getDataGridSelection('DataGrid001');
    		  if(selectList.size()!=1){
          		 Matrix.warn('请选择一行数据！');}
			else{
    		 var uuid=selectList[0].uuid;
             var data2 = {'data':{'uuid':uuid,'catalogId':'${param.catalogId}'}};
							var url = "<%=request.getContextPath()%>/utilization/utili_copyData.action?formId=${param.formId}";
							dataSend(data2,url,"POST",function(data2){
						    var callbackStr = data2.data;
						    var callbackJson = isc.JSON.decode(callbackStr);
						    if(callbackJson!=null&&callbackJson.result==true){
						    	// parent.parent.Matrix.forceFreshTreeNode("Tree0", "${param.parentNodeId}");
							   	 	Matrix.refreshDataGridData('DataGrid001');
							   	 	//加载报错，暂不刷新
							   //	 	var src = "<%=request.getContextPath()%>/utilization/utili_getListById.action?uuid="+callbackJson.uuid+"&formId=${param.formId}&catalogId=${param.catalogId}&formFlag=${formFlag}&oType=update";
								//				Matrix.getMatrixComponentById("HorizontalContainer001Panel2").setContentsURL(src);
						      	  
						    }else{
						    	parent.isc.say('复制失败');
						    }
						    
							},null);
			}
    }
    function refresh(){
    	Matrix.refreshDataGridData('DataGrid001');
    }
    <%--上移--%>
    function moveUp(uuid,index){
    	var selectedRow = index;
    	var curPageFirstRow = MDataGrid001.getData().get(0).index;
    	if(selectedRow==curPageFirstRow) return;
    	var beforeSelected;
    	for(var i = 0;i<MDataGrid001.getData().length;i++){
    		if(MDataGrid001.getData().get(i).uuid==uuid){
    			beforeSelected = MDataGrid001.getData().get(i-1).uuid;
    		}
    	}
		var url = "<%=request.getContextPath()%>/utilization/utili_moveUp.action";
		var newData = "{'beforeSelected':'"+beforeSelected+"','uuid':'"+uuid+"','catalogId':'${param.catalogId}'}";
		var synJson = isc.JSON.decode(newData);
		Matrix.sendRequest(url,synJson,function(data){
			if(data.data){
				var json = isc.JSON.decode(data.data);
				if(json.result==true){
					Matrix.refreshDataGridData('DataGrid001');
				}
			}
		});
    }
    <%--下移--%>
    function moveDown(uuid,index){
    	var selectedRow = index;
    	var curPageLastRow = MDataGrid001.getData().get(MDataGrid001.getData().length-1).index;
    	if(selectedRow==curPageLastRow)return;
    	var nextSelected;
    	for(var i = 0;i<MDataGrid001.getData().length;i++){
    		if(MDataGrid001.getData().get(i).uuid==uuid){
    			nextSelected = MDataGrid001.getData().get(i+1).uuid;
    		}
    	}
    	var url = "<%=request.getContextPath()%>/utilization/utili_moveDown.action";
		var newData = "{'nextSelected':'"+nextSelected+"','uuid':'"+uuid+"','catalogId':'${param.catalogId}'}";
		var synJson = isc.JSON.decode(newData);
		Matrix.sendRequest(url,synJson,function(data){
			if(data.data){
				var json = isc.JSON.decode(data.data);
				if(json.result==true){
					//MDataGrid001.removeSelectedData();
					Matrix.refreshDataGridData('DataGrid001');
				}
			}
		});
    }
</script>
	</head>
	<body>
		<div id='loading' name='loading' class='loading'>
			<script>Matrix.showLoading();</script>
		</div>

		<script> var Mform0=isc.MatrixForm.create({ID:"Mform0",
		name:"Mform0",
		position:"absolute",
		action:"<%=request.getContextPath()%>/utilization/utili_loadDataGridData.action?catalogId=${param.catalogId}",
		canSelectText : true,
		fields : [ {
			name : 'form0_hidden_text',
			width : 0,
			height : 0,
			displayId : 'form0_hidden_text_div'
		} ]
	});
</script>
		<div
			style="width: 100%; height: 100%; overflow: auto; position: relative;">
			<form id="form0" name="form0" eventProxy="Mform0" method="post"
				action="<%=request.getContextPath()%>/utilization/utili_loadDataGridData.action?catalogId=${param.catalogId}"
				style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="form0" value="form0" />
				<input type="hidden" name="is_mobile_request" />
				<input type="hidden" id="matrix_form_datagrid_form0"
					name="matrix_form_datagrid_form0" value="" />
				<div type="hidden" id="form0_hidden_text_div"
					name="form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
				<input type="hidden" name="javax.matrix.faces.ViewState"
					id="javax.matrix.faces.ViewState" value="" />
				<input type="hidden" id="uuid" name="uuid">
				<input type="hidden" id="catalogId" name="catalogId"
					value="${param.catalogId}" />
				<input type="hidden" id="formId" name="formId"
					value="${param.formId}" />
				<div id="HorizontalContainer001_div" class="matrixInline"
					style="width: 100%; height: 100%;; overflow: hidden;">
					<script>
	isc.HLayout.create( {
		ID : "MHorizontalContainer001",
		displayId : "HorizontalContainer001_div",
		position : "relative",
		height : "100%",
		width : "100%",
		align : "center",
		overflow : "auto",
		defaultLayoutAlign : "center",
		members : [ isc.MatrixHTMLFlow.create( {
			ID : "MHorizontalContainer001Panel1",
			width : '30%',
			height : "100%",
			canSelectText : true,
			overflow : "hidden",
			showResizeBar : true,
			contents : "<div id='HorizontalContainer001Panel1_div' class='matrixComponentDiv' style='overflow:hidden'></div>"
		}), isc.HTMLPane.create( {
			ID : "MHorizontalContainer001Panel2",
			height : "100%",
			overflow : "hidden",
			showEdges : false,
			contentsType : "page",
			contentsURL : ""
		}) ],
		canSelectText : true
	});
</script>
				</div>
				<div id="HorizontalContainer001Panel1_div2"
					style="width: 100%; height: 100%; overflow: hidden;"
					class="matrixInline">
					<table class="query_form_content"
						style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
						<tr>
							<td class="query_form_toolbar" colspan="2">
								<script>isc.ToolStripButton.create({
												ID:"MtoolBarItem003",
												icon:"[skin]/images/matrix/actions/add.png",
												title: "添加",showDisabledIcon:false,showDownIcon:false });
								MtoolBarItem003.click=function(){
												Matrix.showMask();
												var x = eval("add();");
												if(x!=null && x==false){
												Matrix.hideMask();
												return false;}Matrix.hideMask();
												}</script>
								<script>isc.ToolStripButton.create({
												ID:"MtoolBarItem004",
												icon:"[skin]/images/matrix/actions/edit.png",
												title: "修改",
												showDisabledIcon:false,
												showDownIcon:false });
								MtoolBarItem004.click=function(){
												Matrix.showMask();
												var x = eval("editor();");
												if(x!=null && x==false){
												Matrix.hideMask();
												return false;}Matrix.hideMask();
												}</script>
								<script>isc.ToolStripButton.create({
												ID:"MtoolBarItem002",
												icon:Matrix.getActionIcon("copy"),
												title: "复制",
												showDisabledIcon:false,
												showDownIcon:false });
								MtoolBarItem002.click=function(){
												Matrix.showMask();
												var x = eval("copyData();");
												if(x!=null && x==false){
												Matrix.hideMask();
												return false;}Matrix.hideMask();
												}</script>
								<script>isc.ToolStripButton.create({
								ID:"MtoolBarItem001",
								icon:"[skin]/images/matrix/actions/delete.png",
								title: "删除",
								showDisabledIcon:false,
								showDownIcon:false });
								MtoolBarItem001.click=function(){
								var _preReturn = Matrix.validateDataGridSelection('DataGrid001');; 
								if(_preReturn !=null&&_preReturn == false){
								return false;}
								Matrix.showMask();
								if(!true){
								Matrix.hideMask();
								return false;}
								if(!Mform0.validate()){
								Matrix.hideMask();
								return false;}
								var vituralbuttonHidden = document.getElementById('matrix_command_id');
								if(vituralbuttonHidden)vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);
								var currentForm = document.getElementById('form0');
								var buttonHidden = document.createElement('input');
								buttonHidden.type='hidden';
								buttonHidden.name='matrix_command_id';
								buttonHidden.id='matrix_command_id';
								buttonHidden.value='toolBarItem001';
								currentForm.appendChild(buttonHidden);
								isc.confirm("确认删除所选数据？","if(value){del();Matrix.queryDataGridData('DataGrid001');var _mgr=Matrix.convertDataGridDataOfForm('form0');if(_mgr!=null&&_mgr==false){Matrix.hideMask();return false;}Matrix.send('form0',{'toolBarItem003':'删除'},function(data){ Matrix.update(data); });}else{Matrix.hideMask();return false;}");
								Matrix.hideMask();}</script>
								<script>
						isc.ToolStripButton.create({
							ID:"MtoolBarItem006",
							icon:"[skin]/images/matrix/actions/move_up.png",
							title: "上移",
							showDisabledIcon:false,showDownIcon:false 
						});
						MtoolBarItem006.click=function(){
							var select = MDataGrid001.getSelection();
							if(select.length>0&&select!=null){
								if(select.length>1){
									isc.warn("只能选择一条数据上移!");
									return;
								}
								var uuid = select.get(0).uuid;
								var index = select.get(0).cOrder;
								moveUp(uuid,index);
							}else{
								isc.warn("请先选中数据!");
							}
						}
					</script>
								<script>
						isc.ToolStripButton.create({
							ID:"MtoolBarItem007",
							icon:"[skin]/images/matrix/actions/move_down.png",
							title: "下移",
							showDisabledIcon:false,
							showDownIcon:false 
						});
						MtoolBarItem007.click=function(){
							var select = MDataGrid001.getSelection();
						
							if(select.length>0&&select!=null){
								if(select.length>1){
									isc.warn("只能选择一条数据下移!");
									return;
								}
								var id = select.get(0).uuid;
								var index = select.get(0).cOrder;
								moveDown(id,index);
							}else{
								isc.warn("请先选中数据!");
							}
						}
					</script>
								<div id="QueryForm001_tb_div"
									style="width: 100%; height: 38px;; overflow: hidden;">
									<script>isc.ToolStrip.create({
										ID:"MQueryForm001_tb",
										displayId:"QueryForm001_tb_div",
										width: "100%",
										height: "100%",
										position: "relative",
										members: [ MtoolBarItem003,MtoolBarItem004,MtoolBarItem001,MtoolBarItem002,,MtoolBarItem006,MtoolBarItem007 ] });if(MHorizontalContainer001Panel1)if(!MHorizontalContainer001Panel1.customMembers)MHorizontalContainer001Panel1.customMembers=[];MHorizontalContainer001Panel1.customMembers.add(MQueryForm001_tb);isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm001_tb.resizeTo(0,0);MQueryForm001_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);</script>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2"
								style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
								<div id="DataGrid001_div" class="matrixComponentDiv"
									style="width: 100%; height: 100%;">
									<script>  
				var MDataGrid001_DS=<%=request.getAttribute("list")%>;
				isc.MatrixListGrid.create({ID:"MDataGrid001",
				name:"DataGrid001",
				displayId:"DataGrid001_div",
				position:"relative",
				width:"100%",
				height:"100%",
				showAllRecords:true,
				fields:[{title:"&nbsp;",name:"MRowNum",canSort:false,canExport:false,canDragResize:false,showDefaultContextMenu:false,autoFreeze:true,
				autoFitEvent:'none',width:45,canEdit:false,canFilter:false,
				autoFitWidth:false,formatCellValue:function(value, record, rowNum, colNum,grid){
				if(grid.startLineNumber==null)return '&nbsp;';return grid.startLineNumber+rowNum;}},
				{title:"应用模板名称",matrixCellId:"name",name:"name",width:"40%",canEdit:false,editorType:'Text',type:'text'},
				{title:"最后修改时间",matrixCellId:"lastEdit",name:"lastEdit",width:"60%",canEdit:false,align:"left",editorType:'DateItem',type:'date',
				formatCellValue:function(value, record, rowNum, colNum,grid){
				debugger;
				return Matrix.formatter(value,'date','yyyy年MM月dd日 HH时mm分', record, rowNum, colNum,grid);}
				}
				],
				autoSaveEdits:false,
				isMLoaded:false,
				autoDraw:false,
				autoFetchData:true,
				selectionType:"single",
				selectionAppearance:"rowStyle",
				alternateRecordStyles:true,
				showRollOver:true,
				canSort:true,
				showHeader:false,
				autoFitFieldWidths:false,
				click:function(record, rowNum, colNum){onClick();(record, rowNum, colNum);},
				startLineNumber:1,
				editEvent:"doubleClick",
				canCustomFilter:true,
				exportCells:[{id:'name',title:'应用模板名称'},{id:'laastEdit',title:'最后修改时间'}],
				showRecordComponents:true,showRecordComponentsByCell:true});
				isc.MatrixDataSource.create({ID:'MDataGrid001_custom_filter_ds',fields:[{title:"应用模板名称",name:"name",type:'text',editorType:'Text'},{title:"最后修改时间",name:"lastEdit",type:'date',editorType:'DateItem'}]});
				isc.FilterBuilder.create({ID:'MDataGrid001_custom_filter',dataSource:MDataGrid001_custom_filter_ds,overflow:'auto',topOperatorAppearance:"none"});
				isc.Button.create({ID:'MDataGrid001_custom_filter_btn',title:"确认",autoDraw:false,click:"MDataGrid001.hideCustomFilter()"});isc.Button.create({ID:'MDataGrid001_custom_filter_btn_reset',title:"重置",autoDraw:false,click:"MDataGrid001_custom_filter.clearCriteria()"});isc.Button.create({ID:'MDataGrid001_custom_filter_btn_cancel',title:"取消",autoDraw:false,click:"MDataGrid001_custom_filter_window.hide()"});isc.Window.create({ID:'MDataGrid001_custom_filter_window',title:"高级查询",autoCenter:true,overflow:"auto",isModal:true,autoDraw:true,height:300,width:500,canDragResize:true,showMaximizeButton:true,items: [MDataGrid001_custom_filter],showFooter:true,footerHeight:20,footerControls:[isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn_reset,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn_cancel,isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false})]});MDataGrid001_custom_filter.resizeTo('100%','100%');MDataGrid001_custom_filter_window.hide();if(MHorizontalContainer001Panel1)if(!MHorizontalContainer001Panel1.customMembers)MHorizontalContainer001Panel1.customMembers=[];MHorizontalContainer001Panel1.customMembers.add(MDataGrid001);isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid001.isMLoaded=true;MDataGrid001.draw();MDataGrid001.setData(MDataGrid001_DS);MDataGrid001.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){
				isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},
				isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('form0')){Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}</script>
								</div>
								<input id="DataGrid001_data_entity"
									name="DataGrid001_data_entity" value="" type="hidden" />
							</td>

						</tr>
					</table>

				</div>
				<script>
	document.getElementById('HorizontalContainer001Panel1_div').appendChild(
			document.getElementById('HorizontalContainer001Panel1_div2'));
</script>
				<%-- 
				<script>
	function getParamsForMainDialog() {
		var params = '&';
		var value;
		return params;
	}
	isc.Window.create( {
		ID : "MMainDialog",
		id : "MainDialog",
		name : "MainDialog",
		autoCenter : true,
		position : "absolute",
		height : "50%",
		width : "50%",
		title : "",
		canDragReposition : false,
		showMinimizeButton : true,
		showMaximizeButton : false,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "closeButton" ],
		showFooter : false
	});
</script>
				<script>
	MMainDialog.hide();
</script>--%>
			</form>
		</div>
		<script>
	Mform0.initComplete = true;
	Mform0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE, function() {
		isc.Page.setEvent(isc.EH.RESIZE, "Mform0.redraw()", null);
	}, isc.Page.FIRE_ONCE);
</script>
	</body>
</html>
