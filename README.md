# CeleRepair
CeleRepair开发

#服务器地址获取
var serviceinfo = JSON.parse(localStorage.getItem('$serviceinfo'));
var url = serviceinfo.app_ip + ":" + serviceinfo.app_port + serviceinfo.path + "方法名";

#跳转的页面需要读取数据的规范
//A页面中打开B页面，设置show的autoShow为false，则B页面在其loaded事件发生后，不会自动显示；
mui.openWindow({
    url: 'B.html', 
    show:{
      autoShow:false
    }
  });

//B页面onload从服务器获取列表数据；
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