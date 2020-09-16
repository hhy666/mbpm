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
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>添加基本或自定义类型标签页</title>
<script type="text/javascript">
		window.onload = function(){
			if(2=="${param.type}"){
				document.getElementById('panel001').innerHTML = "添加基本类型";	
			}else if(3=="${param.type}"){
				document.getElementById('panel001').innerHTML = "添加自定义类型";	
			}
				InfoIframe.src = "<%=path%>/code/code_h5AddRefreshTo.action?parentNodeId=${codeNode.parentUUID}&type=${codeNode.type}";
		}
	
		function tabPanel001Click(){
			if(2=="${param.type}"){
				document.getElementById('panel001').innerHTML = "添加基本类型";	
			}else if(3=="${param.type}"){
				document.getElementById('panel001').innerHTML = "添加自定义类型";	
			}
				InfoIframe.src = "<%=path%>/code/code_h5AddRefreshTo.action?&parentNodeId=${codeNode.parentUUID}&type=${codeNode.type}";
		}
	</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post"  action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<div id="tabContainer0_div" class="matrixComponentDiv" style="width: 100%; height: 100%;; position: relative;">
			<script>
			    $(document).ready(function () {
			        var ifm = $(".J_iframe");
			        ifm.height(document.documentElement.clientHeight);
				    $('#TabContainer001 a[href="#TabPanel001"]').tab('show');
			    });
			    window.onresize = function () {
			        var ifm = $(".J_iframe");
			        ifm.height(document.documentElement.clientHeight);
			    }
			</script>
			<ul id="TabContainer001" class="nav nav-tabs disable" style="position: relative;height: 30px"/>
				<li>
					<a id="panel001" href="#TabPanel001" data-toggle="tab" onclick="tabPanel001Click()"></a>
				</li>
			</ul>
			<iframe id="InfoIframe" style="width:100%;height:calc(100% - 35px);top:30px " frameborder="0" src='' >
				
			</iframe>
		</div>
		<div id="content-main" class="tab-content" style="display:none; border-color: #e7eaec;   -webkit-border-image: none;    -o-border-image: none;    border-image: none;    border-style: solid;    border-width: 1px;    border-top: 0px;width:100%;height:100%">
			<div class="tab-pane fade in active" id="TabPanel001" style='padding: 3px 3px 0px 3px;'></div>
		</div>
	</form>
	
</body>
</html>