<#if base.orderType == 'NORMAL'>
	<table id="orderDetails">
		<tr>
			<th width="1%"><input type="checkbox" class="checkAll"  id="checkedAll"/></th>
		    <th width="4%">PNR</th>
			<th width="3%">类型</th>
			<th width="4%">姓名</th>
			<th width="5%">证件类型</th>
			<th width="6%">证件号码</th>
			<th width="6%">出生日期</th>
			<th width="6%">手机号码</th>
			<th width="6%">票号</th>
			<th width="4%">票面价</th>
			<th width="4%">优惠金额</th>
			<th width="4%">机建费</th>
			<th width="4%">燃油费</th>
			<th width="5%">出票手续费</th>
			<th width="5%">出票服务费</th>
			<th width="3%">销售价</th>
			<th width="3%">结算价</th>
			<th width="5%">供应商</th>
			<th width="6%">供应商政策ID</th>
			<th width="4%">行程单</th>
			<th width="5%">机票状态</th>
			<th width="4%">实收金额</th>
			<th width="4%">实付金额</th>
		</tr>
		<#if info.flightOrderDetails??> 
		<#list info.flightOrderDetails as orderdetail>
		<tr>
			<input type="hidden" name="detailId" value="${orderdetail.id}" />
			<input type="hidden" name="issueId" value="${(orderdetail.flightOrderTicketIssue.id)!''}" />
			<td><input type="checkbox" name="orderDetailId" class="check-sub" value="${orderdetail.id}"/></td>
			<td>
				<a href="javascript:void(0);" onclick="openPnrText('${orderdetail.orderId}','${(orderdetail.flightOrderPNRInfo.id)!''}','${request.contextPath}/order/queryPnrText')">
				${(orderdetail.flightOrderPNRInfo.pnr)!''}</a>
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
				${(orderdetail.flightOrderTicketPrice.parPrice)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketPrice.promotion)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketPrice.airportFee)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketPrice.fuelsurTax)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketIssue.fee)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketIssue.surcharge)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketPrice.salesPrice)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketPrice.settlePrice)!0}
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
			<td>
				${(orderdetail.flightOrderTicketIssue.paiclupAmount)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketIssue.payedAmount)!0}
			</td>
		</tr>
		</#list> 
		</#if>
		
		
		
		
	</table>
<#elseif base.orderType == 'RTVT'>
	<table id="orderDetails">
		<tr>
			<th width="1%"><input type="checkbox" class="checkAll"  id="checkedAll"/></th>
		    <th width="4%">PNR</th>
			<th width="3%">类型</th>
			<th width="4%">姓名</th>
			<th width="5%">证件类型</th>
			<th width="6%">证件号码</th>
			<th width="6%">出生日期</th>
			<th width="6%">手机号码</th>
			<th width="4%">票号</th>
			<th width="4%">票面价</th>
			<th width="4%">优惠金额</th>
			<th width="4%">机建费</th>
			<th width="4%">燃油费</th>
			<th width="5%">退票手续费</th>
			<th width="5%">退票服务费</th>
			<th width="4%">应退金额</th>
			<th width="4%">实退金额</th>
			<th width="5%">供应商应退</th>
			<th width="4%">供应实退</th>
			<th width="5%">供应商</th>
			<th width="5%">供应商政策ID</th>
			<th width="4%">行程单</th>
			<th width="5%">机票状态</th>
		</tr>
	   	<#if info.flightOrderDetails??>
		<#list info.flightOrderDetails as orderdetail>
		<tr>
			<input type="hidden" name="detailId" value="${orderdetail.id}"/>
		    <input type="hidden" name="rtvtId" value="${(orderdetail.flightOrderDetailRTVT.id)!''}"/>
		    <td><input type="checkbox" name="orderDetailId" class="check-sub" value="${orderdetail.id}"/></td>
			<td>
				<a href="javascript:void(0);" onclick="openPnrText('${orderdetail.orderId}','${(orderdetail.flightOrderPNRInfo.id)!''}','${request.contextPath}/order/queryPnrText')">
				${(orderdetail.flightOrderPNRInfo.pnr)!''}</a>
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
				${(orderdetail.flightOrderTicketPrice.parPrice)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketPrice.promotion)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketPrice.airportFee)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketPrice.fuelsurTax)!0}
			</td>
			<td>
				${(orderdetail.flightOrderDetailRTVT.fee)!0}
			</td>
			<td>
				${(orderdetail.flightOrderDetailRTVT.surcharge)!0}
			</td>
			<td>
				${(orderdetail.flightOrderDetailRTVT.refundAmount)!0}
			</td>
			<td>
				${(orderdetail.flightOrderDetailRTVT.actualRefundAmount)!0}
			</td>
			<td>
				${(orderdetail.flightOrderDetailRTVT.supplierRefundAmount)!0}
			</td>
			<td>
				${(orderdetail.flightOrderDetailRTVT.supplierActualRefundAmount)!0}
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
<#elseif base.orderType == 'CTMT'>
	<table id="orderDetails">
		<tr>
			<th width="1%"><input type="checkbox" class="checkAll"  id="checkedAll"/></th>
		    <th width="4%">PNR</th>
			<th width="3%">类型</th>
			<th width="4%">姓名</th>
			<th width="5%">证件类型</th>
			<th width="6%">证件号码</th>
			<th width="6%">出生日期</th>
			<th width="6%">手机号码</th>
			<th width="6%">票号</th>
			<th width="4%">票面价</th>
			<th width="4%">优惠金额</th>
			<th width="4%">机建费</th>
			<th width="4%">燃油费</th>
		    <th width="5%">改签手续费</th>
		    <th width="5%">改签服务费</th>
			<th width="4%">应收款</th>
		    <th width="4%">结算价</th>
			<th width="5%">供应商</th>
			<th width="6%">供应商政策ID</th>
			<th width="4%">行程单</th>
			<th width="5%">机票状态</th>
			<th width="4%">实收金额</th>
			<th width="4%">实付金额</th>
		</tr>
		<#if info.flightOrderDetails??> 
		<#list info.flightOrderDetails as orderdetail>
		<tr>
			<input type="hidden" name="detailId" value="${orderdetail.id}" />
			<input type="hidden" name="ctmtId" value="${orderdetail.flightOrderTicketCTMT.id}" />
			<td><input type="checkbox" name="orderDetailId" class="check-sub" value="${orderdetail.id}"/></td>
			<td>
				<a href="javascript:void(0);" onclick="openPnrText('${orderdetail.orderId}','${(orderdetail.flightOrderPNRInfo.id)!''}','${request.contextPath}/order/queryPnrText')">
				${(orderdetail.flightOrderTicketCTMT.ctmtPnr)!''}</a>
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
				${(orderdetail.flightOrderTicketCTMT.ctmtTicketNo)!''}
			</td>
			<td>
				${(orderdetail.flightOrderTicketPrice.parPrice)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketPrice.promotion)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketPrice.airportFee)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketPrice.fuelsurTax)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketCTMT.fee)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketCTMT.surcharge)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketCTMT.prepaidAmount)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketPrice.settlePrice)!0}
			</td>
			<td>
			   ${(orderdetail.combinationDetail.flightOrderFlightPolicy.supp.code)!''}
			</td>
			<td>
				${(orderdetail.flightOrderTicketCTMT.suppPolicyNo)!''}
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
			<td>
				${(orderdetail.flightOrderTicketCTMT.paiclupAmount)!0}
			</td>
			<td>
				${(orderdetail.flightOrderTicketCTMT.payedAmount)!0}
			</td>
		</tr>
		</#list> 
		</#if>
	</table>
</#if>	
<div id="pnrText_div"></div> 