<!DOCTYPE html>
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" href="${request.contextPath}/css/trip-list.css">
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
	<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
 	
    <script type="text/javascript">
    $(function (){
		initGrid();
		
	   //查询列表信息   
	   $("#queryRemark").click(function() {
			$("#orderRemarkList").jqGrid('setGridParam', {
				url : '${request.contextPath}/order/queryOrderRemark',
				datatype : "json",
				mtype : "POST",
				postData : getRemarkParams()
			}).trigger("reloadGrid");
	  });
	  
	   //清空查询信息   
	   $("#cleanRemark").click(function() {
			document.getElementById("myForm").reset()
	  });
	  
    });    
    
    function getRemarkParams() {
			return {
				'orderMainId' : $("#orderMainId").val(),
				'orderId' : $("#orderId").val(),
				'flightOrderNo.orderNo' : $("#orderNo").val(),
				'remarkType' : $("#remarkType").val(),
				'remark' : $("#remark").val(),
				'search' : false
			}
		}
		
		
	function initGrid() {
		$("#orderRemarkList").jqGrid({
			url : "${request.contextPath}/order/queryOrderRemark?orderMainId="+$("#orderMainId").val() + "&orderId="+$("#orderId").val(),
			datatype : "json",
			mtype : "POST",
			colNames:['订单号', '备注类型','操作人','内容', '附件', '创建时间'],
			colModel : [ 
			{
				name : 'flightOrderNo.orderNo',
				index : 'orderNo',
				align : 'center',
				sortable:false
			},
			{
				name : 'remarkType',
				index : 'remarkType',
				align : 'center',
				sortable:false
			},{
					name : 'oper',
					index : 'oper',
					align : 'center',
					width :60,
					sortable:false
				},
			{
				name : 'remark',
				index : 'remark',
				align : 'center',
				width :200,
				sortable:false
			},
			{
				name : '',
				index : '',
				align : 'center',
				sortable:false
			},
			{
				name : 'remarkTime',
				index : 'remarkTime',
				align : 'center',
				sortable:false
			}
			],
            rowNum: 10,            //每页显示记录数
	 	    autowidth: true,      //自动匹配宽度
	 	    pager: '#pager',      //表格数据关联的分页条，html元素
	   	    rowList:[10,20,50,500],   //分页选项，可以下拉选择每页显示记录数
	      	viewrecords: true,    //显示总记录数
	      	height:'auto',//高度，表格高度。可为数值、百分比或'auto'
		   // autoheight: true,     //设置高度
		    gridview:true,        //加速显示
			viewrecords: true,    //显示总记录数
			multiselect : false,
			sortable:true,        //可以排序
		    sortname: 'flightOrderNo.orderNo',  //排序字段名
	        sortorder: "desc",    //排序方式：倒序
			caption : "订单备注列表",
			jsonReader : {
			root : "results",               // json中代表实际模型数据的入口  
			page : "pagination.page",       // json中代表当前页码的数据   
			records : "pagination.records", // json中代表数据行总数的数据   
			total:'pagination.total',       // json中代表页码总数的数据 
			repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
		    },
			onPaging : function(pgButton) {
				$("#orderRemarkList").jqGrid('setGridParam', {
					postData : getRemarkParams()
				});
			}
		});
		
	} 
  </script>
</head>
<body>
    <input type="hidden" id="orderMainId" name="orderMainId" value="${orderMainId}"/>
	<input type="hidden" id="orderId" name="orderMainId" value="${orderId}"/>
	<div class="content content1">
	  <div class="breadnav"><span>首页</span> > 备注列表信息</div>
	  <form id="myForm" autocomplete="off" >
		<div class="cheak">
			<div class="part part1">
				<span>订单号：</span><input type="text" name="orderNo" id="orderNo" />
				<span>备注类型：</span><select name="remarkType" id="remarkType">
				       <option value="">全部</option> 
					   <#list remarkType as val>  
					   <option value="${val}">${val.cnName}</option>
					   </#list> 
				</select>
				<span>备注信息：</span><input type="text" name="remark" id="remark" />
				<div class="click">
					<a href="javascript:;" id = "queryRemark" ><div class="button" >查询</div></a>
					<a href="javascript:;" id = "cleanRemark" ><div class="button" >清空</div></a>
				</div>
			</div>
		</div>
	  </form>
	</div>

	 <div class="content content1">
      <table id="orderRemarkList"></table>
     <div id="pager"></div>
     </div>
     <br>
     <br>
	 
</body>
</html>