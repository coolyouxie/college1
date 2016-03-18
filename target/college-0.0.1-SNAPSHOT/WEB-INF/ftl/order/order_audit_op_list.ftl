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
			$("#orderAuditOpList").jqGrid('setGridParam', {
				url : "${request.contextPath}/order/queryAuditOpList",
				datatype : "json",
				mtype : "POST",
				postData : getAuditOpParams()
			}).trigger("reloadGrid");
		}
		
		//清空查询信息   
		function reset() { 
			document.getElementById("myForm").reset()
		}
	
		function getAuditOpParams() {
		    // 城市编码
		    var cityCodeAry = getCityCode(); 
			return {
				'orderAuditOpType' : $("#orderAuditOpType").val(),
				'orderNoType' : $("#orderNoTypeEnum").val(),
				'excOrderNo' : $("#excOrderNo").val(),
				'pnr' : $("#pnr").val(),
				'ticketNo' : $("#ticketNo").val(),
				'opTimeType' : $("#opTimeTypeEnum").val(),
				'opBegTime' : $("#opBegTime").val(),
				'opEndTime' : $("#opEndTime").val(),
				'flightNo' : $("#flightNo").val(),
				'departureCity' : cityCodeAry[0],
				'arriveCity' : cityCodeAry[1],
				'orderStatus' : $("#curOrderStatusEnum").val(),
				'customerName' : $("#customerName").val(),
				'contacterName' : $("#contacterName").val(),
				'opPersonType' : $("#opPersonTypeEnum").val(),
				'opPerson' : $("#opPerson").val(),
				'passenger' : $("#passenger").val(),
				'passengerCellphone' : $("#passengerCellphone").val(),
				'passengerIDCardNo' : $("#passengerIDCardNo").val(),
				'lvmamaAccount' : $("#lvmamaAccount").val(),
				'search' : false
			}
		}
	
		function orderLink(cellvalue, options, rowObject) {
		      var url = "${request.contextPath}/order/queryOrderDetail/"+rowObject.orderMainId+"/"+rowObject.orderId+"/NULL";
	          return  "<a href='"+url+"' style='color:blue;' target='_blank'>" + cellvalue + "</a>";
    	}
    	
    	function formatLink(cellvalue, options, rowObject) {
		      var url = "${request.contextPath}/order/queryOrderDetail/"+rowObject.orderMainId+"/"+rowObject.orderId+"/"+rowObject.opType;
	          return  "<a href='"+url+"' style='color:blue;' target='_blank'>" + cellvalue + "</a>";
    	}
    	
		function initGrid() { 
			$("#orderAuditOpList").jqGrid({
				url : "${request.contextPath}/order/queryAuditOpList?orderAuditOpType="+$("#orderAuditOpType").val(),
				datatype : "json",
				mtype : "POST",
				colNames : ['订单号',<#if orderAuditOpType !='ISSUEAUDIT' && orderAuditOpType !='ISSUEOP' >'原订单号',</#if> '会员', 
				'流程状态',<#if orderAuditOpType =='ISSUEAUDIT' || orderAuditOpType =='ISSUEOP' >'供应商审核状态',</#if>'效率',
				'PNR','航程','航班号','舱位','起飞时间','备注','业务员','预定时间','操作'],
				colModel : [ {
					name : 'flightOrderNo.orderNo',formatter:orderLink,
					index : 'orderNo',
					align : 'center',
					width : 280,
					sortable:false
				}, 
				<#if orderAuditOpType !='ISSUEAUDIT' && orderAuditOpType !='ISSUEOP' >
				{
					name : 'preOrderNo',
					index : 'preOrderNo',
					align : 'center',
					width : 280,
					sortable:false
				},
				</#if>
				{
					name : 'flightOrderCustomer.customerName',
					index : 'customerName',
					align : 'center',
					sortable:false
				}, {
					name : 'orderStatus',
					index : 'orderStatus',
					align : 'center',
					sortable:false
				}, 
				<#if orderAuditOpType =='ISSUEAUDIT' || orderAuditOpType =='ISSUEOP' >
				{
					name : 'suppOrderAuditStatus',
					index : 'suppOrderAuditStatus',
					align : 'center',
					width : 220,
					sortable:false
				},
				</#if>
				{
					name : 'efficiency',
					index : 'efficiency',
					align : 'center',
					sortable:false
				}, {
					name : 'flightOrderPNRInfo.pnr',
					index : 'pnr',
					align : 'center',
					sortable:false
				},  {
					name : 'flightSegment',
					index : 'flightSegment',
					align : 'center',
					sortable:false
				},{
					name : 'flightNo',
					index : 'flightNo',
					align : 'center',
					sortable:false
				}, {
					name : 'seatClassCode',
					index : 'seatClassCode',
					align : 'center',
					width : 100,
					sortable:false
				}, {
					name : 'flightTime',
					index : 'flightTime',
					align : 'center',
					width : 260,
					sortable:false
				}, {
					name : 'remark',
					index : 'remark',
					align : 'center',
					width : 220,
					sortable:false
				}, {
					name : 'oper',
					index : 'oper',
					align : 'center',
					sortable:false
				}, {
					name : 'bookingTime',
					index : 'bookingTime',
					align : 'center',
					width : 310,
					sortable:false
				}, {
					name : 'operateType',
					index : 'operateType',formatter:formatLink,
					align : 'center',
					width : 100,
					sortable:false
				}
				],
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
			    sortname: 'bookingTime',  //排序字段名
		        sortorder: "desc",    //排序方式：倒序
				caption : '${orderAuditOpTypeName}'+"列表",
				jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#orderAuditOpList").jqGrid('setGridParam', {
						postData : getAuditOpParams()
					});
				}
			});
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
	
  </script>
</head>
<body>
	<div class="content content1">
	<div class="breadnav"><span>首页</span> > ${orderAuditOpTypeName}</div>
	 <form id="myForm" autocomplete="off" >
		<div class="infor1">
			<div class="product message">
	            <input type="hidden" id="orderAuditOpType" name="orderAuditOpType" value="${orderAuditOpType}"/>
				<div class="main">
					<div class="part">
						<select id="orderNoTypeEnum" name="orderNoType">
					        <#list orderNoTypeEnum as val>  
					        <option value="${val}">${val.cnName}</option>
					        </#list>  
				        </select><input type="text" id="excOrderNo" name="excOrderNo"/>				       
						<span>PNR：</span><input type="text" id="pnr" name="pnr"/>
						<!--<span></span>--><select id="opTimeTypeEnum" name="opTimeType">
					    <#list opTimeTypeEnum as val>  
					    <option value="${val}">${val.cnName}</option>
				     	</#list>  
				        </select><input type="text" id="opBegTime"  name="opBegTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/> - 
				        <input type="text" id="opEndTime"  name="opEndTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
						
					</div>
					<div class="part">
					   <select id="opPersonTypeEnum" name="opPersonType">
					   <#list opPersonTypeEnum as val>  
					   <option value="${val}">${val.cnName}</option>
					   </#list> 
				       </select><input type="text" id="opPerson"  name="opPerson"/>
						<span>航班号：</span><input type="text" id="flightNo"  name="flightNo"/>
						<span>票号：</span><input type="text" id="ticketNo"  name="ticketNo"/>
						<span>驴妈妈账号：</span><input type="text" id="lvmamaAccount"  name="lvmamaAccount" />
					</div>
				</div>
			</div>
			<div class="visitor message">
		
				<div class="main">
					<div class="part">
						<span>乘客姓名：</span><input type="text" id="passenger"  name="passenger"/>
					    <span>乘客手机：</span><input type="text" id="passengerCellphone"  name="passengerCellphone"/>
						<span>乘客证件：</span><input type="text" id="passengerIDCardNo"  name="passengerIDCardNo"/>
						<span>订单状态：</span><select id="curOrderStatusEnum" name="orderStatus"> 
						<#if orderAuditOpType =='ISSUEOP' || orderAuditOpType =='RTVTOP' || orderAuditOpType =='CTMTOP'>
						<option value="">全部</option> 
						</#if>
					    <#list curOrderStatusEnum as val> 
					    <#if val =='NULL'>
						<option value="${val}">全部</option> 
						<#else>
						<option value="${val}">${val.cnName}</option> 
						</#if>
					    </#list> 
					   
				</select> 
					</div>
					<div class="part">
					    <span>出发城市：</span><input type="text" id="departureCity" name="departureCity" mod="address|notice" mod_address_source="hotel" 
							mod_address_suggest="" mod_address_reference="getcityid" placeholder="中文/拼音"/>
						<span>到达城市：</span><input type="text" id="arriveCity" name="arriveCity" mod="address|notice" mod_address_source="hotel" 
							mod_address_suggest="" mod_address_reference="getcityid" placeholder="中文/拼音"/>
						<span>联系人姓名：</span><input type="text" id="contacterName"  name="contacterName"/>
						<span>联系人电话：</span><input type="text" id="contactPhone"  name="contactPhone"/>
					</div>
				</div>
			</div>
			
		</div>
		<div class="click">
				<a href="javascript:;"><div class="button" onclick="query()">查询</div></a> 
		        <a href="javascript:;"><div class="button" onclick="reset()">清空</div></a>
		</div>
	</form>
		  <div class="content1" style="margin-top:50px;">
			<table id="orderAuditOpList"></table>
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