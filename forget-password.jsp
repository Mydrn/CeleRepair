<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>找回密码</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" href="${ctx}/public/celerepair/css/mui.min.css">
		<link rel="stylesheet" type="text/css" href="https://at.alicdn.com/t/font_n5o6ioc4rv8to6r.css" />
		<style>
			html,body{background-color:#efeff4}#register .mui-input-row input{color:#fff;padding:15px 10px 15px 38px}#register{position:fixed;top:0;left:0;right:0;bottom:0;z-index:99;text-align:center;background:rgba(120,120,120,0.75)}#register .mui-btn-block{padding:6px 12px;border:0}.mui-filter{-webkit-filter:blur(6px);-moz-filter:blur(6px);-o-filter:blur(6px);-ms-filter:blur(6px);filter:blur(6px)}#register .mui-input-group{background:transparent;padding:0 10px}#register input{border:1px solid #a7a7a7;border-radius:6px}#register .mui-input-row{margin-bottom:10px}.icon-left{left:0;font-size:20px;font-weight:400}.transparent{background:transparent}#register .mui-content{padding-top:25%}#register .mui-content{background:transparent}#register .mui-table-view{background:transparent}#register .contact{margin:20px 0;font-size:15px}.mui-box-shadow-none{box-shadow:none}.mui-input-group .mui-input-row:after{background:transparent}
		</style>
	</head>
	<body>
		<div id="register">
			<header class="mui-bar mui-bar-nav transparent mui-box-shadow-none">
				<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left f-white"></a>
				<h1 class="mui-title">找回密码</h1>
			</header>
			<div class="mui-content">
				<div style="padding: 10px 10px;">
					<div id="segmentedControl" class="mui-segmented-control">
						<a class="mui-control-item mui-active" href="#item2">普通店铺</a>
						<a class="mui-control-item" href="#item3">合作店铺</a>
					</div>
				</div>
				<br />
				<div>
					<div id="item2" class="mui-control-content mui-active">
						<form class="mui-input-group" id="objectContent">
							<div class="mui-input-row">
								<span class="iconfont icon-shoujihao icon-left"></span>
								<input type="text" data-input-password="3" id="mobile" name="mobile" placeholder="手机号">
							</div>
							<div class="mui-input-row">
								<span class="iconfont icon-icon0103 icon-left"></span>
								<button class="bg-orange f-white" id="send">发送验证码</button>
								<input type="text" data-input-password="3" placeholder="验证码" style="padding-right:102px" id="code" name="code">
							</div>
							<div class="mui-input-row">
								<span class="iconfont icon-denglumima icon-left"></span>
								<input type="password" class="mui-input-password" data-input-password="3" placeholder="登录密码" id="password" name="password">
								<span class="iconfont icon-off-yanjing" onclick="see(this)"></span>
							</div>
							<div class="mui-input-row">
								<span class="iconfont icon-zaicishurumima_fuzhi icon-left"></span>
								<input type="password" class="mui-input-password" data-input-password="3" placeholder="确认密码" id="password1">
								<span class="iconfont icon-off-yanjing" onclick="see(this)"></span>
							</div>
							<br />
							<input type="submit" name="submit" id="submit" value="确定" class="mui-btn mui-btn-block bg-orange f-white" />
						</form>
					</div>
					<div id="item3" class="mui-control-content">
						<form class="mui-input-group">
							<p class="contact f-white">合作用户请联系客服找回密码</p>
							<a href="tel:021-37656937" class="mui-btn mui-btn-block bg-orange f-white f-14" id="kh"></a>
						</form>
					</div>
				</div>
			</div>
		</div>
		<script src="${ctx}/public/celerepair/js/mui.min.js"></script>
			<script type="text/javascript" src="${ctx}/public/celerepair/upload/jquery.js"></script>
		<script type="text/javascript">
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
			document.getElementById('send').addEventListener('tap', function(event) {
				event.preventDefault();
				window.event.returnValue = false;
				var _this=this;
				var phone = document.getElementById("mobile").value;//手机号码
				if(phone.length!=11){
					return mui.toast("手机号码有误");
				}
				mui.ajax('${ctx}/backend/h5/user/getBackPasswordCode',{
					data:{
						mobile : phone
					},
					type:'get',//HTTP请求类型
					dataType:'json',
					timeout:5000,//超时时间设置为5秒；	              
					success:function(data){
						if(data.msgCode=="0002"){
							return mui.toast("您没有该权限,请联系我们的客服");
						}else if(data.msgCode=="0001"){
							return mui.toast("手机号不存在");
						}else if(data.msgCode=="0003"){
							return mui.toast("系统超时,请稍后再试");
						}
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
					},
					error:function(xhr,type,errorThrown){
						
					}
				});
			})
			
			var fragment = document.getElementById("kh");
			mui.ajax('${ctx}/backend/h5/list/findContactUsFirst',{
				type:'get',//HTTP请求类型
				dataType:'json',
				cache:false, 
			    async:false,
				timeout:5000,//超时时间设置为5秒；
				success:function(data){
					fragment.innerHTML='客服电话：'+data.phone;
					fragment.setAttribute('href',data.phone);
				}
			});
			
			
			//找回密码
			var phone = document.getElementById("mobile");
			var code = document.getElementById('code');
			var password= document.getElementById('password');
			var password1 = document.getElementById('password1');
			document.getElementById('submit').addEventListener('click',function(){
				event.preventDefault();
				window.event.returnValue = false;
				if (phone.value.replace(/^1(3|4|5|7|8)\d{9}$/, "")) {
					return mui.toast("请填写正确格式手机号码");
				}
				if (phone.value.length!=11) {
					return mui.toast("请填写正确格式手机号码");
				}
				if(password.value.replace(/(^s*)|(s*$)/g, "").length < 6){
					return mui.toast("请填输入正确格式的密码");
				}
				if(password1.value.replace(/(^s*)|(s*$)/g, "").length < 6){
					return mui.toast("请填输入正确格式的密码");
				}
				if(password.value!=password1.value){
					return mui.toast("两次密码不一致");
				} 
				mui.ajax('${ctx}/backend/h5/user/backPassword',{
					data:$('#objectContent').serialize(),
					type:'post',//HTTP请求类型
					dataType:'json',
					async:true,
					timeout:5000,//超时时间设置为5秒；             
					success:function(data){
						if (data.statusCode == "0000") {
							mui.alert('密码找回成功', function() {
								window.location.href = "${ctx}/page/h5/login.jsp";
							});
						}else if(data.statusCode == "0001"){
							return mui.toast("手机为空");
						}else if(data.statusCode == "0002"){
							return mui.toast("您没有该权限,请联系我们的客服");
						}else if(data.statusCode == "0003"){
							return mui.toast("验证码错误");
						}else{
							return mui.toast("系统错误,请稍后再试");
						}
					},
					error:function(xhr,type,errorThrown){
						
					}
				});
		   });
			
		</script>
	</body>

</html>