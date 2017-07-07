<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>修改密码</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" href="${ctx}/public/celerepair/css/mui.min.css">
		<link rel="stylesheet" type="text/css" href="https://at.alicdn.com/t/font_n5o6ioc4rv8to6r.css"/>
		<style>
			html,body{background-color:#efeff4}span.mui-icon{font-size:20px;color:#fff}#offCanvasSideScroll{padding-top:44px}input[type="text"],input[type="password"]{color:#000;padding-left:38px;font-size:14px}.icon-left,.mui-input-row .mui-input-password~.mui-icon-eye{color:#000}#offCanvasSideScroll .icon-left{left:0}.mui-input-group .mui-input-row:after{right:10px;left:10px}.btn-submit{padding:10px;color:#fff}.mui-input-row>button{position:absolute;right:10px;top:50%;transform:translate(0,-50%);padding:3px 6px;border:0;font-size:14px}.iconfont{color:#ccc}
		</style>
	</head>
	<body>
		<div id="">
			<header class="mui-bar mui-bar-nav transparent mui-box-shadow-none">
				<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left f-white"></a>
				<h1 class="mui-title">修改密码</h1>
				<a href="message.html" class="mui-pull-right">
				</a>
			</header>
			<div id="offCanvasSideScroll" class="mui-scroll-wrapper">
				<form class="mui-input-group" id="objectContent" >
					<c:if test="${customer.customerType == 5}">
						<div class="mui-input-row">
							<span class="iconfont icon-shoujihao icon-left"></span>
							<input type="text" id="mobile" name="customerName" value="${ customer.mobile }" data-input-password="3" placeholder="手机号">
						</div>
						<div class="mui-input-row">
							<span class="iconfont icon-icon0103 icon-left"></span>
							<button class="bg-orange f-white" id="send">发送验证码</button>
							<input type="text" id="code" name = "code" data-input-password="3" placeholder="验证码" style="padding-right:102px">
						</div>
					</c:if>
					<c:if test="${customer.customerType != 5}">
						<div class="mui-input-row">
							<span class="iconfont icon-xingming icon-left"></span>
							<input type="text"  id="mobile" name="customerName" data-input-password="3" placeholder="手机号/账号">
						</div>
						<div class="mui-input-row">
							<span class="iconfont icon-denglumima icon-left"></span>
							<input type="password" id="oldPassword" name="oldPassword" class="mui-input-password" data-input-password="3" placeholder="原登录密码">
							<span class="iconfont icon-off-yanjing" onclick="see(this)"></span>
						</div>
					</c:if>
					<div class="mui-input-row">
						<span class="iconfont icon-denglumima icon-left"></span>
						<input type="password" id="newPassword" name="newPassword" class="mui-input-password" data-input-password="3" placeholder="新登录密码">
						<span class="iconfont icon-off-yanjing" onclick="see(this)"></span>
					</div>
					<br />
					<div class="btn-submit">
						<input type="submit" name="submit" id="submit" value="确定" class="mui-btn mui-btn-block bg-orange" />
					</div>
				</form>
			</div>
		</div>
		<script src="${ctx}/public/celerepair/js/mui.min.js"></script>
		<script type="text/javascript" src="${ctx}/public/celerepair/upload/jquery.js"></script>
		<!--<script type="text/javascript" src="../js/js/vconsole.min.js"></script>-->
		<script>
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
			//发送验证码
			if(${customer.customerType == 5}){
				document.getElementById('send').addEventListener('tap', function(event) {
					var event = event || window.event;
					event.preventDefault();
					var _this=this;
					window.event.returnValue = false;
					var phone = document.getElementById("mobile");//手机号码
					if (phone.value.replace(/^1(3|4|5|7|8)\d{9}$/, "")) {
						return mui.toast("请填写正确格式手机号码");
					}
					mui.get('${ctx}/backend/h5/user/getResetPasswordCode',{mobile:phone.value},function(data){
						mui.toast(data.msg);
						if (data.msgCode == "0000") {
							//成功
							_this.innerHTML='已发送(<span id="count">60</span>)秒';
							var time=parseInt(document.getElementById("count").innerHTML);
							var timer=setInterval(function() {
									time -= 1;
									if(time == 0 ) {
										_this.innerHTML='获取验证码';
										//清除定时器
										clearInterval(timer);
									} else {
										_this.setAttribute("disabled", "disabled");
										//设置倒计时数字
										document.getElementById("count").innerHTML=time;
									}
								}, 1000);
						}
					},'json');
				});
			}
			var customerName = document.getElementsByName('customerName')[0];
			var password = document.getElementById('newPassword');
			document.getElementById('submit').addEventListener('click',function(){
				event.preventDefault();
				window.event.returnValue = false;
				if(customerName.value.replace(/(^s*)|(s*$)/g, "").length == 0){
					return mui.toast("请填写正确的帐号/手机号");
				}
				if(password.value.replace(/(^s*)|(s*$)/g, "").length < 6){
					return mui.toast("请填写正确格式的密码");
				}
				mui.ajax('${ctx}/backend/h5/user/doResetPassword',{
					data:$('#objectContent').serialize(),
					type:'post',//HTTP请求类型
					dataType:'json',
					async:true,
					timeout:5000,//超时时间设置为5秒；             
					success:function(data){
						mui.toast(data.msg)
						if (data.msgCode == "0000") {
							window.location.href = "${ctx}/page/h5/personal.jsp";
						}
					},
					error:function(xhr,type,errorThrown){
						mui.toast("网络繁忙");
					}
				});
		   });

			function see(e) {
				var pass = e.previousElementSibling;
				if(pass.getAttribute('type') == "password") {
					pass.setAttribute("type", "text");
					e.setAttribute('class', e.getAttribute('class').replace(/off/, "no"));
				} else {
					pass.setAttribute("type", "password");
					e.setAttribute('class', e.getAttribute('class').replace(/no/, "off"));
				}
			};
		</script>
	</body>

</html>