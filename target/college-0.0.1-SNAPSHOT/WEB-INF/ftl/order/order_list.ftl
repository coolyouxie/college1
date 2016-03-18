<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
		<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/area_tankuang.css">
		<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
		<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
		<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
		<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
		<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script> 
		<script type="text/javascript">
			
			var opType = '${opType}';
			
			$(function (){
				initGrid();
				$("#showPayOperate").css("display", "none");
				$("#showPayFailInfo").css("display", "none");
				$("#payMethodDialog").css("display", "none");
				
			}); 



			// 关闭，支付失败窗口
			function closePayFailInfo() {
				window.location.reload();
				$("#showPayFailInfo").css("display", "none");
			}

			function closePayMethodDialog(){
				$("#payMethodDialog").css("display", "none");
			}
			
			// 取消支付操作
			function canclePayOperate() {
				window.location.reload();
				$("#showPayOperate").css("display", "none");
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
			   
         
			function query() 
			{
				$("#flightOrderList").jqGrid('setGridParam', 
				{
		 			url:"${request.contextPath}/order/queryOrderList/"+opType,
		 			datatype : "json",
		 			mtype : "POST",
			 		postData : getQueryParams()
				}).trigger("reloadGrid");
				
				conditionHtmlToExportCsvForm();
			}
	
			function getQueryParams() 
			{
	    		var bookingSourceStr="";
        		$("input[tempName='bookingSource']:checkbox").each(function()
        		{ 
            		if($(this).attr("checked")){
                		bookingSourceStr += $(this).val()+","
            		}
        		});
        		
        		var cityCodeAry = getCityCode(); 

				return {
					'orderNoType':$('#orderNoType').val(),
					'orderNo' : $("#orderNo").val(),
					'bookingManualNo' : $("#bookingManualNo").val(),
					'orderBookingQueryBegTime':$("#orderBookingQueryBegTime").val(),
					'orderBookingQueryEndTime':$("#orderBookingQueryEndTime").val(),
					'orderType':$("#orderType").val(),
					'orderStatus.orderBackStatus':$("#orderBackStatus").val(),
					'orderStatus.orderTicketStatus':$("#ticketStatus").val(),
					'orderStatus.orderPayStatus':$("#orderPayStatus").val(),
					'orderStatus.orderAuditStatus':$('#orderAuditStatus').val(),
					'payQueryBegTime':$("#payQueryBegTime").val(),
					'payQueryEndTime':$("#payQueryEndTime").val(),
					'bookingSourceStr':bookingSourceStr,
					'pnr' : $("#pnr").val(),
					'ticketNo':$("#ticketNo").val(),
					'flightNo' : $("#flightNo").val(),
					'suppName':$("#suppName").find("option:selected").val(),
					'carrierName':$("#carrierName").find("option:selected").val(),
					'departureCity':cityCodeAry[0],
					'arriveCity':cityCodeAry[1],
					'flightQueryBegTime':$("#flightQueryBegTime").val(),
					'flightQueryEndTime':$("#flightQueryEndTime").val(),
					'flightOrderCustomer.customerName':$("#customerName").val(),
					'flightOrderCustomer.customerCellphone':$("#customerCellphone").val(),
					'flightOrderPassenger.passengerName':$("#passengerName").val(),
					'flightOrderPassenger.passengerIDCardNo':$("#passengerIDCardNo").val(),
					'flightOrderContacter.name':$("#contactName").val(),
					'flightOrderContacter.email':$("#contactEmail").val(),
					'flightOrderContacter.telphone':$("#contactTelphone").val(),
					'flightOrderContacter.cellphone':$("#contactCellphone").val(),
					'search':false
				}
			}
	
			function initGrid() 
			{
			
				var colNames = ['订单号', '订单类型','PNR', '航程','航班号', '乘机时间','预订人数', '应收款','支付方式', '联系人', 
					'下单时间', '订单来源','当前状态'];
		
				var cols = [ 
					{
						name : 'orderNo',
						index : 'orderNo',
						formatter:formatLink,
						sortable:false
					},
					{
						name : 'orderTypeName',
						index : 'orderTypeName',
						sortable:false
					},
					{
						name : 'pnr',
						index : 'pnr',
						sortable:false
					},
					{
						name : 'flightSegments',
						index : 'flightSegments',
						sortable:false
					},
					{
						name : 'flightNos',
						index : 'flightNos',
						sortable:false
					},
					{
						name : 'flightTimes',
						index : 'flightTimes',
						sortable:false
					},
					{
						name : 'passengerCount',
						index : 'passengerCount',
						sortable:false
					},
					{
						name : 'receivableAmount',
						index : 'receivableAmount',
						sortable:false
					},
					{
						name : 'paymentMethod',
						index : 'paymentMethod',
						sortable:false
					},
					{
						name : 'contactName',
						index : 'contactName',
						sortable:false
					},
					{
						name : 'orderCreateTimeStr',
						index : 'orderCreateTimeStr',
						sortable:false
					},
					{
						name : 'bookingSourceName',
						index : 'bookingSourceName',
						sortable:false
					},
					{
						name : 'currentStatusStr',
						index : 'currentStatusStr',
						sortable:false
					}
					];
					
				if(opType=='PAY'){
					cols[cols.length] = {
						name : 'op',
						index : 'op',
						formatter:formatOp,
						sortable:false
					};		
					colNames[colNames.length] = '操作';
					
					cols[cols.length] = {
						name : 'canPay',
						index : 'canPay',
						sortable:false,
						hidden : true
					};		
					colNames[colNames.length] = '是否可支付';
										
				}
					
			
				$("#flightOrderList").jqGrid({
					url : '${request.contextPath}/order/queryOrderList/'+opType,
					datatype : "json",
					mtype : "POST",
					height:'auto',//高度，表格高度。可为数值、百分比或'auto'
			        //width:1000,//这个宽度不能为百分比
			        autowidth:true,//自动宽
					colNames:colNames,
					colModel :cols,
		            autowidth : true,
					rowNum : 10,
					pager : '#pager',
					viewrecords : true,
					rowList:[10,20,50,200],   //分页选项，可以下拉选择每页显示记录数
					multiselect : false,
					caption : "订单查询列表",
					jsonReader : {
						root : "results",
						page : "pagination.page", //当前页
						records : "pagination.records", //总记录数
						total:'pagination.total',
						repeatitems : false
					},
					onPaging : function(pgButton) {
						$("#flightOrderList").jqGrid('setGridParam', {
							postData : getQueryParams()
						});
					}
				});
			} 
			
			
			function formatOp(cellvalue, options, rowObject) 
			{
	    		if(rowObject.canPay){
                	var toPay ='付款';
                    operateClick= "<div><a href='#' style='color:#f60' onclick=operatorPay('"+rowObject.orderId+"','"+rowObject.orderMainId+"','"+rowObject.orderNo+"')>"+toPay+"</a></div>";  
                    jQuery("#payMonitorTable").jqGrid('setRowData', rowObject, {canPay:operateClick});
                    return operateClick;
		        }else{
	           		return "";
		        }
    		}

			//选择支付方式可按照子单支付或者主单支付
			function selectPayMethod(){
				var payMethod=$('input[name="payMethod"]:checked').val();
				var orderMainId = $.trim($("#orderMainId").val());
				var orderId = $.trim($("#orderId").val());
				$("#payMethodDialog").css("display", "none");
				
				if(payMethod=='mainPay'){//主单支付
					mainPay(orderMainId);
				}else if(payMethod=='subPay'){//子单支付
					subPay(orderId,orderMainId);
				}
				
			}
			
			function mainPay(orderMainId){
				payData = JSON.stringify({
					orderMainId : orderMainId
					});
				doApplyToPay(payData);
			}
			
			//子单支付
			function subPay(orderId,orderMainId){
				payData = JSON.stringify({
								orderMainId : orderMainId,
								orderId : orderId
								});
				doApplyToPay(payData);
			}
    		
    		//申请支付
    		function operatorPay(orderId,orderMainId,orderNo) {
				//判断是否可以主单支付
				validateMainPay(orderId,orderMainId);
			
			}
			
			
			function validateMainPay(orderId,orderMainId){
				$.ajax({
				url:"${request.contextPath}/order/isCanMainPay/"+opType,
				type : 'post',
				dataType : "json",
				contentType : "application/json;",
				data : JSON.stringify({
						orderMainId : orderMainId
					}),
				success : function(data) {
					if (data.status != "" && data.status == "SUCCESS") {
						if(data.message=='true'){//满足主单支付条件则弹出选择框
							$("#orderId").val(orderId);
							$("#orderMainId").val(orderMainId);
							$("#payMethodDialog").css("display", "block");
						}else{
							//子单支付
							subPay(orderId,orderMainId);
						}
					}
				}
				});
			}
			
			//真正去支付
			function doApplyToPay(data){
				//重置状态
				$("input[name='payType']:checked").val("");
				$("#payOpNumber").css("display", "none");
				
				
				$.ajax({
				url : '${request.contextPath}/order/orderPayInfoAjax',
				type : 'post',
				dataType : "json",
				contentType : "application/json;",
				data : data,
				success : function(data) {
					var paymentNo = "";
					var payedAmount = "";
		
					if (data.status != "" && data.status == "SUCCESS") {
						$.each(data.results, function(i, value) {
							$("#paymentNoOperate").val(value.paymentNo);
							$("#payMentValue span").html(value.payedAmount);
						})
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
					$("#showPayOperate").css("display", "none");
					// 显示支付失败信息
					$("#payFailInfo span").html(
							eval('(' + data.responseText + ')').message);
					$("#showPayFailInfo").css("display", "block");
		
				}
				});
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
							if (data.status != "" && data.status == "SUCCESS") {
								alert("支付成功");
								$("#showPayOperate").css("display", "none");
								window.location.reload();
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
			
		
			function formatLink(cellvalue, options, rowObject) 
			{
	    		var url = "${request.contextPath}/order/queryOrderDetail/"+rowObject.orderMainId+"/"+rowObject.orderId+"/"+opType;
	    		return  "<a href='"+url+"' style='color:blue;' target='_blank'>" + cellvalue + "</a>";
    		}
    
			function setTicketStatus(orderType)
			{
      			$('#ticketStatus').empty();
      			$('#ticketStatus').append('<option value="">全部</option>');
      			$('#ticketStatus').append($("#ticketStatus_"+orderType).html());
    		}
    		
    		//获取城市编码
    		function getCityCode()
    		{
    			var cityCodeAry = new Array(); 
    			
    			//设置出发城市和目的城市
        		var departureCity = $('#departureCity').val();
        		if($.trim(departureCity).length > 0)
        		{
        			var startIndex = departureCity.indexOf('(') + 1;
        			var endIndex = departureCity.indexOf(')');
        			departureCity = departureCity.substring(startIndex, endIndex);
        		}
        		cityCodeAry.push(departureCity);
        		
        		var arriveCity = $('#arriveCity').val();
        		if($.trim(arriveCity).length > 0)
        		{
        			var startIndex = arriveCity.indexOf('(') + 1;
        			var endIndex = arriveCity.indexOf(')');
        			arriveCity = arriveCity.substring(startIndex, endIndex);
        		}
        		cityCodeAry.push(arriveCity);
        		
        		return cityCodeAry;
    		}
    		
    		//清空表单
    		function clearForm()
    		{
    			$('input[type=text]').val('');
    			$('select').val('');
    			$('input[tempName="bookingSource"]').attr('checked', false);
    		}
    		
    		//将条件插入到导出exportCsvForm
    		function conditionHtmlToExportCsvForm()
    		{
				$('#exportCsvDiv').html($('#conditionDiv').html());
				//去除exportCsvDiv所有元素的id和tempName属性
				$('#exportCsvDiv').find('select').removeAttr('id');
				$('#exportCsvDiv').find('input').removeAttr('id');
				$('#exportCsvDiv').find('input').removeAttr('tempName');
				//元素赋值
				$.each($('#conditionDiv').find('input[type="text"]'), function(index, obj)
				{
					var objName = $(obj).attr('name');
					if(objName == 'departureCity' || objName == 'arriveCity')
					{
						var cityCodeAry = getCityCode();
						var aryIndex = 0;
						if(objName == 'departureCity')
						{
							aryIndex = 0;
						}
						else
						{
							aryIndex = 1;
						}
						$('#exportCsvDiv').find('input[name="'+objName+'"]').attr('value', cityCodeAry[aryIndex]);
					}
					else
					{
						$('#exportCsvDiv').find('input[name="'+objName+'"]').attr('value', $(obj).val());
					}
				});
				$.each($('#conditionDiv').find('input[type="checkbox"]'), function(index, obj)
				{
					var objName = $(obj).attr('name');
					if($(obj).attr('checked'))
						$('#exportCsvDiv').find('input[name="'+objName+'"]').attr('checked', true);
				});
				$.each($('#conditionDiv').find('select'), function(index, obj)
				{
					var objName = $(obj).attr('name');
					$('#exportCsvDiv').find('select[name="'+objName+'"]').attr('value', $(obj).val());
				});
    		}
    		
    		//导出Csv
    		function exportCsv()
    		{
    			$('#exportCsvForm').submit();
    		}
		</script>
	</head>
	<body>
	<div class="content content1">
	    <input type="hidden" name="search" value="false">
		<div class="breadnav">首页 > 订单查询</div>
		<div class="infor1">
			<div class="order message">
				<div class="title">订单信息</div>
				<div class="main">
					<div class="part">
						<span>订单编号：</span><select id="orderNoType" name="orderNoType">
							<#list orderNoTypeEnum as orderNoType>
								<option value=${orderNoType}>${orderNoType.cnName}</option>
							</#list>
						</select><input type="text" id="orderNo" name="orderNo">
						<span>下单人工号：</span><input type="text" id="bookingManualNo" name="bookingManualNo"/>
					</div>	
 					<div class="part">
						<span>下单时间：</span><input type="text" id="orderBookingQueryBegTime" name="orderBookingQueryBegTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
						 - 
						<input type="text" id="orderBookingQueryEndTime" name="orderBookingQueryEndTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
						 	class="Wdate" readonly="readonly"/>
					</div>
					<div class="part">						
						<span>订单类型：</span><select id="orderType" name="orderType" onchange="setTicketStatus(this.value);">
							<option value="">全部</option>
							<#list orderTypeEnum as val>  
							   <option value="${val}">${val.cnName}</option>
							</#list>  
						</select>
						<span>机票状态：</span><select id="ticketStatus" name="orderStatus.orderTicketStatus">
							<option value="">全部</option>
						</select>							
						<span>订单状态：</span><select id="orderBackStatus" name="orderStatus.orderBackStatus">
							<option value="">全部</option>
							<#list orderBackStatusEnum as val>  
							   <#if val !="NULL">
							       <option value="${val}">${val.cnName}</option>
							   </#if>
							</#list>
						</select>
						<span>审核状态：</span><select id="orderAuditStatus" name="orderStatus.orderAuditStatus">
							<option value="">全部</option>
							<#list orderAuditStatusEnum as val>  
							  <#if val !="NULL">
							   <option value="${val}">${val.cnName}</option>
							  </#if> 
							</#list>
						</select>		
					</div>
					<div class="part">						
						<span>支付状态：</span><select id="orderPayStatus" name="orderStatus.orderPayStatus">
							<option value="">全部</option>
							<#list orderPayStatusEnum as val>  
							  <#if val !="NULL">
							   <option value="${val}">${val.cnName}</option>
							  </#if> 
							</#list>
						</select><!--
						<span>退款状态：</span>
						<select>
							<option value="">全部：</option>
							<option value="">待退款：</option>
							<option value="">已退款：</option>
						</select>-->
						<span>支付时间：</span><input type="text" id="payQueryBegTime" name="payQueryBegTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
						 - 
						<input type="text" id="payQueryEndTime" name="payQueryEndTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
					</div>
					<div class="part">
						<span>订单来源：</span>
						<#list bookingSourceEnum as bookingSource>
						   	<input type="checkbox" class="choose" tempName="bookingSource" name="bookingSources[${bookingSource_index}]" 
						   		value="${bookingSource}"/> ${bookingSource.cnName}
						</#list>							
					</div> 
				</div>
			</div> 
			<div class="product message">
				<div class="title">产品信息</div>
				<div class="main">
					<div class="part">
						<span>PNR：</span><input type="text" id="pnr" name="pnr"/>
						<span>票号：</span><input type="text" id="ticketNo" name="tickeNo"/>
						<span>供应商名称：</span>
						<select name="suppName" id="suppName">
								<option value="">全部</option>
								<#list supperList as supp>
									<option value="${(supp.name)!''}">${(supp.code)!''}</option>
								</#list>
							</select>
					</div>
					<div class="part">
					    <span>航班号：</span><input type="text" id="flightNo" name="flightNo"/>
						<span>航空公司：</span>
						<select name="carrierName" id="carrierName">
								<option value="">全部</option>
								<#list carriersList as carriers>
									<option value="${(carriers.name)!''}">${(carriers.code)!''} ${(carriers.name)!''}</option>
								</#list>
							</select>
					</div>
					<div class="part">
						<span>出发城市：</span><input type="text" id="departureCity" name="departureCity" mod="address|notice" mod_address_source="hotel" 
							mod_address_suggest="" mod_address_reference="getcityid" placeholder="中文/拼音"/>
						<span>到达城市：</span><input type="text" id="arriveCity" name="arriveCity" mod="address|notice" mod_address_source="hotel" 
							mod_address_suggest="" mod_address_reference="getcityid" placeholder="中文/拼音"/>
						<span>乘机时间：</span><input type="text" id="flightQueryBegTime" name="flightQueryBegTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
						 - 
						<input type="text" id="flightQueryEndTime" name="flightQueryEndTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
					</div>
				</div>
			</div>
			<div class="visitor message">
				<div class="title">游客信息</div>
				<div class="main">
					<div class="part">
						<span>驴妈妈账号：</span><input type="text" id="customerName" name="flightOrderCustomer.customerName"/>
						<span>已绑定手机号：</span><input type="text" id="customerCellphone" name="flightOrderCustomer.customerCellphone"/>
						<span>乘机人：</span><input type="text" id="passengerName" name="flightOrderPassenger.passengerName"/>
						<span>乘机人证件号：</span><input type="text" id="passengerIDCardNo" name="flightOrderPassenger.passengerIDCardNo"/>
					</div>
					<div class="part">
						<span>联系人姓名：</span><input type="text" id="contactName" name="flightOrderContacter.name"/>
						<span>联系人邮箱：</span><input type="text" id="contactEmail" name="flightOrderContacter.email"/>
						<span>联系人固话：</span><input type="text" id="contactTelphone" name="flightOrderContacter.telphone"/>
						<span>联系人手机：</span><input type="text" id="contactCellphone" name="flightOrderContacter.cellphone"/>
					</div>
				</div>
			</div>
			
		</div>
		<div class="click">
			<a href="javascript:void(0);" onclick="query();"><div class="button">查询</div></a>
			<a href="javascript:void(0);" onclick="clearForm();"><div class="button">清空</div></a>
			<a href="javascript:void(0);" onclick="exportCsv();"><div class="button">导出Csv</div></a>
			</div>
	</div>
	
	 <div class="content content1" style="margin-top:50px;">
      <table id="flightOrderList"></table>
      <div id="pager"></div>
    </div>
    <br>
    <br>
    <div style="display:none;">
     
         <select id="ticketStatus_NORMAL">
			<#list orderTicketIssueStatusEnum as val>  
			   	<option value="${val}">${val.cnName}</option>
			</#list>
		</select>
		 
		<select id="ticketStatus_RTVT">
			<#list orderTicketRTVTStatusEnum as val> 
			   	<option value="${val}">${val.cnName}</option>
			</#list>
		</select>	
		 
		<select id="ticketStatus_CTMT">
			<#list orderTicketCTMTStatusEnum as val>  
			    <option value="${val}">${val.cnName}</option>
			</#list>
		</select>	
    
    </div>
	
	<form id="exportCsvForm" action="${request.contextPath}/order/exportCsv" method="post" target="_blank">
		<div id="exportCsvDiv" style="display:none;">
		</div>
	</form>
	
	<div id="jsContainer" class="jsContainer" style="height: 0">
		<div id="tuna_alert"
			style="display: none; position: absolute; z-index: 999; overflow: hidden;"></div>
		<div id="tuna_jmpinfo"
			style="visibility: hidden; position: absolute; z-index: 120;"></div>
	</div>                  
	<script type="text/javascript" src="${request.contextPath}/js/fixdiv.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/address.js"></script>

	<!--显示支付信息-->
		<div class="office" id="showPayOperate" style="align:center;top:300px;dispaly:none;border:1px solid #e6e6e6;">
			<div class="o_title" id="showPayOperateTitle">
				订单支付<span class="o_close op" id="closeOpPay">X</span>	
			</div>
			<div class="o_content" id="payMentValue" style="top:10px;font-size:18px;">
	                              订单金额: RMB <span style="color:red;">
	                              
	                              </span>元
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
				<a href="javascript:void(0);"><span class="sure" onclick="payCallBack('${request.contextPath}/order/orderPayCallbackAjax')">支付</span></a>
				<a href="javascript:void(0);"><span class="cancle" onclick="canclePayOperate()">取消</span></a>
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



		<!--选择支付方式：按子单支付还是主单支付-->
		<div class="office" id="payMethodDialog" style="align:center;top:300px;dispaly:none;border:1px solid #e6e6e6;">
			<div class="o_title">
				支付方式<span class="o_close" id="closeRePay" >X</span>	
			</div>
			
			<div class="o_content"" id="payMethodRadioDiv" style="top:10px;font-size:25px;text-align:center;"">
				<input type="radio" name="payMethod" value="mainPay" checked="checked" /> 主单支付
	            <input type="radio" name="payMethod" value="subPay" /> 子单支付
	        </div>
	        
	        <div class="o_submit">
				<a href="javascript:void(0);"><span class="sure" onclick="selectPayMethod()">确认</span></a>
				<a href="javascript:void(0);"><span class="cancle" onclick="closePayMethodDialog()">关闭</span></a>
			</div>
		</div>
		
		<!--隐藏控件-->		
		<input type="hidden" name="paymentNoOperate" id="paymentNoOperate" />
		<input type="hidden" name="orderId" id="orderId" />
		<input type="hidden" name="orderMainId" id="orderMainId" />
</body>
</html>