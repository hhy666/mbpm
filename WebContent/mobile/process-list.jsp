<%@page pageEncoding="utf-8"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.commonservice.data.DataService"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.matrix.api.identity.MFUser"%>
<%@page import="com.matrix.office.investigation.common.CommonHelper"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE HTML><html><head><meta charset='utf-8'/><meta name='viewport' content='width=device-width, initial-scale=1,maximum-scale=1,user-scalable=yes'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><link href='<%=request.getContextPath()%>/resource/html5/css/style.min.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/flat/blue.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/square/blue.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/bootstrap-select.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/select2.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/assets/toastr-master/toastr.min.css'  rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/clockpicker.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/filecss.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/range/ion.rangeSlider.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/range/ion.rangeSlider.skinHTML5.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/assets/bootstrap-table/src/bootstrap-table.css'	rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/google-code-prettify/bin/prettify.min.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/custom.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<link rel='stylesheet' href='<%=request.getContextPath()%>/resource/html5/themes/default/style.min.css'/>
<SCRIPT SRC='<%=request.getContextPath()%>/resource/html5/js/jquery.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath()%>/resource/html5/js/matrix_runtime.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath()%>/resource/html5/js/filejs.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath()%>/resource/html5/js/range/ion.rangeSlider.min.js'></SCRIPT>
<script src='<%=request.getContextPath()%>/resource/html5/js/suggest/bootstrap-suggest.min.js'></script>
<SCRIPT SRC='<%=request.getContextPath()%>/resource/html5/assets/toastr-master/toastr.min.js'></SCRIPT>
<SCRIPT>var webContextPath = "<%=request.getContextPath()%>/";</SCRIPT>
<script src="<%=request.getContextPath()%>/resource/html5/js/jquery.min.js"></script>
<link rel='stylesheet'
  href='<%=request.getContextPath()%>/resource/mobile/mui.min3.css'>
<link rel='stylesheet'
  href='<%=request.getContextPath()%>/resource/mobile/matrix-base.css' />
  
<style>

	.scroll-wrapper {
	-webkit-overflow-scrolling: touch;
	overflow-y: scroll;
	/* 提示: 请在此处加上需要设置的大小(dimensions)或位置(positioning)信息! */
}

.demo-iframe-holder {
	position: fixed;
	right: 0;
	bottom: 0;
	left: 0;
	top: 0;
	-webkit-overflow-scrolling: touch;
	overflow-y: scroll;
}

.demo-iframe-holder iframe {
	height: 100%;
	width: 100%;
}

#attachIframe{
	width: 250vw;
	height: 250vh;
	border: 0;
	transform: scale(0.4);
	transform-origin: 0 0;
}
#commentIframe{
	width: 250vw;
	height: 250vh;
	border: 0;
	transform: scale(0.4);
	transform-origin: 0 0;
}

#opinionDiv_div{
width:100%;position: absolute;  z-index:999999;height:200px;bottom:0px;left:0px; overflow:auto;display:none;
}


</style>

<link
	href="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/skin_styles.css"
	rel="stylesheet" type="text/css" />
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
</head>
<script language=javascript
	src='<%=request.getContextPath()%>/resource/js/office.js'></script>
<script type="text/javascript">
	
	function search(){
   		searchForm.submit();
	}
	function startTemplProcess(mBizId){
		var url = "<%=request.getContextPath()%>/templet/tem_startProcessByTemplate.action?mBizId=" + mBizId;
		Matrix.sendRequest(url, null, function(data) {
			if (data != null && data.data != "") {
				var json = isc.JSON.decode(data.data);
				if (json.flag == null || json.flag == ''
						|| json.flag == 'undefined' || json.flag == 'null') {
					var formId = json.formId;   //表单编码
					var wordType = json.wordType;  //表单类型  ： 1 word 2 excel 3 ckeditor 4 普通表单 
					if(wordType == 3){
						formId = 'CkeditorList';
					}
					var mobileform = json.mobileform; //移动表单类型  1：原表单   2.自定义   3.不支持
					var pdid = json.pdid;    //流程编码
					var adid = json.adid;	
					var authId = json.authId;
					var form = json.form;
					var templateType = json.templateType;
					var title = "新建协同事项";
					
					if(mobileform == '2'){
						formId  = formId + "_mobile";
					}
					var exeUrl = "";	//执行url
					exeUrl+="<%=request.getContextPath()%>/StartFlowForm.rform?fdid=";
					exeUrl+=formId;
					exeUrl+="&pdid="+pdid;
					exeUrl+="&adid="+adid;
					exeUrl+="&formId="+formId;
					exeUrl+="&mBizId="+mBizId;
					exeUrl+="&platId="+mBizId;
					exeUrl+="&mHtml5Flag=true";
					exeUrl+="&is_mobile_request=true";
					
					/*
					openCtpWindow({
						'url' : exeUrl,
						'title' : title
					});
					*/
					window.location.href = exeUrl;

				} else {
					if (json.flag == 'error1') {
						alert("流程不存在或未发布!");
					} else if (json.flag == 'hasNoTemp') {
						alert("该模板不存在!");
					} else if (json.flag == 'templateType') {
						alert("该模板类型不匹配!");
					}
				}
			}

		});
	}
	
	function goBack(){
		window.location.href = '<%=request.getContextPath() %>/mobile/home.jsp';
	}
	
	function change(obj){
		var length = obj.children.length;
		if(length>0){
			obj.style.background = "#E1F2FA";
		}
	}
	
	function reset(obj){
		var length = obj.children.length;
		if(length>0){
			obj.style.background = "";
		}
	}
</script>
<style>
.red_text_template_17 {
	background-position: -32px -304px;
}

.form_temp_117 {
	background-position: -224px -176px;
}

.ico17 {
	display: inline-block;
	vertical-align: middle;
	height: 16px;
	width: 16px;
	line-height: 16px;
	background: url(<%=request.getContextPath()%>/resource/images/icon16.png?v=5_1_6_04)
		no-repeat;
	background-position: -224px -176px;
	cursor: pointer;
	_overflow: hidden;
	_background: url(<%=request.getContextPath()%>/resource/images/icon16.gif?v=5_1_6_04)
		no-repeat;
}

.ico18 {
	display: inline-block;
	vertical-align: middle;
	height: 16px;
	width: 16px;
	line-height: 16px;
	background: url(<%=request.getContextPath()%>/resource/images/icon16.png?v=5_1_6_04)
		no-repeat;
	background-position: -32px -304px;
	cursor: pointer;
	_overflow: hidden;
	_background: url(<%=request.getContextPath()%>/resource/images/icon16.gif?v=5_1_6_04)
		no-repeat;
}

.font_bold {
	font-weight: bold;
}

.color_gray2 {
	color: #757575;
}

.font_size24 {
	font-size: 24px;
}

.search_16 {
	background-position: -32px 0;
}

.ico16 {
	display: inline-block;
	vertical-align: middle;
	height: 16px;
	width: 16px;
	line-height: 16px;
	background: url(<%=request.getContextPath()%>/resource/images/query.png)
		no-repeat;
	background-position: 0 0;
	cursor: pointer;
	_overflow: hidden;
	_background: url(<%=request.getContextPath()%>/resource/images/query.png)
		no-repeat;
}

h1 {
	-webkit-margin-before: 0em;
	-webkit-margin-after: 0em;
	width: 128px;
	height: 28px;
	font-size: 12px;
	background: url(<%=request.getContextPath()%>/resource/images/title.png)
		no-repeat;
	float: left;
	text-align: center;
	line-height: 28px;
	color: #fff;
}

.table-striped>tbody>tr:nth-child(odd)>td, .table-striped>tbody>tr:nth-child(odd)>th
	{
	background-color: #f9f9f9
}

/*
.table-hover>tbody>tr:hover>td, .table-hover>tbody>tr:hover>th {
	background-color: #E1F2FA
}
*/



table col[class*=col-] {
	position: static;
	float: none;
	display: table-column
}

table td[class*=col-], table th[class*=col-] {
	position: static;
	float: none;
	display: table-cell
}
</style>
<body  class='null mui-fullscreen '  style="null" ><input type='hidden' id='validateType' name='validateType' value='jquery'/>
<div id='matrixMask' name='matrixMask' class='matrixMask' style='display:none;'> </div>
<div class='' id='offCanvasWrapper'>
		<div class=''>
			<div class='mui-content'>
				<header class='mui-bar mui-bar-nav'>
					<ul id='backIcon' style='position: fixed;top: 0;left: 6px;z-index: 999999;margin: 6px 20px 6px 6px;width: 70px;padding: 0;' onclick="goBack();"><li><div><i class='fa fa-angle-left' style='color: #fff;left: 5px;font-size: 30px;'></i></div></li></ul>
					<span style="color: #fff;
    display: block;
    width: 100%;
    padding: 0;
    margin: 0 -10px;
    font-size: 17px;
    font-weight: 500;
    line-height: 44px;
    text-align: center;
    white-space: nowrap;">
协同事项
					</span>
				</header>
				<br> <br>
				<div id='datalist' class='mui-content mui-scroll-wrapper'
					style='top: 42px; overflow: auto; width: 100%;  background-color: #FFFFFF;'     
					onchange=''>

			<table border="0" cellpadding="0" cellspacing="0" width="100%"
				bgcolor="#FAFAFA" height="30px">
				<tbody>
					<tr>
						<td width="100%" valign="top" class="border_b padding_l_10" style="border:0px;">
							<form id="searchForm" method="post" action="<%=request.getContextPath()%>/mobile/apply_query.action">
								<table width="100%" border="0" cellpadding="0" cellspacing="0" style="padding-top: 10px;">
									<tbody>
										<tr>	
											<td width="100%" class="padding_r_10" align="left">
												<input id="searchValue" name="searchValue" value="" style="width:100%;text-align:center;height:30px;" placeholder="请输入关键字查询">
												<!-- 
												<span class="ico16 search_16" onclick="search()"></span>
												 -->												
											</td>												
										</tr>
									</tbody>
								</table>
							</form>
						</td>
					</tr>
				</tbody>
			</table>
		
		<%
			try {
				List<DataObject> leafList = (List<DataObject>) request.getAttribute("leafList");
				List<DataObject> dataList = (List<DataObject>) request.getAttribute("dataList");
				HashMap<String, DataObject> typeMap = (HashMap<String, DataObject>) request.getAttribute("typeMap");
		%>

		
		<%
			for (DataObject dbo2 : leafList) {
					List<DataObject> list = new ArrayList<DataObject>();
					for (int i = 0, size = dataList.size(); i < size; i++) {
						DataObject data = dataList.get(i);
						if (dbo2 == typeMap.get(data.getString("parentId"))) {
							if (data.get("isFormTemplate") != null && data.getInt("isFormTemplate") == 1) {
								for (int j = 0; j < dataList.size(); j++) {
									DataObject childDataObject = dataList.get(j);
									if (childDataObject.getString("parentId") != null
											&& childDataObject.getString("parentId").equals(data.getString("mBizId"))) {
										list.add(childDataObject);
									}
								}
							} else {
								list.add(data);
							}
						}
					}
					if (list.size() > 0) {
		%>

		<table width="99%" border="0" cellSpacing="0" cellPadding="0"
			style="margin: 0 auto;">
			<tbody>
				<tr>
					<td class="padding_lr_10" vAlign="top" colSpan="3">
						<div style="wdith: 100%; height: 10px;"></div>
						<div class="scrollList" id="scrollListDiv"
							style="overflow: hidden;">
							<!-- 栏目标题} -->
							<div class="index-type-name"
								style="height: 30px; line-height: 30px; padding-left: 0px; position: relative;">
								<div>
									<div style="float: left; position: absolute; height: 30px;">
										<!-- <div style="width:100px;text-align:center;background: #fff;border: 0px solid #ddd;border-bottom: 1px solid #0082c6;border-top: 0px solid #15a4fa;margin-top:1px;">
	    <%=dbo2.getString("templateName")%>
	    </div>-->
										<h1><%=dbo2.getString("templateName")%></h1>
									</div>


								</div>
							</div>

							<div>
								<div class="mxt-grid-header ">
									<table class="sort ellipsis table-hover table-striped"
										style="border: 0px; table-layout: fixed;" id="leaveWord0"
										width="100%" border="0" cellSpacing="0" cellPadding="0">
										<thead class="mxt-grid-thead"
											style="background-color: #FFFFFF">
										</thead>
										<tbody class="mxt-grid-tbody">

											<%
												for (int i = 0, size = (list.size() > 1 ? list.size() - 1 : list.size()); i <= size / 2; i++) {
											%>

		
											<tr class="sort" erow="" style="height: 35px">

												<td width="25%" style="color: rgb(51, 51, 51);"
													class="title-already-visited-span sort" onmouseover="change(this);" onmouseout="reset(this);"><script>
														
													</script> <%
 	if (i * 2 < list.size()) {
 %> <span class="ico17 form_temp_117"></span><a
													class="title-already-visited"
													style="text-decoration: none; color: #000000"
													href=javascript:startTemplProcess('<%=list.get(i * 2).getString("mBizId")%>')>

														<%=list.get(i * 2).getString("templateName")%></a> <%
 	}
 %></td>
												<td width="25%" style="color: rgb(51, 51, 51);"
													class="title-already-visited-span sort" onmousemove="change(this);" onmouseout="reset(this);"><script>
														
													</script> <%
 	if (i * 2 + 1 < list.size()) {
 %> <span class="ico17 form_temp_117"></span><a
													class="title-already-visited"
													style="text-decoration: none; color: #000000"
													href=javascript:startTemplProcess('<%=list.get(i * 2 + 1).getString("mBizId")%>')>

														<%=list.get(i * 2 + 1).getString("templateName")%></a> <%
 	}
 %></td>											

											</tr>
											<%
												}
											%>
										</tbody>
									</table>
								</div>
							</div>


							<div style="clear: both;"></div>

						</div>
					</td>
				</tr>
			</tbody>
		</table>

		<%
			}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
	</div>
</body>
</html>