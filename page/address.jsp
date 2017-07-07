<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>地址管理</title>
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
			
			#offCanvasSideScroll {
				padding-top: 44px
			}
			
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
			
			.f-blank {
				color: #000!important
			}
			
			.f-14 {
				font-size: 14px!important;
			}
			
			.bg-orange {
				background-color: #ff5700!important;
			}
			
			.userImg {
				position: absolute;
				top: 0;
				right: 40px;
				height: 43px;
				padding: 3px 0;
			}
			
			.mui-position-right {
				position: absolute;
				right: 40px;
			}
			
			.mui-bar {
				background-color: #ff5700
			}
			
			.f-orange {
				color: #ff5700!important
			}
			
			.content .about {
				padding: 10px 0 0;
			}
			/*控制退出的样式*/
			
			.exit .mui-table-view-cell {
				padding-right: 0
			}
			
			.exit .mui-table-view-cell>a:not(.mui-btn) {
				margin-right: 0
			}
			
			.mui-checkbox.mui-left label,
			.mui-radio.mui-left label {
				padding-left: 25px
			}
			
			.mui-checkbox.mui-left input[type=checkbox],
			.mui-radio.mui-left input[type=radio] {
				left: 0;
				top: 50%;
				width: 20px;
				height: 20px;
				-webkit-transform: translate(0, -50%);
				-ms-transform: translate(0, -50%);
				transform: translate(0, -50%);
			}
			
			.mui-checkbox input[type=checkbox]:before,
			.mui-radio input[type=radio]:before {
				font-size: 20px
			}
			
			.mui-checkbox input[type=checkbox]:checked:before,
			.mui-radio input[type=radio]:checked:before {
				color: #ff5700
			}
			
			.mui-card-content-inner {
				padding: 10px 15px
			}
		</style>
	</head>

	<body>
		<div id="">
			<header class="mui-bar mui-bar-nav transparent mui-box-shadow-none">
				<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left f-white"></a>
				<h1 class="mui-title">地址管理</h1>
				<a href="${ctx}/backend/h5/user/doOneAddress" class="mui-btn mui-btn-link mui-pull-right f-white">新增地址</a>
			</header>
			<div id="offCanvasSideScroll" class="mui-scroll-wrapper mui-inner-wrap">
				<div id="addressList" class="mui-scroll">
				<c:forEach var="obj" items="${ addressList }">
					<div class="mui-card">
						<form class="mui-input-group">
							<div class="mui-card-content" <c:if test="${ choose }"> onclick="back(${obj.id });"</c:if> >
								<div class="mui-card-content-inner">
									<table border="0" cellspacing="0" cellpadding="0" style="width:100%">
										<tbody>
											<tr>
												<td style="width:50%">联系人：${ obj.name }</td>
											</tr>
											<tr>
												<td style="width:50%">联系电话：${ obj.mobile }</td>
											</tr>
											<tr>
												<td colspan="2">联系地址：${ obj.address }</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="mui-card-footer">
								<a class="mui-card-link" href="javascript:;">
									<div class="mui-input-row mui-checkbox mui-left">
									<c:if test="${ obj.isDefault }">
										<label class="f-blank">默认地址</label>
										<input name="checkbox" value="${ obj.id }" class="checkbox" checked="checked" type="checkbox">
									</c:if>
									<c:if test="${!obj.isDefault }">
										<label class="f-blank">设为默认</label>
										<input name="checkbox" value="${ obj.id }" class="checkbox" type="checkbox">
									</c:if>
									</div>
								</a>
								<div class="mui-card-link">
									<a class="f-orange" href="${ctx}/backend/h5/user/doOneAddress?state=${choose}&id=${ obj.id }">
										<span class="mui-icon mui-icon-compose f-orange"></span> 编辑
									</a>
									<a class="f-blank del" id="${ obj.id }">
										<span class="mui-icon mui-icon-trash f-blank"></span> 删除
									</a>
								</div>
							</div>
						</form>
					</div>
					</c:forEach>
				</div>
			</div>
			<script src="${ctx}/public/celerepair/js/mui.min.js"></script>
			<!--<script type="text/javascript" src="../js/js/vconsole.min.js"></script>-->
			<script>
				mui.init({
					swipeBack: true //启用右滑关闭功能
				});
				//初始化单页的区域滚动
				mui('.mui-scroll-wrapper').scroll();
				//开启A标签的跳转
				mui('body').on('tap', 'a', function() {
					window.top.location.href = this.href;
				});
				function back(id) {
					window.location.href = "${ctx}/backend/h5/user/backOrder?id="+id;
				}
				mui(function($) {
					$('body').on('tap', '.del', function() {
						mui.get('${ctx}/backend/h5/user/delAddress',{id:this.id},function(data){
							console.log(data);
						});
						this.parentNode.parentNode.parentNode.parentNode.remove();
					});

					$('body').on('tap', '.checkbox', function() {
						var value = this.checked ? "true" : "false";
						mui.get('${ctx}/backend/h5/user/isDefault',{id:this.value,isDefault:value},function(data){
							console.log(data);
						});
						var checkArr = document.getElementsByClassName('checkbox');
						if(this.checked) {
							for(var i = 0; i < checkArr.length; i++) {
								checkArr[i].checked=false;
								checkArr[i].previousElementSibling.innerHTML = "设为默认";
								this.checked=true;
								this.previousElementSibling.innerHTML = "默认地址";
							}
						} else {
							this.previousElementSibling.innerHTML = "设为默认";
						}
					});
					
					
				})
			</script>
	</body>
</html>