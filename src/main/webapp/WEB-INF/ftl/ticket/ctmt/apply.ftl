<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>改期改签申请</title>
<link rel="stylesheet" href="${request.contextPath}/css/order-details.css">
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/jquery-ui.css">
<script type="text/javascript" src="${request.contextPath}/js/resources/jquery-1.7.1.min.js"></script>
 <script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/jquery-ui.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/ticketinfo/ctmt_tiketinfo_apply.js"></script>

</head>
<body>
	<div class="content content4">
	<div class="breadnav"><span>首页</span> > 改期改签申请</div>
	<input type="hidden" id="orderMainId"  name="orderMainId" value="${orderMainId}"/> 
	<input type="hidden" id="orderId" name="orderId" value="${orderId}" /> 
	<input type="hidden" id="depCityCode" name="depCityCode" value="${depCityCode}" /> 
	<input type="hidden" id="arrCityCode" name="arrCityCode" value="${arrCityCode}" /> 
		<div class="flight-infor">
			<div class="title">乘客航班信息</div>
			<table id="flightOrderDetails">
				<tr>
					<th width="5%"><input type="checkbox" class="checkAll"  id="checkedAll"/></th>
					<th width="10%">乘客姓名</th>
					<th width="12%">PNR（大/小）</th>
					<th width="8%">出发城市</th>
					<th width="8%">到达城市</th>
					<th width="8%">航班号</th>
					<th width="6%">舱位</th>
					<th width="10%">出发日期</th>
					<th width="10%">起飞时间</th>
				</tr>
				<#list orderDetailForms as orderDetail>
					<tr>
						<td><input type="checkbox" name="ctmtDetailId" class="check-sub" value="${orderDetail.id}" ${(orderDetail.isCanCTMT != 'true')?string('disabled', '')}/></td>
						<td>${(orderDetail.flightOrderPassenger.passengerName)!''}</td>
						<td>${(orderDetail.flightOrderPNRInfo.pnr)!''}</td>
						<td>${(orderDetail.combinationDetail.flightOrderFlightInfo.flightAirportLine.departureAirport.city.airportCity.name)!''}</td>
						<td>${(orderDetail.combinationDetail.flightOrderFlightInfo.flightAirportLine.arrivalAirport.city.airportCity.name)!''}</td>
						<td>${(orderDetail.combinationDetail.flightOrderFlightInfo.flightNo)!''}</td>
						<td>${(orderDetail.combinationDetail.flightOrderFlightInfo.flightSeat.seatClass.code)!''}</td>
						<td>${orderDetail.combinationDetail.flightOrderFlightInfo.timeSegmentRange.departureTime?string("yyyy-MM-dd")}</td>
						<td>${orderDetail.combinationDetail.flightOrderFlightInfo.timeSegmentRange.departureTime?string("HH:mm")}</td>
					</tr>
				</#list>
			</table>			
		</div>
		
		
		<div class="change-infor">
			<div class="title">改签信息</div>
			<table class="part1">
				<tr class="one">
					<th width="16%">出发日期</th>
					<th width="16%">航班号</th>
					<th width="10%">舱位</th>
					<th width="50%">改签原因</th>
				</tr>
				<tr class="two">
					
					<td>
						<div class="datechange">
	                        <div class="input_date">
	                        <input id="departDate" type="text" name="departDate" class="input_d per70" readonly="readonly" onfocus="WdatePicker({doubleCalendar:true,dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d'})"/>
	                            <!--  <img class="calendar-0 calPosition" src="${request.contextPath}/images/dateimg.jpg"></img>-->
	                        </div>
	                        <div id="datepicker-0"></div>
	                    </div>
					</td>
					<td><input type="text" id="flightNo" name="flightNo" onchange="checkit(this,'${request.contextPath}/ticket/ctmt/applyFlight')" /></td>
					<td>
						<div id="select_1" style = "color:red">
						</div>
					</td>
					
					<td><input type="text" id="reason" name="reason"/></td>
				</tr>
			</table>
			
		</div>		
	
		<div class="explain">
		 <div class="buchong">
	     <p>政策备注：<#if flightTicketRuleForm.flightPolicyRemark?exists>${(flightTicketRuleForm.suppRemark)!''}</#if><br>政策补充说明：</p>
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
		</div>
	
		<div class="remark">
			<div class="title">改签备注</div>
			<div class="write">
				<textarea rows="3" id="remark" name = "remark"></textarea>
			</div>
			
			<div class="click">
				<a href="javascript:;"><div class="button" id="button" onclick="ctmtApply('${request.contextPath}/ticket/ctmt/apply');">提交申请</div></a> 
			</div>
			
		</div>
		
	</div>	
</body>
</html>
