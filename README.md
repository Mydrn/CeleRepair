# CeleRepair
CeleRepair开发

#服务器地址配置以及获取
配置 	js/app.js
获取		var serviceinfo = JSON.parse(localStorage.getItem('$serviceinfo'));
		var url = serviceinfo.app_ip + ":" + serviceinfo.app_port + serviceinfo.path + "方法名";

#token获取方法
配置 	js/app.js
获取 	app.getState().token

#跳转的页面需要读取数据的规范
//A页面中打开B页面，设置show的autoShow为false，则B页面在其loaded事件发生后，不会自动显示；
mui.openWindow({
    url: 'B.html', 
    show:{
      autoShow:false
    }
  });

//B页面onload从服务器获取列表数据；
plus.nativeUI.showWaiting();

plus.nativeUI.closeWaiting();


window.onload = function(){
  //从服务器获取数据
  //业务数据获取完毕，并已插入当前页面DOM；
  //注意：若为ajax请求，则需将如下代码放在处理完ajax响应数据之后；
  mui.plusReady(function(){
    //关闭等待框
    plus.nativeUI.closeWaiting();
    //显示当前页面
    mui.currentWebview.show();
  });
}

#预加载
mui.ready(function(){
console.log(1); 
}); 
mui.plusReady(function(){ 
console.log(2);
})

#页面传值
//A
mui.openWindow({url:'address-new.html',id:'address-new',
					    extras:{itemId:id}
});	
//B
var self = plus.webview.currentWebview();
var itemId = self.itemId;

var href = location.href;
var detailID = href.split("?")[1];


#客服电话
var contactUs = localStorage.getItem('$contactUs');