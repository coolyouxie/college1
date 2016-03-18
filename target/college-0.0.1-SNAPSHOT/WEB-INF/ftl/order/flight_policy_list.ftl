<!DOCTYPE html>
<html>
  <head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  	<script type="text/javascript" src="http://s2.lvjs.com.cn/js/new_v/jquery-1.7.2.min.js"></script>
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
       		
			$("#flightPolicyList").jqGrid('setGridParam', {
				url : "${request.contextPath}/order/queryFlightPolicyList",
				datatype : "json",
				mtype : "POST",
				postData : getFlightPolicyParams()
			}).trigger("reloadGrid");
		}
		
		function getFlightPolicyParams() {
			return {
				'supp.id' : $("#suppName").val(),
				'carrier.id' : $("#carrierName").val(),
				'departureAirport' : $("#departureAirport").val(),
				'arrivalAirport' : $("#arriveAirport").val(),
				'startUpdateTime' : $("#startUpdateTime").val(),
				'endUpdateTime' : $("#endUpdateTime").val(),
				'search':false
			}
		}
		
		function formatLink(cellvalue, options, rowObject) {
		    var url = "${request.contextPath}/order/queryOrderDetail/"+rowObject.orderMainId+"/"+rowObject.orderId+"/NULL";
		    return  "<a href='"+url+"' style='color:blue;' target='_blank'>" + cellvalue + "</a>";
	    }
		
		function initGrid() {
			$("#flightPolicyList").jqGrid({
				url : "${request.contextPath}/order/queryFlightPolicyList",
				datatype : "json",
				mtype : "POST",
				colNames : ['政策ID', '供应商', '航空公司','起飞机场','到达机场','去程舱位','回程舱位','有效日期','维护时间','操作'],
				colModel : [ {
					name : 'id',formatter:formatLink,
					index : 'id',
					align : 'center',
					sortable:false
				}, {
					name : 'supp.name',
					index : 'supp',
					align : 'center',
					sortable:false
				}, {
					name : 'carrier.name',
					index : 'carrier',
					align : 'center',
					sortable:false
				}, {
					name : 'includeDepartureAirports',
					index : 'includeDepartureAirports',
					align : 'center',
					sortable:false
				}, {
					name : 'includeArrivalAirports',
					index : 'includeArrivalAirports',
					align : 'center',
					sortable:false
				},  {
					name : 'departureSeats',
					index : 'departureSeats',
					align : 'center',
					sortable:false
				},{
					name : 'arrivalSeats',
					index : 'arrivalSeats',
					align : 'center',
					sortable:false
				}, {
					name : 'policyEffectDateRange',
					index : 'policyEffectDateRange',
					align : 'center',
					sortable:false
				}, {
					name : 'lastUpdateDate',
					index : 'lastUpdateDate',
					align : 'center',
					sortable:false
				}, {
					name : 'operate',
					index : 'operate',
					align : 'center',
					sortable:false
				}],
				rowNum:10,            //每页显示记录数
		 	    autowidth: true,      //自动匹配宽度
		 	    pager: '#pager',      //表格数据关联的分页条，html元素
		   	    rowList:[10,20,50,500],   //分页选项，可以下拉选择每页显示记录数
		      	viewrecords: true,    //显示总记录数
		      	height:'auto',//高度，表格高度。可为数值、百分比或'auto'
			    //autoheight: true,     //设置高度
			    gridview:true,        //加速显示
				viewrecords: true,    //显示总记录数
				multiselect : false,
				sortable:true,        //可以排序
			    //sortname: 'bookingTime',  //排序字段名
		        //sortorder: "desc",    //排序方式：倒序
				caption : "政策列表",
				jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#flightPolicyList").jqGrid('setGridParam', {
						postData : getFlightPolicyParams()
					});
				},
				gridComplete:function(){  //在此事件中循环为每一行添加修改操作
                    var ids=jQuery("#flightPolicyList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                    	var id=ids[i];
                        operateClick= '<a href="#" style="color:blue" onclick="updatePolicy('+id+')" >修改</a>';
                        jQuery("#flightPolicyList").jqGrid('setRowData', id , {operate:operateClick});
                    }
                }
                
			});
		} 
		
		//修改
		function updatePolicy(id) {
		   	window.open("${request.contextPath}/order/toFlightPolicyExcludePage/"+id);
		}
	  
	
  	</script>
</head>
<body>
	<div class="content content1">
	<div class="breadnav"><span>首页</span> > 政策管理</div>
	 <form id="myForm">
		<div class="infor1">
			
			<div class="visitor message">
		
				<div class="main">
					<div class="part">
						<span> 供应商：</span><select class="gongyingshang" name="suppName" id="suppName">
							<option value="">全部</option>
							<#list supps as supp>
								<option value="${(supp.id)!''}">${(supp.name)!''}</option>
							</#list>
						</select>
						<span class="keyname">维护时间：</span>
						<input type="text" id="startUpdateTime"  name="startUpdateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/> - 
				        <input type="text" id="endUpdateTime"  name="endUpdateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
					</div>
					<div class="part">
					 <span>航空公司：</span><select name="carrierName" id="carrierName">
					    	<option value="">全部</option>
							<#list carriers as carrier>
								<option value="${(carrier.id)!''}">${(carrier.code)!''}&nbsp;&nbsp;${(carrier.name)!''}</option>
							</#list>
						</select>
					    <span>起飞机场：</span><input type="text" id="departureAirport"  name="departureAirport"/>
						<span>到达机场：</span><input type="text" id="arriveAirport"  name="arriveAirport"/>
					</div>
				</div>
			</div>
			
		</div>
		<div class="click">
			<a href="javascript:;"><div class="button" onclick="query()">查询</div></a> 
		</div>
		
	</form>
		  <div class="content1" style="margin-top:50px;">
			<table id="flightPolicyList"></table>
	        <div id="pager"></div>
          </div>
        <br>
        <br>
	</div>
	 
</body>
</html>