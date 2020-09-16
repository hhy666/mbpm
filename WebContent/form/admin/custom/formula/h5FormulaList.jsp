<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>H5计算公式列表</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<style type="text/css">
		div{
			box-sizing: border-box;
			-webkit-user-select: none;
		    -khtml-user-select: none;
		    -moz-user-select: none;
		    -ms-user-select: none;
		    -o-user-select: none;
		    user-select: none;
		}
	</style>
	<script type="text/javascript">
		//弹出条件窗口
		function openFormula(id,index){
			var data = Matrix.getGridData('DataGrid001');   //所有数据
			//当前行
			var record = data[index];
			var flag = id.substr(0, id.indexOf('.'));
			var type = record.type;   //字段类型
			var setType = record.formulaType;  //条件类型   0.普通  1.高级
			var formulaVal = record.formulaVal;  //计算公式条件编码
			
			var num=false;
		  	if(type==2||type==3||type==4||type==5||type==9){
		  		num=true;
		  	}
		
			$("#formulaSetId").val(formulaVal);
			
			var suffixId = id.substr(id.indexOf('.') + 1);
			var contentUrl = "";
			if(setType=='0'){ //普通设置
				contentUrl = "<%=request.getContextPath() %>/condition/condition_loadConditionSet.action?iframewindowid=m_formula&setType="+setType+"&flag="+flag+"&num="+num+"&entrance=GeneralFormula&suffixId="+suffixId+"&index="+index+"&formulaSetId="+encodeURIComponent(formulaVal);
			}else{
				contentUrl = "<%=request.getContextPath() %>/condition/condition_loadConditionSet.action?iframewindowid=m_formula&setType="+setType+"&flag="+flag+"&entrance=AdvancedFormula&suffixId="+suffixId+"&index="+index+"&formulaSetId="+encodeURIComponent(formulaVal);
			}
			//记录弹出窗口对象
			parent.isc.MFH.winObj = this;
			//弹出窗口
			parent.layer.open({
		    	id:'m_formula',
				type : 2,
				
				title : ['设置计算公式'],
				shade: [0.1, '#000'],
				shadeClose: false, //开启遮罩关闭
				area : [ '65%', '80%' ],
				content : contentUrl
			});			
		}
	</script>
</head>
<body>
	<div style="position: absolute;height: 100%;width: 100%;">
	   <form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin: 0px; position: relative; overflow: hidden; width: 100%; height: 100%;overflow: auto;" enctype="application/x-www-form-urlencoded">
		   <input type="hidden" name="form0" value="form0" />
		   <input type="hidden" id="formulaSetId" name="formulaSetId"/>  <!-- 记录当前选择行的计算公式条件编码 -->
		   
		    <div style="height:calc(100% - 54px);overflow: auto;">
			   <table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
					<tr>
						<td colspan="2" style="border-style:none;width:100%;margin:0px;padding:0px;vertical-align: top;">
							<table id="DataGrid001_table" style="width:100%;height:100%;">
								
							</table>
							
							<script>
							$(document).ready(function() {   
								$("#DataGrid001_table").bootstrapTable({           
									classes: 'table table-hover table-no-bordered',
									method: "post", 
									contentType : "application/x-www-form-urlencoded",  //必须配置 不然queryParams传参后台获取不到
									url: "<%=path%>/formula/formula_queryH5All.action", 
									search: false,    //是否启用搜索框
									sortable: false,  //是否启用排序
									pagination:false, //是否启用分页
									sidePagination: "server",  //指定服务器端分页
									formatLoadingMessage: function() {
							            return '请稍等，正在加载中...';
								    },
									formatNoMatches: function() {
							            return '无符合条件的记录';
							        },
								    columns: [							       
									   {
								         title : '序号',
								         align: "center",
								         valign: "middle",
								         width: 50,
								         formatter: function (value, row, index) {
								        	  //获取每页显示的数量
								        	  var pageSize=$('#DataGrid001_table').bootstrapTable('getOptions').pageSize;  
								        	  //获取当前是第几页  
								        	  var pageNumber=$('#DataGrid001_table').bootstrapTable('getOptions').pageNumber;
								        	  //返回序号，注意index是从0开始的，所以要加上1
								        	  return pageSize * (pageNumber - 1) + index + 1;
								          }				 
									    },            
								        {title:"编码",field:"id",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
								        {title:"字段类型编码",field:"type",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
								        {title:"条件类型",field:"formulaType",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},     //0.普通  1.高级
								        {title:"计算公式编码",field:"formulaVal",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
								        {title:"名称",field:"name",sortable:true,clickToSelect:true,editorType:'Text',type:'text',valign:"middle"},
								        {title:"字段类型",field:"typeName",sortable:true,clickToSelect:true,editorType:'Text',type:'text',valign:"middle"},
								        {title:"计算公式",field:"formula",sortable:true,clickToSelect:true,editorType:'Text',type:'text',valign:"middle",
								         formatter: function (value, row, index){
								        	var suffixId = row.id.substr(row.id.indexOf('.') + 1);
										    var strHtml = "<div id=\"formula_"+suffixId+"_div\" class=\"input-group\" style=\"height:100%;width:100%;\">"
										    strHtml += "<input id=\"formula_"+suffixId+"\" name=\"formula_"+suffixId+"\" type=\"text\" value=\""+value+"\" class=\"form-control\" style=\"height:100%;width:100%;\" readOnly=\"true\"/>";
										    strHtml += "<span class=\"input-group-addon addon-udSelect udSelect\" onclick=\"openFormula('"+row.id+"','"+index+"')\">";
										    strHtml += "<i class=\"fa fa-search\"></i>";
										    strHtml += "</span>";
										    strHtml += "</div>";
										    return strHtml;
										 }
								        }  
								    ],
								    singleSelect:true,  //单选
								});
						     });
						
							</script>
						</td>
					</tr>
					<tr>
							<td class="" colspan="2" style="height:20px;width:100%;">
							</td>
					</tr>		
		   	</table>
		  </div>
		  <div class="cmdLayout">
				<input type="button" class="x-btn ok-btn" name="保存" value="保存" id="save" >
				<input type="button" class="x-btn ok-btn" name="保存并关闭" value="保存并关闭" id="saveAndClose" >
				<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="cancel" >
				<script type="text/javascript">
					//保存
			        $("#save").on("click",function(){
			        	 Matrix.showMask2();
			        	 var data = Matrix.getGridData('DataGrid001');   //所有数据
				      	 if(data!=null&&data!=""){
				      	 	var synJson = {'data':JSON.stringify(data)};					
							if(synJson!=null){
								var url = "<%=request.getContextPath()%>/formula/formula_saveH5AllList.action";
								Matrix.sendRequest(url,synJson,function(data){
									if(data.data){
										var json = JSON.parse(data.data);
										if(json.result){
											Matrix.say('保存成功！');		
											Matrix.hideMask2();
										}												
									}
									
								});
							}
				      	 }
			        });
			      //保存并关闭
			        $("#saveAndClose").on("click",function(){
			        	Matrix.showMask2();
			        	 var data = Matrix.getGridData('DataGrid001');   //所有数据
				      	 if(data!=null&&data!=""){
				      	 	var synJson = {'data':JSON.stringify(data)};					
							if(synJson!=null){
								var url = "<%=request.getContextPath()%>/formula/formula_saveH5AllList.action";
								Matrix.sendRequest(url,synJson,function(data){
									Matrix.hideMask2();
									if(data.data){
										var json = JSON.parse(data.data);
										if(json.result){					
											Matrix.closeWindow();								
										}												
									}
								});
							}
				      	 }
			        });
					//关闭
			        $("#cancel").on("click",function(){
			        	Matrix.closeWindow();
			        })
				</script>
			</div>			
		</form>
		</div>
	</body>
</html>
