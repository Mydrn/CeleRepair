(function($, owner) {
	var serviceinfo = {
			//测试接口
//			app_ip: "https://celefix.mydrn.cn",
//			app_port: "443",
//			path: "/celefix/backend/h5/" //环境路径
			
			//本地
			app_ip: "http://127.0.0.1",
			app_port: "8000",
			path: "/celefix/backend/h5/" //环境路径
		};
		//服务器地址存储本地
		localStorage.setItem('$serviceinfo', JSON.stringify(serviceinfo));
	/**
	 * 首页
	 **/
	owner.index = function(loginInfo, callback) {
		
		callback = callback || $.noop;
		loginInfo = loginInfo || {};
		//首页接口
		var url = serviceinfo.app_ip + ":" + serviceinfo.app_port + serviceinfo.path + "user/doIndexList";
		console.log(url);
		$.ajax(url, {
			data: {},
			dataType: 'json', //服务器返回json格式数据
			type: 'POST', //HTTP请求类型
			timeout: 3000, //超时时间设置为3秒；
			headers: {'Content-Type': 'application/json'},
			success: function(data) {
				if(data.result == "0") {
					mui.toast(data.msg);
					return;
				} else {
					console.log(JSON.stringify(data));
					return mui.toast(data.msg);
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
			headers: {'Content-Type': 'application/json'},
			success: function(data) {
				mui.toast(data.msg);
				if(data.msgCode=="0000"){
					console.log(JSON.stringify(data));
					return owner.createState(data, callback);
				}
			},error: function(xhr, type, errorThrown) {
				if(type == "abort") {
					mui.toast('服务器连接异常！');
				} else if(type == "timeout") {
					mui.toast('服务器连接超时！');
				}
				return;
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