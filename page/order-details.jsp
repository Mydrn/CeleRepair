<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>订单详情</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" href="../../../public/celerepair/css/mui.min.css" type="text/css">
		<link rel="stylesheet" href="../../../public/celerepair/css/icons-extra.css" type="text/css" />
		<style>
			body,html{background-color:#efeff4;font-size:14px}.title{margin:35px 15px 10px}.title+.content{margin:10px 15px 35px;color:#bbb;text-indent:1em;font-size:14px;line-height:24px}.f-white{color:#fff!important}.f-orange{color:#ff5700!important}.f-14{font-size:14px!important}.bg-white{background:#fff}.bg-orange{background:#ff5700!important}.userPic{position:absolute;top:50%;left:50%;-webkit-transform:translate(-50%,-50%);-ms-transform:translate(-50%,-50%);transform:translate(-50%,-50%)}#offCanvasSideScroll{padding-top:44px}.content{margin:0 15px 10px;padding:40px 0;position:relative;overflow:hidden;z-index:1}.order-line{float:left;position:relative;width:20%;text-align:center}.order-line img{width:50%}.order-line p{position:absolute;top:-20px;left:50%;-webkit-transform:translate(-50%,0);-ms-transform:translate(-50%,0);transform:translate(-50%,0);font-size:12px;width:100%}#line-active,.line{position:absolute;left:0;top:50%;-webkit-transform:translate(0,-50%);-ms-transform:translate(0,-50%);transform:translate(0,-50%);width:100%;height:4px;z-index:-2;background-color:#ccc}#line-active{background:#ff5700;z-index:-1;width:50%}.active p{top:98%;color:#ff5700}.order-img ul{padding:0}.low{padding-bottom:44px}.order-img li{float:left;list-style:none;width:25%;padding:0 5px 10px 5px}.order-img ul li img{width:100%;height:100%;min-width:100%;min-height:100%}.bottom_tel{position:fixed;bottom:0;left:0;right:0;color:#ccc;border-top:1px solid #f5f5f5}#tel{background:#ff5700;color:#fff}tbody td{overflow:hidden;white-space:nowrap;text-overflow:ellipsis;}.active img{animation:myfirst 6s linear infinite;-moz-animation:myfirst 6s linear infinite;-webkit-animation:myfirst 6s linear infinite;-o-animation:myfirst 6s linear infinite}@keyframes myfirst{from{transform:rotate(0);-ms-transform:rotate(0);-webkit-transform:rotate(0);-o-transform:rotate(0);-moz-transform:rotate(0)}to{transform:rotate(360deg);-ms-transform:rotate(360deg);-webkit-transform:rotate(360deg);-o-transform:rotate(360deg);-moz-transform:rotate(360deg)}}@-moz-keyframes myfirst{from{transform:rotate(0);-ms-transform:rotate(0);-webkit-transform:rotate(0);-o-transform:rotate(0);-moz-transform:rotate(0)}to{transform:rotate(360deg);-ms-transform:rotate(360deg);-webkit-transform:rotate(360deg);-o-transform:rotate(360deg);-moz-transform:rotate(360deg)}}@-webkit-keyframes myfirst{from{transform:rotate(0);-ms-transform:rotate(0);-webkit-transform:rotate(0);-o-transform:rotate(0);-moz-transform:rotate(0)}to{transform:rotate(360deg);-ms-transform:rotate(360deg);-webkit-transform:rotate(360deg);-o-transform:rotate(360deg);-moz-transform:rotate(360deg)}}@-o-keyframes myfirst{from{transform:rotate(0);-ms-transform:rotate(0);-webkit-transform:rotate(0);-o-transform:rotate(0);-moz-transform:rotate(0)}to{transform:rotate(360deg);-ms-transform:rotate(360deg);-webkit-transform:rotate(360deg);-o-transform:rotate(360deg);-moz-transform:rotate(360deg)}}
			.mui-preview-image.mui-fullscreen {
				position: fixed;
				z-index: 20;
				background-color: #000;
			}
			.mui-preview-header,
			.mui-preview-footer {
				position: absolute;
				width: 100%;
				left: 0;
				z-index: 10;
			}
			.mui-preview-header {
				height: 44px;
				top: 0;
			}
			.mui-preview-footer {
				height: 50px;
				bottom: 0px;
			}
			.mui-preview-header .mui-preview-indicator {
				display: block;
				line-height: 25px;
				color: #fff;
				text-align: center;
				margin: 15px auto 4px;
				width: 70px;
				background-color: rgba(150, 150, 150, 0.4);
				border-radius: 12px;
				font-size: 16px;
			}
			.mui-preview-image {
				display: none;
				-webkit-animation-duration: 0.5s;
				animation-duration: 0.5s;
				-webkit-animation-fill-mode: both;
				animation-fill-mode: both;
			}
			.mui-preview-image.mui-preview-in {
				-webkit-animation-name: fadeIn;
				animation-name: fadeIn;
			}
			.mui-preview-image.mui-preview-out {
				background: none;
				-webkit-animation-name: fadeOut;
				animation-name: fadeOut;
			}
			.mui-preview-image.mui-preview-out .mui-preview-header,
			.mui-preview-image.mui-preview-out .mui-preview-footer {
				display: none;
			}
			.mui-zoom-scroller {
				position: absolute;
				display: -webkit-box;
				display: -webkit-flex;
				display: flex;
				-webkit-box-align: center;
				-webkit-align-items: center;
				align-items: center;
				-webkit-box-pack: center;
				-webkit-justify-content: center;
				justify-content: center;
				left: 0;
				right: 0;
				bottom: 0;
				top: 0;
				width: 100%;
				height: 100%;
				margin: 0;
				-webkit-backface-visibility: hidden;
			}
			.mui-zoom {
				-webkit-transform-style: preserve-3d;
				transform-style: preserve-3d;
			}
			.mui-slider .mui-slider-group .mui-slider-item img {
				width: auto;
				height: auto;
				max-width: 100%;
				max-height: 100%;
			}
			.mui-android-4-1 .mui-slider .mui-slider-group .mui-slider-item img {
				width: 100%;
			}
			.mui-android-4-1 .mui-slider.mui-preview-image .mui-slider-group .mui-slider-item {
				display: inline-table;
			}
			.mui-android-4-1 .mui-slider.mui-preview-image .mui-zoom-scroller img {
				display: table-cell;
				vertical-align: middle;
			}
			.mui-preview-loading {
				position: absolute;
				width: 100%;
				height: 100%;
				top: 0;
				left: 0;
				display: none;
			}
			.mui-preview-loading.mui-active {
				display: block;
			}
			.mui-preview-loading .mui-spinner-white {
				position: absolute;
				top: 50%;
				left: 50%;
				margin-left: -25px;
				margin-top: -25px;
				height: 50px;
				width: 50px;
			}
			.mui-preview-image img.mui-transitioning {
				-webkit-transition: -webkit-transform 0.5s ease, opacity 0.5s ease;
				transition: transform 0.5s ease, opacity 0.5s ease;
			}
			@-webkit-keyframes fadeIn {
				0% {
					opacity: 0;
				}
				100% {
					opacity: 1;
				}
			}
			@keyframes fadeIn {
				0% {
					opacity: 0;
				}
				100% {
					opacity: 1;
				}
			}
			@-webkit-keyframes fadeOut {
				0% {
					opacity: 1;
				}
				100% {
					opacity: 0;
				}
			}
			@keyframes fadeOut {
				0% {
					opacity: 1;
				}
				100% {
					opacity: 0;
				}
			}
			p img {
				max-width: 100%;
				height: auto;
			}
		
		</style>
	</head>
	<body>
		<div id="">
			<header class="mui-bar mui-bar-nav transparent mui-box-shadow-none">
				<a href="${ctx}/backend/h5/user/doIndexList" class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left f-white"></a>
				<h1 class="mui-title">订单详情</h1>
				<a href="${ctx}/page/h5/message.jsp" class="mui-pull-right"></a>
			</header>
			<div id="offCanvasSideScroll" class="mui-scroll-wrapper">
			<div class="low">
				<div class="bg-white">
					<div class="content">
						<div class="order-line" style="text-align: left;">
							<img src="../../../public/celerepair/images/already-order.png" />
							<p>已下单</p>
						</div>
						<div class="order-line">
							<c:if test="${obj.customerType == 5 }">
								<p>待接单</p>
							</c:if>
							<c:if test="${obj.customerType != 5 }">
								<p>待审核</p>
							</c:if>
							<img src="../../../public/celerepair/images/not-audit.png" />
						</div>
						<div class="order-line">
							<p>待上门</p>
							<img src="../../../public/celerepair/images/not-visit.png" />
						</div>
						<div class="order-line">
							<c:if test="${obj.customerType == 5 }">
								<p>待付款</p>
							</c:if>
							<c:if test="${obj.customerType != 5 }">
								<p>待审批</p>
							</c:if>
							<img src="../../../public/celerepair/images/not-pay.png" />
						</div>
						<div class="order-line" style="text-align: right;">
							<p>待评价</p>
							<img src="../../../public/celerepair/images/not-evaluate.png" />
						</div>
						<span class="line"></span>
						<span id="line-active"></span>
					</div>
				</div>
				<div class="">
					<ul class="mui-table-view">
						<li class="mui-table-view-cell mui-media bg-white">
							订单详情
						</li>
						<li class="mui-table-view-cell mui-media bg-white">
							<table border="0" cellspacing="0" cellpadding="0" style="width:100%;table-layout: fixed;">
								<tbody>
									<tr>
										<td style="width:18%">订单编号:</td>
										<td style="width:80%">${ obj.claimCode }</td>
									</tr>
									<tr>
										<td style="width:18%">下单时间:</td>
										<td style="width:80%">${ obj.createTime }</td>
									</tr>
									<tr>
									<%-- <td>名称:</td>
										<c:if test="${customer.customerType == 5}">${ address.name }</c:if>
										<c:if test="${customer.customerType != 5}">${ address.customerName }</c:if>
									</tr> --%>
									<tr>
										<td>地址:</td>
										<td>${ obj.proName }${ obj.regiontName }${ obj.cityName }${ address.address }</td>
									</tr>
									<tr>
										<td>联系人:</td>
										<td>
											<c:if test="${customer.customerType == 5}">${ address.name }</c:if>
											<c:if test="${customer.customerType != 5}">${ address.customerName }</c:if>
										</td>
									</tr>
									<tr>
										<td>联系电话:</td>
										<td>${ address.mobile }</td>
									</tr>
								</tbody>
							</table>
						</li>
						<li class="mui-table-view-cell mui-media bg-white">
							报修描述:${ obj.caseDesc }
						</li>
						<li class="mui-table-view-cell mui-media bg-white">
							报修照片:
							<div class="order-img">
								<ul>
								<c:forEach items="${ attachmentList }" var="obj">
									<li><img src="${ obj.attachmentUrl }" data-preview-src="${ obj.attachmentUrl }" data-preview-group="1" /></li>
								</c:forEach>
								</ul>
							</div>
						</li>
					</ul>
				</div>
				</div>
				<div class="bottom_tel">
					<ul class="mui-table-view">
						<li class="mui-table-view-cell">
							<a href="tel:15000946761" id="submit" class="mui-text-center bg-orange f-white">
								联系客服
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div id="picture" class="mui-popover mui-popover-action mui-popover-bottom">
			<ul class="mui-table-view">
				<li class="mui-table-view-cell">
					<a id="weixin" href="javascript:;">微信支付</a>
				</li>
				<li class="mui-table-view-cell">
					<a id="zhifubao" href="javascript:;">模拟支付</a>
				</li>
			</ul>
			<ul class="mui-table-view">
				<li class="mui-table-view-cell">
					<a href="#picture" class=""><span>取消</span></a>
				</li>
			</ul>
		</div>
		<script src="${ctx}/public/celerepair/js/mui.min.js"></script>
		<script src="${ctx}/public/celerepair/js/js/mui.zoom.js"></script>
		<script src="${ctx}/public/celerepair/js/js/mui.previewimage.js"></script>
		<script>
			//主界面和侧滑菜单界面均支持区域滚动；
			mui('#offCanvasSideScroll').scroll();
			mui('#offCanvasContentScroll').scroll();
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
			};
			document.getElementById('weixin').addEventListener('tap',function(){
				mui.ajax('${ctx}/backend/h5/pay/payment',{
					data:{
						total:'${ obj.caseActualMoney }',
						caseId:'${ obj.id }',
						claimCode:'${ obj.claimCode }'
					},
					type:'post',//HTTP请求类型
					dataType:'json',
					timeout:5000,//超时时间设置为5秒；
					success:function(data){
						console.log(data);
						console.log('https://wx.tenpay.com/cgi-bin/mmpayweb-bin/checkmweb?prepay_id='+data.reslt.prepayId+'&package='+ data.param.package +'&redirect_url=https%3A%2F%2Fcelefix.mydrn.cn%2Fcelefix%2Fpage%2Fh5%2Forder-details.jsp');
						window.location.href = 'https://wx.tenpay.com/cgi-bin/mmpayweb-bin/checkmweb?prepay_id='+data.reslt.prepayId+'&package='+ data.param.package +'&redirect_url='+data.redirectUrl;
						/* if(data.msgCode=="0000"){
							window.location.href = "${ctx}/backend/h5/user/doIndexList";
						} */
					},error:function(xhr,type,errorThrown){
						mui.toast("网络繁忙,请重试！");
						console.log(type);
					}
				});
			});
			document.getElementById('zhifubao').addEventListener('tap',function(){
				mui.ajax('${ctx}/backend/h5/pay/orderQuery',{
					data:{caseId:'${ obj.id }'},
					type:'post',//HTTP请求类型
					dataType:'json',
					timeout:500,//超时时间设置为5秒；
					success:function(data){
						console.log(data);
						if(data.msgCode == "0000"){
							mui.alert(data.msg, '提示', function() {
								window.location.href = "${ctx}/backend/h5/case/doCaseOne?caseId=${ obj.id }";
							});
						} 
					},error:function(xhr,type,errorThrown){
						mui.toast("网络繁忙,请重试！");
						console.log(type);
					}
				});
			});
			
			
			if(${obj.caseStatus == -1}){//待审核
				document.querySelector('.bottom_tel .mui-table-view-cell').innerHTML='<a href="${ctx}/backend/h5/case/addCase" id="submit" class="mui-text-center bg-orange f-white">继续下单</a>';
				cycle(0);
			}else if(${obj.caseStatus == 0 || obj.caseStatus==1 || obj.caseStatus==2 }){//待上门
				document.querySelector('.bottom_tel .mui-table-view-cell').innerHTML='<a href="tel:${contactUs.phone}" id="submit" class="mui-text-center bg-orange f-white">联系客服</a>';
				cycle(1);
			}else if(${obj.caseStatus == 3 && obj.customerType != 5 }){//待审批
				
				document.querySelector('.bottom_tel .mui-table-view-cell').innerHTML='<a href="tel:${contactUs.phone}" id="submit" class="mui-text-center bg-orange f-white">联系客服</a>';
				cycle(2);
			}else if(${obj.caseStatus == 3 && obj.customerType == 5 }){//待付款
				document.querySelector('.bottom_tel .mui-table-view-cell').innerHTML='<div class="text mui-pull-left">应付金额:<span class="f-orange">￥${ obj.caseActualMoney }</span></div><a href="#picture" id="tel" class="mui-text-center mui-pull-right"><span class="mui-icon-extra mui-icon-extra-gold f-14"> 去支付</span></a>';
				cycle(2);
			}else if(${obj.caseStatus == 4 && empty obj.assessScore }){//待评价
				document.querySelector('.bottom_tel .mui-table-view-cell').innerHTML='<a href="${ctx}/backend/h5/case/doEvaluation?caseId=${ obj.id }" id="submit" class="mui-text-center bg-orange f-white"><span class="mui-icon-extra mui-icon-extra-like f-14">待评价</span></a>';
				cycle(3);
			}else{//完成订单
				document.querySelector('.bottom_tel .mui-table-view-cell').innerHTML='<a href="JavaScript:;" id="submit" class="mui-text-center bg-orange f-white">已完成</a>';
				cycle(4);
			}
			//状态的封装
			function cycle(a,b) {
				var arr = document.querySelectorAll('.content .order-line img');
				var arr2 = document.querySelectorAll('.content .order-line');
				var arr3 = document.querySelectorAll('.bottom_tel');
				for(var i = 0; i <= a; i++) {
					document.querySelector('#line-active').style.width = 20 * (i+1) + 10 + "%";
					arr[i].setAttribute('src', arr[i].getAttribute('src').replace(/not/, "already"));
					arr[i].parentNode.querySelector('p').innerHTML=	arr[i].parentNode.querySelector('p').innerHTML.replace(/待/, "已");
				}
				arr2[i].classList.add('active');
			};
			//设置图片的平均分配宽度
			mui(function($) {
				var old = document.querySelectorAll('.order-img li');
				for(var i=0;i<old.length;i++){
					console.log(old[i].parentNode.parentNode);
					old[i].style.height=old[i].parentNode.parentNode.scrollWidth/4+"px";
				}
			});
			mui.previewImage();
			//开启A标签的跳转
			mui('body').on('tap', 'a', function() {
				window.top.location.href = this.href;
			});
			
		</script>
	</body>

</html>