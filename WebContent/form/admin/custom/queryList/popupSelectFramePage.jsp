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
	<title>底表弹出选择页面</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<script type="text/javascript">
	//上下拖拉横线
	window.onload = function() {
		 debugger;
		 //点击输入框或选择框 弹出选择数据带入底表数据时关闭遮罩层
		 if(parent.Matrix){
			 parent.Matrix.hideMask2();
		 }
		 var isShowDetails = document.getElementById("isShowDetails").value;  //是否显示详细信息
		 if(isShowDetails == 'true'){  //显示时
			 document.getElementById("line").style.display = '';
			 document.getElementById("bottom").style.display = '';
			 document.getElementById("top").style.height = '60%';
			 
			 var oBox = document.getElementById("box");
			 var oTop = document.getElementById("top");
			 var oBottom = document.getElementById("bottom");
			 var oLine = document.getElementById("line");
			 var mask = document.getElementById("mask");
			 oLine.onmousedown = function(e) {
				mask.style.display = '';
				var disY = (e || event).clientY;
				oLine.top = oLine.offsetTop;
				document.onmousemove = function(e) {	
					var iT = oLine.top + ((e || event).clientY - disY);
					var maxT = oBox.clientHeight - oLine.offsetHeight;
					oLine.style.margin = 0;
					iT < 0 && (iT = 0);
					iT > maxT && (iT = maxT);
					oLine.style.top = oTop.style.height = iT + "px";
					oBottom.style.height = oBox.clientHeight - iT + "px";
					return false
				};	
				document.onmouseup = function() {
					mask.style.display = 'none';
					document.onmousemove = null;
					document.onmouseup = null;	
					oLine.releaseCapture && oLine.releaseCapture()
				};
				oLine.setCapture && oLine.setCapture();
				return false
			};
		 }
	};
	
	function confirmSelect(){
		debugger;
		var data = {};
		var item;
		var datagrid;
		
		if(main_iframe1.contentWindow){
		    datagrid = main_iframe1.contentWindow.MDataGrid001;
		}else{
		    datagrid = main_iframe1.MDataGrid001;
		}
		
		if(datagrid){
			item = datagrid.getSelection();
		}else{//有标签多视图的情况
		    if(main_iframe1.contentWindow){
			    item = main_iframe1.contentWindow.frames[0].contentWindow.MDataGrid001.getSelection();
		    }else{
			    item = main_iframe1.frames[0].MDataGrid001.getSelection();
		    }
		}
		
		if(item!=null && item.length==1){
			//构造主对象数据
			data.mainData = item[0];
			var entity = Matrix.getFormItemValue("entity");
			data.entityId = entity;
		}else{
			Matrix.warn("请选择一条主对象数据!");
			return false;
		}
		
		//构造关联列表数据
		var editListIds = Matrix.getFormItemValue('editListIds');//获得重复表名集合
		if(editListIds!=null && editListIds.length>0){
			if(editListIds.endsWith(";")){
				editListIds = editListIds.substr(0,editListIds.lastIndexOf(";"));
			}
			var subData = [];
			var idsArray = editListIds.split(";");
			if(idsArray!=null && idsArray.length>0){
				for(var i = 0;i<idsArray.length;i++){
					var str = idsArray[i];// id=1,3,5……,
					if(str!=null && str.length>0){
						str = str.substr(0,str.lastIndexOf(","));
						var strArr = str.split("=");
						var da = "{'entityId':'"+strArr[0]+"','arr':'"+strArr[1]+"'}";
						subData.push(isc.JSON.decode(da));
					//	subData.push(da);
					}
				}
			}
			data.subData = subData;
		}
		Matrix.closeWindow(data);
	}
	</script>
</head>
<body>
  <input type="hidden" name="formId" id="formId" value="${formId }" />
  <input type="hidden" name="mIsQueryMode" id="mIsQueryMode" value="${mIsQueryMode }" />
  <input type="hidden" name="isRenderCheckBox" id="isRenderCheckBox" value="${isRenderCheckBox }" />
  <input type="hidden" name="isShowDetails" id="isShowDetails" value="${isShowDetails }" />
  <input type="hidden" name="entity" id="entity" value="${entity }"/>
  <input type="hidden" name="editListIds" id="editListIds" />
  <input type="hidden" name="mHtml5Flag" id="mHtml5Flag" value="${param.mHtml5Flag }" />
  
  <div id="mask" style="width: 100%; height: 100%; position: absolute;top: 1;left: 1;z-index: 9999999999999;display: none;"> </div>
  <div id="box" style="height:calc(100% - 54px);">
  	 <div id="top" style="height: 100%;width:100%;">
  		<iframe id="main_iframe1" src="<%=request.getContextPath()%>/matrix.rform?formId=${param.formId }&mQuerySetConditions=${mQuerySetConditions}&mIsQueryMode=${mIsQueryMode }&isRenderCheckBox=${isRenderCheckBox }&isShowDetails=${isShowDetails }&mHtml5Flag=true" style="width:100%;height:100%;" frameborder="0"></iframe>
  	 </div>
  	 <div id="line" style="height: 1%;width: 100%;overflow: hidden;background: #ebebeb;cursor: ns-resize;display: none;"></div>
   	 <div id="bottom" style="height: 39%;width:100%;position:relative;display: none;">
   	 	  <iframe id="detail_iframe" style="width:100%;height:100%;" frameborder="0" src=""></iframe>
   	 </div>
   </div>
   <div id="buttom" class="cmdLayout">	
  	 	<input type="button" class="x-btn ok-btn" name="确认" value="确认" id="save" >
		<input type="button" class="x-btn cancel-btn" name="关闭" value="关闭" id="cancel" >
		<script type="text/javascript">
			//保存
	        $("#save").on("click",function(){
	        	var mask = document.getElementById("mask");
	        	mask.style.display = '';
				var x = eval("confirmSelect();");
				if(x!=null && x==false){
					Matrix.hideMask();
					mask.style.display = 'none';
					return false;
				}
				mask.style.display = 'none';
	        });
	       
	      	//关闭
	        $("#cancel").on("click",function(){
	        	Matrix.closeWindow();
	        })
		</script>	
   </div>
</body>
</html>