<div class="address lot">
	<div class="title">
		<b>金额信息</b>
	</div>
	<table>
	<#if base.orderType == 'NORMAL'>
		<tr>
			<td colspan="8 style="text-algin:left">
				<b>结算(应收合计：￥<span>${(base.flightOrderAmountDto.orderPrepaidAmount)!0}</span>)</b>
			</td>
		</tr>
		<tr>
			<th>票面价</th>
			<th>优惠金额</th>
			<th>机建费</th>
			<th>燃油费</th>
			<th>手续费</th>
			<th>服务费</th>
			<th>快递费</th>
			<th>保险费</th>
		</tr>
		<tr>
			<td>
				<b><span>${(base.flightOrderAmountDto.orderTicketAmount)!0}</span></b>
			</td>
			<td>	
				<b><span>${(base.flightOrderAmountDto.orderDiscountTotalAmount)!0}</span></b>
			</td>	
			<td>	
				<b><span>${(base.flightOrderAmountDto.orderAirportTaxAmount)!0}</span></b>
			</td>	
			<td>	
				<b><span>${(base.flightOrderAmountDto.orderFuelTaxAmount)!0}</span></b>
			</td>	
			<td>	
				<b><span>0</span></b>
			</td>	
			<td>
				<b><span>0</span></b>
			</td>	
			<td>	
				<b><span>${(base.flightOrderAmountDto.orderExpressAmount)!0}</span></b>
			</td>	
			<td>	
				<b><span>${(base.flightOrderAmountDto.orderInsuranceAmount)!0}</span></b>
			</td>
		</tr>
	<#elseif base.orderType == 'RTVT'>
		<tr>
			<td colspan="8" style="text-algin:left">
				<b>结算(应退合计：￥<span id="rtvtAmountSpan">${(base.flightOrderAmountDto.orderRTVTAmount.rtvtAmount)!0}</span>)</b>
			</td>
		</tr>
		<tr>
			<th>票面价</th>
			<th>优惠金额</th>
			<th>机建费</th>
			<th>燃油费</th>
			<th>手续费</th>
			<th>服务费</th>
			<th>快递费</th>
			<th>保险费</th>
		</tr>
		<tr>
			<td>
				<b><span id="rtvtTicketAmountSpan">${(base.flightOrderAmountDto.orderRTVTAmount.rtvtTicketAmount)!0}</span></b>
			</td>
			<td>
				<b><span id="rtvtDiscountAmountSpan">${(base.flightOrderAmountDto.orderRTVTAmount.rtvtDiscountAmount)!0}</span></b>
			</td>
			<td>
				<b><span id="rtvtAirportTaxAmountSpan">${(base.flightOrderAmountDto.orderRTVTAmount.rtvtAirportTaxAmount)!0}</span></b>
			</td>
			<td>
				<b><span id="rtvtFuelTaxAmountSpan">${(base.flightOrderAmountDto.orderRTVTAmount.rtvtFuelTaxAmount)!0}</span></b>
			</td>
			<td>
				<b><span id="rtvtFeeAmountSpan">${(base.flightOrderAmountDto.orderRTVTAmount.rtvtFeeAmount)!0}</span></b>
			</td>
			<td>
				<b><span id="rtvtSurchargeAmountSpan">${(base.flightOrderAmountDto.orderRTVTAmount.rtvtSurchargeAmount)!0}</span></b>
			</td>
			<td>
				<b><span>0<span></b>
			</td>
			<td>
				<b><span id="rtvtInsuranceAmountSpan">${(base.flightOrderAmountDto.orderRTVTAmount.rtvtInsuranceAmount)!0}<span></b>
			</td>
		</tr>
	<#elseif base.orderType == 'CTMT'>
		<tr>
			<td colspan="8" style="text-algin:left">
				<b>结算(应收合计：￥<span id="ctmtPrepaidAmountSpan">${(base.flightOrderAmountDto.orderCTMTAmount.ctmtPrepaidAmount)!0}</span>)</b>
			</td>
		</tr>
		<tr>
			<th>票面价</th>
			<th>优惠金额</th>
			<th>机建费</th>
			<th>燃油费</th>
			<th>手续费</th>
			<th>服务费</th>
			<th>快递费</th>
			<th>保险费</th>
		</tr>
		<tr>
			<td>
				<b><span id="ctmtTicketDiffAmountSpan">${(base.flightOrderAmountDto.orderCTMTAmount.ctmtTicketDiffAmount)!0}</span></b>
			</td>
			<td>
				<b><span id="ctmtDiscountDiffAmountSpan">${(base.flightOrderAmountDto.orderCTMTAmount.ctmtDiscountDiffAmount)!0}</span></b>
			</td>
			<td>
				<b><span id="ctmtAirportTaxDiffAmountSpan">${(base.flightOrderAmountDto.orderCTMTAmount.ctmtAirportTaxDiffAmount)!0}</span></b>
			</td>
			<td>
				<b><span id="ctmtFuelTaxDiffAmountSpan">${(base.flightOrderAmountDto.orderCTMTAmount.ctmtFuelTaxDiffAmount)!0}</span></b>
			</td>
			<td>
				<b><span id="ctmtFeeAmountSpan">${(base.flightOrderAmountDto.orderCTMTAmount.ctmtFeeAmount)!0}</span></b>
			</td>
			<td>
				<b><span id="ctmtSurchargeAmountSpan">${(base.flightOrderAmountDto.orderCTMTAmount.ctmtSurchargeAmount)!0}</span></b>
			</td>
			<td>
				<b><span>0</span></b>
			</td>
			<td>
				<b><span>0</span></b>
			</td>
		</tr>	
	</#if>
	</table>
</div>
<script language="javascript">

	//退废票应退金额计算
	function rtvtRefundAmountCalculate(index)
	{
		var parPrice = convertNumber($('#parPrice_'+index+'').val());
		var promotion = convertNumber($('#promotion_'+index+'').val());
		var airportFee = convertNumber($('#airportFee_'+index+'').val());
		var fuelsurTax = convertNumber($('#fuelsurTax_'+index+'').val());
		var fee = convertNumber($('#fee_'+index+'').val());
		var surcharge = convertNumber($('#surcharge_'+index+'').val());
		
		var refundAmount = parPrice + airportFee + fuelsurTax - promotion - fee - surcharge;
		$('#refundAmount_'+index+'').val(refundAmount);	
	}
	
	//退废票金额计算
	function rtvtAmountCalculate(obj)
	{
		var rtvtTicketAmount = convertNumber($('#rtvtTicketAmountSpan').text());
		var rtvtDiscountAmount = convertNumber($('#rtvtDiscountAmountSpan').text());
		var rtvtAirportTaxAmount = convertNumber($('#rtvtAirportTaxAmountSpan').text());
		var rtvtFuelTaxAmount = convertNumber($('#rtvtFuelTaxAmountSpan').text());
		var rtvtFeeAmount = convertNumber($('#rtvtFeeAmountSpan').text());
		var rtvtSurchargeAmount = convertNumber($('#rtvtSurchargeAmountSpan').text());
		var rtvtInsuranceAmount = convertNumber($('#rtvtInsuranceAmountSpan').text());
		
		var objName = $(obj).attr('name'); 
		if(objName == 'fee')
		{
			rtvtFeeAmount = 0;
			$('input[name="fee"]').each(function()
			{
				rtvtFeeAmount += convertNumber($(this).val()); 
			});
			$('#rtvtFeeAmountSpan').text(rtvtFeeAmount);
		}
		else if(objName == 'surcharge')
		{
		 	rtvtSurchargeAmount = 0;
			$('input[name="surcharge"]').each(function()
			{
				rtvtSurchargeAmount += convertNumber($(this).val()); 
			});
			$('#rtvtSurchargeAmountSpan').text(rtvtSurchargeAmount);
		}
		else if(objName == 'orderInsuranceId')
		{
			rtvtInsuranceAmount = 0;
			$('input[name="orderInsuranceId"]').each(function()
			{
				if($(this).attr('checked'))
				{
					rtvtInsuranceAmount += convertNumber($('#orderInsurancePrice_'+$(this).val()+'').val());
				}
			});
			$('#rtvtInsuranceAmountSpan').text(rtvtInsuranceAmount);
		}
		var rtvtAmount = rtvtTicketAmount + rtvtAirportTaxAmount + rtvtFuelTaxAmount - 
			rtvtDiscountAmount - rtvtFeeAmount - rtvtSurchargeAmount + rtvtInsuranceAmount;
		$('#rtvtAmountSpan').text(rtvtAmount);	
	}
	
	//改签应收金额计算
	function ctmtPrepaidAmountCalculate(index)
	{
		var diffParPrice = convertNumber($('#parPrice_'+index+'').val()) - convertNumber($('#parPrice_'+index+'').attr('oldValue'));
		var diffPromotion = convertNumber($('#promotion_'+index+'').val()) - convertNumber($('#promotion_'+index+'').attr('oldValue'));
		var diffAirportFee = convertNumber($('#airportFee_'+index+'').val()) - convertNumber($('#airportFee_'+index+'').attr('oldValue'));
		var diffFuelsurTax = convertNumber($('#fuelsurTax_'+index+'').val()) - convertNumber($('#fuelsurTax_'+index+'').attr('oldValue'));
		var diffFee = convertNumber($('#fee_'+index+'').val()) - convertNumber($('#fee_'+index+'').attr('oldValue'));
		var diffSurcharge = convertNumber($('#surcharge_'+index+'').val()) - convertNumber($('#surcharge_'+index+'').attr('oldValue'));
		
		var prepaidAmount = diffParPrice - diffPromotion + diffAirportFee + diffFuelsurTax + diffFee + diffSurcharge;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
		$('#prepaidAmount_'+index+'').val(prepaidAmount);
	}
	
	//改签金额计算
	function ctmtAmountCalculate(obj)
	{
		var ctmtTicketDiffAmount = convertNumber('${(base.flightOrderAmountDto.orderCTMTAmount.ctmtTicketDiffAmount)!0}');
		var ctmtDiscountDiffAmount = convertNumber('${(base.flightOrderAmountDto.orderCTMTAmount.ctmtDiscountDiffAmount)!0}');
		var ctmtAirportTaxDiffAmount = convertNumber('${(base.flightOrderAmountDto.orderCTMTAmount.ctmtAirportTaxDiffAmount)!0}');
		var ctmtFuelTaxDiffAmount = convertNumber('${(base.flightOrderAmountDto.orderCTMTAmount.ctmtFuelTaxDiffAmount)!0}');
		var ctmtFeeAmount = 0;
		var ctmtSurchargeAmount = 0;
		
		var objName = $(obj).attr('name'); 
		if(objName == 'parPrice' || objName == 'promotion' || objName == 'airportFee' || objName == 'fuelsurTax')
		{
			$('input[name="'+objName+'"]').each(function()
			{
				var diffAmount = convertNumber($(this).val()) - convertNumber($(this).attr('oldValue'));
				switch(objName)
				{
					case 'parPrice':
						ctmtTicketDiffAmount += diffAmount;
						$('#ctmtTicketDiffAmountSpan').text(ctmtTicketDiffAmount);
						break;
					case 'promotion':
						ctmtDiscountDiffAmount += diffAmount;
						$('#ctmtDiscountDiffAmountSpan').text(ctmtDiscountDiffAmount);
						break;
					case 'airportFee':
						ctmtAirportTaxDiffAmount += diffAmount;
						$('#ctmtAirportTaxDiffAmountSpan').text(ctmtAirportTaxDiffAmount);
						break;
					case 'fuelsurTax':
						ctmtFuelTaxDiffAmount += diffAmount;
						$('#ctmtFuelTaxDiffAmountSpan').text(ctmtFuelTaxDiffAmount);
						break;
				}
			});
		}
		else if(objName == 'fee')
		{
			$('input[name="fee"]').each(function()
			{
				ctmtFeeAmount += convertNumber($(this).val()); 
			});
			$('#ctmtFeeAmountSpan').text(ctmtFeeAmount);
		}
		else if(objName == 'surcharge')
		{
			$('input[name="surcharge"]').each(function()
			{
				ctmtSurchargeAmount += convertNumber($(this).val()); 
			});
			$('#ctmtSurchargeAmountSpan').text(ctmtSurchargeAmount);
		}

		var ctmtPrepaidAmount = convertNumber($('#ctmtTicketDiffAmountSpan').text()) - convertNumber($('#ctmtDiscountDiffAmountSpan').text()) 
			+ convertNumber($('#ctmtAirportTaxDiffAmountSpan').text()) + convertNumber($('#ctmtFuelTaxDiffAmountSpan').text())
			+ convertNumber($('#ctmtFeeAmountSpan').text()) + convertNumber($('#ctmtSurchargeAmountSpan').text());
		$('#ctmtPrepaidAmountSpan').text(ctmtPrepaidAmount);
	}
	
	//金额字符串转数字
	function convertNumber(val)
	{
		if(parseFloat(val))
		{
			return parseFloat(val);
		}
		return 0;
	}
</script>
