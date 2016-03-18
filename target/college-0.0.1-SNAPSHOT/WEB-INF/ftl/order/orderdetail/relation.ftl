<div class="module2">
	<!-- 关联订单 -->
	<table class="table1" id="relationTable">
		<tr>
			<th>订单号</th>
			<th>内容</th>
			<th>支付金额</th>
			<th>审核状态</th>
			<th>机票状态</th>
			<th>更新时间</th>
		</tr>
		<#if relations??>
		<#list relations as relation>
		<tr>
			<td style="text-align:left">
				<#if relation.orderType == 'RTVT'>
					<#list 1..relation.orderSortCode?length as index>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</#list>退:
				</#if>
				<#if relation.orderType == 'CTMT'>
					<#list 1..relation.orderSortCode?length as index>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</#list>改:
				</#if>
				${relation.orderNo}
			</td>
			<td>
			<#list relation.flightOrderRelationDetails as relationDetail>
				<#if relationDetail.timeSegmentRange??>${(relationDetail.timeSegmentRange.departureTime?string("yyyy-MM-dd HH:mm"))!''}|</#if>
				<#if relationDetail.flightAirportLine??>${(relationDetail.flightAirportLine.departureAirport.code)!''}-${(relationDetail.flightAirportLine.arrivalAirport.code)!''}|</#if>
				<#list relationDetail.passengerTypes as passengerType>
					${(passengerType.cnName)}
					<#list relationDetail.passengerCounts as passengerCount>
						<#if passengerType_index == passengerCount_index>
						  ${passengerCount}人
						</#if>
					</#list>
				</#list>
			</#list>
			</td>
			<td>
				<#if relation.orderType == 'NORMAL'>
					${(relation.flightOrderAmount.orderPrepaidAmount)!''}
				<#elseif relation.orderType == 'RTVT'>	
					${(relation.flightOrderAmount.orderRTVTAmount.rtvtAmount)!''}
				<#else>
					${(relation.flightOrderAmount.orderCTMTAmount.ctmtPrepaidAmount)!''}
				</#if>
			</td>	
			<td>
				${(relation.flightOrderStatusDto.orderAuditStatus.cnName)}
			</td>
			<td>
				${(relation.flightOrderStatusDto.orderTicketStatus.cnName)}
			</td>
			<td>
				${(relation.updateTime?string("yyyy-MM-dd HH:mm"))}
			</td>
		</tr>		
		</#list>
		</#if>
	</table>
	<!-- 同主单订单 -->
	<table class="table1" id="sameTable" style='display:none'>
		<tr>
			<th>订单号</th>
			<th>内容</th>
			<th>支付金额</th>
			<th>审核状态</th>
			<th>机票状态</th>
			<th>更新时间</th>
		</tr>
		<#if sameRelations??>
		<#list sameRelations as sameRelation>
		<tr>
			<td style="text-align:left">
				<#if sameRelation.orderType == 'RTVT'>
					<#list 1..sameRelation.orderSortCode?length as index>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</#list>退:
				</#if>
				<#if sameRelation.orderType == 'CTMT'>
					<#list 1..sameRelation.orderSortCode?length as index>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</#list>改:
				</#if>
				${sameRelation.orderNo}
			</td>
			<td>
			<#list sameRelation.flightOrderRelationDetails as relationDetail>
			<#if relationDetail.timeSegmentRange??>${(relationDetail.timeSegmentRange.departureTime?string("yyyy-MM-dd HH:mm"))!''}|</#if>
			<#if relationDetail.flightAirportLine??>${(relationDetail.flightAirportLine.departureAirport.code)}-${(relationDetail.flightAirportLine.arrivalAirport.code)}|</#if>
				
				<#list relationDetail.passengerTypes as passengerType>
					${(passengerType.cnName)}
					<#list relationDetail.passengerCounts as passengerCount>
						<#if passengerType_index == passengerCount_index>
						  ${passengerCount}人
						</#if>
					</#list>
				</#list>
			</#list>
			</td>
			<td>
				<#if sameRelation.orderType == 'NORMAL'>
					${(sameRelation.flightOrderAmount.orderPrepaidAmount)!''}
				<#elseif sameRelation.orderType == 'RTVT'>	
					${(sameRelation.flightOrderAmount.orderRTVTAmount.rtvtAmount)!''}
				<#else>
					${(sameRelation.flightOrderAmount.orderCTMTAmount.ctmtPrepaidAmount)!''}
				</#if>
			</td>
			<td>
				${(sameRelation.flightOrderStatusDto.orderAuditStatus.cnName)}
			</td>
			<td>
				${(sameRelation.flightOrderStatusDto.orderTicketStatus.cnName)}
			</td>
			<td>
				${(sameRelation.updateTime?string("yyyy-MM-dd HH:mm"))}
			</td>
		</tr>		
		</#list>
		</#if>
	</table>
</div>