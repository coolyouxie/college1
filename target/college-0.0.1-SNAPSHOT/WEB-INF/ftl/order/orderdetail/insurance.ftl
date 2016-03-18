<div class="bdinfor lot">
	<div class="title">
		<b>保单信息</b>
	</div>
	<table>
		<tr>
			<#if base.orderType == 'RTVT'>
				<th width="2%"></th>
			</#if>
			<th width="6%">乘客类型</th>
			<th width="8%">姓名</th>
			<th width="8%">证件号码</th>
			<th width="6%">出生日期</th>
			<th width="8%">手机号码</th>
			<th width="8%">保单号</th>
			<th width="8%">险种</th>
			<th width="6%">保险金额</th>
			<th width="6%">份数</th>
			<th width="6%">销售价</th>
			<th width="6%">供应商</th>
			<th width="6%">结算价</th>
			<th width="6%">保单状态</th>
		</tr>
		<#if info.flightOrderDetails??>
			<#list info.flightOrderDetails as orderdetail>
				<#list orderdetail.flightOrderPassenger.flightOrderInsurances as insurance>
					<!-- 匹配航段 -->
					<#if info.flightOrderFlightInfos??>
						<#list info.flightOrderFlightInfos as flightInfo>
							<#if insurance.flightOrderFlightInfo.id == flightInfo.id>
								<tr>
									<#if base.orderType == 'RTVT'>
									<td>
										<input type="checkbox" name="orderInsuranceId" value="${insurance.id}"
											${(base.flightOrderStatus.orderAuditStatus == 'NOT_AUDIT' && opType == 'RTVT')?string('', 'disabled=true')}" 
											${(insurance.isRefund == 'true')?string('checked', '')} 
											onclick="rtvtAmountCalculate(this)"/>
										<input type="hidden" id="orderInsurancePrice_${insurance.id}" value='${(insurance.insurancePrice)!''}'/>
									</td>
									</#if>
									<td>
										${(orderdetail.flightOrderPassenger.passengerType.cnName)!''}
									</td>
									<td>
										${(orderdetail.flightOrderPassenger.passengerName)!''}
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
										${(insurance.insuranceOrderDto.insuranceNo)!''}
									</td>
									<td>
										${(insurance.insuranceClass.name)!''}
									</td>
									<td>
										${(insurance.insuranceClass.price)!''}
									</td>
									<td>
										${(insurance.insuranceOrderDto.insuredNum)!''}
									</td>
									<td>
										${(insurance.insurancePrice)!''}
									</td>
									<td>
										${(insurance.insuranceOrderDto.insuranceInfoDto.supp.name)!''}
									</td>
									<td>
										${(insurance.insuranceOrderDto.settleAccounts)!''}
									</td>
									<td>
										${(insurance.insuranceOrderDto.insuranceStatus.cnName)!''}
									</td>
								</tr>
							</#if>
						</#list>
					</#if>
				</#list>
			</#list>
		</#if>
	</table>
</div>