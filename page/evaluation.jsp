<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>发布评价</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" href="${ctx}/public/celerepair/css/mui.min.css">
		<link rel="stylesheet" type="text/css" href="${ctx}/public/celerepair/css/icons-extra.css" />
		<style>
			#offCanvasSideScroll{padding-top:44px}.textA{vertical-align:middle}.f-white{color:#fff!important}.bg-white{background-color:#fff!important}.bg-orange{background-color:#ff5700!important}.f-orange{color:#ff5700!important}.mui-icon-star{font-size:20px}.mui-icon-star-filled{color:#ffb400;font-size:20px}[class^="evaluation-"]{padding:10px 15px}textarea{margin-bottom:0;border:transparent;padding:0}.lines,.line{display:block;border-top:1px solid #ccc;position:relative;margin-bottom:8px}.line:after{position:absolute;z-index:2;top:-8px;left:30px;font-family:"微软雅黑";content:'';width:16px;height:16px;border:1px solid #ccc;border-top-color:transparent;border-right-color:transparent;transform:rotate(135deg);-webkit-transform:rotate(135deg);-moz-transform:rotate(135deg);-ms-transform:rotate(135deg);background-color:#fff}.as{padding:0 0 5px;overflow:hidden}.mui-right{float:right}.file-box{margin-right:2px}.file{opacity:0;position:absolute;top:0;left:0;right:0;bottom:0;width:100%;height:100%}.file-box{display:inline-block;width:24%;position:relative;overflow:hidden;padding:40px;border:1px solid #ccc;-webkit-border-radius:10px;-moz-border-radius:10px;border-radius:10px}.file-box img{position:absolute;top:0;left:0;min-height: 100%;width:100%;z-index:1}.file-box:before{position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);font-family:"微软雅黑";content:'';width:2px;height:50%;background:#ccc}.file-box:after{position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);font-family:"微软雅黑";content:'';width:50%;height:2px;background:#ccc}.file-box:first-child{margin-right:-2px}.evaluation-head{margin-bottom:10px}.mui-content-padded{margin:0}
		</style>
	</head>
	<body>
		<div id="">
			<header class="mui-bar mui-bar-nav transparent mui-box-shadow-none">
				<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left f-white"></a>
				<h1 class="mui-title">发布评价</h1>
				<button id="submit" class="mui-btn mui-btn-blue mui-btn-link mui-pull-right f-white">提交</button>
			</header>
			<input id="OderId" hidden value="${obj.id}">
			<input type="text" hidden id="imgUrl" name="imgUrl" value="" />
			<div id="offCanvasSideScroll" class="mui-scroll-wrapper">
				<div class="mui-scroll">
					<div class="mui-content-padded">
						<div class="evaluation-head bg-white">
							<div class="as">  
								<div class="mui-inline">服务内容:</div>
								<div class="icons mui-inline" style="margin-left: 6px;">${obj.serviceName }</div>
							</div>
							<div class="as">
								<div class="mui-inline">订单编号:</div>
								<div class="icons mui-inline" style="margin-left: 6px;">${obj.claimCode }</div>
							</div>
						</div>
						<div class="evaluation-content bg-white">
							<div class="as">
								<div class="mui-inline">服务质量:</div>
								<div class="icons mui-inline" style="margin-left: 6px;">
									<i data-index="1" class="mui-icon mui-icon-star-filled"></i>
									<i data-index="2" class="mui-icon mui-icon-star-filled"></i>
									<i data-index="3" class="mui-icon mui-icon-star-filled"></i>
									<i data-index="4" class="mui-icon mui-icon-star-filled"></i>
									<i data-index="5" class="mui-icon mui-icon-star-filled"></i>
								</div>
								<div class="mui-inline mui-right">无可挑剔</div>
							</div>
							<div class="as">
								<span class="line" style="margin-top:10px"></span>
								<textarea name="assess" id="assess" class="content" rows="5" placeholder="说说做的好的地方和不足的地方吧！"></textarea>
							</div>
							<div class="as">
								<span class="lines"></span>
								<div class="file-box" style="margin-right: -2px;">
									<input type="file" name="file" class="file" accept="image/*">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script src="${ctx}/public/celerepair/js/mui.min.js"></script>
		<script>
			mui.init({
				swipeBack: true //启用右滑关闭功能
			});
			//主界面和侧滑菜单界面均支持区域滚动；
			mui('#offCanvasSideScroll').scroll();
			var starIndex=5;
			//应用评分点击事件
			mui('.icons').on('tap', 'i', function() {
				var index = parseInt(this.getAttribute("data-index"));
				var parent = this.parentNode;
				var children = parent.children;
				if(this.classList.contains("mui-icon-star")) {
					for(var i = 0; i < index; i++) {
						children[i].classList.remove('mui-icon-star');
						children[i].classList.add('mui-icon-star-filled');
					}
				} else {
					for(var i = index; i < 5; i++) {
						children[i].classList.add('mui-icon-star')
						children[i].classList.remove('mui-icon-star-filled')
					}
				}
				index == 1 ? parent.parentNode.children[2].innerHTML = '很差' : '无可挑剔';
				index == 2 ? parent.parentNode.children[2].innerHTML = '一般' : '无可挑剔';
				index == 3 ? parent.parentNode.children[2].innerHTML = '满意' : '无可挑剔';
				index == 4 ? parent.parentNode.children[2].innerHTML = '非常满意' : '无可挑剔';
				index == 5 ? parent.parentNode.children[2].innerHTML = '无可挑剔' : '无可挑剔';
				starIndex = index;
			});
			//设置图片的平均分配宽度
			src();
			function src() {
				var arr = document.querySelectorAll('.file-box');
				var old = document.querySelector('.as').scrollWidth;
				for(var i = 0; i < arr.length; i++) {
					arr[i].style.padding = (old - 35) / 8 + 'px';
				}
			}
			//图片上传事件
			var  imgs=[];
			mui(function($) {
				$("body").on("change", ".file",function() {
				var _this = this.parentNode;
				var _that=this;
				formData = new FormData();
				formData.append("file", this.files[0]);
				formData.append("attachmentType", 9);
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
						reader.readAsDataURL(_that.files[0]);
						//监听文件读取结束后事件    
						reader.onloadend = function(e) {
						//console.log(e.target.result); //e.target.result就是最后的路径地址
						var img = document.createElement('img');
						var div = document.createElement('div');
						img.setAttribute('src', xhr);
						_this.innerHTML=""
						_this.appendChild(img);
						div.setAttribute('class', 'file-box');
						div.innerHTML = '<input type="file" name="file" class="file" accept="image/*">'
						_this.parentNode.appendChild(div);
						src();
					};
				}
			}
		});
		
	})
})
			//评价
			var OderId = document.getElementById("OderId");
			var assess = document.getElementById('assess');
			var imgUrl=document.getElementById('imgUrl');
			document.getElementById('submit').addEventListener('tap',function(){
				event.preventDefault();
				window.event.returnValue = false;
				mui.ajax('${ctx}/backend/h5/case/evaluate',{
					data:{
						score:starIndex,
						objectId:OderId.value,
						assess:assess.value,
						imgUrl:imgUrl.value
					},
					type:'post',//HTTP请求类型
					dataType:'json',
					async:true,
					timeout:5000,//超时时间设置为5秒；             
					success:function(data){
						if (data.statusCode == "0000") {
							mui.alert('评价成功', function() {
								window.location.href = "${ctx}/backend/h5/case/doCaseOne?caseId="+data.status;
							});
						}
					},
					error:function(xhr,type,errorThrown){
						
					}
				});
		   });
			
		</script>
	</body>

</html>