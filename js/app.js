(function($, owner) {
	var serviceinfo = {
		//测试接口
		//		app_ip: "https://celefix.mydrn.cn",
		//		app_port: "443",
		//		path: "/celefix/backend/h5/" //环境路径

		//本地
		app_ip: "http://192.168.3.37",
		app_port: "8000",
		path: "/celefix/backend/h5/" //环境路径
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
		}else{
			data.token = owner.getState().token;
			alert(data.token);
		}
		console.log(url);
		$.ajax(url, {
			data:data,
			dataType: 'json', //服务器返回json格式数据
			type: 'POST', //HTTP请求类型
			timeout: 3000, //超时时间设置为6秒；
			success: function(data) {
				if(data.msgCode == "0000") {
					//设置客服电话
					localStorage.setItem('$contactUs', data.data.contactUs);
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
		console.log(url);
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

	/*$.ready(function() {
		document.onreadystatechange = function() {
			if(document.readyState == "complete") {
				var body = document.getElementsByTagName('body');
				var div = document.createElement('div');
				div.setAttribute("id", "mask");
				div.innerHTML = '<img src="./images/3.gif"/><span id="mask-num">0%</span>';
				body[0].appendChild(div);
			}
		}
	})*/

}(mui, window.app = {}));