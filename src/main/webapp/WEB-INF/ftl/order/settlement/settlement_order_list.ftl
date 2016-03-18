<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>结算列表</title>
<link rel="stylesheet" href="${request.contextPath}/css/trip-list.css">
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
	  
	//组装查询的参数
 	function getQueryParams() {
		return {
			'mainBusinessNo' : $("#mainBusinessNo").val(),
			'businessNo' : $("#businessNo").val(),
			'suppCode' : $("#suppCode").val(),
			'startPayedTime' : $("#startPayedTime").val(),
			'endPayedTime' : $("#endPayedTime").val(),
			'startCreateTime' : $("#startCreateTime").val(),
			'endCreateTime' : $("#endCreateTime").val(),
			'startUsedTime' : $("#startUsedTime").val(),
			'endUsedTime' : $("#endUsedTime").val(),
			'businessContacter' : $("#businessContacter").val(),
			'businessStatus' : $("#businessStatus").val(),
			'settlementOrderNo' : $("#settlementOrderNo").val(),
			'statementStatus' : $("#statementStatus").val(),
			'orderSettlementStatus' : $("#orderSettlementStatus").val(),
			'search':false    
		}
	}
			
	//查询列表信息   
	function query() {  
		$("#settlementOrderList").jqGrid('setGridParam', {
			url : "${request.contextPath}/settlement/queryInsuranceOrderList",
			datatype : "json",
			mtype : "POST",
			postData : getQueryParams()
		}).trigger("reloadGrid");
	 }
		
	//清空查询信息   
	function reset() { 
		document.getElementById("myForm").reset()
	}
     
    //加载表格数据
	function initGrid() {
		$("#settlementOrderList").jqGrid({
			url : "${request.contextPath}/settlement/queryInsuranceOrderList",
			datatype : "json",
			mtype : "POST",
			colNames : ['结算单号','主单号','子单号','订单状态','支付状态','支付时间','创单时间','使用时间','联系人','产品名称','销售单价','结算单价','实际结算单价','订购数量','退款金额','退款备注','结算总价','客户应付总额','实际结算金额','实付打款金额','供应商','结算单状态','结算状态','推送至VST'],
			colModel : [{
				name : 'settlementOrderNo',
				index : 'settlementOrderNo',
				align : 'center',
				sortable:false
			},{
				name : 'mainBusinessNo',
				index : 'mainBusinessNo',
				align : 'center',
				sortable:false
			},{
				name : 'businessNo',
				index : 'businessNo',
				align : 'center',
				sortable:false
			},{
				name : 'orderStatus',
				index : 'orderStatus',
				align : 'center',
				sortable:false
			},{
				name : 'payStatus',
				index : 'payStatus',
				align : 'center',
				sortable:false
			}, {
				name : 'payedDate',
				index : 'payedDate',
				align : 'center',
				sortable:false
			},{
				name : 'createDate',
				index : 'createDate',
				align : 'center',
				sortable:false
			}, {
				name : 'usedDate',
				index : 'usedDate',
				align : 'center',
				sortable:false
			},{
				name : 'businessContacter',
				index : 'businessContacter',
				align : 'center',
				sortable:false
			},{
				name : 'businessDesc',
				index : 'businessDesc',
				align : 'center',
				sortable:false
			}, {
				name : 'salesPrice',
				index : 'salesPrice',
				align : 'center',
				sortable:false
			},{
				name : 'settlePrice',
				index : 'settlePrice',
				align : 'center',
				sortable:false
			},{
				name : 'to3rdSettlePrice',
				index : 'to3rdSettlePrice',
				align : 'center',
				sortable:false
			},{
				name : 'businessSize',
				index : 'businessSize',
				align : 'center',
				sortable:false
			},{
				name : 'refundedAmount',
				index : 'refundedAmount',
				align : 'center',
				sortable:false
			},{
				name : 'refundRemark',
				index : 'refundRemark',
				align : 'center',
				sortable:false
			}, {
				name : 'to3rdSettleAmount',
				index : 'to3rdSettleAmount',
				align : 'center',
				sortable:false
			},{
				name : 'totalPayedAmount',
				index : 'totalPayedAmount',
				align : 'center',
				sortable:false
			},{
				name : 'to3rdActualSettleAmount',
				index : 'to3rdActualSettleAmount',
				align : 'center',
				sortable:false
			},{
				name : 'payedAmount',
				index : 'payedAmount',
				align : 'center',
				sortable:false
			}, {
				name : 'suppCode',
				index : 'suppCode',
				align : 'center',
				sortable:false
			},{
				name : 'stateStatus',
				index : 'stateStatus',
				align : 'center',
				sortable:false
			},{
				name : 'settlementStatus',
				index : 'settlementStatus',
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
	   	    rowList:[10,20,50,200],   //分页选项，可以下拉选择每页显示记录数
	      	viewrecords: true,    //显示总记录数
	      	height:'auto',//高度，表格高度。可为数值、百分比或'auto'
		    gridview:true,        //加速显示
			viewrecords: true,    //显示总记录数
			sortable:true,        //可以排序
		    //sortname: 'searchTime',  //排序字段名
	        sortorder: "desc",    //排序方式：倒序
			caption : "结算列表",
			jsonReader : {
			root : "results",               // json中代表实际模型数据的入口  
			page : "pagination.page",       // json中代表当前页码的数据   
			records : "pagination.records", // json中代表数据行总数的数据   
			total:'pagination.total',       // json中代表页码总数的数据 
			repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
		    },
			onPaging : function(pgButton) {
				$("#settlementOrderList").jqGrid('setGridParam', {
					postData : getQueryParams()
				});
			},
			gridComplete:function(){  //在此事件中循环为每一行添加日志、废保和查看链接
                var ids=jQuery("#settlementOrderList").jqGrid('getDataIDs');
                for(var i=0; i<ids.length; i++){
                	var id=ids[i];
                	//var rowData = $('#settlementOrderList').jqGrid('getRowData',id);
                	//var insuranceNo = rowData.insuranceNo;
                    operateClick= '<a href="javascript:;" style="color:blue" onclick="sendSettlementToVst('+id+')" >推送</a>';
                    jQuery("#settlementOrderList").jqGrid('setRowData', id , {operate:operateClick});
                }
            }
		});
	} 
   
    //推送
	function sendSettlementToVst(id) {
		var gnl=confirm("确认推送至VST？"); 
		if(gnl==true){
			$.ajax({
				url : '${request.contextPath}/settlement/sendSettlementOrderToVst',
				type:'post',
		        dataType : "json",
				contentType : "application/json;",
				data : JSON.stringify({
					id : id,
				 }),
				success: function(data){
					alert(data.message);
					window.location.reload();
	   			}
		    });
		}
	 }
   
  </script>
</head>    
<body>
	<div class="content content1">
	 <form id="myForm" autocomplete="off" >
		<div class="infor1">
			<div class="product message">
				<div class="main">
					<div class="part">
						<span>主单号：</span><input type="text" id="mainBusinessNo" name="mainBusinessNo" style="width:130px;">	
						<span>子单号：</span><input type="text" id="businessNo" name="businessNo" style="width:130px;">				       
						<span>支付时间：</span><input type="text" id="startPayedTime"  name="startPayedTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/> - 
				        <input type="text" id="endPayedTime"  name="endPayedTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
						
						
					</div>
					<div class="part">
					    <span>结算单号：</span><input type="text" id="settlementOrderNo" name="settlementOrderNo" style="width:130px;">
						<span>供应商：</span>
						<select name="suppCode" id="suppCode">
							<#list supps as supp>
								<option value="${(supp.code)!''}">${(supp.code)!''}</option>
							</#list>
						</select>
						<span>创单时间：</span><input type="text" id="startCreateTime"  name="startCreateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/> - 
				        <input type="text" id="endCreateTime"  name="endCreateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
					</div>
					<div class="part">
						<span>结算单状态：</span>
						<select name="statementStatus" id="statementStatus">
							<#list statementStatusEnum as val>
							    <option value="${val}">${val.cnName}</option>
					        </#list> 
						</select>
						<span>结算状态：</span>
						<select name="orderSettlementStatus" id="orderSettlementStatus">
							<option value="">全部</option>
							<#list orderSettlementStatusEnum as val>
								<#if val !="NULL">
					        		<option value="${val}">${val.cnName}</option>
					        	</#if>
					        </#list> 
						</select>
						<span>使用时间：</span><input type="text" id="startUsedTime"  name="startUsedTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/> - 
				        <input type="text" id="endUsedTime"  name="endUsedTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
					</div>
				</div>
			</div>
			
		</div>
		<div class="click">
			<a href="javascript:;"><div class="button" onclick="query()">查询</div></a> 
		</div>
	</form>
		  <div class="content1" style="margin-top:50px;">
			<table id="settlementOrderList"></table>
	        <div id="pager"></div>
          </div>
        <br>
        <br>
        
	</div>

</body>
</html>
