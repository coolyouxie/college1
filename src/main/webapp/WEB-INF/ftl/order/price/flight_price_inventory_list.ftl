<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>航班运库存管理</title>
	<link rel="stylesheet" href="${request.contextPath}/css/trip-list.css">
	<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/area_tankuang.css" />
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
    
    	//获取城市编码
		function getCityCode(){
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
    					   
	 //组装查询的参数
 	function getQueryParams() {
 		var cityCodeAry = getCityCode(); 
		return {
			'flightNo' : $("#flightNo").val(),
			'seatClassCode' : $("#seatClassCode").val(),
			'departureDateTime' : $("#departureDateTime").val(),
			'suppCode' : $("#suppCode").val(),
			'departureCityCode':cityCodeAry[0],
			'arrivalCityCode':cityCodeAry[1]
		}
	}
			
	//查询列表信息   
	function searchFlightPriceInventory() {  
		$("#flightPriceInventoryList").jqGrid('setGridParam', {
			url : "${request.contextPath}/price/queryFlightPriceInventoryList",
			datatype : "json",
			mtype : "POST",
			postData : getQueryParams()
		}).trigger("reloadGrid");
	 }
	     
	      //加载表格数据
		function initGrid() {
		    var colNames = ['运价库存ID','供应商', '航班号','舱位','航班日期','出发时间','到达时间','出发城市','到达城市','库存状态','库存数量','票面价','y舱票面价','结算价','LV舱位代码'];		
			$("#flightPriceInventoryList").jqGrid({
				url : "${request.contextPath}/price/queryFlightPriceInventoryList",
				datatype : "json",
				mtype : "POST",
				colNames :colNames,
				colModel : [{
					name : 'id',
					index : 'id',
					align : 'center',
					width :30,
					sortable:false
				},{
					name : 'suppCode',
					index : 'suppCode',
					align : 'center',
					width :40,
					sortable:false
				},{
					name : 'flightNo',
					index : 'flightNo',
					align : 'center',
					width :30,
					sortable:false
				}, {
					name : 'seatClassCode',
					index : 'seatClassCode',
					align : 'center',
					width :30,
					sortable:false
				}, {
					name : 'departureDate',
					index : 'departureDate',
					align : 'center',
					width :50,
					sortable:false
				},  {
					name : 'departureTime',
					index : 'departureTime',
					align : 'center',
					width :50,
					sortable:false
				},  {
					name : 'arrivalTime',
					index : 'arrivalTime',
					align : 'center',
					width :50,
					sortable:false
				},{
					name : 'departureCityCode',
					index : 'departureCityCode',
					align : 'center',
					width :40,
					sortable:false
				}, {
					name : 'arrivalCityCode',
					index : 'arrivalCityCode',
					align : 'center',
					width :30,
					sortable:false
				}, {
					name : 'inventoryStatus',
					index : 'inventoryStatus',
					align : 'center',
					width :50,
					sortable:false
				}, {
					name : 'inventoryCount',
					index : 'inventoryCount',
					align : 'center',
					width :50,
					sortable:false
				}, {
					name : 'parPrice',
					index : 'parPrice',
					align : 'center',
					width :30,
					sortable:false
				}, {
					name : 'yparPrice',
					index : 'yparPrice',
					align : 'center',
					width :30,
					sortable:false
				}, {
					name : 'settlePrice',
					index : 'settlePrice',
					align : 'center',
					width :50,
					sortable:false
				},{
					name : 'lvSeatClassCode',
					index : 'lvSeatClassCode',
					align : 'center',
					width :50,
					sortable:false
				}
				],
				rowNum:10,            //每页显示记录数
		 	    autowidth: true,      //自动匹配宽度
		 	    pager: '#pager',      //表格数据关联的分页条，html元素
		   	    rowList:[10,20,50,500],   //分页选项，可以下拉选择每页显示记录数
		      	viewrecords: true,    //显示总记录数
		      	height:'auto',//高度，表格高度。可为数值、百分比或'auto'
			    gridview:true,        //加速显示
				viewrecords: true,    //显示总记录数
				multiselect : true,   //是否设置全选按钮
				sortable:true,        //可以排序
			    sortname: 'searchTime',  //排序字段名
		        sortorder: "desc",    //排序方式：倒序
				caption : "运价库存列表",
				jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#flightPriceInventoryList").jqGrid('setGridParam', {
						postData : getQueryParams()
					});
				},
				gridComplete:function(){  //在此事件中循环为每一行添加修改操作
                }
			});
		} 
 
     //删除的对象
	function getFlightPriceInventoryList(rowDataVal){
		var flightPriceInventoryList = new Array();
		rowDataVal = rowDataVal + '';
		var result=rowDataVal.split(",");
		for(var i=0;i<result.length;i++){
		  var obj = new Object;
		  obj = result[i];
		  flightPriceInventoryList[i] = obj;
		}
		return flightPriceInventoryList;
	}
	
   //批量删除
   function batchDelFlightPriceInventory(){
	   var rowData = jQuery('#flightPriceInventoryList').jqGrid('getGridParam','selarrrow');
	   if(rowData==""){
	      alert("请选取需要删除的数据！");
	      return;
	   }

	    $.ajax({
			url : "${request.contextPath}/price/batchDelFlightPriceInventory",
			type:'post',
	        dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
			    flightPriceInventoryList:getFlightPriceInventoryList(rowData)
				}),
			success: function(data){
			   alert(data.message);
			   searchFlightPriceInventory();
   			},
   			error: function (data) {
             	alert(eval('(' + data.responseText + ')').message);
            }
	    });
	  }
   
  </script>
</head>    
<body>
	<div class="content content1">
	  <form id="myForm">
	    <div class="breadnav"><span>首页</span> > 运价库存查询</div>
		<div class="cheak">
			<div class="part part1">
				<span>航班号：</span><input type="text" name="flightNo" id="flightNo" />
				<span>舱位：</span><input type="text" name="seatClassCode" id="seatClassCode" />
				<span>航班日期：</span><input type="text" id="departureDateTime" name="departureDateTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
			 </div>
				
			<div class="part part2">
			   <span>供应商：</span><input type="text" name="suppCode" id="suppCode" />
			    <span>出发城市：</span>
				<input type="text" id="departureCity" name="departureCity" mod="address|notice" mod_address_source="hotel" 
					mod_address_suggest="" mod_address_reference="getcityid" placeholder="中文/拼音"/>
				<span>到达城市：</span>
				<input type="text" id="arriveCity" name="arriveCity" mod="address|notice" mod_address_source="hotel" 
					mod_address_suggest="" mod_address_reference="getcityid" placeholder="中文/拼音"/>
				
				<div class="click">
					<a href="javascript:void(0);"><div class="button" onclick="searchFlightPriceInventory()" >查询</div></a>
				    <a href="javascript:void(0);"><div class="button" onclick="batchDelFlightPriceInventory()">批量删除</div> </a>
				</div>
			</div>
		</div>
	  </form>
	</div>
		
	<div class="content content1" style="top:150px;">
     <table id="flightPriceInventoryList"></table>
     <div id="pager"></div>
     </div>
     <br>
     <br>
	</div>
	
<div id="jsContainer" class="jsContainer" style="height: 0">
<div id="tuna_alert" style="display: none; position: absolute; z-index: 999; overflow: hidden;"></div>
<div id="tuna_jmpinfo" style="visibility: hidden; position: absolute; z-index: 120;"></div>
</div>                  
<script type="text/javascript" src="${request.contextPath}/js/fixdiv.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/address.js"></script>
	
</body>
</html>
