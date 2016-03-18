/**
 * 同步供应商出票信息
 * 
 * @param url
 */
function syncSuppIssue(applyUrl) {
	if ($("#syncSuppIssueButton").css('cursor') == 'no-drop')
		return;
	if (confirm('确认提交同步?')) {
		// 锁住
		$("#syncSuppIssueButton").css('cursor', 'no-drop');
		$.ajax({
			url : applyUrl,
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
				suppOrderNos : setSuppOrderNos()
			}),
			success : function(data) {
				if (data.status == 'SUCCESS') {
					alert('供应商出票成功');
					window.close();
				} else {
					alert('抱歉，供应商暂未出票,请稍后再试');
					$("#syncSuppIssueButton").css('cursor', 'pointer');
				}
			},
			error : function(data) {
				alert(eval('(' + data.responseText + ')').message);
			}
		});
	}
}

function setSuppOrderNos() {
	var suppOrderNos = new Array();
	var index = 0;
	$('input[id="applySuppIssue"]').each(function(i) {
		suppOrderNos[index++] = setSuppOrderNo($(this));
	});
	return suppOrderNos;
}

function setSuppOrderNo(obj) {
	var suppOrderNo = new Object;
	suppOrderNo = $(obj).val();
	return suppOrderNo;
}
/**
 * 出票审核通过
 * 
 * @param url
 */
function issueAuditPass(url) {
	if ($("#issueAuditPass").css('cursor') == 'no-drop')
		return;
	// pnr空值校验
	if (indexIssuePnr() != 0) {
		alert('请输入PNR');
		return;
	}
	// 票号空值校验
	if (indexIssueTicketNo() != 0) {
		alert('请输入票号');
		return;
	}
	// 结算价空值校验
	if (indexIssueSettlePrice() != 0) {
		alert('请输入结算价');
		return;
	}
	// 供应商政策NO空值校验
	if (indexIssueSuppPolicyNo() != 0) {
		alert('请输入供应商政策ID');
		return;
	}
	// 实付金额空值校验
	if (indexIssuePayedAmount() != 0) {
		alert('请输入实付金额');
		return;
	}
	// pnr是否重复值校验
	if (arrayIssuePnr() != 0) {
		alert('请输入相同的PNR');
		return;
	}
	// 供应商政策NO是否重复值校验
	if (arrayIssueSuppPolicyNo() != 0) {
		alert('请输入相同的供应商政策ID');
		return;
	}
	if (confirm('确认审核通过?')) {
		// 锁住
		$("#issueAuditPass").css('cursor', 'no-drop');
		$.ajax({
			url : url,
			type : 'POST',
			contentType : "application/json;",
			dataType : 'json',
			data : JSON.stringify({
				orderMainId : $('#orderMainId').val(),
				orderId : $('#orderId').val(),
				auditOpId : $('#auditOpId').val(),
				flightOrderDetails : issueOrderDetails()
			}),
			success : function(data) {
				if (data.status == 'SUCCESS') {
					alert('出票审核通过成功');
					window.close();
				} else {
					alert('出票审核通过失败');
					$("#issueAuditPass").css('cursor', 'pointer');
				}
			}
		});
	}
}

/**
 * 出票审核驳回
 * 
 * @param url
 */
function issueAuditReject(url) {
	if ($("#issueAuditReject").css('cursor') == 'no-drop')
		return;
	if (confirm('确认审核驳回?')) {
		// 锁住
		$("#issueAuditReject").css('cursor', 'no-drop');
		$.ajax({
			url : url,
			type : 'POST',
			contentType : "application/json;",
			dataType : 'json',
			data : JSON.stringify({
				orderMainId : $('#orderMainId').val(),
				orderId : $('#orderId').val(),
				auditOpId : $('#auditOpId').val(),
				flightOrderDetails : issueOrderDetails()
			}),
			success : function(data) {
				if (data.status == 'SUCCESS') {
					alert('出票审核驳回成功');
					window.close();
				} else {
					alert('出票审核驳回失败');
					$("#issueAuditReject").css('cursor', 'pointer');
				}
			}
		});
	}
}

/**
 * 出票处理通过
 * 
 * @param url
 */
function issueOpPass(url) {
	if ($("#issueOpPass").css('cursor') == 'no-drop')
		return;
	// pnr空值校验
	if (indexIssuePnr() != 0) {
		alert('请输入PNR');
		return;
	}
	// 票号空值校验
	if (indexIssueTicketNo() != 0) {
		alert('请输入票号');
		return;
	}
	// 结算价空值校验
	if (indexIssueSettlePrice() != 0) {
		alert('请输入结算价');
		return;
	}
	// 供应商政策NO空值校验
	if (indexIssueSuppPolicyNo() != 0) {
		alert('请输入供应商政策ID');
		return;
	}
	// 实付金额空值校验
	if (indexIssuePayedAmount() != 0) {
		alert('请输入实付金额');
		return;
	}
	// pnr是否重复值校验
	if (arrayIssuePnr() != 0) {
		alert('请输入相同的PNR');
		return;
	}
	// 供应商政策NO是否重复值校验
	if (arrayIssueSuppPolicyNo() != 0) {
		alert('请输入相同的供应商政策ID');
		return;
	}
	if (confirm('确认处理通过?')) {
		// 锁住
		$("#issueOpPass").css('cursor', 'no-drop');
		$.ajax({
			url : url,
			type : 'POST',
			contentType : "application/json;",
			dataType : 'json',
			data : JSON.stringify({
				orderMainId : $('#orderMainId').val(),
				orderId : $('#orderId').val(),
				auditOpId : $('#auditOpId').val(),
				flightOrderDetails : issueOrderDetails()
			}),
			success : function(data) {
				if (data.status == 'SUCCESS') {
					alert('出票处理通过成功');
					window.close();
				} else {
					alert('出票处理通过失败');
					$("#issueOpPass").css('cursor', 'pointer');
				}
			}
		});
	}
}

/**
 * 出票处理驳回
 * 
 * @param url
 */
function issueOpReject(url) {
	if ($("#issueOpReject").css('cursor') == 'no-drop')
		return;
	if (confirm('确认处理驳回?')) {
		// 锁住
		$("#issueOpReject").css('cursor', 'no-drop');
		$.ajax({
			url : url,
			type : 'POST',
			contentType : "application/json;",
			dataType : 'json',
			data : JSON.stringify({
				orderMainId : $('#orderMainId').val(),
				orderId : $('#orderId').val(),
				auditOpId : $('#auditOpId').val(),
				flightOrderDetails : issueOrderDetails()
			}),
			success : function(data) {
				if (data.status == 'SUCCESS') {
					alert('出票处理驳回成功');
					window.close();
				} else {
					alert('出票处理驳回失败');
					$("#issueOpReject").css('cursor', 'pointer');
				}
			}
		});
	}
}

/**
 * 设置出票订单明细列表
 * 
 * @returns {Array}
 */
function issueOrderDetails() {
	var orderDetailDtos = new Array();
	var index = 0;
	$('#orderDetails tr').each(function() {
		var $TypeFake = $(this).find('td').eq(0).find('input').val();
		if (typeof ($TypeFake) == "undefined") {
			return true;
		}
		orderDetailDtos[index++] = issueOrderDetail($(this));
	});
	return orderDetailDtos;
}

/**
 * 设置订单明细
 * 
 * @param obj
 * @returns
 */
function issueOrderDetail(obj) {
	// 设置订单明细对象
	var orderDetailDto = new Object;
	orderDetailDto.id = $(obj).find("[name='detailId']").val();
	orderDetailDto.orderId = $('#orderId').val();
	// 设置订单明细出票对象
	orderDetailDto.flightOrderTicketIssue = setIssue(obj);
	orderDetailDto.flightOrderTicketPrice = setIssueTicketPrice(obj);

	return orderDetailDto;
}

function setIssue(obj) {
	var issue = new Object();
	issue.orderDetailId = $(obj).find("[name='detailId']").val();
	issue.id = $(obj).find("[name='issueId']").val();
	issue.issuePnr = $(obj).find("[name='issuePnr']").val(); // pnr
	issue.issueTicketNo = $(obj).find("[name='issueTicketNo']").val(); // 改签票号
	//issue.fee = $(obj).find("[name='fee']").val();// 手续费
	//issue.surcharge = $(obj).find("[name='surcharge']").val();// 服务费
	issue.suppPolicyNo = $(obj).find("[name='suppPolicyNo']").val();// 改签政策ID
	issue.bookingSource = $(obj).find("[name='bookingSource']").val();// 来源
	//issue.paiclupAmount = $(obj).find("[name='paiclupAmount']").val();// 实收金额
	issue.payedAmount = $(obj).find("[name='payedAmount']").val();// 实付金额

	return issue;
}

function setIssueTicketPrice(obj) {
	var issueTicketPrice = new Object();
	//issueTicketPrice.parPrice = $(obj).find("[name='parPrice']").val(); // 票面价
	//issueTicketPrice.promotion = $(obj).find("[name='promotion']").val();// 优惠金额
	//issueTicketPrice.airportFee = $(obj).find("[name='airportFee']").val();// 机场建设费
	//issueTicketPrice.fuelsurTax = $(obj).find("[name='fuelsurTax']").val();// 燃油费
	//issueTicketPrice.salesPrice = $(obj).find("[name='salesPrice']").val();// 销售价
	issueTicketPrice.settlePrice = $(obj).find("[name='settlePrice']").val();// 结算价

	return issueTicketPrice;
}
// pnr空值校验
function indexIssuePnr() {
	var indexIssuePnr = 0;
	$('input[name="issuePnr"]').each(function() {
		var issuePnr = $(this).val();
		if (issuePnr == null || issuePnr == '') {
			return indexIssuePnr++;
		}
	});
	return indexIssuePnr;
}
// pnr是否重复值校验
function arrayIssuePnr() {
	var arrayIssuePnr = {};
	var indexIssue = 0;
	var flg = 0;
	$('input[name="issuePnr"]').each(function(i) {
		var issuePnr = $(this).val();
		flg = i;
		if (arrayIssuePnr[issuePnr]) {
			arrayIssuePnr[issuePnr]++;
		} else {
			arrayIssuePnr[issuePnr] = 1;
		}
	});
	if (flg != 0) {
		for ( var k in arrayIssuePnr) {
			if (arrayIssuePnr[k] == 1) {
				indexIssue++;
			}
		}
	}
	return indexIssue;
}
// 票号空值校验
function indexIssueTicketNo() {
	var indexIssueTicketNo = 0;
	$('input[name="issueTicketNo"]').each(function() {
		var issueTicketNo = $(this).val();
		if (issueTicketNo == null || issueTicketNo == '') {
			return indexIssueTicketNo++;
		}
	});
	return indexIssueTicketNo;
}

//结算价空值校验
function indexIssueSettlePrice() {
	var indexIssueSettlePrice = 0;
	$('input[name="settlePrice"]').each(function() {
		var issueSettlePrice = $(this).val();
		if (issueSettlePrice == null || issueSettlePrice == '') {
			return indexIssueSettlePrice++;
		}
	});
	return indexIssueSettlePrice;
}

//实付金额空值校验
function indexIssuePayedAmount() {
	var indexIssuePayedAmount = 0;
	$('input[name="payedAmount"]').each(function() {
		var issuePayedAmount = $(this).val();
		if (issuePayedAmount == null || issuePayedAmount == '') {
			return indexIssuePayedAmount++;
		}
	});
	return indexIssuePayedAmount;
}

// 供应商政策NO空值校验
function indexIssueSuppPolicyNo() {
	var indexIssueSuppPolicyNo = 0;
	$('input[name="suppPolicyNo"]').each(function() {
		var suppPolicyNo = $(this).val();
		if (suppPolicyNo == null || suppPolicyNo == '') {
			return indexIssueSuppPolicyNo++;
		}
	});
	return indexIssueSuppPolicyNo;
}
// 供应商政策NO是否重复值校验
function arrayIssueSuppPolicyNo() {
	var arrayIssueSuppPolicyNo = {};
	var indexIssueNo = 0;
	var flg = 0;
	$('input[name="suppPolicyNo"]').each(function(i) {
		var suppPolicyNo = $(this).val();
		flg = i;
		if (arrayIssueSuppPolicyNo[suppPolicyNo]) {
			arrayIssueSuppPolicyNo[suppPolicyNo]++;
		} else {
			arrayIssueSuppPolicyNo[suppPolicyNo] = 1;
		}
	});
	if (flg != 0) {
		for ( var k in arrayIssueSuppPolicyNo) {
			if (arrayIssueSuppPolicyNo[k] == 1) {
				indexIssueNo++;
			}
		}
	}
	return indexIssueNo;
}
