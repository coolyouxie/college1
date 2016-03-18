<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>核对订单-单程/真往返</title>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/css/area_tankuang.css">
    <link type="text/css" rel="stylesheet" href="${request.contextPath}/js/jquery-dialog/jquery-ui-1.8.9.custom.css" />
    <link rel="stylesheet" href="${request.contextPath}/css/style.css">
    <style type="text/css">
		.opBtn
		{
	    	display: inline;
	    	background: none repeat scroll 0 0 #ff8500;
	    	border: 0 none;
	    	color: #fff;
	    	height: 28px;
	    	line-height: 28px;
	    	margin-left: 10px;
	    	vertical-align: middle;
	    	width: 80px;
		}
    </style>
    <script type="text/javascript" src="${request.contextPath}/js/resources/jquery-1.7.1.min.js"></script>
    <script language="javascript" src="${request.contextPath}/js/jquery-dialog/jquery-ui-1.8.9.custom.min.js"></script>
    
<script type="text/javascript">
$(function() {
	$("#closeOpPay").click(function() {
		$("#showPayResult").css("display", "none");
	});

	$("#closeOpPay").click(function() {
		$("#showPayOperate").css("display", "none");
	});
})

// 支付结果关闭
function canclePayResult() {
	$("#showPayResult").css("display", "none");
	setTimeout("transferPage()",2000);
}

// 取消支付操作
function canclePayOperate() {
	$("#showPayOperate").css("display", "none");
}

// 关闭，支付失败窗口
function closePayFailInfo() {
	$("#showPayFailInfo").css("display", "none");
}



// 点击支付操作，去调用topay,根据类型判断是正常单，改签单
function applyToPay(payUrl) {
    var orderMainIdVal = $("#orderMainId").val();
	//var orderIdVal = $("#orderId").val(); 	orderId : orderIdVal,
	var orderNoVal = $("#orderNo").val();
	var orderNoObj = new Object();
	orderNoObj.orderNo = orderNoVal;
	
	
	$.ajax({
			url : payUrl,
			type : 'post',
			dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
				flightOrderNo : orderNoObj,
				orderMainId : orderMainIdVal
			}),
			success : function(data) {
				if (data.status != "" && data.status == "SUCCESS") {
					$("#paymentNoOperate").val(data.results[0].paymentNo);
					$("input[name='payType']:checked").val("");
					$("#paymentSerialNumber").val("");
					$("#payRemark").val("");
					$("#showPayOperate").css("display", "block");
				} else {
					$("#showPayOperate").css("display", "none");
	
					// 显示支付失败信息
					$("#payFailInfo span").html(data.message);
					$("#showPayFailInfo").css("display", "block");
	
				}
			},
			error : function(data) {
				// 显示支付失败信息
				$("#payFailInfo span").html(
						eval('(' + data.responseText + ')').message);
				$("#showPayFailInfo").css("display", "block");
	
			}
		});
    }

// 选择支付类型
function selectPayType() {
	var payTypeVal = $("input[name='payType']:checked").val();
	if (payTypeVal != "" && payTypeVal != "DUMMY" && payTypeVal != "CASH"
			&& payTypeVal != "OTHER") {
		$("#payOpNumber").css("display", "block");
	} else {
		$("#payOpNumber").css("display", "none");
	}
}

function transferPage(){
	window.location.href="${request.contextPath}/order/toOrderList/NULL";
}


// 支付回调
function payCallBack(payUrl) {
	var payTypeVal = $("input[name='payType']:checked").val();
	var payNumberVal = $.trim($("#paymentSerialNumber").val());
	var payRemarkVal = $.trim($("#payRemark").val());
	var paymentNoOperate = $.trim($("#paymentNoOperate").val());
	if (payTypeVal == "") {
		alert("请选择支付方式");
		return;
	}
	
	if (paymentNoOperate == "") {
		alert("支付单号为空请。检查！");
		return;
	}
	

	if (payNumberVal == "" && payTypeVal != "DUMMY" && payTypeVal != "CASH"
			&& payTypeVal != "OTHER") {
		alert("请填写支付流水号");
		return;
	}

	if (confirm("是否进行支付?")) {
		$.ajax({
			url : payUrl,
			type : 'post',
			dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
				paymentSerialNumber : payNumberVal,
				paymentType : payTypeVal,
				payRemark : payRemarkVal,
				paymentNo : paymentNoOperate
			}),
			success : function(data) {
				var tr = $("#payCloneTr");
				if (data.status != "" && data.status == "SUCCESS") {
					alert("支付成功");
					$("#showPayResult").css("display", "block");
					$("#showPayOperate").css("display", "none");
					
					$.each(data.results, function(index, item) {
						// 克隆tr，每次遍历都可以产生新的tr
						var clonedTr = tr.clone();
						var _index = index;

						// 循环遍历cloneTr的每一个td元素，并赋值
						clonedTr.children("td").each(function(inner_index) {
							// 根据索引为每一个td赋值
							switch (inner_index) {
							case (0)://支付订单号
								$(this).html(item.paymentNo);
								break;
							case (1)://交易流水号
								$(this).html(item.paymentSerialNumber);
								break;
							case (2)://支付方式
								$(this).html(item.paymentType);
								break;
							case (3)://交易金额
								$(this).html(item.payedAmount);
								break;
							case (4)://支付状态
								$(this).html(item.paymentStatus);
								break;
							case (5)://订单支付状态
								$(this).html(item.orderCallbackStatus);
								break;
							case (6)://交易时间
								$(this).html(item.payedTime);
								break;
							case (7)://对账流水号
								$(this).html(item.paymentSerialNumber);
								break;
							case (8)://订单号
								$(this).html(item.flightOrderNo.orderNo);
								break;
							}// end switch
						});// end children.each

						// 把克隆好的tr追加原来的tr后面
						clonedTr.insertAfter(tr);
					});// end $each
					$("#payCloneTr").hide();// 隐藏id=clone的tr，因为该tr中的td没有数据，不隐藏起来会在生成的table第一行显示一个空行
					$("#payTable").show();
					
				} else {
					// 显示支付失败信息
					$("#payFailInfo span").html(data.message);
					$("#showPayFailInfo").css("display", "block");
				}
			},
			error : function(data) {
				$("#showPayFailInfo").css("display", "block");
				$("#payFailInfo span").html(eval('(' + data.responseText + ')').message);
			}
		});
	}
}


</script>
    
</head>
<body>
 <div class="container icheckOrder">
     
	 <#list flightInfoVos as flightInfoVo>
     <#if flightInfoVo.flightTripType == "DEPARTURE">
	 <div class="top">
         <div class="nav">
            <a href=""> 首页</a>&nbsp;&gt;&nbsp;<a href="">航班查询</a>&nbsp;&gt;&nbsp;核对订单 (会员：${(orderCustomer.customerName)!''})
         </div>
         <div class="hint">航班价格变动频繁，请在&nbsp;<div>30分钟</div>内完成支付可确保您的机位和价格。</div>
         <div class="msg">
             <div class="title">航班信息（<#if flightInfoVo.routeType=='OW'>${flightInfoVo.routeTypeName}</#if><#if flightInfoVo.routeType=='RT'>${flightInfoVo.flightTripName}</#if>&nbsp;${(flightInfoVo.flightInfo.flightAirportLine.departureAirport.city.airportCity.name)!'出发城市主数据空'}&nbsp;-&nbsp;${(flightInfoVo.flightInfo.flightAirportLine.arrivalAirport.city.airportCity.name)!'到达城市主数据空'}:主订单号：<strong>${orderMain.flightOrderNo.orderNo}</strong>）</div>
             <table class="tab-1">
                 <tr>
                     <td><img src="/images/order/topxf.png"> ${(flightInfoVo.flightInfo.carrier.name)!'carriername为空'}&nbsp;<strong>${flightInfoVo.flightInfo.flightNo}</strong><div class="div-1">计划机型<span>：</span>${(flightInfoVo.flightInfo.airplane.code)!'飞机代码为空'}(${(flightInfoVo.flightInfo.airplane.airplaneType)!'机型为空'})</div></td>
                     <td class="td-2">${flightInfoVo.flightInfo.timeSegmentRange.departureTime?string("yyyy年MM月dd日")}</td>
                     <td><div class="div-2" style="width:200px;"><div style="float:left;">${flightInfoVo.flightInfo.timeSegmentRange.departureTime?string("HH:mm")}</div>
                      &nbsp;&nbsp;
                     —<i>
                     <#if flightInfoVo.stopCitys??>
	                     <#if (flightInfoVo.stopCitys?size>0) >
                                                        经停
                         <#else>
                                                       不经停
					     </#if>
					 </#if>   
                     </i>
                      —
                     &nbsp;&nbsp;
                     <div style="float:right;">${flightInfoVo.flightInfo.timeSegmentRange.arrivalTime?string("HH:mm")}<number>+${flightInfoVo.days}天</number></div> </div>
                     <div class="div-2" style="width:200px;"><div style="float:left;">${flightInfoVo.flightInfo.flightAirportLine.departureAirport.name}</div>
                      &nbsp;&nbsp;
                     <i>
                     <#if flightInfoVo.stopCitys??>
                       <#list flightInfoVo.stopCitys as city>
                       		${city}
                       </#list>
					 </#if>
                     </i>
                       &nbsp;&nbsp;
                    	<div style="float:right;;">${(flightInfoVo.flightInfo.flightAirportLine.arrivalAirport.name)!''}</div></div></td>
                    	<#list flightInfoVo.flightInfo.seats as seat>
						<td>${seat.seatClassName}${seat.seatClassCode}</td>
						</#list>
                     <td class="td-5">机建：&yen;
                        ${(flightInfoVo.departureOrderDetailVo.airportFee)!''}
                     &nbsp;+&nbsp;燃油：&yen;
                        ${(flightInfoVo.departureOrderDetailVo.fuelsurTax)!''}
                     </td>
                 </tr>
             </table>
             <div class="price">
                 <table cellpadding="0" cellspacing="0">
                     <tr><td>&nbsp;</td><td>票面价</td><td>机建费</td><td>燃油费</td><td>优惠价格</td><td>销售价</td><td>政策ID</td><td>供应商</td><td class="last-td">供应商政策ID</td></tr>
                  	  <#list flightInfoVo.departureOrderDetailVo.flightOrderDetailDtos as detail> 
                  	 	<tr>
							<td>${(detail.combinationDetail.passengerType.cnName)!''}</td>
							<td>${(detail.flightOrderTicketPrice.parPrice)!''}</td>
							<td>${(detail.combinationDetail.flightOrderFlightInfo.flightSeat.flightTicketPriceDto.airportFee)!''}</td>
							<td>${(detail.combinationDetail.flightOrderFlightInfo.flightSeat.flightTicketPriceDto.fuelsurTax)!''}</td>
							<td>${detail.flightOrderTicketPrice.promotion}</td>
							<td>${(detail.flightOrderTicketPrice.salesPrice)!''}</td>
						<td>[${(detail.combinationDetail.flightOrderFlightPolicy.flightPolicy.id)!''}]</td>
						<td>${(detail.combinationDetail.flightOrderFlightPolicy.supp.name)!''}</td>
						<td>[${(detail.combinationDetail.flightOrderFlightPolicy.suppPolicyNo)!''}]</td>
						</tr>
					 </#list>
				</table>
             </div>
             
             
             <div class="tab order-tab">
				<div class="tab-title">
		              <button class="btn1">成人<span>极</span></button>
	                  <button class="btn2">儿童<span>极</span></button>
		         </div>
				 <div id="singleWay" class="tab-cot">
				     <#list flightInfoVos as flightInfos>
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
             
             
             
         </div>
     </div>
     </#if>
     <input id="orderMainId" type="hidden" value="${orderMain.id}">
     
     <#if flightInfoVo.flightTripType == "RETURN">
	 <div class="top">
         <div class="msg">
              <div class="title">航班信息（${flightInfoVo.flightTripName}&nbsp;${(flightInfoVo.flightInfo.flightAirportLine.departureAirport.city.airportCity.name)!'出发城市主数据空'}&nbsp;-&nbsp;${(flightInfoVo.flightInfo.flightAirportLine.arrivalAirport.city.airportCity.name)!'到达城市主数据空'}）</div>
             <table class="tab-1">
                 <tr>
                     <td><img src="/images/order/topxf.png"> ${(flightInfoVo.flightInfo.carrier.name)!'carriername为空'}&nbsp;<strong>${flightInfoVo.flightInfo.flightNo}</strong><div class="div-1">计划机型<span>：</span>${(flightInfoVo.flightInfo.airplane.code)!'飞机代码为空'}(${(flightInfoVo.flightInfo.airplane.airplaneType)!'机型为空'})</div></td>
                     <td class="td-2">${flightInfoVo.flightInfo.timeSegmentRange.departureTime?string("yyyy年MM月dd日")}</td>
                     <td><div class="div-2" style="width:210px;"><div style="float:left;">${flightInfoVo.flightInfo.timeSegmentRange.departureTime?string("HH:mm")}</div>
                      &nbsp;&nbsp;
                     —<i>
                     <#if flightInfoVo.stopCitys??>
	                     <#if (flightInfoVo.stopCitys?size>0) >
                                                        经停
                         <#else>
                                                       不经停
					     </#if>
					 </#if>   
                     </i>
                      —
                     &nbsp;&nbsp;
                     <div style="float:right;">${flightInfoVo.flightInfo.timeSegmentRange.arrivalTime?string("HH:mm")}<number>+${flightInfoVo.days}天</number></div> </div>
                     <div class="div-2" style="width:210px;"><div style="float:left;">${flightInfoVo.flightInfo.flightAirportLine.departureAirport.name}${flightInfoVo.flightInfo.flightAirportLine.departureTermainalBuilding.code}</div>
                      &nbsp;&nbsp;
                     <i>
                     <#if flightInfoVo.stopCitys??>
                       <#list flightInfoVo.stopCitys as city>
                       		${city}
                       </#list>
					 </#if>
                     </i>
                       &nbsp;&nbsp;
                    	<div style="float:right;;">${(flightInfoVo.flightInfo.flightAirportLine.arrivalAirport.name)!''}${(flightInfoVo.flightInfo.flightAirportLine.arrivalTerminalBuilding.code)!''}</div></div></td>
                    	<#list flightInfoVo.flightInfo.seats as seat>
						<td>${seat.seatClassName}${seat.seatClassCode}</td>
						</#list>
                     <td class="td-5">机建：&yen;
                        ${(flightInfoVo.returnOrderDetailVo.airportFee)!''}
                     &nbsp;+&nbsp;燃油：&yen;
                        ${(flightInfoVo.returnOrderDetailVo.fuelsurTax)!''}
                     </td>
                     </td>
                </tr>
			</table>
             <div class="price">
                 <table cellpadding="0" cellspacing="0">
                     <tr><td>&nbsp;</td><td>票面价</td><td>机建费</td><td>燃油费</td><td>优惠价格</td><td>销售价</td><td>政策ID</td><td>供应商</td><td class="last-td">供应商政策ID</td></tr>
                  	 <#list flightInfoVo.returnOrderDetailVo.flightOrderDetailDtos as detail> 
                  	 	<tr>
							<td>${(detail.combinationDetail.passengerType.cnName)!''}</td>
							<td>${(detail.flightOrderTicketPrice.parPrice)!''}</td> 
							<td>${(detail.combinationDetail.flightOrderFlightInfo.flightSeat.flightTicketPriceDto.airportFee)!''}</td>
							<td>${(detail.combinationDetail.flightOrderFlightInfo.flightSeat.flightTicketPriceDto.fuelsurTax)!''}</td>
							<td>${detail.flightOrderTicketPrice.promotion}</td>
							<td>${(detail.flightOrderTicketPrice.salesPrice)!''}</td>
						<td>[${(detail.combinationDetail.flightOrderFlightPolicy.flightPolicy.id)!''}]</td>
						<td>${(detail.combinationDetail.flightOrderFlightPolicy.supp.name)!''}</td>
						<td>[${(detail.combinationDetail.flightOrderFlightPolicy.suppPolicyNo)!''}]</td>
						</tr>
					 </#list>
				</table>
             </div>
             <div class="tab order-tab">
                 <div class="tab-title">
                 	  <button class="btn1">成人<span>极</span></button>
	                  <button class="btn2">儿童<span>极</span></button>
                 </div>
                 <div id="returnTrip" class="tab-cot">
                   <#list flightInfoVos as flightInfos>
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

         </div>
     </div>
     </#if>
    </#list>
    
    
     <div class="passenger-list">
         <div class="title">乘客</div>
       <table>
				<tr>
					<td>PNR</td>
					<td>乘客类型</td>
					<td>姓名</td>
					<td>证件类型</td>
					<td>证件号码</td>
					<td>出生日期</td>
					<td>手机号码</td>
				</tr>
				<#list details as detail>
				<tr>
					<td>${(detail.flightOrderPNRInfo.pnr)!''}</td>
					<td>
					<#if detail.flightOrderPassenger.passengerType == "ADULT">成人
						</#if>
					<#if detail.flightOrderPassenger.passengerType == "CHILDREN">儿童
						</#if>
					</td>
					<td>${detail.flightOrderPassenger.passengerName}&nbsp;</td>
					<td>
					<#if detail.flightOrderPassenger.passengerIDCardType == "ID">身份证
						</#if>
					<#if detail.flightOrderPassenger.passengerIDCardType == "PASSPORT">护照
						</#if>
					<#if detail.flightOrderPassenger.passengerIDCardType == "OFFICER">军官证
						</#if>
					<#if detail.flightOrderPassenger.passengerIDCardType == "SOLDIER">士兵证
						</#if>
					<#if detail.flightOrderPassenger.passengerIDCardType == "TAIBAO">台胞证
						</#if>
					<#if detail.flightOrderPassenger.passengerIDCardType == "OTHER">其他
						</#if>
					</td>
					<td>${detail.flightOrderPassenger.passengerIDCardNo}&nbsp;</td>
					<td>${detail.flightOrderPassenger.passengerBirthday?date}&nbsp;</td>
					<td>${detail.flightOrderPassenger.cellphone}&nbsp;</td>
				</tr>

				</#list>
				
				
			</table>
     </div>
     <#if (flightOrderPassengers?size > 0)>
      <div class="passenger-list">
         <div class="title">保险</div>
         <table>
				<tr>	
					<td>投保人</td>
					<td>险种</td>
					<td>份数</td>
				</tr>
				<#list flightOrderPassengers as flightOrderPassenger>
			   		<#if flightOrderPassenger.flightOrderInsurances??>
            	 		<#list flightOrderPassenger.flightOrderInsurances as flightOrderInsurance>
		            		<tr>
			            		<td>${(flightOrderPassenger.passengerName)!''}</td>
			            		<td>${(flightOrderInsurance.insuranceClass.name)!''}</td>
			            		<td>1</td>
		            		</tr>
	             		</#list>
	           		</#if>  
               </#list>
         </table>
     </div>
     </#if>
     
     <div class="passenger-list">
		<div class="title">联系人 </div>
     		<table>
				<tr>	
					<td>联系人</td>
					<td>联系手机</td>
					<td>电子邮件</td>
					<td>操作</td>
				</tr>
				<tr>
					<td>
						<span id="contacterNameSpan">${(flightOrderContacter.name)!''}</span>
					</td>
					<td>
						<span id="contacterCellphoneSpan">${(flightOrderContacter.cellphone)!''}</span>
					</td>
					<td>
						<span id="contacterEmailSpan">${(flightOrderContacter.email)!''}</span>
					</td>
					<td>
						<button class="opBtn" onclick="openContacterInfoDialog()">修改</button>
					</td>
				</tr>
     		</table>
 		</div>
		<div id="contacterInfoDialog" style="display:none;">
			<table>
				<tr height="35">	
					<td align="right">联系人：</td>
					<td>
						<input type="text" id="contacterNameInput" />
					</td>
				</tr>
				<tr height="35">	
					<td align="right">联系手机：</td>
					<td>
						<input type="text" id="contacterCellphoneInput" maxlength="11" onkeyup="value=value.replace(/[^\d]/g,'')"
							onchange="value=value.replace(/[^\d]/g,'')"/>
					</td>
				</tr>
				<tr height="35">	
					<td align="right">电子邮件：</td>
					<td>
						<input type="text" id="contacterEmailInput" />
					</td>
				</tr>
				<tr height="35">
					<td colspan="2" align="center">
						<button class="opBtn" onclick="saveContacterInfo()">保存</button>
					</td>
				</tr>
			</table>
		</div>
     		
		<div class="passenger-list"> 
			<div class="title">配送信息</div>
			 <ul>
			    <#if flightOrderExpress?exists>
			       <li>配送方式：邮寄</li>
			       <li>配送地址：
				       <span id="expressAddressSpan" >${(flightOrderExpress.address)!''}</span> 
				       (<span id="expressRecipientSpan">${(flightOrderExpress.recipient)!''}</span>)
				       <span id="expressCellphoneSpan">${(flightOrderExpress.cellphone)!''}</span>  
				       <span id="expressTelephoneSpan">${(flightOrderExpress.telephone)!''}</span>
				       <span id="expressPostCodeSpan">${(flightOrderExpress.postCode)!''}</span>      
				       <button class="opBtn" onclick="openExpressInfoDialog()">修改</button>
			       </li>
			     <#else>
			          <li>无</li>
			    </#if>
			 </ul>
			 </div>
			 
			<div id="expressInfoDialog" style="display:none">
				<table>
					<tr height="35">	
						<td align="right">地址：</td>
						<td>
							<input type="text" id="expressAddressInput" />
						</td>
					</tr>	
					<tr height="35">
						<td align="right">收件人：</td>
						<td>
							<input type="text" id="expressRecipientInput"/>
						</td>
					</tr>
					<tr height="35">
						<td align="right">联系方式：</td>
						<td>
							<input type="text" id="expressCellphoneInput" maxlength="11" onkeyup="value=value.replace(/[^\d]/g,'')"
							onchange="value=value.replace(/[^\d]/g,'')" />
						</td>
					</tr>
					<tr height="35">	
						<td align="right">固定电话：</td>
						<td>
							<input type="text" id="expressTelephoneInput"/>
						</td>
					</tr>
					<tr height="35">	
						<td align="right">邮政编码：</td>
						<td>
							<input type="text" id="expressPostCodeInput" onkeyup="value=value.replace(/[^\d]/g,'')"
								onchange="value=value.replace(/[^\d]/g,'')" maxlength="6"/>
						</td>
					</tr>
					<tr height="35">
						<td colspan="2" align="center">
							<button class="opBtn" onclick="saveExpressInfo()">保存</button>
						</td>
					</tr>
			 	</table>
			</div>
     
     <div class="detail">
         <table class="tab-detail" >
             <tr class="tr-1"><td>&nbsp;</td><td>票面价</td><td>-&nbsp;调控金额</td><td>+&nbsp;机建</td><td>+&nbsp;燃油</td><td>+&nbsp;保险</td><td>+&nbsp;附加费</td><td>+&nbsp;快递费</td><td rowspan="5" class="last-td">应收合计：<span>&yen;${amountCalculatorDto.orderPrepaidAmount}</span><button id="orderCancelButtonId" class="btn3">取消订单</button></td></tr>
             <#list pssTypeAmounts as pssTypeAmount>
             <tr><td class="td-1"><#if pssTypeAmount.passengerType == 'ADULT'>成人</#if><#if pssTypeAmount.passengerType == 'CHILDREN'>儿童</#if>&times;${pssTypeAmount.passengerCount}人</td><td>${pssTypeAmount.totalParpriceAmount}/人</td><td>${pssTypeAmount.totalOrderDiscountAmount}/人</td><td>${pssTypeAmount.totalAirportFeeAmount}</td><td>${pssTypeAmount.totalFuelsurTaxAmount}</td><td>${pssTypeAmount.totalInsuranceAmount}</td><td>&nbsp;</td><td>&nbsp;</td></tr>
             </#list>
             <tr class="tr-2"><td>&nbsp;</td><td>${amountCalculatorDto.orderTicketAmount}</td><td>${amountCalculatorDto.orderDiscountTotalAmount}</td><td>${amountCalculatorDto.orderAirportTaxAmount}</td><td>${amountCalculatorDto.orderFuelTaxAmount}</td><td>${amountCalculatorDto.orderInsuranceAmount}</td><td>${amountCalculatorDto.orderPlusAmount}</td><td>${amountCalculatorDto.orderExpressAmount}</td></tr>
         </table>
     </div>
 </div>
 
      <div class="office" id="showPayOperate" style="align:center;top:300px;dispaly:none;border:1px solid #e6e6e6;">
			<div class="o_title">
				订单支付<span class="o_close op" id="closeOpPay">X</span>	
			</div>
			<div class="o_content" id="payMentValue" style="top:10px;font-size:18px;">
	                              订单金额: RMB <span style="color:red;">
	          ${amountCalculatorDto.orderPrepaidAmount}</span>元
	        </div>					
			<div class="bottoms" style="padding:10px; width: 100%; overflow: hidden;">
				<div class="choose moveright" style="padding-left: 5%;float: left;line-height:30px;">
					<input type="radio" name="payType" id="reason2" value="YEE" onclick="selectPayType()" /> <label for="reason2">易宝电话支付</label>
					<input type="radio" name="payType" id="reason1" value="HUNDRED" onclick="selectPayType()"/><label for="reason1">百付电话支付</label>
					<input type="radio" name="payType" id="reason2" value="OFFLINE_CARD" onclick="selectPayType()" /> <label for="reason2">线下拉卡支付</label>
				 </div>
				<div class="choose" style="padding-left: 5%;float: left;line-height:30px;">
				    <input type="radio" name="payType" id="reason3" value="POS" onclick="selectPayType()" /> <label for="reason3">POS机支付</label>
                    <input type="radio" name="payType" id="reason4" value="KENDRION" onclick="selectPayType()" /> <label for="reason4">彬德POS机支付</label>
				    <input type="radio" name="payType" id="reason5" value="CASH" onclick="selectPayType()" /> <label for="reason5">现金支付</label>
					
				</div>
				<div class="choose" style="padding-left: 5%;float: left;line-height:30px;">
				    <input type="radio" name="payType" id="reason6" value="DUMMY" onclick="selectPayType()" /> <label for="reason6">虚拟支付</label>
                    <input type="radio" name="payType" id="reason7" value="OTHER" onclick="selectPayType()" /> <label for="reason7">其他支付</label>
				</div>
			</div>
			<div class="o_content" id="payOpNumber" style="text-align:left;" >
				*交易流水号：<input type="text" name="paymentSerialNumber" id="paymentSerialNumber" style="height: 25px;" />
			</div>
			<div class="o_remark">
				<span>备注：</span><textarea name="payRemark" rows="4" cols="20" id="payRemark" placeholder="订单支付备注" ></textarea>
			</div>
			<div class="o_submit">
				<a href="#"><span class="sure" onclick="payCallBack('${request.contextPath}/order/orderPayCallbackAjax')">支付</span></a>
				<a id="cancleId" href="#"><span class="cancle" onclick="canclePayOperate()">取消</span></a>
			</div>
		</div>
		
		
		
		
		<!--显示支付结果信息-->
	  <div class="pay" id="showPayResult" style="align:center;top:300px; border:1px solid #e6e6e6;dispaly:none;">
			<div class="o_title">
				订单支付结果<span class="o_close" id="closeRePay" >X</span>	
			</div>
			
			<table id="payTable" style ="border=2; display: block;">  
	            <thead>  
	                <tr>  
	                    <th style='width:10%;'>支付订单号</th>  
	                    <th style='width:10%;'>交易流水号</th>
	                    <th style='width:10%;'>支付方式</th>
	                    <th style='width:10%;'>交易金额</th>
	                    <th style='width:10%;'>支付状态</th>
	                    <th style='width:10%;'>订单支付状态</th>
	   		            <th style='width:10%;'>交易时间</th>
	                    <th style='width:10%;'>对账流水号</th>
	                    <th style='width:10%;'>订单号</th>
	                    <th style='width:10%;'>引用订单号</th>
	                </tr>  
	            </thead>  
	            <tbody>  
	                <tr id="payCloneTr">  
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>
	               	   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>
	                 </tr>  
	             </tbody>  
		 	</table> 
			<div class="o_submit">
				<a href="javascript:void(0);"><span class="cancle" onclick="canclePayResult()">关闭</span></a>
			</div>
		</div>
		
 

		<!--显示支付失败信息-->
		<div class="office" id="showPayFailInfo" style="align:center;top:300px;dispaly:none;border:1px solid #e6e6e6;">
			<div class="o_title">
				支付失败信息<span class="o_close" id="closeRePay" >X</span>	
			</div>
			
			<div class="o_content"" id="payFailInfo" style="top:10px;font-size:25px;text-align:center;"">
	            <span style="color:red;padding-left:20px;"></span>
	        </div>
	        
	        <div class="o_submit">
				<a href="javascript:void(0);"><span class="cancle" onclick="closePayFailInfo()">关闭</span></a>
			</div>
			
		</div>
		
		
		<input type="hidden" name="paymentNoOperate" id="paymentNoOperate" /> 
	    <input type="hidden" name="payAmountOperate" id="payAmountOperate" />

	    <input type="hidden" name="payOperUrl" id="payOperUrl" />
		<input type="hidden" name="payNoShow" id="payNoShow" /> 
	    <input type="hidden" name="payAmountShow" id="payAmountShow" />
	    <input type="hidden" name="payNumberShow" id="payNumberShow" />
	    <input type="hidden" name="payResultShow" id="payResultShow" />
</body>

<script type="text/javascript">
	
    /*tab切换*/
    $(".order-tab").each(function(i,obj){
        $(obj).find("button").on("click",function(){
            $(obj).find(".withdraw").css("display","none");
            $(obj).find(".withdraw").eq($(this).index()).css("display","block");
            return false;
        });
    });	
	
$(function(){
 	//initTiketRules();
});	

	
function initTiketRules(){
	
    <#list flightInfoVos as flightInfos>
	var m = 0;
	var n = 0;
	var childHeadTd = "";
	var auditHeadTd = "";
	<#list flightInfos.ticketRuleForms as ticketRuleForm>
		<#list ticketRuleForm.heads as head>
			<#if ticketRuleForm.passengerType == 'ADULT'>
				auditHeadTd = auditHeadTd+"<td class='last-td'>"+ '${head}'+"</td>";
			</#if>
			<#if ticketRuleForm.passengerType == 'CHILDREN'>
				childHeadTd = childHeadTd+"<td class='last-td'>"+ '${head}'+"</td>";
			</#if>
		</#list>
	</#list>
	
	if(auditHeadTd != ""){
		m++;
	}
	if(childHeadTd != ""){
		n++;
	}
	
	var auditVtTd = "";
	var childVtTd = "";
	<#list flightInfos.ticketRuleForms as ticketRuleForm>
		<#list ticketRuleForm.vts as vt>
			<#if ticketRuleForm.passengerType == 'ADULT'>
				if('${vt}' == ''){
					auditVtTd = auditVtTd+"<td class='last-td'>&yen;"+ '${vt}'+"</td>";
				}else{
					auditVtTd = auditVtTd+"<td class='last-td'>&yen;"+ '${vt}'+"</td>";
				}
			</#if>
			<#if ticketRuleForm.passengerType == 'CHILDREN'>
				if('${vt}' == ''){
					childVtTd = childVtTd+"<td class='last-td'>&yen;"+ '${vt}'+"</td>";
				}else{
					childVtTd = childVtTd+"<td class='last-td'>&yen;"+ '${vt}'+"</td>";
				}
			</#if>
		</#list>
	</#list>
	if(auditVtTd != ""){
		m++;
	}
	if(childVtTd != ""){
		n++;
	}
	
	var auditRtTd = "";
	var childRtTd = "";
	<#list flightInfos.ticketRuleForms as ticketRuleForm>
		<#list ticketRuleForm.rts as rt>
			<#if ticketRuleForm.passengerType == 'ADULT'>
				if('${rt}' == ''){
					auditRtTd = auditRtTd+"<td class='last-td'>"+ '${rt}'+"</td>";
				}else{
					auditRtTd = auditRtTd+"<td class='last-td'>&yen;"+ '${rt}'+"</td>";
				}
			</#if>
			<#if ticketRuleForm.passengerType == 'CHILDREN'>
				if('${rt}' == ''){
					childRtTd = childRtTd+"<td class='last-td'>"+ '${rt}'+"</td>";
				}else{
					childRtTd = childRtTd+"<td class='last-td'>&yen;"+ '${rt}'+"</td>";
				}
			</#if>
		</#list>
	</#list>
	if(auditRtTd != ""){
		m++;
	}
	if(childRtTd != ""){
		n++;
	}
	
	var auditCtTd = "";
	var childCtTd = "";
	<#list flightInfos.ticketRuleForms as ticketRuleForm>
		<#list ticketRuleForm.cts as ct>
			<#if ticketRuleForm.passengerType == 'ADULT'>
				if('${ct}' == ''){
					auditCtTd = auditCtTd+"<td class='last-td'>"+ '${ct}'+"</td>";
				}else{
					auditCtTd = auditCtTd+"<td class='last-td'>&yen;"+ '${ct}'+"</td>";
				}
			</#if>
			<#if ticketRuleForm.passengerType == 'CHILDREN'>
				if('${ct}' == ''){
					childCtTd = childCtTd+"<td class='last-td'>"+ '${ct}'+"</td>";
				}else{
					childCtTd = childCtTd+"<td class='last-td'>&yen;"+ '${ct}'+"</td>";
				}
			</#if>
		</#list>
	</#list>
	if(auditCtTd != ""){
		m++;
	}
	if(childCtTd != ""){
		n++;
	}
	
	var auditMtTd = "";
	var childMtTd = "";
	<#list flightInfos.ticketRuleForms as ticketRuleForm>
		<#list ticketRuleForm.mts as mt>
		<#if ticketRuleForm.passengerType == 'ADULT'>
			if('${mt}' == ''){
				auditMtTd = auditMtTd+"<td class='last-td'>"+ '${mt}'+"</td>";
			}else{
				auditMtTd = auditMtTd+"<td class='last-td'>&yen;"+ '${mt}'+"</td>";
			}
		</#if>
		<#if ticketRuleForm.passengerType == 'CHILDREN'>
			if('${mt}' == ''){
				childMtTd = childMtTd+"<td class='last-td'>"+ '${mt}'+"</td>";
			}else{
				childMtTd = childMtTd+"<td class='last-td'>&yen;"+ '${mt}'+"</td>";
			}
		</#if>
		</#list>
	</#list>
	if(auditMtTd != ""){
		m++;
	}
	if(childMtTd != ""){
		n++;
	}
	
	var auditTicketDesc = "";
	var childTicketDesc = "";
	<#list flightInfos.ticketRuleForms as ticketRuleForm>
		<#list ticketRuleForm.ticketRuleDesc as desc>
		<#if ticketRuleForm.passengerType == 'ADULT'>
			if('${desc}' == ''){
				auditTicketDesc = auditTicketDesc+"<td class='last-td'>"+ '${desc}'+"</td>";
			}else{
				auditTicketDesc = auditTicketDesc+"<td colspan='2' class='last-td'>"+ '${desc}'+"</td>";
			}
		</#if>
		<#if ticketRuleForm.passengerType == 'CHILDREN'>
			if('${desc}' == ''){
				childTicketDesc = childTicketDesc+"<td class='last-td'>"+ '${desc}'+"</td>";
			}else{
				childTicketDesc = childTicketDesc+"<td colspan='2' class='last-td'>"+ '${desc}'+"</td>";
			}
		</#if>
		</#list>
	</#list>
	if(auditTicketDesc != ""){
		m++;
	}
	if(childTicketDesc != ""){
		n++;
	}
	
	var auditRtType = "";
	var childRtType = "";
	<#list flightInfos.ticketRuleForms as ticketRuleForm>
		<#assign rts=ticketRuleForm.rts>
		<#if (rts?size>0)>
			<#if ticketRuleForm.passengerType == 'ADULT'>
			auditRtType = "<tr>"+"<td>退票费</td>"+auditRtTd+"</tr>";
			</#if>
			<#if ticketRuleForm.passengerType == 'CHILDREN'>
			childRtType = "<tr>"+"<td>退票费</td>"+childRtTd+"</tr>";
			</#if>
		</#if>
	</#list>
	
	var auditCtType = "";
	var childCtType = "";
	<#list flightInfos.ticketRuleForms as ticketRuleForm>
		<#assign cts=ticketRuleForm.cts>
		<#if (cts?size>0)>
			<#if ticketRuleForm.passengerType == 'ADULT'>
			auditCtType = "<tr>"+"<td>改期费</td>"+auditCtTd+"</tr>";
			</#if>
			<#if ticketRuleForm.passengerType == 'CHILDREN'>
			childCtType = "<tr>"+"<td>改期费</td>"+childCtTd+"</tr>";
			</#if>
		</#if>
	</#list>
	
	var auditMtType = "";
	var childMtType = "";
	<#list flightInfos.ticketRuleForms as ticketRuleForm>
		<#assign mts=ticketRuleForm.mts>
		<#if (mts?size>0)>
			<#if ticketRuleForm.passengerType == 'ADULT'>
			auditMtType = "<tr>"+"<td>签转费</td>"+auditMtTd+"</tr>";
			</#if>
			<#if ticketRuleForm.passengerType == 'CHILDREN'>
			childMtType = "<tr>"+"<td>签转费</td>"+childMtTd+"</tr>";
			</#if>
		</#if>
	</#list>
	
	var auditDescType = "";
	var childDescType = "";
	<#list flightInfos.ticketRuleForms as ticketRuleForm>
		<#assign descs=ticketRuleForm.ticketRuleDesc>
		<#if (descs?size>0)>
			<#if ticketRuleForm.passengerType == 'ADULT'>
			auditDescType = "<tr>"+"<td>退改详情</td>"+auditTicketDesc+"</tr>";
			</#if>
			<#if ticketRuleForm.passengerType == 'CHILDREN'>
			childDescType = "<tr>"+"<td>退改详情</td>"+childTicketDesc+"</tr>";
			</#if>
		</#if>
	</#list>
	
	var auditDiv = '<table class="withdraw"><tr><td rowspan="'+m+'" width="24px">成<br/>人<br/>票</td>'+
	'<td></td>'+auditHeadTd+'</tr>'+auditRtType+auditCtType+auditMtType+auditDescType+'</table>';
	var childDiv = '<table class="withdraw"><tr><td rowspan="'+n+'" width="24px">儿<br/>童<br/>票</td>'+
	'<td></td>'+childHeadTd+'</tr>'+childRtType+childCtType+childMtType+childDescType+'</table>';
	
	<#if flightInfos.flightTripType == "DEPARTURE">
	$('#singleWay').css('display','block');
	$('#singleWay').append(auditDiv);
	$('#singleWay').append(childDiv);
	<#else>
	$('#returnTrip').css('display','block');
	$('#returnTrip').append(auditDiv);
	$('#returnTrip').append(childDiv);
	</#if>
	</#list>
}


//订单取消
$('#orderCancelButtonId').click(function(){
		var data = $('#orderCancelButtonId').attr('data');
		if(data == '1'){
			alert("订单已取消,请做后续处理!");
			return;
		}
		if($("#orderCancelButtonId").css('cursor') == 'no-drop'){
			  return;
		}
		
		$("#orderCancelButtonId").css('cursor', 'no-drop');
		
		$.ajax({
			url : '${request.contextPath}/order/cancelOrderAjax',
			cache : false,
			type : 'post',
			dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
				orderMainId : '${orderMain.id}'
			}),
			success : function(data) {
				if (data != "" && data.status == "SUCCESS") {
					alert("订单取消成功！");
					window.location.href="${request.contextPath}/loginUser/newLogin";
					$("#orderCancelButtonId").css('cursor', 'pointer');
					$('#orderCancelButtonId').attr('data', '1');
				} else {
					alert("订单取消失败,请验证信息后继续操作！");
				}
			}
		});
	})
	
	//打开修改联系人信息Dialog
	function openContacterInfoDialog()
	{
		var contacterName = $.trim($('#contacterNameSpan').text());
		var contacterCellphone = $.trim($('#contacterCellphoneSpan').text());
		var contacterEmail = $.trim($('#contacterEmailSpan').text());
		
		$('#contacterNameInput').attr('value', contacterName);
		$('#contacterCellphoneInput').attr('value', contacterCellphone);
		$('#contacterEmailInput').attr('value', contacterEmail);
		
		$('#contacterInfoDialog').dialog({
		    title:'联系人信息-修改',
		    width:300,
			height:180,
			modal:'true'
		});
	}
	
	//保存联系人信息
	function saveContacterInfo()
	{
		var contacterName = $.trim($('#contacterNameInput').val());
		var contacterCellphone = $.trim($('#contacterCellphoneInput').val());
		var contacterEmail = $.trim($('#contacterEmailInput').val());
		var cellphoneReg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
		var emailReg = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
		
		if(contacterName.length == 0)
		{
			alert('联系人姓名不能为空！');
			return;
		}
		if(contacterCellphone.length == 0)
		{
			alert('联系人手机不能为空！');
			return;
		}
		if(!cellphoneReg.test(contacterCellphone))
		{
			alert('联系人手机格式不正确！');
			return;
		}
		if(contacterEmail.length > 0 && !emailReg.test(contacterEmail))
		{
			alert('邮箱格式不正确！');
			return;
		}
		
		$.ajax({
			url:'${request.contextPath}/order/modify/contacter',
			type:'POST',
			contentType:'application/json;',
			data:JSON.stringify({
				flightOrderContacterDto:
				{
					name:contacterName,
					cellphone:contacterCellphone,
					email:contacterEmail
				},
				orderMainId:'${orderMain.id}'	
			}),
			dataType:'json',
			success:function(data)
			{
				if(data.status == 'SUCCESS')
				{
					alert('联系人信息修改成功！');
					$('#contacterNameSpan').text(contacterName);
					$('#contacterCellphoneSpan').text(contacterCellphone);
					$('#contacterEmailSpan').text(contacterEmail);
					$('#contacterInfoDialog').dialog('close');
				}
				else
				{
					alert('联系人信息修改失败！');
				}
			},
			error:function(data)
			{
				alert('系统异常！');
			}
		});
	}
	
	//打开修改快递信息Dialog
	function openExpressInfoDialog()
	{
		var expressAddress = $.trim($('#expressAddressSpan').text());
		var expressRecipient = $.trim($('#expressRecipientSpan').text());
		var expressCellphone = $.trim($('#expressCellphoneSpan').text());
		var expressTelephone = $.trim($('#expressTelephoneSpan').text());
		var expressPostCode = $.trim($('#expressPostCodeSpan').text());
		
		$('#expressAddressInput').attr('value', expressAddress);
		$('#expressRecipientInput').attr('value', expressRecipient);
		$('#expressCellphoneInput').attr('value', expressCellphone);
		$('#expressTelephoneInput').attr('value', expressTelephone);
		$('#expressPostCodeInput').attr('value', expressPostCode);
		
		$('#expressInfoDialog').dialog({
		    title:'快递信息-修改',
		    width:300,
			height:260,
			modal:'true'
		});
	}
	
	//保存快递信息
	function saveExpressInfo()
	{
		var expressAddress = $.trim($('#expressAddressInput').val());
		var expressRecipient = $.trim($('#expressRecipientInput').val());
		var expressCellphone = $.trim($('#expressCellphoneInput').val());
		var expressTelephone = $.trim($('#expressTelephoneInput').val());
		var expressPostCode = $.trim($('#expressPostCodeInput').val());
		var cellphoneReg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
		var postCodeReg = /^[0-9]{6}$/;
		
		if(expressAddress.length == 0)
		{
			alert('快递地址不能为空！');
			return;
		}
		if(expressRecipient.length == 0)
		{
			alert('收件人不能为空！');
			return;
		}
		if(expressCellphone.length == 0 && expressTelephone.length == 0)
		{
			alert('请填写手机号码或固定电话中的一项！');
			return;
		}
		if(expressCellphone.length > 0 && !cellphoneReg.test(expressCellphone))
		{
			alert('手机号码格式不正确！');
			return;
		}
		if(expressPostCode.length == 0)
		{
			alert('邮政编码不能为空！');
			return;
		}
		if(!postCodeReg.test(expressPostCode))
		{
			alert('邮政编码格式不正确！');
			return;
		}
		
		$.ajax({
			url:'${request.contextPath}/order/modify/express',
			type:'POST',
			contentType:'application/json;',
			data:JSON.stringify({
				flightOrderExpressDto:
				{
					id:'${(flightOrderExpress.id)!''}',
					address:expressAddress,
					recipient:expressRecipient,
					cellphone:expressCellphone,
					telephone:expressTelephone,
					postCode:expressPostCode
				}
			}),
			dataType:'json',
			success:function(data)
			{
				if(data.status == 'SUCCESS')
				{
					alert('快递信息修改成功！');
					$('#expressAddressSpan').text(expressAddress);
					$('#expressRecipientSpan').text(expressRecipient);
					$('#expressCellphoneSpan').text(expressCellphone);
					$('#expressTelephoneSpan').text(expressTelephone);
					$('#expressPostCodeSpan').text(expressPostCode);
					$('#expressInfoDialog').dialog('close');
				}
				else
				{
					alert('快递信息修改失败！');
				}
			},
			error:function(data)
			{
				alert('系统异常！');
			}
		});
	}	
</script>

</html>