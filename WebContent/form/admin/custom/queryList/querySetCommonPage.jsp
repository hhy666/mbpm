<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<style type="text/css">
	
</style>
	<script>
	
		function confirmSelect(){
				var item = main_iframe1.contentWindow.MDataGrid001.getSelection();
				if(item!=null && item.length==1){
					Matrix.closeWindow(item[0]);
				}else{
					Matrix.warn("请选择一条数据！");
					return ;
				}
		}
		
	</script>
<head>
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>
<script type="text/javascript">
</script>
</head>
<body ">
	
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>
<script> var Mform0=isc.MatrixForm.create({
	ID:"Mform0",
	name:"Mform0",
	position:"absolute",
	action:"",
	fields:[{name:'form0_hidden_text',
			 width:0,
			 height:0,
			 displayId:'form0_hidden_text_div'
	}]});
</script>
<div style="width: 100%; height: 100%; overflow: auto; position: relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;overflow:hidden;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" value="form0" />
	<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
	<input type="hidden" name="formId" id="formId" value="${param.formId }" />
	<input type="hidden" name="mIsQueryMode" id="mIsQueryMode" value="${mIsQueryMode }" />
	<div id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
	<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
	<table id="table101" name="table101" style="width:100%;height:100%;">
		<tr id="tr101" name="tr101">
			<td id="td101" name="td101" style="width:100%;height:94%;">
				<table id="table102" name="table102" style="width:100%;height:100%;">
					<tr>
						<td id="td104" name="td104">
							<div class="main" style="width:100%;height:100%;">
    							<iframe id="main_iframe1" src="<%=request.getContextPath()%>/BizDataListServlet?formId=${param.formId }&mIsQueryMode=${mIsQueryMode }" style="width:100%;height:100%;" frameborder="0"></iframe>
    						</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr id="tr102" name="tr102">
			<td id="td102" name="td102" class="cmdLayout" style="width:100%;height:40px;text-align:center;">
				<div id="button001_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
					<script>
						isc.Button.create({
							ID:"Mbutton001",
							name:"button001",
							title:"确认",
							displayId:"button001_div",
							position:"absolute",
							top:0,left:0,
							width:"100%",
							height:"100%",
							//icon:"[skin]/images/matrix/actions/save.png",
							showDisabledIcon:false,
							showDownIcon:false,
							showRollOverIcon:false
						});
						Mbutton001.click=function(){
							Matrix.showMask();
							var dataGrid = main_iframe1.contentWindow.MDataGrid001;
								if(dataGrid!=null && dataGrid!='undefined' && dataGrid!='null'){
									confirmSelect();
								
								}
							    Matrix.hideMask();
							};
						</script>
					</div>
					<div id="button002_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
						<script>
							isc.Button.create({
								ID:"Mbutton002",
								name:"button002",
								title:"关闭",
								displayId:"button002_div",
								position:"absolute",
								top:0,left:0,
								width:"100%",
								height:"100%",
								//icon:"[skin]/images/matrix/actions/delete.png",
								showDisabledIcon:false,
								showDownIcon:false,
								showRollOverIcon:false
							});
							Mbutton002.click=function(){
								Matrix.showMask();
								Matrix.closeWindow();
								Matrix.hideMask();
							};
						</script>
					</div>	
					
			</td>	
		</tr>
	
	</table>
			
			
</form></div>
<script type="text/javascript">
		var data = {};
	</script>
				<!-- 主窗口  所有的弹窗都配置targetDialog  MainDialog-->
				<script>function getParamsForMainDialog(){
									var params='&';
									var value;return params;
								}
								isc.Window.create({
									ID:"MMainDialog",
									id:"MainDialog",
									name:"MainDialog",
									position:"absolute",
									height: "50%",
									width: "50%",
									title: "",
									autoCenter: true,
									animateMinimize: false,
									canDragReposition: true,
									showHeaderIcon:false,
									showTitle:true,
									showMinimizeButton:false,
									showMaximizeButton:true,
									showCloseButton:true,
									showModalMask: false,
									isModal:true,
									autoDraw: false,
								});
								</script>
					<!-- 主窗口1  所有的弹窗都配置targetDialog  MainDialog-->
				<script>function getParamsForMainDialog1(){
									var params='&';
									var value;return params;
								}
								isc.Window.create({
									ID:"MMainDialog1",
									id:"MainDialog1",
									name:"MainDialog1",
									position:"absolute",
									height: "50%",
									width: "50%",
									title: "",
									autoCenter: true,
									animateMinimize: false,
									canDragReposition: false,
									showHeaderIcon:false,
									showTitle:true,
									showMinimizeButton:false,
									showMaximizeButton:false,
									showCloseButton:true,
									showModalMask: false,
									isModal:true,
									autoDraw: false,
								});
								</script>			
								
								
								

<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script></body>
</html>