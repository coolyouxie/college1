<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>虚拟调控详情</title>
<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/area_tankuang.css" />
<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	//返回
	function returnSalesRuleSuppList() {
	   	location.href ="${request.contextPath}/sales/toSalesRuleSupp";
	}
</script>
<body>
	<div class="content content1">
	    <div class="title" style="text-align :center" ><h3>虚拟调控详情</h3></div>
	    <form id="myForm">
	    	<div class="infor1">
				<div class="visitor message">
					<div class="main">
						<div class="part part1">
							<span>供应商：</span>
							<span style="width:80%;text-align:left;">
							<#if salesRuleSupp.suppCodes == 'ALL' && salesRuleSupp.suppCodes??>
							  全部
							<#else>
							  ${(salesRuleSupp.suppCodes)!''}	
							</#if>
							</span>
						 </div>
						<div class="part part1">
						<span>航班机场：</span>
					     <span>起飞机场：</span>
					     <#if salesRuleSupp.salesRuleBase.departureAirportCodes == 'ALL' && salesRuleSupp.salesRuleBase.departureAirportCodes??>
							  全部
							<#else>
							  ${(salesRuleSupp.salesRuleBase.departureAirportCodes)!''}	
							</#if>
				         <span>到达机场：</span>
				         <#if salesRuleSupp.salesRuleBase.arrivalAirportCodes == 'ALL' && salesRuleSupp.salesRuleBase.arrivalAirportCodes??>
							  全部
							<#else>
							  ${(salesRuleSupp.salesRuleBase.arrivalAirportCodes)!''}	
							</#if>
						</div>
						 <div class="part part1">
					     	<span>航空公司：</span>
					     	<#if salesRuleSupp.salesRuleBase.carrierCodes == 'ALL' && salesRuleSupp.salesRuleBase.carrierCodes??>
							  全部
							<#else>
							  ${(salesRuleSupp.salesRuleBase.carrierCodes)!''}	
							</#if>
						</div>
						<div class="part part1" id="seatCodeList" >
					     	<span>适用舱位：</span>
					     	<#if salesRuleSupp.salesRuleBase.seatCodes == 'ALL' && salesRuleSupp.salesRuleBase.seatCodes??>
							  全部
							<#else>
							  ${(salesRuleSupp.salesRuleBase.seatCodes)!''}	
							</#if>
						</div>
						<div class="part part1">
					     	<span>适用航班：</span>
					     	<#if salesRuleSupp.salesRuleBase.includeFlightNos??>
							     适用以下航班：${(salesRuleSupp.salesRuleBase.includeFlightNos)!''}
							<#elseif salesRuleSupp.salesRuleBase.excludeFlightNos??>
							  不适用以下航班： ${(salesRuleSupp.salesRuleBase.excludeFlightNos)!''}
							<#else>	
							没有限制
							</#if>
					 	</div>
						<div class="part part1">
					     	<span>适用班期：</span>
					     	<#if salesRuleSupp.salesRuleBase.weekDays == 'ALL' && salesRuleSupp.salesRuleBase.weekDays??>
							  全部
							<#else>
							  ${(salesRuleSupp.salesRuleBase.weekDays)!''}	
							</#if>
					     </div>
						<div class="part part1">
					     	<span>航班日期：</span>
				                                     从 ${(salesRuleSupp.salesRuleBase.depStartDate?string("yyyy-mm-dd"))!''}	至    ${(salesRuleSupp.salesRuleBase.depEndDate?string("yyyy-mm-dd"))!''}	
				             </div>
						<div class="part part1">
						    <span>营销调控：</span>
						    <span>调控加点：</span>
				          	<span>${(detail.salesRuleBase.priceFormula.scale)!''}</span>
					        <span>调控加价：</span>
					        <span>${(detail.salesRuleBase.priceFormula.fixed)!''}</span>
						</div>
						
						<div class="part part1">
						<span>优先级别：</span>
						${(salesRuleSupp.salesRuleBase.priority)!''}
				     	</div>
				     	<div class="part part1">
				     	  <span>是否有效：</span>
					     ${(salesRuleSupp.salesRuleBase.status.cnName)!''}
						</div> 
						<div class="part part1">
				     	<span>有效日期:</span>
						  从 ${(salesRuleSupp.salesRuleBase.effectDate?string("yyyy-MM-dd "))!''}	至    ${(salesRuleSupp.salesRuleBase.expireDate?string("yyyy-MM-dd "))!''}	
						</div> 
						<div class="part part1">
				     	<span>维护时间:</span>
						 ${(salesRuleSupp.updateTime?string("yyyy-MM-dd HH:mm:ss"))!''}
						</div> 
						 </div>
			           </div>
					 </div>
					 
	         <div class="click">
				<a href="javascript:void(0);"><div class="button" id="button" onclick="returnSalesRuleSuppList()">返回</div></a>
			</div>
		
		 </form>
		<!--</form>-->
		<div id="datepicker-4"></div>
		<div id="datepicker-5"></div>
	</div>
</body>
</html>