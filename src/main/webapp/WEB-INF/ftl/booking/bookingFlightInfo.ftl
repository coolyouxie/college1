<#list segList as flightInfos> 
		<#if flightInfos.flightTripType == "DEPARTURE">
		<div class="top">
			<div class="msg">
				<div class="title"><#if flightInfos.routeType=='OW'>${flightInfos.routeTypeName}<#else>${flightInfos.flightTripTypeName}</#if> &nbsp;${flightInfos.departCityName}
					&nbsp;-&nbsp;${flightInfos.arriveCityName}</div>
				<table>
					<tr>
						<td><img src="images/order/topxf.png">
							${flightInfos.flightSearchFlightInfoDto.carrierName} &nbsp;<strong>${flightInfos.flightSearchFlightInfoDto.flightNo}</strong>
							<div class="div-1">
								计划机型：<span class="blue tankuang_hover">${(flightInfos.flightSearchFlightInfoDto.airplane.code)}(${(flightInfos.flightSearchFlightInfoDto.airplane.airplaneType)})</span>
							</div>
							<div class="area_model tankuang_show">
							    <table>
							        <thead>
							            <tr>
							                <td width="80">计划机型</td>
							                <td width="103">机型名称</td>
							                <td width="56">类型</td>
							                <td width="93">最少座位数</td>
							                <td width="93">最多座位数</td>
							            </tr>
							        </thead>
							        <tbody>
							          <tr>
										      <td>${(flightInfos.flightSearchFlightInfoDto.airplane.code)!''}</td>
										      <td>${(flightInfos.flightSearchFlightInfoDto.airplane.name)!''}${(flightInfos.flightSearchFlightInfoDto.airplane.code)!''}</td>
										      <td>${(flightInfos.flightSearchFlightInfoDto.airplane.airplaneType)!''}</td>
										      <td>${(flightInfos.flightSearchFlightInfoDto.airplane.minSeats)!''}</td>
										      <td>${(flightInfos.flightSearchFlightInfoDto.airplane.maxSeats)!''}</td>
							          </tr>
							        </tbody>
							    </table>
							</div>
							
						</td>
						<input type="hidden" name="flightDepartureDate" id="flightDepartureDate" value="${flightInfos.flightSearchFlightInfoDto.departureDate}"/>
						<td><div class="div-2">
								${flightInfos.flightSearchFlightInfoDto.departureTime}
								&nbsp;&nbsp;— <i><#if
									(flightInfos.flightSearchFlightInfoDto.stopCount>0) >
									经停<#else>不经停</#if></i>
								—&nbsp;&nbsp;${flightInfos.flightSearchFlightInfoDto.arrivalTime}
								<number>${flightInfos.crossDayInfo}</number>
								<div class="name">
									${flightInfos.flightSearchFlightInfoDto.departureAirportName}${flightInfos.flightSearchFlightInfoDto.departureTermainalBuilding} <i></i>
									${flightInfos.flightSearchFlightInfoDto.arrivalAirportName}${flightInfos.flightSearchFlightInfoDto.arrivalTerminalBuilding}
								</div></td>
						<#list flightInfos.flightSearchFlightInfoDto.seats as seat>
						<td>${seat.seatClassName}${seat.seatClassCode}</td>
						</#list>
						<td>退改签说明</td>
						<td class="td-5">机建：&yen;${flightInfos.airportFee}
						&nbsp;+&nbsp;燃油：&yen;${flightInfos.fuelsurTax}</td>
						<td class="td-6">${flightInfos.flightSearchFlightInfoDto.departureDate}</td>
						
						<td><a href="javascript:void(0);" class="fr mr10 mobily_flight" onclick="modifyOWFlight();">修改航班</a>
						<div id="modifyOWFlightDiv">
							<input type="hidden" name="departureAirportCode" value="${flightInfos.departureAirportCode}"/>
							<input type="hidden" name="arrivalAirportCode" value="${flightInfos.arrivalAirportCode}"/>
							<input type="hidden" name="departDate" value="${flightInfos.departureDate}"/>
							<input type="hidden" name="departCity" value="${flightInfos.departCityCode}"/>
							<input type="hidden" name="arriveCity" value="${flightInfos.arriveCityCode}"/>
							<input type="hidden" name="vstOrderId" value="${vstOrderId}"/>
							<input type="hidden" name="vstOrderMainId" value="${vstOrderMainId}"/>
							<#if arriveDate??><input type="hidden" name="arriveDate" value="${arriveDate}"/></#if>
							<#if flightInfos.routeType=='OW'>
								<input type="hidden" name="doWay" value="1"/>
							</#if>
							<#if flightInfos.routeType=='RT'>
								<input type="hidden" name="doWay" value="2"/>
								<input type="hidden" name="bookingFirstDto.flightNo" value="${flightInfos.bookingFirstDto.flightNo}"/>
								<input type="hidden" name="bookingFirstDto.departCity" value="${flightInfos.arriveCityCode}"/>
								<input type="hidden" name="bookingFirstDto.arriveCity" value="${flightInfos.departCityCode}"/>
								<input type="hidden" name="bookingFirstDto.departedDate" value="${flightInfos.bookingFirstDto.departedDate}"/>
								<input type="hidden" name="bookingFirstDto.arriveDate" value="${flightInfos.flightSearchFlightInfoDto.departureDate}"/>
								<input type="hidden" name="bookingFirstDto.departTime" value="${flightInfos.bookingFirstDto.departTime}"/>
								<input type="hidden" name="bookingFirstDto.arriveTime" value="${flightInfos.bookingFirstDto.arriveTime}"/>
								<input type="hidden" name="bookingFirstDto.departAirportCode" value="${flightInfos.bookingFirstDto.departAirportCode}"/>
								<input type="hidden" name="bookingFirstDto.arriveAirportCode" value="${flightInfos.bookingFirstDto.arriveAirportCode}"/>
								<input type="hidden" name="bookingFirstDto.seatClassCode" value="${flightInfos.bookingFirstDto.seatClassCode}"/>
								<input type="hidden" name="bookingFirstDto.parPrice" value="${flightInfos.bookingFirstDto.parPrice}"/>
								<input type="hidden" name="bookingFirstDto.policyId" value="${flightInfos.bookingFirstDto.policyId}"/>
								<input type="hidden" name="bookingFirstDto.carrierName" value="${flightInfos.bookingFirstDto.carrierName}"/>
								<input type="hidden" name="bookingFirstDto.departureTermainalBuilding" value="${flightInfos.bookingFirstDto.departureTermainalBuilding}"/>
								<input type="hidden" name="bookingFirstDto.arrivalTerminalBuilding" value="${flightInfos.bookingFirstDto.arrivalTerminalBuilding}"/>
								<input type="hidden" name="bookingFirstDto.arrivalAirportName" value="${flightInfos.bookingFirstDto.arrivalAirportName}"/>
								<input type="hidden" name="bookingFirstDto.departureAirportName" value="${flightInfos.bookingFirstDto.departureAirportName}"/>
								<input type="hidden" name="bookingFirstDto.stopCount" value="${flightInfos.bookingFirstDto.stopCount}"/>
								<input type="hidden" name="bookingFirstDto.seatClassName" value="${flightInfos.bookingFirstDto.seatClassName}"/>
								<input type="hidden" name="bookingFirstDto.seatClassDesc" value="${flightInfos.bookingFirstDto.seatClassDesc}"/>
								<input type="hidden" name="bookingFirstDto.stopCity" value="${flightInfos.bookingFirstDto.stopCity}"/>
								<input type="hidden" name="bookingFirstDto.flightCode" value="${flightInfos.bookingFirstDto.flightCode}"/>
								<input type="hidden" name="bookingFirstDto.airportFee" value="${flightInfos.bookingFirstDto.airportFee}"/>
								<input type="hidden" name="bookingFirstDto.fuelsurTax" value="${flightInfos.bookingFirstDto.fuelsurTax}"/>
								<input type="hidden" name="bookingFirstDto.salePrice" value="${flightInfos.bookingFirstDto.salePrice}"/>
								<input type="hidden" name="bookingFirstDto.airplaneModel.code" value="${flightInfos.bookingFirstDto.airplaneModel.code}"/>
								<input type="hidden" name="bookingFirstDto.airplaneModel.name" value="${flightInfos.bookingFirstDto.airplaneModel.name}"/>
								<input type="hidden" name="bookingFirstDto.airplaneModel.airplaneType" value="${flightInfos.bookingFirstDto.airplaneModel.airplaneType}"/>
								<input type="hidden" name="bookingFirstDto.airplaneModel.minSeats" value="${flightInfos.bookingFirstDto.airplaneModel.minSeats}"/>
								<input type="hidden" name="bookingFirstDto.airplaneModel.maxSeats" value="${flightInfos.bookingFirstDto.airplaneModel.maxSeats}"/>
								<input type="hidden" name="bookingFirstDto.carrierCode" value="${flightInfos.bookingFirstDto.carrierCode}"/>
								<input type="hidden" name="bookingFirstDto.tripType" value="RETURN"/>
							</#if>
						</div>
						</td>
					</tr>
				</table>
				
			</div>
		</div>
		<div class="price">
			<div class="title">商品价格</div>
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td>&nbsp;</td>
					<td>票面价</td>
					<td>机建费</td>
					<td>燃油费</td>
					<td>优惠金额</td>
					<td>销售价</td>
					<td>政策ID</td>
					<td>供应商</td>
					<td class="last-td">供应商政策ID</td>
				</tr>
				<#list flightInfos.productPrices as productPrice> 
				<#if productPrice_index == 0>
				<tr>
					<td><#if productPrice.passengerType='CHILDREN'>儿童</#if><#if productPrice.passengerType='ADULT'>成人</#if></td>
					<td>${(productPrice.parPrice)}</td>
					<td>${(productPrice.feeAmount)}</td>
					<td>${(productPrice.taxAmount)}</td>
					<td>${(productPrice.promotion)}</td>
					<td>${(productPrice.salePrice)}</td>
					<td>[${(productPrice.policyId)}]</td>
					<td>${(productPrice.suppName)}</td>
					<td class="last-td">[${(productPrice.suppPolicyNo)}]</td>
				</tr>
				<tr class="tr-3">
					<td colspan="10" class="last-td">政策备注：政策补充退改签说明。政策补充说明：政策补充退改签说明。
					</td>
				</tr>
				<#else>
				<tr>
					<td><#if productPrice.passengerType='CHILDREN'>儿童</#if><#if productPrice.passengerType='ADULT'>成人</#if></td>
					<td>${(productPrice.parPrice)}</td>
					<td>${(productPrice.feeAmount)}</td>
					<td>${(productPrice.taxAmount)}</td>
					<td>${(productPrice.promotion)}</td>
					<td>${(productPrice.salePrice)}</td>
					<td>[${(productPrice.policyId)}]</td>
					<td>${(productPrice.suppName)}</td>
					<td class="last-td">[${(productPrice.suppPolicyNo)}]</td>
				</tr>
				</#if>
				</#list>
			</table>
		</div>
		<div class="tab order-tab">
			<div class="tab-title">
	             <button class="btn1">成人<span>极</span></button>
	             <button class="btn2">儿童<span>极</span></button>
	         </div>
			<div id="singleWay" class="tab-cot">
			          <#list segList as flightInfos>
			            <#if flightInfos.flightTripType == "DEPARTURE">
			             	<#list flightInfos.ticketRuleSimples as ticketRuleSimple>
									<table class="withdraw">
								          <tbody>
								                <#list ticketRuleSimple.simpleDetails as simpleDetail>
									              <tr>
									                 <#if simpleDetail_index == 0>
									                    <td style="border-bottom: 1px solid #d6e5f1;" rowspan="${ticketRuleSimple.simpleDetails?size}">${ticketRuleSimple.passengerTypeName}</td>
									                  </#if>
									                  <td >${simpleDetail.detailFeeTypeName}</td>
									                  <td>${simpleDetail.detailFeeDesc}</td>
									              </tr>
								              </#list>
								           </tbody>
								      </table>
							</#list>
						</#if>
			          </#list>
			</div>
		</div>
		</#if> 
		<#if flightInfos.flightTripType == "RETURN">
		<div class="top">
			<div class="msg">
			<div class="title">${flightInfos.flightTripTypeName} &nbsp;${flightInfos.departCityName}
			&nbsp;-&nbsp;${flightInfos.arriveCityName}</div>
				<table>
					<tr>
						<td><img src="images/order/topxf.png">
							${flightInfos.flightSearchFlightInfoDto.carrierName} &nbsp;<strong>${flightInfos.flightSearchFlightInfoDto.flightNo}</strong>
							<div class="div-1">
								计划机型：<span class="blue tankuang_hover">${(flightInfos.flightSearchFlightInfoDto.airplane.code)}(${(flightInfos.flightSearchFlightInfoDto.airplane.airplaneType)})</span>
							</div>
							<div class="area_model tankuang_show">
							    <table>
							        <thead>
							            <tr>
							                <td width="80">计划机型</td>
							                <td width="103">机型名称</td>
							                <td width="56">类型</td>
							                <td width="93">最少座位数</td>
							                <td width="93">最多座位数</td>
							            </tr>
							        </thead>
							        <tbody>
							          <tr>
										      <td>${(flightInfos.flightSearchFlightInfoDto.airplane.code)!''}</td>
										      <td>${(flightInfos.flightSearchFlightInfoDto.airplane.name)!''}${(flightInfos.flightSearchFlightInfoDto.airplane.code)!''}</td>
										      <td>${(flightInfos.flightSearchFlightInfoDto.airplane.airplaneType)!''}</td>
										      <td>${(flightInfos.flightSearchFlightInfoDto.airplane.minSeats)!''}</td>
										      <td>${(flightInfos.flightSearchFlightInfoDto.airplane.maxSeats)!''}</td>
							          </tr>
							        </tbody>
							    </table>
							</div>	
							
						</td>
						
						<td><div class="div-2">
								${flightInfos.flightSearchFlightInfoDto.departureTime}
								&nbsp;&nbsp;—<i><#if
								(flightInfos.flightSearchFlightInfoDto.stopCount>0)
								>经停<#else>不经停</#if></i>—&nbsp;&nbsp;${flightInfos.flightSearchFlightInfoDto.arrivalTime}
								<number>${flightInfos.crossDayInfo}</number>
								<div class="name">
									${flightInfos.flightSearchFlightInfoDto.departureAirportName}${flightInfos.flightSearchFlightInfoDto.departureTermainalBuilding} <i></i>
									${flightInfos.flightSearchFlightInfoDto.arrivalAirportName}${flightInfos.flightSearchFlightInfoDto.arrivalTerminalBuilding}
								</div></td>
						<#list flightInfos.flightSearchFlightInfoDto.seats as seat>
						<td>${seat.seatClassName}${seat.seatClassCode}</td>
						</#list>
						<td>退改签说明</td>
						<td class="td-5"><td class="td-5">机建：&yen;${flightInfos.airportFee}
						&nbsp;+&nbsp;燃油：&yen;${flightInfos.fuelsurTax}</td></td>
						<td class="td-6">${flightInfos.flightSearchFlightInfoDto.departureDate}</td>
						<td><a href="javascript:void(0);" class="fr mr10 mobily_flight" onclick="modifyRTFlight();">修改航班</a>
						<div id="modifyRTFlightDiv">
							<input type="hidden" name="departureAirportCode" value="${flightInfos.departureAirportCode}"/>
							<input type="hidden" name="arrivalAirportCode" value="${flightInfos.arrivalAirportCode}"/>
							<input type="hidden" name="arriveDate" value="${flightInfos.bookingFirstDto.departedDate}"/>
							<input type="hidden" name="departDate" value="${flightInfos.departureDate}"/>
							<input type="hidden" name="departCity" value="${flightInfos.departCityCode}"/>
							<input type="hidden" name="arriveCity" value="${flightInfos.arriveCityCode}"/>
							<input type="hidden" name="vstOrderId" value="${vstOrderId}"/>
							<input type="hidden" name="vstOrderMainId" value="${vstOrderMainId}"/>
							<input type="hidden" name="doWay" value="2"/>
							
							<input type="hidden" name="bookingFirstDto.flightNo" value="${flightInfos.bookingFirstDto.flightNo}"/>
							<input type="hidden" name="bookingFirstDto.departCity" value="${flightInfos.arriveCityCode}"/>
							<input type="hidden" name="bookingFirstDto.arriveCity" value="${flightInfos.departCityCode}"/>
							<input type="hidden" name="bookingFirstDto.departedDate" value="${flightInfos.bookingFirstDto.departedDate}"/>
							<input type="hidden" name="bookingFirstDto.arriveDate" value="${flightInfos.flightSearchFlightInfoDto.departureDate}"/>
							<input type="hidden" name="bookingFirstDto.departTime" value="${flightInfos.bookingFirstDto.departTime}"/>
							<input type="hidden" name="bookingFirstDto.arriveTime" value="${flightInfos.bookingFirstDto.arriveTime}"/>
							<input type="hidden" name="bookingFirstDto.departAirportCode" value="${flightInfos.bookingFirstDto.departAirportCode}"/>
							<input type="hidden" name="bookingFirstDto.arriveAirportCode" value="${flightInfos.bookingFirstDto.arriveAirportCode}"/>
							<input type="hidden" name="bookingFirstDto.seatClassCode" value="${flightInfos.bookingFirstDto.seatClassCode}"/>
							<input type="hidden" name="bookingFirstDto.parPrice" value="${flightInfos.bookingFirstDto.parPrice}"/>
							<input type="hidden" name="bookingFirstDto.policyId" value="${flightInfos.bookingFirstDto.policyId}"/>
							<input type="hidden" name="bookingFirstDto.carrierName" value="${flightInfos.bookingFirstDto.carrierName}"/>
							<input type="hidden" name="bookingFirstDto.departureTermainalBuilding" value="${flightInfos.bookingFirstDto.departureTermainalBuilding}"/>
							<input type="hidden" name="bookingFirstDto.arrivalTerminalBuilding" value="${flightInfos.bookingFirstDto.arrivalTerminalBuilding}"/>
							<input type="hidden" name="bookingFirstDto.arrivalAirportName" value="${flightInfos.bookingFirstDto.arrivalAirportName}"/>
							<input type="hidden" name="bookingFirstDto.departureAirportName" value="${flightInfos.bookingFirstDto.departureAirportName}"/>
							<input type="hidden" name="bookingFirstDto.stopCount" value="${flightInfos.bookingFirstDto.stopCount}"/>
							<input type="hidden" name="bookingFirstDto.seatClassName" value="${flightInfos.bookingFirstDto.seatClassName}"/>
							<input type="hidden" name="bookingFirstDto.seatClassDesc" value="${flightInfos.bookingFirstDto.seatClassDesc}"/>
							<input type="hidden" name="bookingFirstDto.stopCity" value="${flightInfos.bookingFirstDto.stopCity}"/>
							<input type="hidden" name="bookingFirstDto.flightCode" value="${flightInfos.bookingFirstDto.flightCode}"/>
							<input type="hidden" name="bookingFirstDto.airportFee" value="${flightInfos.bookingFirstDto.airportFee}"/>
							<input type="hidden" name="bookingFirstDto.fuelsurTax" value="${flightInfos.bookingFirstDto.fuelsurTax}"/>
							<input type="hidden" name="bookingFirstDto.salePrice" value="${flightInfos.bookingFirstDto.salePrice}"/>
							<input type="hidden" name="bookingFirstDto.airplaneModel.code" value="${flightInfos.bookingFirstDto.airplaneModel.code}"/>
							<input type="hidden" name="bookingFirstDto.airplaneModel.name" value="${flightInfos.bookingFirstDto.airplaneModel.name}"/>
							<input type="hidden" name="bookingFirstDto.airplaneModel.airplaneType" value="${flightInfos.bookingFirstDto.airplaneModel.airplaneType}"/>
							<input type="hidden" name="bookingFirstDto.airplaneModel.minSeats" value="${flightInfos.bookingFirstDto.airplaneModel.minSeats}"/>
							<input type="hidden" name="bookingFirstDto.airplaneModel.maxSeats" value="${flightInfos.bookingFirstDto.airplaneModel.maxSeats}"/>
							<input type="hidden" name="bookingFirstDto.carrierCode" value="${flightInfos.bookingFirstDto.carrierCode}"/>
							<input type="hidden" name="bookingFirstDto.tripType" value="DEPARTURE"/>
						</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="price">
			<div class="title">商品价格</div>
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td>&nbsp;</td>
					<td>票面价</td>
					<td>机建费</td>
					<td>燃油费</td>
					<td>优惠价格</td>
					<td>销售价</td>
					<td>政策ID</td>
					<td>供应商</td>
					<td class="last-td">供应商政策ID</td>
				</tr>
				<#list flightInfos.productPrices as productPrice> 
				<#if productPrice_index == 0>
				<tr>
					<td><#if productPrice.passengerType='CHILDREN'>儿童</#if><#if productPrice.passengerType='ADULT'>成人</#if></td>
					<td>${productPrice.parPrice}</td>
					<td>${(productPrice.feeAmount)}</td>
					<td>${(productPrice.taxAmount)}</td>
					<td>${(productPrice.promotion)}</td>
					<td>${(productPrice.salePrice)}</td>
					<td>[${(productPrice.policyId)}]</td>
					<td>${productPrice.suppName}</td>
					<td class="last-td">[${(productPrice.suppPolicyNo)}]</td>
				</tr>
				<tr class="tr-3">
					<td colspan="10" class="last-td">政策备注：政策补充退改签说明。<br>政策补充说明：政策补充退改签说明。
					</td>
				</tr>
				<#else>
				<tr>
					<td><#if productPrice.passengerType='CHILDREN'>儿童</#if><#if productPrice.passengerType='ADULT'>成人</#if></td>
					<td>${productPrice.parPrice}</td>
					<td>${(productPrice.feeAmount)}</td>
					<td>${(productPrice.taxAmount)}</td>
					<td>${(productPrice.promotion)}</td>
					<td>${(productPrice.salePrice)}</td>
					<td>[${(productPrice.policyId)}]</td>
					<td>${productPrice.suppName}</td>
					<td class="last-td">[${productPrice.suppPolicyNo}]</td>
				</tr>
				</#if>
				</#list>
			</table>
		</div>
		<div class="tab order-tab">
			<div class="tab-title">
	              <button class="btn1">成人<span>极</span></button>
	             <button class="btn2">儿童<span>极</span></button>
	         </div>
			<div id="returnTrip" class="tab-cot">
			     <#list segList as flightInfos>
			            <#if flightInfos.flightTripType == "RETURN">
			             	<#list flightInfos.ticketRuleSimples as ticketRuleSimple>
									<table class="withdraw">
								          <tbody>
								                <#list ticketRuleSimple.simpleDetails as simpleDetail>
									              <tr>
									                 <#if simpleDetail_index == 0>
									                    <td style="border-bottom: 1px solid #d6e5f1;" rowspan="${ticketRuleSimple.simpleDetails?size}">${ticketRuleSimple.passengerTypeName}</td>
									                  </#if>
									                  <td >${simpleDetail.detailFeeTypeName}</td>
									                  <td>${simpleDetail.detailFeeDesc}</td>
									              </tr>
								              </#list>
								           </tbody>
								      </table>
							</#list>
						</#if>
			         </#list>
			</div>
		</div>
		</#if> 
		</#list>