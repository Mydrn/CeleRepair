<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>用户协议</title>
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
			
			#offCanvasSideScroll {
				padding-top: 44px
			}
			
			#content {
				padding: 10px 15px;
			}
			
			.treaty-bottom {
				position: fixed;
				bottom: 0;
				width:100%;
				z-index: 99;
			}
			.treaty-bottom>a{
				width: 50%;
				display: inline-block;
				float: left;
				padding:3% 0;
				text-align: center;
				background-color: #e4e4e4;
				font-weight: 500;
				color:#b1b1b1;
			}
			#treaty-text{
				background-color: #fff;
				padding:5px 0;
				width:100%;
				display: inline-block;
				text-align: center;
			}
			.mui-scroll-wrapper{
				position: relative;
			}
			.mui-scroll {
				padding-bottom: 65px;
			}
		</style>
	</head>

	<body>
		<div id="">
			<header class="mui-bar mui-bar-nav transparent mui-box-shadow-none">
				<a  class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left f-white"></a>
				<h1 class="mui-title">用户协议</h1>
				<a href="message.html" class="mui-pull-right">
				</a>
			</header>
			<div id="offCanvasSideScroll" class="mui-scroll-wrapper mui-text-center">
				<div class="mui-scroll-wrapper">
					<div class="mui-scroll">
						<div id="content">
							<!-- <p>adbnsakjdcbhxzbhczxdbcsaj,zbcxzmhbcmzbdxzkj</p> -->
						</div>
					</div>
				</div>
			</div>
			<div class="treaty-bottom">
				<span id="treaty-text" class="f-orange f-14">我已仔细阅读，并同意该合约内容</span>
				<a href="login.jsp">拒绝</a>
				<a href="register.jsp" class="bg-orange f-white">同意</a>
			</div>
		</div>
		<script src="${ctx}/public/celerepair/js/mui.min.js"></script>
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
			var fragment = document.getElementById("content");
			mui.ajax('${ctx}/backend/h5/list/findAgreementFirst',{
				type:'get',//HTTP请求类型
				dataType:'json',
				cache:false, 
			    async:false,
				timeout:5000,//超时时间设置为5秒；
				success:function(data){
					fragment.innerHTML=data.content;
				}
			});
			
//			(function($, doc) {
//				$.ready(function() {
//					var top = $('header');
//					for(var i = 0; i < top.length; i++) {
//						top[i].style.paddingTop = (128 / 1334 * window.screen.height - 44).toFixed(2) + 'px';
//						top[i].style.height=document.getElementById('offCanvasSideScroll').style.paddingTop = (128 / 1334 * window.screen.height).toFixed(2) + 'px';
//					}
//				})
//			})(mui, document);
		</script>
	</body>

</html>