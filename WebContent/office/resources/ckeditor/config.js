/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	 config.font_names = '仿宋/FangSong;宋体/SimSun;黑体/SimHei;华文行楷/STXingkai;楷体/KaiTi;;'+  
     '微软雅黑/Microsoft YaHei;方正舒体/FZShuTi;方正姚体/FZYaoti;'+  
  
      config.font_names;  

	config.width = '100%'; //宽度
    config.height = '100%'; //高度    
    config.uiColor = '#e1e2e1';
	config.toolbar='full';
	config.tabSpaces = 8;//当用户键入TAB时，编辑器走过的空格数，(&nbsp;) 当值为0时，焦点将移出编辑框 plugins/tab/plugin.js
	config.enterMode = CKEDITOR.ENTER_DIV;
	config.shiftEnterMode = CKEDITOR.ENTER_P;
//	config.baseFloatZIndex = 20000;//（无用） 设置ckeditor背景z-index,但是与smartClient机制相冲突
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

   


