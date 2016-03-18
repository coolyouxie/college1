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
			$("#blackIdList").jqGrid('setGridParam', {
				url : "${request.contextPath}/risk/queryBlackIds",
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
			return {
				'customerId' : $("#customerId").val(),
				'riskLevelType' : $("#riskLevelType").val(),
				'status' : $("#status").val(),
				'search' : false
			}
		}
	
		function initGrid() { 
			$("#blackIdList").jqGrid({
				url : "${request.contextPath}/risk/queryBlackIds",
				datatype : "json",
				mtype : "POST",
			    colNames : ['ID编码','客户ID','客户名字','客户手机','风控等级Enum','风控等级','标志Enum','标志','封禁时间','操作'],
				colModel : [ 
				{
					name : 'id',
					index : 'id',
					align : 'center',
					hidden : true,
					sortable:false
				}, {
					name : 'customerId',
					index : 'customerId',
					align : 'center',
					sortable:false
				}, {
					name : 'customerName',
					index : 'customerName',
					align : 'center',
					sortable:false
				},{
					name : 'customerCellphone',
					index : 'customerCellphone',
					align : 'center',
					sortable:false
				},{
					name : 'riskLevelType',
					index : 'riskLevelType',
					align : 'center',
					hidden : true,
					sortable:false
				},
				{
					name : 'riskLevelTypeStr',
					index : 'riskLevelTypeStr',
					align : 'center',
					sortable:false
				},{
					name : 'status',
					index : 'status',
					align : 'center',
					hidden : true,
					sortable:false
				},{
					name : 'statusStr',
					index : 'statusStr',
					align : 'center',
					sortable:false
				},  {
					name : 'blackTimeStr',
					index : 'blackTimeStr',
					align : 'center',
					sortable:false
				}, 
				{
					name : 'operate',
					index : 'operate',
					align : 'center',
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
				caption : '风控黑名单信息列表',
				jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#blackIdList").jqGrid('setGridParam', {
						postData : getAuditOpParams()
					});
				},
				gridComplete : function() { //在此事件中循环为每一行添加编辑链接
								var ids = jQuery("#blackIdList").jqGrid('getDataIDs');
								for ( var i = 0; i < ids.length; i++) {
									var id = ids[i];
									var rowData = $('#blackIdList').jqGrid('getRowData', id);
									var keyId=rowData.id;
									var customerId=rowData.customerId;
									var customerName=rowData.customerName;
									var riskLevelType=rowData.riskLevelType;
									var status=rowData.status;
									operateClick = '<a href="javascript:;" style="color:blue" onclick="openEditDialog('+id+ ', '+keyId+', '+customerId+', '+"'" +riskLevelType+"' ,'" +customerName+"' , '"+ status +"'"+')" >编辑</a>';
									jQuery("#blackIdList").jqGrid('setRowData', id, {
										operate : operateClick
									});
								}
							}
			});
		} 
		
		
	// 显示修改框
	function openEditDialog(id, keyId, customerId, riskLevelType, customerName, status){
		$('#EditDialog').dialog({
		    title:'任务配置编辑',
		    width:350,
			height:320,
			modal:'true'
		});
		$("#id").val(keyId);
		$("#customerId_2").val(customerId);
		$("#customerName_2").val(customerName);
		
		var riskLevelTypeSe = document.getElementById("riskLevelType_2");
	     for(i=0;i<riskLevelTypeSe.length;i++){
		if(riskLevelTypeSe[i].value==riskLevelType)
			riskLevelTypeSe[i].selected = true;
	    }
	    
	    var statusSe = document.getElementById("status_2");
	     for(i=0;i<statusSe.length;i++){
		if(statusSe[i].value==status)
			statusSe[i].selected = true;
	    }
	}
	
	//编辑
	function edit() {
		$.ajax({
			url : "saveBlackId",
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
				request : setRequest()
			}),
			success : function(data) {
				if (data.flag == 'true') {
					alert("保存成功");
					window.location.reload();
				} else {
					alert("保存失败");
				}
			}
		}); // ajax-end
	}
	
	function setRequest(){
	    var id = $("#id").val();
		var customerId = $("#customerId_2").val();
		var riskLevelType = $("#riskLevelType_2").val();
		var status = $("#status_2").val();
		
		var request = new Object;
		request.id = id;
		request.customerId = customerId;
		request.riskLevelType = riskLevelType;
		request.status = status;
		
		return request;
	}
  </script>
</head>
<body>
	<div class="content content1">
	<div class="breadnav"><span>首页</span> > 风控黑名单信息列表</div>
	 <form id="myForm" autocomplete="off" >
		<div class="infor1">
			<div class="visitor message">
				<div class="main">
					<div class="part">
					<span>客户ID：</span><input type="text" name="customerId" id="customerId"/>	       
					<span>风控等级：</span><select id="riskLevelType" name="riskLevelType">
							<option value="">全部</option>
							<#list riskLevelTypeEnum as val>  
							   <option value="${val}">${val.cnName}</option>
							</#list>
						</select>
						<span>标志状态：</span><select id="status" name="status">
							<option value="">全部</option>
							<#list statusEnum as val>  
							   <option value="${val}">${val.cnName}</option>
							</#list>
						</select>
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
			<table id="blackIdList"></table>
	        <div id="pager"></div>
          </div>
        <br>
        <br>
	</div>
	
	
	<div id="EditDialog" style="display:none;">
			<input type="hidden" id="id" />
			<table>
				<tr height="35">	
					<td align="right">客户ID：</td>
					<td ><input type="text" id="customerId_2"  disabled/></span></td>
				</tr>
				<tr height="35">	
					<td align="right">客户名称：</td>
					<td ><input type="text" id="customerName_2"  disabled/></span></td>
				</tr>
				<tr height="35">	
					<td align="right">风控等级：</td>
					<td>
					<select id="riskLevelType_2" name="riskLevelType" style="width:140px;">
							<#list riskLevelTypeEnum as val>  
							   <option value="${val}">${val.cnName}</option>
							</#list>
						</select>
					</td>
				</tr>
				<tr height="35">	
					<td align="right">标志：</td>
					<td>
					<select id="status_2" name="status" style="width:140px;">
							<#list statusEnum as val>  
							   <option value="${val}">${val.cnName}</option>
							</#list>
						</select>
					</td>
				</tr>
				<tr height="35">
					<td colspan="2" align="center">
					<button class="button" onclick="edit()">保存</button>
					</td>
				</tr>
			</table>
		</div>
	 
</body>
</html>