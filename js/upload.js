var arr = [];
//默认加载完成后就必须执行一次
(function($) {
	// 当domReady的时候开始初始化
	$(function() {
		var $wrap = $('#uploader'),

			// 图片容器
			$queue = $('<ul class="filelist"></ul>')
			.appendTo($wrap.find('.queueList')),
			// 状态栏，包括进度和控制按钮
			$statusBar = $wrap.find('.statusBar'),

			// 文件总体选择信息。
			$info = $statusBar.find('.info'),

			// 上传按钮
			$upload = $wrap.find('.uploadBtn'),

			// 没选择文件之前的内容。
			$placeHolder = $wrap.find('.placeholder'),

			$progress = $statusBar.find('.progress').hide(),

			// 添加的文件数量
			fileCount = 0,
			// 添加的文件总大小
			fileSize = 0,

			// 优化retina, 在retina下这个值是2
			ratio = window.devicePixelRatio || 1,

			// 缩略图大小
			thumbnailWidth = 100 * ratio,
			thumbnailHeight = 100 * ratio,

			// 可能有pedding, ready, uploading, confirm, done.
			state = 'pedding',

			// 所有文件的进度信息，key为file id
			percentages = {},
			// 判断浏览器是否支持图片的base64
			isSupportBase64 = (function() {
				var data = new Image();
				var support = true;
				data.onload = data.onerror = function() {
					if(this.width != 1 || this.height != 1) {
						support = false;
					}
				}
				data.src = "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==";
				return support;
			})(),

			// 检测是否已经安装flash，检测flash的版本
			flashVersion = (function() {
				var version;

				try {
					version = navigator.plugins['Shockwave Flash'];
					version = version.description;
				} catch(ex) {
					try {
						version = new ActiveXObject('ShockwaveFlash.ShockwaveFlash')
							.GetVariable('$version');
					} catch(ex2) {
						version = '0.0';
					}
				}
				version = version.match(/\d+/g);
				return parseFloat(version[0] + '.' + version[1], 10);
			})(),

			supportTransition = (function() {
				var s = document.createElement('p').style,
					r = 'transition' in s ||
					'WebkitTransition' in s ||
					'MozTransition' in s ||
					'msTransition' in s ||
					'OTransition' in s;
				s = null;
				return r;
			})(),

			// WebUploader实例
			uploader;

		if(!WebUploader.Uploader.support('flash') && WebUploader.browser.ie) {

			// flash 安装了但是版本过低。
			if(flashVersion) {
				(function(container) {
					window['expressinstallcallback'] = function(state) {
						switch(state) {
							case 'Download.Cancelled':
								alert('您取消了更新！')
								break;

							case 'Download.Failed':
								alert('安装失败')
								break;

							default:
								alert('安装已成功，请刷新！');
								break;
						}
						delete window['expressinstallcallback'];
					};

					var swf = '../images/expressInstall.swf';
					// insert flash object
					var html = '<object type="application/' +
						'x-shockwave-flash" data="' + swf + '" ';

					if(WebUploader.browser.ie) {
						html += 'classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" ';
					}

					html += 'width="100%" height="100%" style="outline:0">' +
						'<param name="movie" value="' + swf + '" />' +
						'<param name="wmode" value="transparent" />' +
						'<param name="allowscriptaccess" value="always" />' +
						'</object>';

					container.html(html);

				})($wrap);

				// 压根就没有安转。
			} else {
				$wrap.html('<a href="http://www.adobe.com/go/getflashplayer" target="_blank" border="0"><img alt="get flash player" src="http://www.adobe.com/macromedia/style_guide/images/160x41_Get_Flash_Player.jpg" /></a>');
			}

			return;
		} else if(!WebUploader.Uploader.support()) {
			alert('Web Uploader 不支持您的浏览器！');
			return;
		}
		var serviceinfo = JSON.parse(localStorage.getItem('$serviceinfo'));
		// 实例化
		uploader = WebUploader.create({
			pick: {
				id: '#filePicker',
				label: '点击选择图片'
			},
			formData: {
				attachmentType: 7
			},
			dnd: '#dndArea',
			paste: '#uploader',
			swf: '../../dist/Uploader.swf',
			chunked: false,
			compress: null,
			auto: false,
			fileNumLimit: 20,
			chunkSize: 512 * 1024,
			server: serviceinfo.app_ip + ":" + serviceinfo.app_port + "/celefix/backend/base/saveImg",
			// runtimeOrder: 'flash',
			accept: {
				title: 'Images',
				extensions: 'gif,jpg,jpeg,bmp,png',
				mimeTypes: 'image/*'
			},
			// 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
			disableGlobalDnd: true,
			fileSizeLimit: 200 * 1024 * 1024, // 200 M
			fileSingleSizeLimit: 50 * 1024 * 1024 // 50 M
		});
		// 拖拽时不接受 js, txt 文件。
		uploader.on('dndAccept', function(items) {
			var denied = false,
				len = items.length,
				i = 0,
				// 修改js类型
				unAllowed = 'text/plain;application/javascript ';

			for(; i < len; i++) {
				// 如果在列表里面
				if(~unAllowed.indexOf(items[i].type)) {
					denied = true;
					break;
				}
			}

			return !denied;
		});

		uploader.on('dialogOpen', function() {
			//console.log('here');
		});

		// uploader.on('filesQueued', function() {
		//     uploader.sort(function( a, b ) {
		//         if ( a.name < b.name )
		//           return -1;
		//         if ( a.name > b.name )
		//           return 1;
		//         return 0;
		//     });
		// });

		// 添加“添加文件”的按钮，
		uploader.addButton({
			id: '#filePicker2',
			label: '继续添加'
		});

		uploader.on('ready', function() {
			window.uploader = uploader;
		});

		// 当有文件添加进来时执行，负责view的创建
		function addFile(file) {
			var $li = $('<li id="' + file.id + '">' +
					'<p class="title">' + file.name + '</p>' +
					'<p class="imgWrap"></p>' +
					'<p class="progress"><span></span></p>' +
					'</li>'),

				$btns = $('<div class="file-panel">' +
					'<span class="cancel">删除</span>' +
					'<span class="rotateRight">向右旋转</span>' +
					'<span class="rotateLeft">向左旋转</span></div>').appendTo($li),
				$prgress = $li.find('p.progress span'),
				$wrap = $li.find('p.imgWrap'),
				$info = $('<p class="error"></p>'),

				showError = function(code) {
					switch(code) {
						case 'exceed_size':
							text = '文件大小超出';
							break;

						case 'interrupt':
							text = '上传暂停';
							break;

						default:
							text = '上传失败，请重试';
							break;
					}

					$info.text(text).appendTo($li);
				};

			if(file.getStatus() === 'invalid') {
				showError(file.statusText);
			} else {
				// @todo lazyload
				$wrap.text('预览中');
				uploader.makeThumb(file, function(error, src) {
					var img;
					if(error) {
						$wrap.text('不能预览');
						return;
					}

					if(isSupportBase64) {
						img = $('<img src="' + src + '">');
						$wrap.empty().append(img);
					} else {
						var url1 = serviceinfo.app_ip + ":" + serviceinfo.app_port + "/celefix/backend/base/saveImg";
						//$.ajax('http://116.62.48.143/celefix/backend/base/saveImg', {
						$.ajax(url1, {
							method: 'POST',
							data: src,
							dataType: 'json',
							contentType: "application/json; charset=utf-8",
						}).done(function(response) {
							if(response.result) {
								img = $('<img src="' + response.result + '">');
								$wrap.empty().append(img);
							} else {
								$wrap.text("预览出错");
							}
						});
					}
				}, thumbnailWidth, thumbnailHeight);

				percentages[file.id] = [file.size, 0];
				file.rotation = 0;
			}

			file.on('statuschange', function(cur, prev) {
				if(prev === 'progress') {
					$prgress.hide().width(0);
				} else if(prev === 'queued') {
					$li.off('mouseenter mouseleave');
					$btns.remove();
				}

				// 成功
				if(cur === 'error' || cur === 'invalid') {
					console.log(file.statusText);
					showError(file.statusText);
					percentages[file.id][1] = 1;
				} else if(cur === 'interrupt') {
					showError('interrupt');
				} else if(cur === 'queued') {
					$info.remove();
					$prgress.css('display', 'block');
					percentages[file.id][1] = 0;
				} else if(cur === 'progress') {
					$info.remove();
					$prgress.css('display', 'block');
				} else if(cur === 'complete') {
					$prgress.hide().width(0);
					$li.append('<span class="success"></span>');
				}

				$li.removeClass('state-' + prev).addClass('state-' + cur);
			});

			$li.on('mouseenter', function() {
				$btns.stop().animate({
					height: 30
				});
			});

			$li.on('mouseleave', function() {
				$btns.stop().animate({
					height: 0
				});
			});

			$btns.on('click', 'span', function() {
				var index = $(this).index(),
					deg;

				switch(index) {
					case 0:
						uploader.removeFile(file);
						return;

					case 1:
						file.rotation += 90;
						break;

					case 2:
						file.rotation -= 90;
						break;
				}

				if(supportTransition) {
					deg = 'rotate(' + file.rotation + 'deg)';
					$wrap.css({
						'-webkit-transform': deg,
						'-mos-transform': deg,
						'-o-transform': deg,
						'transform': deg
					});
				} else {
					$wrap.css('filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation=' + (~~((file.rotation / 90) % 4 + 4) % 4) + ')');
					// use jquery animate to rotation
					// $({
					//     rotation: rotation
					// }).animate({
					//     rotation: file.rotation
					// }, {
					//     easing: 'linear',
					//     step: function( now ) {
					//         now = now * Math.PI / 180;

					//         var cos = Math.cos( now ),
					//             sin = Math.sin( now );

					//         $wrap.css( 'filter', "progid:DXImageTransform.Microsoft.Matrix(M11=" + cos + ",M12=" + (-sin) + ",M21=" + sin + ",M22=" + cos + ",SizingMethod='auto expand')");
					//     }
					// });
				}

			});

			$li.appendTo($queue);
		}

		// 负责view的销毁
		function removeFile(file) {
			var $li = $('#' + file.id);

			delete percentages[file.id];
			updateTotalProgress();
			$li.off().find('.file-panel').off().end().remove();
		}

		function updateTotalProgress() {
			var loaded = 0,
				total = 0,
				spans = $progress.children(),
				percent;

			$.each(percentages, function(k, v) {
				total += v[0];
				loaded += v[0] * v[1];
			});

			percent = total ? loaded / total : 0;

			spans.eq(0).text(Math.round(percent * 100) + '%');
			spans.eq(1).css('width', Math.round(percent * 100) + '%');
			updateStatus();
		}

		function updateStatus() {
			var text = '',
				stats;

			if(state === 'ready') {
				text = '选中' + fileCount + '张图片，共' +
					WebUploader.formatSize(fileSize) + '。';
			} else if(state === 'confirm') {
				stats = uploader.getStats();
				if(stats.uploadFailNum) {
					text = '已成功上传' + stats.successNum + '张照片至XX相册，' +
						stats.uploadFailNum + '张照片上传失败，<a class="retry" href="#">重新上传</a>失败图片或<a class="ignore" href="#">忽略</a>'
				}

			} else {
				stats = uploader.getStats();
				text = '共' + fileCount + '张（' +
					WebUploader.formatSize(fileSize) +
					'），已上传' + stats.successNum + '张';

				if(stats.uploadFailNum) {
					text += '，失败' + stats.uploadFailNum + '张';
				}
			}

			$info.html(text);
		}

		function setState(val) {
			var file, stats;

			if(val === state) {
				return;
			}

			$upload.removeClass('state-' + state);
			$upload.addClass('state-' + val);
			state = val;

			switch(state) {
				case 'pedding':
					$placeHolder.removeClass('element-invisible');
					$queue.hide();
					$statusBar.addClass('element-invisible');
					uploader.refresh();
					break;

				case 'ready':
					$placeHolder.addClass('element-invisible');
					$('#filePicker2').removeClass('element-invisible');
					$queue.show();
					$statusBar.removeClass('element-invisible');
					uploader.refresh();
					break;

				case 'uploading':
					$('#filePicker2').addClass('element-invisible');
					$progress.show();
					$upload.text('暂停上传');
					break;

				case 'paused':
					$progress.show();
					$upload.text('继续上传');
					break;

				case 'confirm':
					$progress.hide();
					$('#filePicker2').removeClass('element-invisible');
					$upload.text('开始上传');

					stats = uploader.getStats();
					if(stats.successNum && !stats.uploadFailNum) {
						setState('finish');
						return;
					}
					break;
				case 'finish':
					stats = uploader.getStats();
					if(stats.successNum) {
						console.log(stats.success)
					} else {
						// 没有成功的图片，重设
						state = 'done';
						location.reload();
					}
					break;
			}

			updateStatus();
		}
		//进度条的控制
		uploader.onUploadProgress = function(file, percentage) {
			var $li = $('#' + file.id),
				$percent = $li.find('.progress span');

			$percent.css('width', percentage * 100 + '%');
			percentages[file.id][1] = percentage;
			updateTotalProgress();
		};

		uploader.onFileQueued = function(file) {
			fileCount++;
			fileSize += file.size;

			if(fileCount === 1) {
				$placeHolder.addClass('element-invisible');
				$statusBar.show();
			}

			addFile(file);
			setState('ready');
			updateTotalProgress();
		};

		uploader.onFileDequeued = function(file) {
			fileCount--;
			fileSize -= file.size;

			if(!fileCount) {
				setState('pedding');
			}

			removeFile(file);
			updateTotalProgress();

		};

		uploader.on('all', function(type) {
			var stats;
			switch(type) {
				case 'uploadFinished':
					setState('confirm');
					break;

				case 'startUpload':
					setState('uploading');
					break;

				case 'stopUpload':
					setState('paused');
					break;

			}
		});

		uploader.onError = function(code) {
			alert('Eroor: ' + code);
		};
		uploader.on('uploadSuccess', function(file, response) {
			arr.push(response._raw);
			document.getElementById("imgUrl").value = arr;
			console.log(arr);
		});
		$upload.on('click', function() {
			if($(this).hasClass('disabled')) {
				return false;
			}

			if(state === 'ready') {
				uploader.upload();
			} else if(state === 'paused') {
				uploader.upload();
			} else if(state === 'uploading') {
				uploader.stop();
			}
		});

		$info.on('click', '.retry', function() {
			uploader.retry();
		});

		$info.on('click', '.ignore', function() {
			alert('todo');
		});

		$upload.addClass('state-' + state);
		updateTotalProgress();
	});
})(jQuery);

//增加项目类型
//mui('body').on('tap', '.add', function() {
//	var table = document.body.querySelector('#orderList'),
//		ul = document.createElement('ul');
//	s++;
//	ul.classList.add('mui-table-view');
//	ul.classList.add('list-' + s);
//	ul.innerHTML = ('<li class="mui-table-view-cell">' +
//		'<a href="javascript:;" class="mui-navigate-right mui-icon mui-icon-location showCityPicker">' +
//		'报修类型' +
//		'</a>' +
//		'</li>' +
//		'<li class="mui-table-view-cell demo3">' +
//		'<a href="javascript:;" data-options=' + {
//			"value": "2015-10-10 10:10",
//			"beginYear": 2010,
//			"endYear": 2020
//		} + ' class="mui-navigate-right mui-icon mui-icon-location">' +
//		'上门时间' +
//		'</a>' +
//		'</li>' +
//		'<li class="mui-table-view-cell">' +
//		'<div id="wrapper-' + s + '">' +
//		'<p class="order-title">你可以上传多张报修图片:</p>' +
//		'<div id="container-' + s + '">' +
//		'<div id="uploader-' + s + '">' +
//		'<div class="queueList">' +
//		'<div id="dndArea-' + s + '" class="placeholder">' +
//		'<div id="filePicker-' + s + '"></div>' +
//		'</div></div>' +
//		'<div class="statusBar" style="display:none;">' +
//		'<div class="btns">' +
//		'<div id="filePicker2-' + s + '"></div>' +
//		'<div class="uploadBtn">开始上传</div>' +
//		'</div></div></div></div></div></li>' +
//		'<li class="mui-table-view-cell">' +
//		'<p class="order-title">请对报修项目进行描述:</p>' +
//		'<textarea name="" rows="5" cols="5"></textarea>' +
//		'</li>');
//	table.appendChild(ul);
//	// 实例化
//	ready(s);
//	newObj(s);
//	console.log(objBig)
//});

//分离公共代码
//function newObj(a) {
//	objBig['obj' + a] = {};
//	objBig['obj' + a].type = "";
//	objBig['obj' + a].time = "";
//	objBig['obj' + a].arr = [];
//	objBig['obj' + a].more = "";
//}

//时间的操作并且赋值
(function($) {
	$.init();
	var btns = $('.demo3');
	btns.each(function(i, btn) {
		mui('body').on('tap', '.demo3', function() {
			var optionsJson = this.getAttribute('data-options') || '{}';
			var options = JSON.parse(optionsJson);
			var id = this.getAttribute('id');
			/*
			 * 首次显示时实例化组件
			 * 示例为了简洁，将 options 放在了按钮的 dom 上
			 * 也可以直接通过代码声明 optinos 用于实例化 DtPicker
			 */
			var picker = new $.DtPicker(options);
			picker.show(function(rs) {
				/*
				 * rs.value 拼合后的 value
				 * rs.text 拼合后的 text
				 * rs.y 年，可以通过 rs.y.vaue 和 rs.y.text 获取值和文本
				 * rs.m 月，用法同年
				 * rs.d 日，用法同年
				 * rs.h 时，用法同年
				 * rs.i 分（minutes 的第二个字母），用法同年
				 */
				document.getElementById("contract").innerHTML =" 预约时间："+rs.y.text + "-" + rs.m.text + "-" + rs.d.text +" "+ rs.h.text + ":00";
				document.getElementById("servicingTime").value = rs.y.text + rs.m.text + rs.d.text + rs.h.text;
				/* 
				 * 返回 false 可以阻止选择框的关闭
				 * return false;
				 */
				/*
				 * 释放组件资源，释放后将将不能再操作组件
				 * 通常情况下，不需要示放组件，new DtPicker(options) 后，可以一直使用。
				 * 当前示例，因为内容较多，如不进行资原释放，在某些设备上会较慢。
				 * 所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例。
				 */
				picker.dispose();
			});
		}, false);
	});
})(mui);

//安装类型的操作并且赋值
(function($, doc) {
	$.init();
	$.ready(function() {
		var serviceinfo = JSON.parse(localStorage.getItem('$serviceinfo'));
		var url = serviceinfo.app_ip + ":" + serviceinfo.app_port + serviceinfo.path + "user/getAllService";
		$.ajax(url,{
			data:'none',
			type:'post',//HTTP请求类型
			//timeout:10000,//超时时间设置为10秒；
			//headers:{'Content-Type':'application/json'},	              
			success:function(data){
				//级联示例
				var cityPicker = new $.PopPicker({
					layer: 2
				});
				cityPicker.setData(eval("("+data+")"));
				mui('body').on('tap', '.showCityPicker', function(event) {
					cityPicker.show(function(items) {
						document.getElementById("serviceId").value = items[1].value;
						document.getElementsByClassName("showCityPicker")[0].innerHTML =" 报修类型："+items[0].text+"&nbsp;&nbsp;" +items[1].text;
					});
				}, false);
			},
			error:function(xhr,type,errorThrown){
				console.log(type);
			}
		});	
		
	});
})(mui, document);