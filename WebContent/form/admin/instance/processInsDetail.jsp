

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程实例详细</title>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />

<script type="text/javascript">

</script>
</head>

<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%; overflow: auto;">
<script>
                var MForm0 = isc.MatrixForm.create({
                    ID: "MForm0",
                    name: "MForm0",
                    position: "absolute",
                    canSelectText: true,
                    action: "",
                    fields: [{
                        name: 'Form0_hidden_text',
                        width: 0,
                        height: 0,
                        displayId: 'Form0_hidden_text_div'
                    }]
                });
            </script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<input type="hidden" name="detailType" id="detailType" value="${param.detailType}" />
	<input type="hidden" name="piid" id="piid" value="${param.piid}" />
	<input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}" />
    
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;">
</div>

<table id="table0css" jsId="table0css" class="maintain_form_content"
	cellpadding="0px" cellspacing="0px" style="width: 100%; height: 100%">
	
	<tr id="j_id5" jsId="j_id5">
		
		<td id="td13874300245170" jsId="td13874300245170" style="height:100%"
			class="maintain_form_input" colspan="1" rowspan="1" style="vertical-align:top">
	<div id="tabContainer0_div" class="matrixComponentDiv"
	  style="position: relative;">
	
	<script> 
		var MtabContainer0 = isc.TabSet.create({
				ID:"MtabContainer0",
				displayId:"tabContainer0_div",
				height: "100%",
				width: "100%",
				position: "relative",
				align: "center",
				tabBarPosition: "top",
				tabBarAlign: "left",
				showPaneContainerEdges: false,
				showTabPicker: true,
				showTabScroller: true,
				selectedTab: 2,
				tabBarControls : [
					isc.MatrixHTMLFlow.create({
						ID:"MtabContainer0Bar0",
						width:"300px",
						contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
					})
				 ],
				 tabs: [ 
				 	{
				 	title: "流程实例信息",pane:isc.HTMLPane.create({
				 		ID:"MtabContainer0Panel0",height: "100%",
				 		overflow: "hidden",
				 		autoDraw: false,
				 		showEdges:false,
				 		contentsType:"page",
				 		contentsURL:""})
				 	},{
				 	title: "流程实例变量",pane:isc.HTMLPane.create({
				 		ID:"MtabContainer0Panel1",height: "100%",
				 		overflow: "hidden",
				 		autoDraw: false,
				 		showEdges:false,
				 		contentsType:"page",
				 		contentsURL:""})
				 	},{
				 	title: "活动实例列表",pane:isc.HTMLPane.create({
				 		ID:"MtabContainer0Panel2",height: "100%",
				 		overflow: "hidden",
				 		autoDraw: false,
				 		showEdges:false,
				 		contentsType:"page",
				 		contentsURL:""})
				 	},
				 	
				 	{title: ''}
				  ] 
		});
	document.getElementById('tabContainer0_div').style.display='none';MtabContainer0.selectTab(0);
	isc.Page.setEvent("load","MtabContainer0.selectTab(0);MtabContainer0.removeTab(MtabContainer0.tabs.length-1);");
	</script>
</div>
<div id="tabContainer0Bar0_div2" style="text-align: right" class="matrixInline"></div>
<script>
document.getElementById('tabContainer0Bar0_div').appendChild(document.getElementById('tabContainer0Bar0_div2'));

		MtabContainer0Panel0.setContentsURL('<%=request.getContextPath()%>/instance/processInstance_getProcessInsMsg.action?piid=${param.piid}&detailType=${param.detailType}');//
		MtabContainer0Panel1.setContentsURL('<%=request.getContextPath()%>/instance/processInstance_getProcessInsVar.action?piid=${param.piid}&detailType=${param.detailType}');//getProcessInsVar
		MtabContainer0Panel2.setContentsURL('<%=request.getContextPath()%>/instance/processInstance_getActivtityInsesByPiid.action?piid=${param.piid}');//
	
	
	
	document.getElementById('tabContainer0_div').style.display='';
</script>
		
		</td>
	</tr>
	
	<tr id="j_id9" jsId="j_id9" height="20px">
		<td id="j_id10" jsId="j_id10" class="maintain_form_input" 
			rowspan="1"> <script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem4",
                                    icon:Matrix.getActionIcon("exit"),
                                    title: "关闭",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem4.click = function() {
                                    Matrix.showMask();
                                    Matrix.closeWindow(null,0);
                                    Matrix.hideMask();
                                }
                            </script>
                            
		<div id="ToolBar0_div" style="width: 100%; overflow: hidden;"><script>
                                    isc.ToolStrip.create({
                                        ID: "MToolBar0",
                                        displayId: "ToolBar0_div",
                                        width: "100%",
                                        height: "*",
                                        position: "relative",
                                        align: "center",
                                         members: [ MToolBarItem4]
                                    });
                                    isc.Page.setEvent(isc.EH.RESIZE, "MToolBar0.resizeTo(0,0);MToolBar0.resizeTo('100%','100%');", null);
                                </script></div>
		</td>
	</tr>
</table>

	
	</form>
<script>
                MForm0.initComplete = true;
                MForm0.redraw();
                isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
            </script></div>
</body>

</html>


