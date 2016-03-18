<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>营销调控规则详情</title>
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
	function returnSalesRuleSourceList() {
	   	location.href ="${request.contextPath}/sales/toSalesRuleSource";
	}
</script>
<body>
	<div class="content content1">
	    <div class="title" style="text-align :center" ><h3>营销调控规则详情</h3></div>
	    <form id="myForm">
	    	<div class="infor1">
				<div class="visitor message">
					<div class="main">
						<div class="part part1">
							<span>适用渠道：</span>
							<span style="width:80%;text-align:left;">
							<#if salesRuleSource.bookingSources == 'ALL' && salesRuleSource.bookingSources??>
							  全部
							<#else>
							  ${(salesRuleSource.bookingSources)!''}	
							</#if>
							</span>
						 </div>
						 <div class="part part1">
					     	<span>适用场景：</span>
					     	<#if salesRuleSource.productCategorys == 'ALL' && salesRuleSource.productCategorys??>
							  全部
							<#else>
							  ${(salesRuleSource.productCategorys)!''}	
							</#if>
						</div>
						<div class="part part1">
						<span>航班机场：</span>
					     <span>起飞机场：</span>
					     <#if salesRuleSource.salesRuleBase.departureAirportCodes == 'ALL' && salesRuleSource.salesRuleBase.departureAirportCodes??>
							  全部
							<#else>
							  ${(salesRuleSource.salesRuleBase.departureAirportCodes)!''}	
							</#if>
				         <span>到达机场：</span>
				         <#if salesRuleSource.salesRuleBase.arrivalAirportCodes == 'ALL' && salesRuleSource.salesRuleBase.arrivalAirportCodes??>
							  全部
							<#else>
							  ${(salesRuleSource.salesRuleBase.arrivalAirportCodes)!''}	
							</#if>
						</div>
						 <div class="part part1">
					     	<span>航空公司：</span>
					     	<#if salesRuleSource.salesRuleBase.carrierCodes == 'ALL' && salesRuleSource.salesRuleBase.carrierCodes??>
							  全部
							<#else>
							  ${(salesRuleSource.salesRuleBase.carrierCodes)!''}	
							</#if>
						</div>
						<div class="part part1" id="seatCodeList" >
					     	<span>适用舱位：</span>
					     	<#if salesRuleSource.salesRuleBase.seatCodes == 'ALL' && salesRuleSource.salesRuleBase.seatCodes??>
							  全部
							<#else>
							  ${(salesRuleSource.salesRuleBase.seatCodes)!''}	
							</#if>
						</div>
						<div class="part part1">
					     	<span>适用航班：</span>
					     	<#if salesRuleSource.salesRuleBase.includeFlightNos??>
							     适用以下航班：${(salesRuleSource.salesRuleBase.includeFlightNos)!''}
							<#elseif salesRuleSource.salesRuleBase.excludeFlightNos??>
							  不适用以下航班： ${(salesRuleSource.salesRuleBase.excludeFlightNos)!''}
							<#else>	
							没有限制
							</#if>
					 	</div>
						<div class="part part1">
					     	<span>适用班期：</span>
					     	<#if salesRuleSource.salesRuleBase.weekDays == 'ALL' && salesRuleSource.salesRuleBase.weekDays??>
							  全部
							<#else>
							  ${(salesRuleSource.salesRuleBase.weekDays)!''}	
							</#if>
					     </div>
						<div class="part part1">
					     	<span>航班日期：</span>
				                                     从 ${(salesRuleSource.salesRuleBase.depStartDate?string("yyyy-mm-dd"))!''}	至    ${(salesRuleSource.salesRuleBase.depEndDate?string("yyyy-mm-dd"))!''}	
				             </div>
						<div class="part part1">
						    <span>营销调控：</span>
					     	<span style="width:500px;text-align:right;">
					     	<table id="salesRuleTab" style="text-align:center;border:1px solid #e4e4e4;cellpadding:0px;cellspacing:0px;">  
						       <tr>
								   <td width="20%">票面价区间</td>
								   <td width="40%">调控基准</td>
								   <td width="20%">调控比例</td>
								   <td width="25%">调控价格</td>
							   </tr>
							    <#if salesRuleSource.salesRulePriceDtos??>
									<#list salesRuleSource.salesRulePriceDtos as salesRulePrice>
								        <tr style="text-align:center;">
										<td width="20%"><input type="hidden" id="parPriceRange" name="parPriceRange" /> ${(salesRulePrice.parPriceRange)!''}	</td>
										<td width="40%">
										         调控基准:
											<#if salesRulePrice.formulaBase == 'ALL' && salesRulePrice.formulaBase??>
											  全部
											<#else>
											  ${(salesRulePrice.formulaBase)!''}	
											</#if>
										</td>
								        <td width="20%">${(salesRulePrice.priceFormula.scale)!''}%</td> 
								        <td width="20%">${(salesRulePrice.priceFormula.fixed)!''}元</td>
								        </tr> 
								        </#list> 
								    </#if>
						       </table>  
						    </span>
						</div>
						
						<div class="part part1">
						<span>优先级别：</span>
						${(salesRuleSource.salesRuleBase.priority)!''}
				     	</div>
				     	<div class="part part1">
				     	  <span>是否有效：</span>
					     ${(salesRuleSource.salesRuleBase.status.cnName)!''}
						</div> 
						<div class="part part1">
				     	<span>有效日期:</span>
						  从 ${(salesRuleSource.salesRuleBase.effectDate?string("yyyy-MM-dd "))!''}	至    ${(salesRuleSource.salesRuleBase.expireDate?string("yyyy-MM-dd "))!''}	
						
					   <div class="part part1">
				     	   <span>绑定险种：</span>
							<#if salesRuleSource.insuranceClasses == 'ALL' && salesRuleSource.insuranceClasses??>
							  全部
							<#else>
							  ${(salesRuleSource.insuranceClasses)!''}	
							</#if>
						  </div> 
						
						 </div>
			           </div>
					 </div>
					 
	         <div class="click">
				<a href="javascript:void(0);"><div class="button" id="button" onclick="returnSalesRuleSourceList()">返回</div></a>
			</div>
		
		 </form>
		<!--</form>-->
		<div id="datepicker-4"></div>
		<div id="datepicker-5"></div>
	</div>
</body>
</html>
