// JavaScript Document
//点击展开
	$(function(){
		$(".chenk_a").click(function(){
				$("#table01").show()
			});
		})

	//点击显示内容
	$(function(){
		$(".bookbut").click(function(){
			$(".bookline").show();
			})
		})

	$(function(){
		$("input[name='doubleway']").click(function(){
			$(".combination").show();
			})
		})

	//鼠标移上显示效果
	$(function(){
			var _flystyle = $('#flystyle');
			    _flystyle_content = $('#flystyle_content');
				
				_flystyle.hover(function(){
					var _tTime_top = _flystyle.offset().top,
					    _tTime_left = _flystyle.offset().left,
						_tTime_height = _flystyle.height(),
						_top = parseInt(_tTime_top) + parseInt(_tTime_height) + 10 + "px",
						_left = parseInt(_tTime_left) + "px";
						
				_flystyle_content.stop(true,true).fadeIn().css({
					 top:_top,
					 left:_left
					});
					},function(){
						_flystyle_content.stop(true,true).fadeOut();
						});
		});
	

	

	//点击关闭
	$(function(){
			$(".shaixuan02 p i").click(function(){
				$(this).parent(".shaixuan02 p").hide();
				});
			$("#clear_c").click(function(){
				$(".shaixuan02").hide();
				});	
				
		});

   //切换
	$(function(){
		var tab = $(".datebox .datecontent ul");
		
		tab.click(function(){
			$(this).addClass("current").siblings().removeClass("current");
			var index = tab.index(this);
			$("div.t_content > .content").eq(index).fadeIn('slow').siblings().hide();
			});
		});
	//换
	function tranferCity(){
		var arriveCity = $('#arriveCity').val();
		var departCity = $('#departCity').val();
		$('#departCity').val(arriveCity);
		$('#arriveCity').val(departCity);
	}


























