<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>首页</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link rel="stylesheet" href="${ctx}/public/celerepair/css/mui.min.css">
<link rel="stylesheet" type="text/css"
	href="${ctx}/public/celerepair/css/icons-extra.css" />
<style>
html, body {
	background-color: #efeff4;
}
/*p {
				text-indent: 22px;
			}*/
span.mui-icon {
	font-size: 20px;
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
/*个人中心头像部分*/
.userPic {
	position: absolute;
	top: 50%;
	left: 50%;
	-webkit-transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	transform: translate(-50%, -50%);
}

.userPic>div {
	margin: 5px 0;
}

.userPic a {
	background-color: #000;
	color: #fff;
	margin-top: 5px;
	position: relative;
	padding: 2px 20px;
	border-radius: 15px;
}

.userPic .mui-navigate-right:after {
	right: 5px
}

.userImg {
	width: 80px;
	border-radius: 50%;
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

.mui-repair-left {
	margin-right: 4%;
	background: #e0b6b6;
}

.mui-repair-right {
	margin-left: -6px
}

.mui-inline-block {
	display: inline-block !important;
}

.textA {
	vertical-align: middle
}

.f-white {
	color: #fff !important
}

.f-blank {
	color: #000 !important
}

.f-essential {
	color: #c5c5c5 !important;
	font-weight: bold
}

.f-14 {
	font-size: 14px !important;
}

.bg-orange {
	background-color: #ff5700 !important
}

.bg-white {
	background-color: #fff !important
}

.order-null {
	text-align: center;
	padding-top: 10%;
}

.transparent {
	background: transparent
}

.grad {
	background: -webkit-linear-gradient(rgba(0, 0, 0, 0.54),
		rgba(255, 255, 255, 0));
	/* Safari 5.1 - 6.0 */
	background: -o-linear-gradient(rgba(0, 0, 0, 0.54),
		rgba(255, 255, 255, 0));
	/* Opera 11.1 - 12.0 */
	background: -moz-linear-gradient(rgba(0, 0, 0, 0.54),
		rgba(255, 255, 255, 0));
	/* Firefox 3.6 - 15 */
	background: linear-gradient(rgba(0, 0, 0, 0.54), rgba(255, 255, 255, 0))
		/* 标准的语法 */
}

header a {
	color: #fff
}

.mui-bar .mui-icon {
	font-size: 22px;
	padding-top: 11px;
	padding-bottom: 11px;
}

.mui-box-shadow {
	box-shadow: 0 4px 10px rgba(119, 119, 119, 0.3);
}

.user .mui-card {
	margin: 0 0 2px 0
}

.stateType {
	position: absolute;
	top: 50%;
	right: 15px;
	border: 1px solid #a5a5a5;
	padding: 2px 8px;
	border-radius: 5px;
	color: #a5a5a5;
	line-height: 20px;
	-webkit-transform: translate(0, -50%);
	-ms-transform: translate(0, -50%);
	transform: translate(0, -50%);
}

.order-list .mui-table-view-cell:after {
	display: none;
}

.order-list .mui-card {
	box-shadow: none;
}

.order-list .order-title {
	color: #000;
	margin-top: 6px
}

.imgWidth {
	width: 52px
}
</style>
</head>
<body>
	<div id="offCanvasWrapper" class="mui-off-canvas-wrap mui-draggable">
		<!--侧滑菜单部分-->
		<aside id="offCanvasSide" class="mui-off-canvas-left">
			<header class="mui-bar mui-bar-nav transparent mui-box-shadow-none">
				<a href="" class="mui-icon mui-icon-left-nav mui-pull-left"></a>
				<h1 class="mui-title">${ customer.customerName }</h1>
				<a href="${ctx}/backend/h5/list/tidingsList?id=${customer.id}" class="mui-pull-right"> <span
					class="mui-icon mui-icon-chatbubble"></span>
				</a>
			</header>
			<div id="offCanvasSideScroll" class="mui-scroll-wrapper user">
				<div class="mui-scroll">
					<div class="mui-card">
						<div class="mui-card-content">
							<img src="${ctx}/public/celerepair/images/cbd.jpg" alt="" width="100%" />
						</div>
						<div class="userPic mui-text-center">
							<c:if test="${ empty customer.photoUrl }">
								<img class="userImg" id="userImg" src="${ctx}/public/celerepair/images/ice-repair.png" />
							</c:if>
							<c:if test="${ not empty customer.photoUrl }">
								<img class="userImg" id="userImg" src="${customer.photoUrl}" />
							</c:if>
							<div>
								名称:<span>${ customer.customerName }</span>
							</div>
							<a href="${ctx}/page/h5/personal.jsp" class="mui-block mui-navigate-right">
								<div>编辑资料</div>
							</a>
						</div>
					</div>
					<ul
						class="mui-table-view mui-table-view-chevron mui-table-view-inverted">
						<li class="mui-table-view-cell"><a
							href="${ctx}/backend/h5/case/doOrder" class="mui-navigate-right">
								我的订单 </a></li>
						<c:if test="${customer.customerType == 5}">
							<li class="mui-table-view-cell"><a
								href="${ctx}/backend/h5/user/doAddress"
								class="mui-navigate-right"> 地址管理 </a></li>
						</c:if>
					</ul>
					<br />
					<ul class="mui-table-view mui-table-view-chevron mui-table-view-inverted">
						<li class="mui-table-view-cell"><a
							href="${ctx}/page/h5/feedback.jsp" class="mui-navigate-right">
								意见反馈 </a></li>
						<li class="mui-table-view-cell"><a href="javascript:;"
							class="mui-navigate-right tel"> 客服热线 </a></li>
						<li class="mui-table-view-cell"><a
						href="${ctx}/page/h5/about.jsp" class="mui-navigate-right">
							关于快修 </a></li>
					</ul>
					<%--<br />
					 <ul
						class="mui-table-view mui-table-view-chevron mui-table-view-inverted">
						<li class="mui-table-view-cell"><a href="javascript:;"
							class="mui-navigate-right tel" > 清除缓存 </a></li>
						<li class="mui-table-view-cell"><a
							href="${ctx}/page/h5/about.jsp" class="mui-navigate-right">
								关于快修 </a></li>
					</ul> --%>
				</div>
			</div>
		</aside>
		<!--主界面部分-->
		<div class="mui-inner-wrap">
			<div class="mui-scroll-wrapper">
				<div class="mui-scroll">
					<!--头部信息-->
					<header class="mui-bar mui-bar-nav grad">
						<span class="mui-icon mui-icon-location mui-pull-left f-white"></span>
						<a class=" mui-btn mui-btn-link mui-pull-left f-white">上海市</a>
						<a href="${ctx}/backend/h5/list/tidingsList?id=${customer.id}" class="mui-pull-right"> 
							<span class="mui-icon mui-icon-chatbubble"></span>
						</a>
					</header>
					<!--轮播图-->
					<div id="slider" class="mui-slider">
						<div class="mui-slider-group mui-slider-loop">
							<!-- 额外增加的一个节点(循环轮播：第一个节点是最后一张轮播) -->
							<div class="mui-slider-item mui-slider-item-duplicate"></div>
							<c:choose>
								<c:when test="${not empty adList}">
									<c:forEach items="${adList}" var="ad">
										<div class="mui-slider-item">
											<a href="${ad.adLink}"> <img src="${ad.adUrl}"></a>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="mui-slider-item">
										<a href="#"> <img
											src="${ctx}/public/celerepair/images/1.png">
										</a>
									</div>
									<div class="mui-slider-item">
										<a href="#"> <img
											src="${ctx}/public/celerepair/images/2.png">
										</a>
									</div>
									<div class="mui-slider-item">
										<a href="#"> <img
											src="${ctx}/public/celerepair/images/3.png">
										</a>
									</div>
									<div class="mui-slider-item">
										<a href="#"> <img
											src="${ctx}/public/celerepair/images/4.png">
										</a>
									</div>
									<div class="mui-slider-item">
										<a href="#"> <img
											src="${ctx}/public/celerepair/images/5.png">
										</a>
									</div>
								</c:otherwise>
							</c:choose>
							<!-- 额外增加的一个节点(循环轮播：最后一个节点是第一张轮播) -->
							<div class="mui-slider-item mui-slider-item-duplicate"></div>
						</div>
						<div class="mui-slider-indicator">
							<div class="mui-indicator mui-active"></div>
							<div class="mui-indicator"></div>
							<div class="mui-indicator"></div>
							<div class="mui-indicator"></div>
							<div class="mui-indicator"></div>
						</div>
					</div>
					<div class="mui-content-padded">
						<a href="${ctx}/backend/h5/case/addCase">
							<button type="button"
								class="mui-repair mui-repair-left mui-box-shadow">
								<img src="${ctx}/public/celerepair/images/ice-repair.png"
									class="imgWidth" /> <span class="textA">我要报修</span>
							</button>
						</a>
						<button type="button" id="offCanvasShow"
							class="mui-repair mui-repair-right mui-box-shadow">
							<img src="${ctx}/public/celerepair/images/ice-personal.png"
								class="imgWidth" /> <span class="textA">个人中心</span>
						</button>
					</div>
					<div class="order-list">
						<!--订单为空时额样式布局-->
						<c:if test="${ caseList == '' }">
							<div class="order-null">
								<img src="${ctx}/public/celerepair/images/ice-null.png" />
								<div class="f-essential">暂无进行中订单</div>
							</div>
						</c:if>
						<!--有订单时的布局样式-->
						<c:if test="${ caseList != '' }">
							<div class="mui-text-center">
								<span class="mui-icon-extra mui-icon-extra-lamp"></span>
								<p class="f-blank">进行中订单</p>
							</div>
							</c:if>
							<div class="mui-card transparent" style="margin-bottom: 35px;">
								<ul id="objList" class="mui-table-view mui-table-view-chevron transparent">
									<c:forEach var="obj" items="${ caseList }">
										<li class="mui-table-view-cell mui-media bg-white">
											<a href="${ctx}/backend/h5/case/doCaseOne?caseId=${ obj.id }">
												<img class="mui-media-object mui-pull-left" src="${ obj.attachmentFile }">
												<div class="mui-media-body">
													<p class="order-title">${ obj.claimCode }</p>
													<p class="mui-ellipsis">${ obj.createTime }</p>
												</div>
												<span class="stateType">
												<c:choose>
												    <c:when test="${ obj.caseStatus == -1 && obj.customerType == 5}">
														 待<br />接<br />单
												    </c:when>
												    <c:when test="${ obj.caseStatus == -1 && obj.customerType != 5}">
														 审<br />核<br />中
												    </c:when>
												    <c:when test="${ obj.caseStatus == 0 || obj.caseStatus == 1 || obj.caseStatus == 2 }">
														 待<br />上<br />门
												    </c:when>
													<c:when test="${ obj.caseStatus == 3 && obj.customerType != 5}">
														待<br />审<br />批
												    </c:when>
													<c:when test="${ obj.caseStatus == 3 && obj.customerType == 5}">
														 待<br />付<br />款
												    </c:when>
													<c:when test="${ obj.caseStatus == 4 && empty obj.assessScore }">
												  		待<br />评<br />价
												    </c:when>
													<c:otherwise>
												  		已<br />完<br />成
												    </c:otherwise>
												</c:choose>
										</span>
									</a></li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div> 
	</div>
	<script src="${ctx}/public/celerepair/js/mui.min.js"></script>
	<script>
		mui.init();
		//侧滑容器父节点
		var offCanvasWrapper = mui('#offCanvasWrapper');
		//主界面容器
		var offCanvasInner = offCanvasWrapper[0]
				.querySelector('.mui-inner-wrap');
		//菜单容器
		var offCanvasSide = document.getElementById("offCanvasSide");
		if (!mui.os.android) {
			var spans = document.querySelectorAll('.android-only');
			for (var i = 0, len = spans.length; i < len; i++) {
				spans[i].style.display = "none";
			}
		}
		//移动效果是否为整体移动
		var moveTogether = false;
		//侧滑容器的class列表，增加.mui-slide-in即可实现菜单移动、主界面不动的效果；
		var classList = offCanvasWrapper[0].classList;
		//变换侧滑动画移动效果；
		offCanvasSide.classList.remove('mui-transitioning');
		offCanvasSide.setAttribute('style', '');
		classList.remove('mui-slide-in');
		classList.remove('mui-scalable');
		classList.add('mui-slide-in');
		offCanvasWrapper.offCanvas().refresh();
		//主界面和侧滑菜单界面均支持区域滚动；
		mui('#offCanvasSideScroll').scroll();
		mui('#offCanvasContentScroll').scroll();
		//主界面‘显示侧滑菜单’按钮的点击事件
		document.getElementById('offCanvasShow').addEventListener('tap',
				function() {
					if ('${customer}' == '') {
						window.location.href = "${ctx}/page/h5/login.jsp"
					}
					offCanvasWrapper.offCanvas('show');
				}

		);
		//实现ios平台原生侧滑关闭页面；
		if (mui.os.plus && mui.os.ios) {
			mui.plusReady(function() {
				//5+ iOS暂时无法屏蔽popGesture时传递touch事件，故该demo直接屏蔽popGesture功能
				plus.webview.currentWebview().setStyle({
					'popGesture' : 'none'
				});
			});
		}
		if ('${customer}' == '') {
			offCanvasInner.addEventListener('drag', function(event) {
				mui.toast("您还未登录!");
			    event.stopPropagation();
			});
		}
		
		//自动播放轮播图
		mui(function(e) {
			mui("#slider").slider({
				interval : 4000
			})
		}
		)
		//
		mui(function($) {
			$(".mui-scroll-wrapper").scroll({
			//bounce: false,//滚动条是否有弹力默认是true
			//indicators: false, //是否显示滚动条,默认是true
			});

		});
		//开启A标签的跳转
		mui('body').on('tap', 'a', function() {
			window.top.location.href = this.href;
		});
		//电话号码
			mui('body').on('tap', '.tel', function() {
				if(this.innerText == "客服热线") {
					var btnArray = ['取消', '拨打'];
					mui.confirm('${contactUs.phone}', '您确定拨打电话吗？', btnArray, function(e) {
						if(e.index == 1) {
							window.location.href = 'tel:${contactUs.phone}';
						} else {
							//info.innerText = 'MUI没有得到你的认可，继续加油'
						}
					})
				} else if(this.innerText == "清除缓存") {
					var btnArray = ['取消', '确定'];
					mui.confirm('您确定清除缓存吗？', '温馨提示', btnArray, function(e) {
						if(e.index == 1) {
							//window.location.href = 'tel:400-888-888';
						} else {
							//info.innerText = 'MUI没有得到你的认可，继续加油'
						}
					})
				}
			});
	</script>
</body>

</html>