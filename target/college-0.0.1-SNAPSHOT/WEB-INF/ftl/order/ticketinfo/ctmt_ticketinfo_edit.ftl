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
		<th width="4%">优惠金额</th>
		<th width="4%">机建费</th>
		<th width="4%">燃油费</th>
		<th width="5%">改签手续费</th>
		<th width="5%">改签服务费</th>
		<th width="4%">应收款</th>
		<th width="4%">结算价</th>
		<th width="5%">供应商</th>
		<th width="7%">供应商政策ID</th>
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
		<td>
			<input type="text" name="ctmtPnr" value="${(orderdetail.flightOrderTicketCTMT.ctmtPnr)!''}" onBlur="trim(this)"/>
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
			<input type="text" name="ctmtTicketNo" value="${(orderdetail.flightOrderTicketCTMT.ctmtTicketNo)!''}" onBlur="trim(this)"/>
		</td>
		<td>
		<#if base.flightOrderStatus.orderAuditStatus == 'AUDIT_PASS'>
		${(orderdetail.flightOrderTicketPrice.parPrice)!0}
		<#else>
		<input type="text" id="parPrice_${orderdetail_index}" name="parPrice" 
				oldValue="${(orderdetail.flightOrderTicketPrice.parPrice)!0}" value="${(orderdetail.flightOrderTicketPrice.parPrice)!0}" 
				onchange="ctmtPrepaidAmountCalculate(${orderdetail_index});ctmtAmountCalculate(this)"  onkeyup="formatNumber(this)"/>
		</#if>
		</td>
		<td>
		<#if base.flightOrderStatus.orderAuditStatus == 'AUDIT_PASS'>
		${(orderdetail.flightOrderTicketPrice.promotion)!0}
		<#else>
			<input type="text" id="promotion_${orderdetail_index}" name="promotion"
				oldValue="${(orderdetail.flightOrderTicketPrice.promotion)!0}" value="${(orderdetail.flightOrderTicketPrice.promotion)!0}" 
				onchange="ctmtPrepaidAmountCalculate(${orderdetail_index});ctmtAmountCalculate(this)" onkeyup="formatNumber(this)" />
		</#if>
		</td>
		<td>
		<#if base.flightOrderStatus.orderAuditStatus == 'AUDIT_PASS'>
		${(orderdetail.flightOrderTicketPrice.airportFee)!0}
		<#else>
			<input type="text" id="airportFee_${orderdetail_index}" name="airportFee" 
				oldValue="${(orderdetail.flightOrderTicketPrice.airportFee)!0}" value="${(orderdetail.flightOrderTicketPrice.airportFee)!0}" 
				onchange="ctmtPrepaidAmountCalculate(${orderdetail_index});ctmtAmountCalculate(this)" onkeyup="formatNumber(this)"/>
		</#if>
		</td>
		<td>
		<#if base.flightOrderStatus.orderAuditStatus == 'AUDIT_PASS'>
		${(orderdetail.flightOrderTicketPrice.fuelsurTax)!0}
		<#else>
			<input type="text" id="fuelsurTax_${orderdetail_index}" name="fuelsurTax"
				oldValue="${(orderdetail.flightOrderTicketPrice.fuelsurTax)!0}" value="${(orderdetail.flightOrderTicketPrice.fuelsurTax)!0}" 
				onchange="ctmtPrepaidAmountCalculate(${orderdetail_index});ctmtAmountCalculate(this)" onkeyup="formatNumber(this)"/>
		</#if>
		</td>
		<td>
		<#if base.flightOrderStatus.orderAuditStatus == 'AUDIT_PASS'>
		${(orderdetail.flightOrderTicketCTMT.fee)!0}
		<#else>
			<input type="text" id="fee_${orderdetail_index}" name="fee" 
				oldValue="${(orderdetail.flightOrderTicketCTMT.fee)!0}" value="${(orderdetail.flightOrderTicketCTMT.fee)!0}" 
				onchange="ctmtPrepaidAmountCalculate(${orderdetail_index});ctmtAmountCalculate(this)" onkeyup="formatNumber(this)"/>
		</#if>
		</td>
		<td>
		<#if base.flightOrderStatus.orderAuditStatus == 'AUDIT_PASS'>
		${(orderdetail.flightOrderTicketCTMT.surcharge)!0}
		<#else>
			<input type="text" id="surcharge_${orderdetail_index}" name="surcharge" 
				oldValue="${(orderdetail.flightOrderTicketCTMT.surcharge)!0}" value="${(orderdetail.flightOrderTicketCTMT.surcharge)!0}" 
				onchange="ctmtPrepaidAmountCalculate(${orderdetail_index});ctmtAmountCalculate(this)" onkeyup="formatNumber(this)"/>
		</#if>
		</td>
		<td>
		<#if base.flightOrderStatus.orderAuditStatus == 'AUDIT_PASS'>
		${(orderdetail.flightOrderTicketCTMT.prepaidAmount)!0}
		<#else>
			<input type="text" id="prepaidAmount_${orderdetail_index}" name="prepaidAmount" 
				value="${(orderdetail.flightOrderTicketCTMT.prepaidAmount)!0}" readonly="readonly" onkeyup="formatNumber(this)"/>
		</#if>
		</td>
		<td>
		<#if base.flightOrderStatus.orderAuditStatus == 'AUDIT_PASS'>
		${(orderdetail.flightOrderTicketPrice.settlePrice)!0}
		<#else>
			<input type="text" name="settlePrice" value="${(orderdetail.flightOrderTicketPrice.settlePrice)!0}"  onkeyup="formatNumber(this)"/>
		</#if>
		</td>
		<td>
		<select name="bookingSource"> 
		<#list supps as supp>
				  <option value="${supp.code}">${supp.code}</option>
		</#list>
		</select>
		</td>
		<td>
			<input type="text" name="suppPolicyNo" value="${(orderdetail.flightOrderTicketCTMT.suppPolicyNo)!''}" onBlur="trim(this)"/>
		</td>
		<td><#list info.bspNoMap?keys as key>
				<#if key == orderdetail.flightOrderTicketInfo.id>
					${info.bspNoMap[key]}
				</#if>
			</#list>
         </td>
		<td>
			${(orderdetail.detailTicketStatus.cnName)!''}
		</td>
		<td>
		<#if base.flightOrderStatus.orderAuditStatus == 'AUDIT_PASS'>
		${(orderdetail.flightOrderTicketCTMT.paiclupAmount)!0}
		<#else>
		<input type="text" name="paiclupAmount" value="${(orderdetail.flightOrderTicketCTMT.paiclupAmount)!0}" onkeyup="formatNumber(this)"/>
		</#if>
		</td>
		<td><input type="text" name="payedAmount" value="${(orderdetail.flightOrderTicketCTMT.payedAmount)!0}" onkeyup="formatNumber(this)"/></td>
	</tr>
	</#list> 
	</#if>
</table>
