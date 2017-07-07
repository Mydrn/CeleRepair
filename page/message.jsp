<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>消息中心</title>
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
			
			h4 {
				font-weight: 400
			}
			
			.mui-card-content-inner {
				padding: 10px
			}
			
			.mui-card-content-inner span {
				color: #757575
			}
			
			.mui-dot {
				position: absolute;
				display: inline-block;
				top: 10;
				right: 10px;
				width: 10px;
				height: 10px;
				border-radius: 50%;
				background: red;
			}
			
			.dataTime {
				margin-top: 10px
			}
			
			.mui-table-view-cell {
				margin: 11px 10px;
				padding: 0;
			}
			.mui-table-view,.mui-table-view:after,.mui-table-view:before{
				background-color: transparent;
			}
			.mui-btn{
				margin-bottom: 0;
			}
			.text-body{
				white-space: nowrap;
				overflow: hidden;
				text-overflow: ellipsis;
			}
		</style>
	</head>

	<body>
		<header class="mui-bar mui-bar-nav bg-orange">
			<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left f-white"></a>
			<h1 class="mui-title">消息中心</h1>
		</header>
		<div id="messageLists" class="mui-content">
			<ul id="OA_task_1" class="mui-table-view">
				<!-- <li>
					<p class="mui-text-center dataTime">2017-06-06 10:00 (周三)</p>
				</li> -->
				<c:forEach items="${tidingsList}" var="tidings">
				<li class="mui-table-view-cell" onclick="view(${tidings.id})" >
					<div class="mui-slider-right mui-disabled">
						<a class="mui-btn mui-btn-red" href="javascript:void(0)" onclick="deleted(${tidings.id})">删除</a>
					</div>
					<div class="mui-slider-handle">
						<div class="mui-card-content">
							<div class="mui-card-content-inner">
							<c:if test="${!tidings.status}"><span class="mui-dot"></span></c:if>	
								<h4>${tidings.title}</h4>
								<p class="text-body">${tidings.content}</p>
							</div>
						</div>
					</div>
				</li>
				</c:forEach>
			</ul>
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
			/* (function($) {
				var btnArray = ['取消','确认'];
				//拖拽后显示操作图标，点击操作图标删除元素；
				$('#OA_task_1').on('tap', '.mui-btn', function(event) {
					var elem = this;
					var li = elem.parentNode.parentNode;
					mui.confirm('确认删除该条记录？', '温馨提示', btnArray, function(e) {
						if(e.index == 1) {
							li.parentNode.removeChild(li);
						} else {
							setTimeout(function() {
								$.swipeoutClose(li);
							}, 0);
						}
					});
				})
				
			})(mui); */
			
			function deleted(event) {
				//document.getElementByClassName('mui-table-view-cell').onclick = function(){};
				$("li").removeAttr("onclick");
				var btnArray = ['取消','确认'];
				mui.confirm('确认删除该条记录？', '温馨提示',function(e) {
						if (e.index==1) {
							mui.ajax('${ctx}/backend/h5/list/deteletidings',{
								type:'get',//HTTP请求类型
								data:{objectId:event},
								dataType:'json',
								cache:false, 
							    async:false,
								timeout:5000,//超时时间设置为5秒；
								success:function(data){
									document.location.reload();	
								}
							});
						}else{
							setTimeout(function() {
								document.location.reload();
							}, 0);
						}
				})
			}
			//点击查看消息内容
			function  view(event) {
				mui.ajax('${ctx}/backend/h5/list/findtidingsFirst',{
					type:'get',//HTTP请求类型
					data:{id:event},
					dataType:'json',
					cache:false, 
				    async:false,
					timeout:5000,//超时时间设置为5秒；
					success:function(data){
						var h1=data.title;
						var p=data.content;
						mui.confirm(p, h1,function(e) {
							if(e.index == 1) {
								document.location.reload();
							} else {
								setTimeout(function() {
									document.location.reload();
								}, 0);
							}
						});
					}
				});
			}
		</script>
	</body>

</html>