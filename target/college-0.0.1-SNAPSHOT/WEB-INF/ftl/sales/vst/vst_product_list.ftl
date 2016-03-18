<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
		<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
		<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
		<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
		<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
		<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			$(function() {
				initGrid();
			});
			
			function checkId(){
				var re = /^[1-9]+[0-9]*]*$/;
				var id = $("#vstProductId").val();
				if(isNaN(id)){
					alert("请输入合法ID(只包含数字)");
					return false;
				}
				if(id&&id!=""){
					if (!re.test(id)){
						alert("请输入合法ID(只包含数字)");
						return false;
					}else{
						return true;
					}
				}else{
					return true;
				}
			}
			
			function query() {
				var checkFlag = checkId();
				if(!checkFlag){
					return;
				}
				$("#vstProducts").jqGrid('setGridParam', {
					url : "${request.contextPath}/sales/vst/queryVstProducts",
					datatype : "json",
					mtype : "POST",
					postData : getQueryParams()
				}).trigger("reloadGrid");
			}
			
			function initGrid() {
				$("#vstProducts").jqGrid({
						url : '${request.contextPath}/sales/vst/queryVstProducts',
						datatype : "json",
						mtype : "POST",
						height : 'auto',// 高度，表格高度。可为数值、百分比或'auto'
						// width:1000,//这个宽度不能为百分比
						autowidth : true,// 自动宽
						colNames : [ 'VST产品ID', '出发城市', '目的城市', 'VST出发城市ID', 'VST目的城市ID', '上架/下架信息', '开始日期',
								'到期日期', '创建时间', '更新时间', '同步标志'],
						colModel : [ {
							name : 'vstProductId',
							index : 'vstProductId',
							formatter : formatLink,
							sortable : false
						}, {
							name : 'deptCity.name',
							index : 'deptCity.name',
							sortable : false
						}, {
							name : 'arrvCity.name',
							index : 'arrvCity.name',
							sortable : false
						}, {
							name : 'vstDeptCityId',
							index : 'vstDeptCityId',
							sortable : false
						}, {
							name : 'vstArrvCityId',
							index : 'vstArrvCityId',
							sortable : false
						}, {
							name : 'activeStatusStr',
							index : 'activeStatusStr',
							sortable : false
						}, {
							name : 'effectDateStr',
							index : 'effectDateStr',
							sortable : false
						}, {
							name : 'expireDateStr',
							index : 'expireDateStr',
							sortable : false
						}, {
							name : 'createTimeStr',
							index : 'createTimeStr',
							sortable : false
						}, {
							name : 'updateTimeStr',
							index : 'updateTimeStr',
							sortable : false
						}, {
							name : 'batchFlagStr',
							index : 'batchFlagStr',
							sortable : false
						}],
						autowidth : true,
						rowNum : 10,
						pager : '#pager',
						viewrecords : true,
						rowList : [ 10, 20, 50, 200 ], // 分页选项，可以下拉选择每页显示记录数
						multiselect : false,
						caption : "航班信息查询",
						jsonReader : {
							root : "results",
							page : "pagination.page", // 当前页
							records : "pagination.records", // 总记录数
							total : 'pagination.total',
							repeatitems : false
						},
						onPaging : function(pgButton) {
							$("#flightOrderList").jqGrid('setGridParam', {
								postData : getQueryParams()
							});
						}
					});
			}
			
			function formatLink(cellvalue, options, rowObject) {
				var url = "${request.contextPath}/sales/vst/queryVstProductDetail?vstProductId="+rowObject.vstProductId;
				return "<a href='" + url + "' style='color:blue;' target='_blank'>" + cellvalue + "</a>";
			}
			
			function getQueryParams(){
				var vstProduct = {
					'vstProductId':$("#vstProductId").val(),
					'updateBeginTime':$("#updateBeginTime").val(),
					'updateEndTime':$("#updateEndTime").val(),
					'batchFlag':$("#batchFlag").val()
				};
				return vstProduct;
			}
			
			function formatStatus(cellvalue, options, rowObject) 
			{
				var status =null;
				if(cellvalue==1){
					status ="正在进行";
				}else{
					status ="已完成";
				}
				return status;
			}
			
			//重置同步状态
			function cleanCondition(){
				//$("#vstProductId").attr('value',null);
				$('input[type=text]').val(null);
			}
		</script>
	</head>
	<body>
	<div class="content content1">
		<input type="hidden" name="search" value="false">
		<div class="infor1">
			VST产品ID：<input type="text" id="vstProductId" name="vstProductId" width="100"/>
			更新时间(起始点)：<input type="text" id="updateBeginTime" name="updateBeginTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:150px;" class="Wdate" readonly="readonly"/>
			更新时间(结束点)：<input type="text" id="updateEndTime" name="updateEndTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:150px;" class="Wdate" readonly="readonly"/>
			<br/>
			同步状态：<select id="batchFlag" name="batchFlag">
						<option value=''>请选择</option>
						<option value='NEW'>需同步</option>
						<option value='SUCC'>已同步</option>
					</select>
		</div>
		<div class="click">
			<a href="javascript:void(0);" onclick="query();"><div class="button">查询</div></a>
			<a href="javascript:void(0);" onclick="cleanCondition();"><div class="button">清空</div></a>
		</div>
	</div>

	<div class="content content1" style="margin-top:50px;">
		<table id="vstProducts"></table>
		<div id="pager"></div>
	</div>
    
	<div id="jsContainer" class="jsContainer" style="height: 0">
		<div id="tuna_alert" style="display: none; position: absolute; z-index: 999; overflow: hidden;"></div>
		<div id="tuna_jmpinfo" style="visibility: hidden; position: absolute; z-index: 120;"></div>
	</div>
	
	
	<script type="text/javascript" src="${request.contextPath}/js/fixdiv.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/address.js"></script>
</body>
</html>