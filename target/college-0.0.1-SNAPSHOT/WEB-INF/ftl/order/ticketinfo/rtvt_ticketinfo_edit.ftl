<script src="${request.contextPath}/js/ticketinfo/rtvt_ticketinfo_edit.js"> </script>
<table id="orderDetails">
	<tr>
	    <th width="4%">PNR</th>
		<th width="3%">类型</th>
		<th width="4%">姓名</th>
		<th width="5%">证件类型</th>
		<th width="6%">证件号码</th>
		<th width="6%">出生日期</th>
		<th width="6%">手机号码</th>
		<th width="4%">票号</th>
		<th width="3%">票面价</th>
		<th width="5%">优惠金额</th>
		<th width="4%">机建费</th>
		<th width="4%">燃油费</th>
	    <th width="5%">退票手续费</th>
		<th width="5%">退票服务费</th>
	    <th width="4%">应退金额</th>
		<th width="4%">实退金额</th>
		<th width="5%">供应商应退</th>
		<th width="4%">供应实退</th>
		<th width="4%">供应商</th>
		<th width="6%">供应商政策ID</th>
		<th width="4%">行程单</th>
		<th width="5%">机票状态</th>
	</tr>
   	<#if info.flightOrderDetails??>
	<#list info.flightOrderDetails as orderdetail>
	<tr>
		<input type="hidden" name="detailId" value="${orderdetail.id}"/>
	    <input type="hidden" name="rtvtId" value="${(orderdetail.flightOrderDetailRTVT.id)!''}"/>
		<td>
			${(orderdetail.flightOrderPNRInfo.pnr)!''}
		</td>
		<td>
			${(orderdetail.flightOrderPassenger.passengerType.cnName)!''}
		</td>
		<td>
			${(orderdetail.flightOrderPassenger.passengerName)!''}
		</td>
		<td>
			${(orderdetail.flightOrderPassenger.passengerIDCardType.cnName)!''}
		</td>
		<td>
			${(orderdetail.flightOrderPassenger.passengerIDCardNo)!''}
		</td>
		<td>
			${(orderdetail.flightOrderPassenger.passengerBirthday?string("yyyy-MM-dd"))!''}
		</td>
		<td>
			${(orderdetail.flightOrderPassenger.cellphone)!''}
		</td>
		<td>
			${(orderdetail.flightOrderTicketInfo.ticketNo)!''}
		</td>
		<td>
			<input type="hidden" id="parPrice_${orderdetail_index}" value="${(orderdetail.flightOrderTicketPrice.parPrice)!0}"/>
			${(orderdetail.flightOrderTicketPrice.parPrice)!0}
		</td>
		<td>
			<input type="hidden" id="promotion_${orderdetail_index}" value="${(orderdetail.flightOrderTicketPrice.promotion)!0}"/>
			${(orderdetail.flightOrderTicketPrice.promotion)!0}
		</td>
		<td>
			<input type="hidden" id="airportFee_${orderdetail_index}" value="${(orderdetail.flightOrderTicketPrice.airportFee)!0}"/>
			${(orderdetail.flightOrderTicketPrice.airportFee)!0}
		</td>
		<td>
			<input type="hidden" id="fuelsurTax_${orderdetail_index}" value="${(orderdetail.flightOrderTicketPrice.fuelsurTax)!0}"/>
			${(orderdetail.flightOrderTicketPrice.fuelsurTax)!0}
		</td>
		<td>
			<input type="text" style="text-align: center;" id="fee_${orderdetail_index}" name="fee" 
				${(base.flightOrderStatus.orderAuditStatus != 'NOT_AUDIT')?string('readonly', '')} 
				value="${(orderdetail.flightOrderDetailRTVT.fee)!0}" 
				onchange="rtvtRefundAmountCalculate(${orderdetail_index});rtvtAmountCalculate(this)"/>
		</td>
		<td>
			<input type="text" style="text-align: center;" name="surcharge"	id="surcharge_${orderdetail_index}" 
				${(base.flightOrderStatus.orderAuditStatus != 'NOT_AUDIT')?string('readonly', '')}
				value="${(orderdetail.flightOrderDetailRTVT.surcharge)!0}" 
				onchange="rtvtRefundAmountCalculate(${orderdetail_index});rtvtAmountCalculate(this)"/>
		</td>
		<td>
			<input type="text" style="text-align: center;" name="refundAmount" id="refundAmount_${orderdetail_index}" 
				readonly="readonly" value="${(orderdetail.flightOrderDetailRTVT.refundAmount)!0}"/>
		</td>
		<td>
			<input type="text" style="text-align: center;" name="actualRefundAmount"
				value="${(orderdetail.flightOrderDetailRTVT.actualRefundAmount)!0}"	/>	
		</td>
		<td>
			<input type="text" style="text-align: center;" name="supplierRefundAmount" 
				value="${(orderdetail.flightOrderDetailRTVT.supplierRefundAmount)!0}"/>
		</td>
		<td>
			<input type="text" style="text-align: center;" name="supplierActualRefundAmount"
				value="${(orderdetail.flightOrderDetailRTVT.supplierActualRefundAmount)!0}"/>
		</td>
		<td>
			${(orderdetail.combinationDetail.flightOrderFlightPolicy.supp.code)!''}
		</td>
		<td>
			${(orderdetail.combinationDetail.flightOrderFlightPolicy.suppPolicyNo)!''}
		</td>
		<td>
			<#list info.bspNoMap?keys as key>
				<#if key == orderdetail.flightOrderTicketInfo.id>
					${info.bspNoMap[key]}
				</#if>
			</#list>
        </td>
		<td>
			${(orderdetail.detailTicketStatus.cnName)!''}
		</td>
	</tr>
    </#list>
   </#if>
</table>	
