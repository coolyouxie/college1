<!DOCTYPE html>
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
	<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script> 
	
    <script type="text/javascript">
    
	    $(function (){
			initGrid();
	    });    
		
		//查询列表信息   
		function query() { 
			$("#ticketRemindReportList").jqGrid('setGridParam', {
				url : "${request.contextPath}/report/queryTicketRemindList",
				datatype : "json",
				mtype : "POST",
				postData : getParams()
			}).trigger("reloadGrid");
			
		
		}
		
		//清空查询信息   
		function reset() { 
			document.getElementById("myForm").reset()
		}
		
	
		function getParams() {
		    // 城市编码
		    var cityCodeAry = getCityCode(); 
			return {
				'bookingQueryBegTime' : $("#bookingQueryBegTime").val(),
				'bookingQueryEndTime' : $("#bookingQueryEndTime").val(),
				'carrierCode' : $("#carrierCode").val(),
				'suppCode' : $("#suppCode").val(),
				'flightQueryBegTime' : $("#flightQueryBegTime").val(),
				'flightQueryEndTime' : $("#flightQueryEndTime").val(),
				'depCode' : cityCodeAry[0],
				'arrCode' : cityCodeAry[1],
				'bookingSource' : $("#bookingSource").val(),
				'orderNo' : $("#orderNo").val(),
				'search' : false
			}
		}
		
		function orderLink(cellvalue, options, rowObject) {
		      var url = "${request.contextPath}/order/queryOrderDetail/"+rowObject.orderMainId+"/"+rowObject.orderId+"/NULL";
	          return  "<a href='"+url+"' style='color:blue;' target='_blank'>" + cellvalue + "</a>";
    	}
    	
		function initGrid() { 
			$("#ticketRemindReportList").jqGrid({
				url : "${request.contextPath}/report/queryTicketRemindList",
				datatype : "json",
				mtype : "POST",
			colNames : ['订单号','订单类型','下单时间','处理时间','供应商','销售渠道','航空公司'
				,'航班号','始发地','目的地','支付方式','产品类型','出票速度'],
			colModel : [ {
					name : 'orderNo',formatter:orderLink,
					index : 'orderNo',
					align : 'center',
					width : 130,
					sortable:false
				}, 
				{
					name : 'orderTypeStr',
					index : 'orderTypeStr',
					align : 'center',
					width : 60,
					sortable:false
				}, {
					name : 'orderStartTime',
					index : 'orderStartTime',
					align : 'center',
					sortable:false
				}, 
				{
					name : 'orderEndTime',
					index : 'orderEndTime',
					align : 'center',
					sortable:false
				},  {
					name : 'supp.code',
					index : 'name',
					width : 80,
					align : 'center',
					sortable:false
				},  {
					name : 'bookingSourceStr',
					index : 'bookingSourceStr',
					align : 'center',
					width : 80,
					sortable:false
				},{
					name : 'carrier.code',
					index : 'name2',
					align : 'center',
					width : 70,
					sortable:false
				},{
					name : 'flightNo',
					index : 'flightNo',
					align : 'center',
					width : 80,
					sortable:false
				}, {
					name : 'depAirportCityName',
					index : 'depAirportCityName',
					width : 80,
					align : 'center',
					sortable:false
				}, {
					name : 'arrAirportCityName',
					index : 'arrAirportCityName',
					align : 'center',
					width : 80,
					sortable:false
				}, {
					name : 'paymentTypeStr',
					index : 'paymentTypeStr',
					align : 'center',
					width : 70,
					sortable:false
				}, {
					name : 'productStr',
					index : 'productStr',
					align : 'center',
					width : 70,
					sortable:false
				}, {
					name : 'ticketSpeed',
					index : 'ticketSpeed',
					width : 70,
					align : 'center',
					sortable:false
				}
				],
				shrinkToFit:false,
				autoScroll: false,
				rowNum:10,            //每页显示记录数
		 	    autowidth: true,      //自动匹配宽度
		 	    pager: '#pager',      //表格数据关联的分页条，html元素
		   	   	rowList:[10,20,50,200],   //分页选项，可以下拉选择每页显示记录数
		      	viewrecords: true,    //显示总记录数
		      	height:'auto',//高度，表格高度。可为数值、百分比或'auto'
			    //autoheight: true,     //设置高度
			    gridview:true,        //加速显示
				viewrecords: true,    //显示总记录数
				multiselect : false,
				sortable:true,        //可以排序
			    sortname: 'orderCreateTime',  //排序字段名
		        sortorder: "desc",    //排序方式：倒序
				caption : '出票超时列表',
				jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#ticketRemindReportList").jqGrid('setGridParam', {
						postData : getParams()
					});
				}
			});
		} 
		
		    //获取城市编码
		     //获取城市编码
    		function getCityCode()
    		{
    			var cityCodeAry = new Array(); 
    			
    			//设置出发城市和目的城市
        		var departureCity = $('#depCode').val();
        		if($.trim(departureCity).length > 0)
        		{
        			var startIndex = departureCity.indexOf('(') + 1;
        			var endIndex = departureCity.indexOf(')');
        			departureCity = departureCity.substring(startIndex, endIndex);
        		}
        		cityCodeAry.push(departureCity);
        		
        		var arriveCity = $('#arrCode').val();
        		if($.trim(arriveCity).length > 0)
        		{
        			var startIndex = arriveCity.indexOf('(') + 1;
        			var endIndex = arriveCity.indexOf(')');
        			arriveCity = arriveCity.substring(startIndex, endIndex);
        		}
        		cityCodeAry.push(arriveCity);
        		
        		return cityCodeAry;
    		}
    	
	
		
			//导出Csv
	function exportCsv()
	{  var cityCodeAry = getCityCode(); 
		$("#depCode").val(cityCodeAry[0]);		
		$("#arrCode").val(cityCodeAry[1]);		
		$('#myForm').submit();
	}

	
  </script>
</head>
<body>
	<div class="content content1">
	<div class="breadnav"><span>首页</span> > </div>
	 <form id="myForm" action="${request.contextPath}/report/exportTicketRemindExcel" method="post" target="_blank">
		<div class="infor1" id="conditionDiv">
			<div class="product message">
				<div class="main">
					<div class="part">
					 	<span>订单号：</span><input type="text" id="orderNo" name="orderNo"/>
						<span>下单日期：</span>
						<input type="text" id="bookingQueryBegTime" name="bookingQueryBegTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
						 - 
						<input type="text" id="bookingQueryEndTime" name="bookingQueryEndTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
						 	class="Wdate" readonly="readonly"/>
						<span>订单类型：</span><select style="width: 135px" id="orderType" name="orderType">
						<option value="">全部</option> 
					    <#list orderTypeEnum as val>  
					    <option value="${val}">${val.cnName}</option>
					    </#list> 
				        </select>
						
					</div>
					<div class="part">
				
					
						<span>销售渠道：</span><select style="width: 138px" id="bookingSource" name="bookingSource">
						<option value="">全部</option> 
					    <#list bookingSourceEnum as val>  
					    <option value="${val}">${val.cnName}</option>
					    </#list></select>
			
					<span>航班日期：</span><input type="text" id="flightQueryBegTime" name="flightQueryBegTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
						 - 
						<input type="text" id="flightQueryEndTime" name="flightQueryEndTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
						 	class="Wdate" readonly="readonly"/>
					
						<span>供应商：</span><select style="width: 135px" id="suppCode" name="suppCode">
						<option value="">全部</option> 
					    <#list supps as val>  
					    <option value="${val.code}">${val.name}</option>
					    </#list> 
				        </select>
					</div>
					<div class="part">
					<span>出发城市：</span><input type="text" id="depCode" name="depCode" mod="address|notice" mod_address_source="hotel" 
							mod_address_suggest="" mod_address_reference="getcityid" placeholder="中文/拼音"/>
					<span>到达城市：</span><input type="text" id="arrCode" name="arrCode" mod="address|notice" mod_address_source="hotel" 
							mod_address_suggest="" mod_address_reference="getcityid" placeholder="中文/拼音"/>
					</div>
				</div>
			</div>
			
			
		</div>
		</form>
	
		<div class="click">
			<a href="javascript:;"><div class="button" onclick="exportCsv()">导出</div></a>
				<a href="javascript:;"><div class="button" onclick="query()">查询</div></a> 
		       
		</div>
	
		  <div class="content1" style="margin-top:50px;">
			<table id="ticketRemindReportList"></table>
	        <div id="pager"></div>
          </div>
        <br>
        <br>
	</div>
	 

	
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