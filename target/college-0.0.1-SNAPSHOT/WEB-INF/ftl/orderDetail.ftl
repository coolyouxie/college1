<!DOCTYPE html>
<html>
  <head>
    <title>出票详情</title>
    <link href="css/orderdetail/styles.css" type="text/css" rel="stylesheet"/>
    <script src="js/scripts/jquery-1.7.1.min.js"></script>
    
    <script type="text/javascript">
      <#--
      	$axure.utils.getTransparentGifPath = function() { return 'css/images/transparent.gif'; };
      	$axure.utils.getOtherPath = function() { return 'resources/Other.html'; };
      	$axure.utils.getReloadPath = function() { return 'resources/reload.html'; };
      -->
    </script>
    <style>
    	.baseTable tr td{
    		width:100px;
    	}
    </style>
  </head>
  <body>
  	<div>
  		<div>基础信息</div>
  		<div>主订单信息</div>
  		<table class="baseTable">
  			<tr>
  				<td>订单号:${order.flightOrderNo.orderNo}</td>
  				<td></td>
  				<td>订单状态：</td>
  				<td></td>
  				<td>供应商：</td>
  				<td></td>
  			</tr>
  			<tr>
  				<td>下单时间:</td>
  				<td></td>
  				<td>出票时间:</td>
  				<td></td>
  				<td>销售渠道：</td>
  				<td></td>
  			</tr>
  			<tr>
  				<td>联系人姓名:</td>
  				<td>${order.flightOrderContacter.name}</td>
  				<td>联系电话:</td>
  				<td>${order.flightOrderContacter.cellphone}</td>
  				<td></td>
  				<td></td>
  			</tr>
  			<tr>
  				<td>上游订单号:</td>
  				<td></td>
  				<td>下游订单号:</td>
  				<td></td>
  				<td>△相关订单</td>
  				<td></td>
  			</tr>
  		</table>
  		<div>
			原订单 1234567890  2580
  		</div>
  	</div>
  	<br/>
  	<div>
  		<div>
  			单程  上海 - 三亚
  		</div>
  		<div>
  			<table>
  			<tr align="center">
  				<td align="left">${info.carrier.name}&nbsp;&nbsp;${info.carrier.code}${info.flightNo}</td>
  				<td rowspan="2" width="200">2014年12月31日</td>
  				<td align="right">16:30—</td>
				<td align="center"> 经停 </td>
				<td>—20:05 +1天</td>
  				<td rowspan="2">全价经济舱Y</td>
  				<td rowspan="2">机建：￥50 + 燃油：￥70</td>
  			</tr>
  			<tr>
  				<td>计划机型：${info.airplane.code}（${info.airplane.airplaneType}）</td>
  				<td align="right">${info.flightAirportLine.arrivalAirport.name}${info.flightAirportLine.arrivalTerminalBuilding.code}</td>
  				<td align="center"></td>
  				<td>${info.flightAirportLine.departureAirport.name}</td>
  			</tr>
  		</table>
  		</div>
  	</div>
  	
	<br/>
	<div>
  		<div>报价信息</div>
  		<div>
  			<table>
  				<tr>
  					<td width="100">PNR</td>
  					<td width="100">乘客类型</td>
  					<td width="100">票面价</td>
  					<td width="100">佣金</td>
  					<td width="100">基建燃油费</td>
  					<td width="100">结算价</td>
  					<td width="100">平台调控</td>
  					<td width="100">销售价</td>
  					<td width="100">政策ID</td>
  				</tr>
  			</table>
  		</div>
  		<div>
  			<table>
  				<tr>
  					<td width="100">1231</td>
  					<td width="100">${passengerInfo.passengerType}</td>
  					<td width="100">${ticketInfo.flightOrderTicketPrice.parPrice}</td>
  					<td width="100"><font-color="red">10.00</font-color></td>
  					<td width="100">${ticketInfo.flightOrderTicketPrice.airportTax}+${ticketInfo.flightOrderTicketPrice.fuelTax}</td>
  					<td width="100">${ticketInfo.flightOrderTicketPrice.settlePrice}</td>
  					<td width="100"></td>
  					<td width="100"></td>
  					<td width="100">${ticketInfo.flightOrderPNRInfo.id}</td>
  				</tr>
  			</table>
  			<table border="1">
				<tr>
					<td colspan="2" >
						成人票退改签规定
					</td>
				</tr>
				<tr>
					<td width="100">
						退改签规定
					</td>
					<td width="700">
						航班规定离站时间2小时之前免收变更费，离站时间2小时以内至航班起飞后收取5%变更费;航班规定离站时间2小时之前收取5%退票费，离站时间2小时以内至航班起飞后收取10%退票费。
					</td>
				</tr>
				<tr>
					<td width="100">
						政策备注
					</td>
					<td >政策【000001】退改签补充说明备注信息。</td>
				</tr>
			</table>
			
			<table>
  				<tr>
  					<td width="100">1</td>
  					<td width="100">儿童</td>
  					<td width="100">790</td>
  					<td width="100">10.00</td>
  					<td width="100">120</td>
  					<td width="100"></td>
  					<td width="100"></td>
  					<td width="100"></td>
  					<td width="100"></td>
  				</tr>
  			</table>
  			<table border="1">
				<tr>
					<td colspan="2" >
						儿童票退改签规定
					</td>
				</tr>
				<tr>
					<td width="100">
						退改签规定
					</td>
					<td width="700">
						航班规定离站时间2小时之前免收变更费，离站时间2小时以内至航班起飞后收取5%变更费;航班规定离站时间2小时之前收取5%退票费，离站时间2小时以内至航班起飞后收取10%退票费。
					</td>
				</tr>
				<tr>
					<td width="100">
						政策备注
					</td>
					<td >政策【000001】退改签补充说明备注信息。</td>
				</tr>
			</table>
		</div>
	</div>
	
	<br/>
	
	<div>
		<table>
			<tr><td colspan="11">乘客信息</td></tr>
			<tr>
				<td><input type="checkbox" name="ids" value=""/></td>
				<td>乘客类型</td>
				<td>乘客姓名</td>
				<td>证件类型</td>
				<td>证件号</td>
				<td>PNR（大/小）</td>
				<td>PNR（大/小）新</td>
				<td>舱位</td>
				<td>票号</td>
				<td>行程单</td>
				<td>保险</td>
			</tr>
			<tr>
				<td><input type="checkbox" name="id" value=""/></td>
				<td>
					${passengerInfo.passengerType}
				</td>
				<td>
					${passengerInfo.passengerName}
				</td>
				<td>
					${passengerInfo.passengerIDCardType}
				</td>
				<td>
					${passengerInfo.passengerIDCardNo}
				</td>
				<td>
					${pnrInfo.pnr}/${pnrInfo.pnr}
				</td>
				<td>
					${pnrInfo.pnr}/${pnrInfo.pnr}
				</td>
				<td>
					${info.flightSeat.seatClass.code}
				</td>
				<td>
					${ticketInfo.flightTicketNo}
				</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td colspan="11">
					<input type="button" value="申请改签" />
					<input type="button" value="申请退票" />
				</td>
			</tr>
		</table>
		
		<table>
			<tr><td colspan="8">结算（应收合计：<span id="countMoney">￥3806.80</span>）</td></tr>
			<tr>
				<td></td>
				<td>票面价</td>
				<td>-  调控金额</td>
				<td>+ 机建</td>
				<td>+ 燃油</td>
				<td>+ 保险</td>
				<td>+ 附加费</td>
				<td>+ 快递费</td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>总计	</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
		<table>
			<tr><td colspan="5">支付信息</td></tr>
			<tr>
				<td>支付方式</td>
				<td>支付时间</td>
				<td>支付账号</td>
				<td>支付金额</td>
				<td>支付状态</td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
		
		<table>
			<tr><td colspan="4">操作日志</td></tr>
			<tr>
				<td width="200">节点时间</td>
				<td width="200">操作详情</td>
				<td width="200">
					<select>
						<option value ="all">全部</option>
						<option value ="system">系统</option>
						<option value="service">客服</option>
						<option value="customer">客户</option>
					</select>
				</td>
				<td width="200">备注</td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
		<div>
			<div>新增备注</div>
			<textarea rows="3" cols="100"></textarea>
		</div>
	</div>
  </body>
</html>
