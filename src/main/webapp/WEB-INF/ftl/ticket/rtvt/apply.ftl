<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"></meta>
		<link rel="stylesheet" href="${request.contextPath}/css/order-details.css"></link>
		<script type="text/javascript" src="${request.contextPath}/js/resources/jquery-1.7.1.min.js"></script>
	</head>
	<body>
	<form id="applyForm">
		<div class="content content3">
			<div class="flight-infor">
				<input type="hidden" name="orderMainId" value="${orderMainId}" id="orderMainId" /> 
				<input type="hidden" name="orderId" value="${orderId}" id="orderId" /> 
				<div class="title">乘客航班信息</div>
				<table>
					<tr>
						<th width="5%">
							<input type="checkbox" id="checkAll"/>
						</th>
						<th width="10%">乘客姓名</th>
						<th width="12%">PNR（大/小）</th>
						<th width="8%">航班号</th>
						<th width="6%">舱位</th>
						<th width="12%">票号</th>
						<th width="10%">行程单</th>
						<th width="8%">出发城市</th>
						<th width="8%">到达城市</th>
						<th width="10%">出发日期</th>
						<th width="10%">起飞时间</th>
					</tr>
					<#list orderDetailForms as orderDetailForm>
					<tr>
						<td>
							<input type="checkbox" name="flightOrderDetails[${orderDetailForm_index}].id" class="check-sub" 
								value="${orderDetailForm.id}" ${(orderDetailForm.isCanRTVT != 'true')?string('disabled', '')}/>
						</td>
						<td>${(orderDetailForm.flightOrderPassenger.passengerName)}</td>
						<td>${(orderDetailForm.flightOrderPNRInfo.pnr)!''}</td>
						<td>${(orderDetailForm.combinationDetail.flightOrderFlightInfo.flightNo)!''}</td>
						<td>${(orderDetailForm.combinationDetail.flightOrderFlightInfo.flightSeat.seatClass.code)!''}</td>
						<td>${(orderDetailForm.flightOrderTicketInfo.ticketNo)!''}</td>
						<td>
							<#list bspNoMap?keys as key>
								<#if key == orderDetailForm.flightOrderTicketInfo.id>
									${bspNoMap[key]}
								</#if>
							</#list>
						</td>
						<td>${(orderDetailForm.combinationDetail.flightOrderFlightInfo.flightAirportLine.departureAirport.city.airportCity.name)!''}</td>
						<td>${(orderDetailForm.combinationDetail.flightOrderFlightInfo.flightAirportLine.arrivalAirport.city.airportCity.name)!''}</td>
						<td>${orderDetailForm.combinationDetail.flightOrderFlightInfo.timeSegmentRange.departureTime?string("yyyy-MM-dd")}</td>
						<td>${orderDetailForm.combinationDetail.flightOrderFlightInfo.timeSegmentRange.departureTime?string("HH:mm")}</td>
					</tr>
					</#list>
	
				</table>
			</div>
			<div class="return-infor">
				<div class="title">退票信息</div>
				<div class="list">
					<div class="classify">
						退票类型： 
						<#list applyRefundTypes as applyRefundType>
							<input type="radio" name="applyRefundType" id="applyRefundType_${applyRefundType_index}" value="${applyRefundType}" /> 
							<label for="applyRefundType_${applyRefundType_index}">${applyRefundType.cnName}</label>
						</#list>
					</div>
					<div class="classify">
						是否需要取消位置： 
						<input type="radio" name="cancelPNR" id="cancelPNR_Y" value="true" />
						<label for="cancelPNR_Y">是</label> 
						<input type="radio" name="cancelPNR" id="cancelPNR_N" value="false" /> 
						<label for="cancelPNR_N">否</label> 
						<span>
							退票PNR：<input type="text" class="wide" id="rtvtPNR" />
						</span>
					</div>
					<div class="classify">
						上传附件：
						<input type="text" class="wide" /> 
							<a href=""><div class="button">选择</div></a>
					</div>
					<div class="classify">
						退票原因： <input type="text" class="wide" name="refundReason" />
					</div>
				</div>
				<div class="explain">
				 <div class="buchong">
	             <p>政策备注：<#if flightTicketRuleForm.flightPolicyRemark?exists>${(flightTicketRuleForm.suppRemark)!''}</#if><br>政策补充说明：</p>
	             </div>
		         <!--退改签规定-->
			     <div class="rule">
			         <#if flightTicketRuleForm.flightSearchTicketRuleSimple?exists>
					 <table>
						<#list flightTicketRuleForm.simpleDetails as simpleDetail>
			              <tr>
			                 <#if simpleDetail_index == 0>
			                    <td width="3%" class="hebing" rowspan="${flightTicketRuleForm.simpleDetails?size}">${flightTicketRuleForm.passengerTypeName}</td>
			                  </#if>
			                  <td width="14%">${simpleDetail.detailFeeTypeName}</td>
			                  <td width="80%" class="tal">${simpleDetail.detailFeeDesc}</td>
			              </tr>
				         </#list>
				     </table>
				     </#if>
				</div>
		        </div>
			</div>
			<div class="remark">
				<div class="title">退票备注</div>
				<div class="write">
					<textarea rows="3" name="flightOrderRemark.remark"></textarea>
				</div>
				<a href="javascript:void(0);" id="submitApplyBtn"><div class="button">提交申请</div></a>
			</div>
		</div>
	</form>
</body>
</html>
<script type="text/javascript">
	
	//全选
	$('#checkAll').click(function()
	{
		if($(this).attr('checked'))
		{
			$('.check-sub').each(function(i, obj)
			{
				if(!$(obj).attr('disabled'))
					$(obj).attr('checked', true);
			});
		}
		else
		{
			$(".check-sub").attr('checked', false);
		}
	});
	
	//选择子项点击事件
	$('.check-sub').click(function()
	{
		var flag = true;
		$('.check-sub').each(function(i, obj)
		{
			if(!$(this).attr('checked') && !$(this).attr("disabled"))
			{
				flag = false;
				return;
			}
		});
		if(flag)
			$('#checkAll').attr('checked', true);
		else
			$('#checkAll').attr('checked', false);
	})
	
	//提交申请
	$('#submitApplyBtn').click(function()
	{
		if($('#submitApplyBtn').css('cursor') == 'no-drop') return;
		
		var index = 0;
		$('.check-sub').each(function(i, obj)
		{
			if($(this).attr('checked'))
			{
				index++;
				return;
			}
		});
		if(index == 0)
		{
			alert('请选择需要退票的记录！');
			return;
		}
		
		if(!$('input:radio[name="applyRefundType"]:checked').val())
		{
			alert('请选择退票类型！');
			return;
		}
		if(!$('input:radio[name="cancelPNR"]:checked').val())
		{
			alert('请选择是否需要取消位置！');
			return;
		}
		if(confirm('确认提交申请'))
		{
			$('#submitApplyBtn').css('cursor', 'no-drop');
			$.ajax({
				url:'${request.contextPath}/ticket/rtvt/submitApply',
				type:'POST',
				data:$('#applyForm').serialize(),
				dataType:"json",
				success:function(data) 
				{
					if(data != null)
					{
						alert("提交申请成功!");
						window.close();
					} 
					else 
					{
						$('#submitApplyBtn').css('cursor', 'pointer');
						alert("提交申请失败!");
					}
				},
				error:function(data)
				{
					alert(eval('(' + data.responseText + ')').message);
				}
			});
		}
	})
</script>
