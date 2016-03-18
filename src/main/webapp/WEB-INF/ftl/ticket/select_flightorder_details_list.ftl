<!DOCTYPE html>
<html>
	<head>
 		<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
 		<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
 		<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
 		<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
 		<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
 		<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
 		<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>	
 		<script src="${request.contextPath}/js/Calendar.js"></script>
 		<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
 
 		<script type="text/javascript">
    		$(function()
    		{
				initGrid();
    		});	    
      
     	 	//查询列表信息   
			function query() 
			{
				$("#flightTicketList").jqGrid('setGridParam', 
				{
			 		url: "${request.contextPath}/ticket/searchTicketDetailsList",
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
					'suppName':$("#suppName").val(),
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
				$("#flightTicketList").jqGrid(
				{
					url : '${request.contextPath}/ticket/searchTicketDetailsList',
					datatype : "json",
					mtype : "POST",
					height:'auto',//高度，表格高度。可为数值、百分比或'auto'
	        		//width:1000,//这个宽度不能为百分比
	        		autowidth:true,//自动宽      
					colNames:['票号', '订单号','机票状态','PNR', '航程','航班号', '乘机时间','乘机人', '应收款','支付方式','下单时间', '渠道'],
					colModel : 
					[ 
						{
							name : 'ticketNo',
							index : 'ticketNo',
							align : 'center',
							width : 250,
							sortable:false
						},
						{
							name : 'orderNo',
							index : 'orderNo',formatter:formatLink,
							align : 'center',
							width : 280,
							sortable:false
						},
						{
							name : 'detailTicketStatusName',
							index : 'detailTicketStatusName',
							align : 'center',
							sortable:false
						},
						{
							name : 'pnr',
							index : 'pnr',
							align : 'center',
							sortable:false
						},
						{
							name : 'flightSegment',
							index : 'flightSegment',
							align : 'center',
							sortable:false
						},
						{
							name : 'flightNo',
							index : 'flightNo',
							align : 'center',
							sortable:false
						},
						{
							name : 'flightTime',
							index : 'flightTime',
							align : 'center',
							width : 310,
							sortable:false
						},
						{
							name : 'passengerName',
							index : 'passengerName',
							align : 'center',
							sortable:false
						},
						{
							name : 'receivableAmount',
							index : 'receivableAmount',
							align : 'center',
							sortable:false
						},
						{
							name : 'paymentMethod',
							index : 'paymentMethod',
							align : 'center',
							sortable:false
						},
						{
							name : 'orderCreateTime',
							index : 'orderCreateTime',
							align : 'center',
							width : 310,
							sortable:false
						},
						{
							name : 'bookingSourceName',
							index : 'bookingSourceName',
							align : 'center',
							sortable:false
						}
					],
            		autowidth : true,
					rowNum : 10,
					pager : '#pager',
					viewrecords : true,
					rowList:[10,20,50,200],   //分页选项，可以下拉选择每页显示记录数
					multiselect : false,
					caption : "客票明细查询列表",
					jsonReader : {
						root : "results",
						page : "pagination.page", //当前页
						records : "pagination.records", //总记录数
						total:'pagination.total',
						repeatitems : false
					},
					onPaging : function(pgButton) 
					{
						$("#flightTicketList").jqGrid('setGridParam', 
						{
							postData : getQueryParams()
						});
					}
				});
			}
    
    		function formatLink(cellvalue, options, rowObject) 
    		{
	    		var url = "${request.contextPath}/order/queryOrderDetail/"+rowObject.orderMainId+"/"+rowObject.orderId+"/NULL";
	    		return "<a href='"+url+"' style='color:blue;' target='_blank'>" + cellvalue + "</a>";
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
		<div class="breadnav">首页 > 客票明细查询</div>
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
						<span>航司/航班号：</span><input type="text" id="flightNo" name="flightNo"/>
						<span>供应商名称：</span><input type="text" id="suppName" name="suppName"/>
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
      <table id="flightTicketList"></table>
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
	
	<form id="exportCsvForm" action="${request.contextPath}/ticket/exportCsv" method="post" target="_blank">
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
</body>
</html>