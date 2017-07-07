<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>我的订单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" href="${ctx}/public/celerepair/css/mui.min.css">
		<style>
			html,body{background-color:#efeff4}.mui-bar~.mui-content .mui-fullscreen{top:44px;height:auto}.mui-pull-top-tips{position:absolute;top:-20px;left:50%;margin-left:-25px;width:40px;height:40px;border-radius:100%;z-index:1}.mui-bar~.mui-pull-top-tips{top:24px}.mui-pull-top-wrapper{width:42px;height:42px;display:block;text-align:center;background-color:#efeff4;border:1px solid #ddd;border-radius:25px;background-clip:padding-box;box-shadow:0 4px 10px #bbb;overflow:hidden}.mui-pull-top-tips.mui-transitioning{-webkit-transition-duration:200ms;transition-duration:200ms}.mui-pull-top-tips .mui-pull-loading{margin:0}.mui-pull-top-wrapper .mui-icon,.mui-pull-top-wrapper .mui-spinner{margin-top:7px}.mui-pull-bottom-tips{text-align:center;background-color:#efeff4;font-size:15px;line-height:40px;color:#777}.mui-pull-top-canvas{overflow:hidden;background-color:#fafafa;border-radius:40px;box-shadow:0 4px 10px #bbb;width:40px;height:40px;margin:0 auto}.mui-pull-top-canvas canvas{width:40px}.mui-slider-indicator.mui-segmented-control{background-color:#efeff4}.mui-scroll-wrapper{overflow:hidden}#sliderSegmentedControl .mui-active{color:#ff5700}.order-title{color:#000;margin-top:6px}.stateType{position:absolute;top:50%;right:15px;border:1px solid #a5a5a5;padding:2px 8px;border-radius:5px;color:#a5a5a5;line-height:20px;-webkit-transform:translate(0,-50%);-ms-transform:translate(0,-50%);transform:translate(0,-50%)}.mui-table-view-cell{margin-bottom:10px;background-color:#fff}.mui-control-content,.mui-table-view{background-color:transparent}.f-white{color:#fff!important}
		</style>
	</head>

	<body>
		<header class="mui-bar mui-bar-nav">
			<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left f-white"></a>
			<h1 class="mui-title">我的订单</h1>
		</header>
		<div class="mui-content">
			<div id="slider" class="mui-slider mui-fullscreen">
				<div id="sliderSegmentedControl" class="mui-slider-indicator mui-segmented-control mui-segmented-control-inverted">
					<a class="mui-control-item mui-active" href="#item1mobile">
						全部
					</a>
					<a class="mui-control-item" href="#item2mobile">
						审核中
					</a>
					<a class="mui-control-item" href="#item3mobile">
						待上门
					</a>
					<a class="mui-control-item" href="#item4mobile">
						待支付
					</a>
					<a class="mui-control-item" href="#item5mobile">
						待评价
					</a>
				</div>
				<div id="sliderProgressBar" class="mui-slider-progress-bar mui-col-xs-25 bg-orange"></div>
				<div class="mui-slider-group">
					<div id="item1mobile" class="mui-slider-item mui-control-content mui-active">
						<div class="mui-scroll-wrapper">
							<div class="mui-scroll all">
								<ul class="mui-table-view mui-loading">
									<div class="mui-spinner">
									</div>
								</ul>
							</div>
						</div>
					</div>
					<div id="item2mobile" class="mui-slider-item mui-control-content">
						<div class="mui-scroll-wrapper">
							<div class="mui-scroll">
								<ul class="mui-table-view mui-loading">
									<c:forEach var="obj" items="${ caseList }">
									<c:if test="${ obj.caseStatus == -1 }">
										<ul class="mui-table-view">
											<li class="mui-table-view-cell mui-media">
												<a href="${ctx}/backend/h5/case/doCaseOne?caseId=${ obj.id }">
													<img class="mui-media-object mui-pull-left" src="${obj.attachmentFile}">
													<div class="mui-media-body">
														<p class="order-title">${ obj.claimCode }</p>
														<p class="mui-ellipsis">${ obj.createTime }</p>
													</div><span class="stateType">审<br />核<br />中</span>
												</a>
											</li>
										</ul>
									</c:if>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
					<div id="item3mobile" class="mui-slider-item mui-control-content">
						<div class="mui-scroll-wrapper">
							<div class="mui-scroll">
								<ul class="mui-table-view mui-loading">
										<c:forEach var="obj" items="${ caseList }">
										<c:if test="${ obj.caseStatus == 0 || obj.caseStatus == 1 || obj.caseStatus == 2 }">
											<ul class="mui-table-view">
												<li class="mui-table-view-cell mui-media">
													<a href="${ctx}/backend/h5/case/doCaseOne?caseId=${ obj.id }">
														<img class="mui-media-object mui-pull-left" src="${obj.attachmentFile}">
														<div class="mui-media-body">
															<p class="order-title">${ obj.claimCode }</p>
															<p class="mui-ellipsis">${ obj.createTime }</p>
														</div><span class="stateType">待<br />上<br />门</span>
													</a>
												</li>
											</ul>
										</c:if>
										</c:forEach>
								</ul>
							</div>
						</div>
					</div>
					<div id="item4mobile" class="mui-slider-item mui-control-content">
						<div class="mui-scroll-wrapper">
							<div class="mui-scroll">
								<ul class="mui-table-view mui-loading">
								<c:forEach var="obj" items="${ caseList }">
										<c:if test="${ obj.caseStatus == 7 }">
											<ul class="mui-table-view">
												<li class="mui-table-view-cell mui-media">
													<a href="${ctx}/backend/h5/case/doCaseOne?caseId=${ obj.id }">
														<img class="mui-media-object mui-pull-left" src="${obj.attachmentFile}">
														<div class="mui-media-body">
															<p class="order-title">${ obj.claimCode }</p>
															<p class="mui-ellipsis">${ obj.createTime }</p>
														</div><span class="stateType">待<br />支<br />付</span>
													</a>
												</li>
											</ul>
										</c:if>
										</c:forEach>
								</ul>
							</div>
						</div>
					</div>
					<div id="item5mobile" class="mui-slider-item mui-control-content">
						<div class="mui-scroll-wrapper">
							<div class="mui-scroll">
								<ul class="mui-table-view mui-loading">
									<c:forEach var="obj" items="${ caseList }">
									
										<c:if test="${obj.caseStatus == 4 && empty obj.assessScore }">
											<ul class="mui-table-view">
												<li class="mui-table-view-cell mui-media">
													<a href="${ctx}/backend/h5/case/doCaseOne?caseId=${ obj.id }">
														<img class="mui-media-object mui-pull-left" src="${obj.attachmentFile}">
														<div class="mui-media-body">
															<p class="order-title">${ obj.claimCode }</p>
															<p class="mui-ellipsis">${ obj.createTime }</p>
														</div><span class="stateType">待<br />评<br />价</span>
													</a>
												</li>
											</ul>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script src="${ctx}/public/celerepair/js/mui.min.js"></script>
		<script src="${ctx}/public/celerepair/js/js/mui.pullToRefresh.js"></script>
		<script src="${ctx}/public/celerepair/js/js/mui.pullToRefresh.material.js"></script>
		<script>
			mui.init();

			mui('body').on('tap', 'a', function() {
				if(this.href.indexOf('#item')>0){
					return
				}else{
					window.top.location.href = this.href;
				}
			});
			(function($) {
				//阻尼系数
				var deceleration = mui.os.ios ? 0.003 : 0.0009;
				$('.mui-scroll-wrapper').scroll({
					bounce: false,
					indicators: true, //是否显示滚动条
					deceleration: deceleration
				});
				var pages = 1;
				//循环初始化所有下拉刷新，上拉加载。
				$.each(document.querySelectorAll('.mui-slider-group .all'), function(index, pullRefreshEl) {
					$(pullRefreshEl).pullToRefresh({
						down: {
							//这里是下滑请求后台数据
							callback: function() {
								pages++;
								var self = this;
								setTimeout(function() {
									var ul = self.element.querySelector('.mui-table-view');
									ul.insertBefore(createFragment(ul, pages, 10, true), ul.firstChild);
									self.endPullDownToRefresh();
								}, 500);
							}
						},
						up: {
							//这里是上滑请求后台数据
							callback: function() {
								pages++;
								var self = this;
								setTimeout(function() {
									var ul = self.element.querySelector('.mui-table-view');
									ul.appendChild(createFragment(ul, pages, 10));
									self.endPullUpToRefresh();
								}, 500);
							}
						}
					});
				});
				//在这里创建DOM结构
				var numOld = false;
				var state1 = "审<br />核<br />中", state2 = "待<br />上<br />门",
					state3 = "待<br />审<br />批", state4 = "待<br />付<br />款",
					state5 = "待<br />评<br />价", state6 = "已<br />完<br />成",
					state7 = "待<br />接<br />单";
				var stateType = "已<br />完<br />成";
				var createFragment = function(ul, page, count, reverse) {
					var fragment = document.createDocumentFragment();
					var li;
					if(numOld){
						mui.toast("没有更多数据");
						return fragment;
					}
					mui.ajax('${ctx}/backend/h5/case/doPairCasePage',{
						data:{
							pages:pages,
							num:count
						},
						type:'post',//HTTP请求类型
						dataType:'json',
						cache:false, 
					    async:false,
						timeout:5000,//超时时间设置为5秒；
						success:function(data){
							if(data.length == 0){
								mui.toast("没有更多数据");
								numOld = true;
							}
							for (var item in data) {
								if(data[item].caseStatus == -1 && data[item].customerType != 5){stateType = state1}
								else if(data[item].caseStatus == -1  && data[item].customerType == 5){stateType = state7}
								else if(data[item].caseStatus == 0 || data[item].caseStatus == 1 || data[item].caseStatus == 2){stateType = state2}
								else if(data[item].caseStatus == 3 && data[item].customerType != 5){stateType = state3}
								else if(data[item].caseStatus == 3 && data[item].customerType == 5){stateType = state4}
								else if(data[item].caseStatus == 4 && data[item].assessScore == null){stateType = state5}
								li = document.createElement('li');
								li.className = 'mui-table-view-cell mui-media';
								li.innerHTML = '<a href="${ctx}/backend/h5/case/doCaseOne?caseId='+ data[item].id +'">'+
												'<img class="mui-media-object mui-pull-left" src="'+ data[item].attachmentFile +'">'+
													'<div class="mui-media-body">'+
														'<p class="order-title">'+ data[item].claimCode +'</p>'+
															'<p class="mui-ellipsis">'+data[item].updateTimeString +'</p>'+
													'</div>'+
													'<span class="stateType">'+ stateType +
												'</a>';
								fragment.appendChild(li);
							}
						},
						error:function(xhr,type,errorThrown){
							mui.toast("网络繁忙");
						}
					});
					return fragment;
				};
				//切换时的页面内容填充
				//var html1 = '<ul class="mui-table-view"><li class="mui-table-view-cell mui-media"><a href="order-details.html"><img class="mui-media-object mui-pull-left" src="${obj.attachmentFile}"><div class="mui-media-body"><p class="order-title">五金件安装</p><p class="mui-ellipsis">2017-06-05 17:50</p></div><span class="stateType">审<br />核<br />中</span></a></li></ul>';
				var item1 = document.getElementById('item1mobile');
				//打开此页面时第一屏的页面内容
				if(item1.querySelector('.mui-loading')) {
					setTimeout(function() {
						var ul = document.querySelector('.mui-table-view');
						ul.innerHTML='';
						ul.appendChild(createFragment(ul,1,10));
					}, 500);
				}
				//点击导航栏时的事件
				/* document.getElementById('slider').addEventListener('slide', function(e) {
					//第二屏的页面内容
					if(e.detail.slideNumber === 1) {
						if(item2.querySelector('.mui-loading')) {
							setTimeout(function() {
								item2.querySelector('.mui-table-view').innerHTML = html2;
							}, 500); 
						}
					//第三屏的页面内容
					} else if(e.detail.slideNumber === 2) {
						if(item3.querySelector('.mui-loading')) {
							setTimeout(function() {
								item3.querySelector('.mui-table-view').innerHTML = html3;
							}, 500);
						}
					//第四屏的页面内容
					} else if(e.detail.slideNumber === 3) {
						if(item4.querySelector('.mui-loading')) {
							setTimeout(function() {
								//item4.querySelector('.mui-table-view').innerHTML = html4;
							}, 500);
						}
					//第五屏的页面内容
					} else if(e.detail.slideNumber === 4) {
						if(item5.querySelector('.mui-loading')) {
							setTimeout(function() {
								//item5.querySelector('.mui-table-view').innerHTML = html5;
							}, 500);
						}
					}
				}); */
			})(mui);
		</script>
	</body>

</html>