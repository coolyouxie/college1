<div class="top order">
	<div>
		<p class="bold">订单流程</p>
		<p>订位</p>
		
		<#if base.orderType == 'NORMAL' || base.orderType == 'CTMT'>
			<p>支付</p>
		<#elseif base.orderType == 'RTVT' && base.flightOrderStatus.orderPayStatus.orderPayStatusType == 'REFUND'>
			<p>退款</p>
		</#if>
		
		<#if base.orderType == 'NORMAL' ||  base.orderType == 'CTMT'>
			<p>取消</p>		
		</#if>
		
		<#if base.orderType == 'NORMAL'>
			<p>出票</p>
		<#elseif base.orderType == 'RTVT'>
			<p>退票</p>
		<#else>
			<p>改签</p>
		</#if>
		
		<p>审核</p>
		
		<#if base.flightOrderStatus.orderAuditStatus.orderAuditType == 'OP'>
			<p>处理</p>
		</#if>
		
		<#if base.orderType == 'RTVT'>
			<p>供应商退票</p>
		</#if>
	</div>
	<div>
		<p class="bold">状态</p>
		<p class="green">${(base.flightOrderStatus.orderBookingStatus.cnName)!''}&nbsp;</p>
		
		<#if base.orderType == 'NORMAL' || base.orderType == 'CTMT'>
			<p class="green">${(base.flightOrderStatus.orderPayStatus.cnName)!''}&nbsp;</p>
		<#elseif base.orderType == 'RTVT' && base.flightOrderStatus.orderPayStatus.orderPayStatusType == 'REFUND'>
			<p class="green">${(base.flightOrderStatus.orderPayStatus.cnName)!''}&nbsp;</p>	
		</#if>
		
		<#if base.orderType == 'NORMAL' ||  base.orderType == 'CTMT'>
			<p class="green">${(base.flightOrderStatus.orderCancelStatus.cnName)!''}&nbsp;</p>		
		</#if>

		<p class="green">${(base.flightOrderStatus.orderTicketStatus.cnName)!''}&nbsp;</p>
		
		<#if base.flightOrderStatus.orderAuditStatus.orderAuditType == 'OP'>
        <p class="green">审核通过&nbsp;</p>
		<#elseif base.flightOrderStatus.orderAuditStatus.orderAuditType == 'AUDIT' || base.flightOrderStatus.orderAuditStatus.orderAuditType == 'NULL'>
			<p class="green">${(base.flightOrderStatus.orderAuditStatus.cnName)!''}&nbsp;</p>
		</#if>
		
		<#if base.flightOrderStatus.orderAuditStatus.orderAuditType == 'OP'>
			<p class="green">${(base.flightOrderStatus.orderAuditStatus.cnName)!''}&nbsp;</p>	
		</#if>
		
		<#if base.orderType == 'RTVT'>
			<p class="green">${(base.flightOrderStatus.suppOrderAuditStatus.cnName)!''}&nbsp;</p>
		</#if>
	</div>	
</div>