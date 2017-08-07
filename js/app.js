(function($, owner) {
	var serviceinfo = {
		//测试接口
		//app_ip: "http://celerepair.celelink.com",
		app_ip: "http://116.62.48.143",
		app_port: "8080",
		path: "/celefix/backend/h5/" //环境路径

		//本地
//		app_ip: "http://192.168.3.37",
//		app_port: "8000",
//		path: "/celefix/backend/h5/" //环境路径
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
		var data = {
			v : Math.random(),
			token : owner.getState().token
		};
		$.ajax(url, {
			data: data,
			dataType: 'json', //服务器返回json格式数据
			//cache: false,
			type: 'POST', //HTTP请求类型
			timeout: 6000, //超时时间设置为6秒；
			success: function(data) {
				if(data.msgCode == "0000") {
					var state1 = "审<br />核<br />中",
						state2 = "待<br />上<br />门",
						state3 = "待<br />审<br />批",
						state4 = "待<br />付<br />款",
						state5 = "待<br />评<br />价",
						state6 = "已<br />完<br />成",
						state7 = "待<br />接<br />单";
					var stateType = "已<br />完<br />成";
					//设置客服电话
					localStorage.setItem('$contactUs', data.data.contactUs);
					//订单列表
					var caseList = data.data.caseList;
					var caseUl = document.getElementById("caseUl");
					if(caseList == undefined || caseList.length <= 0) {
						var orderList = document.getElementById("orderList")
						orderList.innerHTML = '<div class="order-null"><img src="images/ice-null.png" /><div class="f-essential">暂无进行中订单</div></div>';
						return;
					}
					var caseHTML = '';
					for(var item in caseList) {
						if(caseList[item].caseStatus == -1 && caseList[item].customerType != 5) {
							stateType = state1
						} else if(caseList[item].caseStatus == 0 && caseList[item].technicianId == 0 && caseList[item].customerType == 5) {
							stateType = state7
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
				}
				return callback(data);
			},
			error: function(xhr, type, errorThrown) {
				//plus.nativeUI.closeWaiting();
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

	owner.see = function() {
		mui("body").on("tap", ".see", function() {
			var pass = this.previousElementSibling;
			if(pass.getAttribute('type') == "password") {
				pass.setAttribute("type", "text");
				this.setAttribute('class', this.getAttribute('class').replace(/off/, "no"));
			} else {
				pass.setAttribute("type", "password");
				this.setAttribute('class', this.getAttribute('class').replace(/no/, "off"));
			}
		})
	}
}(mui, window.app = {}));