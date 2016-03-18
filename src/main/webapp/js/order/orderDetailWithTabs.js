var bookingSource = "";
Date.prototype.format = function(format) {
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds()
	};
	if (/(y+)/.test(format))
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
	return format;
};


function unbindOrder(){
	var orderMainNo = $("#orderMainNo").val();
	var vstFlightOrderId = $("#vstFlightOrderId").val();
	var vstOrderMainId = $("#vstOrderMainId").val();
	var vstOrderForm = {
			"vstOrderRequest":{
				"flightOrderVstDto":{
					"vstFlightOrderId":vstFlightOrderId,
					"vstOrderMainId":vstOrderMainId,
					"lvfMainOrderNo":orderMainNo
				}
			}
	};
	if(orderMainNo){
		$.ajax({
			type:"POST",
			url:'order/unbindingVstOrder',
			cache : false,
			async : false,
			datatype : "json",
			data:vstOrderForm,
			success:function(data){
				alert(data);
			}
		});
	}
}

//向页面填充数据
function fillData(orderDetail){
//	var dataStr = '('+orderDetail+')';
//	var orderData = eval(dataStr);
	var orderData = orderDetail;
	
	if(orderData){
		//设置base.ftl内容
		getBookingSource(orderData);
		setBaseFtl(orderData);
		
		//设置relation.ftl内容
		//设置同主单订单sameTable
		//删除原表中的数据，再添加新数据
		var tableName = "sameTable";
		setRelationFtl(orderData,tableName);
		//设置相关订单relationTable
		tableName = "relationTable";
		setRelationFtl(orderData,tableName);

		//设置info.ftl
		setInfoFtl(orderData);
		if(orderData.opType=="CTMT"){
			setCTMT_ticketInfo_edit_ftl(orderData);
		}else if(orderData.opType=="RTVT"){
			rtvt_tiketinfo_edit(orderData);
		}else if(orderData.opType=="ISSUE"){
			issue_tiketinfo_edit(orderData);
		}
	}
}

function getBookingSource(orderData){
	if(orderData.base.bookingSource == "DEFAULT"){
		bookingSource = "默认";
	}else if(orderData.base.bookingSource == "LVMAMA_FRONT"){
		bookingSource = "机票前台";
	}else if(orderData.base.bookingSource == "LVMAMA_ANDROID"){
		bookingSource = "机票Android";
	}else if(orderData.base.bookingSource == "LVMAMA_IOS"){
		bookingSource = "机票IOS";
	}else if(orderData.base.bookingSource == "LVMAMA_H5"){
		bookingSource = "机票H5";
	}else if(orderData.base.bookingSource == "LAMAMA_BACK"){
		bookingSource = "机票后台";
	}else if(orderData.base.bookingSource == "LAMAMA_DISTRIBUTION"){
		bookingSource = "机票分销";
	}else if(orderData.base.bookingSource == "VST_PACKAGE_FRONT"){
		bookingSource = "VST打包前台";
	}else if(orderData.base.bookingSource == "VST_PACKAGE_ANDROID"){
		bookingSource = "VST打包Android";
	}else if(orderData.base.bookingSource == "VST_PACKAGE_IOS"){
		bookingSource = "VST打包IOS";
	}else if(orderData.base.bookingSource == "VST_PACKAGE_H5"){
		bookingSource = "VST打包H5";
	}else if(orderData.base.bookingSource == "VST_PACKAGE_BACK"){
		bookingSource = "VST打包后台";
	}else if(orderData.base.bookingSource == "VST_DISTRIBUTION"){
		bookingSource = "VST分销";
	}
}

//设置base.ftl
function setBaseFtl(orderData){
	if(orderData.base){
		var base = orderData.base;
		//订单号
		$("#baseOrderNo").text(base.orderNo);
		//订单来源
		$("#baseBookingSource").text(base.bookingSource.cnName);
		//支付类型
		$("#basePayType").text();
		//所属公司
		$("#baseCompany").text();
		//所属产品经理
		$("#baseProductManager").text();
		//产品经理手机号
		$("#baseManagerMobilephone").text();
		//登录用户
		$("#baseLoginUser").text();
		if(base.flightOrderContacter){
			var contacter = base.flightOrderContacter;
			$("#baseContacterName").text(contacter.name);
			$("#baseContacterCellphone").text(contacter.cellphone);
			$("#baseContacterCellphone").append('<a href="">[发送短信]</a>');
			$("#baseContacterEmail").text(contacter.email);
		}
		//产品类型：
		$("#baseProductType").text();
		//产品名称：
		$("#baseProductName").text();
		//用户退款总金额：
		$("#baseRefundAmount").text();
		//分销渠道减少总金额：
		$("#baseSalesAmount").text();
		if(base.applyRTVT){
			$(function () {
				// $("body").append("<h1></h1>");
				var $applyRTVT = $("<a id='baseApplyRTVT' href='"+requestContextPath+"'/ticket/rtvt/apply/'"+base.orderMainId+"'/'"+base.orderId+"'>'"+
					"<div class='button'>申请退票</div>"+
					"</a>");
				$("#handleContainer").append($applyRTVT);
			});
		}
		if(base.applyCTMT){
			$(function () {
				// $("body").append("<h1></h1>");
				var $applyCTMT = $("<a id='baseApplyCTMT' href='"+requestContextPath+"'/ticket/ctmt/apply/'"+base.orderMainId+"'/'"+base.orderId+"'>'"+
					"<div class='button'>申请改签</div>"+
					"</a>");
				$("#handleContainer").append($applyCTMT);
			});
		}

		// 付款情况
		$("#basePayStatus").text();
		// 应付款
		$("#basePayAmount").text();
		// 已收款
		$("#basePayedAmount").text();
		// 剩余款
		$("#baseUnpayedAmount").text();
		// 支付等待时间
		$("#baseWaitTime").text();
		
//		用户备注/特殊要求
		$("#baseCustomerRemar").text(base.customerRemark);
//		确认方式
		$("#baseConfirmType").text(base.confirmType);
		
	}
}


//设置Relation.ftl
function setRelationFtl(orderData,tableName){
	if(orderData.relations){
		var relations = null;
		if(tableName=="relationTable"){
			relations = orderData.relations;
		}else if(tableName=="sameTable"){
			relations = orderData.sameRelations;
		}
		var cit= $("#"+tableName);
        if(cit.size()>0) {
            cit.find("tr:not(:first)").remove();
        }
      //设置相关订单数据
        for(var i=0;i<relations.length;i++){
        	var relationDetails =relations[i].flightOrderRelationDetails;
        	var context = "";
        	if(relationDetails&&relationDetails.length!=0){
        		for(var j=0;j<relationDetails.length;j++){
        			var flightAirportLine = relationDetails[j].flightAirportLine;
        			if(flightAirportLine){
        				var depDate = null;
        				if(relationDetails[j].timeSegmentRange&&relationDetails[j].timeSegmentRange.departureTime){
        					depDate = new Date(relationDetails[j].timeSegmentRange.departureTime);
        					context +=depDate.format("yyyy-MM-dd hh:mm")+"|";
	        				context +=flightAirportLine.departureAirport.code+"-"+flightAirportLine.arrivalAirport.code+"|";
	        				if(relationDetails[j].passengerTypes){
	        					for(var k=0;k<relationDetails[j].passengerTypes.length;k++){
	        						if(relationDetails[j].passengerTypes[k]=="ADULT"){
	        							context += "成人  ";
	        						}else{
	        							context += "儿童  ";
	        						}
	        					}
	        				}
	        				if(relationDetails[j].passengerCounts){
	        					var count = 0;
	        					for(var k=0;k<relationDetails[j].passengerCounts.length;k++){
	        						count += relationDetails[j].passengerCounts[k];
	        					}
	        					context +=count+"人";
	        				}
        				}
        			}
        		}
        	}
        	var orderAuditStatus = "";
    		var orderTicketStatus = "";
    		if(relations[i].flightOrderStatusDto&&relations[i].flightOrderStatusDto.orderAuditStatus){
    			if(relations[i].flightOrderStatusDto.orderAuditStatus=="NOT_AUDIT"){
    				orderAuditStatus = "未审核";
    			}else if(relations[i].flightOrderStatusDto.orderAuditStatus=="AUDIT_PASS"){
    				orderAuditStatus = "审核通过";
    			}else if(relations[i].flightOrderStatusDto.orderAuditStatus=="AUDIT_REJECT"){
    				orderAuditStatus = "审核驳回";
    			}else if(relations[i].flightOrderStatusDto.orderAuditStatus=="APPLY_SUPP_OP"){
    				orderAuditStatus = "申请供应商处理";
    			}else if(relations[i].flightOrderStatusDto.orderAuditStatus=="SUPP_OP_PASS"){
    				orderAuditStatus = "供应商处理通过";
    			}else if(relations[i].flightOrderStatusDto.orderAuditStatus=="SUPP_OP_REJECT"){
    				orderAuditStatus = "供应商处理驳回";
    			}else if(relations[i].flightOrderStatusDto.orderAuditStatus=="OP_PASS"){
    				orderAuditStatus = "审核通过";
    			}else if(relations[i].flightOrderStatusDto.orderAuditStatus=="OP_REJECT"){
    				orderAuditStatus = "处理驳回";
    			}
//    			else {
//    				//有可能状态为NULL
//    				orderAuditStatus ="等待处理";
//    			}
    		}
    		if(relations[i].flightOrderStatusDto&&relations[i].flightOrderStatusDto.orderTicketStatus){
    			if(relations[i].flightOrderStatusDto.orderTicketStatus=="NOT_ISSUE"){
    				orderTicketStatus ="未出票";
    			}else if(relations[i].flightOrderStatusDto.orderTicketStatus=="APPLY_ISSUE"){
    				orderTicketStatus ="申请出票";
    			}else if(relations[i].flightOrderStatusDto.orderTicketStatus=="ISSUE_SUCC"){
    				orderTicketStatus ="出票成功";
    			}else if(relations[i].flightOrderStatusDto.orderTicketStatus=="ISSUE_FAIL"){
    				orderTicketStatus ="出票失败";
    			}else if(relations[i].flightOrderStatusDto.orderTicketStatus=="APPLY_CTMT"){
    				orderTicketStatus ="申请变更";
    			}else if(relations[i].flightOrderStatusDto.orderTicketStatus=="CTMT_SUCC"){
    				orderTicketStatus ="变更成功";
    			}else if(relations[i].flightOrderStatusDto.orderTicketStatus=="CTMT_FAIL"){
    				orderTicketStatus ="变更失败";
    			}else if(relations[i].flightOrderStatusDto.orderTicketStatus=="APPLY_RTVT"){
    				orderTicketStatus ="申请退票";
    			}else if(relations[i].flightOrderStatusDto.orderTicketStatus=="RTVT_SUCC"){
    				orderTicketStatus ="退票成功";
    			}else if(relations[i].flightOrderStatusDto.orderTicketStatus=="RTVT_FAIL"){
    				orderTicketStatus ="退票失败";
    			}else if(relations[i].flightOrderStatusDto.orderTicketStatus=="ALL_CHANGE"){
    				orderTicketStatus ="全部退改";
    			}
//    			else{
//    				orderTicketStatus ="等待处理";
//    			}
    		}
    		$("#"+tableName+">tbody").append('<tr><td>'+relations[i].orderNo+'</td><td>'+context+'</td><td>'+""+'</td><td>'+orderAuditStatus+'</td>'+
    				'<td>'+orderTicketStatus+'</td><td>'+new Date(relations[i].updateTime).format("yyyy-MM-dd hh:mm:ss")+'</td></tr>');
        }
	}
}

//设置InfoFtl
function setInfoFtl(orderData){
	var cit= $("#flightInfoTable");
    if(cit.size()>0) {
        cit.find("tr").remove();
    }
    var info = orderData.info;
    if(info){
    	var flightInfos =info.flightOrderFlightInfos;
    	if(flightInfos){
    		for(var i=0;i<flightInfos.length;i++){
    			var flightInfo = flightInfos[i];
    			var flightNo = "";
    			var tripType = "";
    			var carrierName = "";
    			var airplaneName = "";
    			var depAirport = "";
    			var arrAirport = "";
    			var arrTime = "";
    			var depTime = "";
    			var depDate = "";
    			var seatClassCode = "";
    			var seatClassName = "";
    			if(flightInfo){
    				if(flightInfo.flightNo){
    					flightNo = flightInfo.flightNo;
    				}
    				if(flightInfo.flightTripType){
    					if(flightInfo.flightTripType=="DEPARTURE"){
    						tripType = "去";
    					}else if(flightInfo.flightTripType=="RETURN"){
    						tripType = "返";
    					}
    				}
    				if(flightInfo.carrier){
    					carrierName = flightInfo.carrier.name;
    				}
    				if(flightInfo.airplane){
    					airplaneName = flightInfo.airplane.name;
    				}
    				if(flightInfo.flightAirportLine){
    					depAirport = flightInfo.flightAirportLine.departureAirport.name;
    					arrAirport = flightInfo.flightAirportLine.arrivalAirport.name;
    				}
    				if(flightInfo.timeSegmentRange){
    					depTime = new Date(flightInfo.timeSegmentRange.departureTime).format("hh:mm");
    					arrTime = new Date(flightInfo.timeSegmentRange.arrivalTime).format("hh:mm");
    					depDate = new Date(flightInfo.timeSegmentRange.departureTime).format("yyyy-MM-dd");
    				}
    				if(flightInfo.flightSeat){
    					if(flightInfo.flightSeat.seatClass){
    						seatClassCode = flightInfo.flightSeat.seatClass.code;
    						seatClassName = flightInfo.flightSeat.seatClass.name;
    					}
    				}
    				$("#flightInfoTable").append('<tr>'+
			    			'<td class="go">'+tripType+
			    				'<img src="/images/topxf.png">'+
			    				tripType+carrierName+'<strong>'+flightNo+'</strong>'+
			    				'<div class="jixing">计划机型：<a href="">'+airplaneName+'</a></div>'+
			    			'</td>'+
			    			'<td>'+depTime+'&nbsp;&nbsp;&nbsp;&nbsp;—<i>经停</i>—&nbsp;&nbsp;&nbsp;&nbsp;'+ arrTime +'<number>+1天</number>'+
			    			'<div class="name">'+depAirport+'&nbsp;&nbsp;—&nbsp;&nbsp;'+arrAirport+'</div></td>'+
			    			'<td>'+seatClassName+seatClassCode+'</td>'+
							'<td class="td-5">'+'机建：&yen;50&nbsp;+&nbsp;燃油：&yen;70</td>'+
							'<td class="td-6">'+depDate+'</td>'+
							'</tr>');
    			}
    		}
    		
    		if(orderData.opType==null){
    			$("#passengerContainer").css("display","block");
    			if(info.flightOrderDetails){
    				var cit1= $("#passengerTable");
    			    if(cit1.size()>0) {
    			        cit1.find("tr:not(:first)").remove();
    			    }
    			    var orderDetails = info.flightOrderDetails;
        			for(var i=0;i<orderDetails.length;i++){
        				var passengerType = "";
        				var passengerName = "";
        				var passengerIDCardNo = "";
        				var passengerBirthday = "";
        				var cellphone = "";
        				var ticketNo = "";
        				var parPrice = "";
        				var amount = "";
        				var suppName = "";
        				var settlePrice = "";
        				var detailTicketStatus = orderDetails[i].detailTicketStatus;
        				if(orderDetails[i].flightOrderPassenger){
            				if(orderDetails[i].flightOrderPassenger.passengerType=="ADULT"){
        						passengerType = "成人";
        					}else if(orderDetails[i].flightOrderPassenger.passengerType=="ALL"){
        						passengerType = "全部";
        					}else{
        						passengerType = "儿童";
        					}
        					passengerName = orderDetails[i].flightOrderPassenger.passengerName;
        					passengerIDCardNo = orderDetails[i].flightOrderPassenger.passengerIDCardNo;
        					passengerBirthday = orderDetails[i].flightOrderPassenger.passengerBirthday;
        					cellphone = orderDetails[i].flightOrderPassenger.cellphone;
        				}
        				if(orderDetails[i].flightOrderTicketInfo){
        					ticketNo = orderDetails[i].flightOrderTicketInfo.ticketNo;
        				}
        				if(orderDetails[i].flightOrderTicketPrice){
        					parPrice = orderDetails[i].flightOrderTicketPrice.parPrice;
        					amount = orderDetails[i].flightOrderTicketPrice.airportFee + orderDetails[i].flightOrderTicketPrice.fuelsurTax;
        					settlePrice = orderDetails[i].flightOrderTicketPrice.settlePrice;
        				}
        				if(orderDetails[i].combinationDetail){
        					if(orderDetails[i].combinationDetail.flightOrderFlightPolicy){
        						if(orderDetails[i].combinationDetail.flightOrderFlightPolicy.supp)
        							suppName = orderDetails[i].combinationDetail.flightOrderFlightPolicy.supp.name;
        					}
        				}
        				$("#passengerTable>tbody").append(
        						'<tr>'+
    	        				'<td>'+passengerType+'</td>'+
    	        				'<td>'+passengerName+'</td>'+
    	        				'<td>'+passengerIDCardNo+'</td>'+
    	        				'<td>'+passengerBirthday+'</td>'+
    	        				'<td>'+cellphone+'</td>'+
    	        				'<td>'+ticketNo+'</td>'+
    	        				'<td>'+parPrice+'</td>'+
    	        				'<td>'+amount+'</td>'+
    	        				'<td></td>'+
    	        				'<td></td>'+
    	        				'<td></td>'+
    	        				'<td></td>'+
    	        				'<td>'+suppName+'</td>'+
    	        				'<td>'+settlePrice+'</td>'+
    	        				'<td>'+detailTicketStatus+'</td>'+
    	        			'</tr>'
        				);
        			}
        		}
    		}
    		if(orderData.opType = "ISSUE"){
    			$("#issue_tiketinfo_edit").css("display","block");
    			$("#rtvt_tiketinfo_edit").css("display","none");
    			$("#ctmt_tiketinfo_edit").css("display","none");
    		}else if(orderData.opType = "CTMT"){
    			$("#issue_tiketinfo_edit").css("display","none");
    			$("#rtvt_tiketinfo_edit").css("display","none");
    			$("#ctmt_tiketinfo_edit").css("display","block");
    		}else if(orderData.opType = "RTVT"){
    			$("#issue_tiketinfo_edit").css("display","none");
    			$("#rtvt_tiketinfo_edit").css("display","block");
    			$("#ctmt_tiketinfo_edit").css("display","none");
    		}
    	}
    }
}


function setInsuranceInfo(orderData){
	var insuranceTable = $("#insuranceTable");
	if(insuranceTable.size()>0) {
		insuranceTable.find("tr").remove();
    }
	if(orderData.info.flightOrderDetails){
		var orderDetailss = orderData.info.flightOrderDetails;
		for(var i=0;i<orderDetails.length;i++){
			var passenger = orderDetails[i].flightOrderPassenger;
			if(passneger){
				var insurances = passenger.flightOrderInsurances;
				var passengerType = passenger.passengerType.cnName;
				var passengerName = passenger.passengerName;
				var IDCardType = passenger.passengerIDCardType.cnName;
				var IDCardNo = passenger.passengerIDCardNo;
				var passengerBirthday = passenger.passengerBirthday;
				var cellphone = passenger.cellphone;
				if(insurances){
					for(var j=0;j<insurances.length;j++){
						var insurance = insurances[i];
						if(insurance){
							var insuranceNo = "";
							var insuranceClassName = "";
							var price = "";
							var insuredNum = "";
							var insurancePrice = "";
							var suppName = "";
							var settleAccounts = "";
							var insuranceStatus = "";
							/*if (!insurance.insurancePrice){
								insurancePrice = insurance.insuranceClass.price;
							}else {*/
								insurancePrice = insurance.insurancePrice;
							//}
							if(insurance.insuranceOrderDto){
								settleAccounts = insurance.insuranceOrderDto.settleAccounts;
								insuranceNo = insurance.insuranceOrderDto.insuranceNo;
								insuredNum = insurance.insuranceOrderDto.insuredNum;
								if(insurance.insuranceOrderDto.insuranceInfoDto){
									if(insurance.insuranceOrderDto.insuranceInfoDto.supp){
										suppName = insurance.insuranceOrderDto.insuranceInfoDto.supp.name;
									}
								}
								if(insurance.insuranceOrderDto.insuranceStatus){
									insuranceStatus = insurance.insuranceOrderDto.insuranceStatus.cnName;
								}
								if(insurance.insuranceClass){
									insuranceClassName = insurance.insuranceClass.name;
									price = insurance.insuranceClass.price;
								}
							}
						}
						$("#insuranceTable>tbody").append(
								'<tr>'+
								'<td>'+passengerType+'</td>'+
								'<td>'+passengerName+'</td>'+
								'<td>'+IDCardType+'</td>'+
								'<td>'+IDCardNo+'</td>'+
								'<td>'+passengerBirthday+'</td>'+
								'<td>'+cellphone+'</td>'+
								'<td>'+insuranceNo+'</td>'+
								'<td>'+insuranceClassName+'</td>'+
								'<td>'+price+'</td>'+
								'<td>'+insurance.insuranceOrderDto.insuredNum+'</td>'+
								'<td>'+insurancePrice+'</td>'+
								'<td>'+insurance.insuranceOrderDto.insuranceInfoDto.supp.name+'</td>'+
								'<td>'+insurance.insuranceOrderDto.settleAccounts+'</td>'+
								'<td>'+insurance.insuranceOrderDto.insuranceStatus.cnName+'</td>'+
								'</tr>'
						);
					}
				}
			}
		}
	}
		
}

function setCTMT_ticketInfo_edit_ftl(orderData){
	var cit= $("#ctmt_orderDetails");
    if(cit.size()>0) {
        cit.find("tr:not(:first)").remove();
    }
    var info = orderData.info;
    if(info){
    	var orderDetails = info.flightOrderDetails;
    	if(orderDetails){
    		for(var i=0;i<orderDetails.length;i++){
    			var pnr ="";
    			var passengerSelect = '<select name="passengerType" disabled>';
    			var detailPassengerType = "";
    			var passengerName = "";
    			var detailIDCardType = "";
    			var IDCardNo = "";
    			var passengerBirthday = "";
    			var cellphone = "";
    			var ctmtTicketNo = "";
    			var ctmtParPrice = "";
    			var privilegeAmount = "";
    			var airportFee = "";
    			var fuelsurTax = "";
    			var poundageAmount = "";
    			var saleAmount = "";
    			var settlementAmount = "";
    			var serviceAmount = "";
    			var ctmtPolicyId = "";
    			var detailTicketStatus = "";
    			var realIncomeAmount = "";
    			var realPayAmount = "";
    			if(orderDetails[0].flightOrderPNRInfo){
    				pnr = orderDetails[0].flightOrderPNRInfo.pnr;
    				detailPassengerType = orderDetails[0].flightOrderPassenger.passengerType;
    				passengerName = orderDetails[i].flightOrderPassenger.passengerName;
    				detailIDCardType = orderDetails[i].flightOrderPassenger.IDCardType;
    				IDCardNo = orderDetails[i].flightOrderPassenger.passengerIDCardNo;
    				passengerBirthday = orderDetails[i].flightOrderPassenger.passengerBirthday;
    				cellphone = orderDetails[i].flightOrderPassenger.cellphone;
    				if(orderDetails[i].flightOrderTicketCTMT){
        				ctmtTicketNo = orderDetails[i].flightOrderTicketCTMT.ctmtTicketNo;
        				ctmtParPrice = orderDetails[i].flightOrderTicketCTMT.ctmtParPrice;
        				privilegeAmount = orderDetails[i].flightOrderTicketCTMT.privilegeAmount;
        				airportFee = orderDetails[i].flightOrderTicketCTMT.airportFee;
        				fuelsurTax = orderDetails[i].flightOrderTicketCTMT.fuelsurTax;
        				poundageAmount = orderDetails[i].flightOrderTicketCTMT.poundageAmount;
        				serviceAmount = orderDetails[i].flightOrderTicketCTMT.serviceAmount;
        				saleAmount = orderDetails[i].flightOrderTicketCTMT.saleAmount;
        				settlementAmount = orderDetails[i].flightOrderTicketCTMT.settlementAmount;
        				realIncomeAmount = orderDetails[i].flightOrderTicketCTMT.realIncomeAmount;
        				realPayAmount = orderDetails[i].flightOrderTicketCTMT.realPayAmount;
        			}
    				if(orderDetails[i].combinationDetail){
    					ctmtPolicyId = orderdetails[i].combinationDetail.ctmtPolicyId;
    				}
    				if(orderdetail[i].detailTicketStatus){
    					detailTicketStatus = orderdetails[i].detailTicketStatus.cnName;
    				}
    			}
    			if(orderData.passengerTypeEnum){
    				for(var i=0;i<orderData.passengerTypeEnum.length;i++){
    					var passengerType = orderData.passengerTypeEnum[i];
    					var passengerTypeName = "";
    					if(passengerType=="ADULT"){
    						passengerTypeName = "成人";
    					}else if(passengerType=="ALL"){
    						passengerTypeName = "全部";
    					}else{
    						passengerTypeName = "儿童";
    					}
    					if(detailPassengerType = passengerType){
    						passengerSelect += '<option value='+passengerType+' "selected">'+passengerTypeName+'</option>';
    					}else{
    						passengerSelect += '<option value='+passengerType+'>'+passengerTypeName+'</option>';
    					}
    				}
    				passengerSelect +="</select>";
    			}
    			var IDCardType = "";
    			var IDCardTypeSelect = '<select name="IDCardType" disabled>';
    			if(orderData.passengerIDCardTypeEnum){
    				for(var i=0;i<orderData.passengerIDCardTypeEnum.length;i++){
    					var IDCardType = orderData.passengerIDCardTypeEnum[i];
    	    			var IDCardTypeName = "";
    					if(IDCardType=="ID"){
    						IDCardTypeName = "身份证";
    					}else if(IDCardType=="PASSPORT"){
    						IDCardTypeName = "护照";
    					}else if(IDCardType=="OFFICER"){
    						IDCardTypeName = "军官证";
    					}else if(IDCardType=="SOLDIER"){
    						IDCardTypeName = "士兵证";
    					}else if(IDCardType=="TAIBAO"){
    						IDCardTypeName = "台胞证";
    					}else if(IDCardType=="OTHER"){
    						IDCardTypeName = "其他";
    					}
    					if(detailIDCardType = IDCardType){
    						IDCardTypeSelect += '<option value='+IDCardType+' "selected">'+IDCardTypeName+'</option>';
    					}else{
    						IDCardTypeSelect += '<option value='+IDCardType+'>'+IDCardTypeName+'</option>';
    					}
    				}
    				IDCardTypeSelect +="</select>";
    			}
    			
    			
    			
    		}
    	}
    }
    
    $("#ctmt_orderDetails>tbody").append('<tr>'+
    		'<td>'+
    			'<input type="text" style="text-align: center;" name="ctmtPnr" value="'+ pnr +'"/>'+
    		'</td>'+
    		'<td>'+
    	    	passengerSelect+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align:center;" name="passengerName" '+
    			'value="'+passengerName+'" disabled/>'+
    	'</td>'+
    	'<td>'+
    		IDCardTypeSelect+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="passengerIDCardNo" '+
    			'value="'+passengerIDCardNo+'" disabled/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="passengerBirthday" '+
    			'value="'+passengerBirthday+'" disabled/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="cellphone" '+
    			'value="'+cellphone+'" />'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="ctmtTicketNo" '+
    			'value="'+ctmtTicketNo+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="ctmtParPrice" '+
    			'value="'+ctmtParPrice+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="privilegeAmount" '+
    			'value="'+privilegeAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="airportFee" '+
    			'value="'+airportFee+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="fuelsurTax" '+
    			'value="'+fuelsurTax+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="poundageAmount" '+
    			'value="'+poundageAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="serviceAmount" '+
    			'value="'+serviceAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="saleAmount" '+
    			'value="'+saleAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="settlementAmount" '+
    			'value="'+settlementAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="bookingSource" '+
    			'value="'+bookingSource+'"/>'+
    		'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="ctmtPolicyId" '+
    			'value="'+ctmtPolicyId+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" disabled="disabled"/>'+
    	'</td>'+
    	'<td>'+
    		detailTicketStatus+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="realIncomeAmount" '+
    			'value="'+realIncomeAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="realPayAmount" '+
    			'value="'+realPayAmount+'"/>'+
    	'</td>'
    );
}

//设置rtvt_tikectinfo_edit.ftl
function rtvt_tiketinfo_edit(orderData){
//	var bookingSource = orderData.base.bookingSource;
	var cit= $("#rtvt_orderDetails");
    if(cit.size()>0) {
        cit.find("tr:not(:first)").remove();
    }
    var info = orderData.info;
    if(info){
    	var orderDetails = info.flightOrderDetails;
    	if(orderDetails){
    		for(var i=0;i<orderDetails.length;i++){
    			var pnr ="";
    			var passengerSelect = '<select name="passengerType" disabled>';
    			var detailPassengerType = "";
    			var passengerName = "";
    			var detailIDCardType = "";
    			var IDCardNo = "";
    			var passengerBirthday = "";
    			var cellphone = "";
    			var ctmtTicketNo = "";
    			var ctmtParPrice = "";
    			var privilegeAmount = "";
    			var airportFee = "";
    			var fuelsurTax = "";
    			var poundageAmount = "";
    			var saleAmount = "";
    			var settlementAmount = "";
    			var serviceAmount = "";
    			var rtvtPolicyId = "";
    			var detailTicketStatus = "";
    			var realIncomeAmount = "";
    			var realPayAmount = "";
    			if(orderDetails[0].flightOrderPNRInfo){
    				pnr = orderDetails[0].flightOrderPNRInfo.pnr;
    				detailPassengerType = orderDetails[0].flightOrderPassenger.passengerType;
    				passengerName = orderDetails[i].flightOrderPassenger.passengerName;
    				detailIDCardType = orderDetails[i].flightOrderPassenger.IDCardType;
    				IDCardNo = orderDetails[i].flightOrderPassenger.passengerIDCardNo;
    				passengerBirthday = orderDetails[i].flightOrderPassenger.passengerBirthday;
    				cellphone = orderDetails[i].flightOrderPassenger.cellphone;
    				if(orderDetails[i].flightOrderDetailRTVT){
        				ctmtTicketNo = orderDetails[i].flightOrderDetailRTVT.ctmtTicketNo;
        				ctmtParPrice = orderDetails[i].flightOrderDetailRTVT.ctmtParPrice;
        				privilegeAmount = orderDetails[i].flightOrderDetailRTVT.privilegeAmount;
        				airportFee = orderDetails[i].flightOrderDetailRTVT.airportFee;
        				fuelsurTax = orderDetails[i].flightOrderDetailRTVT.fuelsurTax;
        				poundageAmount = orderDetails[i].flightOrderDetailRTVT.poundageAmount;
        				serviceAmount = orderDetails[i].flightOrderDetailRTVT.serviceAmount;
        				saleAmount = orderDetails[i].flightOrderDetailRTVT.saleAmount;
        				settlementAmount = orderDetails[i].flightOrderDetailRTVT.settlementAmount;
        				realIncomeAmount = orderDetails[i].flightOrderDetailRTVT.realIncomeAmount;
        				realPayAmount = orderDetails[i].flightOrderDetailRTVT.realPayAmount;
        			}
    				if(orderDetails[i].combinationDetail){
    					rtvtPolicyId = orderdetails[i].combinationDetail.rtvtPolicyId;
    				}
    				if(orderdetail[i].detailTicketStatus){
    					detailTicketStatus = orderdetails[i].detailTicketStatus.cnName;
    				}
    			}
    			if(orderData.passengerTypeEnum){
    				for(var i=0;i<orderData.passengerTypeEnum.length;i++){
    					var passengerType = orderData.passengerTypeEnum[i];
    					var passengerTypeName = "";
    					if(passengerType=="ADULT"){
    						passengerTypeName = "成人";
    					}else if(passengerType=="ALL"){
    						passengerTypeName = "全部";
    					}else{
    						passengerTypeName = "儿童";
    					}
    					if(detailPassengerType = passengerType){
    						passengerSelect += '<option value='+passengerType+' "selected">'+passengerTypeName+'</option>';
    					}else{
    						passengerSelect += '<option value='+passengerType+'>'+passengerTypeName+'</option>';
    					}
    				}
    				passengerSelect +="</select>";
    			}
    			var IDCardType = "";
    			var IDCardTypeSelect = '<select name="IDCardType" disabled>';
    			if(orderData.passengerIDCardTypeEnum){
    				for(var i=0;i<orderData.passengerIDCardTypeEnum.length;i++){
    					var IDCardType = orderData.passengerIDCardTypeEnum[i];
    	    			var IDCardTypeName = "";
    					if(IDCardType=="ID"){
    						IDCardTypeName = "身份证";
    					}else if(IDCardType=="PASSPORT"){
    						IDCardTypeName = "护照";
    					}else if(IDCardType=="OFFICER"){
    						IDCardTypeName = "军官证";
    					}else if(IDCardType=="SOLDIER"){
    						IDCardTypeName = "士兵证";
    					}else if(IDCardType=="TAIBAO"){
    						IDCardTypeName = "台胞证";
    					}else if(IDCardType=="OTHER"){
    						IDCardTypeName = "其他";
    					}
    					if(detailIDCardType = IDCardType){
    						IDCardTypeSelect += '<option value='+IDCardType+' "selected">'+IDCardTypeName+'</option>';
    					}else{
    						IDCardTypeSelect += '<option value='+IDCardType+'>'+IDCardTypeName+'</option>';
    					}
    				}
    				IDCardTypeSelect +="</select>";
    			}
    		}
    	}
    }
    
    $("#rtvt_orderDetails>tbody").append('<tr>'+
    		'<td>'+
    			'<input type="text" style="text-align: center;" name="ctmtPnr" value="'+ pnr +'"/>'+
    		'</td>'+
    		'<td>'+
    	    	passengerSelect+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align:center;" name="passengerName" '+
    			'value="'+passengerName+'" disabled/>'+
    	'</td>'+
    	'<td>'+
    		IDCardTypeSelect+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="passengerIDCardNo" '+
    			'value="'+passengerIDCardNo+'" disabled/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="passengerBirthday" '+
    			'value="'+passengerBirthday+'" disabled/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="cellphone" '+
    			'value="'+cellphone+'" />'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="ctmtTicketNo" '+
    			'value="'+rtvtTicketNo+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="ctmtParPrice" '+
    			'value="'+rtvtParPrice+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="privilegeAmount" '+
    			'value="'+privilegeAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="airportFee" '+
    			'value="'+airportFee+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="fuelsurTax" '+
    			'value="'+fuelsurTax+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="poundageAmount" '+
    			'value="'+poundageAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="serviceAmount" '+
    			'value="'+serviceAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="saleAmount" '+
    			'value="'+saleAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="settlementAmount" '+
    			'value="'+settlementAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="bookingSource" '+
    			'value="'+bookingSource+'"/>'+
    		'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="rtvtPolicyId" '+
    			'value="'+rtvtPolicyId+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" disabled="disabled"/>'+
    	'</td>'+
    	'<td>'+
    		detailTicketStatus+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="realIncomeAmount" '+
    			'value="'+realIncomeAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="realPayAmount" '+
    			'value="'+realPayAmount+'"/>'+
    	'</td>'
    );
}


function issue_tiketinfo_edit(orderData){
//	var bookingSource = orderData.base.bookingSource;
	var cit= $("#issue_orderDetails");
    if(cit.size()>0) {
        cit.find("tr:not(:first)").remove();
    }
    var info = orderData.info;
    if(info){
    	var orderDetails = info.flightOrderDetails;
    	if(orderDetails){
    		for(var i=0;i<orderDetails.length;i++){
    			var pnr ="";
    			var passengerSelect = '<select name="passengerType" disabled>';
    			var detailPassengerType = "";
    			var passengerName = "";
    			var detailIDCardType = "";
    			var IDCardNo = "";
    			var passengerBirthday = "";
    			var cellphone = "";
    			var issueTicketNo = "";
    			var issueParPrice = "";
    			var privilegeAmount = "";
    			var airportFee = "";
    			var fuelsurTax = "";
    			var poundageAmount = "";
    			var saleAmount = "";
    			var settlementAmount = "";
    			var serviceAmount = "";
    			var issuePolicyId = "";
    			var detailTicketStatus = "";
    			var realIncomeAmount = "";
    			var realPayAmount = "";
    			if(orderDetails[0].flightOrderPNRInfo){
    				pnr = orderDetails[0].flightOrderPNRInfo.pnr;
    				detailPassengerType = orderDetails[0].flightOrderPassenger.passengerType;
    				passengerName = orderDetails[i].flightOrderPassenger.passengerName;
    				detailIDCardType = orderDetails[i].flightOrderPassenger.IDCardType;
    				IDCardNo = orderDetails[i].flightOrderPassenger.passengerIDCardNo;
    				passengerBirthday = orderDetails[i].flightOrderPassenger.passengerBirthday;
    				cellphone = orderDetails[i].flightOrderPassenger.cellphone;
    				if(orderDetails[i].flightOrderTicketIssue){
        				issueTicketNo = orderDetails[i].flightOrderTicketIssue.ctmtTicketNo;
        				issueParPrice = orderDetails[i].flightOrderTicketIssue.ctmtParPrice;
        				privilegeAmount = orderDetails[i].flightOrderTicketIssue.privilegeAmount;
        				airportFee = orderDetails[i].flightOrderTicketIssue.airportFee;
        				fuelsurTax = orderDetails[i].flightOrderTicketIssue.fuelsurTax;
        				poundageAmount = orderDetails[i].flightOrderTicketIssue.poundageAmount;
        				serviceAmount = orderDetails[i].flightOrderTicketIssue.serviceAmount;
        				saleAmount = orderDetails[i].flightOrderTicketIssue.saleAmount;
        				settlementAmount = orderDetails[i].flightOrderTicketIssue.settlementAmount;
        				realIncomeAmount = orderDetails[i].flightOrderTicketIssue.realIncomeAmount;
        				realPayAmount = orderDetails[i].flightOrderTicketIssue.realPayAmount;
        			}
    				if(orderDetails[i].combinationDetail){
    					issuePolicyId = orderDetails[i].combinationDetail.issuePolicyId;
    				}
    				if(orderDetails[i].detailTicketStatus){
    					detailTicketStatus = orderDetails[i].detailTicketStatus.cnName;
    				}
    			}
    			if(orderData.passengerTypeEnum){
    				for(var i=0;i<orderData.passengerTypeEnum.length;i++){
    					var passengerType = orderData.passengerTypeEnum[i];
    					var passengerTypeName = "";
    					if(passengerType=="ADULT"){
    						passengerTypeName = "成人";
    					}else if(passengerType=="ALL"){
    						passengerTypeName = "全部";
    					}else{
    						passengerTypeName = "儿童";
    					}
    					if(detailPassengerType = passengerType){
    						passengerSelect += '<option value='+passengerType+' "selected">'+passengerTypeName+'</option>';
    					}else{
    						passengerSelect += '<option value='+passengerType+'>'+passengerTypeName+'</option>';
    					}
    				}
    				passengerSelect +="</select>";
    			}
    			var IDCardType = "";
    			var IDCardTypeSelect = '<select name="IDCardType" disabled>';
    			if(orderData.passengerIDCardTypeEnum){
    				for(var i=0;i<orderData.passengerIDCardTypeEnum.length;i++){
    					var IDCardType = orderData.passengerIDCardTypeEnum[i];
    	    			var IDCardTypeName = "";
    					if(IDCardType=="ID"){
    						IDCardTypeName = "身份证";
    					}else if(IDCardType=="PASSPORT"){
    						IDCardTypeName = "护照";
    					}else if(IDCardType=="OFFICER"){
    						IDCardTypeName = "军官证";
    					}else if(IDCardType=="SOLDIER"){
    						IDCardTypeName = "士兵证";
    					}else if(IDCardType=="TAIBAO"){
    						IDCardTypeName = "台胞证";
    					}else if(IDCardType=="OTHER"){
    						IDCardTypeName = "其他";
    					}
    					if(detailIDCardType = IDCardType){
    						IDCardTypeSelect += '<option value='+IDCardType+' "selected">'+IDCardTypeName+'</option>';
    					}else{
    						IDCardTypeSelect += '<option value='+IDCardType+'>'+IDCardTypeName+'</option>';
    					}
    				}
    				IDCardTypeSelect +="</select>";
    			}
    		}
    	}
    }
    
    $("#issue_orderDetails>tbody").append('<tr>'+
    		'<td>'+
    			'<input type="text" style="text-align: center;" name="ctmtPnr" value="'+ pnr +'"/>'+
    		'</td>'+
    		'<td>'+
    	    	passengerSelect+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align:center;" name="passengerName" '+
    			'value="'+passengerName+'" disabled/>'+
    	'</td>'+
    	'<td>'+
    		IDCardTypeSelect+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="passengerIDCardNo" '+
    			'value="'+IDCardNo+'" disabled/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="passengerBirthday" '+
    			'value="'+passengerBirthday+'" disabled/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="cellphone" '+
    			'value="'+cellphone+'" />'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="ctmtTicketNo" '+
    			'value="'+issueTicketNo+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="ctmtParPrice" '+
    			'value="'+issueParPrice+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="privilegeAmount" '+
    			'value="'+privilegeAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="airportFee" '+
    			'value="'+airportFee+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="fuelsurTax" '+
    			'value="'+fuelsurTax+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="poundageAmount" '+
    			'value="'+poundageAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="serviceAmount" '+
    			'value="'+serviceAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="saleAmount" '+
    			'value="'+saleAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="settlementAmount" '+
    			'value="'+settlementAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="bookingSource" '+
    			'value="'+bookingSource+'"/>'+
    		'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="rtvtPolicyId" '+
    			'value="'+issuePolicyId+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" disabled="disabled"/>'+
    	'</td>'+
    	'<td>'+
    		detailTicketStatus+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="realIncomeAmount" '+
    			'value="'+realIncomeAmount+'"/>'+
    	'</td>'+
    	'<td>'+
    		'<input type="text" style="text-align: center;" name="realPayAmount" '+
    			'value="'+realPayAmount+'"/>'+
    	'</td>'
    );
}