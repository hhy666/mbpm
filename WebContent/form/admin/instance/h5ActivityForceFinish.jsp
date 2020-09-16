<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
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
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<script type="text/javascript">
	function convertSubmitData(){
		var transType = document.getElementById("transType").value;
		var transDid = document.getElementById("transDid").value;
		var actDid = document.getElementById("actDid").value;
		var aiid = document.getElementById("aiid").value;
		var data = {'transType':transType,'transDid':transDid,'actDid':actDid,'aiid':aiid};
		Matrix.closeWindow(data);
	}

	$(document).ready(function() {
		var transByHandlerTr = document.getElementById('transByHandlerTr');
		var anyTransTr = document.getElementById('anyTransTr');
		var transType = document.getElementById('transType');
	    $('input[type=radio][name=selectedType]').change(function() {
	        if (this.value == '1') {
	        	transByHandlerTr.style.display = "none";
	        	anyTransTr.style.display = "none";
	        	transType.value = "1";
	        }else if (this.value == '2') {
	        	transByHandlerTr.style.display = "table-row";
	        	anyTransTr.style.display = "none";
	        	transType.value = "2";
	        }else if (this.value == '3') {
	        	transByHandlerTr.style.display = "none";
	        	anyTransTr.style.display = "table-row";
	        	transType.value = "3";
	        }
	    });
	});
</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="Form0" value="Form0" />
		<input type="hidden" id="aiid" name="aiid" value="${aiid}" />
		<input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}" />
		<input type="hidden" id="transType" name="transType" value="1" >
		<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
		<table id="table0css" jsId="table0css" class="maintain_form_content" cellpadding="0px" cellspacing="0px" style="width: 100%; height: 100%">
			<tr style="height: 10%">
				<td class="maintain_form_content" colspan="2" rowspan="1" style="height: 30px;padding: 5px"">
					<label id="label001" name="label001" style="padding-left: 5px">
						流转方式:
					</label>
				</td>
			</tr>
			<tr style="height: 50%;display: inline;">
				<td style="padding-left: 5px;">
					<input type="radio" style="padding-bottom: 5px;padding-top: 5px" name="selectedType" value="1" checked>根据业务流程规则进行流转<br>
					<input type="radio" style="padding-bottom: 5px;padding-top: 5px" name="selectedType" value="2">手工选择设计流转路径<br>
					<input type="radio" style="padding-bottom: 5px;padding-top: 5px" name="selectedType" value="3">任意跳转流转环节
					<table>
						<tr style="height: 10%;display:none" id="transByHandlerTr" jsId="j_id9">
							<td style="padding-bottom: 20px;padding-top: 20px">
								<label id="label002" name="label001">
									选择下一步:
								</label>
							</td>
							<td>
								<select name="transDid" id="transDid" class="form-control select2-accessible">
									<c:forEach items="${transitions}" var="li">
										<option value="${li.tdid}">${li.name}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr style="height: 10%;display:none" id="anyTransTr" jsId="j_id10">
							<td style="padding-bottom: 20px;padding-top: 20px">
								<label id="label003" name="label003">
									选择下一步:
								</label>
							</td>
							<td>
								<select name="actDid" id="actDid" class="form-control select2-accessible">
									<c:forEach items="${actTmpls}" var="li">
										<c:if test="${adid!=li.adid}">
											<option value="${li.adid}">${li.name}</option>
										</c:if>
									</c:forEach>
								</select>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="cmdLayout" colspan="8" style="text-align: center;">
					<div id="button1" class="matrixInline">
						<input type="button" class="x-btn ok-btn " value="确认" onclick="convertSubmitData()">
					</div>
					<div id="button2" class="matrixInline">
						<input type="button" class="x-btn cancel-btn " value="取消" onclick="Matrix.closeWindow(null,0)">
					</div>
				</td>
			</tr>
		</table>
	</form>	
</body>
</html>