/**
 * 退票审核通过
 * @param url
 */
function rtvtAuditPass(url)
{
	if(confirm('确认退票审核通过？'))
	{
		$.ajax({
			url:url,
			type:'POST',
			contentType:"application/json;",
			data:JSON.stringify({
				orderId:$('#orderId').val(),
				auditOpId:$('#auditOpId').val(),
				orderInsuranceIds:setOrderInsuranceIds(),
				flightOrderDetails:setOrderDetails()
			}),
			dataType:'json',
			success:function(data)
			{
				if(data.status == 'SUCCESS')
				{
					alert('退票审核通过操作成功！');
					window.close();
				}	
				else
				{
					alert('退票审核通过操作失败！');
				}
			},
			error:function(data)
			{
				alert(eval('(' + data.responseText + ')').message);
			}
		});
	}	
}

/**
 * 退票审核驳回
 * @param url
 */
function rtvtAuditReject(url)
{
	if(confirm('确认退票审核驳回？'))
	{
		$.ajax({
			url:url,
			type:'POST',
			contentType:"application/json;",
			data:JSON.stringify({
				orderId:$('#orderId').val(),
				auditOpId:$('#auditOpId').val(),
				orderInsuranceIds:setOrderInsuranceIds(),
				flightOrderDetails:setOrderDetails()
			}),
			dataType:'json',
			success:function(data)
			{
				if(data.status == 'SUCCESS')
				{
					alert('退票审核驳回操作成功！');
					window.close();
				}
				else
				{
					alert('退票审核驳回操作失败！');
				}
			},
			error:function(data)
			{
				alert(eval('(' + data.responseText + ')').message);
			}
		});
	}
}

/**
 * 申请供应商退票
 * @param url
 */
function applySuppRTVT(url)
{
	if(confirm('确认申请供应商退票？'))
	{
		$.ajax({
			url:url,
			type:'post',
			dataType:'json',
			success:function(data)
			{
				if(data == 'SUCCESS')
				{
					alert('申请供应商退票操作成功！');
					window.reload();
				}
				else
				{
					alert('申请供应商退票操作失败！');
				}
			},
			error:function(data)
			{
				alert(eval('(' + data.responseText + ')').message);
			}
		});
	}	
}

/**
 * 退票处理通过
 * @param url
 */
function rtvtOpPass(url)
{
	//验证实退金额
	var actualRefundAmountFlag = true;
	$('input[name="actualRefundAmount"]').each(function()
	{
		if($.trim($(this).val()).length == 0)
		{
			actualRefundAmountFlag = false;
			$(this).focus();
			return;
		}
	});
	if(!actualRefundAmountFlag)
	{
		alert('实退金额不能为空！');
		return;
	}
	
	//验证供应商应退金额
	var supplierRefundAmountFlag = true;
	$('input[name="supplierRefundAmount"]').each(function()
	{
		if($.trim($(this).val()).length == 0)
		{
			supplierRefundAmountFlag = false;
			$(this).focus();
			return;
		}
	});
	if(!supplierRefundAmountFlag)
	{
		alert('供应商应退金额不能为空！');
		return;
	}
	
	//验证供应商实退金额
	var supplierActualRefundAmountFlag = true;
	$('input[name="supplierActualRefundAmount"]').each(function()
	{
		if($.trim($(this).val()).length == 0)
		{
			supplierActualRefundAmountFlag = false;
			$(this).focus();
			return;
		}
	});
	if(!supplierActualRefundAmountFlag)
	{
		alert('供应商实退金额不能为空！');
		return;
	}
	if(confirm('确认退票处理通过？'))
	{
		$.ajax({
			url:url,
			type:'POST',
			contentType:"application/json;",
			data:JSON.stringify({
				orderId:$('#orderId').val(),
				auditOpId:$('#auditOpId').val(),
				flightOrderDetails:setOrderDetails()
			}),
			dataType:'json',
			success:function(data)
			{
				if(data.status == 'SUCCESS')
				{
					alert('退票处理通过操作成功！');
					window.close();
				}
				else
				{
					alert('退票处理通过操作失败！');
				}
			},
			error:function(data)
			{
				alert(eval('(' + data.responseText + ')').message);
			}
		});
	}	
}

/**
 * 退票处理驳回
 * @param url
 */
function rtvtOpReject(url)
{
	if(confirm('确认退票处理驳回？'))
	{
		$.ajax({
			url:url,
			type:'POST',
			contentType:"application/json;",
			data:JSON.stringify({
				orderId:$('#orderId').val(),
				auditOpId:$('#auditOpId').val(),
				flightOrderDetails:setOrderDetails()
			}),
			dataType:'json',
			success:function(data)
			{
				if(data.status == 'SUCCESS')
				{
					alert('退票处理驳回操作成功！');
					window.close();
				}
				else
				{
					alert('退票处理驳回操作失败！');
				}
			},
			error:function(data)
			{
				alert(eval('(' + data.responseText + ')').message);
			}
		});
	}
}

/**
 * 设置退票订单明细列表
 * @returns {Array}
 */
function setOrderDetails()
{
	var orderDetails = new Array();
	var index = 0;
	$('#orderDetails tr').each(function(i)
	{
		if(i != 0)
		{
			orderDetails[index++] = setOrderDetail($(this));
		}
	});
	return orderDetails;
}

/**
 * 设置订单明细
 * @param 	obj
 * @returns
 */
function setOrderDetail(obj)
{
	//设置订单明细对象
	var orderDetail = new Object; 
	orderDetail.id = $(obj).find("input[name='detailId']").val();
	orderDetail.orderId = $('#orderId').val();
	
	//设置订单明细审核对象
	orderDetail.flightOrderDetailRTVT = setOrderDetailRTVT(obj);
	
	return orderDetail;
}

//设置订单明细审核对象
function setOrderDetailRTVT(obj)
{
	var orderDetailRTVT = new Object();
	orderDetailRTVT.id = $(obj).find("input[name='rtvtId']").val();
	orderDetailRTVT.fee = $(obj).find("input[name='fee']").val();
	orderDetailRTVT.surcharge = $(obj).find("input[name='surcharge']").val();
	orderDetailRTVT.refundAmount = $(obj).find("input[name='refundAmount']").val();
	orderDetailRTVT.actualRefundAmount = $(obj).find("input[name='actualRefundAmount']").val();
	orderDetailRTVT.supplierRefundAmount = $(obj).find("input[name='supplierRefundAmount']").val();
	orderDetailRTVT.supplierActualRefundAmount = $(obj).find("input[name='supplierActualRefundAmount']").val();
	return orderDetailRTVT;
}

//设置需要退款的订单保险主键
function setOrderInsuranceIds()
{
	var orderInsuranceIds = new Array();
	
	$('input[name="orderInsuranceId"]').each(function()
	{
		if($(this).attr('checked'))
		{
			orderInsuranceIds.push($(this).val());
		}
	});
	return orderInsuranceIds;
}

//同步供应商退票
function syncSuppRTVT(url)
{
	var suppRefundNo = $.trim($('#suppRefundNo').val());
	if(suppRefundNo.length == 0)
	{
		suppRefundNo = prompt('请输入退票单号：', '');
	}
	suppRefundNo = $.trim(suppRefundNo);
	
	if(suppRefundNo.length > 0)
	{
		url += '/'+$('#orderId').val()+'/'+suppRefundNo+'';
		$.ajax({
			url:url,
			type:'post',
			dataType:'json',
			success:function(data)
			{
				if(data.status == 'SUCCESS')
				{
					alert('同步供应商退票操作成功！');
					window.reload();
				}
				else
				{
					alert('同步供应商退票操作失败！');
				}
			},
			error:function(data)
			{
				alert(eval('(' + data.responseText + ')').message);
			}
		});
	}	
}