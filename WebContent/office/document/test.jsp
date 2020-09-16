<%@ page
	language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="commonj.sdo.DataObject"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
 <script src="js/jquery-1.4.2.min.js"></script>
 <script src="js/WebOffice.js"></script>
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>	
<script>
/******************************************************************************************/
</script>
</head>
<body onload="">
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>

<script> var Mform0=isc.MatrixForm.create({
				ID:"Mform0",
				name:"Mform0",
				position:"absolute",
				action:"",
				fields:[
				{name:'form0_hidden_text',width:0,height:0,displayId:'form0_hidden_text_div'}
				]});
</script>
<div style="width:100%;height:100%;overflow:auto;position:relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post" 
	action="" 
	style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" 
	enctype="application/x-www-form-urlencoded">
<input type="hidden" name="form0" value="form0" />
<input type="hidden" id="mode" name="mode" value="debug" />
<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
<input type="hidden" id="dataGridId" name="dataGridId" />
<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
<table class="maintain_form_content" id="report" style="width:100%;">
	<tr><td height="32px" class="" width="100%">
 
 <div id="toolBar002_div"  style="width:100%;height:100%;overflow:hidden;top:0;"  >
 
		<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem001",
						icon:"[skin]/images/matrix/actions/save.png",
						title: "保存",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem001.click=function(){
						Matrix.showMask();
						var content = WebOffice.WebObject.ActiveDocument.content.text;
						WebOffice.content=content;
						Matrix.setFormItemValue('content',content);
						SaveDocument();
	     				//document.getElementById("form0").submit();
						Matrix.hideMask();
					};
				</script>
				<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem002",
						icon:"[skin]/images/matrix/actions/add.png",
						title: "全屏",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem002.click=function(){
						Matrix.showMask();
						var WebOffice = new WebOffice2015();
						WebOffice.FullSize(true);
						Matrix.hideMask();
					}
				</script>
			<script>isc.ToolStrip.create({ID:"MtoolBar002",displayId:"toolBar002_div",width: "100%",height: "100%",position: "relative",
				members: [ 
				"separator",
				MtoolBarItem001,
				"separator",
				MtoolBarItem002
				] 
				});
				isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MtoolBar002.resizeTo(0,0);MtoolBar002.resizeTo('100%','34px');",null);},isc.Page.FIRE_ONCE);</script>
 			</td>
 		</tr> 
 		<tr><td id="showtr" colspan="2"  valign="top">
  			<table id="functionBox" border="0">
			
       			 <tr>
					<td colspan="2"><div style="width:99%;top:33px;bottom:60px;position:absolute;overflow:auto;"><script src="js/iWebOffice2015.js"></script></div></td>
	    		</tr>
	    
	    		<tr>
					<td height="10px" style="bottom:30px;position:absolute;left:0px;" class="statue">状态：<span id="state"></span></td>
					<td  style="time;bottom:30px;position:absolute;right:0px;">时间：</td>
				</tr>
  
  			</table>
 			</td>
 		</tr>
 		<tr ><td colspan="2" height="30px" class="footer">
 				<table><tr><td align="center"><span style="width:100%;height:100%;bottom:0px;postion:absolute;">江西金格科技股份有限公司 版权所有</span></td></tr></table>
 			</td>
 		</tr>
 
</table>

</form></div><script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script></body>
</html>
