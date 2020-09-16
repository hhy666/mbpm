// 
//  common.js
//  skywalk-er.com
//  
//  Created by silva on 2015-02-12.
//  Copyright 2015 silva. All rights reserved.
// 
// var URL = 'http://wx.localhost.com';
var URL = 'http://'+window.location.host;

var ua = navigator.userAgent.toLowerCase();
var sys = ua.match(/html5plus/);

if (sys != 'html5plus') {
	mui.openWindow = function openWindow(param,target,options) {
		if(param.target == '_blank'){
			window.open(param.url);
		}else{
			window.location.href = param.url;
		}
	}
}

mui.ready(function() {
	// å¤±å»ç¦ç¹è¡¥æ
	mui('.mui-inner-wrap').on('tap','input,textarea',function(){
		this.focus();
	});

	mui('#pullrefresh').scroll();
	mui('#slider').slider({
		interval: 3000
	});
	//ä¾§æ»å®¹å¨ç¶èç¹
	var offCanvasWrapper = mui('#offCanvasWrapper');
	//ä¸»çé¢å®¹å¨
	var offCanvasInner = offCanvasWrapper[0].querySelector('.mui-inner-wrap');
	//èåå®¹å¨
	var offCanvasSide = document.getElementById("offCanvasSide");
	// var mask = mui.createMask();//callbackä¸ºç¨æ·ç¹å»èçæ¶èªå¨æ§è¡çåè°ï¼
	// mask.show();//æ¾ç¤ºé®ç½©
	// mask.close();//å³é­é®ç½©
	if(document.getElementById('offCanvasShow')){
		document.getElementById('offCanvasShow').addEventListener('tap', function() {
			offCanvasWrapper.offCanvas('show');
			//Zepto('.mui-backdrop').show();
		});
	}
	

/*	Zepto('.mui-backdrop').on('tap',function(){
		//Zepto('.mui-backdrop').hide();
		offCanvasWrapper.offCanvas('close');
	})
*/
	mui('.mui-table-view,.user-info,.tap-a').on('tap', 'a', function(e) {
		window.location.href=this.getAttribute('href');
	/*	mui.openWindow({
			url: this.getAttribute('href'),
			id: 'info'
		});
		*/
	});
	
	//mui('.mui-bar').on('tap','a',function(e){
		//alert("2222"+this.getAttribute('href'));
		//window.location.href=this.getAttribute('href');
	/*
		mui.openWindow({
			url: this.getAttribute('href'),
			id: 'info'
		});
	*/	
	//})
	
	
	/*å¼¹åºè®¢å*/
	mui('.mui-content-padded').on('tap','#post-my-order',function(){
		mui('.mui-popover').popover('toggle');
	});
	mui('.mui-content-padded').on('tap','#order',function(){
		mui.openWindow({
			url: this.getAttribute('data-href'),
			id: 'order'
		});
	});
	/*å³é­å¼¹åºå±*/
	mui('#popover').on('tap','.close-popover',function(){
		mui('.mui-popover').popover('toggle');
	});
	

	mui('a').on('tap','.reply',function(){
		mui('.reply-content')[0].style.display = 'block';
		document.getElementById('content').focus();
	})

	// mui('p').on('tap','.reply',tap_reply);
	// var tap_reply = function(){
	// 	mui('.reply-content')[0].style.display = 'block';
	// 	document.getElementById('content').focus();

	// 	var _num_flow = this.getAttribute('data-value');
	// 	if(_num_flow > 0){
	// 		Zepto('#reply_id').val(_num_flow);
	// 		Zepto('.reply-content-tit').html('åå¤'+_num_flow+'æ¥¼');
	// 	}else{
	// 		Zepto('.reply-content-tit').html('åå¤');

	// 	}
	// };

	mui('p').on('tap','.reply-close',function(){
		mui('.reply-content')[0].style.display = 'none';
		Zepto('.reply-content-tit').html('åå¤');
		Zepto('#content').val('')
	})
	mui('p').on('tap','.reply-submit',function(){
		var _uid = Zepto('#uid').val(),
			_community_id = Zepto('#community_id').val(),
			_cid = Zepto('#cid').val(),
			_reply_id = Zepto('#reply_id').val(),
			_unsign = Zepto('#unsign').attr("checked"); //Zepto('#unsign').val(),
			_content = Zepto('#content').val(),
			_username = Zepto('#username').val();

		if(_content == undefined || _content == ''){
			alert('è¯´ç¹ä»ä¹åæäº¤å§^-^');
			return false;
		}
		mui.ajax({
			type:'POST',
			url:URL+'/community/post_reply',
			data:'user_id='+_uid+'&username='+_username+'&cid='+_cid+'&content='+_content+'&community_id='+_community_id+'&reply_id='+_reply_id+'&unsign='+_unsign,
			success:function(json){
				// alert(json.data);
				// mui('.mui-popover').popover('toggle');
				if(json.code == '200'){
					alert(json.data);
					mui('.mui-popover').popover('toggle');
				}else{
					alert(json.data);
					mui('.mui-popover').popover('toggle');
				}
			},
			error:function(json){
				alert(json.data);
			}
		});

		mui('.reply-content')[0].style.display = 'none';
		Zepto('.reply-content-tit').html('åå¤');
	});
	mui('.font-face').on('tap','span',function(){
		Zepto('#content').val(Zepto('#content').val()+Zepto(this).html());
		console.log(Zepto('#content').val());
	});

	mui('.mui-content-padded').on('tap','h5.show-content',function(){
		var cdt = Zepto('.content-detail');
		cdt.find('img').attr({
			width: '',
			height: ''
		}).css({
			width: '',
			height: ''
		});;
		if(cdt.height() != 200){
			Zepto('.content-detail').css({
				height: '200px'
			});
			Zepto('h5.show-content').html('å±å¼çº¿è·¯è¯¦ç»ä»ç»');
		}else{
			Zepto('.content-detail').css({
				height: 'auto'
			});
			Zepto('h5.show-content').html('æ¶èµ·çº¿è·¯è¯¦ç»ä»ç»');
		}
		
	});

	
	/* éåºç»å½ */
	mui('.mui-content-padded').on('tap','.btn-logout',function(){
		window.location.href="/member/public/logout";
	});

	

});