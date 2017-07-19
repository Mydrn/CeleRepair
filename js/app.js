(function($, owner) {
	var serviceinfo = {
		//测试接口
		app_ip: "http://116.62.48.143",
		app_port: "8088",
		path: "/celefix/backend/h5/" //环境路径

		//本地
		//				app_ip: "http://192.168.3.37",
		//				app_port: "8000",
		//				path: "/celefix/backend/h5/" //环境路径
	};
	//服务器地址存储本地
	localStorage.setItem('$serviceinfo', JSON.stringify(serviceinfo));
	/**
	 * 首页
	 **/
	owner.indexList = function(callback) {
		callback = callback || $.noop;
		//首页接口
		var url = serviceinfo.app_ip + ":" + serviceinfo.app_port + serviceinfo.path + "user/doIndex";
		var data = {};
		if(owner.getState().token == undefined) {

		} else {
			data.token = owner.getState().token;
		}
		$.ajax(url, {
			data: data,
			dataType: 'json', //服务器返回json格式数据
			type: 'POST', //HTTP请求类型
			timeout: 3000, //超时时间设置为6秒；
			success: function(data) {
				if(data.msgCode == "0000") {
					//设置客服电话
					localStorage.setItem('$contactUs', data.data.contactUs);
					if(data.msgCode == "0000") {
						//广告数据
						var slider = document.getElementById("slider-list");
						var html = '';
						var adList = data.data.adList;
						for(var item in adList) {
							html += '<div class="mui-slider-item">' +
								'<a class="adLink" href="javascript:;" id="' + [item].adLink + '">' +
								'<img src="' + adList[item].adUrl + '">' +
								'</a>' +
								'</div>'
						}
						slider.innerHTML = '<div class="mui-slider-item mui-slider-item-duplicate"></div>' + html + '<div class="mui-slider-item mui-slider-item-duplicate"></div>';
						//自动播放轮播图
						//订单列表
						var caseList = data.data.caseList;
						var caseUl = document.getElementById("caseUl");
						if(caseList==undefined || caseList.length<=0 ) {
							var orderList = document.getElementById("orderList")
							orderList.innerHTML = '<div class="order-null"><img src="images/ice-null.png" /><div class="f-essential">暂无进行中订单</div></div>';
							return;
						}
						var caseHTML='';
						for(var item in caseList) {
							if(caseList[item].caseStatus == -1 && caseList[item].customerType != 5) {
								stateType = state1
							} else if(caseList[item].caseStatus == -1 && caseList[item].customerType == 5) {
								stateType = state7
							} else if(caseList[item].caseStatus == 0 || caseList[item].caseStatus == 1 || caseList[item].caseStatus == 2) {
								stateType = state2
							} else if(caseList[item].caseStatus == 3 && caseList[item].customerType != 5) {
								stateType = state3
							} else if(caseList[item].caseStatus == 3 && caseList[item].customerType == 5) {
								stateType = state4
							} else if(caseList[item].caseStatus == 4 && caseList[item].assessScore == null) {
								stateType = state5
							}
							caseHTML += '<li class="mui-table-view-cell mui-media bg-white"><a href="javascript:;" class="details" id="' + caseList[item].id + '">' +
								'<img class="mui-media-object mui-pull-left" src="' + caseList[item].attachmentFile + '">' +
								'<div class="mui-media-body">' +
								'<p class="order-title mui-ellipsis">' + caseList[item].claimCode + '</p>' +
								'<p class="mui-ellipsis">' + caseList[item].updateTime + '</p>' +
								'</div>' +
								'<span class="stateType">' + stateType +
								'</a></li>';
						}
						caseUl.innerHTML = caseHTML;
						//document.getElementById('mask').style.display='none';
					} else if(data.msgCode == "0002") {
						mui.alert('你已在其它地方登录,请重新登录!', function() {
							var w = plus.webview.create( "../login.html" );
								w.show(); // 显示窗口
							/*mui.openWindow({
								url: 'login.html',
								id: 'login'
							});*/
						});
					}
					
					//console.log(JSON.stringify(data));
					return callback(data);
				} else if(data.msgCode == "0002") {
					mui.alert('你已在其它地方登录,请重新登录!', function() {
						mui.openWindow({
							url: 'login.html',
							id: 'login'
						});
					});
				}
			},
			error: function(xhr, type, errorThrown) {
				plus.nativeUI.closeWaiting();
				return mui.toast('网络繁忙!');
			}
		});
	};
	/**
	 * 用户登录
	 **/
	owner.login = function(loginInfo, callback) {
		callback = callback || $.noop;
		loginInfo = loginInfo || {};
		var serviceinfo = JSON.parse(localStorage.getItem('$serviceinfo'));
		loginInfo.customerName = loginInfo.customerName || '';
		loginInfo.password = loginInfo.password || '';
		if(loginInfo.password.length < 6) {
			return callback('密码最短为 6 个字符');
		}
		var url = serviceinfo.app_ip + ":" + serviceinfo.app_port + serviceinfo.path + "user/doLogin";
		$.ajax(url, {
			data: {
				name: loginInfo.customerName,
				password: loginInfo.password
			},
			dataType: 'json', //服务器返回json格式数据
			type: 'POST', //HTTP请求类型
			timeout: 3000, //超时时间设置为3秒；
			headers: {
				'Content-Type': 'application/json'
			},
			success: function(data) {
				mui.toast(data.msg);
				if(data.msgCode == "0000") {
					return owner.createState(data, callback);
				}
			},
			error: function(xhr, type, errorThrown) {
				if(type == "abort") {
					mui.toast('服务器连接异常！');
				} else if(type == "timeout") {
					mui.toast('服务器连接超时！');
				}
				return;
			}
		});
	};

	/**
	 * 获取用户信息
	 **/
	owner.findUser = function(callback) {
		callback = callback || $.noop;
		var serviceinfo = JSON.parse(localStorage.getItem('$serviceinfo'));
		var url = serviceinfo.app_ip + ":" + serviceinfo.app_port + serviceinfo.path + "user/doOneData";
		$.ajax(url, {
			data: {
				token: owner.getState().token
			},
			type: 'POST', //HTTP请求类型
			dataType: 'json',
			timeout: 5000, //超时时间设置为5秒；
			success: function(data) {
				if(data.msgCode == "0000") {
					return callback(data);
				} else if(data.msgCode == "0002") {
					mui.alert('你已在其它地方登录,请重新登录!', function() {
						mui.openWindow({
							url: '../login.html',
							id: 'login'
						});
					});
				}
			}
		});
	};
	owner.createState = function(jsonData, callback) {
		var state = owner.getState();
		state.token = jsonData.data;
		owner.setState(state);
		return callback();
	};
	/**
	 * 获取当前状态
	 **/
	owner.getState = function() {
		var stateText = localStorage.getItem('$state') || "{}";
		return JSON.parse(stateText);
	};
	/**
	/**
	 * 设置当前状态
	 **/
	owner.setState = function(state) {
		state = state || {};
		localStorage.setItem('$state', JSON.stringify(state));
		//var settings = owner.getSettings();
		//settings.gestures = '';
		//owner.setSettings(settings);
	};
	/**
	 * 设置应用本地配置
	 **/
	owner.setSettings = function(settings) {
		settings = settings || {};
		localStorage.setItem('$settings', JSON.stringify(settings));

	}

	/**
	 * 获取应用本地配置
	 **/
	owner.getSettings = function() {
		var settingsText = localStorage.getItem('$settings') || "{}";
		return JSON.parse(settingsText);
	}
}(mui, window.app = {}));