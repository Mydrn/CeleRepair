<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>关于快修</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" href="${ctx}/public/celerepair/css/mui.min.css">
		<link rel="stylesheet" type="text/css" href="${ctx}/public/celerepair/css/icons-extra.css" />
		<style>
			html,
			body {
				background-color: #efeff4;
			}
			
			/*p {
				text-indent: 22px;
			}*/
			
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
			
			input {
				color: #fff;
			}
			
			.userPic {
				position: absolute;
				top: 50%;
				left: 50%;
				-webkit-transform: translate(-50%, -50%);
				-ms-transform: translate(-50%, -50%);
				transform: translate(-50%, -50%);
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
			#offCanvasSideScroll{padding-top:44px}
			.mui-repair-left {
				margin-right: 4%;
				background: #e0b6b6;
			}
			
			.mui-repair-right {
				margin-left: -6px
			}
			
			.textA {
				vertical-align: middle
			}
			
			.f-white {
				color: #fff!important
			}
			
			.f-14 {
				font-size: 14px!important;
			}
			
			.bg-orange {
				background-color: #ff5700!important;
			}
			.userImg{
				position: absolute;
				top: 0;
				right:40px;
				height: 43px;
				padding:3px 0;
			}
			.mui-position-right{
				position: absolute;
				right: 40px;
			}
			.mui-bar{background-color:#ff5700}
			.f-orange {
				color: #ff5700!important
			}
			.content{padding-top:30%}
			.content .about{
				padding:10px 0 0;
			}
			/*控制退出的样式*/
			.exit .mui-table-view-cell{padding-right:0}
			.exit .mui-table-view-cell>a:not(.mui-btn){margin-right:0}
		</style>
	</head>

	<body>
		<div id="">
			<header class="mui-bar mui-bar-nav transparent mui-box-shadow-none">
				<a href="${ctx}/page/h5/index.jsp" class="mui-icon mui-icon-left-nav mui-pull-left f-white"></a>
				<h1 class="mui-title">关于快修</h1>
				<a href="message.html" class="mui-pull-right">
				</a>
			</header>
			<div id="offCanvasSideScroll" class="mui-scroll-wrapper mui-text-center">
				<div class="content">
					<img src="${ctx}/public/celerepair/images/logo.png"/>
					<p class="about">快修 旨在精益求精</p>
					<p>1.0.0</p>
				</div>
			</div>
		</div>
		<script src="${ctx}/public/celerepair/js/mui.min.js"></script>
		<!--<script type="text/javascript" src="../js/js/vconsole.min.js"></script>-->
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
		</script>
	</body>

</html>