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
		<th width="6%">出票手续费</th>
		<th width="6%">出票服务费</th>
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
		<input type="hidden" name="issueId" value="${orderdetail.flightOrderTicketIssue.id}" />

		<td><input type="text" name="issuePnr" value="${(orderdetail.flightOrderTicketIssue.issuePnr)!''}" onBlur="trim(this)"/></td>
		<td>${(orderdetail.flightOrderPassenger.passengerType.cnName)!''}</td>
		<td>${(orderdetail.flightOrderPassenger.passengerName)!''}</td>
		<td>${(orderdetail.flightOrderPassenger.passengerIDCardType.cnName)!''}</td>
		<td>${(orderdetail.flightOrderPassenger.passengerIDCardNo)!''}</td>
		<td>${(orderdetail.flightOrderPassenger.passengerBirthday?string("yyyy-MM-dd"))!''}</td>
		<td>${(orderdetail.flightOrderPassenger.cellphone)!''}</td>
		<td><input type="text" name="issueTicketNo" value="${(orderdetail.flightOrderTicketInfo.ticketNo)!''}" onBlur="trim(this)"/></td>
		<!--票面 与优惠金额-->
		<td>${(orderdetail.flightOrderTicketPrice.parPrice)!0}</td>
		<td>${(orderdetail.flightOrderTicketPrice.promotion)!0}</td>
		<!--机建费燃油费-->
		<td>${(orderdetail.flightOrderTicketPrice.airportFee)!0}</td>
		<td>${(orderdetail.flightOrderTicketPrice.fuelsurTax)!0}</td>
		<td>${(orderdetail.flightOrderTicketIssue.fee)!0}</td>
		<td>${(orderdetail.flightOrderTicketIssue.surcharge)!0}</td>
		<!--销售价结算价-->
		<td>${(orderdetail.flightOrderTicketPrice.salesPrice)!0}</td>
		<td><input type="text" name="settlePrice" value="${(orderdetail.flightOrderTicketPrice.settlePrice)!0}" onkeyup="formatNumber(this)"/></td>
		<td><select name="bookingSource"> 
		<#list supps as supp>
			<option value="${supp.code}">${supp.code}</option>
		</#list>
		</select></td>
		<td><input type="text" name="suppPolicyNo" value="${(orderdetail.combinationDetail.flightOrderFlightPolicy.suppPolicyNo)!''}" onBlur="trim(this)"/></td>
		<td><#list info.bspNoMap?keys as key>
				<#if key == orderdetail.flightOrderTicketInfo.id>
					${info.bspNoMap[key]}
				</#if>
			</#list></td>
		<td>${(orderdetail.detailTicketStatus.cnName)}</td>
		<td>${(orderdetail.flightOrderTicketIssue.paiclupAmount)!0}</td>
		<td><input type="text" name="payedAmount" value="${(orderdetail.flightOrderTicketIssue.payedAmount)!0}" onkeyup="formatNumber(this)"/></td>
	</tr>
	</#list> 
	</#if>
</table>	
