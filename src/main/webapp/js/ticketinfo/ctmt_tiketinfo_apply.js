/**
 * 申请航班补全
 * 
 * @param obj
 */
function checkit(obj, afUrl) {
	$.ajax({
			url : afUrl + '/' + $('#depCityCode').val() + '/' + $('#arrCityCode').val(),
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
				flightNo : $('#flightNo').val()
			}),
			success : function(data) {
				if (data.status == 'SUCCESS') {
					// 组装舱位
					var seatClassList = eval(data.results);
					var seatStart = '<select id="seatClassCode" name="seatClassCode">';
					var seatEnd = '</select>';
					var seat = '';
					for ( var i = 0; i < seatClassList.length; i++) {
						seat += '<option value="' + seatClassList[i].code
								+ '">' + seatClassList[i].code
								+ '</option>';
					}
					$('#select_1').html(seatStart + seat + seatEnd);
				} else {
					$('#select_1').html("航班信息不存在");
				}
			}
		});
}

$(function() {
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
});

// 提交申请
function ctmtApply(applyUrl) {
	if ($(".button").css('cursor') == 'no-drop')
		return;

	var index = 0;
	$('.check-sub').each(function(i, obj) {
		if ($(this).attr('checked')) {
			index++;
			return;
		}
	});
	if (index == 0) {
		alert('请选择需要改签的乘客');
		return;
	}

	if (confirm('确认提交申请?')) {
		// 锁住
		$(".button").css('cursor', 'no-drop');
		$.ajax({
			url : applyUrl,
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
				orderMainId : $('#orderMainId').val(),
				orderId : $('#orderId').val(),
				departDate : $('#departDate').val(),
				flightNo : $('#flightNo').val(),
				seatClassCode : $('#seatClassCode').val(),
				reason : $('#reason').val(),
				flightOrderRemark : setFlightOrderRemark(),
				flightOrderDetails : setOrderDetails()
			}),
			success : function(data) {
				if (data != null) {
					alert('改签申请成功');
					window.close();
				} else {
					alert('改签申请失败');
					$(".button").css('cursor', 'pointer');
				}
			},
			error:function(data)
			{
				alert(eval('(' + data.responseText + ')').message);
			}
		}); // ajax-end
	}
}// .button-end

// 设置备注信息
function setFlightOrderRemark() {
	var remarkDto = new Object;
	remarkDto.remark = $('#remark').val();

	return remarkDto;
}

// 数据组装orderDetails
function setOrderDetails() {
	var arrays = new Array();
	var index = 0;
	$('#flightOrderDetails tr').each(function(i) {
		if ($(this).find("[name='ctmtDetailId']").attr("checked") == "checked") {
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
	orderDetailDto.id = $(obj).find("[name='ctmtDetailId']").val();
	orderDetailDto.orderId = $('#orderId').val();

	return orderDetailDto;
}