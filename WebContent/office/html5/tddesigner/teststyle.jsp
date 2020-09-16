<%@page pageEncoding="utf-8"%>
<!DOCTYPE HTML><html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="../../../foundation/common/taglib.jsp"/>
<jsp:include page="../../../foundation/common/resource.jsp"/>
</head>
</head>
<body>
<script>
	function ontdStyleWindowClose(data){
		if(data!=null){
		Matrix.setFormItemValue('input001',data);
		}
	}
	function onlabelStyleWindowClose(data){
		if(data!=null){
		Matrix.setFormItemValue('input002',data);
		}
	}
</script>
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>

<script> var Mform0=isc.MatrixForm.create({ID:"Mform0",name:"Mform0",position:"absolute",action:"/mofficeV3/matrix.rform",canSelectText: true,fields:[{name:'form0_hidden_text',width:0,height:0,displayId:'form0_hidden_text_div'}]});</script><div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;zoom:1" id="context"><form id="form0" name="form0" eventProxy="Mform0" method="post" action="/mofficeV3/matrix.rform" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
<input type="hidden" name="form0" value="form0" />
<input type="hidden" name="is_mobile_request" />
<input type="hidden" name="mHtml5Flag" value="value" />
<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" value="914e6e06-ece3-4496-afe7-165fb4aaf28a" />
<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
<table id="table001" class="tableLayout" style="width:100%;"><tr id="tr001"><td id="td001" class="tdLayout" style="width:50%;"><label id="label001" name="label001" id="label001">
td样式</label></td>
<td id="td002" class="tdLayout" style="width:224.5px;"><div id="input001_div" eventProxy="Mform0" class="matrixInline" style="width:100%;"></div><script> var input001=isc.TextItem.create({ID:"Minput001",name:"input001",editorType:"TextItem",displayId:"input001_div",position:"relative",autoDraw:false});Mform0.addField(input001);</script></td>
<td id="td005" class="tdLayout" rowspan="1" style="width:224.5px;"><div id="button002_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;"><script>isc.Button.create({ID:"Mbutton002",name:"button002",title:"按钮",displayId:"button002_div",position:"absolute",top:0,left:0,width:"100%",height:"100%",showDisabledIcon:false,showDownIcon:false,showRollOverIcon:false});Mbutton002.click=function(){Matrix.showMask();var x = eval("Matrix.showWindow('tdStyleWindow');");if(x!=null && x==false){Matrix.hideMask();Mbutton002.enable();return false;}Matrix.hideMask();};</script></div></td>
</tr>
<tr id="tr002"><td id="td003" class="tdLayout" style="width:50%;"><label id="label002" name="label002" id="label002">
标签样式</label></td>
<td id="td004" class="tdLayout" colspan="1" style="width:225px;"><div id="input002_div" eventProxy="Mform0" class="matrixInline" style="width:100%;"></div><script> var input002=isc.TextItem.create({ID:"Minput002",name:"input002",editorType:"TextItem",displayId:"input002_div",position:"relative",autoDraw:false});Mform0.addField(input002);</script></td>
<td id="td006" class="tdLayout" rowspan="1" style="width:225px;"><div id="button001_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;"><script>isc.Button.create({ID:"Mbutton001",name:"button001",title:"按钮",displayId:"button001_div",position:"absolute",top:0,left:0,width:"100%",height:"100%",showDisabledIcon:false,showDownIcon:false,showRollOverIcon:false});Mbutton001.click=function(){Matrix.showMask();var x = eval("Matrix.showWindow('labelStyleWindow');");if(x!=null && x==false){Matrix.hideMask();Mbutton001.enable();return false;}Matrix.hideMask();};</script></div></td>
</tr>
</table>
<script>function getParamsFortdStyleWindow(){var params='&';var value;return params;}isc.Window.create({ID:"MtdStyleWindow",id:"tdStyleWindow",name:"tdStyleWindow",autoCenter: true,position:"absolute",height: "550px",width: "700px",title: "单元格样式设置",canDragReposition: false,showMinimizeButton:true,showMaximizeButton:true,showCloseButton:true,showModalMask: false,modalMaskOpacity:0,isModal:true,autoDraw: false,headerControls:["headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"],getParamsFun:getParamsFortdStyleWindow,initSrc:"/mofficeV3/office/html5/tddesigner/tdstyle.jsp",src:"/mofficeV3/office/html5/tddesigner/tdstyle.jsp",showFooter: false });</script><script>MtdStyleWindow.hide();</script><script>function getParamsForlabelStyleWindow(){var params='&';var value;return params;}isc.Window.create({ID:"MlabelStyleWindow",id:"labelStyleWindow",name:"labelStyleWindow",autoCenter: true,position:"absolute",height: "50%",width: "50%",title: "样式设置",canDragReposition: false,showMinimizeButton:true,showMaximizeButton:true,showCloseButton:true,showModalMask: false,modalMaskOpacity:0,isModal:true,autoDraw: false,headerControls:["headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"],getParamsFun:getParamsForlabelStyleWindow,initSrc:"/mofficeV3/office/html5/tddesigner/labelstyle.jsp",src:"/mofficeV3/office/html5/tddesigner/labelstyle.jsp",showFooter: false });</script><script>MlabelStyleWindow.hide();</script>
</form></div><script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script></body>
</html>
