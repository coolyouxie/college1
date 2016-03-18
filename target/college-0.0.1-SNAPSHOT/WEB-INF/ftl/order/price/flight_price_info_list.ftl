<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>航班运价基本信息管理</title>
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
	    
		 //组装查询的参数
	 	function getQueryParams() {
			return {
				'flightNo' : $("#flightNo").val(),
				'seatClassCode' : $("#seatClassCode").val(),
				'departureDateTime' : $("#departureDateTime").val(),
				'departureAirportCode' : $("#departureAirportCode").val(),
				'arrivalAirportCode' : $("#arrivalAirportCode").val()
			}
		}
				
		//查询列表信息   
		function searchFlightPriceInfo() {  
			$("#flightPriceInfoList").jqGrid('setGridParam', {
				url : "${request.contextPath}/price/queryFlightPriceInfoList",
				datatype : "json",
				mtype : "POST",
				postData : getQueryParams()
			}).trigger("reloadGrid");
		 }
	     
	      //加载表格数据
		function initGrid() {
		    var colNames = ['运价信息ID','航班号','舱位','航班日期','起飞时间','到达时间','出发机场','到达机场','库存数量','票面价','y舱票面价','折扣','LV舱位代码'];		
			$("#flightPriceInfoList").jqGrid({
				url : "${request.contextPath}/price/queryFlightPriceInfoList",
				datatype : "json",
				mtype : "POST",
				colNames :colNames,
				colModel : [{
					name : 'id',
					index : 'id',
					align : 'center',
					width :30,
					sortable:false
				}, {
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
					name : 'departureAirportCode',
					index : 'departureAirportCode',
					align : 'center',
					width :40,
					sortable:false
				}, {
					name : 'arrivalAirportCode',
					index : 'arrivalAirportCode',
					align : 'center',
					width :30,
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
					name : 'discount',
					index : 'discount',
					align : 'center',
					width :50,
					sortable:false,
					formatter:function(v){
                         return (v*100).toFixed(0)+"%";
                   } 
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
					$("#flightPriceInfoList").jqGrid('setGridParam', {
						postData : getQueryParams()
					});
				},
				gridComplete:function(){  //在此事件中循环为每一行添加修改操作
                }
			});
		} 
 
        //删除的对象
		function getFlightPriceInfoList(rowDataVal){
			var flightPriceInfoList = new Array();
			rowDataVal = rowDataVal + '';
			var result=rowDataVal.split(",");
			for(var i=0;i<result.length;i++){
			  var obj = new Object;
			  obj = result[i];
			  flightPriceInfoList[i] = obj;
			}
			return flightPriceInfoList;
		}
         
       //批量删除
	   function batchDelFlightPriceInfo(){
		   var rowData = jQuery('#flightPriceInfoList').jqGrid('getGridParam','selarrrow');
		   if(rowData==""){
		      alert("请选取需要删除的数据！");
		      return;
		   }
		   
		   $.ajax({
				url : "${request.contextPath}/price/batchDelFlightPriceInfo",
				type:'post',
		        dataType : "json",
				contentType : "application/json;",
				data : JSON.stringify({
				    flightPriceInfoList:getFlightPriceInfoList(rowData)
					}),
				success: function(data){
				   alert(data.message);
				   searchFlightPriceInfo();
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
	    <div class="breadnav"><span>首页</span> > 运价基本信息查询</div>
		    <div class="cheak">
				<div class="part part1">
					<span>航班号：</span><input type="text" name="flightNo" id="flightNo" />
					<span>舱位：</span><input type="text" name="seatClassCode" id="seatClassCode" />
					<span>航班日期：</span><input type="text" id="departureDateTime" name="departureDateTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
				<div class="part part2">
			   		<span>出发机场：</span><input type="text" name="departureAirportCode" id="departureAirportCode" />
					<span>到达机场：</span><input type="text" name="arrivalAirportCode" id="arrivalAirportCode" />
				<div class="click">
					<a href="javascript:void(0);"><div class="button" onclick="searchFlightPriceInfo()" >查询</div></a>
				    <a href="javascript:void(0);"><div class="button" onclick="batchDelFlightPriceInfo()">批量删除</div></a>
				</div>
		   </div>
		</div>
	  </form>
	</div>
		
	<div class="content content1" style="top:150px;">
	 <table id="flightPriceInfoList"></table>
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
