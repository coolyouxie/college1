/**
 * 改签审核通过
 * 
 * @param url
 */
function ctmtAuditPass(url) {
	if ($("#ctmtAuditPass").css('cursor') == 'no-drop')
		return;
	var flightNo = $('#flightNo').val();
	var departDate = $('#departDate').val();
	var seatClassCode = $('#seatClassCode').val();
	if (flightNo == null || flightNo == '') {
		alert('请输入改签航班号');
		return;
	}
	if (seatClassCode == null || seatClassCode == '') {
		alert('请输入改签航班舱位');
		return;
	}
	if (departDate == null || departDate == '') {
		alert('请输入改签航班日期');
		return;
	}
	// pnr空值校验
	if (indexCtmtPnr() != 0) {
		alert('请输入改签PNR');
		return;
	}
	// 票号空值校验
	if (indexCtmtTicketNo() != 0) {
		alert('请输入改签票号');
		return;
	}
	// 供应商政策NO空值校验
	if (indexctmtSuppPolicyNo() != 0) {
		alert('请输入改签供应商政策ID');
		return;
	}
	// pnr是否重复值校验
	if (arrayCtmtPnr() != 0) {
		alert('请输入相同的PNR');
		return;
	}
	// 供应商政策NO是否重复值校验
	if (arrayCtmtSuppPolicyNo() != 0) {
		alert('请输入相同的供应商政策ID');
		return;
	}
	//应付金额校验
	if(parseFloat($('#ctmtPrepaidAmountSpan').text()) < 0)
	{
		alert('应付金额小于0，请重新修改！');
		return;
	}	
	if (confirm('确认审核通过?')) {
		// 锁住
		$("#ctmtAuditPass").css('cursor', 'no-drop');
		$.ajax({
			url : url,
			type : 'POST',
			contentType : "application/json;",
			dataType : 'json',
			data : JSON.stringify({
				orderMainId : $('#orderMainId').val(),
				orderId : $('#orderId').val(),
				auditOpId : $('#auditOpId').val(),
				departDate : $('#departDate').val(),
				flightNo : $('#flightNo').val(),
				seatClassCode : $('#seatClassCode').val(),
				flightOrderDetails : ctmtOrderDetails()
			}),
			success : function(data) {
				if (data.status == 'SUCCESS') {
					alert('改签审核通过成功');
					// window.location.reload();
					window.close();
				} else {
					alert('改签审核通过失败');
					$("#ctmtAuditPass").css('cursor', 'pointer');
				}
			}
		});
	}
}

/**
 * 改签审核驳回
 * 
 * @param url
 */
function ctmtAuditReject(url) {
	if ($("#ctmtAuditReject").css('cursor') == 'no-drop')
		return;
	if (confirm('确认审核驳回?')) {
		// 锁住
		$("#ctmtAuditReject").css('cursor', 'no-drop');
		$.ajax({
			url : url,
			type : 'POST',
			contentType : "application/json;",
			dataType : 'json',
			data : JSON.stringify({
				orderMainId : $('#orderMainId').val(),
				orderId : $('#orderId').val(),
				auditOpId : $('#auditOpId').val(),
				flightOrderDetails : ctmtOrderDetails()
			}),
			success : function(data) {
				if (data.status == 'SUCCESS') {
					alert('改签审核驳回成功');
					window.close();
				} else {
					alert('改签审核驳回失败');
					$("#ctmtAuditReject").css('cursor', 'pointer');
				}
			}
		});
	}
}

/**
 * 改签处理通过
 * 
 * @param url
 */
function ctmtOpPass(url) {
	if ($("#ctmtOpPass").css('cursor') == 'no-drop')
		return;
	// pnr空值校验
	if (indexCtmtPnr() != 0) {
		alert('请输入改签PNR');
		return;
	}
	// 票号空值校验
	if (indexCtmtTicketNo() != 0) {
		alert('请输入改签票号');
		return;
	}
	// 供应商政策NO空值校验
	if (indexctmtSuppPolicyNo() != 0) {
		alert('请输入改签供应商政策ID');
		return;
	}
	// pnr是否重复值校验
	if (arrayCtmtPnr() != 0) {
		alert('请输入相同的PNR');
		return;
	}
	// 供应商政策NO是否重复值校验
	if (arrayCtmtSuppPolicyNo() != 0) {
		alert('请输入相同的供应商政策ID');
		return;
	}
	if (confirm('确认处理通过?')) {
		// 锁住
		$("#ctmtOpPass").css('cursor', 'no-drop');
		$.ajax({
			url : url,
			type : 'POST',
			contentType : "application/json;",
			dataType : 'json',
			data : JSON.stringify({
				orderMainId : $('#orderMainId').val(),
				orderId : $('#orderId').val(),
				auditOpId : $('#auditOpId').val(),
				departDate : $('#departDate').val(),
				flightNo : $('#flightNo').val(),
				seatClassCode : $('#seatClassCode').val(),
				flightOrderDetails : ctmtOrderDetails()
			}),
			success : function(data) {
				if (data.status == 'SUCCESS') {
					alert('改签处理通过成功');
					window.close();
				} else {
					alert('改签处理通过失败');
					$("#ctmtOpPass").css('cursor', 'pointer');
				}
			}
		});
	}
}

/**
 * 改签处理驳回
 * 
 * @param url
 */
function ctmtOpReject(url) {
	if ($("#ctmtOpReject").css('cursor') == 'no-drop')
		return;
	if (confirm('确认处理驳回?')) {
		// 锁住
		$("#ctmtOpReject").css('cursor', 'no-drop');
		$.ajax({
			url : url,
			type : 'POST',
			contentType : "application/json;",
			dataType : 'json',
			data : JSON.stringify({
				orderMainId : $('#orderMainId').val(),
				orderId : $('#orderId').val(),
				auditOpId : $('#auditOpId').val(),
				flightOrderDetails : ctmtOrderDetails()
			}),
			success : function(data) {
				if (data.status == 'SUCCESS') {
					alert('改签处理驳回成功');
					window.close();
				} else {
					alert('改签处理驳回失败');
					$("#ctmtOpReject").css('cursor', 'pointer');
				}
			}
		});
	}
}

/**
 * 设置改签订单明细列表
 * 
 * @returns {Array}
 */
function ctmtOrderDetails() {
	var orderDetailDtos = new Array();
	var index = 0;
	$('#orderDetails tr').each(function(i) {
		if (i != 0) {
			orderDetailDtos[index++] = ctmtOrderDetail($(this));
		}
	});
	return orderDetailDtos;
}

/**
 * 设置订单明细
 * 
 * @param obj
 * @returns
 */
function ctmtOrderDetail(obj) {
	// 设置订单明细对象
	var orderDetailDto = new Object;
	orderDetailDto.id = $(obj).find("[name='detailId']").val();
	orderDetailDto.orderId = $('#orderId').val();
	// 设置订单明细改签对象
	orderDetailDto.flightOrderTicketCTMT = setCtmt(obj);
	orderDetailDto.flightOrderTicketPrice = setCtmtTicketPrice(obj);

	return orderDetailDto;
}

function setCtmt(obj) {
	var ctmt = new Object();
	ctmt.orderDetailId = $(obj).find("[name='detailId']").val();
	ctmt.id = $(obj).find("[name='ctmtId']").val();
	ctmt.ctmtPnr = $(obj).find("[name='ctmtPnr']").val(); // pnr
	ctmt.ctmtTicketNo = $(obj).find("[name='ctmtTicketNo']").val(); // 改签票号
	ctmt.fee = $(obj).find("[name='fee']").val();// 手续费
	ctmt.surcharge = $(obj).find("[name='surcharge']").val();// 服务费
	ctmt.suppPolicyNo = $(obj).find("[name='suppPolicyNo']").val();// 改签政策ID
	ctmt.bookingSource = $(obj).find("[name='bookingSource']").val();// 来源
	ctmt.prepaidAmount = $(obj).find("[name='prepaidAmount']").val(); // 应收款
	ctmt.paiclupAmount = $(obj).find("[name='paiclupAmount']").val();// 实收金额
	ctmt.payedAmount = $(obj).find("[name='payedAmount']").val();// 实付金额

	return ctmt;
}

function setCtmtTicketPrice(obj) {
	var ctmtTicketPrice = new Object();
	ctmtTicketPrice.parPrice = $(obj).find("[name='parPrice']").val(); // 改签票面价
	ctmtTicketPrice.promotion = $(obj).find("[name='promotion']").val();// 优惠金额
	ctmtTicketPrice.airportFee = $(obj).find("[name='airportFee']").val();// 机场建设费
	ctmtTicketPrice.fuelsurTax = $(obj).find("[name='fuelsurTax']").val();// 燃油费
	ctmtTicketPrice.settlePrice = $(obj).find("[name='settlePrice']").val();// 结算价

	return ctmtTicketPrice;
}
// pnr空值校验
function indexCtmtPnr() {
	var indexCtmtPnr = 0;
	$('input[name="ctmtPnr"]').each(function() {
		var ctmtPnr = $(this).val();
		if (ctmtPnr == null || ctmtPnr == '') {
			return indexCtmtPnr++;
		}
	});
	return indexCtmtPnr;
}
// pnr是否重复值校验
function arrayCtmtPnr() {
	var arrayCtmtPnr = {};
	var indexCtmt = 0;
	var flg = 0;
	$('input[name="ctmtPnr"]').each(function(i) {
		var ctmtPnr = $(this).val();
		flg = i;
		if (arrayCtmtPnr[ctmtPnr]) {
			arrayCtmtPnr[ctmtPnr]++;
		} else {
			arrayCtmtPnr[ctmtPnr] = 1;
		}
	});
	if (flg != 0) {
		for ( var k in arrayCtmtPnr) {
			if (arrayCtmtPnr[k] == 1) {
				indexCtmt++;
			}
		}
	}
	return indexCtmt;
}
// 票号空值校验
function indexCtmtTicketNo() {
	var indexCtmtTicketNo = 0;
	$('input[name="ctmtTicketNo"]').each(function() {
		var ctmtTicketNo = $(this).val();
		if (ctmtTicketNo == null || ctmtTicketNo == '') {
			return indexCtmtTicketNo++;
		}
	});
	return indexCtmtTicketNo;
}
// 供应商政策NO空值校验
function indexctmtSuppPolicyNo() {
	var indexctmtSuppPolicyNo = 0;
	$('input[name="suppPolicyNo"]').each(function() {
		var suppPolicyNo = $(this).val();
		if (suppPolicyNo == null || suppPolicyNo == '') {
			return indexctmtSuppPolicyNo++;
		}
	});
	return indexctmtSuppPolicyNo;
}
// 供应商政策NO是否重复值校验
function arrayCtmtSuppPolicyNo() {
	var arrayCtmtSuppPolicyNo = {};
	var indexCtmtNo = 0;
	var flg = 0;
	$('input[name="suppPolicyNo"]').each(function(i) {
		var suppPolicyNo = $(this).val();
		flg = i;
		if (arrayCtmtSuppPolicyNo[suppPolicyNo]) {
			arrayCtmtSuppPolicyNo[suppPolicyNo]++;
		} else {
			arrayCtmtSuppPolicyNo[suppPolicyNo] = 1;
		}
	});
	if (flg != 0) {
		for ( var k in arrayCtmtSuppPolicyNo) {
			if (arrayCtmtSuppPolicyNo[k] == 1) {
				indexCtmtNo++;
			}
		}
	}
	return indexCtmtNo;
}
