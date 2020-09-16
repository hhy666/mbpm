<%@page import="com.matrix.statistic.admin.model.StatisticsDiagram"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.matrix.form.admin.custom.utilization.model.Utilization"%>
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
	function openStatisticList(mBizId){
		window.location.href = '<%=request.getContextPath() %>/mobile/statistic-info.jsp?mBizId='+mBizId;
	}
	
	function goBack(){
		window.location.href = '<%=request.getContextPath() %>/mobile/home.jsp';
	}
	
	function change(obj){
		obj.style.background = "#E1F2FA";
	}
	
	function reset(obj){
		obj.style.background = "";
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
	/*background-color: #f9f9f9*/
	background-color: white
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
						统计信息
					</span>
				</header>
				<br><br>
				<div id='datalist' class='mui-content mui-scroll-wrapper'
					style='top: 42px; overflow: auto; width: 100%;  background-color: #FFFFFF;'     
					onchange=''>

			<table border="0" cellpadding="0" cellspacing="0" width="100%"
				bgcolor="#FAFAFA" height="30px">
				<tbody>
					<tr>
						<td width="100%" valign="top" class="border_b padding_l_10" style="border:0px;">
							<form id="searchForm" method="post" action="<%=request.getContextPath()%>/mobile/statistic_loadStatistic.action">
								<table width="100%" border="0" cellpadding="0" cellspacing="0" style="padding-top: 10px;">
									<tbody>
										<tr>	
											<td width="100%" class="padding_r_10" align="left">
												<input id="searchValue" name="searchValue" value="" style="width:100%;text-align:center;height:30px;" placeholder="请输入关键字查询">							
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
				List<DataObject> leafList = (List<DataObject>) request.getAttribute("leafList");   //目录列表
				List<Object[]> templateList = (List<Object[]>) request.getAttribute("templateList");
				List<StatisticsDiagram> dataList = (List<StatisticsDiagram>) request.getAttribute("dataList");   //统计信息列表
		%>
		
		<%
			for (DataObject dataObject : leafList) {
					List<StatisticsDiagram> list = new ArrayList<StatisticsDiagram>();   //存放统计信息
					for(int i=0; i<templateList.size(); i++){
						Object[] temp = templateList.get(i);
						String mBizId = (String) temp[0];   //模板主键
						String parentId = (String) temp[1];   //父编码
						if(parentId.equals(dataObject.getString("uuid"))){
							for (StatisticsDiagram statisticsDiagram : dataList) {
								String catalogId = statisticsDiagram.getTemplateId();
								if(catalogId!=null && catalogId.toString().trim().length()>0){
									if(catalogId.equals(mBizId)){
										list.add(statisticsDiagram);
									}
								}
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
										<h1><%=dataObject.getString("templateName")%></h1>
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
 %> <span><img src="<%=request.getContextPath()%>/resource/mobile/cover_13.png"/></span><a
													class="title-already-visited"
													style="text-decoration: none; color: #000000"
													href=javascript:openStatisticList('<%=list.get(i * 2).getId()%>')>

														<%=list.get(i * 2).getName()%></a> <%
 	}
 %></td>
												<td width="25%" style="color: rgb(51, 51, 51);"
													class="title-already-visited-span sort" onmousemove="change(this);" onmouseout="reset(this);"><script>
														
													</script> <%
 	if (i * 2 + 1 < list.size()) {
 %> <span><img src="<%=request.getContextPath()%>/resource/mobile/cover_13.png"/></span><a
													class="title-already-visited"
													style="text-decoration: none; color: #000000"
													href=javascript:openStatisticList('<%=list.get(i * 2 + 1).getId()%>')>

														<%=list.get(i * 2 + 1).getName()%></a> <%
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