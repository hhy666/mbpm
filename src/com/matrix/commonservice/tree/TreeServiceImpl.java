package com.matrix.commonservice.tree;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.el.ValueExpression;
import javax.matrix.faces.context.MFacesContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.mapping.Column;
import org.hibernate.mapping.PersistentClass;

import com.matrix.commonservice.data.DataService;
import com.matrix.dasservice.DASAgent;
import com.matrix.form.api.MFormContext;
import com.matrix.form.engine.foundation.FormStore;
import com.matrix.form.model.FormContainer;
import com.matrix.form.model.component.composite.DynamicTreeNode;
import com.matrix.form.model.component.composite.MatrixClientTreeNode;
import com.matrix.form.model.component.composite.MatrixTreeNode;
import com.matrix.form.model.component.composite.StaticTreeNode;
import com.matrix.form.model.component.composite.Tree;
import com.matrix.form.model.component.composite.TreeNode;
import com.matrix.form.model.config.FormContentHelper;
import com.matrix.form.render.util.LogConstants;
import com.matrix.form.render.util.TreeUtil;
import com.matrix.form.util.DataObjectHelper;
import com.matrix.web.engine.das.transaction.annotation.Transaction;
import commonj.sdo.DataObject;
import commonj.sdo.Property;

public class TreeServiceImpl implements TreeService {
	
    private Log log=LogFactory.getLog(LogConstants.LOG_UICOMPONENT_COMPOSITE_TREE);
	
    private DataService getDASService(){
    	return MFormContext.getService("DataService");
    }
	public List loadChildren(MatrixClientTreeNode mtreenode,Tree tree, DynamicTreeNode dynamicTreeNode) {
    	
		if(log.isDebugEnabled())
			log.debug("load children of tree service been called");
    	
		List result = new ArrayList();
		// 默认的加载树节点的方式
		MatrixTreeNode treenode=(MatrixTreeNode)mtreenode;
		if (!dynamicTreeNode.isLoadAllChildren()) {
			if (MatrixClientTreeNode.RootNodeId.equals(treenode.getEntityId())) {
				if (dynamicTreeNode.getRootEntityId() != null) {
					if(log.isDebugEnabled())
						log.debug("the entity type of parent node is:"+dynamicTreeNode.getEntityType()+", entity id is:" + dynamicTreeNode.getRootEntityId());

					DataService sdbs = getDASService();
			    	String entityName =dynamicTreeNode.getEntityType();
					boolean isQueryObj = this.isQueryObject(entityName);
					if(isQueryObj){
						ValueExpression _ve = dynamicTreeNode.getValueExpression("entityId");
						String pkPro = _ve.getExpressionString();
						if(pkPro != null && pkPro.startsWith("#{entity.") && pkPro.endsWith("}"));{
							pkPro = pkPro.trim();
							pkPro = pkPro.substring(9, pkPro.length()-1);
							FormStore formStore = MFormContext.getService("matrixFormStore");
							String colName = getColumnName(entityName, pkPro);
							
							DataObject entity = DataObjectHelper.getDataObjectOfEntity(entityName);
							Property pro = entity.getType().getProperty(pkPro);
							String type = pro.getType().getInstanceClass().getSimpleName();

							List list = null;
							if("String".equals(type))
								list = sdbs.queryList(" from "+entityName +" where "+ colName +"='"+dynamicTreeNode.getRootEntityId()+"'", null);
							else
								list = sdbs.queryList(" from "+entityName +" where "+ colName +"="+dynamicTreeNode.getRootEntityId(), null);
							if (list != null && list.size()>0) {
								Object rootObj = list.get(0);
								result.add(rootObj);
							}
						}	
					}else{
						// 根节点
						Object rootObj = sdbs.load(dynamicTreeNode.getEntityType(),dynamicTreeNode.getRootEntityId());
						if (rootObj != null) {
							result.add(rootObj);
						}
					}
				}
				
			} else {
				TreeNode componentNode;
				String key = treenode.getId();
				if (treenode.getComponentId() != null) {
					key = treenode.getComponentId();
				}

				componentNode = tree.getTreeNodeById(key);
				if (componentNode instanceof DynamicTreeNode) {
					if (dynamicTreeNode.isProperty()) {
//						// 读取父节点的属性
//						DynamicTreeNode dynamicTreeNode1 = (DynamicTreeNode) componentNode;
//						if(log.isDebugEnabled())
//							log.debug("the entity type of parent node is:"+dynamicTreeNode1.getEntityType()+", entity id is:" + dynamicTreeNode1.getRootEntityId());
//
//						DataService sdbs = getDASService();
//						Object parentObject = null;
//
//				    	String entityName =dynamicTreeNode.getEntityType();
//						boolean isQueryObj = this.isQueryObject(entityName);
//						if(isQueryObj){
//							ValueExpression _ve = dynamicTreeNode.getValueExpression("entityId");
//							String pkPro = _ve.getExpressionString();
//							if(pkPro != null && pkPro.startsWith("#{entity.") && pkPro.endsWith("}"));{
//								pkPro = pkPro.trim();
//								pkPro = pkPro.substring(9, pkPro.length()-1);
//								
//								String colName = getColumnName(entityName, pkPro);
//								
//								DataObject entity = DataObjectHelper.getDataObjectOfEntity(entityName);
//								Property pro = entity.getType().getProperty(pkPro);
//								String type = pro.getType().getInstanceClass().getSimpleName();
//
//								List list = null;
//								if("String".equals(type))
//									list = sdbs.queryList(" from "+entityName +" where "+ colName +"='"+treenode.getEntityId()+"'", null);
//								else
//									list = sdbs.queryList(" from "+entityName +" where "+ colName +"="+treenode.getEntityId(), null);
//
//								if (list != null && list.size()>0) {
//									Object rootObj = list.get(0);
//									result.add(rootObj);
//								}
//							}	
//						}else{
//							parentObject = sdbs.load(dynamicTreeNode.getEntityType(), treenode.getEntityId());
//						}	
//						if(parentObject!=null){
////							result = getChildren(dynamicTreeNode1, treenode.getEntityId());
//							result = getChildren(dynamicTreeNode, treenode.getEntityId());
//				            result.iterator();
//						}

						result = getChildren(dynamicTreeNode, treenode.getEntityId());
						
					}
					
					
				}

			}
		}
		if(log.isDebugEnabled())
			log.debug("the count of loaded children is:" + result.size());

		return result;
	}
	
	private boolean isQueryObject(String entity){
		boolean isQueryObj = false;
		if(entity == null || entity.trim().length()==0)
			return false;
		
 		String formType = MFormContext.getFormProperties().getType();
 		boolean isDepPhase = MFormContext.getPhaseId()==2;//判断是否为设计开发阶段

		if("platform".equalsIgnoreCase(formType) && isDepPhase){ //如果是嵌入在平台中
			Configuration conf = DASAgent.getDASService().getConfiguration(entity);
			String tableName = conf.getClassMapping(entity).getTable().getName();
			if(tableName.startsWith("_mb_")){  //mybatis
				isQueryObj = true;
			}
		}else{
			isQueryObj = FormContainer.getInstance().getQueryEntityPros().containsKey(entity);
		}
		
		return isQueryObj;
	}
	
	private String getColumnName( String entity, String propertyName) {  
		
		String formType = MFormContext.getFormProperties().getType();
 		boolean isDepPhase = MFormContext.getPhaseId()==2;//判断是否为设计开发阶段

		if("platform".equalsIgnoreCase(formType) && isDepPhase){ //如果是嵌入在平台中
			Configuration conf = DASAgent.getDASService().getConfiguration(entity);
			PersistentClass persistentClass = conf.getClassMapping(entity);  
			org.hibernate.mapping.Property property = persistentClass.getProperty(propertyName);  
			Iterator<?> it = property.getColumnIterator();  
			if (it.hasNext()) {  
				Column column = (Column) it.next();  
				return column.getName();  
			 }  
			 return null;  
		}else{
			FormStore formStore = MFormContext.getService("matrixFormStore");
			String colName = formStore.getColNameByProName(entity, propertyName);
			return colName;
		}
		
	 }  

	private List getChildren(DynamicTreeNode dynamicTreeNode1, String parentId){
		DataService sdbs = getDASService();
		List result = null;
		String relationId = dynamicTreeNode1.getRelationProperty();
		if(relationId == null || relationId.trim().length()==0)
			return new ArrayList();
		
//    	String entityName = dynamicTreeNode1.getEntityType();
//		boolean isQueryObj = this.isQueryObject(entityName);
//		if(isQueryObj){
//			FormStore formStore = MFormContext.getService("matrixFormStore");
//			relationId = getColumnName(entityName, relationId);
//		}
		
		String seqPro = dynamicTreeNode1.getSequenceProperty();
		StringBuffer hql = new StringBuffer();
		if(dynamicTreeNode1.getRelaProIsStr()){
			hql.append("from ").append(dynamicTreeNode1.getEntityType()).append(" as o where o.").append(relationId).append(" ='").append(parentId).append("'");
		}else{
			hql.append("from ").append(dynamicTreeNode1.getEntityType()).append(" as o where o.").append(relationId).append(" =").append(parentId);
		}
		
		//存在条件时追加条件
		String condition = dynamicTreeNode1.getCondition();
		if(condition != null && condition.trim().length()>0){
			condition = FormContentHelper.convertExpression(condition);
			hql.append(" and ( "+condition+" ) ");
		}
		
		if(seqPro != null && seqPro.trim().length()>0){
			hql.append(" order by o.").append(seqPro).append(" ASC");
		}
		
		result = sdbs.queryList(hql.toString(), null);

		return result;
	}
	
	private void deleteChildren(DynamicTreeNode dynamicTreeNode1, String parentId, DataService sdbs){
		String relationId = dynamicTreeNode1.getRelationProperty();
		StringBuffer hql = new StringBuffer();
		if(dynamicTreeNode1.getRelaProIsStr()){
			hql.append("delete from ").append(dynamicTreeNode1.getEntityType()).append(" where ").append(relationId).append(" ='").append(parentId).append("'");
		}else{
			hql.append("delete from ").append(dynamicTreeNode1.getEntityType()).append(" where ").append(relationId).append(" =").append(parentId);
		}
		
		sdbs.executeDelete(hql.toString(), null);
	}
	
	private void recurDelete(String uuid, DynamicTreeNode dynamicNode, DataService sdbs){
		String childUuid = null;
		List childList = null;
		int len;
		int type;
		childList = getChildren(dynamicNode, uuid);
		if(childList!=null&&(len= childList.size())>0){
			for(int i=0;i<len;i++){
				DataObject child = (DataObject)childList.get(i);
				childUuid =  child.getString("uuid");
				type = child.getInt("type");
				this.recurDelete(childUuid, dynamicNode, sdbs);
				
			}
		}
		//删除子项
		deleteChildren(dynamicNode, uuid, sdbs);
	
		
	}
	
    @Transaction
	public boolean removeTreeNode(Tree tree) {
		if(log.isDebugEnabled())
			log.debug("remove tree node of tree service been called");
		// 默认删除节点的方式
		MatrixTreeNode treenode = tree.getCurrentTreeNode();
		TreeNode componentNode;
		String key = treenode.getId();
		if (treenode.getComponentId() != null) {
			key = treenode.getComponentId();
		}
		// 根节点需要另外处理
		componentNode = tree.getTreeNodeById(key);

		if (componentNode instanceof DynamicTreeNode) {
			DynamicTreeNode node1 = (DynamicTreeNode) componentNode;
			MatrixTreeNode parentNode = tree.getParentTreeNode();
			DataService sdbs = getDASService();
			if (parentNode != null) {
				//删除子节点
				recurDelete(treenode.getEntityId(), node1, sdbs);
				
				//删除当前节点
				String key1 = parentNode.getId();
				if (parentNode.getComponentId() != null) {
					key1 = parentNode.getComponentId();
				}
				TreeNode parentComponentNode = tree.getTreeNodeById(key1);
				if (parentComponentNode instanceof DynamicTreeNode) {
					// 如果是当前节点是父节点的属性时,考虑到排序,从父节点的属性中删除
					DynamicTreeNode parentDynamicComponentNode = (DynamicTreeNode) parentComponentNode;
					if (!node1.isLoadAllChildren() && node1.isProperty()) {
						// 作为父节点属性时,与前一节点调换list里的顺序
						DataObject parentObj = (DataObject) sdbs.load(parentNode.getEntityId(), parentDynamicComponentNode.getEntityType());
						List list1 = parentObj.getList(node1.getChildrenProperty());
						DataObject currentObj = null;
						int index = 0;
						for (Iterator it = list1.iterator(); it.hasNext();) {
							Object o = it.next();
							if (o != null) {
								DataObject dataobj = (DataObject) o;
								MFacesContext context = MFacesContext.getCurrentInstance();
								context.getExternalContext().getRequestMap().put("entity", dataobj);
								if (treenode.getEntityId().equals(TreeUtil.getValueStringByExpression("entityId", node1))) {
									currentObj = dataobj;
									break;
								}
							}
							index++;
						}
						if (index < list1.size()) {
							sdbs.delete(currentObj);
							return true;
						}
					}
				}
				
				///////////////////
			}
			
		}
		return false;
	}
    @Transaction
	public boolean dropTreeNode(Tree tree) {
		if(log.isDebugEnabled())
			log.debug("drop tree node of tree service been called");
    	
		// 拖动的节点
		MatrixTreeNode currentNode = tree.getCurrentTreeNode();
		// 原父节点
		MatrixTreeNode soureParentNode = tree.getParentTreeNode();
		// 目标父节点
		MatrixTreeNode destParentNode = tree.getDestParentTreeNode();
		// 得到目标父节点的组件
		TreeNode destParentComponentNode = tree.getTreeNodeById(destParentNode
				.getComponentId() == null ? destParentNode.getId()
				: destParentNode.getComponentId());
		if (soureParentNode.getComponentId().equals(
				destParentNode.getComponentId())
				&& !soureParentNode.getEntityId().equals(
						destParentNode.getEntityId())) {
			// 判断是否可以拖拽,如果目标父id和原来的父id一致说明说可以拖动
			if (destParentComponentNode instanceof DynamicTreeNode) {
				// 默认处理方式
				// 得到拖动节点的组件模型节点
				TreeNode componentNode = tree.getTreeNodeById(currentNode
						.getComponentId() == null ? currentNode.getId()
						: currentNode.getComponentId());
				if (componentNode instanceof DynamicTreeNode) {
					if(log.isDebugEnabled())
						log.debug("the entity id is:" + ((DynamicTreeNode)componentNode).getEntityId());
					DynamicTreeNode componentNode1 = (DynamicTreeNode) componentNode;
					if (componentNode1.isProperty()) {
						// 只有加载子节点的方式是属性时,才能处理拖拽
						// 删除原来父节点下的此节点,同时如果有排序子段,将后面的节点序号减一
						// 在新的父节点添加子节点
						DynamicTreeNode destParentComponentNode1 = (DynamicTreeNode) destParentComponentNode;
						DataService sdbs = getDASService();
						DataObject sourceParentObject = (DataObject) sdbs.load(	soureParentNode.getEntityId(), destParentComponentNode1.getEntityType());
						DataObject destParentObject = (DataObject) sdbs.load(
								destParentNode.getEntityId(),
								destParentComponentNode1.getEntityType());
						List sourcechildren = sourceParentObject
								.getList(componentNode1.getChildrenProperty());
						List destchildren = destParentObject
								.getList(componentNode1.getChildrenProperty());
						// 删除原来的子节点
						
						DataObject currentObject =null;
						 for(Iterator
								 it=sourcechildren.iterator();it.hasNext();){
							    
								 DataObject obj=(DataObject)it.next();
								 if(obj!=null){
									 MFacesContext context =
										 MFacesContext.getCurrentInstance();
									 context.getExternalContext().getRequestMap().put("entity",obj);
//									 if(currentNode.getEntityId().equals(TreeUtil.getValueStringByExpression("entityId",componentNode1))){
									 if(currentNode.getEntityId().equals(currentNode.getEntityId())){
										 currentObject=obj;
										 break;
									 } 
								 }					 
						}
						 
						if (currentObject != null) {
							
							// 移除原父节点中当前节点
							sourcechildren.iterator();
							sourcechildren.remove(currentObject);
							sourceParentObject.setList(componentNode1.getChildrenProperty(),
									sourcechildren);
							sdbs.saveOrUpdate(sourceParentObject);

							// 在新的父节点后添加当前节点
							destchildren.iterator();
							destchildren.add(currentObject);
							destParentObject.setList(componentNode1.getChildrenProperty(),
									destchildren);
							sdbs.saveOrUpdate(destParentObject);
							
						}
						return true;
					}
				}
			}
		}
		return false;
	}
    @Transaction
	public boolean moveUp(Tree tree) {
		if(log.isDebugEnabled())
			log.debug("move up tree node of tree service been called");

		// 上移节点
		MatrixTreeNode previousTreeNode = tree.getPreviousTreeNode();
		MatrixTreeNode treeNode = tree.getCurrentTreeNode();
		String key = treeNode.getId();
		if (treeNode.getComponentId() != null) {
			key = treeNode.getComponentId();
		}
		TreeNode componentNode = tree.getTreeNodeById(key);
		if (componentNode instanceof DynamicTreeNode) {
			if(log.isDebugEnabled())
				log.debug("the entity id is:" + ((DynamicTreeNode)componentNode).getEntityId());
			DynamicTreeNode node1 = (DynamicTreeNode) componentNode;
			if (previousTreeNode!=null && previousTreeNode.getComponentId().equals(
					treeNode.getComponentId())) {
				MatrixTreeNode parentNode = tree.getParentTreeNode();
				DataService sdbs = getDASService();
				if (parentNode != null) {
					String key1 = parentNode.getId();

					if (parentNode.getComponentId() != null) {
						key1 = parentNode.getComponentId();
					}
					TreeNode parentComponentNode = tree.getTreeNodeById(key1);

					int index = 0;
					if (parentComponentNode instanceof DynamicTreeNode) {
						DynamicTreeNode parentDynamicComponentNode = (DynamicTreeNode) parentComponentNode;
						if (!node1.isLoadAllChildren() && node1.isProperty()) {
							// 作为父节点属性时,与前一节点调换list里的顺序
							DataObject parentObj = (DataObject) sdbs.load(
									parentNode.getEntityId(),
									parentDynamicComponentNode.getEntityType());

							List list1 = getChildren(parentDynamicComponentNode, parentNode.getEntityId());
							
							DataObject preObj = null;
							DataObject currentObj = null;
							for (Iterator it = list1.iterator(); it.hasNext();) {
								Object o = it.next();
								if (o != null) {
									DataObject dataobj = (DataObject) o;
									MFacesContext context = MFacesContext.getCurrentInstance();
									context.getExternalContext().getRequestMap().put("entity",dataobj);
									if (treeNode.getEntityId().equals(TreeUtil.getValueStringByExpression("entityId",node1))) {
										currentObj = dataobj;
										break;
									}
									
									preObj = dataobj;
								}
								index++;
							}
							
							String seqProperty = node1.getSequenceProperty();
							if(currentObj != null && preObj != null 
									&& (seqProperty != null && seqProperty.trim().length()>0)){
								Object curValue = currentObj.get(seqProperty); 
								Object preValue = preObj.get(seqProperty);
								
								currentObj.set(seqProperty, preValue);
								preObj.set(seqProperty, curValue);
								
								sdbs.update(currentObj);
								sdbs.update(preValue);
							}
						}

					}

				}
				
			}
		}
		return false;
	}
    @Transaction
	public boolean moveDown(Tree tree) {
		if(log.isDebugEnabled())
			log.debug("remove down tree node of tree service been called");
    	
		// 下移节点
		MatrixTreeNode nextTreeNode = tree.getNextTreeNode();
		MatrixTreeNode treeNode = tree.getCurrentTreeNode();
		String key = treeNode.getId();
		if (treeNode.getComponentId() != null) {
			key = treeNode.getComponentId();
		}
		TreeNode componentNode = tree.getTreeNodeById(key);
		if (componentNode instanceof DynamicTreeNode) {
			if(log.isDebugEnabled())
				log.debug("the entity id is:" + ((DynamicTreeNode)componentNode).getEntityId());
			DynamicTreeNode node1 = (DynamicTreeNode) componentNode;
			if (nextTreeNode!=null && nextTreeNode.getComponentId().equals(treeNode.getComponentId())) {
				MatrixTreeNode parentNode = tree.getParentTreeNode();
				DataService sdbs = getDASService();
				if (parentNode != null) {

					String key1 = parentNode.getId();
					if (parentNode.getComponentId() != null) {
						key1 = parentNode.getComponentId();
					}
					TreeNode parentComponentNode = tree.getTreeNodeById(key1);
					if (parentComponentNode instanceof DynamicTreeNode) {
						DynamicTreeNode parentDynamicComponentNode = (DynamicTreeNode) parentComponentNode;
						if (!node1.isLoadAllChildren() && node1.isProperty()) {
							// 作为父节点属性时,与前一节点调换list里的顺序
							List list1 = getChildren(parentDynamicComponentNode, parentNode.getEntityId());

							DataObject currentObj = null;
							DataObject nextObj = null;
							int index = 0;
							for (Iterator it = list1.iterator(); it.hasNext();) {
								Object o = it.next();
								if (o != null) {
									DataObject dataobj = (DataObject) o;
									MFacesContext context = MFacesContext.getCurrentInstance();
									context.getExternalContext().getRequestMap().put("entity",dataobj);
									if (treeNode.getEntityId().equals(TreeUtil.getValueStringByExpression("entityId",node1))) {
										currentObj = dataobj;
										
										if(it.hasNext())
											nextObj = (DataObject)it.next();
										break;
									}
								}
								index++;
							}
							
							String seqProperty = node1.getSequenceProperty();
							if(currentObj != null && nextObj != null 
									&& (seqProperty != null && seqProperty.trim().length()>0)){
								Object curValue = currentObj.get(seqProperty); 
								Object nextValue = nextObj.get(seqProperty);
								
								currentObj.set(seqProperty, nextValue);
								nextObj.set(seqProperty, curValue);
								
								sdbs.update(currentObj);
								sdbs.update(nextObj);
							}
						}
					}

				}
				
			}
		}
		return false;
	}

}
