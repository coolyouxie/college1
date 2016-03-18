<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<title>${payMonitorTitleName}</title>
<link rel="stylesheet" href="${request.contextPath}/css/trip-list.css">
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/area_tankuang.css">
<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
<script src="${request.contextPath}/js/Calendar.js"></script>
<script type="text/javascript">	
   $(function(){
		initGrid();
	})
	
	function getQueryParams(){
    	return {
			'refundNo':$("#refundNo").val(),
			'refundSerialNumber':$("#refundSerialNumber").val(),
			'flightOrderNo.orderNo':$("#orderNo").val(),
			'createStartDate':$("#createStartDate").val(),
			'createEndDate':$("#createEndDate").val(),
			'refundedStartDate':$("#refundedStartDate").val(),
			'refundedEndDate':$("#refundedEndDate").val(),
			'refundStatus':$("#refundStatus").val(),
			'orderCallbackStatus':$("#orderCallbackStatus").val(),
			'refundmentType':$("#refundmentType").find("option:selected").val()
			}
	}
	
	
	
	function initGrid() {
		$("#payMonitorTable").jqGrid({
			url : "${request.contextPath}/refundMonitor/queryRefunds",
			datatype : "json",
			postData : getQueryParams(),
			mtype : "POST",
			height:'auto',//高度，表格高度。可为数值、百分比或'auto'
	        autowidth:true,//自动宽
			colNames:['退款单号','退款类型','交易流水号','网关流水号','退款网关','退款金额','退款申请状态','订单退款回调状态','退款时间','对账流水号','机票订单号','VST订单号','VST退款ID','创建时间','操作','重复发起','ID'],
			colModel : [
			
			{name : 'refundNo',index:'refundNo',editable:true,sortable:false,align:'center'},//退款单号
			{name : '',index:'',sortable:false,align:'center',formatter:function(){return "订单退款"}},//退款类型
			{name : 'refundSerialNumber',index:'refundSerialNumber',sortable:false,align:'center'},//交易流水号
			{name : '',index:'',sortable:false,align:'center'},//网关流水号
			{name : 'refundmentType',index:'refundmentType',sortable:false,align:'center'},//退款网关
			{name : 'refundAmount',index:'refundAmount',sortable:false,align:'center'},//退款金额
			{name : 'refundStatus',index:'refundStatus',sortable:false,align:'center'},//退款状态
			{name : 'orderCallbackStatus',index:'orderCallbackStatus',sortable:false,align:'center'},//订单退款状态
			{name : 'refundTime',index:'refundTime',sortable:false,align:'center'},//退款时间
			{name : '',index:'',sortable:false,align:'center'},//对账流水号
			{name : 'flightOrderNo.orderNo',index:'flightOrderNo.orderNo',sortable:false,align:'center',formatter : formatLink},//机票订单号
			{name : '',index:'',sortable:false,align:'center'},//VST订单号
			{name : '',index:'',sortable:false,align:'center'},//VST退款ID
			{name : 'createTime',index:'createTime',sortable:false,align:'center'},//创建时间
			{name :'operate',index:'operate',width:120,align:"center",sortable:false},
			{name :'canRepeatRefund',index:'canRepeatRefund',width:120,align:"center",sortable:false,hidden : true},//重复发起
			{name :'id',index:'id',width:120,align:"center",sortable:false,hidden : true}//id
			],
			
		 	rowNum:10,            //每页显示记录数
		 	autowidth: true,      //自动匹配宽度
		 	pager: '#pager',      //表格数据关联的分页条，html元素
		   	rowList:[10,20,30],   //分页选项，可以下拉选择每页显示记录数
		   	viewrecords: true,    //显示总记录数
			multiselect: true,    //可多选，出现多选框
			autoheight: true,     //设置高度
			gridview:true,        //加速显示
			multiselectWidth: 25, //设置多选列宽度
			sortable:true,        //可以排序
			sortname: 'createTime',  //排序字段名
		    sortorder: "desc",    //排序方式：倒序，本例中设置默认按id倒序排序
			caption : "退款监控查询",
			
			jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			},	 
			
			gridComplete:function(){  //在此事件中循环为每一行添加修改和删除链接
                    var ids=jQuery("#payMonitorTable").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                    	var id=ids[i];
                    	
                        var model = jQuery("#payMonitorTable").jqGrid('getRowData', id);
                        if(model.canRepeatRefund=='true'){
	                    	var applyRefund='重复发起' ;
	                    	var unfreeze ='设置无效';
	                        operateClick= "<div><a href='#' style='color:#f60' onclick=repeat('"+id+"')>"+applyRefund+"</a> | <a href='#' style='color:#f60' onclick=unfreeze('"+id+"')>"+unfreeze+"</a></div>";   
	                        jQuery("#payMonitorTable").jqGrid('setRowData', ids[i], {operate:operateClick});
                  		}      
                    }
                },
			
			onPaging : function(pgButton) {
				$("#payMonitorTable").jqGrid('setGridParam', {
					postData : getQueryParams()
				});
			}
		 }); 
   } 
   
   //解冻
   function unfreeze(refundId){
   if (confirm("是否设置无效?")) {
   		$.ajax({
					url : '${request.contextPath}/refundMonitor/updateRefundStatus',
					type : 'post',
					dataType : "json",
					contentType : "application/json;",
					data : JSON.stringify({
						id:refundId
					}),
					success : function(data) {
						if (data.status != "" && data.status == "SUCCESS") {
							alert("设置无效成功!");
							window.location.reload();
						} else {
							alert("设置无效失败!");
						}
					},
					error : function(data) {
							alert("设置无效失败!");
					}
				});
			}
   }
   
   
    //重复发起   
	function repeat(id) {
   if (confirm("是否重复发起?")) {
			$.ajax({
					url : '${request.contextPath}/order/refund',
					type : 'post',
					dataType : "json",
					contentType : "application/json;",
					data : JSON.stringify({
						refundIds:id
					}),
					success : function(data) {
						if (data.status != "" && data.status == "SUCCESS") {
							alert("重复发起成功!");
							window.location.reload();
						} else {
							alert("重复发起失败!");
						}
					},
					error : function(data) {
							alert("重复发起失败!");
					}
				});
		}
	}
	
	function formatLink(cellvalue, options, rowObject) {
		if (rowObject.orderId != null) {
			var url = "${request.contextPath}/order/queryOrderDetail/" + rowObject.orderMainId + "/" + rowObject.orderId + "/NULL";
			return "<a href='"+url+"' style='color:blue;' target='_blank'>" + cellvalue + "</a>";
		}else{
			return rowObject.flightOrderNo.orderNo;
		}
		
	}

		
   
   
   	 //查询列表信息   
	function queryRefunds() {
		$("#payMonitorTable").jqGrid('setGridParam', {
			 url : "${request.contextPath}/refundMonitor/queryRefunds",
			 datatype : "json",
			 mtype : "POST",
			 postData : getQueryParams()
		}).trigger("reloadGrid");
		conditionHtmlToExportCsvForm();
	}
	
	
		//清空表单
    		function clearForm()
    		{
    			$('input[type=text]').val('');
    			$('select').val('');
    		}
    		

		//将条件插入到导出exportCsvForm
	function conditionHtmlToExportCsvForm() {
		$('#exportCsvDiv').html($('#cheak').html());
		//去除exportCsvDiv所有元素的id和tempName属性
		$('#exportCsvDiv').find('select').removeAttr('id');
		$('#exportCsvDiv').find('input').removeAttr('id');
		$('#exportCsvDiv').find('input').removeAttr('tempName');
		//元素赋值
		$.each($('#cheak').find('input[type="text"]'), function(index, obj) {
			var objName = $(obj).attr('name');
			$('#exportCsvDiv').find('input[name="' + objName + '"]').attr('value', $(obj).val());
		});
		$.each($('#cheak').find('input[type="checkbox"]'), function(index, obj) {
			var objName = $(obj).attr('name');
			if ($(obj).attr('checked'))
				$('#exportCsvDiv').find('input[name="' + objName + '"]').attr('checked', true);
		});
		$.each($('#cheak').find('select'), function(index, obj) {
			var objName = $(obj).attr('name');
			$('#exportCsvDiv').find('select[name="' + objName + '"]').attr('value', $(obj).val());
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
	 <form>
		<div class="breadnav"><span>首页</span> >${payMonitorTitleName}</div>
		<div class="cheak">
			<div class="part part1">
				<span>机票订单号：</span><input type="text" name="orderNo" id="orderNo" />
				<span>退款网关：</span>
				<select id="refundmentType" name="refundmentType" >
					<option value="">全部</option>
					<#list refundTypeEnum as val>
					   <option value="${val}">${val.cnName}</option>
					</#list>  
		     	</select>	
		     	<span>网关流水号：</span><input type="text" name="" id="" />
			
			</div>
			
			<div class="part part2">
				<span>交易流水号：</span><input type="text" name="refundSerialNumber" id="refundSerialNumber" />
				<span>退款单号：</span><input type="text" name="refundNo" id="refundNo" />
		     	<span>VST订单号：</span><input type="text" name="" id="" />
			</idv>
			
			<div class="part part3">
			<span>退款申请状态：</span>
				<select id="refundStatus" name="refundStatus" >
					<option value="">全部</option>
					<#list refundStatusEnum as val>
					   <option value="${val}">${val.cnName}</option>
					</#list>  
		     	</select>	
				<span>订单退款回调状态：</span>
				<select id="orderCallbackStatus" name="orderCallbackStatus" >
					<option value="">全部</option>
					<#list orderCallbackStatusEnum as val>
					   <option value="${val}">${val.cnName}</option>
					</#list>  
		     	</select>	
			</div>
			
			<div class="part part4">
			    <span>创建时间：</span><input type="text" name="createStartDate" id="createStartDate" onClick="new Calendar().show(this);" readonly /> 至 <input type="text" name="createEndDate" id="createEndDate" onClick="new Calendar().show(this);" readonly />
			    <span>退款时间：</span><input type="text" name="refundedStartDate" id="refundedStartDate" onClick="new Calendar().show(this);" readonly /> 至 <input type="text" name="refundedEndDate" id="refundedEndDate" onClick="new Calendar().show(this);" readonly />
				<div class="click">
					<a href="javascript:void(0);"><div class="button" onclick="queryRefunds()" >查询</div></a>
					<a href="javascript:void(0);"><div class="button" onclick="exportCsv()" >导出Cvs</div></a>
					<a href="javascript:void(0);" onclick="clearForm();"><div class="button">清空</div></a>
				</div>
			</div>
		</div>
	</form>
	</div>
	
	<div class="content content1">
     <table id="payMonitorTable"></table>
     <div id="pager"></div>
     </div>
     <br>
     <br>
     
     
    <form id="exportCsvForm" action="${request.contextPath}/payMonitor/exportRefundsByCsv" method="post" target="_blank">
		<div id="exportCsvDiv" style="display:none;">
		</div>
	</form>
	
</body>
</html>
