<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>
</head>
<body >
<div id='loading' name='loading' class='loading'>
<script>Matrix.showLoading();</script></div>

<script> var Mform0=isc.MatrixForm.create({ID:"Mform0",name:"Mform0",position:"absolute",action:"<%=request.getContextPath()%>/matrix.rform",fields:[{name:'form0_hidden_text',width:0,height:0,displayId:'form0_hidden_text_div'}]});</script>
<div
	style="width: 100%; height: 100%; overflow: auto; position: relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action="<%=request.getContextPath()%>##"
	style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="form0" value="form0" /> <input type="hidden"
	id="matrix_form_tid" name="matrix_form_tid"
	value="c143cdc1-03ce-4384-bd6b-7e68858dc855" /> <input type="hidden"
	id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0"
	value="" />
<div type="hidden" id="form0_hidden_text_div"
	name="form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
<input type="hidden" name="javax.matrix.faces.ViewState"
	id="javax.matrix.faces.ViewState" value="" />
	
<label>hello!</label>
<p style='font-size:30px;'>this is messageTest.jsp</p>


</form>

</div>
<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script>
</body>
</html>
