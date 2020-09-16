<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程实例优先级设置</title>
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
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="Form0" value="Form0" />
	
	<input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}" />
    
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;">
</div>

<table id="table0css" jsId="table0css" class="maintain_form_content"
	cellpadding="0px" cellspacing="0px" style="width: 100%; height: 100%">
	<tr id="j_id2" jsId="j_id2">
		<td id="j_id3" jsId="j_id3" class="maintain_form_content" colspan="2"
			rowspan="1" style="height: 30px;">该页面用于设定实例的优先级。</td>
	</tr>
	
	<tr id="j_id5" jsId="j_id5" height="100%">
		
			
		<td id="td13874300245170" jsId="td13874300245170" style="height:100%"
			class="maintain_form_input" colspan="1" rowspan="1" style="vertical-align:top">
			
		<table id="basicContent" jsId="basicContent" class="maintain_form_content">
		
		<tr id="j_id9" jsId="j_id9" >
		
		<td id="j_id12" jsId="j_id12" class="maintain_form_input" style="text-align:center" >
			<div id="priority_div" eventProxy="MForm0" class="matrixInline" ></div>
		<script>
		 	var Mpriority_VM=[];
		    var priority=isc.SelectItem.create({
		    		ID:"Mpriority",
		    		name:"priority",
		    		editorType:"SelectItem",
		    		displayId:"priority_div",
		    		valueMap:[],
		    		value:"${param.priority}",
		    		position:"relative",
		    		width:290
		    });
		    MForm0.addField(priority);
		    Mpriority_VM=['0','1','2','3'];
		    Mpriority.displayValueMap={'0':'普通','1':'中级','2':'高级','3':'特级'};
		    Mpriority.setValueMap(Mpriority_VM);
		   
		</script>
			
		</td>
	 </tr>


		</table>
		</td>
	</tr>
	
	<tr id="j_id9" jsId="j_id9" height="20px">
		<td id="j_id10" jsId="j_id10" class="maintain_form_input" colspan="2"
			rowspan="1"><script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem3",
                                    icon:Matrix.getActionIcon("save"),
                                    title: "确认",
                                    
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem3.click = function() {
                                    Matrix.showMask();
                                    var priority = Matrix.getMatrixComponentById("priority").getValue();
                                    Matrix.closeWindow(priority,1);
                                    Matrix.hideMask();
                                }
                            </script> <script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem4",
                                    icon:Matrix.getActionIcon("exit"),
                                    title: "取消",
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
                                         members: [MToolBarItem3, "separator", MToolBarItem4]
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
</span>