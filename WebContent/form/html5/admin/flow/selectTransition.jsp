<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<%@ page import="java.util.List"%>
<%@ page import="com.matrix.api.template.activity.AvailableTransition"%>
<%@ page import="com.matrix.api.identity.MFPotentialOwner"%>
<%@ page import="com.matrix.form.render.util.RenderKitUtils"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选择流转和执行人</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<style type="text/css">
.ibox-content {
    background-color: #fff;
    color: inherit;
    padding: 15px 20px 20px;
    border-color: #e7eaec;
    -webkit-border-image: none;
    -o-border-image: none;
    border-image: none;
    border-style: solid solid none;
    border-width: 1px 0;
}
.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th{
	vertical-align: middle;
}
.form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control {
    background-color: rgb(253, 253, 219);
}
/*设置按钮栏置底 
.btnTd{
	position: absolute;
    bottom: 0px;
    text-align: center;
    width: 100%;
    left: 0;
    right: 0px;
    background-color: #fff;
}
.btnTr{
	position: absolute;
    bottom: 0px;
    width: 100%;
    left: 0;
} */
</style>
<script type="text/javascript">
/* 所有用户单选 回调*/
function onsingleSelectClose(data){
	var i = parent.iframeI;
	if(data){
		$('#selectFromAllIds'+i).val(data.ids);
		$('#selectFromAllText'+i).val(data.names);
	}else{
		$('#selectFromAllIds'+i).val('');
		$('#selectFromAllText'+i).val('');
	}
}

/* 所有用户混合选择  回调*/
function onmixSelectClose(data){
	var i = parent.iframeI;
	if(data){
		$('#selectFromAllIds'+i).val(data.ids);
		$('#selectFromAllText'+i).val(data.names);
	}else{
		$('#selectFromAllIds'+i).val('');
		$('#selectFromAllText'+i).val('');
	}
}
</script>
</head>
<body>
<div class="container" style="height:100%;">
	<div class="row" style="height:100%;">
		<div class="col-xs-12" style="height:100%;">
			<div class="ibox float-e-margins" style="height:100%;">
				<div class="ibox-content" style='overflow: auto;height:100%;' >
				    <table class="table">
				    	<thead>
	                        <tr>
	                            <th colspan="6">分支和人员选项</th>
	                        </tr>
                        </thead>
				        <tbody>
				        <%
//				        	List<List<MFPotentialOwner>> ownersList = (List<List<MFPotentialOwner>>)request.getAttribute("allTransitionsInfo");//待选择的人员
//					        List<AvailableTransition> transitions = (List<AvailableTransition>)request.getAttribute("transitions");//集合 取 名字，执行人数
				        	List<List<MFPotentialOwner>> ownersList = (List<List<MFPotentialOwner>>)request.getSession().getAttribute("allTransitionsInfo");//待选择的人员
					        List<AvailableTransition> transitions = (List<AvailableTransition>)request.getSession().getAttribute("transitions");//集合 取 名字，执行人数
					        
					        boolean isMobile = RenderKitUtils.isMobile();   //是否为移动端
					    %>
					    	<script type="text/javascript">	
					    		var heightNum;
					    		var widthNum;
					        	if(<%=isMobile %>){
					        		heightNum = '100%';
					        		widthNum = '100%';
					        	}else{
					        		heightNum = '70%';
					        		widthNum = '80%';
					        	}
					        </script>	
					    <% 
					        Boolean isMultiOutTransitions = (Boolean)request.getSession().getAttribute("isMultiOutTransitions");
					        
					        if(transitions == null || ownersList == null ){
					        %>
					        	<script type="text/javascript">	
					        		Matrix.closeWindow();
					        	</script>	
					        
					        <%	
					        }
					        
					        if(transitions != null){
					        	
				        	for(int i=0; i<transitions.size(); i++){
				        		AvailableTransition transition = transitions.get(i);
				        		List<MFPotentialOwner> ownerList = ownersList.get(i);
				        		%>
					        <tr>
					        	<td style="text-align: center; width:5%;" >
					        	<div class="form-group;" style="display: inline-table;" >
					        	<%if(isMultiOutTransitions == null || isMultiOutTransitions == false){ %>
										<input type="checkbox" class="box" name="transitionsCheckbox"
								<%}else{ %>		
										<input type="radio" class="box" name="transitionsCheckbox"
								<%} %>		
										value="<%=transition.getTdid() %>" 
										<%
											if(transitions.size()==1 && transition.getRouteType() == 1){
												//1.如果只有一个分支且为手工选择，默认选中
												%>
												checked
												<%
											}
											if(transition.getForceType() == 1){//强制
												if(transition.getRouteType() == 0){//条件
													if(transition.isConditionFlag()){//条件满足
														//4.如果 为条件分支，强制类型，条件满足(isConditionFlag)， 显示选中且不可改
														%>
														checked Disabled 
														<%
													}else{//条件不满足
														//8.如果为条件分支，强制类型，条件都不满足(isConditionFlag==false)，默认不选中，且不可改，显示desc
														%>
														Disabled  
														<%
													}
												}else if(transition.getRouteType() == 1 ){//手动
													
												}
											}else if(transition.getForceType() == 0){//非强制
												if(transition.getRouteType() == 0){//条件
													if(transition.isConditionFlag()){//条件满足
														//2.如果为条件分支，非强制类型，条件满足时(isConditionFlag),默认选中(第一条分支)
														if(i==0){
														%>
														checked
														<%
														}
													}else{//条件不满足
														//3.如果为条件分支，非强制类型，条件不满足时(isConditionFlag==false),默认不选中，且不可改，显示desc
														%>
														Disabled
														<%
													}
												}else if(transition.getRouteType() == 1 ){//手动
													
												}
											}
										%>
                                      />
                                    <label></label>
                                </div>
					        	</td>
					            <td width="24%"><%=transition.getName() %></td>
					            <%if(!RenderKitUtils.isMobile()){ %>
					            <td width="10%">
					            	<%
					            		if(transition.isMultiPotentialOwners()){
					            			%>
					            			（多人执行）
					            			<%
					            		}else{
					            			%>
											（单人执行）
					            			<%
					            		}
					            	%>
					            	</td>
					            	<td width="20%" style="text-align:center; ">
					            	<%
					            		if(transition.getRouteType() == 1){//分支类型：   0 条件分支  1 手动分支
					            			%>
					            			手动选择分支
					            			<%
										}else if(transition.getRouteType() == 0){
											if(transition.isConditionFlag()){//条件满足
												%>
												<div><label style="color: rgb(0, 114, 255);">分支条件满足</label></div>
												<div><%=transition.getDesc()==null?"":transition.getDesc() %></div>
						            			<%
											}else{//条件不满足
												%>
												<div><label style="color: rgb(0, 114, 255);">分支条件不满足</label></div>
												<div><%=transition.getDesc()==null?"":transition.getDesc() %></div>
						            			<%
											}
					            		}
					            	%>
					            	
					            </td>
					            <%
					            }
					            %>
					            <td 
					            <%
					            if(!RenderKitUtils.isMobile()){
					            %>
					            width="10%" 
					            <%
					            }else{
					            	%>
					            	 width="20%" 
					            	<%
					            }
					            %>
					            style='text-align:right;'>
					            	<div><label >执行人：</label></div>
					            </td>
					            <td width="30%">
					            	
					            	<div>
				            			<%
				            			if(transition.getIsAssignedToAll()){//从所有选
					            			%>
					            				<input id="selectFromAllIds<%=i%>" type="hidden">
					            				<input id="selectFromAllText<%=i%>" type="text" class="form-control" readonly="readonly" placeholder="点击此处选择执行人"
					            				 style="width:90%;" onclick=
					            					<%
					            					if(transition.isMultiPotentialOwners()){//从所有选多个
					            						%>
					            						"showMixSelect<%=i%>();"
					            						<%
						            				}else{//从所有选一个
						            					%>
						            					"showSingleSelect<%=i%>();"
						            					<%
						            				}
					            					%>
					            					>
					            					<script type="text/javascript">
														/* 所有用户单选 */
														function showSingleSelect<%=i%>(){
															parent.iframeWin = this;	
															parent.iframeI = <%=i%>;
															var index = parent.layer.open({
														    	id:'singleSelect',
																type : 2,//iframe 层
																
																title : ['单选执行人'],
																closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
																//maxmin: true,//弹出即全屏
																shadeClose: false, //开启遮罩关闭
																area : [ heightNum, widthNum ],
																content : '<%=path %>/office/html5/select/SingleSelectPerson.jsp?iframewindowid=singleSelect',
															});
														}
														
														/* 所有用户混合选择 */
														function showMixSelect<%=i%>(){
															var ids = $('#selectFromAllIds<%=i%>').val();
															var names = $('#selectFromAllText<%=i%>').val();
															parent.iframeWin = this;	
															parent.iframeI = <%=i%>;
															var index = parent.layer.open({
														    	id:'mixSelect',
																type : 2,//iframe 层
																
																title : ['多选执行人'],
																closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
																//maxmin: true,//弹出即全屏
																shadeClose: false, //开启遮罩关闭
																area : [ heightNum, widthNum ],
																content : '<%=path %>/office/html5/select/MultiSelectPerson.jsp?iframewindowid=mixSelect&selectIndex=<%=i%>',
															});
														}
													</script>
					            				<%
				            			}else{//从选中的数据中选
						            		if(!ownerList.isEmpty()){//是否为空
					            				if(transition.getRouteType() == 0  && transition.isConditionFlag() && ownerList.size()==1){
					            					//5，如果为条件分支，条件满足时(isConditionFlag),只有一个执行人，直接显示执行人名称文本
					            					//只有一个
					            					%>
					            					<input id="selectFromAllIds<%=i%>" type="hidden" value="<%=ownerList.get(0).getId() %>">
					            					<label><%=ownerList.get(0).getName() %></label>
						            				<%-- <input id="selectFromAllText<%=i%>" type="text" class="form-control" readonly="readonly" style="width:80%;" value="<%=ownerList.get(0).getString("name") %>"> --%>
					            					<%
					            				}else{//有多个
						            				if(transition.isMultiPotentialOwners()){//从选中的选多个
						            					%>
														<select id="optionsMore<%=i %>" class="form-control m-b selectpicker" multiple name="optionSelect" data-width="90%" data-none-selected-text="点击下拉多选执行人" >
														<%
															for(int j=0; j<ownerList.size(); j++){
																MFPotentialOwner obj = ownerList.get(j);
																%>
							                                    <option value="<%=obj.getId() %>"><%=obj.getName() %></option>
																<%
															}
														%>
						                                </select>
								            			<%
						            				}else{
								            			%>
														<select id="optionsSingle<%=i %>" class="form-control m-b" name="optionSelect" style="width:90%;">
														<%
															for(int j=0; j<ownerList.size(); j++){
																MFPotentialOwner obj = ownerList.get(j);
																%>
							                                    <option value="<%=obj.getId() %>"><%=obj.getName() %></option>
																<%
															}
														%>
						                                </select>
								            			<%
						            				}
					            				}
					            			}else{
					            				%>
					            				<label>系统自动分派</label>
					            				<%
					            			}
				            			}
					            		
					            	%>
					            	</div>
								</td>
					        </tr>
				        		
				        		<%
				        	}
				        	
					        }

				        %>
					     <tr class='btnTr'>
					     	<td colspan="6" class='cmdLayout'>
					     		<input type="hidden" id="ownerId">
			     				<input type="hidden" id="ownerId">
					     		<button type="button"  id="button001" class="x-btn ok-btn " >确认</button>
								<button type="button"  id="button002" class="x-btn cancel-btn " >取消</button>
								<script type="text/javascript">
									$('#button001').click(function(){
										var buttonFlag = document.getElementById('button001');
										buttonFlag.disabled = 'disabled';
										var data = new Array();
										var transitionsCheckboxs = document.getElementsByName('transitionsCheckbox');
										var transitionAndOwner = {};
										var selected = false;
										for(var i=0 ;i < transitionsCheckboxs.length; i++){
											if(transitionsCheckboxs[i].checked){
												selected = true;
												var ownersVal = null;
												var isSetOwner = false;
												if($('#selectFromAllIds'+i).length > 0){
													ownersVal = $('#selectFromAllIds'+i).val();
													isSetOwner = true;
												}else if($('#optionsMore'+i).length > 0) {
													ownersVal = $('#optionsMore'+i).selectpicker('val');
													isSetOwner = true;
												}else if($('#optionsSingle'+i).length >0) {
													ownersVal = $('#optionsSingle'+i).val();
													isSetOwner = true;
												}
												if(isSetOwner){  //是否需要选人
													if(ownersVal==null || ownersVal == ''){
														layer.msg('请选择执行人！');
														buttonFlag.disabled = '';
														return false;
													}else{
														if(typeof(ownersVal) == 'string')
															ownersVal = ownersVal.replace(new RegExp(";","gm"),",");
														transitionAndOwner[transitionsCheckboxs[i].value] = ownersVal;
													}
												}else{
													transitionAndOwner[transitionsCheckboxs[i].value] = "";
												}
												var ownersVal;
											}
										}
										if(selected == false){
											layer.msg('请至少选择一条执行！');
											buttonFlag.disabled = '';
											return false;
										}
										Matrix.closeWindow(transitionAndOwner);
									});
									
									$('#button002').click(function(){
										Matrix.closeWindow();
									});
								</script>
					     	</td>
					     </tr>   
				        </tbody>
				    </table>
				</div>
			</div>
		</div>
	</div>
</div>
<% 
request.getSession().setAttribute("allTransitionsInfo",null);
request.getSession().setAttribute("transitions",null);


%>

</body>
</html>