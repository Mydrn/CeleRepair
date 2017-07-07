<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>修改手机号码</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" href="${ctx}/public/celerepair/css/mui.min.css">
		<link rel="stylesheet" type="text/css" href="https://at.alicdn.com/t/font_n5o6ioc4rv8to6r.css"/>
		<style>
			html,
			body {
				background-color: #efeff4;
			}
			span.mui-icon {
				font-size: 20px;
				color: #fff;
			}
			
			.mui-off-canvas-left {
				color: #fff;
			}
			
			.title {
				margin: 35px 15px 10px;
			}
			
			.title+.content {
				margin: 10px 15px 35px;
				color: #bbb;
				text-indent: 1em;
				font-size: 14px;
				line-height: 24px;
			}
			
			.mui-repair {
				width: 44%;
				padding: 4% 0;
				margin: 0 0 0 4%;
				color: #fff;
				border: 0;
				background: #92b0dd;
				border-radius: 10px;
			}
			
			#offCanvasSideScroll {
				padding-top: 44px
			}
			
			.mui-repair-left {
				margin-right: 4%;
				background: #e0b6b6;
			}
			
			.mui-repair-right {
				margin-left: -6px
			}
			
			.f-white {
				color: #fff!important
			}
			
			.f-blank {
				color: #000!important
			}
			
			.f-14 {
				font-size: 14px!important;
			}
			
			.bg-orange {
				background-color: #ff5700!important;
			}
			
			.mui-bar {
				background-color: #ff5700
			}
			
			.f-orange {
				color: #ff5700!important
			}
			
			input[type="text"],
			input[type="tel"],
			input[type="number"],
			input[type="password"] {
				color: #000;
				padding-left: 38px;
				font-size: 14px
			}
			
			.icon-left,
			.mui-input-row .mui-input-password~.mui-icon-eye {
				color: #000;
			}
			
			#offCanvasSideScroll .icon-left {
				left: 0
			}
			
			.mui-input-group .mui-input-row:after {
				right: 10px;
				left: 10px
			}
			
			.btn-submit {
				padding: 10px;
				color: #fff
			}
			
			.mui-input-row>button {
				position: absolute;
				right: 10px;
				top: 50%;
				transform: translate(0, -50%);
				padding: 3px 6px;
				border:none;
				font-size: 14px;
			}
			.iconfont {
    			color: #ccc;
			}
		</style>
	</head>
	<body>
		<div id="">
			<header class="mui-bar mui-bar-nav transparent mui-box-shadow-none">
				<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left f-white"></a>
				<h1 class="mui-title">修改手机号码</h1>
			</header>
			<div id="offCanvasSideScroll" class="mui-scroll-wrapper">
				<form class="mui-input-group" id="objectContent">
					<div class="mui-input-row">
						<span class="iconfont icon-shoujihao icon-left"></span>
						<button class="bg-orange f-white" id="send">发送验证码</button>
						<input type="tel" id="mobile" name="mobile"  data-input-password="3" placeholder="新手机号" style="padding-right:102px">
					</div>
					<div class="mui-input-row">
						<span class="iconfont icon-icon0103 icon-left"></span>
						<input type="number" id="code" name="code" data-input-password="3" placeholder="验证码">
					</div>
					<div class="mui-input-row">
						<span class="iconfont icon-denglumima icon-left"></span>
						<input type="password" id="password" name="password" class="mui-input-password" data-input-password="3" placeholder="登录密码"  style="padding-right:42px">
						<span class="iconfont icon-off-yanjing" onclick="see(this)"></span>
					</div>
					<div class="btn-submit">
						<input type="submit" name="submit" id="submit" value="完成" class="mui-btn mui-btn-block bg-orange" />
					</div>
				</form>
			</div>
		</div>
		<script src="${ctx}/public/celerepair/js/mui.min.js"></script>
		<!--<script type="text/javascript" src="../js/js/vconsole.min.js"></script>-->
		<script>
			mui.init();
			mui.init({
				swipeBack: true //启用右滑关闭功能
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
			//发送验证码
			var phone = document.getElementById("mobile");//手机号码
			document.getElementById('send').addEventListener('tap', function(event) {
				event.preventDefault();
				window.event.returnValue = false;
				var _this=this;
				if(phone.value.replace(/^1(3|4|5|7|8)\d{9}$/, "")){
					return mui.toast("手机号码有误");
				}
				mui.get('${ctx}/backend/h5/user/getMobileCode',{mobile:phone.value},function(data){
					mui.toast(data.msg);
					if (data.msgCode == "0000") {
						//成功
						//发送验证码倒计时
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

			var code = document.getElementById('code');
			var password = document.getElementById('password');
			document.getElementById('submit').addEventListener('tap',function(){
				event.preventDefault();
				window.event.returnValue = false;
				if(phone.value.replace(/(^s*)|(s*$)/g, "").length == 0){
					return mui.toast("请填写正确的手机号");
				}if(code.value.replace(/(^s*)|(s*$)/g, "").length == 0){
					return mui.toast("请填写验证码");
				}if(password.value.replace(/(^s*)|(s*$)/g, "").length < 5){
					return mui.toast("请填写正确格式的密码");
				}
				mui.ajax('${ctx}/backend/h5/user/doRevisePhone',{
					data:{
						mobile:phone.value,
						code:code.value,
						password:password.value
						},
					type:'post',//HTTP请求类型
					dataType:'json',
					async:true,
					timeout:5000,//超时时间设置为5秒；             
					success:function(data){
						mui.toast(data.msg);
						if (data.msgCode == "0000") {
							window.location.href = "${ctx}/page/h5/personal.jsp";
						}
					},
					error:function(xhr,type,errorThrown){
						mui.toast("网络繁忙");
					}
				});
			});
			
		</script>
	</body>

</html>