<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>我要报修</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" href="${ctx}/public/celerepair/css/mui.min.css">
		<link rel="stylesheet" type="text/css" href="https://at.alicdn.com/t/font_n5o6ioc4rv8to6r.css"/>
		<link rel="stylesheet" href="${ctx}/public/celerepair/css/css/mui.picker.css"  />
		<link rel="stylesheet" href="${ctx}/public/celerepair/css/css/mui.poppicker.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/public/celerepair/css/css/mui.picker.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/public/celerepair/upload/webuploader.css" />
		<style>
			html,body{background-color:#efeff4}.mui-off-canvas-left{color:#fff}.title{margin:35px 15px 10px}.title+.content{margin:10px 15px 35px;color:#bbb;text-indent:1em;font-size:14px;line-height:24px}#offCanvasSideScroll{padding-top:44px}.f-white{color:#fff!important}.f-14{font-size:14px!important}.bg-orange{background-color:#ff5700!important}.mui-bar{background-color:#ff5700}.f-orange{color:#ff5700!important}.f-blank{color:#000!important}.content{padding:0 15px}.content .about{padding:10px 0 10px}.orderNew{padding:0 15px}.mui-icon{font-size:16PX}.orderNew .mui-table-view-cell:after{left:0}.order_new .mui-table-view-cell{padding:0;background:transparent}#submit{background:#ff5700;margin:0;padding:10px 0;border:transparent;color:#fff;border-radius:5px;width:100%}.mui-opacity{opacity:0}.mui-vertical{position:absolute;left:50%;-webkit-transform:translate(-50%,0);-ms-transform:translate(-50%,0);transform:translate(-50%,0)}.cross:after{position:absolute;content:'';width:45px;height:2px;background:#ccc;top:50%;left:50%;-webkit-transform:translate(-50%,-50%);-ms-transform:translate(-50%,-50%);transform:translate(-50%,-50%)}.cross:before{position:absolute;content:'';width:2px;height:45px;background:#ccc;top:50%;left:50%;-webkit-transform:translate(-50%,-50%);-ms-transform:translate(-50%,-50%);transform:translate(-50%,-50%)}.orderNew textarea{padding:5px;margin-bottom:0}#picture-list>.mui-btn:nth-child(4n+1){margin:0 -6px 1% 0}#picture-list>.mui-btn{margin:0 -6px 1%;margin-left:1%}#picture-list>a>img{position:absolute;top:0;left:0;width:100%;height:100%;z-index:1}.ui-alert{text-align:center;padding:20px 10px;font-size:16px}.mui-table-view{margin-bottom:10px}.iconfont{font-size:16px!important}
		</style>
	</head>
	<body>
		<div class="orderNew">
			<header class="mui-bar mui-bar-nav transparent mui-box-shadow-none">
				<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left f-white"></a>
				<h1 class="mui-title">我要报修</h1>
				<a href="message.html" class="mui-pull-right">
				</a>
			</header>
			<div id="offCanvasSideScroll" class="mui-scroll-wrapper mui-inner-wrap">
				<div class="mui-scroll">
					<div class="content">
						<form  id="objectContent">
							<input type="text" hidden id="addressId" name="addressId" value="${ address.id }"/>
							<input type="text" hidden id="serviceId" name="serviceId" value="" />
							<input type="text" hidden id="imgUrl" name="imgUrl" value="" />
							<input type="text" hidden id="shopId" name="shopId" value="" />
							<!-- <input type="datetime" hidden id="servicingTime" name="servicingTime" /> -->
							<p class="about  mui-text-center"><!-- 个人用户可在此报修， -->请填写需求内容<br />我们会尽快安排工作人员上门服务</p>
							<div class="mui-bar-nav">
								<ul class="mui-table-view">
									<c:choose>
								         <c:when test="${customer.customerType == 5}">  
								            <li class="mui-table-view-cell">
												<a href="${ctx}/backend/h5/user/doAddress?state=true" class="mui-navigate-right iconfont icon-iconfontaddress">
													报修地址 ：${ address.address }
												</a>
											</li>
								         </c:when>  
								         <c:when test="${customer.customerType == 3}">  
								            <li class="mui-table-view-cell" >
									            <a href="javascript:;" id="showUserPicker" class="mui-navigate-right mui-icon mui-icon-location">
													选择店铺：<strong id="userResult" ></strong>
												</a>
												
											</li>
								         </c:when>
								        <c:otherwise>  
											 <li class="mui-table-view-cell">
												<p class="mui-navigate-right mui-icon mui-icon-location">
													报修店铺:${ customer.customerName }
												</p>
											</li>
								        </c:otherwise>  
							   		 </c:choose>
								</ul>
							</div>
							<div class="mui-bar-nav" id="orderList">
								<ul class="mui-table-view list-0">
									<li class="mui-table-view-cell">
										<a href="javascript:;" class="mui-navigate-right iconfont icon-leixing showCityPicker">
											报修类型：<strong id="bxlx" ></strong>
										</a>
									</li>
									<!-- <li class="mui-table-view-cell demo3">
										<a href="javascript:;" id="demo3" data-options='{"value":"2017-06-10 10:10","beginYear":2017,"endYear":2025}' class="mui-navigate-right mui-icon mui-icon-location">
											上门时间：<strong id="smsj" ></strong>
										</a>
									</li> -->
									<li class="mui-table-view-cell">
										<div id="wrapper">
											<p class="order-title">你可以上传多张报修图片:</p>
											<div id="container">
												<!--头部，相册选择和格式选择-->
												<div id="uploader">
													<div class="queueList">
														<div id="dndArea" class="placeholder">
															<div id="filePicker"></div>
														</div>
													</div>
													<div class="statusBar" style="display:none;">
														<div class="btns">
															<div id="filePicker2"></div>
															<div class="uploadBtn">开始上传</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</li>
									<li class="mui-table-view-cell">
										<p class="order-title">请对报修项目进行描述:</p>
										<textarea id="caseDesc"  name="caseDesc" rows="5" cols="5"></textarea>
									</li>
								</ul>
							</div>
							<br />
							<div class="order_new">
								<ul class="mui-table-view">
									<li class="mui-table-view-cell">
										<input type="button" id="submit" value="确认下单" class="mui-text-center" />
										<!-- <a href="javascript:;" id="submit" class="mui-text-center">确认下单</a> -->
									</li>
								</ul>
							</div>
						</form>
					</div>
				</div>
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
		<script type="text/javascript" src="${ctx}/public/celerepair/js/mui.min.js"></script>
		<script type="text/javascript" src="${ctx}/public/celerepair/js/js/mui.picker.js"></script>
		<script type="text/javascript" src="${ctx}/public/celerepair/js/js/mui.poppicker.js"></script>
		<script type="text/javascript" src="${ctx}/public/celerepair/js/js/mui.picker.min.js"></script>
		<script type="text/javascript" src="${ctx}/public/celerepair/upload/jquery.js"></script>
		<script type="text/javascript" src="${ctx}/public/celerepair/upload/webuploader.js"></script>
		<script type="text/javascript" src="${ctx}/public/celerepair/upload/html2canvas.js"></script>
		<script type="text/javascript" src="${ctx}/public/celerepair/upload/upload.js"></script>
		<script>
			mui.init({
				swipeBack: true //启用右滑关闭功能
			});
			//开启A标签的跳转
			mui('body').on('tap', 'a', function() {
				window.top.location.href = this.href;
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
			//初始化单页的区域滚动
			mui('.mui-scroll-wrapper').scroll();

			mui('body').on('shown', '.mui-popover', function(e) {
				//console.log('shown', e.detail.id);//detail为当前popover元素
			});
			mui('body').on('hidden', '.mui-popover', function(e) {
				//console.log('hidden', e.detail.id);//detail为当前popover元素
			});

			mui('body').on('tap', '.crossClick', function() {
				var a = this,
					parent;
				//根据点击按钮，反推当前是哪个actionsheet
				for(parent = a.parentNode; parent != document.body; parent = parent.parentNode) {
					if(parent.classList.contains('mui-popover-action')) {
						break;
					}
				}
				//关闭actionsheet
				mui('#' + parent.id).popover('toggle');
			})

			//控制上传图片的自适应宽度
			mui(function($) {
				var arr = document.querySelectorAll('.cross');
				for(var i = 0; i < arr.length; i++) {
					arr[i].style.padding = "12%";
				}

			});

	document.getElementById('submit').addEventListener('click',function(){
				if(${customer.customerType == 5}){
					if($("#addressId").val() == ''){
						mui.toast("请选择地址");
						return false;
					}
				}else if(${customer.customerType == 3}){
					if($("#shopId").val()==''){
						mui.toast("请选择店铺");
						return false;
					}
				}
				if($("#serviceId").val()==''){
					mui.toast("请选择服务类型");
					return false;
				}if($("#imgUrl").val()==''){
					mui.toast("请先上传照片");
					return false;
				}
				/* if($("#servicingTime").val()==''){
				mui.toast("请选择上门时间");
				return false;
				} */
				mui.ajax('${ctx}/backend/h5/case/saveCase',{
					data:$('#objectContent').serialize(),
					type:'post',//HTTP请求类型
					dataType:'json',
					//timeout:10000,//超时时间设置为10秒；
					success:function(data){
						mui.toast(data.msg);
						if(data.msgCode=="0000"){
							window.location.href = "${ctx}/backend/h5/case/doCaseOne?caseId="+data.data;
						}
					},
					error:function(xhr,type,errorThrown){
						console.log(type);
					}
				});
			});
			
			/* (function($, doc) {
				$.init();
				$.ready(function() {
					//普通示例
					var userPicker = new $.PopPicker();
					userPicker.setData(${ shopList });
					var showUserPickerButton = doc.getElementById('showUserPicker');
					var userResult = doc.getElementById('userResult');
					showUserPickerButton.addEventListener('tap', function(event) {
						userPicker.show(function(items) {
							userResult.innerHTML ="&nbsp;" + items[0].text;
							doc.getElementById('shopId').value = items[0].value;
						});
					}, false);
					
				});
			})(mui, document) */
		</script>
	</body>

</html>