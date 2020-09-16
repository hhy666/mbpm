package com.matrix.commonservice.tree;

import java.util.List;

import com.matrix.form.model.component.composite.DynamicTreeNode;
import com.matrix.form.model.component.composite.MatrixClientTreeNode;
import com.matrix.form.model.component.composite.Tree;


public interface TreeService {
	public boolean dropTreeNode(Tree tree);
	public List loadChildren(MatrixClientTreeNode treenode,Tree tree, DynamicTreeNode dynamicTreeNode);
	public boolean moveDown(Tree tree);
	public boolean moveUp(Tree tree);
	public boolean removeTreeNode(Tree tree);
}
