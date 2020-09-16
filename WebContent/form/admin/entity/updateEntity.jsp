<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML > 
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil" %>
	<%  
		int currentPhase = CommonUtil.getCurPhase();

	%>
<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>更新实体信息</title>
	<jsp:include page="/form/admin/common/taglib.jsp"/>
	<jsp:include page="/form/admin/common/resource.jsp"/>
	<script type="text/javascript">
		//主键生成策略变化 序列名
		 function keyStrategyChanged(value){
		 	var sequenceName = Matrix.getMatrixComponentById('sequenceName');
		 	var seqNameTr = document.getElementById("sequenceNameTr");
		 	if(value=='sequence'){//如果为序列 序列输入框可用
		 		//tr显示
		 		seqNameTr.style.display = "table-row";
		 		sequenceName.setDisabled(false);
		 		sequenceName.setRequired (true);
		 	}else{//其余类型不可用
		 	    sequenceName.clearValue();
		 	    sequenceName.setRequired (false);
		     	sequenceName.setDisabled(true);
		     	seqNameTr.style.display = "none";
		 	}
		 
		 }
		 
		 function initPage(){
		 	 	var phase = "<%=currentPhase%>";
		 	if(phase=="1"||phase=="4"){//需求分析&业务定制阶段
		 		MtableName.setRequired(false);
		 		
		 		document.getElementById("tableNameTr").style.display="none";
		 		document.getElementById("keyStrategyTr").style.display="none";
		 		document.getElementById("cacheTypeTr").style.display="none";
		 	
		 	}
		 
		 }
		 
		 
	</script>
	
	
</head>
<body onload="initPage()">
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
<script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"MForm0",
	 		position:"absolute",
	 		action:"",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	 });
	</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
	  action="<%=request.getContextPath()%>/entity/entityInfo_updateEntityInfo.action" 
	  style="margin:0px;" enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
<input type="hidden" name="parentNodeId" value="parentNodeId" value="${param.parentNodeId}" />
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" 
			style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;"></div>
<div style="text-valign:center;position:relative">
<table id="j_id3" jsId="j_id3" class="maintain_form_content">
		<tr id="j_id4" jsId="j_id4">
			<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id6" name="j_id6" style="margin-left:10px">编码：</label>
			</td>
			<td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
				<div id="definedId_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
					<script>
					  var definedId=isc.TextItem.create({
						  	ID:"MdefinedId",
						  	name:"definedId",
						  	editorType:"TextItem",
						  	displayId:"definedId_div",
						  	position:"relative",
						  	width:290,
						  	value:"${entityInfo.mid}",
						  	disabled:true,
						  	required:true
					  });
					  MForm0.addField(definedId);
					</script>
				 <span id="MultiLabel0" style="width: 28px;height:20px; color: #FF0000">*</span>
			</td>
		</tr>
		<tr id="j_id9" jsId="j_id9">
			<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id11" name="j_id11" style="margin-left:10px">名称：</label>
		    </td>
			<td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1" rowspan="1">
				<div id="name_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
				<script> 
					var name2=isc.TextItem.create({
						ID:"Mname",
						name:"name",
						editorType:"TextItem",
						displayId:"name_div",
						position:"relative",
						width:290,
						value:"${entityInfo.name}",
						validators:[{
		      		    	type:"custom",
		      		    	condition:function(item, validator, value, record){
		      		         	return inputNameValidate(item, validator, value, record);
		      		         },
		      		         errorMessage:"名称不能为空!"
		      		 	}]
					});
					MForm0.addField(name2);
				</script>
				<span id="MultiLabel1" style="width: 29px;height:20px; color: #FF0000">*</span>
				<span id="nameEchoMessage"
									style="color: #FF0000">${nameEchoMessage}</span>
			</td>
		</tr>
		
		<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" >
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 启用状态：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1" rowspan="1">
			<div id="state_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var Mstate_VM=[];
		    var state=isc.SelectItem.create({
		    		ID:"Mstate",
		    		name:"state",
		    		editorType:"SelectItem",
		    		displayId:"state_div",
		    		valueMap:[],
		    		value:"${entityInfo.state}",
		    		position:"relative",
		    		width:290
		    });
		    MForm0.addField(state);
		    Mstate_VM=['1','0'];
		    Mstate.displayValueMap={'1':'启用','0':'未启用'};
		    Mstate.setValueMap(Mstate_VM);
		    
		    
		   
		</script>
			
			
		</td>
	</tr>
		<tr id="j_id114" jsId="j_id114">
			<td id="j_id115" jsId="j_id115" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id116" name="j_id116" style="margin-left:10px">路径：</label>
			</td>
			<td id="j_id117" jsId="j_id117" class="maintain_form_input" colspan="1" rowspan="1">
				<div id="entityLabel_div" eventProxy="MForm0" class="matrixInline" style=""></div>
				<script> var entityLabel=isc.TextItem.create({
								ID:"MentityLabel",
								name:"entityLabel",
								editorType:"TextItem",
								displayId:"entityLabel_div",
								position:"relative",
								width:290,
								value:"${entityInfo.entity}",
								canEdit:false
					    });
					    MForm0.addField(entityLabel);
			    </script>
			  
			  </td>
		</tr>
		<tr id="tableNameTr" jsId="j_id14">
			<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id16" name="j_id16" style="margin-left:10px">表名：</label>
			</td>
			<td id="j_id17" jsId="j_id17" class="maintain_form_input" colspan="1" rowspan="1">
				<div id="tableName_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
				<script> var tableName=isc.TextItem.create({
								ID:"MtableName",
								name:"tableName",
								editorType:"TextItem",
								displayId:"tableName_div",
								position:"relative",
								width:290,
								value:"${entityInfo.tableName}",
								required:true
					    });
					    MForm0.addField(tableName);
			    </script>
			    <span id="tableMultiLabel1" style="width: 29px;height:20px; color: #FF0000">*</span>
			  </td>
		</tr>
		<tr id="keyStrategyTr" jsId="j_id19">
			<td id="j_id20" jsId="j_id20" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id21" name="j_id21" style="margin-left:10px">主键生成策略：</label>
			</td>
		 <td id="j_id22" jsId="j_id22" class="maintain_form_input" colspan="1" rowspan="1">
			<div id="keyStrategy_div" eventProxy="MForm0" class="matrixInline" style=""></div>
			<script> 
				var MkeyStrategy_VM=[];
			    var keyStrategy=isc.SelectItem.create({
			    		ID:"MkeyStrategy",
			    		name:"keyStrategy",
			    		editorType:"SelectItem",
			    		displayId:"keyStrategy_div",
			    		valueMap:[],
			    		value:"${entityInfo.keyStrategy}",
			    		position:"relative",
			    		width:290,
			    		changed:function(form, item, value){
			    			keyStrategyChanged(value);
			    		
			    		}
			    });
			    MForm0.addField(keyStrategy);
			    MkeyStrategy_VM=['assigned','uuid.hex','increment','sequence'];
			    MkeyStrategy.displayValueMap={'assigned':'assigned','uuid.hex':'uuid.hex','increment':'increment','sequence':'sequence'};
			    MkeyStrategy.setValueMap(MkeyStrategy_VM);
			    //MkeyStrategy.setValue('uuid');
			  </script>
		  </td>
		</tr>
		
			<tr id="sequenceNameTr" jsId="j_id14">
			<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id16" name="j_id16" style="margin-left:10px">序列名：</label>
			</td>
			<td id="j_id17" jsId="j_id17" class="maintain_form_input" colspan="1" rowspan="1">
				<div id="sequenceName_div" eventProxy="MForm0" class="matrixInline" style=""></div>
				<script> var sequenceName=isc.TextItem.create({
								ID:"MsequenceName",
								name:"sequenceName",
								editorType:"TextItem",
								displayId:"sequenceName_div",
								position:"relative",
								width:290,
								value:"${entityInfo.sequenceName}",
								disabled:'${entityInfo.keyStrategy}'!='sequence'
					    });
					    MForm0.addField(sequenceName);
					    
			    </script>
			   
			  </td>
		</tr>
		 <script>
		    var displayVal = ('${entityInfo.keyStrategy}'=='sequence')?"table-row":"none";
		 	document.getElementById("sequenceNameTr").style.display = displayVal;
		 </script>
	    <tr id="cacheTypeTr" jsId="j_id114">
		<td id="j_id115" jsId="j_id115" class="maintain_form_label" colspan="1" rowspan="1" style=" width: '20%'">
		<label id="j_id116" name="j_id116" style="margin-left: 10px"> 缓存类型：</label>
		</td>
		<td id="j_id117" jsId="j_id117" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="cacheType_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var McacheType_VM=[];
		    var cacheType=isc.SelectItem.create({
		    		ID:"McacheType",
		    		name:"cacheType",
		    		editorType:"SelectItem",
		    		displayId:"cacheType_div",
		    		valueMap:[],
		    		value:"${entityInfo.cacheType}",
		    		position:"relative",
		    		width:290
		    });
		    MForm0.addField(cacheType);
		    McacheType_VM=['none','read-only','read-write','nonstrict-read-only'];
		    McacheType.displayValueMap={'none':'无','read-only':'只读型','read-write':'读写型','nonstrict-read-only':'非严格读写型'};
		    McacheType.setValueMap(McacheType_VM);
		   // McacheType.setValue('none');
		</script></td>
	</tr>
	
	<tr id="j_id1141" jsId="j_id1141">
			<td id="j_id1151" jsId="j_id1151" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id1161" name="j_id1161" style="margin-left:10px">存储类型：</label>
			</td>
			<td id="j_id1171" jsId="j_id1171" class="maintain_form_input" colspan="1" rowspan="1">
				<div id="storeType_div" eventProxy="MForm0" class="matrixInline" style=""></div>
				<script> 
				var MstoreType_VM=[];
				var storeType = isc.SelectItem.create({
								ID:"MstoreType",
								name:"storeType",
								editorType:"SelectItem",
								displayId:"storeType_div",
								valueMap:[],
								position:"relative",
								width:290,
								value:"${entityInfo.storeType}",
								canEdit:false
					    });
					    MForm0.addField(storeType);
					    MstoreType_VM=['','1','2'];
					    MstoreType.displayValueMap={'':'服务器','1':'服务器','2':'本地'};
			    </script>
			  
			  </td>
		</tr>
	
	  <tr id="dsNameTr" jsId="j_id4u">
               <td id="j_id5u" jsId="j_id5u" class="maintain_form_label" colspan="1" rowspan="1"
                      style="width: '20%'">
                     <label id="j_id6u" name="j_id6u" style="margin-left: 10px">
                                                	数据源名称：
                      </label>
                </td>
                 <td id="j_id7u" jsId="j_id7u" class="maintain_form_input" colspan="1" rowspan="1">
                 <div id="dsName_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var MdsName_VM=[];
		    var dsName=isc.SelectItem.create({
		    		ID:"MdsName",
		    		name:"dsName",
		    		editorType:"SelectItem",
		    		displayId:"dsName_div",
		    		valueMap:[],
		    		position:"relative",
		    		width:290,
		    		value:"${entityInfo.dsName}",
		    		canEdit:false
		    		
		    });
		    
		    MForm0.addField(dsName);
			MdsName.displayValueMap={'':'默认'};
		</script>
           
                                          
           </td>
        </tr>
	
		<tr id="j_id27" jsId="j_id27">
	  		<td id="j_id28" jsId="j_id28" class="maintain_form_label" colspan="1" rowspan="1">
	  			<label id="j_id29" name="j_id29" style="margin-left:10px">描述：</label>
	  		</td>
	        <td id="j_id30" jsId="j_id30" class="maintain_form_input" colspan="1" rowspan="1">
	        	<div id="desc_div" eventProxy="MForm0" class="matrixInline" style=""></div>
	        	<script>
	        		 var desc=isc.TextAreaItem.create({
	        		 		ID:"Mdesc",
	        		 		name:"desc",
	        		 		editorType:"TextAreaItem",
	        		 		displayId:"desc_div",
	        		 		position:"relative",
	        		 		value:"${entityInfo.desc}",
	        		 		width:290,
	        		 		height:100
	        		 });
	        		 MForm0.addField(desc);
	            </script>
	       </td>
		  </tr>
		  
		  <tr id="j_id31" jsId="j_id31">
		  		<td id="j_id32" jsId="j_id32" class="maintain_form_command" colspan="2" rowspan="1">
		 			 <div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
		  			<script>
		  				isc.Button.create({
		  					ID:"MdataFormSubmitButton",
		  					name:"dataFormSubmitButton",
		  					title:"保存",
		  					displayId:"dataFormSubmitButton_div",
		  					position:"absolute",
		  					top:0,
		  					left:0,
		  					width:"100%",
		  					height:"100%",
			icon:Matrix.getActionIcon("save"),
		  					showDisabledIcon:false,
		  					showDownIcon:false,
		  					showRollOverIcon:false});
		  					MdataFormSubmitButton.click=function(){
		  							Matrix.showMask();
		  					
		  					if(!MForm0.validate()){
		  						Matrix.hideMask();
		  						 return false;
		  				 	}
		  				 	
		  				 	Matrix.convertFormItemValue('Form0');
		  				 	//document.getElementById('Form0').submit();
		  				 	Matrix.send("Form0",null,callbackFun);
		  				 	Matrix.hideMask();
		  				 	};
		  				 	//更新回调函数
		  				 	function callbackFun(data){
		  				 		//返回成功时刷新树节点parentNodeId
		  				 		parent.parent.Matrix.forceFreshTreeNode("Tree0","${param.parentNodeId}");
		  				 	     isc.say(data.data);
		  				 	}
		  			</script>
		  		</div>
		     </td>
		</tr>
</table>

</div>
        <input id="entity" type="hidden" name="entity" value="${entityInfo.entity}" />
		<input id="mid" type="hidden" name="mid" value="${entityInfo.mid}" />
		<input id="type" type="hidden" name="type" value="${entityInfo.type}" />
		<input id="tenantId" type="hidden" name="tenantId" value="${entityInfo.tenantId}" />
		<input id="uuid" type="hidden" name="uuid"  value="${entityInfo.uuid}"/>
		<input id="createdDate" type="hidden" name="createdDate"  value="${entityInfo.createdDate}"/>
		<input id="lastModifiedDate" type="hidden" name="lastModifiedDate" value="${entityInfo.lastModifiedDate}" />
		<input id="lastModifiedUser" type="hidden" name="lastModifiedUser"  value="${entityInfo.lastModifiedUser}"/>
		<input id="createdUser" type="hidden" name="createdUser"  value="${entityInfo.createdUser}"/>
		
		<input id="phase" type="hidden" name="phase"  value="${entityInfo.phase}"/>
</form>
<script>
	MForm0.initComplete=true;
	MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>
</body>
</html>