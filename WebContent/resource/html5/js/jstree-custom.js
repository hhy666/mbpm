function Matrix(){
	var tree;
	
}
Matrix.URL = "matrix.rform";


/**
 *刷新树节点
 */
Matrix.refreshTreeNode = function(node){
	if(node && Matrix.tree){
		if(node.reference){
			var inst = $.jstree.reference(node.reference),
        	obj = inst.get_node(node.reference);
			Matrix.tree.refresh_node(obj);
		
		}else{
			Matrix.tree.refresh_node(node);
		}
	}
}

//
Matrix.forceFreshTreeNode = function(treeId,nodeId){
	if(treeId){
		var curTree = jQuery.jstree.reference("#"+treeId);
		if(curTree && nodeId){
			var node = curTree.get_node(nodeId);
			if(node){
				curTree.refresh_node(node);
			}
		}
	}
}
//上移
Matrix.moveUpTreeNode = function(node,item,menu,colNum){
	if(node){
		Matrix.moveTreeNode(node,"moveup");
	}
}
//下移
Matrix.moveDownTreeNode = function(node,item,menu,colNum){
	if(node){
		Matrix.moveTreeNode(node,"movedown");
	}
}


Matrix.removeUpTreeNode = function(node,item,menu,colNum){
	
	if(node){
		var instance = $.jstree.reference(node.reference);//当前节点实例
		if(instance){
			var curNode = instance.get_node(node.reference);//当前节点
			if(!confirm("确认删除"+curNode.text+"?")){
				return;
			}
			if(Matrix.tree){
		    	var parentNode = Matrix.tree.get_node(curNode.parent);
		    	if(parentNode){
		    		var content = {};
    				content["treeComponentId"] = "Tree0";
					content["matrix_form_tid"] = $("#matrix_form_tid").val();
					content["REFRESH_COMPONENT_IDS"] = "Tree0,";
					content["mHtml5Flag"] = true;
					content["MATRIX_REFRESH_FORM_ID"]=$("#form0").val();
					content["form0"]=$("#form0").val();
					content["X-Requested-With"]="XMLHttpRequest";
					var currentNode = Matrix.jstreeNode2MatrixTreeNode(Matrix.tree,curNode);//当前节点
					var parentTreeNode = Matrix.jstreeNode2MatrixTreeNode(Matrix.tree,parentNode);//父节点
					var nodeData ="{currentNode:"+JSON.stringify(currentNode)+",parentNodeData:"+JSON.stringify(parentTreeNode)+"}";
					content["actionType"] = "remove";
					var url=Matrix.URL;
					content["data"] = nodeData;
					Matrix.sendRequest(url,content,function(result){
			    		if(result){
					    	var synJson =  eval('('+result+')');		
			    			if(synJson.result){
			    				Matrix.refreshTreeNode(parentNode);//刷新父节点
			    			}
			    		}
				    });
		    	}
		    }
		}
	}
}
/**
 *移动树节点
 */
Matrix.moveTreeNode = function(node,moveType){
	var instance = $.jstree.reference(node.reference);//当前节点实例
	if(instance){
		var curNode = instance.get_node(node.reference);//当前节点
	    if(Matrix.tree){
		    var parentNode = Matrix.tree.get_node(curNode.parent);
		    if(parentNode){
			    var children = parentNode.children;
			    if(children){
				    var curNodeIndex = children.indexOf(curNode.id);
				    var childrenSize = children.length;
				    var isPost = false; // 异步标识
    				var targetNode = null;
    				var moveFun = null;
    				//参数
    				var content = {};
    				content["treeComponentId"] = "Tree0";
					content["matrix_form_tid"] = $("#matrix_form_tid").val();
					content["REFRESH_COMPONENT_IDS"] = "Tree0,";
					content["mHtml5Flag"] = true;
					content["MATRIX_REFRESH_FORM_ID"]=$("#form0").val();
					content["form0"]=$("#form0").val();
					content["X-Requested-With"]="XMLHttpRequest";
					var currentNode = Matrix.jstreeNode2MatrixTreeNode(Matrix.tree,curNode);//当前节点
					var parentTreeNode = Matrix.jstreeNode2MatrixTreeNode(Matrix.tree,parentNode);//父节点
					var url=Matrix.URL;
					
    				if(moveType=='moveup'){//上移
    					content["actionType"] = "moveup";
				     	if(curNodeIndex>0){//不是第一条  可上移
				    		
				    		var preNode = Matrix.tree.get_node(children[curNodeIndex-1]);//上一条
							targetNode = Matrix.jstreeNode2MatrixTreeNode(Matrix.tree,preNode);//符合数据结构的上一条数据节点对象
							
							var nodeData ="{currentNode:"+JSON.stringify(currentNode)+",parentNodeData:"+JSON.stringify(parentTreeNode)+",previousNodeData:"+JSON.stringify(targetNode)+"}";
				    		content["data"] = nodeData;
				    	}else{
				    		alert("第一个节点不能上移");
				    		return;
				    	}
			    	}else if(moveType == 'movedown'){
			    		content["actionType"] = "movedown";
			    		if(curNodeIndex<children.length-1){//不是最后一条
			    			var nextNode = Matrix.tree.get_node(children[curNodeIndex+1]);//下一条
							targetNode = Matrix.jstreeNode2MatrixTreeNode(Matrix.tree,nextNode);//符合数据结构的下一条数据节点对象
							var nodeData ="{currentNode:"+JSON.stringify(currentNode)+",parentNodeData:"+JSON.stringify(parentTreeNode)+",nextNodeData:"+JSON.stringify(targetNode)+"}";
				    		content["data"] = nodeData;
			    		}else{
				    		alert("最后一个节点不能下移");
				    		return;
				    	}
			    	}
			    	Matrix.sendRequest(url,content,function(result){
			    		if(result){
					    	var synJson =  eval('('+result+')');		
			    			if(synJson.result){
			    				Matrix.refreshTreeNode(parentNode);//刷新父节点
			    			}
			    		}
				    });
			    }
		    }
	    }
	}
}

/**
 *根据tree和nodeId获得node对象
 */
Matrix.getComponentById2 = function(tree,nodeId){
	if(tree && nodeId){
		return tree.get_node(nodeId);
	}
	return null;
}

/**
 *  发送异步请求
 *  if you want to use this method,'jquery.min.js' must be included in form page
 *  a: url  default value is  Matrix.URL
 *  b: json data
 *  c: call back method
 *  d: send type   'post' or 'get' default value is 'post'
 */
/*Matrix.sendRequest = function(a,b,c,d){
	if(d==null || d==''){
		d = "post";
	}
	if(a==null || a==''){
		a = Matrix.URL;
	}
	//发送异步请求
	$.ajax({
        type: d,
        url: a,
        data: b,
        success: c
    });
}
*/

/**
 * jstree 节点数据 转换为 MatrixTree 节点的数据
 */
Matrix.jstreeNode2MatrixTreeNode = function(tree,node){
	var json = "";
	if(node){
		json +="{";
		json += Matrix.getTreeNodeJsonStr(node);
		if(node.children && node.children.length>0){
			json+=",\"children\":[";
				for(var i = 0;i<node.children.length;i++){
					var childStr = "{";
					var child = tree.get_node(node.children[i]);
					childStr += Matrix.getTreeNodeJsonStr(child);
					childStr +="}";
					if(i<node.children.length-1){
						childStr +=",";
					}
					json += childStr;
				}
			
			json+="]";
		}
		json +="}";
		var jsonObj = JSON.parse(json);
		return jsonObj;
	}
}


Matrix.getTreeNodeJsonStr = function(node){
	var json = "";
	if(node){
		json += "\"id\":\""+node.id+"\",";
		json +="\"entityId\":\""+node.original.entityId+"\",";
		json +="\"icon\":\""+node.icon+"\",";
		json +="\"isFolder\":\""+node.original.isFolder+"\",";
		json +="\"text\":\""+node.text+"\",";
		json +="\"menuId\":\""+node.original.menuId+"\",";
		json +="\"cascade\":\""+node.original.cascade+"\",";
		if(node.original.extr1!=null && node.original.extr1.length>0){
			json +="\"extr1\":\""+node.original.extr1+"\",";
		}
		if(node.original.extr2!=null && node.original.extr2.length>0){
			json +="\"extr2\":\""+node.original.extr2+"\",";
		}
		if(node.original.extr3!=null && node.original.extr3.length>0){
			json +="\"extr3\":\""+node.original.extr3+"\",";
		}
		if(typeof(node.original.loaded) === 'boolean'){
			json +="\"loaded\":"+node.original.loaded+",";
		}
		if(typeof(node.original.loadAll)=== 'boolean'){
			json +="\"loadAll\":"+node.original.loadAll+",";
		}
		if(node.original.onSelect!="null" && node.original.onSelect!="undefined"){
			json +="\"onSelect\":\""+node.original.onSelect+"\",";
		}
		
		json +="\"componentId\":\""+node.original.componentId+"\",";
		json +="\"parentId\":\""+node.parent+"\"";
	}
	return json;
}
