// JavaScript Document
// 时间选择js
$(function(){
	// $( "#datepicker-0" ).datepicker({
	// 	inline: true,
	// 	numberOfMonths:2,
	// 	dateFormat:"yy-mm-dd",
	// 	altField:"input[name='date-0']"
	// });
	$("#datepicker-0").css("display","none");
	// $(".calendar-0").click(function(){
	// 	$("#datepicker-0").css("display","block");
	// });
	$(document).mousedown(
		function(event){
  		var objParent = $(event.target).closest("#datepicker-0");
  		if(objParent.get()[0] != $("#datepicker-0").get()[0] && $(event.target).get()[0] != $(".datechange input").get()[0]){
  			$("#datepicker-0").css("display","none");
  		}
	});
// 第二个时间选项
	// $( "#datepicker-1" ).datepicker({
	// 	inline: true,
	// 	numberOfMonths:2,
	// 	dateFormat:"yy-mm-dd",
	// 	altField:"input[name='date-1']"
	// });
	$("#datepicker-1").css("display","none");
	// $(".calendar-1").click(function(){
	// 	$("#datepicker-1").css("display","block");
	// });
	$(document).mousedown(
		function(event){
  		var objParent = $(event.target).closest("#datepicker-1");
  		if(objParent.get()[0] != $("#datepicker-1").get()[0] && $(event.target).get()[0] != $(".datechange input").get()[0]){
  			$("#datepicker-1").css("display","none");
  		}
	});
	$(document).mouseup(
		function(event){
		$(".ui-state-default").click(function(){
			$(".hasDatepicker").css("display","none");
		})
	});

	//覆盖当前日期
	$.extend({
		_tostring:function(){
			var datenow = new Date();
			// var datenow = new Date(str_year,str_month,str_date);
			var datenow1 = new Date(datenow.getFullYear(),datenow.getMonth(),datenow.getDate()+1);
			var datenow2 = new Date(datenow.getFullYear(),datenow.getMonth(),datenow.getDate()+2);
			console.log(datenow);
			function modify(date,index){
				var str = "";
				if(index==0)
					str="今天";
				if(index==1)
					str="明天";
				if(index==2)
					str="后天";
				$(".hasDatepicker table tr td").each(function(){
					if($(this).attr("data-year")==date.getFullYear() && $(this).attr("data-month")==date.getMonth() && $(this).children(".ui-state-default").text()==date.getDate()){
						$(this).children(".ui-state-default").text(str);
					}
				});
			}
			modify(datenow,0);
			modify(datenow1,1);
			modify(datenow2,2);
		}
	})
})