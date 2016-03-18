
	<#list insuranceInfos as insurance>
	<tr>
	<td style="width:5%; border:none;">
	<img src="images/order/jian.png">
	 </td>
	 <td style="width:5%;border:none;">
	<input id="input_${insurance.id}" type="checkbox" value="${insurance.id}" name="insurance" onclick="onInsuranceSel(this)">
	</td>
	 <td style="width:45%;border:none;text-align:left;">
	<span alt="insurance.insuranceDesc">${insurance.insuranceClass.name}</span>&nbsp;
		&yen;${(insurance.insurancePrice)!''}/份 &nbsp;
		${insurance.supp.name}${insurance.insuranceClass.name}&nbsp;
		</td>
		<td style="width:45%;border:none;text-align:left;">
		  <select id="insurance_${insurance.id}" data="${insurance.id}" class="insuranceTypeChange" style="border:1px solid #e4e4e4;width:40%;">
			<#list 1..1 as t>
			  <option value="${t}">每人${t}份</option>
			</#list>
		</select>
		 </td>
      </tr>
	</#list>

