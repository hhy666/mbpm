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
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
	</head>
	<script language=javascript
		src='<%=request.getContextPath()%>/resource/js/office.js'></script>
	<script type="text/javascript">
	function search() {
		searchForm.submit();
	}
	
	function UUID() {
        var s = [];
        var hexDigits = "0123456789abcdef";
        for (var i = 0; i < 36; i++) {
            s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
        }
        s[14] = "4"; 
        s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1); 
                                                            
        s[8] = s[13] = s[18] = s[23] = "-";

        var uuid = s.join("");
        return uuid;
    }
	
	function startTemplProcess(mBizId){
		var url = "<%=request.getContextPath()%>/templet/tem_startProcessByTemplate.action?mBizId="+mBizId;
		Matrix.sendRequest(url,null,function(data){
			if(data!=null && data.data!=""){
				var json = isc.JSON.decode(data.data);
				if(json.flag==null || json.flag=='' ||json.flag=='undefined' ||json.flag=='null'){
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
					var mFlowBizId = json.mFlowBizId;
					var title = "";
					var url = webContextPath+"/"+form+".rform?mHtml5Flag=true&formId="+formId+"&mBizId="+mBizId+"&pdid="+pdid+"&adid="+adid+"&isInitLoad=0&authId="+authId+"&mFlowBizId="+mFlowBizId;
					if(templateType == '1'){
						var subType = json.subType;
						url+="&subType="+subType+"&type=1";
						title = "新建公文事项";
					}else if(templateType == '2'){
						var baseCode = json.baseCode;
						var sysType = json.sysType;
						url+="&baseCode="+baseCode+"&sysType="+sysType+"&type=3&firstTime=1";
						title = "新建协同事项";
					}
					openCtpWindow({'url':url,'title':title});
					
				}else{
					if(json.flag=='error1'){
						alert("流程不存在或未发布!");
					}else if(json.flag =='hasNoTemp'){
						alert("该模板不存在!");
					}else if(json.flag == 'templateType'){
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
.red_text_template_17{
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
    background: url(<%=request.getContextPath()%>/resource/images/icon16.png?v=5_1_6_04) no-repeat;
    background-position: -224px -176px;
    cursor: pointer;
    _overflow: hidden;
    _background: url(<%=request.getContextPath()%>/resource/images/icon16.gif?v=5_1_6_04) no-repeat;
}
.ico18 {
    display: inline-block;
    vertical-align: middle;
    height: 16px;
    width: 16px;
    line-height: 16px;
    background: url(<%=request.getContextPath()%>/resource/images/icon16.png?v=5_1_6_04) no-repeat;
   background-position: -32px -304px;
    cursor: pointer;
    _overflow: hidden;
    _background: url(<%=request.getContextPath()%>/resource/images/icon16.gif?v=5_1_6_04) no-repeat;
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
    background: url(<%=request.getContextPath()%>/resource/images/query.png) no-repeat;
    background-position: 0 0;
    cursor: pointer;
    _overflow: hidden;
    _background: url(<%=request.getContextPath()%>/resource/images/query.png) no-repeat;
}

h1 {
	-webkit-margin-before: 0em;
	-webkit-margin-after: 0em;
	width: 128px;
	height: 28px;
	font-size: 12px;
	background: url(<%=request.getContextPath()%>/ resource/ images/
		title.png ) no-repeat;
	float: left;
	text-align: center;
	line-height: 28px;
	color: #fff;
}

.table-striped>tbody>tr:nth-child(odd)>td,.table-striped>tbody>tr:nth-child(odd)>th
	{
	background-color: #f9f9f9
}

/*
.table-hover>tbody>tr:hover>td, .table-hover>tbody>tr:hover>th {
	background-color: #E1F2FA
}
*/


table col[class *=col-] {
	position: static;
	float: none;
	display: table-column
}

table td[class *=col-],table th[class *=col-] {
	position: static;
	float: none;
	display: table-cell
}
</style>
	<body class="page_content public_page" style="background: #ffffff;">
		
		<table width="99%" border="0" cellSpacing="0" cellPadding="0"
			style="margin: 0 auto;">
			<tbody>
				<tr>
					<td class="padding_lr_10" vAlign="top" colSpan="3">
						
						<div class="scrollList" id="scrollListDiv"
							style="overflow: hidden;">
							<!-- 栏目标题 -->
						</div>
						</div>

						<div>
							<div class="mxt-grid-header ">
								<table class="sort ellipsis table-hover table-striped"
									style="border: 0px; table-layout: fixed;" id="leaveWord0"
									width="100%" border="0" cellSpacing="0" cellPadding="0">
									<thead class="mxt-grid-thead" style="background-color: #FFFFFF">
									</thead>
									<tbody class="mxt-grid-tbody">
										<%
											try {
												String row = request.getParameter("row");// 控制输出行数
												int num = 6;

												List<DataObject> list = (List<DataObject>) request.getAttribute("dataList");
												
												int count = 0;
												if (row != null && row.trim().length() > 0)
													num = Integer.parseInt(row);

											    for (int i = 0, size = list.size(); i <= size / 4; i++) {
													if (count < num) {
										%>


										<tr class="sort" erow="" style="height: 35px">
										
											<td width="25%" style="color: rgb(51, 51, 51);" class="title-already-visited-span sort" onmouseover="change(this);" onmouseout="reset(this);">
												<%
													if (i * 4 < size) { 
												%>
												<span class="ico17 form_temp_117"></span>
													<a class="title-already-visited" style="text-decoration: none; color: #000000"
													href=javascript:startTemplProcess('<%=list.get(i * 4).getString("mBizId")%>')>
													<%=list.get(i * 4).getString("templateName")%></a>
												<%
												  }
												%>
											</td>
											
											<td width="25%" style="color: rgb(51, 51, 51);" class="title-already-visited-span sort" onmouseover="change(this);" onmouseout="reset(this);">
												<%
													if (i * 4 + 1 < size) {
												%>
												<span class="ico17 form_temp_117"></span>
													<a class="title-already-visited" style="text-decoration: none; color: #000000"
													href=javascript:startTemplProcess('<%=list.get(i * 4 + 1).getString("mBizId")%>')>
													<%=list.get(i * 4 + 1).getString("templateName")%></a>													
												<%
													}
												%>
											</td>
											
											
											<td width="25%" style="color: rgb(51, 51, 51);"
												class="title-already-visited-span sort" onmouseover="change(this);" onmouseout="reset(this);">
												<%
													if (i * 4 + 2 < size) {
												%>
												<span class="ico17 form_temp_17"></span>
													<a class="title-already-visited" style="text-decoration: none; color: #000000"
													href=javascript:startTemplProcess('<%=list.get(i * 4 + 2).getString("mBizId")%>')>
													<%=list.get(i * 4 + 2).getString("templateName")%></a>
												<%
												  }
												%>
											</td>
											
											
											<td width="25%" style="color: rgb(51, 51, 51);"
												class="title-already-visited-span sort" onmouseover="change(this);" onmouseout="reset(this);">
												<%
													if (i * 4 + 3 < size) {
												%>
												<span class="ico17 form_temp_17"></span>
													<a class="title-already-visited" style="text-decoration: none; color: #000000"
													href=javascript:startTemplProcess('<%=list.get(i * 4 + 3).getString("mBizId")%>')>
													<%=list.get(i * 4 + 3).getString("templateName")%></a>
												<%
													}
												%>
											</td>

										</tr>
										<%
											count++;
											} else {
												break;
											}
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
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
	</body>
</html>