<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/css/base.css">
		<#--<link type="text/css" rel="stylesheet" href="${request.contextPath}/css/jquery.ui.autocomplete.css">-->
		<#--<link type="text/css" rel="stylesheet" href="${request.contextPath}/css/jquery.ui.theme.css">-->
		<#--<link type="text/css" rel="stylesheet" href="${request.contextPath}/css/ui-components.css">-->
		<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/css/ui-common.css">
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/css/ui-panel.css">
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/css/iframe.css">
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
				var flag = false;
				var re = /^[1-9]+[0-9]*]*$/;
				var vstTrafficFlightId = $("#vstTrafficFlightId").val();
				if(isNaN(vstTrafficFlightId)){
					alert("请输入合法ID(只包含数字)");
					return false;
				}
				if(vstTrafficFlightId&&vstTrafficFlightId!=""){
					if (!re.test(vstTrafficFlightId)){
						alert("请输入合法ID(只包含数字)");
						return false;
					}else{
						flag = true;
					}
				}else{
					flag = true;
				}
				
				var vstBasicFlightId = $("#vstBasicFlightId").val();
				if(isNaN(vstBasicFlightId)){
					alert("请输入合法ID(只包含数字)");
					return false;
				}
				if(vstBasicFlightId&&vstBasicFlightId!=""){
					if (!re.test(vstBasicFlightId)){
						alert("请输入合法ID(只包含数字)");
						flag = false;;
					}else{
						flag = true;
					}
				}else{
					flag = true;
				}
				
				var vstProductId1 = $("#vstProductId1").val();
				if(isNaN(vstProductId1)){
					alert("请输入合法ID(只包含数字)");
					return false;
				}
				if(vstProductId1&&vstProductId1!=""){
					if (!re.test(vstProductId1)){
						alert("请输入合法ID(只包含数字)");
						return false;
					}else{
						flag = true;
					}
				}else{
					flag = true;
				}
				
				var vstGroupId =$("#vstGroupId").val();
				if(isNaN(vstGroupId)){
					alert("请输入合法ID(只包含数字)");
					return false;
				}
				if(vstGroupId&&vstGroupId!=""){
					if (!re.test(vstGroupId)){
						alert("请输入合法ID(只包含数字)");
						return false;
					}else{
						flag = true;
					}
				}else{
					flag = true;
				}
				return flag;
			}
			
			function query() {
				var checkFlag = checkId();
				if(!checkFlag){
					return;
				}
				$("#vstTrafficFlight").jqGrid('setGridParam', {
					url : "${request.contextPath}/sales/vst/queryVstTrafficFlights",
					datatype : "json",
					mtype : "POST",
					postData : getQueryParams()
				}).trigger("reloadGrid");
			}
			
			function initGrid() {
				$("#vstTrafficFlight").jqGrid({
						url : '${request.contextPath}/sales/vst/queryVstTrafficFlights',
						datatype : "json",
						mtype : "POST",
						height : 'auto',// 高度，表格高度。可为数值、百分比或'auto'
						width:1150,//这个宽度不能为百分比
						//autowidth : true,// 自动宽
						postData : getQueryParams(),
						colNames : [ 'VST产品航班ID', 'VST产品ID', 'VST产品组ID', 'VST基础航班ID','往返类型','创建时间', '更新时间', '同步标志'],
						colModel : [ {
							name : 'vstTrafficFlightId',
							index : 'vstTrafficFlightId',
							//formatter : formatLink,
							sortable : false
						}, {
							name : 'vstProductId',
							index : 'vstProductId',
							sortable : false
						}, {
							name : 'vstGroupId',
							index : 'vstGroupId',
							sortable : false
						}, {
							name : 'vstFlightId',
							index : 'vstFlightId',
							sortable : false
						}, {
							name : 'tripType',
							index : 'tripType',
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
							name : 'batchFlag',
							index : 'batchFlag',
							formatter : formatBatchFlag,
							sortable : false
						}],
						//autowidth : true,
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
				var url = "${request.contextPath}/sales/vst/queryVstProductDetail/" + rowObject.vstGoodsId;
				return "<a href='" + url + "' style='color:blue;' target='_blank'>" + cellvalue + "</a>";
			}
			
			function formatBatchFlag(cellvalue, options, rowObject) {
				var result = rowObject.batchFlag;
				if(result=="SUCC"){
					return "已同步";
				}else{
					return "需同步";
				}
			}
			
			function getQueryParams(){
				//如果选中，则表示从库中所有记录查询不被vstProductId限制
				var flag = $("#searchFromAll").is(':checked');
				var vstTrafficFlight = null;
				if(flag){
					vstTrafficFlight = {
						'vstProductId':$("#vstProductId1").val(),
						'vstTrafficFlightId':$("#vstTrafficFlightId").val(),
						'vstBasicFlightId':$(vstBasicFlightId).val(),
						'vstFlightId':$(vstBasicFlightId).val(),
						'vstGroupId':$(vstGroupId).val(),
						'updateBeginTime':$("#updateBeginTime").val(),
						'updateEndTime':$("#updateEndTime").val(),
						'batchFlag':$("#batchFlag").val()
					}
				}else{
					vstTrafficFlight = {
						'vstProductId':$("#vstProductId").val(),
						'vstTrafficFlightId':$("#vstTrafficFlightId").val(),
						'vstBasicFlightId':$(vstBasicFlightId).val(),
						'vstFlightId':$(vstBasicFlightId).val(),
						'vstGroupId':$(vstGroupId).val(),
						'updateBeginTime':$("#updateBeginTime").val(),
						'updateEndTime':$("#updateEndTime").val(),
						'batchFlag':$("#batchFlag").val()
					}
				}
				return vstTrafficFlight;
			}
			
			//重置同步状态
			function cleanCondition(){
				$('input[type=text]').val(null);
				$('select').val(null);
			}
		</script>
	</head>
	<body>
    	<div class="content content1" style="margin-top:10px;">
			<input type="hidden" name="search" value="false"/>
			<input type="hidden" id="vstProductId" name="vstProductId" value="${vstProductId}"/>
			<div class="infor1">
				<input type="checkbox" id="searchFromAll" value=""/>从所有产品航班信息中查询
				<br/>
				VST产品ID：<input type="text" id="vstProductId1" name="vstProductId1" width="100"/>
				VST产品航班ID：<input type="text" id="vstTrafficFlightId" name="vstTrafficFlightId" width="100"/>
				VST基础航班ID：<input type="text" id="vstBasicFlightId" name="vstBasicFlightId" width="100"/>
				VST产品组ID：<input type="text" id="vstGroupId" name="vstGroupId" width="100"/>
				<br/>
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
			<table id="vstTrafficFlight"></table>
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