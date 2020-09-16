/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	config.width = '100%'; //宽度
    config.height = '100%'; //高度    
    config.uiColor = '#e1e2e1';
	config.toolbar='full';
	config.font_names='宋体/宋体;黑体/黑体;仿宋/仿宋_GB2312;楷体/楷体_GB2312;隶书/隶书;幼圆/幼圆;微软雅黑/微软雅黑;'+ config.font_names;
	config.enterMode = CKEDITOR.ENTER_BR;
	config.shiftEnterMode = CKEDITOR.ENTER_P;
	config.toolbar_full=
	[
        	['Font','FontSize'],
            ['Bold', 'Italic', 'Underline'],
            ['JustifyLeft','JustifyCenter','JustifyRight'],
            ['TextColor','BGColor'],  
            ['NumberedList','BulletedList','-','Outdent','Indent'],       	
			['Image','Flash','Table','HorizontalRule','ImageButton','Link','Unlink'],
			['Undo','Redo']
	];

};

   


