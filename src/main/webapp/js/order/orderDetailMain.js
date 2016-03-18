$(function() {
	$("#closeRePay").click(function() {
		$("#showPayResult").css("display", "none");
	});

	$("#closeOpPay").click(function() {
		$("#showPayOperate").css("display", "none");
	});

	$("#closeReRefund").click(function() {
		$("#showRefundResult").css("display", "none");
	});

	$("#closeOpRefund").click(function() {
		$("#showRefundOperate").css("display", "none");
	});
	$("#closeSmsDialog").click(function() {
		$("#smsDialog").css("display", "none");
	});
})

// 关闭，支付失败窗口
function closePayFailInfo() {
	window.location.reload();
	$("#showPayFailInfo").css("display", "none");
}

// 支付结果关闭
function canclePayResult() {
	window.location.reload();
	$("#showPayResult").css("display", "none");
}


//支付结果关闭
function closeShowToRefundFail() {
	window.location.reload();
	$("#showToRefundFail").css("display", "none");
}




// 取消支付操作
function canclePayOperate() {
	window.location.reload();
	$("#showPayOperate").css("display", "none");
}

// 点击支付操作，去调用topay,根据类型判断是正常单，改签单
function applyToPay(payUrl) {
	var orderMainIdVal = $("#orderMainId").val();
	var orderIdVal = $("#orderId").val();
	var orderNoVal = $("#orderNo").val();
	var orderNoObj = new Object();
	orderNoObj.orderNo = orderNoVal;
	var paymentIdVal = $.trim($("#orderCustomerCode").val());
	var paymentNameVal = $.trim($("#orderCustomerName").val());

	if (paymentIdVal == "" || paymentNameVal =="") {
		alert("用户不能为空，请检查！");
		return;
	}
	
	
	$.ajax({
		url : payUrl,
		type : 'post',
		dataType : "json",
		contentType : "application/json;",
		data : JSON.stringify({
			orderId : orderIdVal,
			flightOrderNo : orderNoObj,
			orderMainId : orderMainIdVal,
			payerId : paymentIdVal,
			payerName : paymentNameVal
		}),
		success : function(data) {
			var paymentNo = "";
			var payedAmount = "";

			if (data.status != "" && data.status == "SUCCESS") {
				$.each(data.results, function(i, value) {
					$("#paymentNoOperate").val(value.paymentNo);
				})

				$("input[name='payType']:checked").val("");
				$("#paymentSerialNumber").val("");
				$("#payRemark").val("");
				$("#showPayOperate").css("display", "block");
			} else {
				$("#showPayOperate").css("display", "none");

				// 显示支付失败信息
				$("#payFailInfo span").html(data.message);
				$("#showPayFailInfo").css("display", "block");

			}
		},
		error : function(data) {
			$("#showPayOperate").css("display", "none");
			// 显示支付失败信息
			$("#payFailInfo span").html(
					eval('(' + data.responseText + ')').message);
			$("#showPayFailInfo").css("display", "block");

		}
	});
}
 
// 查看
function showPayResult(payReUrl,checkRefundInfoURL) {
	var orderMainIdVal = $("#orderMainId").val();
	var orderIdVal = $("#orderId").val();
	var orderNoVal = $("#orderNo").val();
	var obj = new Object(); 
	obj.orderNo = orderNoVal;
	
	//支付查看
	$.ajax({
		url : payReUrl,
		type : 'post',
		dataType : "json",
		contentType : "application/json;",
		data : JSON.stringify({
			orderId : orderIdVal,
			flightOrderNo : obj,
			orderMainId : orderMainIdVal
		}),
		
		success : function(data) {
			var tr = $("#showPayResultCloneTr");
			if (data.status != "" && data.status == "SUCCESS") {
				$("#showPayResult").css("display", "block");
				$("#showPayOperate").css("display", "none");
				
				$.each(data.results, function(index, item) {
					// 克隆tr，每次遍历都可以产生新的tr
					var clonedTr = tr.clone();
					var _index = index;

					// 循环遍历cloneTr的每一个td元素，并赋值
					clonedTr.children("td").each(function(inner_index) {
						// 根据索引为每一个td赋值
						switch (inner_index) {
						case (0)://支付订单号
							$(this).html(item.paymentNo);
							break;
						case (1)://交易流水号
							$(this).html(item.paymentSerialNumber);
							break;
						case (2)://支付方式
							$(this).html(item.paymentType);
							break;
						case (3)://交易金额
							$(this).html(item.payedAmount);
							break;
						case (4)://支付状态
							$(this).html(item.paymentStatus);
							break;
						case (5)://订单支付状态
							$(this).html(item.orderCallbackStatus);
							break;
						case (6)://交易时间
							$(this).html(item.payedTime);
							break;
						case (7)://对账流水号
							$(this).html(item.paymentSerialNumber);
							break;
						case (8)://订单号
							$(this).html(item.flightOrderNo.orderNo);
							break;
						case (9)://引用订单号
							$(this).html(item.refNo);
							break;
						}// end switch
					});// end children.each

					// 把克隆好的tr追加原来的tr后面
					clonedTr.insertAfter(tr);
				});// end $each
				$("#showPayResultCloneTr").hide();// 隐藏id=clone的tr，因为该tr中的td没有数据，不隐藏起来会在生成的table第一行显示一个空行
				$("#showPayResultTable").show();
			} else {
				// 显示支付失败信息
				$("#payFailInfo span").html(data.message);
				$("#showPayFailInfo").css("display", "block");
			}
			
		},
		error : function(data) {
			// 显示支付失败信息
			$("#payFailInfo span").html(eval('(' + data.responseText + ')').message);
			$("#showPayFailInfo").css("display", "block");
		}
	});
	
	//---------------------------------checkPayRefundTable
	$.ajax({
		url : checkRefundInfoURL,
		type : 'post',
		dataType : "json",
		contentType : "application/json;",
		data : JSON.stringify({
			orderId : orderIdVal,
			flightOrderNo : obj,
			orderMainId : orderMainIdVal
		}),
		success : function(data) {
			var tr = $("#payRefundCloneTr");
			if (data.status != "" && data.status == "SUCCESS") {
				$.each(data.results, function(index, item) {
					// 克隆tr，每次遍历都可以产生新的tr
					var clonedTr = tr.clone();
					var _index = index;

					// 循环遍历cloneTr的每一个td元素，并赋值
					clonedTr.children("td").each(function(inner_index) {
						// 根据索引为每一个td赋值
						switch (inner_index) {
							case (0)://退款订单号
								$(this).html(item.refundNo);
								break;
							case (1)://退款流水号
								$(this).html(item.refundSerialNumber);
								break;
							case (2)://退款方式
								$(this).html(item.refundmentType);
								break;
							case (3)://退款金额
								$(this).html(item.refundAmount);
								break;
							case (4)://退款状态
								$(this).html(item.refundStatus);
								break;
							case (5)://订单退款状态
								$(this).html(item.orderCallbackStatus);
								break;
							case (6)://退款时间
								$(this).html(item.refundTime);
								break;
							case (7)://对账流水号
								$(this).html(item.refundSerialNumber);
								break;
							case (8)://订单号
								$(this).html(item.flightOrderNo.orderNo);
								break;
						}// end switch
					});// end children.each

					// 把克隆好的tr追加原来的tr后面
					clonedTr.insertAfter(tr);
				});// end $each
				$("#payRefundCloneTr").hide();// 隐藏id=clone的tr，因为该tr中的td没有数据，不隐藏起来会在生成的table第一行显示一个空行
				$("#payRefundTable").show();
				
			}else{
				$("#payRefundTable").hide();
			}
			
		},
	});
}

// 选择支付类型
function selectPayType() {
	var payTypeVal = $("input[name='payType']:checked").val();
	if (payTypeVal != "" && payTypeVal != "DUMMY" && payTypeVal != "CASH"
			&& payTypeVal != "OTHER") {
		$("#payOpNumber").css("display", "block");
	} else {
		$("#payOpNumber").css("display", "none");
	}
}

// 支付回调
function payCallBack(payUrl) {
	var payTypeVal = $("input[name='payType']:checked").val();
	var payNumberVal = $.trim($("#paymentSerialNumber").val());
	var payRemarkVal = $.trim($("#payRemark").val());
	var paymentNoOperate = $.trim($("#paymentNoOperate").val());
	if (payTypeVal == "") {
		alert("请选择支付方式");
		return;
	}

	if (payNumberVal == "" && payTypeVal != "DUMMY" && payTypeVal != "CASH"
			&& payTypeVal != "OTHER") {
		alert("请填写支付流水号");
		return;
	}

	if (confirm("是否进行支付?")) {
		$.ajax({
			url : payUrl,
			type : 'post',
			dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
				paymentSerialNumber : payNumberVal,
				paymentType : payTypeVal,
				payRemark : payRemarkVal,
				paymentNo : paymentNoOperate
			}),
			success : function(data) {
				var tr = $("#showPayResultCloneTr");
				if (data.status != "" && data.status == "SUCCESS") {
					alert("支付成功");
					$("#showPayResult").css("display", "block");
					$("#showPayOperate").css("display", "none");
					
					$.each(data.results, function(index, item) {
						// 克隆tr，每次遍历都可以产生新的tr
						var clonedTr = tr.clone();
						var _index = index;

						// 循环遍历cloneTr的每一个td元素，并赋值
						clonedTr.children("td").each(function(inner_index) {
							// 根据索引为每一个td赋值
							switch (inner_index) {
							case (0)://支付订单号
								$(this).html(item.paymentNo);
								break;
							case (1)://交易流水号
								$(this).html(item.paymentSerialNumber);
								break;
							case (2)://支付方式
								$(this).html(item.paymentType);
								break;
							case (3)://交易金额
								$(this).html(item.payedAmount);
								break;
							case (4)://支付状态
								$(this).html(item.paymentStatus);
								break;
							case (5)://订单支付状态
								$(this).html(item.orderCallbackStatus);
								break;
							case (6)://交易时间
								$(this).html(item.payedTime);
								break;
							case (7)://对账流水号
								$(this).html(item.paymentSerialNumber);
								break;
							case (8)://订单号
								$(this).html(item.flightOrderNo.orderNo);
								break;
							}// end switch
						});// end children.each

						// 把克隆好的tr追加原来的tr后面
						clonedTr.insertAfter(tr);
					});// end $each
					$("#showPayResultCloneTr").hide();// 隐藏id=clone的tr，因为该tr中的td没有数据，不隐藏起来会在生成的table第一行显示一个空行
					$("#showPayResultTable").show();
				} else {
					// 显示支付失败信息
					$("#payFailInfo span").html(data.message);
					$("#showPayFailInfo").css("display", "block");
				}
			},
			error : function(data) {
				$("#showPayFailInfo").css("display", "block");
				$("#payFailInfo span").html(eval('(' + data.responseText + ')').message);
			}
		});
	}
}

// 退款结果关闭
function cancleRefundResult() {
	window.location.reload();
	$("#showRefundResult").css("display", "none");
}

// 取消退款操作
function cancleRefundOperate() {
	window.location.reload();
	$("#showRefundOperate").css("display", "none");
}

// 退款操作
function showRefundOperateClick() {
	$("input[name='refundType']:checked").val("");
	$("#refundSerialNumber").val("");
	$("#refundRemark").val("");
	$("#showRefundOperate").css("display", "block");
}

// 去退款->toRefund
function toRefund(refundUrl) {
	var orderMainIdVal = $("#orderMainId").val();
	var orderIdVal = $("#orderId").val();
	var orderNoVal = $("#orderNo").val();

	var orderNoObj = new Object();
	orderNoObj.orderNo = orderNoVal;

	$.ajax({
		url : refundUrl,
		type : 'post',
		dataType : "json",
		contentType : "application/json;",
		data : JSON.stringify({
			orderId : orderIdVal,
			flightOrderNo : orderNoObj,
			orderMainId : orderMainIdVal,
		}),
		success : function(data) {
			var refundIds = "";

			$("#showRefundOperate").css("display", "block");

			var tr = $("#showRefundOperateCloneTr");
			if (data.status != "" && data.status == "SUCCESS") {
				var length = data.results.length;
				$.each(data.results, function(index, item) {
					if(index==(length-1)){
						refundIds=refundIds+item.id
					}else{
						refundIds=refundIds+item.id+","
					}
					
					// 克隆tr，每次遍历都可以产生新的tr
					var clonedTr = tr.clone();
					var _index = index;

					// 循环遍历cloneTr的每一个td元素，并赋值
					clonedTr.children("td").each(function(inner_index) {
						// 根据索引为每一个td赋值
						switch (inner_index) {
							case (0)://退款订单号
								$(this).html(item.refundNo);
								break;
							case (1)://退款流水号
								$(this).html(item.refundSerialNumber);
								break;
							case (2)://退款方式
								$(this).html(item.refundmentType);
								break;
							case (3)://退款金额
								$(this).html(item.refundAmount);
								break;
							case (4)://退款状态
								$(this).html(item.refundStatus);
								break;
							case (5)://订单退款状态
								$(this).html(item.orderCallbackStatus);
								break;
							case (6)://退款时间
								$(this).html(item.refundTime);
								break;
							case (7)://对账流水号
								$(this).html(item.refundSerialNumber);
								break;
							case (8)://订单号
								$(this).html(item.flightOrderNo.orderNo);
								break;
						}// end switch
					});// end children.each

					// 把克隆好的tr追加原来的tr后面
					clonedTr.insertAfter(tr);
				});// end $each
				$("#showRefundOperateCloneTr").hide();// 隐藏id=clone的tr，因为该tr中的td没有数据，不隐藏起来会在生成的table第一行显示一个空行
				$("#showRefundOperateTable").show();
				
				
				//保存退款单号集合
				$("#refundIds").val(refundIds);
				
			} else {
				$("#showRefundOperate").css("display", "none");

				// 显示退款失败信息
				$("#toRefundFail span").html(data.message);
				$("#showToRefundFail").css("display", "block");

			}
		},
		error : function(data) {
			$("#showRefundOperate").css("display", "none");

			// 显示退款失败信息
			$("#showToRefundFail").css("display", "block");
			$("#toRefundFail span").html(eval('(' + data.responseText + ')').message);
		}
	});
}

// 查看<退款>
function showRefundInfo(refundUrl) {
	var orderMainIdVal = $("#orderMainId").val();
	var orderIdVal = $("#orderId").val();
	var orderNoVal = $("#orderNo").val();

	var orderNoObj = new Object();
	orderNoObj.orderNo = orderNoVal;
	$("#showToRefundFail").css("display", "none");

	$.ajax({
		url : refundUrl,
		type : 'post',
		dataType : "json",
		contentType : "application/json;",
		data : JSON.stringify({
			orderId : orderIdVal,
			flightOrderNo : orderNoObj,
			orderMainId : orderMainIdVal
		}),
		success : function(data) {
			var tr = $("#showRefundResultCloneTr");
			if (data.status != "" && data.status == "SUCCESS") {
				$("#showRefundResult").css("display", "block");
				
				$.each(data.results, function(index, item) {
					// 克隆tr，每次遍历都可以产生新的tr
					var clonedTr = tr.clone();
					var _index = index;

					// 循环遍历cloneTr的每一个td元素，并赋值
					clonedTr.children("td").each(function(inner_index) {
						// 根据索引为每一个td赋值
						switch (inner_index) {
							case (0)://退款订单号
								$(this).html(item.refundNo);
								break;
							case (1)://退款流水号
								$(this).html(item.refundSerialNumber);
								break;
							case (2)://退款方式
								$(this).html(item.refundmentType);
								break;
							case (3)://退款金额
								$(this).html(item.refundAmount);
								break;
							case (4)://退款状态
								$(this).html(item.refundStatus);
								break;
							case (5)://订单退款状态
								$(this).html(item.orderCallbackStatus);
								break;
							case (6)://退款时间
								$(this).html(item.refundTime);
								break;
							case (7)://对账流水号
								$(this).html(item.refundSerialNumber);
								break;
							case (8)://订单号
								$(this).html(item.flightOrderNo.orderNo);
								break;
						}// end switch
					});// end children.each

					// 把克隆好的tr追加原来的tr后面
					clonedTr.insertAfter(tr);
				});// end $each
				$("#showRefundResultCloneTr").hide();// 隐藏id=clone的tr，因为该tr中的td没有数据，不隐藏起来会在生成的table第一行显示一个空行
				$("#showRefundResultTable").show();
				
			} else {
				// 显示退款失败信息
				$("#toRefundFail span").html(data.message);
				$("#showToRefundFail").css("display", "block");

			}
			
		},
		error : function(data) {
			// 显示退款失败信息
			$("#toRefundFail span").html(data.message);
			$("#showToRefundFail").css("display", "block");
		}
	});
}

// 选择退款类型
function selectRefundType() {
	var refundTypeVal = $("input[name='refundType']:checked").val();
	if (refundTypeVal != "" && refundTypeVal != "DUMMY"
			&& refundTypeVal != "CASH" && refundTypeVal != "OTHER") {
		$("#refundOpNumber").css("display", "block");
	} else {
		$("#refundOpNumber").css("display", "none");
	}
}

// 退款回调
function refund(refundOpUrl) {
	var refundRemarkVal = $.trim($("#refundRemark").val());
	var refundIds = $("#refundIds").val();

	if (confirm("是否进行退款?")) {
		$
				.ajax({
					url : refundOpUrl,
					type : 'post',
					dataType : "json",
					contentType : "application/json;",
					data : JSON.stringify({
						refundRemark : refundRemarkVal,
						refundIds:refundIds
					}),
					success : function(data) {
						if (data.status != "" && data.status == "SUCCESS") {
							alert("申请退款成功,请查看详情!");
						} else {
							alert("申请退款失败,请查看详情!");
						}
						
						$("#showRefundOperate").css("display", "none");
						$("#showToRefundFail").css("display", "none");
						
						window.location.reload();
						showRefundInfo('${request.contextPath}/order/searchOrderRefundInfoAjax')
					},
					error : function(data) {
						$("#showRefundOperate").css("display", "none");
						// 显示退款失败信息
						$("#toRefundFail span").html(data.message);
						$("#showToRefundFail").css("display", "block");
					}
				});
	}
}


// 选取订单取消原因
function selectClear() {
	var cancelNameVal = $("input[name='cancel']:checked").val();
	$("#cancelRemark").val(cancelNameVal);
}

// 订单取消
function cancelOrder(url) {
	if ($("#cancel_Order").css('cursor') == 'no-drop')
		return;
	var remarkVal = $('#cancelRemark').val();
	if (remarkVal == "") {
		alert("取消备注不能为空,请选择和填写取消原因！");
		return;
	}
	// 锁住
	$("#cancel_Order").css('cursor', 'no-drop');
	$.ajax({
		url : url,
		cache : false,
		async : false,
		type : 'post',
		dataType : "json",
		contentType : "application/json;",
		data : JSON.stringify({
			orderId : $('#orderId').val(),
			flightOrderRemarkDto : setFlightOrderRemark()
		}),
		success : function(data) {
			if (data != "" && data.status == "SUCCESS") {
				alert("订单取消成功！");
			} else {
				alert("订单取消失败,请验证信息后继续操作！");
			}
			window.location.reload();
		}
	});
}

// 设置备注信息
function setFlightOrderRemark() {
	var remarkDto = new Object;
	remarkDto.remark = $('#cancelRemark').val();
	remarkDto.orderMainId = $('#orderMainId').val();
	remarkDto.orderId = $('#orderId').val();
	remarkDto.remarkType = "CANCEL";
	var flightOrderNo = new Object;
	flightOrderNo.orderNo = $('#orderNo').val();
	remarkDto.flightOrderNo = flightOrderNo;

	return remarkDto;
}

// 短信发送
function openSmsDialog() {
	$("#smsDialog").css("display", "block");
}
// 短信发送关闭
function closeSmsDialog() {
	// window.location.reload();
	$("#smsDialog").css("display", "none");

}
// 展示订单PNR文本信息
function openPnrText(orderId,pnrId,url) {
	$.ajax({
	 	type:'post',
		url:url+'/'+orderId+'/'+pnrId,
		dataType:'html',
		success : function(data)
		{
			$("#pnrText_div").html(data);
			$("#pnrText").css("display", "block");
	 	}
	});
}

// 关闭订单PNR文本信息
function closePnrText() {
	$("#pnrText").css("display", "none");
}

// 保存订单PNR文本信息
function savePnrText(url) {
	$.ajax({
		url : url,
		type : "post",
		dataType : "json",
		contentType : "application/json;",
		data : JSON.stringify({
			flightOrderPNRInfoRequest : setFlightOrderPNRInfoRequest()
		}),
		success : function(data) {
			if(data == 'SUCCESS'){
				alert("保存成功！");
				$("#pnrText").css("display", "none");
			}else{
				alert("保存失败！");
			}
		}
	}); 
}

function setFlightOrderPNRInfoRequest() {
	var pnrId = $("#pnrId").val();
	var pnrTxt = $("#pnrTxt").val();
	var flightOrderPNRInfoRequest = new Object;
	flightOrderPNRInfoRequest.pnrId = pnrId;
	flightOrderPNRInfoRequest.pnrTxt = pnrTxt;
	return flightOrderPNRInfoRequest;
}

function changeSmsType(smsTypeName, url) {
	$.ajax({
		url : url + $("#orderId").val() + '/' + smsTypeName,
		type : 'post',
		dataType : "json",
		contentType : "application/json;",
		success : function(data) {
			// alert(data.content);
			$("#smsContent").val(data.content);
		}
	});
}

function sendSms(url) {

	// alert(orderId+smsTypeName+mobile+smsContent)
	var smsContent = $("#smsContent").val();
	if (smsContent == '发送内容····') {
		alert("发送内容不能为空!");
		return;
	}

	$.ajax({
		url : url,
		dataType : "json",
		contentType : "application/json;",
		type : "POST",
		data : JSON.stringify({
			smsSendRequest : setSmsSendRequest()
		}),
		success : function(data) {
			// alert(data.flag);
			if (data.flag == 'true') {
				alert("发送成功！");
				$("#smsDialog").css("display", "none");
			} else {
				alert("发送失败！");

			}
		}
	}); // ajax-end

}

function setSmsSendRequest() {
	var orderId = $("#orderId").val();
	var smsTypeName = $("#smsTypeName").val();
	var mobile = $("#smsMobile").val();
	var smsContent = $("#smsContent").val();
	var smsSendRequest = new Object;
	smsSendRequest.orderId = orderId;
	smsSendRequest.smsType = smsTypeName;
	smsSendRequest.mobile = mobile;
	smsSendRequest.smsContent = smsContent;
	return smsSendRequest;
}

//人工延后取消订单时间，更改limitime
function openLimitDialog() {
	$("#limitTimeDialog").css("display", "block");
}
// 短信发送关闭
function closelimitTimeDialog() {
	// window.location.reload();
	$("#limitTimeDialog").css("display", "none");

}


function editLimtTime(url) {

	// alert(orderId+smsTypeName+mobile+smsContent)
	var limitTime = $("#limitTime").val();
	if (limitTime == '') {
		alert("内容不能为空!");
		return;
	}

	$.ajax({
		url : url,
		dataType : "json",
		contentType : "application/json;",
		type : "POST",
		data : JSON.stringify({
			flightOrderCancelRequest : setflightOrderCancelRequest()
		}),
		success : function(data) {
			// alert(data.flag);
			if (data.flag == 'true') {
				alert("成功！");
				$("#limitTimeDialog").css("display", "none");
			} else {
				alert("失败！");
				$("#limitTimeDialog").css("display", "none");

			}
		}
	}); // ajax-end

}

function setflightOrderCancelRequest(){
	var orderId = $("#orderId").val();
	var limitTime = $("#limitTime").val();
	var request = new Object;
	request.orderId = orderId;
	request.limitTime = limitTime;

	return request;
	
}
