$(function(){
	var index;
	$(".calendar").click(function(){
		var str = $(this).attr("id");
		if(str == "toubao_start")
			index = 0;
		if(str == "toubao_end")
			index = 1;
		if(str == "shengxiao_start")
			index = 2;
		if(str == "shengxiao_end")
			index = 3;
		if(str == "shengxiaoSJ")
			index = 4;
		if(str == "jiesuSJ")
			index = 5;
		if(str == "bx-modify-start")
			index = 6;
		if(str == "bx-modify-end")
			index = 7;
		$("#datepicker-"+index).datepicker({
			inline: true,
			numberOfMonths:1,
			dateFormat:"yy-mm-dd",
			altField:"input[name="+str+"]",
			minDate:new Date()
		});
		var top = $(this).offset().top+34;
		var left = $(this).offset().left;
		$("#datepicker-"+index).css({"display":"block","position":"absolute","left":left+"px","top":top+"px"
			,"z-index":"20"});
	});
	$(document).mousedown(
		function(event){
  		var objParent = $(event.target).closest("#datepicker-"+index);
  		if(objParent.get()[0] != $("#datepicker-"+index).get()[0] && $(event.target).get()[0] != $(".calendar").get()[0]){
  			$("#datepicker-"+index).css("display","none");
  		}
  	})
});
