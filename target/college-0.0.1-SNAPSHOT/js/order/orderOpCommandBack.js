// 取消订单的客票信息
$(function() {
	operateClick();
	// 全选
	$("#checkedAll").click(function() {
		// 如果当前点击的多选框被选中
		if ($(this).attr('checked')) {
			$('.check-sub').each(function(i, obj) {
				if (!$(obj).attr('disabled')) {
					$(obj).attr('checked', true);
				}
			});
		} else {
			$(".check-sub").attr('checked', false);
		}
	});

	// 选择子项点击事件
	$('.check-sub').click(function() {
		var flag = true;
		$('.check-sub').each(function(i, obj) {
			if (!$(this).attr('checked') && !$(this).attr("disabled")) {
				flag = false;
				return;
			}
		});
		if (flag) {
			$('#checkedAll').attr('checked', true);
		} else {
			$('#checkedAll').attr('checked', false);
		}
	});
	
	$("#closeVerifyBookingAgainSuccDialog").click(function() {
		window.location.reload();
		$("#verifyBookingAgainSucc").css("display", "none");
	});
	$("#closeVerifyBookingAgainFailDialog").click(function() {
		window.location.reload();
		$("#verifyBookingAgainFail").css("display", "none");
	});	
});

//根据id获取操作的id和等级，然后添加不同样式
function operateClick(){
	 $(".button").each(function(){
	       var operateid= $.trim($(this).attr('id'));
	       var operateLevel= $.trim($(this).attr('value'));
	       var levelStyle="";
	       if(operateLevel!="" && operateLevel=="1"){
	   	     $("#"+operateid).css("background-color","#999999");
	   	     $("#"+operateid).css("color","#ffffff");
	   	   }
	   	   if(operateLevel!="" && operateLevel=="2"){
	   		 $("#"+operateid).css("border","2px solid #009dd9");
	   	     $("#"+operateid).css("color","#009dd9");
	   	   }
	   	   if(operateLevel!="" && operateLevel=="3"){
	   		 $("#"+operateid).css("background-color","#009dd9");
	   	     $("#"+operateid).css("color","#ffffff");
	   	   }
	   	   if(operateLevel!="" && operateLevel=="4"){
	   		 $("#"+operateid).css("background-color","#ff8500");
	   	     $("#"+operateid).css("color","#ffffff");
	   	   }
		});
	}

// 重新下单前验舱验价
function verifyBookingAgain(applyUrl) {
	if ($("#bookingAgainButton").css('cursor') == 'no-drop')
		return;
	if (confirm('确认提交申请?')) {
		// 锁住
		$("#bookingAgainButton").css('cursor', 'no-drop');
		$("#bookingAgainButton").html("验证中...");
		$.ajax({
			url : applyUrl,
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
				orderMainId : $('#orderMainId').val(),
				orderId : $('#orderId').val(),
				flightOrderDetails : setOrderDetails()
			}),
			success : function(data) {
				if (data != null && data.status == "SUCCESS") {
					// 显示成功信息
					$("#verifyBookingAgainSuccMessage span").html(data.message);
					$("#verifyBookingAgainSucc").css("display", "block");
				} else {
					$("#verifyBookingAgainFailMessage span").html(data.message);
					$("#verifyBookingAgainFail").css("display", "block");
					$("#bookingAgainButton").css('cursor', 'pointer');
					$("#bookingAgainButton").html("重新下单");
				}
			},
			error:function(data)
			{
				alert(eval('(' + data.responseText + ')').message);
			}
		}); 
	}
}

//重新下单
function bookingAgain(applyUrl) {
	if ($("#bookingAgainSuccButton").css('cursor') == 'no-drop')
		return;

	var index = 0;
	$('.check-sub').each(function(i, obj) {
		if ($(this).attr('checked')) {
			index++;
			return;
		}
	});
	if (index == 0) {
		alert('请在客票信息选择重新下单的乘客');
		return;
	}

	if (confirm('确认提交申请?')) {
		// 锁住
		$("#bookingAgainSuccButton").css('cursor', 'no-drop');
		$("#bookingAgainSuccButton").html('<span>确认中···</span>');
		$.ajax({
			url : applyUrl,
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
				orderMainId : $('#orderMainId').val(),
				orderId : $('#orderId').val(),
				flightOrderDetails : setOrderDetails()
			}),
			success : function(data) {
				if (data != null && data.status == "SUCCESS") {
					$("#verifyBookingAgainSucc").css("display", "block");
					$("#bookingAgainSuccButton").css('cursor', 'pointer');
					$("#bookingAgainSuccButton").html('<span onclick="closeBookingAgainSucc_1()">关闭</span>');
					if (data.results != null && data.results.length > 0){
						$.each(data.results, function(i, value) {
							if (value.flightOrders != null && value.flightOrders.length > 0){
								$.each(value.flightOrders, function(k, value2) {
									var url = "/order/queryOrderDetail/"+value2.orderMainId+"/"+value2.id+"/NULL";
									$("#verifyBookingAgainSuccMessage span").html(data.message + "新订单号：" + "<a href='"+url+"' style='color:blue;' target='_blank'>" + value2.flightOrderNo.orderNo + "</a>");
									return false; 
								})
							}
						})
					}
				} else {
					$("#verifyBookingAgainSuccMessage span").html(data.message);
					$("#verifyBookingAgainSucc").css("display", "block");
					$("#bookingAgainSuccButton").css('cursor', 'pointer');
					$("#bookingAgainSuccButton").html('<span onclick="closeBookingAgainSucc_2()">关闭</span>');
				}
			},
			error:function(data)
			{
				alert(eval('(' + data.responseText + ')').message);
			}
		}); 
	}
}

//结果关闭
function closeVerifyBookingAgainFail() {
	window.location.reload();
	$("#verifyBookingAgainFail").css("display", "none");
}
function closeBookingAgainSucc_1() {
	window.close();
}
function closeBookingAgainSucc_2() {
	window.location.reload();
	$("#verifyBookingAgainSucc").css("display", "none");
}


// 数据组装orderDetails
function setOrderDetails() {
	var arrays = new Array();
	var index = 0;
	$('#orderDetails tr').each(function(i) {
		if ($(this).find("[name='orderDetailId']").attr("checked") == "checked") {
			if(i != 0){
				arrays[index++] = setOrderDetail($(this));
			}
		}
	});
	return arrays;
}

// 组装数据请求退票信息
function setOrderDetail(obj) {
	// 设置订单明细对象
	var orderDetailDto = new Object;
	orderDetailDto.id = $(obj).find("[name='detailId']").val();
	orderDetailDto.orderId = $('#orderId').val();

	return orderDetailDto;
}