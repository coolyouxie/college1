<table id="insurance">
	<tr>
	   <tr>
			<th width="6%">乘客类型</th>
			<th width="8%">姓名</th>
			<th width="8%">证件类型</th>
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
	</tr>
  <#if info.flightOrderDetails>
		<#list info.flightOrderDetails as orderdetail>
			<#list orderdetail.flightOrderPassenger.flightOrderInsurances as insurance>
			<tr>
			    <input  type="hidden"  style="text-align: center;" name="detailId" value="${orderdetail.id}"/>
				<td>
				      <select name="passengerType">
			            <#list passengerTypeEnum as val>  
						   <option value="${val}" <#if orderdetail.flightOrderPassenger.passengerType ==val>selected="selected"</#if>>${val.cnName}</option>
						</#list>  
					  </select>
				</td>
				<td><input  type="text"  style="text-align: center;" name="passengerName" value="${orderdetail.flightOrderPassenger.passengerName}"/></td>
				<td>
			       <select name="passengerIDCardType">
				     <#list passengerIDCardTypeEnum as val>  
					   <option value="${val}" <#if orderdetail.flightOrderPassenger.passengerIDCardType==val>selected="selected"</#if>>${val.cnName}</option>
					 </#list> 
				   </select>
				</td>
				<td><input  type="text"  style="text-align: center;" name="passengerIDCardNo" value="${(orderdetail.flightOrderPassenger.passengerIDCardNo)!''}"/></td>
				<td><input  type="text"  style="text-align: center;" name="passengerBirthday" value="${(orderdetail.flightOrderPassenger.passengerBirthday)!''}"/></td>
				<td><input  type="text"  style="text-align: center;" name="cellphone" value="${(orderdetail.flightOrderPassenger.cellphone)!''}"/></td>
				
				<td><input  type="text"  style="text-align: center;" name="insuranceNo" value="${(insurance.insuranceOrderDto.insuranceNo)!''}"/></td>
				<td><input  type="text"  style="text-align: center;" name="name" value="${(insurance.insuranceClass.name)!''}"/></td>
				<td><input  type="text"  style="text-align: center;" disabled="disabled" value="${(insurance.insurancePrice)!''}"/></td>
				<td><input  type="text"  style="text-align: center;" name="insuredNum" value="${(insurance.insuranceOrderDto.insuredNum)!''}"/></td>
				<td><input  type="text"  style="text-align: center;" name="insurancePrice" value="${(insurance.insurancePrice)!''}"/></td>
				<td><input  type="text"  style="text-align: center;" name="name" value="${(insurance.insuranceOrderDto.insuranceInfoDto.supp.name)!''}"/></td>
				<td><input  type="text"  style="text-align: center;" name="settleAccounts" value="${(insurance.insuranceOrderDto.settleAccounts)!''}"/></td>
				<td><input  type="text"  style="text-align: center;" name="insuranceStatus" value="${(insurance.insuranceOrderDto.insuranceStatus.cnName)!''}"/></td>
			
			</tr>
			</#list>
		</#list>
   </#if>
</table>	
