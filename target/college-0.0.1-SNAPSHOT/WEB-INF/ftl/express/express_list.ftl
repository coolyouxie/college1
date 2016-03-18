
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet"
	href="${request.contextPath}/css/order-details.css" type="text/css" />
<link type="text/css" rel="stylesheet"
	href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css" />
<link type="text/css" rel="stylesheet"
	href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css" />
<script
	src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js">
	
</script>
<script
	src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
<script
	src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
<script
	src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
<script src="${request.contextPath}/js/Calendar.js"></script>
    <script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>



<script type="text/javascript">
	$(function() {
		initGrid();
	});

	//查询列表信息   
	function query() {
		var orderNo = $("#orderNo").val();
		var depTime = $("#depTime").val();
		

	

		$("#list").jqGrid('setGridParam', {
			url : "${request.contextPath}/express/queryExpressList",
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
		return {
			'orderNo' : $("#orderNo").val(),
			'depTime' : $("#depTime").val(),
			'recipient' : $("#recipient").val(),
			'cellphone' : $("#cellphone").val(),
			'expressTime' : $("#expressTime").val(),
			'expressStatus' : $("#expressStatus").val(),
			
			'search' : false
		}
	}

	function initGrid() {
		$("#list")
				.jqGrid(
						{
							url : "${request.contextPath}/express/queryExpressList",
							datatype : "json",
							mtype : "POST",
							colNames : [ '主单id','订单id','主订单号','子订单号', '航班日期', '联系人',
									'手机号码', '邮寄地址','邮寄时间','快递公司', '配送状态',
									'快递单号', '操作' ],
							colModel : [ {
								name : 'orderMainId',
								index : 'orderMainId',
								align : 'center',
								hidden : true,
								sortable : false
							}, {
								name : 'orderId',
								index : 'orderId',
								align : 'center',
									hidden : true,
								sortable : false
							},  {
								name : 'orderMainNo',
								index : 'orderMainNo',
								align : 'center',
								width :180,
								sortable : false
							}, {
								name : 'orderNo',
								index : 'orderNo',
								align : 'center',
								width :180,
								sortable : false
							},{
								name : 'depTime',
								index : 'depTime',
								align : 'center',
								width :100,
								sortable : false
							}, {
								name : 'recipient',
								index : 'recipient',
								align : 'center',
									width :80,
								sortable : false
							}, {
								name : 'cellphone',
								index : 'cellphone',
								align : 'center',
								width :120,
								sortable : false
							}, {
								name : 'address',
								index : 'address',
								align : 'center',
								width :400,
								sortable : false
							}, {
								name : 'orderExpressTime',
								index : 'orderExpressTime',
								align : 'center',
									width :100,
								sortable : false
							},  {
								name : 'expressWay.name',
								index : 'expressWay.name',
								align : 'center',
									width :50,
								sortable : false
							}, {
								name : 'expressStatusName',
								index : 'expressStatusName',
								align : 'center',
									width :80,
								sortable : false
							},{
								name : 'expressFileNo',
								index : 'expressFileNo',
								align : 'center',
								sortable : false
							},  {
								name : 'operate',
								index : 'operate',
								align : 'center',
								sortable : false
							} ],
							rowNum : 10, //每页显示记录数
							autowidth : true, //自动匹配宽度
							pager : '#pager', //表格数据关联的分页条，html元素
							rowList : [ 10, 20, 50, 500 ], //分页选项，可以下拉选择每页显示记录数
							viewrecords : true, //显示总记录数
							height : 'auto',//高度，表格高度。可为数值、百分比或'auto'
							//autoheight: true,     //设置高度
							gridview : true, //加速显示
							viewrecords : true, //显示总记录数
							multiselect : false,
							sortable : true, //可以排序
							sortname : 'searchTime', //排序字段名
							sortorder : "desc", //排序方式：倒序
							caption : "流量列表",
							jsonReader : {
								root : "results", // json中代表实际模型数据的入口  
								page : "pagination.page", // json中代表当前页码的数据   
								records : "pagination.records", // json中代表数据行总数的数据   
								total : 'pagination.total', // json中代表页码总数的数据 
								repeatitems : false
							// 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
							},
							onPaging : function(pgButton) {
								$("#list").jqGrid('setGridParam', {
									postData : getParams()
								});
							},
							gridComplete : function() { //在此事件中循环为每一行添加日志、废保和查看链接
								var ids = jQuery("#list").jqGrid('getDataIDs');
								for ( var i = 0; i < ids.length; i++) {
									var id = ids[i];
									

									var rowData = $('#list').jqGrid('getRowData', id);
									//alert(rowData.arrCityCode);
									var orderId=rowData.orderId;
									var orderMainId=rowData.orderMainId;

									operateClick = '<a href="#" style="color:blue" onclick="openEditDialog('+ id + ','+orderId+','+orderMainId+')" >编辑</a> | <a style="color:blue" href="${request.contextPath}/toOrderOpLogListPage/'+orderId+'">日志</a> ';
									jQuery("#list").jqGrid('setRowData', id, {
										operate : operateClick
									});
								}
							}
						});
	}

	//添加
	function add() {
		var depCityCode = $("#depCityCode").val();
		var arrCityCode = $("#arrCityCode").val();
		var startDay = $("#startDay").val();
		var endDay = $("#endDay").val();
		var startHour = $("#startHour").val();
		var endHour = $("#endHour").val();
		var rate = $("#rate").val();
		
		if(depCityCode==''||arrCityCode==''||startDay==''||endDay==''||startHour==''||endHour==''||rate==''){
			alert("数据不能为空!");
			return;
		}
		
	
		$.ajax({
			url : "save",
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
				request : setRequest()
			}),
			success : function(data) {
				// alert(data.flag);
				if (data.flag == 'true') {
					alert("成功！");
					window.location.reload();
				} else {
					alert("失败！");

				}
			}
		}); // ajax-end
	}
	
	function setRequest(){
		var depCityCode = $("#depCityCode").val();
		var arrCityCode = $("#arrCityCode").val();
		var startDay = $("#startDay").val();
		var endDay = $("#endDay").val();
		var startHour = $("#startHour").val();
		var endHour = $("#endHour").val();
		var rate = $("#rate").val();
		
		if(depCityCode==''){
			alert("数据不能为空!");
			return;
		}
		
		var request = new Object;
		request.depCityCode = depCityCode;
		request.arrCityCode = arrCityCode;
		request.startDay = startDay;
		request.endDay = endDay;
		request.startHour = startHour;
		request.endHour = endHour;
		request.rate = rate;
		return request;
	}
	
	

	
	//编辑
	function openEditDialog(id,orderId,orderMainId){
		$('#EditDialog').dialog({
		    title:'任务配置编辑',
		    width:350,
			height:320,
			modal:'true'
		});
		
		 $("#expressId").val(id);
		 $("#orderId").val(orderId);
		 $("#orderMainId").val(orderMainId);
	
		$.ajax({
			url : "get",
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
				request : setDeleteRequest(id)
			}),
			success : function(data) {
				
		
	        var html='';
			if(data.expressStatus=='DELIVERED'){
				html='<input type="radio" id="expressStatusInput" name="expressStatusInput" value="RECYCLING" checked="checked" />回收';
				
			}else{
				html='<input type="radio" id="expressStatusInput" name="expressStatusInput" value="DELIVERED" checked="checked" />邮寄';
			}
			 $("#expressStatusInputSpan").empty().append(html);
				 initExpressWayHtml(data.expressWayCode);
				 $("#expressFileNo").val(data.expressFileNo);
				 $("#remark").val(data.remark);
				
			}
		}); // ajax-end
	}
	
	
	function setDeleteRequest(id){
		var request = new Object;
		request.id = id;
		return request;
	}
	
	
	//编辑
	function edit() {
		$.ajax({
			url : "save",
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
				request : setEditRequest()
			}),
			success : function(data) {
				// alert(data.flag);
				if (data.flag == 'true') {
					alert("成功！");
					window.location.reload();
				} else {
					alert("失败！");

				}
			}
		}); // ajax-end
	}
	
	function setEditRequest(){
		var expressId = $("#expressId").val();
		var orderId = $("#orderId").val();
		var orderMainId = $("#orderMainId").val();
		var expressStatus = $("#expressStatusInput").val();
	
		var expressFileNo = $("#expressFileNo").val();
		var remark = $("#remark").val();

		var rate = $("#rateInput").val();
		var request = new Object;
		request.id = expressId;
		request.orderId = orderId;
		request.orderMainId = orderMainId;
		request.expressStatus = expressStatus;
		request.expressWay= setExpressWay();
		request.expressFileNo = expressFileNo;
		request.remark = remark;
		return request;
	}
	
	function setExpressWay(){
		var way = $("#expressWayInput").val();
		var expressWay = new Object;
		var  code=  way.substring(0,way.indexOf('#'))
		var  name=  way.substring(way.indexOf('#')+1,way.length);
		expressWay.code=code;
		expressWay.name=name;
		return expressWay;
	}
	
	
	function initExpressWayHtml(expressWayCode){
			$.ajax({
			url : "getExpressWays",
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data :"",
			success : function(data) {
			
			var jsontext = JSON.stringify(data);
			var citys=JSON.parse(jsontext);
				   for(var o in citys){  
			        //alert("text:"+data[o].name);  
			      } 
				  
				  	  
				   var htmldep="";
				   var selectdep="";
					$.each(citys,function(i,n){
						if(data[i]['code']==expressWayCode){
							selectdep='selected="selected"';
							htmldep+="<option  "+selectdep+" value="+data[i]['code']+"#"+data[i]['name']+">"+data[i]['name']+"("+data[i]['code']+")</option>";
						}else{
							htmldep+="<option   value="+data[i]['code']+"#"+data[i]['name']+">"+data[i]['name']+"("+data[i]['code']+")</option>";
						}
						})
			
		             $("#expressWayInput").empty().append(htmldep);
					
		             
			}
		}); // ajax-end
	
	}
	
	//导出Csv
	function exportCsv()
	{
		$('#myForm').submit();
	}
	
	
	
</script>
</head>
<body>
	<div class="content content1">
		<div class="breadnav">
			<span>首页</span> >配送服务后台
		</div>
		<form id="myForm" action="${request.contextPath}/express/expressExportCsv" method="post" target="_blank">
			<div class="infor1">

				<div class="visitor message">
				<div class="main">
					<div class="part">
						<span>子订单号：</span><input type="text" value="" name="orderNo" id="orderNo" length="300px" />
					    <span>航班日期：</span><input type="text" value="${depTime}" name="depTime" id="depTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
						<span>联系人：</span><input type="text" value="" id="recipient" name="recipient" length="300px" />
						<span>手机号：</span><input type="text" value="" id="cellphone" name="cellphone" length="300px" /><br />
					</div>
					<div class="part">
					    <span>邮寄时间：</span><input type="text" name="expressTime" value="${expressTime}" id="expressTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
					    <span>配送状态：</span><select id="expressStatus" name="expressStatus" onchange="setTicketStatus(this.value);">
							   <option value="">全部</option>
							<#list expressStatusEnum as val>  
							   <option value="${val}">${val.cnName}</option>
							</#list>  
						</select>
					</div>
				</div>
			</div>

			</div>
			<div class="click">
				<!-- <a href="javascript:;"><div class="button"
						onclick="add()">添加</div></a>  -->
						<a href="javascript:;"><div class="button" onclick="exportCsv()">导出</div></a>
						<a href="javascript:;"><div class="button" onclick="query()">查询</div></a>
				<!-- <a href="javascript:;"><div class="button" onclick="reset()">清空</div></a>-->
			</div>
		</form>
		<div class="content1" style="margin-top: 50px;">
			<table id="list"></table>
			<div id="pager"></div>
		</div>
		<br> <br>
	</div>
	
	
	
	<div id="EditDialog" style="display:none;">
	
			<input type="hidden" id="expressId" />
			<input type="hidden" id="orderId" />
			<input type="hidden" id="orderMainId" />
			<table>
			
				<tr height="35">	
					<td align="right">操作类型:<span  style="color: red;" ></span></td>
					<td ><span   id="expressStatusInputSpan"  ><input type="radio"  id="expressStatusInput" name="expressStatusInput" value="DELIVERED" checked="checked" />邮寄</span>
					</td>
				</tr>
				<tr height="35">	
					<td align="right">快递公司:<span  style="color: red;" ></span></td>
					
					<td>
						<select id="expressWayInput"  style="width:140px;" >
							
							</select>
					</td>
				</tr>
			
			
				<tr height="35">	
					<td align="right">快递单号：</td>
					<td>
						<input type="text" id="expressFileNo" />
					</td>
				</tr>
				<tr height="35">	
					<td align="right">备注：</td>
					<td>
						
						<textarea rows="3" cols="20" id="remark">

						</textarea>
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