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
<script type="text/javascript">
		
	function check(){
		var uuid="<%=request.getParameter("uuid")%>";
		if(uuid!="null"){
			Mtitle.setCanEdit(true);
		}
	}
	
	function lengthValidate(item, validator, value, record){
    	var titleLength = value.length;
    	if(titleLength>40){
    		return false;
    	}
    	return true;
    }
	</script>
</head>
<body onload="check()">
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>

<script> var Mform0=isc.MatrixForm.create({ID:"Mform0",name:"Mform0",position:"absolute",action:"<%=request.getContextPath()%>/matrix.rform",fields:[{name:'form0_hidden_text',width:0,height:0,displayId:'form0_hidden_text_div'}]});</script>
<div
	style="width: 100%; height: 100%; overflow: auto; position: relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action="<%=request.getContextPath()%>/parts/partsAction_findAllParts.action"
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
<input type="hidden" name="uuid" id="uuid" value="${param.uuid}"/>	
<input type="hidden" name="partId" id="partId" value="${param.partId }"/>
<input type="hidden" name="portalId" id="portalId" value="${param.portalId }"/>	
<table class="maintain_form_content" style="width:100%;height:100%">
	<tr>
		<td class="maintain_form_label2">
			<label id="j_id0" name="j_id0">
				 标题
			</label>
		</td>
		<td class="maintain_form_input2">
			<div id="title_div" eventProxy="Mform0" class="matrixInline" style=""></div>
				<script> var title=isc.TextItem.create({
							ID:"Mtitle",
							name:"title",
							value:"${title}",
							editorType:"TextItem",
							displayId:"title_div",
							position:"relative",
							required:true,
							width:250,
							length:100,
							validators:[{
								type:"custom",
								condition:function(item, validator, value, record){
								return lengthValidate(item, validator, value, record);
							},
							errorMessage:"标题必须在40个字符之内!"}]
						});
						Mform0.addField(title);</script>
				<span id="validateIdMsg" style="width: 20px; height: 20px; color: #FF0000">
                    *
                </span>	
						</td>
	</tr>
	<tr>
		<td class="maintain_form_label2">
			<label id="j_id1" name="j_id1">
				链接地址
			</label>
		</td>
		<td class="maintain_form_input2">
			<div id="urlValue_div" eventProxy="Mform0" class="matrixInline" style=""></div>
				<script> var urlValue=isc.TextItem.create({
							ID:"MurlValue",
							name:"urlValue",
							value:"${urlValue}",
							editorType:"TextItem",
							displayId:"urlValue_div",
							position:"relative",
							required:true,
							width:250,
							length:100
						});
						Mform0.addField(urlValue);
				</script>
				<span id="validateIdMsg" style="width: 20px; height: 20px; color: #FF0000">
                    *
                </span>
		</td>
	</tr>
	<tr>
		<td class="maintain_form_label2">
			<label id="j_id2" name="j_id2">
				默认宽度
			</label>
		</td>
		<td class="maintain_form_input2">
			<div id="width_div" eventProxy="Mform0" class="matrixInline" style=""></div>
				<script> var width=isc.TextItem.create({
							ID:"Mwidth",
							name:"width",
							value:"${width}",
							editorType:"TextItem",
							displayId:"width_div",
							position:"relative",
							width:250,
							length:100
						});
						Mform0.addField(width);
				</script>
		</td>
	</tr>
	<tr>
		<td class="maintain_form_label2">
			<label id="j_id3" name="j_id3">
				默认高度
			</label>
		</td>
		<td class="maintain_form_input2">
			<div id="height_div" eventProxy="Mform0" class="matrixInline" style=""></div>
				<script> var height=isc.TextItem.create({
							ID:"Mheight",
							name:"height",
							value:"${height}",
							editorType:"TextItem",
							displayId:"height_div",
							position:"relative",
							width:250,
							length:100
						});
						Mform0.addField(height);
				</script>
		</td>
	</tr>
	<tr>
		<td class="maintain_form_label2">
			<label id="j_id8" name="j_id8">
				默认行数
			</label>
		</td>
		<td class="maintain_form_input2">
			<div id="rows_div" eventProxy="Mform0" class="matrixInline" style=""></div>
				<script> var rows=isc.TextItem.create({
							ID:"Mrows",
							name:"rows",
							value:"${rows}",
							editorType:"TextItem",
							displayId:"rows_div",
							position:"relative",
							width:250,
							length:100,
							validators:[
								{type:"custom",condition:function(item, validator, value, record){
										return Matrix.validateLongRange(0,20,value);
									},
									expression:"^\\d+$",errorMessage:"必须是0到20之间的整数!"
								}]
							});	
						Mform0.addField(rows);
				</script>
		</td>
	</tr>
	<tr>
		<td class="maintain_form_label2">
			<label id="j_id9" name="j_id9">
				默认列数
			</label>
		</td>
		<td class="maintain_form_input2">
			<div id="cols_div" eventProxy="Mform0" class="matrixInline" style=""></div>
				<script> var cols=isc.TextItem.create({
							ID:"Mcols",
							name:"cols",
							value:"${cols}",
							editorType:"TextItem",
							displayId:"cols_div",
							position:"relative",
							width:250,
							length:100,
							validators:[
								{type:"custom",condition:function(item, validator, value, record){
										return Matrix.validateLongRange(0,20,value);
									},
									expression:"^\\d+$",errorMessage:"必须是0到20之间的整数!"
								}]
						});
						Mform0.addField(cols);
				</script>
		</td>
	</tr>
	<tr>
		<td class="maintain_form_label2">
			<label id="j_id7" name="j_id7">
				更多(url)
			</label>
		</td>
		<td class="maintain_form_input2">
			<div id="more_div" eventProxy="Mform0" class="matrixInline" style=""></div>
				<script> var more=isc.TextItem.create({
							ID:"Mmore",
							name:"more",
							value:"${more}",
							editorType:"TextItem",
							displayId:"more_div",
							position:"relative",
							width:250,
							length:100
						});
						Mform0.addField(more);
				</script>
		</td>
	</tr>
	<tr>
		<td class="maintain_form_label2">
			<label id="j_id6" name="j_id6">
				状态
			</label>
		</td>
		<td class="maintain_form_input2">
			<span id="status_div" style="width:200px;">
				<table border="0" style="width:100%;height:100%;margin:0px;padding: 0px;display: inline;" cellspacing="0" cellpadding="0">
					
						<tr>
							<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;">
								<div id="status_0_div" eventProxy="Mform0"></div>
									<script> var status_0=isc.RadioItem.create({
												ID:"Mstatus_0",
												name:"status",
												editorType:"RadioItem",
												displayId:"status_0_div",
												value:"0",
												title:"启用",
												position:"relative",
												groupId:"status"
											});
											Mform0.addField(status_0);
									</script>
							</td>
							<td></td>
							<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;">
								<div id="status_1_div" eventProxy="Mform0"></div>
									<script> var status_1=isc.RadioItem.create({
												ID:"Mstatus_1",
												name:"status",
												editorType:"RadioItem",
												displayId:"status_1_div",
												value:"1",
												title:"禁用",
												position:"relative",
												groupId:"status"
											});
											Mform0.addField(status_1);
											Mform0.setValue("status","${status}");
									</script>
							</td>
						</tr>
						
				</table>
			</span>
		</td>
	</tr>
	<tr>
		<td class="maintain_form_command" colspan="2">
		<div id="button003_div" class="matrixInline"
			style="position: relative;; width: 100px;; height: 22px;">
			<script>
			isc.Button.create({
			ID:"Mbutton003",
			name:"button003",
			title:"保存",
			displayId:"button003_div",
			position:"absolute",
			top:0,left:0,
			width:"100%",height:"100%",
			icon:"<%=request.getContextPath()%>/resource/images/submit.png",
			showDisabledIcon:false,
			showDownIcon:false,
			showRollOverIcon:false
			});
			Mbutton003.click=function(){
				Matrix.showMask();
				if(!Mform0.validate()){
					Matrix.hideMask();
					return false;
				}
				var vituralbuttonHidden = document.getElementById('matrix_command_id');
				if(vituralbuttonHidden)
					vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);
				var currentForm = document.getElementById('form0');
				var buttonHidden = document.createElement('input');
				buttonHidden.type='hidden';
				buttonHidden.name='matrix_command_id';
				buttonHidden.id='matrix_command_id';
				buttonHidden.value='button003';
				currentForm.appendChild(buttonHidden);
				var _mgr=Matrix.convertDataGridDataOfForm('form0');
				if(_mgr!=null&&_mgr==false){
					Matrix.hideMask();
					return false;
				}
				document.getElementById('form0').action=
				"<%=request.getContextPath()%>/portal/partsAction_saveParts.action";	
				Matrix.send('form0',{'button003':'保存'},function(data){
					var json = isc.JSON.decode(data.data);
					if(json.result==true&&json.flag==true){
						Matrix.closeWindow();
						isc.say("保存成功！");
					}
					if(json.result==false&&json.flag==true){
						Matrix.closeWindow();
						isc.say("修改成功！");
					}
					if(json.result==true&&json.flag==false){
						isc.warn("已存在该部件");
					}
					
					
				});
				
				Matrix.hideMask();
           
				
			};
			</script></div>
		<div id="button004_div" class="matrixInline"
			style="position: relative;; width: 100px;; height: 22px;">
			<script>
				isc.Button.create({
						ID:"Mbutton004",
						name:"button004",
						title:"取消",
						displayId:"button004_div",
						position:"absolute",
						top:0,left:0,width:"100%",
						height:"100%",icon:"<%=request.getContextPath()%>/resource/images/return.png",
						showDisabledIcon:false,
						showDownIcon:false,
						showRollOverIcon:false
						});
					Mbutton004.click=function(){
						Matrix.showMask();
						Matrix.closeWindow();
						Matrix.hideMask();
					}
					
						</script></div>
		</td>
	</tr>
</table>


</form>

</div>
<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script>
</body>
</html>
