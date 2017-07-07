<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>${ title }</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" href="${ctx}/public/celerepair/css/mui.min.css">
		<link rel="stylesheet" type="text/css" href="${ctx}/public/celerepair/css/icons-extra.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/public/celerepair/css/css/mui.picker.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/public/celerepair/css/css/mui.poppicker.css" />
		<style>
			body,html{background-color:#efeff4}span.mui-icon{font-size:20px;color:#fff}.mui-off-canvas-left{color:#fff}.title{margin:35px 15px 10px}.title+.content{margin:10px 15px 35px;color:#bbb;text-indent:1em;font-size:14px;line-height:24px}#offCanvasSideScroll{padding-top:44px}.f-white{color:#fff!important}.f-14{font-size:14px!important}.f-orange{color:#ff5700!important}.f-cc{color:#ccc}.bg-orange{background-color:#ff5700!important}.mui-position-right{position:absolute;right:40px}.mui-bar{background-color:#ff5700}.mui-input-group .mui-input-row:after{left:0}.top-border:before{position:absolute;right:0;top:0;left:0;height:1px;content:'';-webkit-transform:scaleY(.5);transform:scaleY(.5);background-color:#c8c7cc}.mui-btn,button,input[type=button],input[type=reset],input[type=submit]{padding:6px 42%;border:none}.text-overflow{overflow:hidden;text-overflow:ellipsis}
		</style>
	</head>
	<body>
		<div id="">
			<header class="mui-bar mui-bar-nav transparent mui-box-shadow-none">
				<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left f-white"></a>
				<h1 class="mui-title">${ title }</h1>
			</header>
			<div id="offCanvasSideScroll" class="mui-scroll-wrapper">
				<form class="mui-input-group" action="${ctx}/backend/h5/user/saveAddress" onsubmit="return check()" method="post">
						<input type="text" hidden name="state" value="${ choose }" id="state"/>
						<input type="text" hidden name="id" value="${address.id }" id="id"/>
						<input type="text" hidden name="proId" value="${address.proId }" id="proId"/>
						<input type="text" hidden name="cityId" value="${address.cityId }" id="cityId"/>
						<input type="text" hidden name="regionId" value="${address.regionId }" id="regionId"/>
					<div class="mui-input-row">
						<label>联系地址:</label>
						<input type="text" placeholder="请选择地址" class="mui-text-right text-overflow" id="showCityPicker3">
					</div> 
					<div class="mui-input">
							<textarea id="address" name="address" placeholder="请输入详细地址" rows="3" cols="2">${ address.address }</textarea>
					</div>
					<div class="mui-input-row">
						<label>联系人:</label>
						<input type="text" id="name" name="name" value="${ address.name }" class="mui-input-clear mui-text-right" placeholder="请输入联系人" data-input-clear="5"><span class="mui-icon mui-icon-clear mui-hidden"></span>
					</div>
					<div class="mui-input-row">
						<label>联系电话:</label>
						<input type="tel" id="mobile" name="mobile" value="${ address.mobile }" class="mui-input-clear mui-text-right" placeholder="请输入联系电话" data-input-clear="5"><span class="mui-icon mui-icon-clear mui-hidden"></span>
					</div>
					<div class="mui-button-row">
						<button class="mui-btn bg-orange f-white">确认</button>
					</div>
				</form>
			</div>
		</div>
		<script src="${ctx}/public/celerepair/js/mui.min.js"></script>
		<script type="text/javascript" src="${ctx}/public/celerepair/js/js/mui.picker.js"></script>
		<script type="text/javascript" src="${ctx}/public/celerepair/js/js/mui.poppicker.js"></script>
		<script type="text/javascript" src="${ctx}/public/celerepair/js/js/city.data-3.js"></script>
		<script>
			mui.init();
			mui.init({
				swipeBack: true //启用右滑关闭功能
			});
			//实现ios平台原生侧滑关闭页面；
			if(mui.os.plus && mui.os.ios) {
				mui.plusReady(function() {
					//5+ iOS暂时无法屏蔽popGesture时传递touch事件，故该demo直接屏蔽popGesture功能
					plus.webview.currentWebview().setStyle({
						'popGesture': 'none'
					});
				});
			}
			//默认选中地区
			document.getElementById('showCityPicker3').value=seach(${address.proId })+" "+seach(${address.cityId })+" "+seach(${address.regionId });
			function seach(a){
				for(var i=0;i<cityData3.length;i++){
					if(cityData3[i].value==a){
						return cityData3[i].text
					}else{
						for(var m=0;m<cityData3[i].children.length;m++){
							if(cityData3[i].children[m].value==a){
								return cityData3[i].children[m].text
							}else{
								for(var n=0;n<cityData3[i].children[m].children.length;n++){
									if(cityData3[i].children[m].children[n].value==a){
										return cityData3[i].children[m].children[n].text;
									}
								}
							}
						}
					}
				}
			}
			
			
			
			function check(){
			   if(document.getElementById("regionId").value==''){
				    mui.tosat("请选择地区");
				    return false;
			   }if(document.getElementById("address").value.trim()==''){
				    mui.tosat("请输入详细地址");
				    return false;
			   }if(document.getElementById("name").value.trim()==''){
				    mui.tosat("请输入联系人");
				    return false;
			   }
			   var isMob= '(^(\d{3,4}-)?\d{7,8})$|(13[0-9]{9})';
			   if(!isMob.test(document.getElementById("mobile").value.trim())){
				    mui.tosat("请输入正确的联系电话");
			        return false;
			    }
			}
			(function($, doc) {
				$.init();
				$.ready(function() {
					//级联示例
					var cityPicker3 = new $.PopPicker({
						layer: 3
					});
					cityPicker3.setData(cityData3);
					var showCityPickerButton = doc.getElementById('showCityPicker3');
					showCityPickerButton.addEventListener('tap', function(event) {
						cityPicker3.show(function(items) {
							document.getElementById("proId").value=(items[0] || {}).value;
							document.getElementById("cityId").value=(items[1] || {}).value;
							document.getElementById("regionId").value=(items[2] || {}).value;
							showCityPickerButton.value = (items[0] || {}).text + " " + (items[1] || {}).text + " " + (items[2] || {}).text;
							//返回 false 可以阻止选择框的关闭
							//return false;
						});
					}, false);
				});
			})(mui, document);
		</script>
	</body>

</html>