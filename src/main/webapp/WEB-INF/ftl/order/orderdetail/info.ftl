<script type="text/javascript">
//申请航班补全
function checkit(obj, afUrl) {
	$.ajax({
			url : afUrl + '/' + $('#depCityCode').val() + '/' + $('#arrCityCode').val(),
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
				flightNo : $('#flightNo').val(),
				passengerType : $('#passengerType').val()
			}),
			success : function(data) {
				if (data.status == 'SUCCESS') {
					var flight = eval(data.results);
					var carrierSpan = '';
					var airplaneSpan = '';
					var airportSpan = '';
					var airportFeeSpan = '';
					var timeSegmentRangeSpan = '';
					var flightCrossDaySpan = '';
					if (flight.length >= 0) {
					  carrierSpan = flight[0].carrier.name;
					  airplaneSpan = flight[0].airplane.code;
					  airportSpan = flight[0].flightAirportLine.departureAirport.fullName + " —— "+ flight[0].flightAirportLine.arrivalAirport.fullName;
					  airportFeeSpan = "机建： " + flight[0].airportFee + " 燃油： " + flight[0].fuelsurTax;
					  if(!flight[0].flightStopInfo && !flight[0].flightStopInfo.stopCount && flight[0].flightStopInfo.stopCount > 0){
					     timeSegmentRangeSpan = flight[0].departureTime + " —<i>经停</i>— " + flight[0].arrivalTime;
					  } else {
					     timeSegmentRangeSpan = flight[0].departureTime + " —— " + flight[0].arrivalTime;
					  }
					  if (flight[0].crossDay > 0) {
					  flightCrossDaySpan = "+" + flight[0].crossDay + "天";
					  }
					  
					}
					// 组装舱位
					var seatClassList = flight[0].seatClasss;
					var seatStart = '<select id="seatClassCode" name="seatClassCode">';
					var seatEnd = '</select>';
					var seat = '';
					for ( var i = 0; i < seatClassList.length; i++) {
						seat += '<option value="' + seatClassList[i].code + '">' + seatClassList[i].name +"  "+  seatClassList[i].code + '</option>';
					}
					
					$('#carrierSpan').html(carrierSpan);
					$('#airplaneSpan').html(airplaneSpan);
					$('#airportSpan').html(airportSpan);
					$('#airportFeeSpan').html(airportFeeSpan);
					$('#timeSegmentRangeSpan').html(timeSegmentRangeSpan);
					$('#seatClassCodeSpan').html(seatStart + seat + seatEnd);
					$('#flightCrossDaySpan').html(flightCrossDaySpan);
				} else {
					$('#seatClassCodeSpan').html("航班信息不存在");
					$("#seatClassCodeSpan").css("color","red");
				}
			}
		});
}
</script>
<div class="module3">
	<div class="hbinfor"> 
		<div class="title">航班信息</div> 
		<table id="flightInfoTable">
		<#if opType != 'CTMT'>
			<#list info.flightOrderFlightInfos as flightInfo>
			<tr> 
				<td class="go">
					<#if info.routeType == 'RT'>
						<#if flightInfo.flightTripType == "DEPARTURE">去</#if>
						<#if flightInfo.flightTripType =="RETURN">返</#if>
					<#else>
						&nbsp;	
					</#if>
					<img src="${request.contextPath}/images/topxf.png">	
					${(flightInfo.carrier.name)!''}
					<strong>${(flightInfo.flightNo)!''}</strong>
					<div class="jixing">
						计划机型：
						<a href="javascript:void(0)">${(flightInfo.airplane.code)!''}</a>
					</div>
				</td>
				<td>
					<div>
						${flightInfo.timeSegmentRange.departureTime?string("HH:mm")}
						<#if flightInfo.flightStopInfo?? && flightInfo.flightStopInfo.stopCount?? && (flightInfo.flightStopInfo.stopCount > 0)>
							——<i>经停</i>——
						<#else>
							————
						</#if>
						${(flightInfo.timeSegmentRange.arrivalTime?string("HH:mm"))}
						<#list info.flightCrossDays as flightCrossDay>
							<#if flightCrossDays_index == flightInfo_index && flightCrossDay > 0>
								<number>+${flightCrossDay}天</number>
							</#if>
						</#list>
					</div>
					<div class="name">
						${(flightInfo.flightAirportLine.departureAirport.fullName)!''}(${(flightInfo.flightAirportLine.departureTermainalBuilding.code)!''})
						—— ${(flightInfo.flightAirportLine.arrivalAirport.fullName)!''}(${(flightInfo.flightAirportLine.arrivalTerminalBuilding.code)!''})
					</div>
					<td>
						${(flightInfo.flightSeat.seatClass.name)!''}${(flightInfo.flightSeat.seatClass.code)!''}
					</td>
					<td>&nbsp;</td>
					<td class="td-5">
						机建：&yen;${(flightInfo.flightSeat.flightTicketPriceDto.airportFee)!0}&nbsp;
						燃油：&yen;${(flightInfo.flightSeat.flightTicketPriceDto.fuelsurTax)!0}
					</td>
					<td class="td-6">
						<t>${flightInfo.timeSegmentRange.departureTime?string("yyyy-MM-dd")}</t>
					</td>    
				</td>
			</tr>
			</#list>
		</#if>
		<#if opType =="CTMT">
			<#list info.flightOrderFlightInfos as flightInfo>
			<tr> 
				<td class="go">
					<#if flightInfo.flightTripType == "DEPARTURE">去</#if>
					<#if flightInfo.flightTripType =="RETURN">返</#if>
					<img src="${request.contextPath}/images/topxf.png">	
					<span id="carrierSpan">${(flightInfo.carrier.name)!''}</span>
					<strong><input type="text" id="flightNo" name="flightNo" value="${(flightInfo.flightNo)!''}"  onchange="checkit(this,'${request.contextPath}/ticket/ctmt/auditFlight')" /></strong>
					<div class="jixing">
						计划机型：
						<span id="airplaneSpan"><a href="javascript:void(0)">${(flightInfo.airplane.code)!''}</a></span>
					</div>
				</td>
				<td>
					<div>
					<#if flightInfo.timeSegmentRange?exists>
						<span id="timeSegmentRangeSpan">${flightInfo.timeSegmentRange.departureTime?string("HH:mm")}
						<#if flightInfo.flightStopInfo?? && flightInfo.flightStopInfo.stopCount?? && (flightInfo.flightStopInfo.stopCount > 0)>
							——<i>经停</i>——
						<#else>
							————
						</#if>
						${(flightInfo.timeSegmentRange.arrivalTime?string("HH:mm"))}</span><span id="flightCrossDaySpan">
						<#list info.flightCrossDays as flightCrossDay>
							<#if flightCrossDays_index == flightInfo_index && flightCrossDay > 0>
								<number>+${flightCrossDay}天</number>
							</#if>
						</#list></span>
					</#if>
					</div>
					<div class="name">
						<span id="airportSpan">${(flightInfo.flightAirportLine.departureAirport.fullName)!''} —— ${(flightInfo.flightAirportLine.arrivalAirport.fullName)!''}</span>
					</div>
					<td>
						<span id="seatClassCodeSpan"><#if flightInfo.flightSeat??><select id="seatClassCode" name="seatClassCode"> 
						<option value=""></option> 
		                <#list seatClassCodeEnum as seatClassCode>
				        <option value="${seatClassCode}" <#if flightInfo.flightSeat??>${(flightInfo.flightSeat.seatClass.code == seatClassCode)?string('selected', '')}</#if>>
					    ${seatClassCode.cnName}${seatClassCode} 
				       </option> 
		               </#list>
		               </select>
		               </#if></span>
					</td>
					<td>&nbsp;</td>
					<input type="hidden" id="passengerType" value="${passengerType}"/> 
					<input type="hidden" id="depCityCode" name="depCityCode" value="${depCityCode}" /> 
	                <input type="hidden" id="arrCityCode" name="arrCityCode" value="${arrCityCode}" /> 
					<td class="td-5">
						<span id="airportFeeSpan">机建：&yen;${(flightInfo.flightSeat.flightTicketPriceDto.airportFee)!0}&nbsp;
						燃油：&yen;${(flightInfo.flightSeat.flightTicketPriceDto.fuelsurTax)!0}</span>
					</td>
					<td class="td-6">
					<#if flightInfo.timeSegmentRange?exists>
					    <t><input id="departDate" type="text" name="departDate" class="input_d per70" 
						readonly="readonly" onfocus="WdatePicker({doubleCalendar:true,dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d'})" value='${flightInfo.timeSegmentRange.departureTime?string("yyyy-MM-dd")}'/></t>
					<#else>
						<t><input id="departDate" type="text" name="departDate" class="input_d per70" readonly="readonly" onfocus="WdatePicker({doubleCalendar:true,dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d'})"/></t>
					</#if>
					</td>    
				</td>
			</tr>
			</#list>
		</#if>
		</table> 
	</div>
	<!--退改签规定-->
     <div class="rule">
         <#if flightTicketRuleForm.flightSearchTicketRuleSimple?exists>
		 <table>
			<#list flightTicketRuleForm.simpleDetails as simpleDetail>
              <tr>
                 <#if simpleDetail_index == 0>
                    <td width="3%" class="hebing" rowspan="${flightTicketRuleForm.simpleDetails?size}">${flightTicketRuleForm.passengerTypeName}</td>
                  </#if>
                  <td width="14%">${simpleDetail.detailFeeTypeName}</td>
                  <td width="80%" class="tal">${simpleDetail.detailFeeDesc}</td>
              </tr>
	         </#list>
	     </table>
	     </#if>
	</div>
	<div class="buchong">
		  <p>政策备注：<#if flightTicketRuleForm.flightPolicyRemark?exists>${(flightTicketRuleForm.suppRemark)!''}</#if><br>政策补充说明：</p>
	 </div>
	<div class="kpinfor lot">
		<div class="title">
			<b>客票信息</b>
		</div>
		<#if opType == 'NULL'>
			<#include "order/ticketinfo/ticketinfo_detail.ftl">
		<#elseif opType == "ISSUE">
			<#include "order/ticketinfo/issue_ticketinfo_edit.ftl">
		<#elseif opType == "RTVT">
			<#include "order/ticketinfo/rtvt_ticketinfo_edit.ftl">
		<#elseif opType =="CTMT">
		   <#include "order/ticketinfo/ctmt_ticketinfo_edit.ftl">
		</#if>
	</div>
	<#include "order/orderdetail/insurance.ftl">
	<div class="address lot">
		<div class="title">
			<b>邮寄地址</b> 
		</div>
		<table>
			<tr>
				<th width="16%">联系人</th>
				<th width="16%">手机号码</th>
				<th width="16%">邮寄费</th>
				<th width="48%">地址</th>
			</tr>
			<tr>
				<td>${(info.flightOrderExpress.recipient)!''}</td>
				<td>${(info.flightOrderExpress.cellphone)!''}</td>
				<td>${(info.flightOrderExpress.expressPrice)!''}</td>
				<td>${(info.flightOrderExpress.address)!''}</td>
			</tr>
		</table>
	</div>
	<div class="contacts lot">
		<div class="title">
			<b>联系人信息</b>				
		</div>
		<p>
			联系人：${(base.flightOrderContacter.name)!''}<br>
			联系手机：${(base.flightOrderContacter.cellphone)!''}
		</p>
	</div>	
	<#include "order/orderdetail/amount.ftl">
</div>