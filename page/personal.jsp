<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>个人信息</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" href="${ctx}/public/celerepair/css/mui.min.css">
		<link rel="stylesheet" type="text/css" href="${ctx}/public/celerepair/css/icons-extra.css" />
		<style>
			html,body{background-color:#efeff4}p{text-indent:22px}span.mui-icon{font-size:20px;color:#fff}.mui-off-canvas-left{color:#fff}.title{margin:35px 15px 10px}.title+.content{margin:10px 15px 35px;color:#bbb;text-indent:1em;font-size:14px;line-height:24px}#offCanvasSideScroll{padding-top:44px}.mui-repair-left{margin-right:4%;background:#e0b6b6}.mui-repair-right{margin-left:-6px}.textA{vertical-align:middle}.f-white{color:#fff!important}.f-14{font-size:14px!important}.bg-orange{background-color:#ff5700!important}.userImg{position:absolute;top:0;right:40px;height:43px;padding:3px 0}.mui-position-right{position:absolute;right:40px}.mui-bar{background-color:#ff5700}.f-orange{color:#ff5700!important}.exit .mui-table-view-cell{padding-right:0}.exit .mui-table-view-cell>a:not(.mui-btn){margin-right:0}[type="file"]{opacity:0;position:absolute;top:0;left:0;bottom:0;width:100%}
		</style>
	</head>

	<body>
		<div id="">
			<header class="mui-bar mui-bar-nav transparent mui-box-shadow-none">
				<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left f-white"></a>
				<%-- <a href="${ctx}/page/h5/index.jsp" class="mui-icon mui-icon-left-nav mui-pull-left f-white"></a> --%>
				<h1 class="mui-title">个人中心</h1>
				<a href="message.html" class="mui-pull-right">
				</a>
			</header>
			<div id="offCanvasSideScroll" class="mui-scroll-wrapper">
				<div class="mui-scroll">
					<ul class="mui-table-view mui-table-view-chevron mui-table-view-inverted">
						<li class="mui-table-view-cell">
							<a href="#picture" class="mui-navigate-right">
								头像
								<c:if test="${ empty customer.photoUrl }">
									<img class="userImg" id="userImg" src="${ctx}/public/celerepair/images/ice-repair.png" />
								</c:if>
								<c:if test="${ not empty customer.photoUrl }">
									<img class="userImg" id="userImg" src="${customer.photoUrl}" />
								</c:if>
							</a>
						</li>
						<li class="mui-table-view-cell">
							<a>
								姓名
								<span class="mui-position-right">${ customer.customerName }</span>
							</a>
						</li>
					</ul>
					<br />
					<ul class="mui-table-view mui-table-view-chevron mui-table-view-inverted">
						<li class="mui-table-view-cell">
							<a href="${ctx}/page/h5/personal-mobile.jsp" class="mui-navigate-right">
								联系电话
								<span class="mui-position-right">${ customer.mobile }</span>
							</a>
						</li>
						<li class="mui-table-view-cell">
							<a href="${ctx}/page/h5/personal-password.jsp" class="mui-navigate-right">
								修改密码
							</a>
						</li>
					</ul>
					<br />
					<br />
					<br />
					<ul class="mui-table-view mui-table-view-chevron mui-table-view-inverted exit">
						<li class="mui-table-view-cell mui-text-center">
							<a onclick="doLogout();" class="f-orange">
								退出
							</a>
						</li>
					</ul>
				</div>
			</div>
			<div id="picture" class="mui-popover mui-popover-action mui-popover-bottom">
				<ul class="mui-table-view">
					<li class="mui-table-view-cell">
						<h4 class="mui-vertical">拍照或录像</h4>
						<input type="file" name="picture" id="camera" onchange="file(this)" class="mui-opacity" capture="camera" accept="image/*" />
					</li>
					<li class="mui-table-view-cell">
						<h4 class="mui-vertical">选取现有的</h4>
						<input type="file" name="picture" id="picture" onchange="file(this)" class="mui-opacity" accept="image/*" />
					</li>
				</ul>
				<ul class="mui-table-view">
					<li class="mui-table-view-cell">
						<a href="#picture" class=""><b>取消</b></a>
					</li>
				</ul>
			</div>
		</div>
		<script src="${ctx}/public/celerepair/js/mui.min.js"></script>
		<!--<script type="text/javascript" src="../js/js/vconsole.min.js"></script>-->
		<script>
			mui.init({
				swipeBack: true //启用右滑关闭功能
			});
			function doLogout() {
				mui.toast("退出成功");
				mui.ajax('${ctx}/backend/h5/user/doLogout',{
					type:'post',//HTTP请求类型
					cache: false,
					async:true,
					dataType:'json',
					timeout:5000,//超时时间设置为10秒；
					success:function(data){
						window.location.href = "${ctx}/page/h5/login.jsp"
					},
					error:function(xhr,type,errorThrown){
						mui.toast("网络繁忙");
						console.log(type);
					}
				});	
			}
			//修改头像事件
			function file(e) {
				console.log(e.files[0]);
				formData = new FormData();
				formData.append("file", e.files[0]);
				formData.append("attachmentType", 7);
				mui.ajax('${ctx}/backend/base/saveImg',{
					data:formData,
					type:'post',//HTTP请求类型
					dataType: 'text',
					contentType: false, //必须 
					processData: false, //必须
					cache: false,
					async: true,
					timeout:5000,//超时时间设置为5秒；
					success:function(url){
						mui.ajax('${ctx}/backend/h5/user/saveUserImg',{
							data:{
								photoUrl:url
							},
							type:'post',//HTTP请求类型
							cache: false,
							async: true,
							dataType:'json',
							timeout:5000,//超时时间设置为10秒；
							success:function(data){
								document.getElementById("userImg").src = url;
								mui.toast(data.msg);
							},
							error:function(xhr,type,errorThrown){
								mui.toast("网络繁忙");
								console.log(type);
							}
						});	
					},
					error:function(xhr,type,errorThrown){
						mui.toast("网络繁忙");
						console.log(type);
					}
				});
				document.querySelector('#picture').style.display='none';
				document.querySelector('.mui-backdrop-action').style.display='none';
			}
		</script>
	</body>

</html>