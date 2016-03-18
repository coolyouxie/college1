<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>搜索结果页</title>
<script type="text/javascript" src="${request.contextPath}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/base.js"></script> 
<script type="text/javascript" src="${request.contextPath}/js/common.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/jquery-ui.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/search.js"></script>
 
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/citychoose.css">
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/jquery-ui.css">
<link rel="stylesheet" href="${request.contextPath}/css/platfrom.css" />
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/area_tankuang.css">
<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
 
</head>

<body>
<div class="publicbox">
	<!--导航面包-->
     <div class="search-nav" id="userMeberName"><a href="#">首页</a> > 航班查询 （会员：<span>
     <#if userMember?exists>   
         ${userMember.userName}          
     </#if>
    </span>）</div>
    <!--选择出发城市、日期-->
    <form id="search_form" action="search" method="post">
    <div class="startwrap">
        <div class="typeofflight">
        	<ul class="way">
            	<li><input class="doWay1" name="doWay" type="radio" value="1" checked="true" onclick="routeType(this);"/> 单程</li>
                <li><input class="doWay2" name="doWay" type="radio" value="2" onclick="routeType(this);"/> 往返</li>
            </ul>
        </div>
        <ul class="city">
            <dl>
                <dt>出发城市</dt>
                <dd><!-- <input name="" type="text" /> -->
                    <div class="demo">
                      <div>
                        <input id="departCity" type="text" value="${objSear.departCity}" size="15" name="departCity" mod="address|notice" mod_address_source="hotel" mod_address_suggest="" mod_address_reference="getcityid" mod_notice_tip="中文/拼音" autocomplete="off" style="color: gray;"
                        class="input_a per70">
                      </div>
                    </div>
                </dd>
            </dl>
            <dl>
                <dt>到达城市</dt>
                <dd><!-- <input name="" type="text" /> -->
                    <div class="demo">
                      <div>
                        <input id="arriveCity" type="text" value="${objSear.arriveCity}" size="15" name="arriveCity" mod="address|notice" mod_address_source="hotel" mod_address_suggest="" mod_address_reference="getcityid" mod_notice_tip="中文/拼音" autocomplete="off" style="color: gray;"
                        class="input_a per70">
                      </div>
                    </div>
                </dd>
            </dl>
        </ul>
        
        <ul class="change">&nbsp;<a href="#" onclick="tranferCity();">换</a></ul>
        <ul class="city">
            <dl id="departDateId">
                <dt>出发日期</dt>
                <dd>
                    <div class="datechange">
                        <div class="input_date">
                        <input id="departTime" type="text" name="departDate" class="input_d per70" onfocus="WdatePicker({doubleCalendar:true,dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d',maxDate:'{%y+1}-%M-%d'})" value="${objSear.departDate}" readonly="readonly"></input>
                        </div>
                    </div>
                </dd>
            </dl>
            <dl id="arriveDateId">
                <dt>返回日期</dt>
                <dd><!-- <input name="" type="text" /> -->
                    <div class="datechange">
                        <div class="input_date">
                        <input id="arriveTime" type="text" name="arriveDate" class="input_d per70" onfocus="WdatePicker({doubleCalendar:true,dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d',maxDate:'{%y+1}-%M-%d'})" value="${objSear.arriveDate}" readonly="readonly"></input>
                        </div>
                    </div>
                </dd>
            </dl>
        </ul>
        <div class="pinkbut pt20"><a href="#" onclick="searchSubmit();">搜索</a></div>
    </div>
    </form>
    
<!--选择航班,单程、往返切换-->
<!-- 单程 -->
    <div class="flighttab">
        <div class="f16 fb mt10">选择航班:<span>${objSear.departCity}</span> > <span>${objSear.arriveCity} </span><span>( ${departDate} ${week} )</span></div>
        
        <!--日期选择 tab轮转切换-->
        <div class="datebox mt10">
        	<div class="datecontent">
                <div class="li_dancheng">
                    <button class="prv"><span></span></button>
                    <div class="datelist">
                        <nav>
                          <ul>
		                  </ul>
                        </nav>
                    </div>
                    <button class="next"><span></span></button> 
                </div>
            </div>
            <div class="date-rili" onclick="minPriceDate();">
                <a href="#"><img src="${request.contextPath}/images/order/rili0306.png" /></a>
                <span class="">查看30天<br />最低价</span>
            </div>
        </div>
         <!--航班信息切换-->
         <div class="t_content">
            <div class="content">
            	<div class="shaixuan01">
                  <span class="fl">筛选条件：</span>
                  <select id="departTimeSeg" name="select" onchange="departSeg();">
                    <#list departureTimeSegment as departTime>
                    <#list departTime?keys as itemKey>
					<#if departTime_index=0>
						<option selected value="${itemKey}">${departTime[itemKey]}</option>
					<#else>
						<option value="${itemKey}">${departTime[itemKey]}

						</option>
					</#if>
					</#list>
					</#list>
                  </select>
                  <select id="arriveTimeSeg" name="select" onchange="departSeg();">
	                    <#list arrivalTimeSegment as arrivalTime>
	                    <#list arrivalTime?keys as itemKey>
						<#if arrivalTime_index=0>
							<option selected value="${itemKey}">${arrivalTime[itemKey]}</option>
						<#else>
							<option value="${itemKey}">${arrivalTime[itemKey]}</option>
						</#if>
						</#list>
						</#list>
	              </select>
                  <select id="carrierCode" name="select" onchange="departSeg();">
	                    <#list carrierCode as code>
	                    <#list code?keys as itemKey>
						<#if code_index=0>
							<option selected value="${itemKey}">${code[itemKey]}</option>
						<#else>
							<option value="${itemKey}">${code[itemKey]}</option>
						</#if>
						</#list>
						</#list>
	              </select>
                  <select id="seatBand" name="select" onchange="departSeg();">
                    <#list seatClasss as seatClass>
                    <#list seatClass?keys as itemKey>
					<#if seatClass_index=0>
						<option selected value="${itemKey}">${seatClass[itemKey]}</option>
					<#else>
						<option value="${itemKey}">${seatClass[itemKey]}</option>
					</#if>
					</#list>
					</#list>
                  </select>
                   <div class="fl"><input type="checkbox" name="toRedeem" id="isHaveMeal" onclick="departSeg();"/>&nbsp;<label for="to_redeem">餐食</label>&nbsp;&nbsp;</div>
                   <div class="fl"><input type="checkbox" name="toRedeem" id="isDirect" onclick="departSeg();"/>&nbsp;<label for="to_redeem">直飞</label>&nbsp;&nbsp;</div>
                </div>
                <div id="doWaySingle" class="shaixuan02">
                  <span class="fl">您已选择：</span>
                  <#list filterRecords as filterRecord>
                      <p>${filterRecord}<i>&times;</i></p>
                  </#list>
                  <a href="#" id="clear_c">清除所有条件</a>
    			</div>
                <div class="airmsg mt10">
                	<ul>
                    	<li class="w18 ml2">航班信息</li>
                        <li class="w27 tc"><a href="javascript:void(0);" onclick="arriveTimeSort();">起抵时间<span><font><#if objSear.sortByDepartureTimeDate == 'DESC'>▼<#else>▲</#if></font></span></a>
                        	<input type="hidden" name=""/>
                        </li>
                        <li class="w10"><a href="javascript:void(0);" onclick="flyTimeSort();">飞行时长<span><font><#if objSear.sortByFlyTimeHours == 'DESC'>▼<#else>▲</#if></font></span></a></li>
                        <li class="w6">餐食</li>
                        <li class="w10"><a href="javascript:void(0);" onclick="parpriceSort();">票面价<span><font><#if objSear.sortByParPrice == 'DESC'>▼<#else>▲</#if></font></span></a></li>
                        <li class="w8">佣金</li>
                        <li class="w10"><a href="javascript:void(0);" onclick="salePriceSort();">销售价（含税）<span><font><#if objSear.sortBySettlePrice == 'DESC'>▼<#else>▲</#if></font></span></a></li>
                    </ul>
                </div>
                
            <#if (flights?size = 0)>
            	未查到航班信息!
            </#if>
            <#list flights as flight>
            <#if (flight.sortedSeats?size >=3)>
            <div class="bor_orange">
            	<div id="${flight.flightNo}_ow">
                <div class="airmsg02">
                    <ul>
                        <li class="w18 position_r"><img src="${request.contextPath}/images/order/airlogo1.png" /><span class="ml1">${flight.carrierName} ${flight.flightNo}</span><span class="gray02 style_p">计划机型&nbsp;<i class="blue tankuang_hover">${flight.airplaneModel.code}</i></span>
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
                                                <td>${flight.airplaneModel.code}</td>
						                        <td>${flight.airplaneModel.name}${flight.airplaneModel.code}</td>
						                        <td>${flight.airplaneModel.airplaneType}</td>
						                        <td>${flight.airplaneModel.minSeats}</td>
						                        <td>${flight.airplaneModel.maxSeats}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                        </li>
                        <li class="w27 tc">
                            <span class="ml35">${flight.departureTime}—<br /><i class="gray02">${flight.departureAirportName}${flight.departureTermainalBuilding}</i></span>
                            <span class="red ml3 mr3"><#if (flight.stopCount>0)>经停<#else>不经停</#if></span>
                            <span>—${flight.arrivalTime} ${flight.crossDay}<br /><i class="gray02">${flight.arrivalAirportName}${flight.arrivalTerminalBuilding}</i></span>
                        </li>
                        <li class="w10">${flight.flyTime}</li>
                        <li class="w6">${flight.mealType}</li>
                        <li class="w10"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&yen;${flight.flightMinParPrice}起</span><span class="gray02">&nbsp;&nbsp;&nbsp;税：&yen;${flight.airportFees}-&yen;${flight.fuelsurTax}</span></li>
                        <li class="w8">&yen;${flight.profitAmount}</li>
                        <li class="w10">&yen;${flight.salePrice}起</li>
                        <li class="w8 bluebut02"></li>
                    </ul>
                </div>
                </div>
                
				<div id="${flight.flightNo}_1">
                <#list flight.yCFseats as seat>
                <form id="${flight.flightNo}${seat.id}${seat.pricePolicyId}_1" action="toBooking.do" method="post">
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].flightNo" value="${flight.flightNo}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].departureDate" value="${objSear.departDate}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].departureAirportCode" value="${flight.departureAirportCode}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].arrivalAirportCode" value="${flight.arrivalAirportCode}"/>
	                <input type="hidden" name="routeType" value="OW"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].seatClassCode" value="${seat.seatClassCode}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].parPrice" value="${seat.parPrice}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].policyId" value="${seat.policyId}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].pricePolicyId" value="${seat.pricePolicyId}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].suppCode" value="${seat.suppCode}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].flightTripType" value="DEPARTURE"/>
	                <input type="hidden" name="deptCityName" value="${objSear.departCity}"/>
	                <input type="hidden" name="arrvCityName" value="${objSear.arriveCity}"/>
	                <input type="hidden" name="userId" value="${objSear.userId}"/>
	                <input type="hidden" name="userName" value="${objSear.userName}"/>
	                <input type="hidden" name="grade" value="${objSear.grade}"/>
                </form>
                
                <div  class="airmsg03" id="${flight.flightNo}_${seat_index}${seat.pricePolicyId}_1">
                    <ul>
                        <li class="w18">&nbsp;&nbsp;&nbsp;&nbsp;${seat.seatClassTypeName}</li>
                        <li class="w16 tr">${seat.seatClassName}${seat.seatClassCode}</li>
                        <li class="w10 blue ml1 tl return_hover" carrierCode='${flight.carrierCode}' departAirportCode='${flight.departureAirportCode}' 
                        	arriveAirportCode='${flight.arrivalAirportCode}' parPrice='${seat.parPrice}' policyId='${seat.policyId}' seatClassCode='${seat.seatClassCode}' pricePolicyId='${seat.pricePolicyId}'
                        >
                        	退改签说明
                        	<div class="endorse_detail"></div>
                        </li>
                        <li class="w10" style="white-space:nowrap">[${seat.suppPolicyId}][${seat.suppCode}]</li>
                        <li class="w6">&nbsp;</li>
                        <li class="w10 orange tc">&yen;${seat.parPrice}</li>
                        <li class="w8 tc">&yen;${seat.profitAmount}</li>
                        <li class="w10 tc"><span class="mt10">&yen;${seat.salePrice}</span><span class="gray">已优惠：&yen;${seat.promotion}</span></li>
                        <li class="w8 orangebut tc"><a href="javascript:void(0);" class="bookbut" flightNo="${flight.flightNo}" seatId="${seat.id}" departAirportCode="${flight.departureAirportCode}" 
                        	arriveAirportCode="${flight.arrivalAirportCode}" parPrice="${seat.parPrice}" policyId="${seat.policyId}" pricePolicyId="${seat.pricePolicyId}" seatClassCode="${seat.seatClassCode}" departDate="${objSear.departDate}" carrierCode="${flight.carrierCode}" onclick="bookingAjax(this);" >预定</a></li>
                        <li><#if (seat.inventoryCount <= 9)><span style="color:red">剩${seat.inventoryCount}张</span></#if></li>
                    </ul>
                </div>
                
                </#list>
				</div>
                <div id="extend_content_${flight.flightNo}_1" style="display:none">
                
                <#list flight.sortedSeats as seat>
                
                <form id="${flight.flightNo}${seat.id}${seat.pricePolicyId}_1" action="toBooking.do" method="post">
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].flightNo" value="${flight.flightNo}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].departureDate" value="${objSear.departDate}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].departureAirportCode" value="${flight.departureAirportCode}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].arrivalAirportCode" value="${flight.arrivalAirportCode}"/>
	                <input type="hidden" name="routeType" value="OW"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].seatClassCode" value="${seat.seatClassCode}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].parPrice" value="${seat.parPrice}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].policyId" value="${seat.policyId}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].pricePolicyId" value="${seat.pricePolicyId}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].suppCode" value="${seat.suppCode}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].flightTripType" value="DEPARTURE"/>
	                <input type="hidden" name="deptCityName" value="${objSear.departCity}"/>
	                <input type="hidden" name="arrvCityName" value="${objSear.arriveCity}"/>
	                <input type="hidden" name="userId" value="${objSear.userId}"/>
	                <input type="hidden" name="userName" value="${objSear.userName}"/>
	                <input type="hidden" name="grade" value="${objSear.grade}"/>
	             </form>
                
                <div class="airmsg03">
                    <ul>
                        <li class="w18">&nbsp;&nbsp;&nbsp;&nbsp;${seat.seatClassTypeName}</li>
                        <li class="w16 tr">${seat.seatClassName}${seat.seatClassCode}</li>
                        <li class="w10 blue ml1 tl return_hover" carrierCode='${flight.carrierCode}' departAirportCode='${flight.departureAirportCode}' 
                    	arriveAirportCode='${flight.arrivalAirportCode}' parPrice='${seat.parPrice}' policyId='${seat.policyId}' seatClassCode='${seat.seatClassCode}' pricePolicyId='${seat.pricePolicyId}'
                        >
                        	退改签说明
                        	<div class="endorse_detail"></div>
                        </li>
                        <li class="w10" style="white-space:nowrap">[${seat.suppPolicyId}][${seat.suppCode}]</li>
                        <li class="w6">&nbsp;</li>
                        <li class="w10 orange tc">&yen;${seat.parPrice}</li>
                        <li class="w8 tc">&yen;${seat.profitAmount}</li>
                        <li class="w10 tc"><span class="mt10">&yen;${seat.salePrice}</span><span class="gray">已优惠：&yen;${seat.promotion}</span></li>
                        <li class="w8 orangebut tc"><a href="javascript:void(0);" class="bookbut" flightNo="${flight.flightNo}" seatId="${seat.id}" departAirportCode="${flight.departureAirportCode}" 
                    	arriveAirportCode="${flight.arrivalAirportCode}" parPrice="${seat.parPrice}" policyId="${seat.policyId}" pricePolicyId="${seat.pricePolicyId}" seatClassCode="${seat.seatClassCode}" departDate="${objSear.departDate}" carrierCode="${flight.carrierCode}" onclick="bookingAjax(this);">预定</a></li>
                    	<li><#if (seat.inventoryCount <= 9)><span style="color:red">剩${seat.inventoryCount}张</span></#if></li>
                    </ul>
                </div>
	            </#list>
                </div>
				<div class="more_e"><a href="#" class="extend" data="${flight.flightNo}"><span>展开所有</span><i>&nbsp;</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div>
	          </div>
	            <#else>
				<div id="${flight.flightNo}_ow">
            	<div class="airmsg02">
                    <ul>
                        <li class="w18 position_r"><img src="${request.contextPath}/images/order/airlogo1.png" /><span class="ml1">${flight.carrierName} ${flight.flightNo}</span><span class="gray02 style_p">计划机型&nbsp;<i class="blue tankuang_hover">${flight.airplaneModel.code}</i></span>
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
                                                <td >${flight.airplaneModel.code}</td>
						                        <td>${flight.airplaneModel.name}${flight.airplaneModel.code}</td>
						                        <td>${flight.airplaneModel.airplaneType}</td>
						                        <td>${flight.airplaneModel.minSeats}</td>
						                        <td>${flight.airplaneModel.maxSeats}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                        </li>
                        <li class="w27 tc">
                            <span class="ml35">${flight.departureTime}—<br /><i class="gray02">${flight.departureAirportName}${flight.departureTermainalBuilding}</i></span>
                            <span class="red ml3 mr3"><#if (flight.stopCount>0)>经停<#else>不经停</#if></span>
                            <span>—${flight.arrivalTime} ${flight.crossDay}<br /><i class="gray02">${flight.arrivalAirportName}${flight.arrivalTerminalBuilding}</i></span>
                        </li>
                        <li class="w10">${flight.flyTime}</li>
                        <li class="w6">${flight.mealType}</li>
                        <li class="w10"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&yen;${flight.flightMinParPrice}起</span><span class="gray02">&nbsp;&nbsp;&nbsp;税：&yen;${flight.airportFees}-&yen;${flight.fuelsurTax}</span></li>
                        <li class="w8">&yen;${flight.profitAmount}</li>
                        <li class="w10">&yen;${flight.salePrice}起</li>
                        <li class="w8 bluebut02"></li>
                    </ul>
                </div>
                </div>
                
                
                <#if flight.yCFseats ?exists> 
                <#list flight.yCFseats as seat>
                <form id="${flight.flightNo}${seat.id}${seat.pricePolicyId}_1" action="toBooking.do" method="post">
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].flightNo" value="${flight.flightNo}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].departureDate" value="${objSear.departDate}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].departureAirportCode" value="${flight.departureAirportCode}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].arrivalAirportCode" value="${flight.arrivalAirportCode}"/>
	                <input type="hidden" name="routeType" value="OW"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].seatClassCode" value="${seat.seatClassCode}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].parPrice" value="${seat.parPrice}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].policyId" value="${seat.policyId}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].pricePolicyId" value="${seat.pricePolicyId}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].suppCode" value="${seat.suppCode}"/>
	                <input type="hidden" name="flightOrderBookingDetailRequests[0].flightTripType" value="DEPARTURE"/>
	                <input type="hidden" name="deptCityName" value="${objSear.departCity}"/>
	                <input type="hidden" name="arrvCityName" value="${objSear.arriveCity}"/>
	                <input type="hidden" name="userId" value="${objSear.userId}"/>
	                <input type="hidden" name="userName" value="${objSear.userName}"/>
	                <input type="hidden" name="grade" value="${objSear.grade}"/>
            	</form>
                <div class="airmsg03">
                    <ul>
                        <li class="w18">&nbsp;&nbsp;&nbsp;&nbsp;${seat.seatClassTypeName}</li>
                        <li class="w16 tr">${seat.seatClassName}${seat.seatClassCode}</li>
                        <li class="w10 blue ml1 tl return_hover" carrierCode='${flight.carrierCode}' departAirportCode='${flight.departureAirportCode}' 
                        	arriveAirportCode='${flight.arrivalAirportCode}' parPrice='${seat.parPrice}' policyId='${seat.policyId}' seatClassCode='${seat.seatClassCode}' pricePolicyId='${seat.pricePolicyId}'
                        >
                        	退改签说明
                        	<div class="endorse_detail"></div>
                        </li>
                        <li class="w10" style="white-space:nowrap">[${seat.suppPolicyId}][${seat.suppCode}]</li>
                        <li class="w6">&nbsp;</li>
                        <li class="w10 orange tc">&yen;${seat.parPrice}</li>
                        <li class="w8 tc">&yen;${seat.profitAmount}</li>
                        <li class="w10 tc"><span class="mt10">&yen;${seat.salePrice}</span><span class="gray">已优惠：&yen;${seat.promotion}</span></li>
                        <li class="w8 orangebut tc"><a href="javascript:void(0);" class="bookbut" flightNo="${flight.flightNo}" seatId="${seat.id}" departAirportCode="${flight.departureAirportCode}" 
                        	arriveAirportCode="${flight.arrivalAirportCode}" parPrice="${seat.parPrice}" policyId="${seat.policyId}" pricePolicyId="${seat.pricePolicyId}" seatClassCode="${seat.seatClassCode}" departDate="${objSear.departDate}" carrierCode="${flight.carrierCode}" onclick="bookingAjax(this);">预定</a></li>
                    	<li><#if (seat.inventoryCount <= 9)><span style="color:red">剩${seat.inventoryCount}张</span></#if></li>
                    </ul>
                </div>
            	</#list>
            	</#if>
            	</#if>
            	</#list>
            </div>
        </div>
    </div>
    
    
<!-- 往返 -->
    <div class="flighttab">
        <div class="combination mt10">
            <a href="#">自由搭配</a>
        </div>
        <!-- 修改航班 -->
        <#if bookingFirstDto??>
        <form id="cancelSelected" action="search" method="post">
        	<#if bookingFirstDto.tripType == 'RETURN'>
        	<input type="hidden" name="departCity" value="${bookingFirstDto.arriveCity}"/>
        	<input type="hidden" name="arriveCity" value="${bookingFirstDto.departCity}"/>
        	<input type="hidden" name="departDate" value="${bookingFirstDto.arriveDate}"/>
        	<input type="hidden" name="arriveDate" value="${bookingFirstDto.departedDate}"/>
        	<#else>
        	<input type="hidden" name="departCity" value="${bookingFirstDto.departCity}"/>
        	<input type="hidden" name="arriveCity" value="${bookingFirstDto.arriveCity}"/>
        	<input type="hidden" name="departDate" value="${bookingFirstDto.departedDate}"/>
        	<input type="hidden" name="arriveDate" value="${bookingFirstDto.arriveDate}"/>
        	</#if>
        	<input type="hidden" name="vstOrderId" value="${objSear.vstOrderId}"/>
        	<input type="hidden" name="vstOrderMainId" value="${objSear.vstOrderMainId}"/>
        	<input type="hidden" name="doWay" value="${objSear.doWay}"/>
        	<input type="hidden" name="cancelSelected" value="true" />
        </form>
        <div id="modifyFlight" class="bookline mt10" style="display:none;height:150px;">
            <h3>
                <span class="fl ml10"><#if bookingFirstDto.tripType == 'RETURN'>回程<#else>去程</#if>：${bookingFirstDto.departCity}-${bookingFirstDto.arriveCity}</span>
                <a href="#" class="fr mr10 mobily_flight">修改航班</a>
            </h3>
            <div class="airmsg02">
                <ul style="background:#F6F6F6;height:100px;">
                    <li class="w18 position_r">
                        <img src="${request.contextPath}/images/order/airlogo1.png" />
                        <span class="ml1">${bookingFirstDto.carrierName} ${bookingFirstDto.flightNo}</span>
                        <span class="gray02 style_p">
                            计划机型&nbsp;<i class="blue tankuang_hover">${bookingFirstDto.flightCode}</i>
                        </span>
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
                                                <td>${(bookingFirstDto.airplaneModel.code)!''}</td>
						                        <td>${(bookingFirstDto.airplaneModel.name)!''}${(bookingFirstDto.airplaneModel.code)!''}</td>
						                        <td>${(bookingFirstDto.airplaneModel.airplaneType)!''}</td>
						                        <td>${(bookingFirstDto.airplaneModel.minSeats)!''}</td>
						                        <td>${(bookingFirstDto.airplaneModel.maxSeats)!''}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                    </li>
                    <li class="w27 tc">
                        <span class="ml35">
                            ${bookingFirstDto.departTime}&nbsp;—<br /><i class="gray02">${bookingFirstDto.departureAirportName}${bookingFirstDto.departureTermainalBuilding}</i>
                        </span>
                        <span class="red ml3 mr3"><#if (bookingFirstDto.stopCount>0)>经停<#else>不经停</#if></span>
                        <span>
                            &nbsp;—&nbsp;${bookingFirstDto.arriveTime} ${bookingFirstDto.crossDay}<br /><i class="gray02">${bookingFirstDto.arrivalAirportName}${bookingFirstDto.arrivalTerminalBuilding}</i>
                        </span>
                    </li>
                     <li class="w18 w10 blue ml1 tl return_hover_history" carrierCode='${bookingFirstDto.carrierCode}' departAirportCode='${bookingFirstDto.departAirportCode}' 
                        	arriveAirportCode='${bookingFirstDto.arriveAirportCode}' parPrice='${bookingFirstDto.parPrice}' policyId='${bookingFirstDto.policyId}' seatClassCode='${bookingFirstDto.seatClassCode}' pricePolicyId='${bookingFirstDto.pricePolicyId}'
                        >
                          <span class="cangwei ml10">
                            ${bookingFirstDto.seatClassName}${bookingFirstDto.seatClassCode}<br /><i class="blue">退改签说明</i>
                          </span>
                             <div class="endorse_detail_list"></div>
                        </li>
                    <li class="w10">
                        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&yen;${bookingFirstDto.parPrice}</span>
                        <span class="gray02">&nbsp;&nbsp;&nbsp;税：&yen;${bookingFirstDto.airportFee}-&yen;${bookingFirstDto.fuelsurTax}</span>
                    </li>
                    <li class="w10"><i class="gray02"></i>&nbsp;</li>
                    <li class="w16" style="padding-left:100px;"><i class="orange f24 fb">&yen;${bookingFirstDto.salePrice}</i>(含税费)</li>
                </ul>
            </div>
        </div>
        </#if>
        <!-- 自由搭配、往返组合的内容 -->
        <!-- 自由搭配 -->
        <div class="combination_tab">
            <!-- 具体航班信息 -->
            <div class="f16 fb mt10">选择航班:<span>${objSear.departCity}</span> > <span>${objSear.arriveCity} </span><span>( ${departDate} ${week} )</span></div>          
            <!--日期选择-->
            <div class="datebox mt10">
                <div class="datecontent">
                    <div class="li_free">
                        <button class="prv"><span></span></button>
                        <div class="datelist">
                            <div class="free_tab">
                                <ul>

		                   	<#list flightMinPriceForms as flightMinPrice>
		                   	<#if flightMinPrice_index=0> 
		                    <li id="${flightMinPrice.seq}_2" class="active">
		                      <a href="javascript:void(0)" onclick="minPriceClick(${flightMinPrice.seq})">
		                             <p>${flightMinPrice.day} ${flightMinPrice.week}</p>
		                             <p><i>&yen;</i><span>${flightMinPrice.minPrice}</span></p>
		                      </a>
		                      <form id="${flightMinPrice.seq}_1" action="search" method="post">
		                      	<input type="hidden" name="minPriceDate" value="${flightMinPrice.deptDate}"/>
		                      	<input type="hidden" name="departCity" value="${objSear.departCity}"/>
		                      	<input type="hidden" name="arriveCity" value="${objSear.arriveCity}"/>
		                      	<input type="hidden" name="doWay" value="${objSear.doWay}"/>
		                      </form>
		                    </li>
		                    </#if>
		                    <#if (flightMinPrice_index<31) && (0<flightMinPrice_index)>
		                    <li id="${flightMinPrice.seq}_2">
		                      <a href="javascript:void(0)" onclick="minPriceClickWO(${flightMinPrice.seq})">
		                             <p>${flightMinPrice.day} ${flightMinPrice.week}</p>
		                             <p><i>&yen;</i><span>${flightMinPrice.minPrice}</span></p>
		                      </a>
		                      <form id="${flightMinPrice.seq}_1" action="search" method="post">
		                      	<input type="hidden" name="minPriceDate" value="${flightMinPrice.deptDate}"/>
		                      	<input type="hidden" name="departCity" value="${objSear.departCity}"/>
		                      	<input type="hidden" name="arriveCity" value="${objSear.arriveCity}"/>
		                      	<input type="hidden" name="doWay" value="${objSear.doWay}"/>
		                      </form>
		                    </li>
		                    </#if>
		                    </#list>
		                    
		                  </ul>
                            </div>
                        </div>
                        <button class="next"><span></span></button> 
                    </div>
                </div>

                <div class="date-rili" onclick="minPriceDate();">
                    <a href="#"><img src="${request.contextPath}/images/order/rili0306.png" /></a>
                    <span class="">查看30天<br />最低价</span>
                </div>
            </div>
            <div class="t_content">
                <div class="content">
                    <div class="shaixuan01">
                      <span class="fl">筛选条件：</span>
                      <select id="departTimeSegShuffle" name="select" onchange="departSeg();">
	                    <#list departureTimeSegment as departTime>
	                    <#list departTime?keys as itemKey>
						<#if departTime_index=0>
							<option selected value="${itemKey}">${departTime[itemKey]}</option>
						<#else>
							<option value="${itemKey}">${departTime[itemKey]}</option>
						</#if>
						</#list>
						</#list>
	                  </select>
	                  <select id="arriveTimeSegShuffle" name="select" onchange="departSeg();">
	                    <#list arrivalTimeSegment as arrivalTime>
	                    <#list arrivalTime?keys as itemKey>
						<#if arrivalTime_index=0>
							<option selected value="${itemKey}">${arrivalTime[itemKey]}</option>
						<#else>
							<option value="${itemKey}">${arrivalTime[itemKey]}</option>
						</#if>
						</#list>
						</#list>
	                  </select>
	                  <select id="carrierCodeShuffle" name="select" onchange="departSeg();">
	                    <#list carrierCode as code>
	                    <#list code?keys as itemKey>
						<#if code_index=0>
							<option selected value="${itemKey}">${code[itemKey]}</option>
						<#else>
							<option value="${itemKey}">${code[itemKey]}</option>
						</#if>
						</#list>
						</#list>
	                  </select>
	                  <select id="seatBandShuffle" name="select" onchange="departSeg();">
	                    <#list seatClasss as seatClass>
	                    <#list seatClass?keys as itemKey>
						<#if seatClass_index=0>
							<option selected value="${itemKey}">${seatClass[itemKey]}</option>
						<#else>
							<option value="${itemKey}">${seatClass[itemKey]}</option>
						</#if>
						</#list>
						</#list>
	                  </select>
                       <div class="fl"><input type="checkbox" name="toRedeem" id="isHaveMealShuffle" onclick="departSeg();"/>&nbsp;<label for="to_redeem">餐食</label>&nbsp;&nbsp;</div>
                       <div class="fl"><input type="checkbox" name="toRedeem" id="isDirectShuffle" onclick="departSeg();"/>&nbsp;<label for="to_redeem">直飞</label>&nbsp;&nbsp;</div>
                    </div>
                    <div id="doWayDouble" class="shaixuan02">
                      <span class="fl">您已选择：</span>
                      <#list filterRecords as filterRecord>
                      <p>${filterRecord}<i>&times;</i></p>
                      </#list>
                      <a href="#" id="clear_c">清除所有条件</a>
                    </div>
                    <div class="airmsg mt10">
                        <ul>
                            <li class="w18 ml2">航班信息</li>
                            <li class="w27 tc"><a href="javascript:void(0);" onclick="arriveTimeSort();">起抵时间<span><font ><#if objSear.sortByDepartureTimeDate == 'DESC'>▼<#else>▲</#if></font></span></a>
                            <li class="w10"><a href="javascript:void(0);" onclick="flyTimeSort();">飞行时长<span><font><#if objSear.sortByFlyTimeHours == 'DESC'>▼<#else>▲</#if></font></span></a></li>
                            <li class="w6">餐食</li>
                            <li class="w10"><a href="javascript:void(0);" onclick="parpriceSort();">票面价<span><font><#if objSear.sortByParPrice == 'DESC'>▼<#else>▲</#if></font></span></a></li>
                            <li class="w8">佣金</li>
                            <li class="w10"><a href="javascript:void(0);" onclick="salePriceSort();">销售价（含税）<span><font><#if objSear.sortBySettlePrice == 'DESC'>▼<#else>▲</#if></font></span></a></li>
                        </ul>
                    </div>
                    
                    <#list flights as flight>
                    <#if (flight.sortedSeats?size >=3)>
                    <div class="bor_orange">
						<div id="${flight.flightNo}_rt">
                        <div class="airmsg02">
                            <ul>
                                <li class="w18 position_r"><img src="${request.contextPath}/images/order/airlogo1.png" /><span class="ml1">${flight.carrierName} ${flight.flightNo}</span><span class="gray02 style_p">计划机型&nbsp;<i class="blue tankuang_hover">${flight.airplaneModel.code}</i></span>
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
                                                        <td >${flight.airplaneModel.code}</td>
        						                        <td>${flight.airplaneModel.name}${flight.airplaneModel.code}</td>
        						                        <td>${flight.airplaneModel.airplaneType}</td>
        						                        <td>${flight.airplaneModel.minSeats}</td>
        						                        <td>${flight.airplaneModel.maxSeats}</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                </li>
                                <li class="w27 tc">
                                    <span class="ml35">${flight.departureTime}—<br /><i class="gray02">${flight.departureAirportName}${flight.departureTermainalBuilding}</i></span>
                                    <span class="red ml3 mr3"><#if (flight.stopCount>0)>经停<#else>不经停</#if></span>
                                    <span>—${flight.arrivalTime} ${flight.crossDay}<br /><i class="gray02">${flight.arrivalAirportName}${flight.arrivalTerminalBuilding}</i></span>
                                </li>
                                <li class="w10">${flight.flyTime}</li>
                                <li class="w6">${flight.mealType}</li>
                                <li class="w10"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&yen;${flight.flightMinParPrice}起</span><span class="gray02">&nbsp;&nbsp;&nbsp;税：&yen;${flight.airportFees}-&yen;${flight.fuelsurTax}</span></li>
                                <li class="w8">&yen;${flight.profitAmount}</li>
                                <li class="w10">&yen;${flight.salePrice}起</li>
                                <li class="w8 bluebut02"></li>
                            </ul>
                        </div>
                        </div>
						
                        <div id="${flight.flightNo}_2">
                        <#list flight.yCFseats as seat>
                        <#if bookingFirstDto??>
                        <form id="${flight.flightNo}${seat.id}${seat.pricePolicyId}_2" action="toBooking.do" method="post">
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].flightNo" value="${bookingFirstDto.flightNo}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].departureDate" value="${bookingFirstDto.departedDate}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].departureAirportCode" value="${bookingFirstDto.departAirportCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].arrivalAirportCode" value="${bookingFirstDto.arriveAirportCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].seatClassCode" value="${bookingFirstDto.seatClassCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].parPrice" value="${bookingFirstDto.parPrice}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].policyId" value="${bookingFirstDto.policyId}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].pricePolicyId" value="${bookingFirstDto.pricePolicyId}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].suppCode" value="${bookingFirstDto.suppCode}"/>
                        
                        <#if bookingFirstDto.tripType == 'RETURN'>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].flightTripType" value="RETURN"/>
                        <#else>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].flightTripType" value="DEPARTURE"/>
                        </#if>
                        
                        <#if bookingFirstDto.tripType == 'RETURN'>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].departureDate" value="${objSear.departDate}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].flightTripType" value="DEPARTURE"/>
                        <#else>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].departureDate" value="${objSear.arriveDate}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].flightTripType" value="RETURN"/>
                        </#if>
                        
                        <input type="hidden" name="routeType" value="RT"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].flightNo" value="${flight.flightNo}"/>
                        
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].departureAirportCode" value="${flight.departureAirportCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].arrivalAirportCode" value="${flight.arrivalAirportCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].seatClassCode" value="${seat.seatClassCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].parPrice" value="${seat.parPrice}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].policyId" value="${seat.policyId}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].pricePolicyId" value="${seat.pricePolicyId}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].suppCode" value="${seat.suppCode}"/>
                        
                        <input type="hidden" name="userId" value="${objSear.userId}"/>
        	            <input type="hidden" name="userName" value="${objSear.userName}"/>
        	            <input type="hidden" name="grade" value="${objSear.grade}"/>
                        <#else>
                        
                        <form id="${flight.flightNo}${seat.id}${seat.pricePolicyId}_2" action="search" method="post">
                        <input type="hidden" name="bookingFirstDto.flightNo" value="${flight.flightNo}"/>
                        <input type="hidden" name="bookingFirstDto.departedDate" value="${objSear.departDate}"/>
                        <input type="hidden" name="bookingFirstDto.arriveDate" value="${objSear.arriveDate}"/>
                        <input type="hidden" name="bookingFirstDto.departAirportCode" value="${flight.departureAirportCode}"/>
                        <input type="hidden" name="bookingFirstDto.arriveAirportCode" value="${flight.arrivalAirportCode}"/>
                        <input type="hidden" name="bookingFirstDto.parPrice" value="${seat.parPrice}"/>
                        <input type="hidden" name="bookingFirstDto.policyId" value="${seat.policyId}"/>
                        <input type="hidden" name="bookingFirstDto.pricePolicyId" value="${seat.pricePolicyId}"/>
                        <input type="hidden" name="bookingFirstDto.suppCode" value="${seat.suppCode}"/>
                        <input type="hidden" name="bookingFirstDto.carrierCode" value="${flight.carrierCode}"/>
                        <input type="hidden" name="bookingFirstDto.carrierName" value="${flight.carrierName}"/>
                        <input type="hidden" name="bookingFirstDto.departureAirportName" value="${flight.departureAirportName}"/>
                        <input type="hidden" name="bookingFirstDto.arrivalAirportName" value="${flight.arrivalAirportName}"/>
                        <input type="hidden" name="bookingFirstDto.departureTermainalBuilding" value="${flight.departureTermainalBuilding}"/>
                        <input type="hidden" name="bookingFirstDto.arrivalTerminalBuilding" value="${flight.arrivalTerminalBuilding}"/>
                        <input type="hidden" name="bookingFirstDto.stopCount" value="${flight.stopCount}"/>
                        <input type="hidden" name="bookingFirstDto.stopCity" value="${flight.stopCity}"/>
                        <input type="hidden" name="bookingFirstDto.flightCode" value="${flight.airplaneModel.code}"/>
                        <input type="hidden" name="bookingFirstDto.seatClassName" value="${seat.seatClassName}"/>
                        <input type="hidden" name="bookingFirstDto.seatClassCode" value="${seat.seatClassCode}"/>
                        <input type="hidden" name="bookingFirstDto.departTime" value="${flight.departureTime}"/>
                        <input type="hidden" name="bookingFirstDto.arriveTime" value="${flight.arrivalTime}"/>
                        <input type="hidden" name="bookingFirstDto.seatClassDesc" value="${seat.seatClassDesc}"/>
                        <input type="hidden" name="bookingFirstDto.departCity" value="${objSear.departCity}"/>
                        <input type="hidden" name="bookingFirstDto.arriveCity" value="${objSear.arriveCity}"/>
                        <input type="hidden" name="bookingFirstDto.airportFee" value="${flight.airportFees}"/>
                        <input type="hidden" name="bookingFirstDto.fuelsurTax" value="${flight.fuelsurTax}"/>
                        <input type="hidden" name="bookingFirstDto.salePrice" value="${seat.salePrice}"/>
                        <input type="hidden" name="departCity" value="${objSear.arriveCity}"/>
                        <input type="hidden" name="arriveCity" value="${objSear.departCity}"/>
                        <input type="hidden" name="arriveDate" value="${objSear.departDate}"/>
                        <input type="hidden" name="departDate" value="${objSear.arriveDate}"/>
                        <input type="hidden" name="bookingFirstDto.airplaneModel.code" value="${flight.airplaneModel.code}"/>
                        <input type="hidden" name="bookingFirstDto.airplaneModel.name" value="${flight.airplaneModel.name}"/>
                        <input type="hidden" name="bookingFirstDto.airplaneModel.airplaneType" value="${flight.airplaneModel.airplaneType}"/>
                        <input type="hidden" name="bookingFirstDto.airplaneModel.minSeats" value="${flight.airplaneModel.minSeats}"/>
                        <input type="hidden" name="bookingFirstDto.airplaneModel.maxSeats" value="${flight.airplaneModel.maxSeats}"/>
                        <input type="hidden" id="${flight.flightNo}${seat.id}${seat.pricePolicyId}_3" name="doWay" />
                        </#if>
                        </form>
                        
                        <div class="airmsg03" id="${flight.flightNo}_${seat_index}${seat.pricePolicyId}_2">
                            <ul>
                                <li class="w18">&nbsp;&nbsp;&nbsp;&nbsp;${seat.seatClassTypeName}</li>
                                <li class="w16 tr">${seat.seatClassName}${seat.seatClassCode}</li>
                                <li class="w10 blue ml1 tl return_hover" carrierCode='${flight.carrierCode}' departAirportCode='${flight.departureAirportCode}' 
                                	arriveAirportCode='${flight.arrivalAirportCode}' parPrice='${seat.parPrice}' policyId='${seat.policyId}' seatClassCode='${seat.seatClassCode}' pricePolicyId='${seat.pricePolicyId}'
                                >
                                	退改签说明
                                	<div class="endorse_detail"></div>
                                </li>
                                <li class="w10" style="white-space:nowrap">[${seat.suppPolicyId}][${seat.suppCode}]</li>
                                <li class="w6">&nbsp;</li>
                                <li class="w10 orange tc">&yen;${seat.parPrice}</li>
                                <li class="w8 tc">&yen;${seat.profitAmount}</li>
                                <li class="w10 tc"><span class="mt10">&yen;${seat.salePrice}</span><span class="gray">已优惠：&yen;${seat.promotion}</span></li>
                                <li class="w8 orangebut tc"><a href="javascript:void(0);" class="bookbut" flightNo="${flight.flightNo}" seatId="${seat.id}" departAirportCode="${flight.departureAirportCode}" 
                                	arriveAirportCode="${flight.arrivalAirportCode}" parPrice="${seat.parPrice}" policyId="${seat.policyId}" pricePolicyId="${seat.pricePolicyId}" seatClassCode="${seat.seatClassCode}" <#if bookingFirstDto?? && bookingFirstDto.tripType != 'RETURN'>departDate="${objSear.arriveDate}"<#else>departDate="${objSear.departDate}"</#if> carrierCode="${flight.carrierCode}" onclick="bookingAjax(this);">预定</a></li>
                            	<li><#if (seat.inventoryCount <= 9)><span style="color:red">剩${seat.inventoryCount}张</span></#if></li>
                            </ul>
                        </div>
                        </#list>
        				</div>
        				<div id="extend_content_${flight.flightNo}_2" style="display:none">
                        
                        <#list flight.sortedSeats as seat>
                        <#if bookingFirstDto??>
                        <form id="${flight.flightNo}${seat.id}${seat.pricePolicyId}_2" action="toBooking.do" method="post">
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].flightNo" value="${bookingFirstDto.flightNo}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].departureDate" value="${bookingFirstDto.departedDate}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].departureAirportCode" value="${bookingFirstDto.departAirportCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].arrivalAirportCode" value="${bookingFirstDto.arriveAirportCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].seatClassCode" value="${bookingFirstDto.seatClassCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].parPrice" value="${bookingFirstDto.parPrice}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].policyId" value="${bookingFirstDto.policyId}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].pricePolicyId" value="${bookingFirstDto.pricePolicyId}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].suppCode" value="${bookingFirstDto.suppCode}"/>
                        
                        <#if bookingFirstDto.tripType == 'RETURN'>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].flightTripType" value="RETURN"/>
                        <#else>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].flightTripType" value="DEPARTURE"/>
                        </#if>
                        
                        <#if bookingFirstDto.tripType == 'RETURN'>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].departureDate" value="${objSear.departDate}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].flightTripType" value="DEPARTURE"/>
                        <#else>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].departureDate" value="${objSear.arriveDate}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].flightTripType" value="RETURN"/>
                        </#if>
                        
                        <input type="hidden" name="routeType" value="RT"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].flightNo" value="${flight.flightNo}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].departureAirportCode" value="${flight.departureAirportCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].arrivalAirportCode" value="${flight.arrivalAirportCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].seatClassCode" value="${seat.seatClassCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].parPrice" value="${seat.parPrice}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].policyId" value="${seat.policyId}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].pricePolicyId" value="${seat.pricePolicyId}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].suppCode" value="${seat.suppCode}"/>
                        <input type="hidden" name="userId" value="${objSear.userId}"/>
        	            <input type="hidden" name="userName" value="${objSear.userName}"/>
        	            <input type="hidden" name="grade" value="${objSear.grade}"/>
                        <#else>
                        
                        <form id="${flight.flightNo}${seat.id}${seat.pricePolicyId}_2" action="search" method="post">
                        <input type="hidden" name="bookingFirstDto.flightNo" value="${flight.flightNo}"/>
                        <input type="hidden" name="bookingFirstDto.departedDate" value="${objSear.departDate}"/>
                        <input type="hidden" name="bookingFirstDto.arriveDate" value="${objSear.arriveDate}"/>
                        <input type="hidden" name="bookingFirstDto.departAirportCode" value="${flight.departureAirportCode}"/>
                        <input type="hidden" name="bookingFirstDto.arriveAirportCode" value="${flight.arrivalAirportCode}"/>
                        <input type="hidden" name="bookingFirstDto.parPrice" value="${seat.parPrice}"/>
                        <input type="hidden" name="bookingFirstDto.policyId" value="${seat.policyId}"/>
                        <input type="hidden" name="bookingFirstDto.pricePolicyId" value="${seat.pricePolicyId}"/>
                        <input type="hidden" name="bookingFirstDto.suppCode" value="${seat.suppCode}"/>
                        <input type="hidden" name="bookingFirstDto.carrierCode" value="${flight.carrierCode}"/>
                        <input type="hidden" name="bookingFirstDto.carrierName" value="${flight.carrierName}"/>
                        <input type="hidden" name="bookingFirstDto.departureAirportName" value="${flight.departureAirportName}"/>
                        <input type="hidden" name="bookingFirstDto.arrivalAirportName" value="${flight.arrivalAirportName}"/>
                        <input type="hidden" name="bookingFirstDto.departureTermainalBuilding" value="${flight.departureTermainalBuilding}"/>
                        <input type="hidden" name="bookingFirstDto.arrivalTerminalBuilding" value="${flight.arrivalTerminalBuilding}"/>
                        <input type="hidden" name="bookingFirstDto.stopCount" value="${flight.stopCount}"/>
                        <input type="hidden" name="bookingFirstDto.stopCity" value="${flight.stopCity}"/>
                        <input type="hidden" name="bookingFirstDto.flightCode" value="${flight.airplaneModel.code}"/>
                        <input type="hidden" name="bookingFirstDto.seatClassName" value="${seat.seatClassName}"/>
                        <input type="hidden" name="bookingFirstDto.seatClassCode" value="${seat.seatClassCode}"/>
                        <input type="hidden" name="bookingFirstDto.departTime" value="${flight.departureTime}"/>
                        <input type="hidden" name="bookingFirstDto.arriveTime" value="${flight.arrivalTime}"/>
                        <input type="hidden" name="bookingFirstDto.seatClassDesc" value="${seat.seatClassDesc}"/>
                        <input type="hidden" name="bookingFirstDto.departCity" value="${objSear.departCity}"/>
                        <input type="hidden" name="bookingFirstDto.arriveCity" value="${objSear.arriveCity}"/>
                        <input type="hidden" name="bookingFirstDto.airportFee" value="${flight.airportFees}"/>
                        <input type="hidden" name="bookingFirstDto.fuelsurTax" value="${flight.fuelsurTax}"/>
                        <input type="hidden" name="bookingFirstDto.salePrice" value="${seat.salePrice}"/>
                        <input type="hidden" name="departCity" value="${objSear.arriveCity}"/>
                        <input type="hidden" name="arriveCity" value="${objSear.departCity}"/>
                        <input type="hidden" name="arriveDate" value="${objSear.departDate}"/>
                        <input type="hidden" name="departDate" value="${objSear.arriveDate}"/>
                        <input type="hidden" name="bookingFirstDto.airplaneModel.code" value="${flight.airplaneModel.code}"/>
                        <input type="hidden" name="bookingFirstDto.airplaneModel.name" value="${flight.airplaneModel.name}"/>
                        <input type="hidden" name="bookingFirstDto.airplaneModel.airplaneType" value="${flight.airplaneModel.airplaneType}"/>
                        <input type="hidden" name="bookingFirstDto.airplaneModel.minSeats" value="${flight.airplaneModel.minSeats}"/>
                        <input type="hidden" name="bookingFirstDto.airplaneModel.maxSeats" value="${flight.airplaneModel.maxSeats}"/>
                        <input type="hidden" id="${flight.flightNo}${seat.id}${seat.pricePolicyId}_3" name="doWay" />
                        </#if>
                        </form>
                        <div class="airmsg03">
                            <ul>
                                <li class="w18">&nbsp;&nbsp;&nbsp;&nbsp;${seat.seatClassTypeName}</li>
                                <li class="w16 tr">${seat.seatClassName}${seat.seatClassCode}</li>
                                <li class="w10 blue ml1 tl return_hover" carrierCode='${flight.carrierCode}' departAirportCode='${flight.departureAirportCode}' 
                            	arriveAirportCode='${flight.arrivalAirportCode}' parPrice='${seat.parPrice}' policyId='${seat.policyId}' seatClassCode='${seat.seatClassCode}' pricePolicyId='${seat.pricePolicyId}'
                                >
                                	退改签说明
                                	<div class="endorse_detail"></div>
                                </li>
                                <li class="w10" style="white-space:nowrap">[${seat.suppPolicyId}][${seat.suppCode}]</li>
                                <li class="w6">&nbsp;</li>
                                <li class="w10 orange tc">&yen;${seat.parPrice}</li>
                                <li class="w8 tc">&yen;${seat.profitAmount}</li>
                                <li class="w10 tc"><span class="mt10">&yen;${seat.salePrice}</span><span class="gray">已优惠：&yen;${seat.promotion}</span></li>
                                <li class="w8 orangebut tc"><a href="javascript:void(0);" class="bookbut" flightNo="${flight.flightNo}" seatId="${seat.id}" departAirportCode="${flight.departureAirportCode}" 
                            	arriveAirportCode="${flight.arrivalAirportCode}" parPrice="${seat.parPrice}" policyId="${seat.policyId}" pricePolicyId="${seat.pricePolicyId}" seatClassCode="${seat.seatClassCode}" <#if bookingFirstDto??  && bookingFirstDto.tripType != 'RETURN'>departDate="${objSear.arriveDate}"<#else>departDate="${objSear.departDate}"</#if> carrierCode="${flight.carrierCode}" onclick="bookingAjax(this);">预定</a></li>
                            	<li><#if (seat.inventoryCount <= 9)><span style="color:red">剩${seat.inventoryCount}张</span></#if></li>
                            </ul>
                        </div>
                        
                        
                        </#list>
        				
        				</div>
                        <div class="more_e"><a href="#" class="extend" data="${flight.flightNo}"><span>展开所有</span><i>&nbsp;</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div>
                        </div>

                        
                        <#else>
						<div id="${flight.flightNo}_rt">
                    	<div class="airmsg02">
                            <ul >
                            <li class="w18 position_r"><img src="${request.contextPath}/images/order/airlogo1.png" /><span class="ml1">${flight.carrierName} ${flight.flightNo}</span><span class="gray02 style_p">计划机型&nbsp;<i class="blue tankuang_hover">${flight.airplaneModel.code}</i></span>
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
                                                <td >${flight.airplaneModel.code}</td>
						                        <td>${flight.airplaneModel.name}${flight.airplaneModel.code}</td>
						                        <td>${flight.airplaneModel.airplaneType}</td>
						                        <td>${flight.airplaneModel.minSeats}</td>
						                        <td>${flight.airplaneModel.maxSeats}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                        </li>
                                <li class="w27 tc">
                                    <span class="ml35">${flight.departureTime}—<br /><i class="gray02">${flight.departureAirportName}${flight.departureTermainalBuilding}</i></span>
                                    <span class="red ml3 mr3"><#if (flight.stopCount>0)>经停<#else>不经停</#if></span>
                                    <span>—${flight.arrivalTime} ${flight.crossDay}<br /><i class="gray02">${flight.arrivalAirportName}${flight.arrivalTerminalBuilding}</i></span>
                                </li>
                                <li class="w10">${flight.flyTime}</li>
                                <li class="w6">${flight.mealType}</li>
                                <li class="w10"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&yen;${flight.flightMinParPrice}起</span><span class="gray02">&nbsp;&nbsp;&nbsp;税：&yen;${flight.airportFees}-&yen;${flight.fuelsurTax}</span></li>
                                <li class="w8">&yen;${flight.profitAmount}</li>
                                <li class="w10">&yen;${flight.salePrice}起</li>
                                <li class="w8 bluebut02"></li>
                            </ul>
                        </div>
                        </div>
                        <#if flight.yCFseats ?exists> 
                        <#list flight.yCFseats as seat>
                        
                        <#if bookingFirstDto??>
                        <form id="${flight.flightNo}${seat.id}${seat.pricePolicyId}_2" action="toBooking.do" method="post">
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].flightNo" value="${bookingFirstDto.flightNo}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].departureDate" value="${bookingFirstDto.departedDate}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].departureAirportCode" value="${bookingFirstDto.departAirportCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].arrivalAirportCode" value="${bookingFirstDto.arriveAirportCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].seatClassCode" value="${bookingFirstDto.seatClassCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].parPrice" value="${bookingFirstDto.parPrice}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].policyId" value="${bookingFirstDto.policyId}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].pricePolicyId" value="${bookingFirstDto.pricePolicyId}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].suppCode" value="${bookingFirstDto.suppCode}"/>
                        
                        <#if bookingFirstDto.tripType == 'RETURN'>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].flightTripType" value="RETURN"/>
                        <#else>
                        <input type="hidden" name="flightOrderBookingDetailRequests[0].flightTripType" value="DEPARTURE"/>
                        </#if>
                        
                        <#if bookingFirstDto.tripType == 'RETURN'>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].departureDate" value="${objSear.departDate}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].flightTripType" value="DEPARTURE"/>
                        <#else>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].departureDate" value="${objSear.arriveDate}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].flightTripType" value="RETURN"/>
                        </#if>
                        
                        <input type="hidden" name="routeType" value="RT"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].flightNo" value="${flight.flightNo}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].departureAirportCode" value="${flight.departureAirportCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].arrivalAirportCode" value="${flight.arrivalAirportCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].seatClassCode" value="${seat.seatClassCode}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].parPrice" value="${seat.parPrice}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].policyId" value="${seat.policyId}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].pricePolicyId" value="${seat.pricePolicyId}"/>
                        <input type="hidden" name="flightOrderBookingDetailRequests[1].suppCode" value="${seat.suppCode}"/>
                        <input type="hidden" name="userId" value="${objSear.userId}"/>
        	            <input type="hidden" name="userName" value="${objSear.userName}"/>
        	            <input type="hidden" name="grade" value="${objSear.grade}"/>
                        <#else>
                        
                        <form id="${flight.flightNo}${seat.id}${seat.pricePolicyId}_2" action="search" method="post">
                        <input type="hidden" name="bookingFirstDto.flightNo" value="${flight.flightNo}"/>
                        <input type="hidden" name="bookingFirstDto.departedDate" value="${objSear.departDate}"/>
                        <input type="hidden" name="bookingFirstDto.arriveDate" value="${objSear.arriveDate}"/>
                        <input type="hidden" name="bookingFirstDto.departAirportCode" value="${flight.departureAirportCode}"/>
                        <input type="hidden" name="bookingFirstDto.arriveAirportCode" value="${flight.arrivalAirportCode}"/>
                        <input type="hidden" name="bookingFirstDto.parPrice" value="${seat.parPrice}"/>
                        <input type="hidden" name="bookingFirstDto.policyId" value="${seat.policyId}"/>
                        <input type="hidden" name="bookingFirstDto.pricePolicyId" value="${seat.pricePolicyId}"/>
                        <input type="hidden" name="bookingFirstDto.suppCode" value="${seat.suppCode}"/>
                        <input type="hidden" name="bookingFirstDto.departureTermainalBuilding" value="${flight.departureTermainalBuilding}"/>
                        <input type="hidden" name="bookingFirstDto.arrivalTerminalBuilding" value="${flight.arrivalTerminalBuilding}"/>
                        <input type="hidden" name="bookingFirstDto.carrierCode" value="${flight.carrierCode}"/>
                        <input type="hidden" name="bookingFirstDto.carrierName" value="${flight.carrierName}"/>
                        <input type="hidden" name="bookingFirstDto.departureAirportName" value="${flight.departureAirportName}"/>
                        <input type="hidden" name="bookingFirstDto.arrivalAirportName" value="${flight.arrivalAirportName}"/>
                        <input type="hidden" name="bookingFirstDto.stopCount" value="${flight.stopCount}"/>
                        <input type="hidden" name="bookingFirstDto.stopCity" value="${flight.stopCity}"/>
                        <input type="hidden" name="bookingFirstDto.flightCode" value="${flight.airplaneModel.code}"/>
                        <input type="hidden" name="bookingFirstDto.seatClassName" value="${seat.seatClassName}"/>
                        <input type="hidden" name="bookingFirstDto.seatClassCode" value="${seat.seatClassCode}"/>
                        <input type="hidden" name="bookingFirstDto.departTime" value="${flight.departureTime}"/>
                        <input type="hidden" name="bookingFirstDto.arriveTime" value="${flight.arrivalTime}"/>
                        <input type="hidden" name="bookingFirstDto.seatClassDesc" value="${seat.seatClassDesc}"/>
                        <input type="hidden" name="bookingFirstDto.departCity" value="${objSear.departCity}"/>
                        <input type="hidden" name="bookingFirstDto.arriveCity" value="${objSear.arriveCity}"/>
                        <input type="hidden" name="bookingFirstDto.airportFee" value="${flight.airportFees}"/>
                        <input type="hidden" name="bookingFirstDto.fuelsurTax" value="${flight.fuelsurTax}"/>
                        <input type="hidden" name="bookingFirstDto.salePrice" value="${seat.salePrice}"/>
                        <input type="hidden" name="departCity" value="${objSear.arriveCity}"/>
                        <input type="hidden" name="arriveCity" value="${objSear.departCity}"/>
                        <input type="hidden" name="arriveDate" value="${objSear.departDate}"/>
                        <input type="hidden" name="departDate" value="${objSear.arriveDate}"/>
                         <input type="hidden" name="bookingFirstDto.airplaneModel.code" value="${flight.airplaneModel.code}"/>
                        <input type="hidden" name="bookingFirstDto.airplaneModel.name" value="${flight.airplaneModel.name}"/>
                        <input type="hidden" name="bookingFirstDto.airplaneModel.airplaneType" value="${flight.airplaneModel.airplaneType}"/>
                        <input type="hidden" name="bookingFirstDto.airplaneModel.minSeats" value="${flight.airplaneModel.minSeats}"/>
                        <input type="hidden" name="bookingFirstDto.airplaneModel.maxSeats" value="${flight.airplaneModel.maxSeats}"/>
                        <input type="hidden" id="${flight.flightNo}${seat.id}${seat.pricePolicyId}_3" name="doWay" />
                        
                        </#if>
                        </form>
                        
                        <div class="airmsg03">
                            <ul>
                                <li class="w18">&nbsp;&nbsp;&nbsp;&nbsp;${seat.seatClassTypeName}</li>
                                <li class="w16 tr">${seat.seatClassName}${seat.seatClassCode}</li>
                                <li class="w10 blue ml1 tl return_hover" carrierCode='${flight.carrierCode}' departAirportCode='${flight.departureAirportCode}' 
                                	arriveAirportCode='${flight.arrivalAirportCode}' parPrice='${seat.parPrice}' policyId='${seat.policyId}' seatClassCode='${seat.seatClassCode}' pricePolicyId='${seat.pricePolicyId}'
                                >
                                	退改签说明
                                	<div class="endorse_detail"></div>
                                </li>
                                <li class="w10" style="white-space:nowrap">[${seat.suppPolicyId}][${seat.suppCode}]</li>
                                <li class="w6">&nbsp;</li>
                                <li class="w10 orange tc">&yen;${seat.parPrice}</li>
                                <li class="w8 tc">&yen;${seat.profitAmount}</li>
                                <li class="w10 tc"><span class="mt10">&yen;${seat.salePrice}</span><span class="gray">已优惠：&yen;${seat.promotion}</span></li>
                                <li class="w8 orangebut tc"><a href="javascript:void(0);" class="bookbut" flightNo="${flight.flightNo}" seatId="${seat.id}" departAirportCode="${flight.departureAirportCode}" 
                                	arriveAirportCode="${flight.arrivalAirportCode}" parPrice="${seat.parPrice}" policyId="${seat.policyId}" pricePolicyId="${seat.pricePolicyId}" seatClassCode="${seat.seatClassCode}" <#if bookingFirstDto??  && bookingFirstDto.tripType != 'RETURN'>departDate="${objSear.arriveDate}"<#else>departDate="${objSear.departDate}"</#if> carrierCode="${flight.carrierCode}" onclick="bookingAjax(this);">预定</a></li>
                            	<li><#if (seat.inventoryCount <= 9)><span style="color:red">剩${seat.inventoryCount}张</span></#if></li>
                            </ul>
                        </div>
                        
                    	</#list>
        	            </#if>
        	            </#if>
        	            </#list>
            </div>
        </div>
        </div>
    </div>
    <!-- 城市选择(下拉) -->
    <div style="height:0" class="jsContainer" id="jsContainer"> 
        <div style="display:none;position:absolute;z-index:999;overflow:hidden;" id="tuna_alert">
        </div> 
        <div style="visibility:hidden;position:absolute;z-index:120;" id="tuna_jmpinfo">
        </div> 
        <div style="width: 0px; height: 0px;">
            <div style="display:none;position:absolute;top:0;z-index:120;overflow:hidden;-moz-box-shadow:2px 2px 5px #333;-webkit-box-shadow:2px 2px 5px #333;" id="tuna_address">
                <div id="address_warp">
                    <div id="address_message">
                        &nbsp;
                    </div>
                    <div id="address_list">
                        <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
                        <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
                        <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
                        <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
                        <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
                        <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
                        <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
                        <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
                        <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
                        <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
                        <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
                        <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
                    </div>
                    <div id="address_p" class="address_pagebreak">
                        <a name="p" href="javascript:;" id="address_arrowl">&lt;-</a>
                        <a class="address_current" name="1" href="javascript:;" id="   address_p1"><1>            </1></a>
                        <a name="2" href="javascript:;" id="address_p2">2</a>
                        <a name="3" href="javascript:;" id="address_p3">3</a>
                        <a name="4" href="javascript:;" id="address_p4">4</a>
                        <a name="5" href="javascript:;" id="address_p5">5</a>
                        <a name="n" href="javascript:;" id="address_arrowr">-&gt;</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
     <!-- 日期-价格弹框 -->
    <div class="date_bground">
        <div class="date_tankuang">
            <div class="month_show">
                <div class="date_close" onclick="closeMinPriceWin();">X</div>
                <div class="month_dom_reduce">
                    <div class="minus"><span></span></div>
                    <div class="year"></div>
                    <div class="yue"></div>
                </div>
                <div class="month_dom_add">
                    <div class="plus"><span></span></div>
                    <div class="year"></div>
                    <div class="yue"></div>
                </div>
            </div>
            <div class="date_show">
                <p class="date_title">选择单程低价</p>
                <div class="date_dom">
                    <div class="riqi"><span>SUN 日</span><span>MON 一</span><span>TUE 二</span><span>WED 三</span><span>THU 四</span><span>FRI 五</span><span>SAT 六</span></div>
                </div>
                <div class="datelist">
                    <div class="date_1"></div>
                </div>
            </div>
            <div class="info">因票价变动频繁，请以实时查询报价为准。</div>
        </div>
    </div>
</div>

<div id="bookingFirstDtoDiv">
<#if bookingFirstDto??>
	<input type="hidden" name="bookingFirstDto.departureAirportName" value="${bookingFirstDto.departureAirportName}"/>
	<input type="hidden" name="bookingFirstDto.departureTermainalBuilding" value="${bookingFirstDto.departureTermainalBuilding}"/>
	<input type="hidden" name="bookingFirstDto.stopCount" value="${bookingFirstDto.stopCount}"/>
	<input type="hidden" name="bookingFirstDto.departTime" value="${bookingFirstDto.departTime}"/>
	<input type="hidden" name="bookingFirstDto.arriveTime" value="${bookingFirstDto.arriveTime}"/>
	<input type="hidden" name="bookingFirstDto.crossDay" value="${bookingFirstDto.crossDay}"/>
	<input type="hidden" name="bookingFirstDto.arrivalAirportName" value="${bookingFirstDto.arrivalAirportName}"/>
	<input type="hidden" name="bookingFirstDto.arrivalTerminalBuilding" value="${bookingFirstDto.arrivalTerminalBuilding}"/>
	<input type="hidden" name="bookingFirstDto.carrierCode" value="${bookingFirstDto.carrierCode}"/>
	<input type="hidden" name="bookingFirstDto.departAirportCode" value="${bookingFirstDto.departAirportCode}"/>
	<input type="hidden" name="bookingFirstDto.arriveAirportCode" value="${bookingFirstDto.arriveAirportCode}"/>
	
	<input type="hidden" name="bookingFirstDto.parPrice" value="${bookingFirstDto.parPrice}"/>
	<input type="hidden" name="bookingFirstDto.policyId" value="${bookingFirstDto.policyId}"/>
	<input type="hidden" name="bookingFirstDto.seatClassName" value="${bookingFirstDto.seatClassName}"/>
	<input type="hidden" name="bookingFirstDto.fuelsurTax" value="${bookingFirstDto.fuelsurTax}"/>
	<input type="hidden" name="bookingFirstDto.salePrice" value="${bookingFirstDto.salePrice}"/>
	<input type="hidden" name="bookingFirstDto.airportFee" value="${bookingFirstDto.airportFee}"/>
	
	<input type="hidden" name="bookingFirstDto.departCity" value="${bookingFirstDto.departCity}"/>
	<input type="hidden" name="bookingFirstDto.arriveCity" value="${bookingFirstDto.arriveCity}"/>
	<input type="hidden" name="bookingFirstDto.carrierName" value="${bookingFirstDto.carrierName}"/>
	
	<input type="hidden" name="bookingFirstDto.flightNo" value="${bookingFirstDto.flightNo}"/>
	<input type="hidden" name="bookingFirstDto.flightCode" value="${bookingFirstDto.flightCode}"/>
	<input type="hidden" name="bookingFirstDto.departedDate" value="${bookingFirstDto.departedDate}"/>
	<input type="hidden" name="bookingFirstDto.arriveDate" value="${bookingFirstDto.arriveDate}"/>
	<input type="hidden" name="bookingFirstDto.seatClassCode" value="${bookingFirstDto.seatClassCode}"/>
	<input type="hidden" name="bookingFirstDto.parPrice" value="${bookingFirstDto.parPrice}"/>
	<input type="hidden" name="bookingFirstDto.policyId" value="${bookingFirstDto.policyId}"/>
	<input type="hidden" name="bookingFirstDto.pricePolicyId" value="${bookingFirstDto.pricePolicyId}"/>
	<input type="hidden" name="bookingFirstDto.suppCode" value="${bookingFirstDto.suppCode}"/>
	
	<#if bookingFirstDto.tripType == 'RETURN'>
	<input type="hidden" name="bookingFirstDto.tripType" value="${bookingFirstDto.tripType}"/>
	</#if>
	
	<input type="hidden" name="bookingFirstDto.airplaneModel.code" value="${(bookingFirstDto.airplaneModel.code)}"/>
	<input type="hidden" name="bookingFirstDto.airplaneModel.name" value="${bookingFirstDto.airplaneModel.name}"/>
	<input type="hidden" name="bookingFirstDto.airplaneModel.airplaneType" value="${bookingFirstDto.airplaneModel.airplaneType}"/>
	<input type="hidden" name="bookingFirstDto.airplaneModel.minSeats" value="${bookingFirstDto.airplaneModel.minSeats}"/>
	<input type="hidden" name="bookingFirstDto.airplaneModel.maxSeats" value="${bookingFirstDto.airplaneModel.maxSeats}"/>
</#if>
</div>

<#if bookingFirstDto??>
	<form id="formHideRT" action="search" method="post">
		<input type="hidden" name="bookingFirstDto.departureAirportName" value="${bookingFirstDto.departureAirportName}"/>
		<input type="hidden" name="bookingFirstDto.departureTermainalBuilding" value="${bookingFirstDto.departureTermainalBuilding}"/>
		<input type="hidden" name="bookingFirstDto.stopCount" value="${bookingFirstDto.stopCount}"/>
		<input type="hidden" name="bookingFirstDto.departTime" value="${bookingFirstDto.departTime}"/>
		<input type="hidden" name="bookingFirstDto.arriveTime" value="${bookingFirstDto.arriveTime}"/>
		<input type="hidden" name="bookingFirstDto.crossDay" value="${bookingFirstDto.crossDay}"/>
		<input type="hidden" name="bookingFirstDto.arrivalAirportName" value="${bookingFirstDto.arrivalAirportName}"/>
		<input type="hidden" name="bookingFirstDto.arrivalTerminalBuilding" value="${bookingFirstDto.arrivalTerminalBuilding}"/>
		<input type="hidden" name="bookingFirstDto.carrierCode" value="${bookingFirstDto.carrierCode}"/>
		<input type="hidden" name="bookingFirstDto.departAirportCode" value="${bookingFirstDto.departAirportCode}"/>
		<input type="hidden" name="bookingFirstDto.arriveAirportCode" value="${bookingFirstDto.arriveAirportCode}"/>
		
		<#if bookingFirstDto.tripType == 'RETURN'>
		<input type="hidden" name="bookingFirstDto.tripType" value="${bookingFirstDto.tripType}"/>
		</#if>
		
		<input type="hidden" name="bookingFirstDto.parPrice" value="${bookingFirstDto.parPrice}"/>
		<input type="hidden" name="bookingFirstDto.policyId" value="${bookingFirstDto.policyId}"/>
		<input type="hidden" name="bookingFirstDto.seatClassName" value="${bookingFirstDto.seatClassName}"/>
		<input type="hidden" name="bookingFirstDto.fuelsurTax" value="${bookingFirstDto.fuelsurTax}"/>
		<input type="hidden" name="bookingFirstDto.salePrice" value="${bookingFirstDto.salePrice}"/>
		<input type="hidden" name="bookingFirstDto.airportFee" value="${bookingFirstDto.airportFee}"/>
		
		<input type="hidden" name="bookingFirstDto.departCity" value="${bookingFirstDto.departCity}"/>
		<input type="hidden" name="bookingFirstDto.arriveCity" value="${bookingFirstDto.arriveCity}"/>
		<input type="hidden" name="bookingFirstDto.carrierName" value="${bookingFirstDto.carrierName}"/>
		
		<input type="hidden" name="bookingFirstDto.flightNo" value="${bookingFirstDto.flightNo}"/>
		<input type="hidden" name="bookingFirstDto.flightCode" value="${bookingFirstDto.flightCode}"/>
		<input type="hidden" name="bookingFirstDto.departedDate" value="${bookingFirstDto.departedDate}"/>
		<input type="hidden" name="bookingFirstDto.arriveDate" value="${bookingFirstDto.arriveDate}"/>
		<input type="hidden" name="bookingFirstDto.seatClassCode" value="${bookingFirstDto.seatClassCode}"/>
		<input type="hidden" name="bookingFirstDto.parPrice" value="${bookingFirstDto.parPrice}"/>
		<input type="hidden" name="bookingFirstDto.policyId" value="${bookingFirstDto.policyId}"/>
		<input type="hidden" name="bookingFirstDto.pricePolicyId" value="${bookingFirstDto.pricePolicyId}"/>
		<input type="hidden" name="bookingFirstDto.suppCode" value="${bookingFirstDto.suppCode}"/>
		
		<input type="hidden" name="bookingFirstDto.airplaneModel.code" value="${(bookingFirstDto.airplaneModel.code)}"/>
		<input type="hidden" name="bookingFirstDto.airplaneModel.name" value="${bookingFirstDto.airplaneModel.name}"/>
		<input type="hidden" name="bookingFirstDto.airplaneModel.airplaneType" value="${bookingFirstDto.airplaneModel.airplaneType}"/>
		<input type="hidden" name="bookingFirstDto.airplaneModel.minSeats" value="${bookingFirstDto.airplaneModel.minSeats}"/>
		<input type="hidden" name="bookingFirstDto.airplaneModel.maxSeats" value="${bookingFirstDto.airplaneModel.maxSeats}"/>
	
		<input name="departDate" type="hidden" value="${objSear.arriveDate}"/>
		<input name="arriveDate" type="hidden" value="${objSear.departDate}"/>
		<input name="arriveCity" type="hidden" value="${objSear.arriveCity}"/>
		<input name="departCity" type="hidden" value="${objSear.departCity}"/>
		<input name="doWay" type="hidden" value="2"/>
	</form>
<#else>
	<form id="formHideOW" action="search" method="post">
		<input name="departCity" type="hidden" value="${objSear.departCity}"/>
		<input name="arriveCity" type="hidden" value="${objSear.arriveCity}"/>
		<#if objSear.doWay == 1>
			<input name="doWay" type="hidden" value="1"/>
			<input name="departDate" type="hidden" value="${objSear.departDate}"/>
		<#else>
			<input name="doWay" type="hidden" value="2"/>
			<input name="departDate" type="hidden" value="${objSear.departDate}"/>
			<input name="arriveDate" type="hidden" value="${objSear.arriveDate}"/>
		</#if>
	</form>
</#if>
<#if objSear.doWay == 1>
<a id="anchor_scroll_ow" href="#${objSear.selectedFlightNo}_ow" style="display:none"></a>
</#if>
<#if objSear.doWay ==2>
<a id="anchor_scroll_rt" href="#${objSear.selectedFlightNo}_rt" style="display:none"></a>
</#if>
<script type="text/javascript" src="js/fixdiv.js"></script>
<script type="text/javascript" src="js/address.js"></script>

<script type="text/javascript">
//判断选取用户值是否存在
function validUser(){
	var vstUserName=$.trim($("#userMeberName span").text());
	if(vstUserName=="" || vstUserName==null){
	   alert("会员信息失效，请重新登录选取会员信息！！！");
	   window.location.href="${request.contextPath}/loginUser/newLogin";
	   return false;
	}
}

$(function(){
	validUser();
    // 测试数组mytest
    var mytest=[];
    for (var i = 0; i <= 30; i++) {
        mytest[i] = i+1;
    };
    
    
    
    var minprices = new Array();
	var i=0;
	<#list flightMinPriceForms as priceForm>
		<#if priceForm.minPrice??>
			minprices[i++]='￥${priceForm.minPrice}';
		<#else>
			minprices[i++]='点击查看';
		</#if>
	</#list>
    
    var now = new Date();//初始时间
    // var date1 = new Date(2015,5,30);//点击的时间
    var fag = 0;//右移++
    var fag1 = 0;//左移++
    var n_index;
    var p_index;
    var l_left;//
    //向前，后移动并重新初始化数据
    function add_sj_p(date,index,c_name,in_t){
        var n = date.getMonth();
        $("."+c_name+" .datelist ul li").each(function(i,ele){
            var date1 = new Date(date.getFullYear(),n,date.getDate());
            var m = date1.getDate()-index+i;
            date1.setDate(m);
            var str = dateTostr(date1,"-");
            $(this).get()[0].setAttribute("date",str);
            $(ele).children().children(".li_riqi").text(str);
            if(in_t == 1){
                $(ele).children().children(".li_content").html("<span class='li_content'>点击查看</span><form action='search' method='post' class='f_info'></form>");
                var departCity = "<input type='hidden' name='departCity' value='"+ '${objSear.departCity}'+"'/>";
        		var arriveCity = "<input type='hidden' name='arriveCity' value='"+ '${objSear.arriveCity}'+"'/>";
        		var doWay = "<input type='hidden' name='doWay' value='"+ '${objSear.doWay}'+"'/>";
        		var departDate = "<input type='hidden' name='departDate' value='"+str+"'/>";
        		$(ele).children("form").html(departCity+arriveCity+departDate+doWay);
                return;
            }else{
                var date_l = new Date(date1.getFullYear(),date1.getMonth(),date1.getDate());
                var date_n = new Date(now.getFullYear(),now.getMonth(),now.getDate());
                date_n.setDate(date_n.getDate()+30);
                var mn = (date_n.getTime()-date_l.getTime())/(24*3600*1000)+1;
                $(ele).children().children(".li_content").children("span").text(minprices[31-mn]);
        		var departCity = "<input type='hidden' name='departCity' value='"+ '${objSear.departCity}'+"'/>";
        		var arriveCity = "<input type='hidden' name='arriveCity' value='"+ '${objSear.arriveCity}'+"'/>";
        		var doWay = "<input type='hidden' name='doWay' value='"+ '${objSear.doWay}'+"'/>";
        		var departDate = "<input type='hidden' name='departDate' value='"+str+"'/>";
        		$(ele).children("form").html(departCity+arriveCity+departDate+doWay);
            }
        });
        math_date(c_name);
    }
    //计算周几返回固定date-week格式
     function week_formate(date){
        var i = parseInt(date.getDay());
        var week = ["周一","周二","周三","周四","周五","周六","周末"];
        return parseInt(date.getMonth()+1)+"-"+date.getDate()+" "+week[i];
    }
    //计算总天数,大于30就不显示
    function math_date(c_name){
        var datenoshow = new Date(now.getFullYear(),now.getMonth(),now.getDate());
        datenoshow.setDate(datenoshow.getDate()+30);
        $("."+c_name+" .datelist ul li").each(function(li_index,element){
            var nian = parseInt($(element).attr("date").split("-")[0]);
            var yue = parseInt($(element).attr("date").split("-")[1]);
            var ri = parseInt($(element).attr("date").split("-")[2]);
            var num1 = parseInt(datenoshow.getFullYear());
            var num2 = parseInt(datenoshow.getMonth())+1;
            var num3 = parseInt(datenoshow.getDate());
            if(nian>num1 || (nian==num1 && yue>num2) || (nian==num1 && yue==num2 && ri>num3)){
            	if(yue < 10){
            		yue = '0'+yue;
            	}
            	
            	if(ri < 10){
            		ri = '0'+ri;
            	}
            	var str = nian+"-"+yue+'-'+ri;
            	var departDate;
            	<#if bookingFirstDto?? && bookingFirstDto.tripType != 'RETURN'>
            		departDate = '${objSear.arriveDate}';
            	<#else>
            		departDate = '${objSear.departDate}';
            	</#if>
            	
                if(str==departDate){
                    $(element).children().children(".li_content").html("<span class='click_check'>"+ '￥${minprice}'+"</span>");
                }else{ 
                    $(element).children().children(".li_content").html("<span class='click_check'>点击查看</span>");
                }
            }
        });
    }
    //初始化函数
    function myinit(d_now,d_click,c_name,noti){
        //清空ul数据
        $("."+c_name+" .datelist ul li").remove();
        $("."+c_name+" .datelist ul").css("left","0");
        fag = 0;
        fag1 = 0;
        $("."+c_name+" .datelist ul").css("width","3920px");
        var m_click = new Date(d_click.getFullYear(),d_click.getMonth(),d_click.getDate());
        var m_now = new Date(d_now.getFullYear(),d_now.getMonth(),d_now.getDate());
        var inde = parseInt(m_click.getTime())-parseInt(m_now.getTime()),
            count = inde/(3600*1000*24)+1;
        if(noti==1){
            var date =new Date(d_click.getFullYear(),d_click.getMonth(),d_click.getDate());
            date.setDate(date.getDate()-3);
            for (var i = 0; i < 7; i++) {
                $("."+c_name+" .datelist ul").append("<li date='' onclick='minPriceClick(this);'><a href='#'><p class='li_riqi'>"+week_formate(date)+"</p><p class='li_content'><span class='li_content'>点击查看</span></p></a><form action='search' method='post' class='f_info'></form></li>");
            };
            add_sj_p(date,0,c_name,1);
            var str = dateTostr(d_click,"-");
            $("."+c_name+" ul li").each(function(){
                if($(this).get()[0].getAttribute("date") == str)
                    $(this).siblings().removeClass("active")
                    .end().addClass("active");
            });
            return;
        }
        if(count < 4){
            var date =new Date(d_now.getFullYear(),d_now.getMonth(),d_now.getDate());
            for (var i = 0; i < 7; i++) {
                $("."+c_name+" .datelist ul").append("<li date='' onclick='minPriceClick(this);'><a href='#'><p class='li_riqi'>"+week_formate(date)+"</p><p class='li_content'><i></i><span>220</span></p></a><form action='search' method='post' class='f_info'></form></li>");
            }; 
            add_sj_p(date,0,c_name,0);
            $("."+c_name+" .datelist ul li").siblings().removeClass("active");
            var str = dateTostr(d_click,"-");
            $("."+c_name+" ul li").each(function(){
                if($(this).get()[0].getAttribute("date") == str)
                    $(this).siblings().removeClass("active")
                    .end().addClass("active");
            });
        }
        else{
            var date =new Date(d_click.getFullYear(),d_click.getMonth(),d_click.getDate());
            date.setDate(date.getDate()-3);
            for (var i = 0; i < 7; i++) {
                $("."+c_name+" .datelist ul").append("<li date=''  onclick='minPriceClick(this);'><a href='#'><p class='li_riqi'>"+week_formate(date)+"</p><p class='li_content'><i></i><span>220</span></p></a><form action='search' method='post' class='f_info'></form></li>");
            };
            // var str =d_click.getFullYear()+"-"+(d_click.getMonth()+1)+"-"+d_click.getDate();
            add_sj_p(date,0,c_name,0);
            var str = dateTostr(d_click,"-");
            $("."+c_name+" ul li").each(function(){
                if($(this).get()[0].getAttribute("date") == str)
                    $(this).siblings().removeClass("active")
                    .end().addClass("active");
            });
        }

        //多出的天数改成点击查询
        math_date(c_name);

        var n_i = $("."+c_name+" .datelist ul li").get().length-1;
        var n_date = strTodate($("."+c_name+" .datelist ul li").get()[n_i].getAttribute("date"));
        var n_date1 = new Date(now.getFullYear(),now.getMonth(),now.getDate());
        n_date1.setDate(n_date1.getDate()+34);
        n_index = ((parseInt(n_date1.getTime())-parseInt(n_date.getTime()))/
                        (3600*1000*24));
        var p_i = $("."+c_name+" .datelist ul li").get().length-1;
        var p_date1 = strTodate($("."+c_name+" .datelist ul li").get()[p_i].getAttribute("date"));
        var p_date = strTodate($("."+c_name+" .datelist ul li").get()[0].getAttribute("date"));
        var second_d = new Date(now.getFullYear(),now.getMonth(),now.getDate());
        p_index = (parseInt(p_date.getTime())-parseInt(second_d.getTime()))/
                        (3600*1000*24);
        if(p_index < 0)
            p_index = 0;
        date_comp(now,c_name,0);
        date_comp(now,c_name,0);                
    }
    //判断箭头颜色
    function date_comp(date1,c_name,lleft,str){ 
        var date = strTodate($("."+c_name+" .datelist ul li").get()[0].getAttribute("date"));
        var c_date = new Date(date.getFullYear(),date.getMonth(),date.getDate());
        var c_date1 = new Date(date1.getFullYear(),date1.getMonth(),date1.getDate());
        var f_i = c_date.getTime() - c_date1.getTime();
        // console.log(lleft+":     :"+f_i);
        if(lleft==0 && f_i == 0){
            $("."+c_name+" .prv span").css("border-right-color","#ccc");
        }else{
            $("."+c_name+" .prv span").css("border-right-color","#ED3386");
        }
        // 右箭头
        if(lleft==28 || str == 1){
            $("."+c_name+" .next span").css("border-left-color","#ccc");
        }else{
            $("."+c_name+" .next span").css("border-left-color","#ED3386");
        }  
    }
    var getleft = function(c_name){
        var d_left = $("."+c_name+" .datelist ul").css("left");
        var i_m = Math.abs(parseInt(d_left.replace(/px/,""))/112);
        return i_m;
    }
    // 向右动
    $(".next").click(function(){
        if($("."+classname+" .datelist ul").is(":animated")){
            return;
        }
        var classname = $(this).parent().get()[0].className;  
        var date = strTodate($("."+classname+" .datelist ul li").get()[0].getAttribute("date"));
        var i = $("."+classname+" .datelist ul li").get().length-1;
        var date1 = strTodate($("."+classname+" .datelist ul li").get()[i].getAttribute("date"));
        var right = Math.abs(parseInt($("."+classname+" .datelist ul").css("left")));
        if(fag > 0){
            if($("."+classname+" .datelist ul").is(":animated")){
                return null;
            }
            var i = fag/784;
            if(i>=1){
                $("."+classname+" .datelist ul").animate({"left":"-="+784+"px"},300,function(){ l_left = getleft(classname);date_comp(now,classname,l_left,0);});
                fag = fag - 784;  
                fag1 = fag1 + 784;
                return null;
            }
            else{
                if($("."+classname+" .datelist ul").is(":animated")){
                    return null;
                }
                $("."+classname+" .datelist ul").animate({"left":"-="+fag%784+"px"},300,function(){ l_left = getleft(classname);
                    date_comp(now,classname,l_left,0);});
                fag1 =fag1 + fag%784;
                fag = 0; 
                return null;
            }
        }
        if(n_index>7 && fag == 0){
            if($("."+classname+" .datelist ul").is(":animated")){
                return null;
            }
            for (var i = 0; i < 7; i++) {
                $("."+classname+" .datelist ul").append("<li date='' onclick='minPriceClick(this);'><a href='#'><p class='li_riqi'></p><p class='li_content'><i></i><span>220</span></p></a><form action='search' method='post' class='f_info'></form></li>");
            };
            add_sj_p(date,0,classname,0);
            $("."+classname+" .datelist ul").animate({"left":"-="+784+"px"},300,function(){ l_left = getleft(classname);
                date_comp(now,classname,l_left,0);});
            fag1 = fag1 + 784;
            n_index = n_index - 7;
            //多出的天数改成点击查询
            math_date(classname);
            return null;
        }
        if(n_index<=7 && fag == 0){
            if($("."+classname+" .datelist ul").is(":animated")){
                return null;
            }
            for (var i = 0; i < n_index; i++) {
                $("."+classname+" .datelist ul").append("<li date=''><a href='#'><p class='li_riqi'></p><p class='li_content'><i></i><span>220</span></p></a><form action='search' method='post' class='f_info'></form></li>");
            };
            add_sj_p(date,0,classname,0);
            $("."+classname+" .datelist ul").animate({"left":"-="+112*n_index+"px"},300,function(){ l_left = getleft(classname);
                date_comp(now,classname,l_left,1);});
            fag1 = fag1 + 112*(n_index);
            n_index = 0;
            //多出的天数改成点击查询
            math_date(classname);
            return null;
        }
    })
    // 向左动
    $(".prv").click(function(){
        var classname = $(this).parent().get()[0].className;
        var date = strTodate($("."+classname+" .datelist ul li").get()[0].getAttribute("date"));
        var left = Math.abs(parseInt($("."+classname+" .datelist ul").css("left")));
        if(fag1 > 0){
            if($("."+classname+" .datelist ul").is(":animated")){
                return null;
            }
            var i = fag1/784;
            if(i>=1){
                $("."+classname+" .datelist ul").animate({"left":"+="+784+"px"},300,function(){ l_left = getleft(classname);date_comp(now,classname,l_left,0);});
                fag1 = fag1 - 784;
                fag = fag + 784;
                return null;
            }
            else{
                if($("."+classname+" .datelist ul").is(":animated")){
                    return null;
                }
                $("."+classname+" .datelist ul").animate({"left":"+="+fag1%784+"px"},300,function(){ l_left = getleft(classname);date_comp(now,classname,l_left,0);});
                fag = fag + (fag1%784);
                fag1 = 0;
                return null;
            }
        }
        if(p_index>7 && fag1 == 0){
            if($("."+classname+" .datelist ul").is(":animated")){
                return null;
            }
            for (var i = 0; i < 7; i++) {
                $("<li date=''><a href='#'><p class='li_riqi'></p><p class='li_content'><i></i><span>220</span></p></a><form action='search' method='post' class='f_info'></form></li>").insertBefore($("."+classname+" .datelist ul").get()[0].firstChild);
            };
            add_sj_p(date,7,classname,0);
            $("."+classname+" .datelist ul").css("left","-784px");
            $("."+classname+" .datelist ul").animate({"left":"+="+784+"px"},300,function(){ l_left = getleft(classname);date_comp(now,classname,l_left,0);});
            fag = fag + 784;
            p_index = p_index - 7;
            return null;
        }
        if(p_index<=7 && fag1 == 0){
            if($("."+classname+" .datelist ul").is(":animated")){
                return null;
            }
            if(p_index == 0){
                date_comp(now,classname,0,0); 
                return null;
            }else{
                for (var i = 0; i < p_index; i++) {
                    $("<li date=''><a href='#'><p class='li_riqi'></p><p class='li_content'><i></i><span>220</span></p></a><form action='search' method='post' class='f_info'></form></li>").insertBefore($("."+classname+" .datelist ul").get()[0].firstChild);
                };
                add_sj_p(date,p_index,classname,0);
                $("."+classname+" .datelist ul").css("left","-"+112*p_index+"px");
                $("."+classname+" .datelist ul").animate({"left":"+="+112*p_index+"px"},300,function(){ l_left = getleft(classname);
                date_comp(now,classname,l_left,0);});
                fag = fag + 112*p_index;
                p_index = 0;
                return null;
            }
        }
    })
    //当前时间
    var now_d = new Date();
    $( "#datepicker-0" ).datepicker({
        inline: true,
        numberOfMonths:2,
        dateFormat:"yy-mm-dd",
        minDate:now_d,
        altField:".input_date input[name='departDate']"
    });
    $( "#datepicker-1" ).datepicker({
        inline: true,
        numberOfMonths:2,
        dateFormat:"yy-mm-dd",
        minDate:now_d,
        altField:".input_date input[name='arriveDate']"
    });
    var z_date = new Date($("#datepicker-0").datepicker("getDate"));
    z_date.setDate(z_date.getDate()+1);
    $.datepicker.formatDate("yy-mm-dd",z_date);
    $(".input_date input[name='departDate'],.input_date input[name='arriveDate']").val($.datepicker.formatDate("yy-mm-dd",z_date));

    // 选定日期重新初始化（居中）
    function update_n(str,c_name){
        var y = str.split("-")[0];
        var m = str.split("-")[1];
        var d = str.split("-")[2];
        var date = new Date(y,(m-1),d);
        var last_d = new Date(now.getFullYear(),now.getMonth(),now.getDate());
        // 判断选定的时间在31天外
        last_d.setDate(last_d.getDate()+30);
        if(y>last_d.getFullYear() || y==last_d.getFullYear()&&(m-1)>last_d.getMonth()||y==last_d.getFullYear()&&(m-1)==last_d.getMonth()&&d>last_d.getDate()){
            last_d.setDate(last_d.getDate()-3);
            myinit(now,date,c_name,1);
            $("."+c_name+" .prv span").css("border-right-color","#ccc");
            $("."+c_name+" .prv").attr("disabled","true");
            $("."+c_name+" .next span").css("border-left-color","#ccc");
            $("."+c_name+" .next").attr("disabled","true");
        }else{
            $("."+c_name+" .prv span").css("border-right-color","#ED3386");
            $("."+c_name+" .next span").css("border-left-color","#ED3386");
            $("."+c_name+" .prv").removeAttr("disabled");
            $("."+c_name+" .next").removeAttr("disabled");
            myinit(now,date,c_name,0);
        } 
    }

    //点击搜索初始化
//    $(".pinkbut").click(function(){
//        var b_str = $("input[name='departDate']").val();
//        update_n(b_str,"li_dancheng");
//    });
    // 点击样式变化,提交内部表单
    $("body").on("click",".datelist li",function(){
        $(this).siblings().removeClass("active")
        .end().addClass("active");
        var date2 = strTodate($(this).children().children(".li_riqi").text());
        var classname = $(this).closest(".datelist").parent().get()[0].className;  
        var l_fag = $(this).children().children(".li_content").children(".click_check").length;
        //if(date2 != null && l_fag <= 0)
            //myinit(now,date2,classname,0);
        $(this).children("form").submit();
    })

    $("body").on("mouseover",".datelist li",function(){
        $(this).siblings().removeClass("list_bg")
        .end().addClass("list_bg");
    })
    $("body").on("mouseout",".datelist li",function(){
        $(this).removeClass("list_bg");
    })

    //赋值及页面初始化
    <#if bookingFirstDto?? && bookingFirstDto.tripType != 'RETURN'> 
    	$("#departCity").val('${objSear.arriveCity}');
    	$("#arriveCity").val('${objSear.departCity}');
    <#else>
	    $("#departCity").val('${objSear.departCity}');
	    $("#arriveCity").val('${objSear.arriveCity}');
    </#if>
    $(".input_date input[name='departDate']").val('${objSear.departDate}');//出发日期
    $(".input_date input[name='arriveDate']").val('${objSear.arriveDate}');//到达日期
    update_n('${objSear.departDate}',"li_dancheng");
    <#if bookingFirstDto?? && bookingFirstDto.tripType != 'RETURN'>
    update_n('${objSear.arriveDate}',"li_free");
    <#else>
    update_n('${objSear.departDate}',"li_free");
    </#if>
})
</script>



<script type="text/javascript">
$(function(){
    // 自由搭配、往返组合combination_tab
        $(".combination").tabChange({ 
            initNum:0,
            tabName: "combination_tab",
            tabSwitch: "a"
        });
        <#if objSear.selectedFlightNo??>
        	<#if objSear.doWay == 1>
        		document.getElementById("anchor_scroll_ow").click();
        	</#if>
        	<#if objSear.doWay == 2>
        		document.getElementById("anchor_scroll_rt").click();
        	</#if>
        </#if>
})
</script>


<script type="text/javascript">
//字符串转日期
    function strTodate(str){
        var formate1 = str.split("-");
        var formate2 = str.split(".");
        var formate3 = str.split("/");
        var date;
        if(formate1.length>1)
            date = new Date(formate1[0],(parseInt(formate1[1])-1),formate1[2]);
        if(formate2.length>1)
            date = new Date(formate2[0],(parseInt(formate2[1])-1),formate2[2]);
        if(formate3.length>1)
            date = new Date(formate3[0],(parseInt(formate3[1])-1),formate3[2]);
        return date;
    }
//日期转字符串
    function dateTostr(date,str){
        var stringdate = date.getFullYear()+str+(parseInt(date.getMonth())+1)+str+date.getDate();
        return stringdate;
    }

    $(".tankuang_hover").hover(function(){
        $(this).closest("li").children(".tankuang_show").css("display","block");
        var height_tk = parseInt($(this).closest("li").children(".tankuang_show").offset().top);
        var height_b = parseInt($("body").css("height"));
        if((height_b-height_tk)<133){
            $(this).closest("li").children(".tankuang_show").css("top","-70px");
        }
    },function(){
        $(this).closest("li").children(".tankuang_show").css("display","none");
        $(this).closest("li").children(".tankuang_show").css("top","40px");
    });
    
    
    
    /*$(".return_hover").hover(function(){
    	var ticketDiv = $(this).closest("li").children("div");
    	var carrierCode=$(this).closest("li").attr('carrierCode');
    	var departAirportCode=$(this).closest("li").attr('departAirportCode');
    	var arriveAirportCode=$(this).closest("li").attr('arriveAirportCode');
    	var parPrice=$(this).closest("li").attr('parPrice');
    	var policyId=$(this).closest("li").attr('policyId');
    	var seatClassCode=$(this).closest("li").attr('seatClassCode');
    	if(ticketDiv.html() == ''){
        	$.ajax({
    			url : 'ticketRule',
    			data : {carrierCode:carrierCode,
    					departureAirportCode:departAirportCode,
    					arrivalAirportCode:arriveAirportCode,	
    					parPrice:parPrice,
    					policyId:policyId,
    					seatClassCode:seatClassCode
    					},
    			type : 'post',
    			dataType:'json',    
    			success : function(data) {
    				var dataLeng = data.length;
    				for(var i=0;i<dataLeng;i++ ){
    					var heads = data[i].heads;
        				var vts = data[i].vts;
        				var rts = data[i].rts;
        				var mts = data[i].mts;
        				var cts = data[i].cts;
        				var descs = data[i].ticketRuleDesc;
        				var headTd = "";
        				for(var i=0;i<heads.length;i++){
        					headTd = headTd+"<td>"+heads[i]+"</td>";
        				}
        				
        				var vtTd = "";
        				for(var i=0;i<vts.length;i++){
        					if(vts[i] == ''){
        						vtTd = vtTd+"<td>&yen;"+vts[i]+"</td>";
        					}else{
        						vtTd = vtTd+"<td>&yen;"+vts[i]+"</td>";
        					}
        				}
        				
        				var rtTd = "";
        				for(var i=0;i<rts.length;i++){
        					if(rts[i] == ''){
        						rtTd = rtTd+"<td>"+rts[i]+"</td>";
        					}else{
        						rtTd = rtTd+"<td>&yen;"+rts[i]+"</td>";
        					}
        				}
        				
        				var mtTd = "";
        				for(var i=0;i<mts.length;i++){
        					if(mts[i] == ''){
        						mtTd = mtTd+"<td>"+mts[i]+"</td>";
        					}else{
        						mtTd = mtTd+"<td>&yen;"+mts[i]+"</td>";
        					}
        				}
        				
        				var ctTd = "";
        				for(var i=0;i<cts.length;i++){
        					if(cts[i] == ''){
        						ctTd = ctTd+"<td>"+cts[i]+"</td>";
        					}else{
        						ctTd = ctTd+"<td>&yen;"+cts[i]+"</td>";
        					}
        				}
        				
        				var ticketDesc = "";
        				for(var i=0;i<descs.length;i++){
        					if(descs[i] == ''){
        						ticketDesc = ticketDesc+"<td>"+descs[i]+"</td>";
        					}else{
        						ticketDesc = ticketDesc+"<td colspan='2'>"+descs[i]+"</td>";
        					}
        				}
        				
        				
        				var rtType = "";
        				if(rts.length >0){
        					rtType = "<td>退票费</td>"+rtTd;
        				}
        				
        				var ctType = "";
        				if(cts.length >0){
        					ctType = "<td>改期费</td>"+ctTd;
        				}
        				
        				var mtType = "";
        				if(mts.length >0){
        					mtType = "<td>签转费</td>"+mtTd;
        				}
        				
        				var descType = "";
        				if(descs.length >0){
        					descType = "<td>退改详情</td>"+ticketDesc;
        				}
        				
        				var strDiv = '<table border="1px bolid"><tr><td rowspan="5" width="24px">成<br/>人<br/>票</td>'+
        				'<td></td>'+headTd+'</tr><tr>'+rtType
        				+'</tr><tr>'+ctType+'</tr><tr>'+mtType+'</tr><tr>'+descType+'</tr></table>';
        				ticketDiv.append(strDiv);
    				}
    			},
    			error : function() {
    				
    			}
    		});
    	}
    	ticketDiv.css("display","block");
        var height_tk = parseInt($(this).closest("li").children("div").offset().top);
        var height_b = parseInt($("body").css("height"));
        if((height_b-height_tk)<133){
            $(this).closest("li").children("div").css("top","-200px");
        }
    },function(){
    	$(this).closest("li").children("div").css("display","none");
        $(this).closest("li").children("div").css("top","40px");
//     	$(this).closest("li").children("div").children('table').remove();
    });*/
    
    
    $(".return_hover").hover(function(){
    	var ticketDiv = $(this).closest("li").children("div");
    	$(this).closest("li").children("div").css("top","20px");
    	var carrierCode=$(this).closest("li").attr('carrierCode');
    	var departAirportCode=$(this).closest("li").attr('departAirportCode');
    	var arriveAirportCode=$(this).closest("li").attr('arriveAirportCode');
    	var seatClassCode=$(this).closest("li").attr('seatClassCode');
    	var pricePolicyId=$(this).closest("li").attr('pricePolicyId');
    	var departDate = '${objSear.departDate}';
    	if(ticketDiv.html() == ''){
        	$.ajax({
    			url : 'ticketRuleSimple',
    			data : {carrierCode:carrierCode,
    					departureAirportCode:departAirportCode,
    					arrivalAirportCode:arriveAirportCode,	
    					seatClassCode:seatClassCode,
    					departDate:departDate,
    					pricePolicyId:pricePolicyId
    					},
    			type : 'post',
    			dataType:'json',    
    			success : function(data) {
    				var length = data.simpleDetails.length;
    				var ticketDivHtml = '<table border="1px bolid " >';
    				for(var i=0;i<length;i++){
    					 var trHtml = '<tr>';
    					  if(i==0){
    						  trHtml = trHtml+'<td  rowspan="'+(length+1)+'" style="width:40px;">成人</td></tr>';
    					  }
    					  var detailFeeTypeName = data.simpleDetails[i].detailFeeTypeName;
    					  var detailFeeDesc = data.simpleDetails[i].detailFeeDesc;
    					  trHtml = trHtml+'<td style="width:50px;">'+detailFeeTypeName+'</td>';
    					  trHtml = trHtml+'<td style="width:250px;word-break:break-all;">'+detailFeeDesc+'</td>';
    					  trHtml = trHtml+'</tr>';
    					  ticketDivHtml = ticketDivHtml+trHtml;
    				}
    				ticketDivHtml = ticketDivHtml+'</table>';
    				ticketDiv.html("");
    				ticketDiv.append(ticketDivHtml);
    				if(length==0){
    					ticketDiv.html("无数据！");
    				}
    			},
    			error : function() {
    				ticketDiv.html("无数据！")
    			}
    		});
    	}
    	ticketDiv.css("display","block");
        var height_tk = parseInt($(this).closest("li").children("div").offset().top);
        var height_b = parseInt($("body").css("height"));
        if((height_b-height_tk)<150){
            $(this).closest("li").children("div").css("top","-250px");
        }
    },function(){
    	$(this).closest("li").children("div").css("display","none");
        $(this).closest("li").children("div").css("top","20px");
    });
    
       $(".return_hover_history").hover(function(){
    	var ticketDiv = $(this).closest("li").children("div");
    	$(this).closest("li").children("div").css("top","20px");
    	var carrierCode=$(this).closest("li").attr('carrierCode');
    	var departAirportCode=$(this).closest("li").attr('departAirportCode');
    	var arriveAirportCode=$(this).closest("li").attr('arriveAirportCode');
    	var seatClassCode=$(this).closest("li").attr('seatClassCode');
    	var departDate = '${objSear.departDate}';
    	if(ticketDiv.html() == ''){
        	$.ajax({
    			url : 'ticketRuleSimple',
    			data : {carrierCode:carrierCode,
    					departureAirportCode:departAirportCode,
    					arrivalAirportCode:arriveAirportCode,	
    					seatClassCode:seatClassCode,
    					departDate:departDate
    					},
    			type : 'post',
    			dataType:'json',    
    			success : function(data) {
    				var length = data.simpleDetails.length;
    				var ticketDivHtml = '<table border="1px bolid " style="width:400px;">';
    				for(var i=0;i<length;i++){
    					 var trHtml = '<tr>';
    					  if(i==0){
    						  trHtml = trHtml+'<td  rowspan="'+(length+1)+'" style="width:40px;">成人</td></tr>';
    					  }
    					  var detailFeeTypeName = data.simpleDetails[i].detailFeeTypeName;
    					  var detailFeeDesc = data.simpleDetails[i].detailFeeDesc;
    					  trHtml = trHtml+'<td style="width:50px;">'+detailFeeTypeName+'</td>';
    					  trHtml = trHtml+'<td style="width:300px;word-break:break-all;">'+detailFeeDesc+'</td>';
    					  trHtml = trHtml+'</tr>';
    					  ticketDivHtml = ticketDivHtml+trHtml;
    				}
    				ticketDivHtml = ticketDivHtml+'</table>';
    				ticketDiv.html("");
    				ticketDiv.append(ticketDivHtml);
    				if(length==0){
    					ticketDiv.html("无数据！");
    				}
    			},
    			error : function() {
    				ticketDiv.html("无数据！")
    			}
    		});
    	}
    	ticketDiv.css("display","block");
        var height_tk = parseInt($(this).closest("li").children("div").offset().top);
        var height_b = parseInt($("body").css("height"));
        if((height_b-height_tk)<133){
            $(this).closest("li").children("div").css("top","-200px");
        }
    },function(){
    	$(this).closest("li").children("div").css("display","none");
        $(this).closest("li").children("div").css("top","30px");
    });
    
    
    
$(function(){
		var way=${objSear.doWay}
	    if(way=='1'){
		    $(".doWay1").attr("checked","checked");
		    //$('#arriveTime').attr("disabled",true);
		    $('#arriveDateId').hide();
		    <#if objSear.isMeals??>
		    	$('#isHaveMeal').attr("checked","checked");
		    </#if>
		    <#if objSear.isDirect??>
		    	$('#isDirect').attr("checked","checked");
		    </#if>
		    $(".typeofflight").tabChange({ 
		        initNum:0,
		        tabName: "flighttab",
		        tabSwitch: "input"
		    });
		    
	    }else if(way=='2'){
		    $(".doWay2").attr("checked","checked");
		    //$('#arriveTime').attr("disabled",false);
		    $('#arriveDateId').show();
		    <#if objSear.isMeals??>
		    	$('#isHaveMealShuffle').attr("checked","checked");
		    </#if>
		    <#if objSear.isDirect??>
		    	$('#isDirectShuffle').attr("checked","checked");
		    </#if>
		    $(".typeofflight").tabChange({ 
		        initNum:1,
		        tabName: "flighttab",
		        tabSwitch: "input"
		    });
	    }
		
	// 自由搭配
	    $(".combination").tabChange({ 
	        initNum:0,
	        tabName: "combination_tab",
	        tabSwitch: "a"
	    });
	    
	// 点击修改航班，航班信息消失
	    $(".mobily_flight").click(function(){
	        $('#cancelSelected').submit();
	    });
		
		function getBookingDetailRequest(flightNo,seatId){ 
			var arrayList = new Array(); 
			var request = new Object(); 
			request.flightTripType="DEPARTURE";
			request.flightNo=$('#airplaneModel_'+flightNo).val(); 
			request.departureDate=$('#getcity_name').val();
			request.departureAirportCode=$('#departureAirportCode_'+flightNo).val(); 
			request.arrivalAirportCode=$('#arrivalAirportCode_'+flightNo).val(); 
			request.seatClassCode=$('#seatClassCode_'+seatId).val(); 
			request.parPrice=$('#parPrice_'+seatId).val();
			request.policyId=$('#policyId_'+seatId).val();
			arrayList[0] = request;
			return arrayList;
		}
	})


	function routeType(obj){
	    	var val = obj.value;
	    	if(val == 1){
	    		//$('#arriveTime').attr("disabled",true);
	    		$('#arriveDateId').hide();
	    		$('#arriveTime').val(null);
	    	}else{
	    		$('#arriveDateId').show();
	    	}
	} 

	function minPriceClick(val){
		$(val).children('form').submit();
	}

	function minPriceClickRT(arg){
		$(":radio").each(function(){
		    if($(this).attr("checked")){
		    	if($(this).val() == 2){
		    		$('#'+arg+arg+'_2').val(2);
		    	}
		    }
		})
		$('#'+arg+"_2").submit();
	}

	function validSession(){
		$.ajax({
			url : 'validSession',
			contentType:"application/json;",
			dataType:"json",
			type : 'post',
			success : function(data) {
			},
			error : function() {
			}
		});
	}

//点击预订，显示航程信息
	function bookingAjax(obj){
	    	var doWay = $('input[name="doWay"]:checked').val();
	    	var flightNo = $(obj).attr("flightNo");
	    	var seatId = $(obj).attr("seatId");
	    	var policyId = $(obj).attr("policyId");
	    	var pricePolicyId = $(obj).attr("pricePolicyId");
	    	var conditions = new Array();
	    	var obj1 = new Object();
	    	obj1.flightNo = flightNo;
	    	obj1.carrierCode = $(obj).attr("carrierCode");
	    	obj1.departureAirportCode = $(obj).attr('departAirportCode');
	    	obj1.arrivalAirportCode = $(obj).attr('arriveAirportCode');
	    	obj1.parPrice = $(obj).attr('parPrice');
	    	obj1.pricePolicyId = $(obj).attr('pricePolicyId');
	    	obj1.seatClassCode = $(obj).attr('seatClassCode');
	    	obj1.departDate = $(obj).attr('departDate');
	    	conditions[0] = obj1;
	    	var input3 = $("<input type='hidden' name='bookingSource'/>");
	    	var bookingSource;
	    	if('${objSear.vstOrderId}' != null && $.trim('${objSear.vstOrderId}') != ''){
	    		bookingSource = 'VST_PACKAGE_BACK';
	    	}else{
	    		bookingSource = 'LAMAMA_BACK';
	    	}
	    	input3.attr('value',bookingSource);
	    	if(doWay == 1){
	    		$.ajax({
	    			url : 'verifySeatAndPrice',
	    			contentType:"application/json;",
	    			dataType:"json",
	    			data : JSON.stringify({
	    				conditions:conditions
	    				}),
	    			type : 'post',
	    			success : function(data) {
	    				if(data.status == 'SUCCESS'){
	    					var input1 = $("<input type='hidden' name='vstOrderId' />");
	    					input1.attr('value','${objSear.vstOrderId}');
	    					var input2 = $("<input type='hidden' name='vstOrderMainId' />");
	    					input2.attr('value','${objSear.vstOrderMainId}');
	    					var form = $('#'+flightNo+seatId+pricePolicyId+"_1");
	    					form.append(input1);
	    					form.append(input2);
	    					form.append(input3);
	    					form.submit();
	    				}else{
	    					$(obj).css('cursor', 'no-drop');
	    					var form = $('#formHideOW');
	    					var input1 = $("<input type='hidden' name='selectedFlightNo' />");
	    			        input1.attr('value',flightNo);
	    			        var input2 = $("<input type='hidden' name='vstOrderId' />");
	    					input2.attr('value','${objSear.vstOrderId}');
	    					var input4 = $("<input type='hidden' name='vstOrderMainId' />");
	    					input4.attr('value','${objSear.vstOrderMainId}');
	    			        form.append(input1);
	    			        form.append(input2);
	    			        form.append(input3);
	    			        form.append(input4);
	    					form.submit();
	    				}
	    			},
					error : function(textStatus, errorThrown) {
						alert("系统ajax交互错误: " + textStatus);
	    			}
	    		});
	    	}else{
	    		$.ajax({
	    			url : 'verifySeatAndPrice',
	    			contentType:"application/json;",
	    			dataType:"json",
	    			data : JSON.stringify({
	    				conditions:conditions
	    				}),
	    			type : 'post',
	    			success : function(data) {
			    		if(data.status == 'SUCCESS'){
			    			var input1 = $("<input type='hidden' name='vstOrderId' />");
	    					input1.attr('value','${objSear.vstOrderId}');
	    					var input2 = $("<input type='hidden' name='vstOrderMainId' />");
	    					input2.attr('value','${objSear.vstOrderMainId}');
	    					var form = $('#'+flightNo+seatId+pricePolicyId+"_2");
	    					form.append(input1);
	    					form.append(input2);
	    					form.append(input3);
			    			$('#'+flightNo+seatId+pricePolicyId+"_3").val(doWay);
				    		form.submit();
	    				}else{
	    					$(obj).css('cursor', 'no-drop');
	    					var input2 = $("<input type='hidden' name='vstOrderId' />");
	    					input2.attr('value','${objSear.vstOrderId}');
	    					var input4 = $("<input type='hidden' name='vstOrderMainId' />");
	    					input4.attr('value','${objSear.vstOrderMainId}');
	    					<#if bookingFirstDto??>
		    					var form = $('#formHideRT');
		    					var input1 = $("<input type='hidden' name='selectedFlightNo' />");
		    			        input1.attr('value',flightNo);
		    			        form.append(input1);
		    			        form.append(input2);
		    			        form.append(input3);
		    			        form.append(input4);
		    					form.submit();
	    					<#else>
		    					var form = $('#formHideOW');
		    					var input1 = $("<input type='hidden' name='selectedFlightNo' />");
		    			        input1.attr('value',flightNo);
		    			        form.append(input1);
		    			        form.append(input2);
		    			        form.append(input3);
		    			        form.append(input4);
		    					form.submit();
	    					</#if>
	    				}
	    			},
	    			error : function(textStatus, errorThrown) {
	    				alert("系统ajax交互错误: " + textStatus);
	    			}
	    		});
		    }
	}

	function searchSubmit(){
		if($.trim($('#departCity').val()) == ''){
			alert("请选择出发城市");
			$('#departCity').focus();
			return;
		}
		
		if($.trim($('#arriveCity').val()) == ''){
			alert("请选择到达城市");
			$('#arriveCity').focus();
			return;
		}
		
		var doWay = $('input[name="doWay"]:checked').val();
		if(doWay == 2){
			if($('#arriveTime').val() == null || $('#arriveTime').val() == ''){
				alert("请选择返回日期");
				return;
			}
		}
		
		var start=new Date(($("#departTime").val()).replace(/-/g,"/"));
		var end=new Date(($("#arriveTime").val()).replace(/-/g,"/")); 
		if(start>=end){
			alert("出发时间不能大于返回时间");
			return;
		}
		
		var input1 = $("<input type='hidden' name='vstOrderId' />");
		input1.attr('value','${objSear.vstOrderId}');
		
		var input2 = $("<input type='hidden' name='vstOrderMainId' />");
		input2.attr('value','${objSear.vstOrderMainId}');
		var form = $('#search_form');
		form.append(input1);
		form.append(input2);
		form.submit();
	}


//点击展开收缩
$(function(){
var _extend = $(".extend");
	_extend.toggle(function(){
		var data = $(this).attr('data');
		$(this).addClass('up').children('span').text('收起');
		$(":radio").each(function(){
		    if($(this).attr("checked")){
		    	if($(this).val() == 1){
					$('#extend_content_'+data+'_1').fadeIn('slow');
					$('#'+data+"_0_1").hide();
					$('#'+data+"_1_1").hide();
					$('#'+data+"_2_1").hide();
					$('#'+data+"_1").attr('style','display:none');
		    	}else{
					$('#extend_content_'+data+'_2').fadeIn('slow');
					$('#'+data+"_0_2").hide();
					$('#'+data+"_1_2").hide();
					$('#'+data+"_2_2").hide();
					$('#'+data+"_2").attr('style','display:none');
				}
		    }
		})
		
		},function(){
			var data = $(this).attr('data');
			$(this).removeClass('up').children('span').text('展开所有');
			$(":radio").each(function(){
			    if($(this).attr("checked")){
			    	if($(this).val() == 1){
			    		$('#extend_content_'+data+'_1').hide();
			    		$('#'+data+"_0_1").show();
						$('#'+data+"_1_1").show();
						$('#'+data+"_2_1").show();
						$('#'+data+"_1").attr('style','display:block');
					}else{
						$('#extend_content_'+data+'_2').hide();
						$('#'+data+"_0_2").show();
						$('#'+data+"_1_2").show();
						$('#'+data+"_2_2").show();
						$('#'+data+"_2").attr('style','display:block');
					}
			    }
			})
		});
	});

	$(function(){
		var way=${objSear.doWay};
		if(way=='2'){
			<#if bookingFirstDto??>
				$('#modifyFlight').css('display','block');
			</#if>
		}
		$("#id option[value='1']").attr("selected","selected");
	});
	
	$(function(){
		$('#doWaySingle').hide();
		$('#doWayDouble').hide();
	})

	$(function(){
		$(".shaixuan02 p i").click(function(){
			$(this).parent(".shaixuan02 p").hide();
			});
		$("#clear_c").click(function(){
			$(".shaixuan02").hide();
			});	
	});
	
	
	function tranferCity(){
		var arriveCity = $('#arriveCity').val();
		var departCity = $('#departCity').val();
		$('#departCity').val(arriveCity);
		$('#arriveCity').val(departCity);
	}
	
	function commonForm(){
		var form_login=document.createElement("form");
    	document.body.appendChild(form_login);
    	form_login.action="search";
    	form_login.method="post";
    	form_login.charset='utf-8';
    	
    	var arriveDate = document.createElement("input");
    	arriveDate.type="hidden";
    	arriveDate.name="arriveDate";
    	var departDate = document.createElement("input");
    	departDate.type="hidden";
    	departDate.name="departDate";
    	var departCity = document.createElement("input");
    	departCity.type="hidden";
    	departCity.name="departCity";
    	var arriveCity = document.createElement("input");
    	arriveCity.type="hidden";
    	arriveCity.name="arriveCity";
    	
    	var vstOrderId = document.createElement("input");
    	vstOrderId.type="hidden";
    	vstOrderId.name="vstOrderId";
    	vstOrderId.value='${objSear.vstOrderId}';
    	
    	var vstOrderMainId = document.createElement("input");
    	vstOrderMainId.type="hidden";
    	vstOrderMainId.name="vstOrderMainId";
    	vstOrderMainId.value="${objSear.vstOrderMainId}";
    	
    	<#if objSear.doWay == 2>
			$(form_login).html($('#bookingFirstDtoDiv').html());
			<#if bookingFirstDto?? && bookingFirstDto.tripType != 'RETURN'>
				departDate.value='${objSear.arriveDate}';
				arriveDate.value="${objSear.departDate}";
				<#else>
				departDate.value='${objSear.departDate}';
				arriveDate.value="${objSear.arriveDate}";
			</#if>
			
			departCity.value="${objSear.departCity}";
			arriveCity.value="${objSear.arriveCity}";
		<#else>
	    	departDate.value='${objSear.departDate}';
			departCity.value="${objSear.departCity}";
			arriveCity.value="${objSear.arriveCity}";
		</#if>
		
		form_login.appendChild(arriveDate);
    	form_login.appendChild(departDate);
    	form_login.appendChild(departCity);
    	form_login.appendChild(arriveCity);
    	
    	var doWay = document.createElement("input");
    	doWay.type="hidden";
    	doWay.value='${objSear.doWay}';
    	doWay.name="doWay";
    	form_login.appendChild(doWay);
    	form_login.appendChild(vstOrderId);
    	form_login.appendChild(vstOrderMainId);
    	return form_login;
	}
	
	function getSelectedSeg(form_login){
		var departTimeSelected = document.createElement("input");
		var departTimeSegInput = document.createElement("input");
		<#if objSear.departTimeSelected?exists>
		<#if objSear.departTimeSelected == 'true'>
	    	departTimeSelected.type="hidden";
	    	departTimeSelected.name="departTimeSelected";
	    	departTimeSelected.value="true";
	    	form_login.appendChild(departTimeSelected);
	    	departTimeSegInput.type="hidden";
	    	departTimeSegInput.name="departTimeSeg";
	    	form_login.appendChild(departTimeSegInput);
    	</#if>
    	</#if>
    	var departTimeSeg = document.getElementById('departTimeSeg');
    	var departTimeSegShuffle = document.getElementById('departTimeSegShuffle');
    	
    	var arriveTimeSegInput = document.createElement("input");
    	var arriveTimeSelected = document.createElement("input");
    	<#if objSear.arriveTimeSelected?exists>
    	<#if objSear.arriveTimeSelected == 'true'>
	    	arriveTimeSegInput.type="hidden";
	    	arriveTimeSegInput.name="arriveTimeSeg";
	    	form_login.appendChild(arriveTimeSegInput);
	    	arriveTimeSelected.type="hidden";
	    	arriveTimeSelected.name="arriveTimeSelected";
	    	arriveTimeSelected.value="true";
	    	form_login.appendChild(arriveTimeSelected);
    	</#if>
    	</#if>
    	var arriveTimeSeg = document.getElementById('arriveTimeSeg');
    	var arriveTimeSegShuffle = document.getElementById('arriveTimeSegShuffle');
    	
    	var carrierCodeInput = document.createElement("input");
    	var carriesSelected = document.createElement("input");
    	<#if objSear.carriesSelected?exists>
    	<#if objSear.carriesSelected == 'true'>
	    	carrierCodeInput.type="hidden";
	    	carrierCodeInput.name="airCompany";
	    	form_login.appendChild(carrierCodeInput);
	    	carriesSelected.type="hidden";
	    	carriesSelected.name="carriesSelected";
	    	carriesSelected.value="true";
	    	form_login.appendChild(carriesSelected);
    	</#if>
    	</#if>
    	var carrierCode = document.getElementById('carrierCode');
    	var carrierCodeShuffle = document.getElementById('carrierCodeShuffle');
    	
    	var seatBandInput = document.createElement("input");
    	var seatClassSelected = document.createElement("input");
    	<#if objSear.seatClassSelected?exists>
    	<#if objSear.seatClassSelected == 'true'>
	    	seatBandInput.type="hidden";
	    	seatBandInput.name="seatBand";
	    	form_login.appendChild(seatBandInput);
	    	seatClassSelected.type="hidden";
	    	seatClassSelected.name="seatClassSelected";
	    	seatClassSelected.value="true";
	    	form_login.appendChild(seatClassSelected);
    	</#if>
    	</#if>
    	var seatBand = document.getElementById('seatBand');
    	var seatBandShuffle = document.getElementById('seatBandShuffle');
    	
    	var meal = document.createElement("input");
    	<#if objSear.isMeals?exists>
		<#if objSear.isMeals == 'HAVE'>
    	    meal.type="hidden";
    	    meal.name="isMeals";
    	    meal.value="HAVE";
    	    form_login.appendChild(meal);
    	</#if>
    	</#if>
    	
    	var direct = document.createElement("input");
    	<#if objSear.isDirect?exists>
		<#if objSear.isDirect == 'DIRECT'>
    	    direct.type="hidden";
    	    direct.name="isDirect";
    	    direct.value="DIRECT";
    	    form_login.appendChild(direct);
    	</#if>
		</#if>
    	
    	$(":radio").each(function(){
		    if($(this).attr("checked")){
		    	if($(this).val() == 1){
		    		if(departTimeSeg.value != 'departSeg'){
		        		departTimeSegInput.value=departTimeSeg.value;
		        	}else{
		        		departTimeSegInput.value='';
		        		departTimeSelected.value="false";
		        	}
		    		
		    		if(arriveTimeSeg.value != 'arriveSeg'){
		        		arriveTimeSegInput.value=arriveTimeSeg.value;
		        	}else{
		        		arriveTimeSelected.value="false";
		        		arriveTimeSegInput.value='';
		        	}
		    			
		    		if(carrierCode.value != 'carrier'){
		    			carrierCodeInput.value=carrierCode.value;
		        	}else{
		        		carriesSelected.value="false";
		        		carrierCodeInput.value='';
		        	}
		    		
		    		if(seatBand.value != 'seatBand'){
		    			seatBandInput.value=seatBand.value;
		        	}else{
		        		seatClassSelected.value="false";
		        		seatBandInput.value='';
		        	}
				}else{
					if(departTimeSegShuffle.value != 'departSeg'){
						departTimeSegInput.value=departTimeSegShuffle.value;
			    	}else{
			    		departTimeSegInput.value='';
			    		departTimeSelected.value="false";
			    	}
					
					if(arriveTimeSegShuffle.value != 'arriveSeg'){
						alert(arriveTimeSegShuffle.value);
			    		arriveTimeSegInput.value=arriveTimeSegShuffle.value;
			    	}else{
			    		arriveTimeSegInput.value='';
			    		arriveTimeSelected.value="false";
			    	}
					
					if(carrierCodeShuffle.value != 'carrier'){
		    			carrierCodeInput.value=carrierCodeShuffle.value;
		        	}else{
		        		carriesSelected.value="false";
		        		carrierCodeInput.value='';
		        	}
					
					if(seatBandShuffle.value != 'seatBand'){
						seatBandInput.value=seatBandShuffle.value;
			    	}else{
			    		seatBandInput.value='';
			    		seatClassSelected.value="false";
			    	}
				}
		    	
		    }
		})
		return form_login;
	}

	function arriveTimeSort(){
    	var form_login = commonForm();
    	form_login = getSelectedSeg(form_login);
    	var sortByDepartAndArriveTime = document.createElement("input");
    	sortByDepartAndArriveTime.type="hidden";
    	sortByDepartAndArriveTime.name="sortByDepartureTimeDate";
    	form_login.appendChild(sortByDepartAndArriveTime);
    	if('${objSear.sortByDepartureTimeDate}' == 'ASC'){
    		sortByDepartAndArriveTime.value="DESC";
    	}else{
    		sortByDepartAndArriveTime.value="ASC";
    	}
    	form_login.submit();
    }

	function flyTimeSort(){
    	var form_login = commonForm();
    	form_login = getSelectedSeg(form_login);
    	var sortByFlyTime = document.createElement("input");
    	sortByFlyTime.type="hidden";
    	sortByFlyTime.name="sortByFlyTimeHours";
    	form_login.appendChild(sortByFlyTime);
    	if('${objSear.sortByFlyTimeHours}' == 'ASC'){
    		sortByFlyTime.value="DESC";
    	}else{
    		sortByFlyTime.value="ASC";
    	}
    	form_login.submit();
    }
	
	
	function parpriceSort(){
    	var form_login = commonForm();
    	form_login = getSelectedSeg(form_login);
    	var sortByParPrice = document.createElement("input");
    	sortByParPrice.type="hidden";
    	sortByParPrice.name="sortByParPrice";
    	form_login.appendChild(sortByParPrice);
    	if('${objSear.sortByParPrice}' == 'ASC'){
    		sortByParPrice.value="DESC";
    	}else{
    		sortByParPrice.value="ASC";
    	}
    	form_login.submit();
    }
	
	function salePriceSort(){
    	var form_login = commonForm();
    	form_login = getSelectedSeg(form_login);
    	var sortBySettlePrice = document.createElement("input");
    	sortBySettlePrice.type="hidden";
    	sortBySettlePrice.name="sortBySettlePrice";
    	form_login.appendChild(sortBySettlePrice);
    	if('${objSear.sortBySettlePrice}' == 'ASC'){
    		sortBySettlePrice.value="DESC";
    	}else{
    		sortBySettlePrice.value="ASC";
    	}
    	form_login.submit();
    }
	
	function departSeg(){
    	var form_login=commonForm();
    	var departTimeSelected = document.createElement("input");
    	departTimeSelected.type="hidden";
    	departTimeSelected.name="departTimeSelected";
    	departTimeSelected.value="true";
    	form_login.appendChild(departTimeSelected);

    	var departTimeSegInput = document.createElement("input");
    	departTimeSegInput.type="hidden";
    	departTimeSegInput.name="departTimeSeg";
    	form_login.appendChild(departTimeSegInput);
    	
    	var departTimeSeg = document.getElementById('departTimeSeg');
    	var departTimeSegShuffle = document.getElementById('departTimeSegShuffle');
    	
    	
    	var arriveTimeSegInput = document.createElement("input");
    	arriveTimeSegInput.type="hidden";
    	arriveTimeSegInput.name="arriveTimeSeg";
    	form_login.appendChild(arriveTimeSegInput);
    	
    	
    	var arriveTimeSeg = document.getElementById('arriveTimeSeg');
    	var arriveTimeSegShuffle = document.getElementById('arriveTimeSegShuffle');
    	
    	
    	var arriveTimeSelected = document.createElement("input");
    	arriveTimeSelected.type="hidden";
    	arriveTimeSelected.name="arriveTimeSelected";
    	arriveTimeSelected.value="true";
    	form_login.appendChild(arriveTimeSelected);

    	
    	var carrierCodeInput = document.createElement("input");
    	carrierCodeInput.type="hidden";
    	carrierCodeInput.name="airCompany";
    	form_login.appendChild(carrierCodeInput);
    	
    	var carrierCode = document.getElementById('carrierCode');
    	var carrierCodeShuffle = document.getElementById('carrierCodeShuffle');
    	
    	var carriesSelected = document.createElement("input");
    	carriesSelected.type="hidden";
    	carriesSelected.name="carriesSelected";
    	carriesSelected.value="true";
    	form_login.appendChild(carriesSelected);
    	
    	
    	var seatBandInput = document.createElement("input");
    	seatBandInput.type="hidden";
    	seatBandInput.name="seatBand";
    	form_login.appendChild(seatBandInput);
    	
    	var seatBand = document.getElementById('seatBand');
    	var seatBandShuffle = document.getElementById('seatBandShuffle');
    	
    	var seatClassSelected = document.createElement("input");
    	seatClassSelected.type="hidden";
    	seatClassSelected.name="seatClassSelected";
    	seatClassSelected.value="true";
    	form_login.appendChild(seatClassSelected);
    	
    	
    	if(document.getElementById("isHaveMeal").checked || document.getElementById("isHaveMealShuffle").checked){
    	    var meal = document.createElement("input");
    	    meal.type="hidden";
    	    meal.name="isMeals";
    	    meal.value="HAVE";
    	    form_login.appendChild(meal);
    	}
    	
    	if(document.getElementById("isDirect").checked || document.getElementById("isDirectShuffle").checked){
    	    var direct = document.createElement("input");
    	    direct.type="hidden";
    	    direct.name="isDirect";
    	    direct.value="DIRECT";
    	    form_login.appendChild(direct);
    	}
    	
    	$(":radio").each(function(){
		    if($(this).attr("checked")){
		    	if($(this).val() == 1){
		    		if(departTimeSeg.value != 'departSeg'){
		        		departTimeSegInput.value=departTimeSeg.value;
		        	}else{
		        		departTimeSegInput.value='';
		        		departTimeSelected.value="false";
		        	}
		    		
		    		if(arriveTimeSeg.value != 'arriveSeg'){
		        		arriveTimeSegInput.value=arriveTimeSeg.value;
		        	}else{
		        		arriveTimeSelected.value="false";
		        		arriveTimeSegInput.value='';
		        	}
		    			
		    		if(carrierCode.value != 'carrier'){
		    			carrierCodeInput.value=carrierCode.value;
		        	}else{
		        		carriesSelected.value="false";
		        		carrierCodeInput.value='';
		        	}
		    		
		    		if(seatBand.value != 'seatBand'){
		    			seatBandInput.value=seatBand.value;
		        	}else{
		        		seatClassSelected.value="false";
		        		seatBandInput.value='';
		        	}
				}else{
					if(departTimeSegShuffle.value != 'departSeg'){
						departTimeSegInput.value=departTimeSegShuffle.value;
			    	}else{
			    		departTimeSegInput.value='';
			    		departTimeSelected.value="false";
			    	}
					
					if(arriveTimeSegShuffle.value != 'arriveSeg'){
						alert(arriveTimeSegShuffle.value);
			    		arriveTimeSegInput.value=arriveTimeSegShuffle.value;
			    	}else{
			    		arriveTimeSegInput.value='';
			    		arriveTimeSelected.value="false";
			    	}
					
					if(carrierCodeShuffle.value != 'carrier'){
		    			carrierCodeInput.value=carrierCodeShuffle.value;
		        	}else{
		        		carriesSelected.value="false";
		        		carrierCodeInput.value='';
		        	}
					
					if(seatBandShuffle.value != 'seatBand'){
						seatBandInput.value=seatBandShuffle.value;
			    	}else{
			    		seatBandInput.value='';
			    		seatClassSelected.value="false";
			    	}
				}
		    	
		    }
		})
    	form_login.submit();
    }
</script>



<!-- 日历弹框 -->
<script type="text/javascript">
$(function(){
	//获取当前时间
    var date = new Date();
    //var date = new Date(2015,2,10);
    var set_num = 1; //计算能选择的实际天数
    var init_top = 1; //初始位移
    var index = 1; //打印的月数
    var click_num = 1;//点击切换计数
    var i_record = 0;//记录月份的30
    var year_record = 0;//记录年份的变化
    console.log(i_record);
    // 打印出一月日期，从当天开始
    function date_list(date){
        var date1 = new Date(date.getFullYear(),date.getMonth()+1,0);
            date2 = new Date(date.getFullYear(),date.getMonth(),1);
        for (var j = 0; j < date2.getDay(); j++) {
            $(".date_show .datelist .date_1").append("<div class='date_k'><div class='date_num'></div><div class='date_price'></div></div>");
        };
        var more_date = date2.getDay();
        for (var i = 1; i < 43-more_date;i++) {
            if(i>(date1.getDate())){ 
                $(".date_show .datelist .date_1").append("<div class='date_k'><div class='date_num'></div><div class='date_price'></div></div>");
            }else{
                if(i<date.getDate()){
                    $(".date_show .datelist .date_1").append("<div class='date_k'><div class='date_num'>"+i+"</div><div class='date_price'>--</div></div>");
                }else{
                    $(".date_show .datelist .date_1").append("<div class='date_k'><div class='date_num'>"+i+"</div><div class='date_price'><i>&yen;</i><span>350</span></div></div>");
                }
            }
        };
    }
    // 计算实际天数
    function date_num(){
        set_num = 0;
        $(".date_price").each(function(i,element){
            if($(element).text() != "--" && $(element).text() != ""){
                if(set_num>=31)
                    $(element).html("<span style='font-size:12px;color:#b4b4b4'>点击查看</span>");
                set_num++;
                //加手指
                $(element).css("cursor","pointer");
            }
            if($(element).text() == "--"){
                init_top++;
            }
        });
    }
    //初始化年月
    function init(date){
        date2 = new Date(date.getFullYear(),date.getMonth()+1,1);
        $(".month_show .month_dom_reduce .year").text((date.getFullYear())+"年");
        $(".month_show .month_dom_reduce .yue").text((date.getMonth()+1)+"月");
        if(parseInt($(".date_show .datelist .date_1").css("top")) == 0){
            $(".month_show .month_dom_add .year").text((date.getFullYear())+"年");
            $(".month_show .month_dom_add .yue").text((date.getMonth()+1)+"月");
        }else{
            $(".month_show .month_dom_add .year").text((date2.getFullYear())+"年");
            $(".month_show .month_dom_add .yue").text((date2.getMonth()+1)+"月");
        }
    }
    date_list(date);
    date_num();
    var init_back = Math.floor(init_top/7)*50; 
    $(".date_show .datelist .date_1").animate({"top":"-="+(Math.floor(init_top/7)*50)+"px"},0);
    init(date);
    //判断当月是否满30天，不满就再加一月
    function d_date(date){
        if(date.getMonth() == 11)
            var date2 = new Date(date.getFullYear()+1,date.getMonth()+1,1);
        var date2 = new Date(date.getFullYear(),date.getMonth()+1,1);
        date_list(date2);
        date_num();
        index ++;
        $(".date_show .datelist .date_1").css({"border-bottom":"3px solid #bdbdbd","box-sizing":"border-box","-webkit-box-sizing":"border-box","-moz-box-sizing":"border-box"});
        // console.log("set_num"+set_num);
        if(set_num<31)
            d_date(date2);
    }
    d_date(date);
    //记录初始300-top
    var p_num;
    $(".minus").click(function(){
        var num = Math.abs(parseInt($(".date_show .datelist .date_1").css("top")));
        // console.log("init_back  "+init_back);
        if(parseInt($(".date_show .datelist .date_1").css("top"))>-300){
            $(".month_dom_reduce .minus span").css("background-image","url(${request.contextPath}/images/up1.png)");
            // init(date);
            return;
        }
        if(num == 300){
            $(".date_show .datelist .date_1").animate({"top":"+="+(300-init_back)+"px"},100);
            $(".month_dom_add .plus span").css("background-image","url(${request.contextPath}/images/down2.png)");
            click_num--;
            // 显示单月时去掉年月信息
            $(".month_dom_reduce .year,.month_dom_reduce .yue").css("display","block");
            $(".month_dom_reduce .year,.month_dom_add .yue").css("display","block");
            $(".month_dom_reduce .year,.month_dom_add .year").css("display","block");
            init(date);
            if(init_back == 0){
                $(".month_show .month_dom_add .year").text((date.getFullYear())+"年");
                $(".month_show .month_dom_add .yue").text((date.getMonth()+1)+"月");
            }
        }
        else{
            $(".date_show .datelist .date_1").animate({"top":"+="+300+"px"},100);
            $(".month_dom_add .plus span").css("background-image","url(${request.contextPath}/images/down2.png)");
            click_num--;
            // 显示单月时去掉年月信息
            i_record--;
            console.log("i_record:  "+i_record);
            if(i_record <= 0){
                year_record--;
                i_record = 12;
                $(".month_show .month_dom_reduce .yue").text(i_record+"月");
                $(".month_show .month_dom_reduce .year").text((year_record)+"年");
            }else{
                $(".month_show .month_dom_reduce .year").text(year_record+"年");
                $(".month_show .month_dom_reduce .yue").text(i_record+"月");
            }
            $(".month_dom_add .year,.month_dom_add .yue").css("display","none");
            $(".month_dom_reduce .year,.month_dom_reduce .yue").css("display","block");
        }
    });

    $(".plus").click(function(){
        p_num = 300-Math.abs(parseInt($(".date_show .datelist .date_1").css("top")));
        if(click_num>=index){
            $(".month_dom_add .plus span").css("background-image","url(${request.contextPath}/images/down1.png)");
            return;
        }
        if(p_num%300 != 0){
            $(".date_show .datelist .date_1").animate({"top":"-="+p_num+"px"},100);
            $(".month_dom_reduce .minus span").css("background-image","url(${request.contextPath}/images/up2.png)");
            click_num++;
            // 显示单月时去掉年月信息
            $(".month_dom_reduce .year,.month_dom_reduce .yue").css("display","none");
            $(".month_dom_add .year,.month_dom_add .yue").css("display","block");
            
        }
        else{
            $(".date_show .datelist .date_1").animate({"top":"-="+300+"px"},100);
            $(".month_dom_reduce .minus span").css("background-image","url(${request.contextPath}/images/up2.png)");
            click_num++;
            // 显示单月时去掉年月信息
            i_record = parseInt($(".month_show .month_dom_add .yue").text());
            year_record = parseInt($(".month_show .month_dom_add .year").text());
            // console.log("i_record-add:  "+i_record);
            i_record++;
            if(i_record > 12){
                i_record = 1;
                year_record++;
                $(".month_show .month_dom_add .yue").text(i_record+"月");
                $(".month_show .month_dom_add .year").text((year_record)+"年");
            }else{
                $(".month_show .month_dom_add .year").text(year_record+"年");
                $(".month_show .month_dom_add .yue").text(i_record+"月");
            }
            $(".month_dom_reduce .year,.month_dom_reduce .yue").css("display","none");
            $(".month_dom_add .year,.month_dom_add .yue").css("display","block");
            
        }
    });

    // 添加内容
    function add_date(){
        var set_num1 = 0;
        var minPriceArray = getMinPriceArray();
        $(".date_price").each(function(i,element){
            if($(element).text() != "--" && $(element).text() != ""){
                if(set_num1>=31)
                    return false;
                $(element).children("span").text(minPriceArray[set_num1].minPrice);
                var form = "<form action='search' method='post'><input type='hidden' name='departCity' value='${objSear.departCity}'/>"+
             	"<input type='hidden' name='arriveCity' value='${objSear.arriveCity}'/>"+
             	"<input type='hidden' name='departDate' value='"+minPriceArray[set_num1].deptDate+"'/>"+
             	"<input type='hidden' name='doWay' value='${objSear.doWay}'/></form>";
             	$(element).append(form);
                set_num1++;
            }
        });
    }
    add_date();
    
    function getMinPriceArray(){
    	var minprices = new Array();
    	var i=0;
    	<#list flightMinPriceForms as priceForm>
    		var priceObj = new Object();
    		priceObj.minPrice='${priceForm.minPrice}';
    	    priceObj.deptDate='${priceForm.deptDate}';
    	    minprices[i++] = priceObj;
    	</#list>
    	return minprices;
    }

    $("body").on("click",".date_price",function(){
        if($(this).text() != "--" && $(this).text() != "")
            $(this).parent().siblings().removeClass("active")
            .end().addClass("active");
    })
    $("body").on("mouseover",".date_price",function(){
        if($(this).text() != "--" && $(this).text() != "")
            $(this).parent().siblings().removeClass("hover")
            .end().addClass("hover");
    })
    $("body").on("mouseout",".date_price",function(){
        if($(this).text() != "--" && $(this).text() != "")
            $(this).parent().removeClass("hover");
    })
    $("body").on("mouseover",".date_close",function(){
        $(".date_close").css("color","#FF7F2A");
    })
    $("body").on("mouseout",".date_close",function(){
        $(".date_close").css("color","#666666");
    })
    
    $('.date_k div').click(function(){
    	var form = $(this).children("form");
    	form.submit();
    })
})     
	function minPriceDate(){
		$(".date_bground").css("display","block");
	}
	
	function closeMinPriceWin(){
		$(".date_bground").css("display","none");
	}

</script>
</body>
</html>
