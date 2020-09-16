<%@page pageEncoding="utf-8"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.commonservice.data.DataService"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.matrix.api.identity.MFUser"%>
<%@page import="com.matrix.office.investigation.common.CommonHelper"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>

<link
	href="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/skin_styles.css"
	rel="stylesheet" type="text/css" />
<link href='<%=request.getContextPath()%>/resource/html5/css/style.min.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/filecss.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/custom.css' rel="stylesheet"></link>
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
					var formId = json.formId;
					var wordType = json.wordType;  //表单类型  ： 1 word 2 excel 3 ckeditor 4 普通表单 
					if(wordType == 3){
						formId = 'CkeditorList';
					}
					var pdid = json.pdid;
					var adid = json.adid;
					var authId = json.authId;
					var form = json.form;
					var templateType = json.templateType;
					var title = "";
					var url = webContextPath
							+ "/templet/crtPro_createProcess.action?formId="
							+ formId + "&mBizId=" + mBizId + "&pdid=" + pdid
							+ "&adid=" + adid + "&isInitLoad=0&authId="
							+ authId +"&templateType="+templateType;
					if (templateType == '1') {
						var subType = json.subType;
						url += "&subType=" + subType + "&type=1";
						title = "新建公文事项";
					} else if (templateType == '2') {
						var baseCode = json.baseCode;
						var sysType = json.sysType;
						url += "&baseCode=" + baseCode + "&sysType=" + sysType
								+ "&type=3";
						title = "新建协同事项";
					}
					openCtpWindow({
						'url' : url,
						'title' : title
					});

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
<body class="page_content public_page" style="background: #ffffff;">
	<div
		style="width: 100%; height: 100%; overflow: auto; position: relative;">
		<div
			style="padding-left: 10px; padding-top: 9px; width: 99%; height: 42px;">
			<table border="0" cellpadding="0" cellspacing="0" width="100%"
				bgcolor="#FAFAFA" height="42px">
				<tbody>
					<tr>
						<td width="100%" valign="top" class="border_b padding_l_10">
							<form id="searchForm" method="post"
								action="<%=request.getContextPath()%>/templet/tem_query.action">
								<table width="100%" border="0" cellpadding="0" cellspacing="0"
									style="padding-top: 10px;">
									<tbody>
										<tr>
											<td colspan="2">
												<div class="input-group" style="width:100%;margin-right:5px;margin-top: 5px;">
													<label id="label011" name="label011" style="font-size:18px;font-weight: normal;vertical-align:bottom;" class="control-label">我的模板</label>									
												     <input id="searchValue" name="searchValue" placeholder="请输入模板名称" class="form-control" style="float:right;width:15%;height:28px;">
											        <div class="input-group-btn">
							                           <button type="submit" class="x-btn ok-btn btn-sm">搜索</button>
							                        </div>
						                        </div>
											</td>
											<!-- 我的模板 -->
											 <!--
											<td width="50%" class="padding_r_10" align="right"> 
												<input
													id="searchValue" name="searchValue" value=""> <span
													class="ico16 search_16" onclick="search()"></span>
													&nbsp;&nbsp; <a
														href="/seeyon/collTemplate/collTemplate.do?method=showTemplateConfig">配置模板</a>
													 配置模板 											
										     </td>
										      -->
										</tr>
									</tbody>
								</table>
							</form>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<%
			try {
				List<DataObject> leafList = (List<DataObject>) request.getAttribute("leafList");
				List<DataObject> dataList = (List<DataObject>) request.getAttribute("dataList");
				HashMap<String, DataObject> typeMap = (HashMap<String, DataObject>) request.getAttribute("typeMap");
				List<DataObject> docLeafList = (List<DataObject>) request.getAttribute("docLeafList");
				HashMap<String, DataObject> docTypeMap = (HashMap<String, DataObject>) request
						.getAttribute("docTypeMap");
				int x = 0;
				int y = 0;
				for (DataObject dbo2 : docLeafList) {
					List<DataObject> list = new ArrayList<DataObject>();
					for (int i = 0, size = dataList.size(); i < size; i++) {
						DataObject data = dataList.get(i);
						if (dbo2 == docTypeMap.get(data.getString("parentId"))) {
							if (data.get("isFormTemplate") != null && data.getInt("isFormTemplate") == 1) {
								for (int j = 0; j < dataList.size(); j++) {
									DataObject childDataObject = dataList.get(j);
									if (childDataObject.getString("parentId")!=null && childDataObject.getString("parentId").equals(data.getString("mBizId"))) {
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
									<div style="float: left; position: absolute; width:100%; height: 30px;">
										<div class="bs-callout">
									       <span><%=dbo2.getString("templateName")%></span>								   
									    </div>
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
												for (int i = 0, size = (list.size() > 1 ? list.size() - 1 : list.size()); i <= size / 4; i++) {//格式化每四个为一行·
											%>


											<tr class="sort" erow="" style="height: 35px">

												<td width="25%" style="color: rgb(51, 51, 51);"
													class="title-already-visited-span sort" onmouseover="change(this);" onmouseout="reset(this);">
													<%
 	if (i * 4 < list.size()) {
 %> <span class="ico18 red_text_template_17"></span><a
													class="title-already-visited"
													style="text-decoration: none; color: #000000"
													href=javascript:startTemplProcess('<%=list.get(i * 4).getString("mBizId")%>')>

														<%=list.get(i * 4).getString("templateName")%></a> <%
 	}
 %></td>
												<td width="25%" style="color: rgb(51, 51, 51);"
													class="title-already-visited-span sort" onmouseover="change(this);" onmouseout="reset(this);"><%
 	if (i * 4 + 1 < list.size()) {
 %> <span class="ico18 red_text_template_17"></span><a
													class="title-already-visited"
													style="text-decoration: none; color: #000000"
													href=javascript:startTemplProcess('<%=list.get(i * 4 + 1).getString("mBizId")%>')>

														<%=list.get(i * 4 + 1).getString("templateName")%></a> <%
 	}
 %></td>
												<td width="25%" style="color: rgb(51, 51, 51);"
													class="title-already-visited-span sort" onmouseover="change(this);" onmouseout="reset(this);"> <%
 	if (i * 4 + 2 < list.size()) {
 %> <span class="ico18 red_text_template_17"></span><a
													class="title-already-visited"
													style="text-decoration: none; color: #000000"
													href=javascript:startTemplProcess('<%=list.get(i * 4 + 2).getString("mBizId")%>')>

														<%=list.get(i * 4 + 2).getString("templateName")%></a> <%
 	}
 %></td>
												<td width="25%" style="color: rgb(51, 51, 51);"
													class="title-already-visited-span sort" onmouseover="change(this);" onmouseout="reset(this);"><%
 	if (i * 4 + 3 < list.size()) {
 %> <span class="ico18 red_text_template_17"></span><a
													class="title-already-visited"
													style="text-decoration: none; color: #000000"
													href=javascript:startTemplProcess('<%=list.get(i * 4 + 3).getString("mBizId")%>')>

														<%=list.get(i * 4 + 3).getString("templateName")%></a> <%
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
		%>
		<%
		int z = 0;
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
									<div style="float: left; position: absolute; width:100%; height: 30px;">
										<div class="bs-callout">
									       <span><%=dbo2.getString("templateName")%></span>								   
									    </div>
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
												for (int i = 0, size = (list.size() > 1 ? list.size() - 1 : list.size()); i <= size / 4; i++) {
											%>


											<tr class="sort" erow="" style="height: 35px">

												<td width="25%" style="color: rgb(51, 51, 51);"
													class="title-already-visited-span sort" onmouseover="change(this);" onmouseout="reset(this);">
													 <%
 	if (i * 4 < list.size()) {
 %> <span class="ico17 form_temp_117"></span><a
													class="title-already-visited"
													style="text-decoration: none; color: #000000"
													href=javascript:startTemplProcess('<%=list.get(i * 4).getString("mBizId")%>')>

														<%=list.get(i * 4).getString("templateName")%></a> <%
 	}
 %></td>
												<td width="25%" style="color: rgb(51, 51, 51);"
													class="title-already-visited-span sort" onmouseover="change(this);" onmouseout="reset(this);">
													<%
 	if (i * 4 + 1 < list.size()) {
 %> <span class="ico17 form_temp_117"></span><a
													class="title-already-visited"
													style="text-decoration: none; color: #000000"
													href=javascript:startTemplProcess('<%=list.get(i * 4 + 1).getString("mBizId")%>')>

														<%=list.get(i * 4 + 1).getString("templateName")%></a> <%
 	}
 %></td>
												<td width="25%" style="color: rgb(51, 51, 51);"
													class="title-already-visited-span sort" onmouseover="change(this);" onmouseout="reset(this);">
													 <%
 	if (i * 4 + 2 < list.size()) {
 %> <span class="ico17 form_temp_17"></span><a
													class="title-already-visited"
													style="text-decoration: none; color: #000000"
													href=javascript:startTemplProcess('<%=list.get(i * 4 + 2).getString("mBizId")%>')>

														<%=list.get(i * 4 + 2).getString("templateName")%></a> <%
 	}
 %></td>
												<td width="25%" style="color: rgb(51, 51, 51);"
													class="title-already-visited-span sort" onmouseover="change(this);" onmouseout="reset(this);">
													 <%
 	if (i * 4 + 3 < list.size()) {
 %> <span class="ico17 form_temp_17"></span><a
													class="title-already-visited"
													style="text-decoration: none; color: #000000"
													href=javascript:startTemplProcess('<%=list.get(i * 4 + 3).getString("mBizId")%>')>

														<%=list.get(i * 4 + 3).getString("templateName")%></a> <%
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