<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<style type="text/css">
	#td102{
		background:#F8F8F8;
		text-align:center;
	}
	#table101{
		/**border:3px #dedede solid;*/
	}
	#td103{
		width:25%;
		height:100%;
		border:3px #dedede solid;
	}
	#td104{
		width:75%;
		height:100%;
		border:3px #dedede solid;
	}
	#td105{/** 属性结构标题td*/
		width:100%;
		height:30px;
		background:#F8F8F8;
	}
	#td106{/** 属性结构内容td*/
		width:100%;
		height:94%;
		border:1px #dedede solid;
	}
	#font1{
		font-size:16px;
		margin-left:10px;
		font-weight:bold;
	}
	#font2{
		font-size:16px;
		margin-left:10px;
		font-weight:bold;
	}
	#td107{
		width:100%;
		height:30px;
		background:#F8F8F8;
	}
	#td108{
		width:100%;
		height:94%;
		border:1px #dedede solid;
	}
	<script>
		
		
	</script>
	
	
	
</style>
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
<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" value="form0" />
	<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
	<!-- 记录当前活动的id -->
	<input type="hidden" id="processdid" name="processdid" value="${param.processdid }"/>
	<input type="hidden" id="activityId" name="activityId" value="${param.activityId }"/>
	<input type="hidden" id="optType" name="optType" value="${param.optType }"/>
	<input type="hidden" id="type" name="type" value="${param.type}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType }"/>
	<div id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
	<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
	<table id="table101" name="table101" style="width:100%;height:100%;">
		<tr id="j_id2" jsId="j_id2">
			<td id="j_id3" jsId="j_id3"  height="60px"
				 style="height: 50px;width:100%;background-image:url(<%=request.getContextPath()%>/matrix/resource/images/probanner.jpg);background-size:100% 100%">
						<br>
				&nbsp;&nbsp;&nbsp;编辑流程活动节点属性，完成后点击保存或保存并关闭按钮.
			
			</td>
		</tr>
		
		<tr id="tr101" name="tr101">
			<td id="td101" name="td101" style="width:100%;height:94%;">
				<table id="table102" name="table102" style="width:100%;height:100%;">
					<tr>
					<!-- 属性结构树 -->
						<td id="td103" name="td103">
							<table id="table102" name="table102" style="width:100%;height:100%;">
								<tr id="tr105" name="tr105">
									<td id="td105" name="td105"><font id="font1">属性结构</font></td>
								</tr>
								<tr id="tr106" name="tr106">
									<td id="td106" name="td106">
											<!-- 
										<script type="text/javascript">
												 isc.HLayout.create({
        											ID: "MFrameLayout1",
        											position: "relative",
        											height: "100%",
        											width: "100%",
        											align: "center",
        											overflow: "auto",
        											resizeBarSize:1,
        											defaultLayoutAlign: "center",
        											members: [
														isc.HTMLPane.create({
															ID:"MContentPane1",
															height: "100%",
															overflow: "hidden",
															showEdges:false,
															contentsType:"page",
															contentsURL:"propertyDetailInfoPage.jsp"
														})
													] 
    											});
										</script>
									 -->
										<div class="main" style="width:100%;height:100%;">
    										<iframe id="main_iframe" src="logicActivityPropertyConstructionPage.jsp?activityId=${param.activityId }&type=${param.type }&processdid=${param.processdid }" style="width:100%;height:100%;" frameborder="0"></iframe>
    									</div>
    								
									</td>
								</tr>
							</table>
						</td>
					<!-- 属性详细信息 -->
						<td id="td104" name="td104">
										
							<div class="main" style="width:100%;height:100%;">
								
    							<iframe id="main_iframe1" src="<%=request.getContextPath()%>/editor/editor_autoLoadLogicActBasicInfo.action?activityId=${param.activityId }&type=${param.type }&processdid=${param.processdid }" style="width:100%;height:100%;" frameborder="0"></iframe>
    						
    						
    						</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr id="tr102" name="tr102">
			<td id="td102" name="td102" style="width:100%;height:32px;">
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
							icon:"[skin]/images/matrix/actions/save.png",
							showDisabledIcon:false,
							showDownIcon:false,
							showRollOverIcon:false
						});
						Mbutton001.click=function(){
							Matrix.showMask();
							comfirmSelect();
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
								icon:"[skin]/images/matrix/actions/delete.png",
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