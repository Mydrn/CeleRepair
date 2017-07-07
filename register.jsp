<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>用户注册</title>
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
			
			
			#register .mui-input-row input {
				color: #fff;
				padding: 8px 10px 8px 38px
			}
			
			#register {
				position: fixed;
				top: 0;
				left: 0;
				right: 0;
				bottom: 0;
				z-index: 99;
				text-align: center;
				background: rgba(120, 120, 120, 0.75);
			}
			
			#register .mui-btn-block {
				padding: 6px 12px;
				border: none;
			}
			
			.mui-filter {
				-webkit-filter: blur(6px);
				-moz-filter: blur(6px);
				-o-filter: blur(6px);
				-ms-filter: blur(6px);
				filter: blur(6px);
			}
			
			.login-content {
				padding-top: 30%
			}
			
			.login-content img {
				margin-bottom: 15%
			}
			
			#register .mui-input-group {
				background: transparent;
				padding: 0 10px
			}
			
			#register input {
				border: 1px solid #a7a7a7;
				border-radius: 6px;
			}
			
			#register .mui-input-row {
				margin-bottom: 10px;
			}
			
			.icon-left {
				left: 0;
				font-size: 20px;
				font-weight: 400;
			}
			
			.transparent {
				background: transparent
			}
			
			#register .mui-content {
				padding-top: 25%;
				padding-bottom: 12%
			}
			
			#register .mui-content {
				background: transparent
			}
			
			#register .mui-table-view {
				background: transparent;
			}
			
			#register .contact {
				margin: 20px 0;
				font-size: 15px;
			}
			
			.mui-content {
				padding-top: 44px;
			}
			
			#register header a {
				color: #fff
			}
			
			.mui-box-shadow-none {
				box-shadow: none;
			}
			
			.mui-input-group .mui-input-row:after {
				background: transparent
			}
			
			
			.file {
				opacity: 0;
				position: absolute;
				top: 0;
				left: 0;
				right: 0;
				bottom: 0;
				width: 100%;
				height: 100%;
			}
			
			.file-box {
				float: left;
				position: relative;
				overflow: hidden;
				margin:0 2px 2px 0;
				border: 1px dotted #ccc;
				box-sizing: border-box;
				-webkit-box-sizing: border-box;
				-moz-box-sizing: border-box;
				-webkit-border-radius: 10px;
				-moz-border-radius: 10px;
				border-radius: 10px;
			}
			.file-box:nth-child(4n+4){
				margin:0;
				margin-bottom: 2px;
			}
			
			.file-box img {
				position: absolute;
				top: 0;
				left: 0;
				width: 100%;
				z-index: 1;
				min-height: 100%;
			}
			
			.file-box:before {
				position: absolute;
				top: 50%;
				left: 50%;
				transform: translate(-50%, -50%);
				font-family: "微软雅黑";
				content: '';
				width: 2px;
				height: 50%;
				background: #ccc;
			}
			
			.file-box:after {
				position: absolute;
				top: 50%;
				left: 50%;
				transform: translate(-50%, -50%);
				font-family: "微软雅黑";
				content: '';
				width: 50%;
				height: 2px;
				background: #ccc;
			}
			.business-body{
				border: 1px solid #a7a7a7;
    			border-radius: 6px;
    			padding:9px;
			}
			.business {
				margin-top: 9px;
				overflow:hidden;
			}
			.mui-left{
				float: left;
			}
		</style>
	</head>

	<body>
		<div id="register">
			<header class="mui-bar mui-bar-nav transparent mui-box-shadow-none">
				<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
				<h1 class="mui-title">注册快修</h1>
			</header>
			<div id="offCanvasSideScroll" class="mui-scroll-wrapper">
				<div class="mui-scroll">
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
										<span class="iconfont icon-xingming icon-left"></span>
										<input type="text" data-input-password="3" placeholder="姓名" id="customerName" name="customerName">
									</div>
									<div class="mui-input-row">
										<span class="iconfont icon-shoujihao icon-left"></span>
										<input type="tel" data-input-password="3" placeholder="手机号" id="mobile" name="mobile">
									</div>
									<div class="mui-input-row">
										<span class="iconfont icon-icon0103 icon-left"></span>
										<button class="bg-orange f-white" id="send">发送验证码</button>
										<input type="text" data-input-password="3" placeholder="验证码" id="code" name="code">
									</div>
									<div class="mui-input-row">
										<span class="iconfont icon-denglumima icon-left"></span>
										<input type="password" class="mui-input-password" data-input-password="3" placeholder="登录密码" id="password" name="password">
										<span class="iconfont icon-off-yanjing" onclick="see(this)"></span>
									</div>
									<!-- <input type="text" hidden id="imgUrl" name="imgUrl" value="" />
									<div class="mui-text-left business-body">
										<label for="file" class="f-white">上传营业执照/身份证正面:</label>
										<div class="business">
											<div class="file-box">
												<input type="file" class="file" accept="image/*" onchange="file(this)" />
											</div>
										</div>
									</div> -->
									<br />
									<input type="submit" name="submit" id="submit" value="注册" class="mui-btn mui-btn-block bg-orange f-white" />
								</form>
							</div>
							<div id="item3" class="mui-control-content">
								<form class="mui-input-group">
									<p class="contact f-white">合作用户请联系客服注册账号</p>
									<a href="tel:021-37656937" class="mui-btn mui-btn-block bg-orange f-white f-14" id="kh"><!-- 400-200-3000 --></a>
								</form>
							</div>
						</div>
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

			//主界面和侧滑菜单界面均支持区域滚动；
			mui('#offCanvasSideScroll').scroll();

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
				mui.ajax('${ctx}/backend/h5/user/getMobileCode',{
					data:{
						mobile : phone
					},
					type:'get',//HTTP请求类型
					dataType:'json',
					timeout:5000,//超时时间设置为5秒；	              
					success:function(data){
						if(data.msgCode=="0001"){
							return mui.toast("该手机已注册");
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

			/* //设置图片的平均分配宽度
			src();

			function src() {
				var arr = document.querySelectorAll('.file-box');
				var old = document.querySelector('.business').scrollWidth;
				for(var i = 0; i < arr.length; i++) {
					arr[i].style.width=arr[i].style.height = (old-6) / 4+ 'px';
				}
			}
			
			//图片上传事件
			var  imgs=[];
			function file(event) {
				var _this = event.parentNode;
				formData = new FormData();
				formData.append("file", event.files[0]);
				formData.append("attachmentType", 8);
				mui.ajax("${ctx}/backend/base/saveImg",{
					type: "post",
					dataType: 'text',
					contentType: false, //必须 
					processData: false, //必须
					cache: false,
					async:true,
					data: formData,
					success: function(xhr,status,data) {
						imgs.push(xhr);
						document.getElementById("imgUrl").value = imgs;
						if(window.FileReader) {
							var reader = new FileReader();
							reader.readAsDataURL(event.files[0]);
							//监听文件读取结束后事件    
							reader.onloadend = function(e) {
								//console.log(e.target.result); //e.target.result就是最后的路径地址
								var img = document.createElement('img');
								var div = document.createElement('div');
								img.setAttribute('src', xhr);
								_this.appendChild(img);
								div.setAttribute('class', 'file-box');
								div.innerHTML = '<input type="file" class="file" accept="image/*" onchange="file(this)">'
								_this.parentNode.appendChild(div);
								src();
							};
						}
					}
				});
				
			}
			
			(function($, doc) {
				$.ready(function() {
					var top = $('header');
					for(var i = 0; i < top.length; i++) {
						top[i].style.paddingTop = (128 / 1334 * window.screen.height - 44).toFixed(2) + 'px';
						top[i].style.height=document.getElementById('offCanvasSideScroll').style.paddingTop = (128 / 1334 * window.screen.height).toFixed(2) + 'px';
					}
				})
			})(mui, document); */
			//注册
			var phone = document.getElementById("mobile");
			var customerName = document.getElementById('customerName');
			var password = document.getElementById('password');
			document.getElementById('submit').addEventListener('tap',function(){
				event.preventDefault();
				window.event.returnValue = false;
				if(customerName.value.replace(/(^s*)|(s*$)/g, "").length == 0){
					return mui.toast("请填写帐号");
				}
				if (phone.value.replace(/^1(3|4|5|7|8)\d{9}$/, "")) {
					return mui.toast("请填写正确格式手机号码");
				}
				if (phone.value.length!=11) {
					return mui.toast("请填写正确格式手机号码");
				}
				if(password.value.replace(/(^s*)|(s*$)/g, "").length < 6){
					return mui.toast("请填输入正确格式的密码");
				}
				mui.ajax('${ctx}/backend/h5/user/savePersonalCustomer',{
					data:$('#objectContent').serialize(),
					type:'post',//HTTP请求类型
					dataType:'json',
					async:true,
					timeout:5000,//超时时间设置为5秒；             
					success:function(data){
						if (data.statusCode == "0000") {
							mui.alert('注册成功', function() {
								window.location.href = "${ctx}/page/h5/login.jsp";
							});
						}else if(data.statusCode == "0002"){
							return mui.toast("您的账号正在审核，请勿重复注册");
						}else if(data.statusCode == "0003"){
							return mui.toast("账号名称已存在");
						}else if(data.statusCode == "0004"){
							return mui.toast("验证码错误");
						}else{
							return mui.toast("系统错误,请稍后再试");
						}
					},
					error:function(xhr,type,errorThrown){
						
					}
				});
		   });
			
			var fragment = document.getElementById("kh");
			mui.ajax('${ctx}/backend/h5/list/findContactUsFirst',{
				type:'get',//HTTP请求类型
				dataType:'json',
				cache:false, 
			    async:false,
				timeout:5000,//超时时间设置为5秒；
				success:function(data){
					fragment.innerHTML='客服电话：'+data.phone;
					fragment.setAttribute('href',"tel:"+data.phone);
				}
			});
		</script>
	</body>

</html>