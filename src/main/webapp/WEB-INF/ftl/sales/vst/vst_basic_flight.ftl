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
				var flag = false;
				var re = /^[1-9]+[0-9]*]*$/;
				var id = $("#vstBasicFlightId").val();
				if(isNaN(id)){
					alert("请输入合法ID(只包含数字)");
					return false;
				}
				if(id&&id!=""){
					if (!re.test(id)){
						alert("请输入合法ID(只包含数字)");
						return false;
					}else{
						flag = true;
					}
				}else{
					flag = true;
				}
				
				var vstCarrierId = $("#vstCarrierId").val();
				if(isNaN(vstCarrierId)){
					alert("请输入合法ID(只包含数字)");
					return false;
				}
				if(vstCarrierId&&vstCarrierId!=""){
					if (!re.test(vstCarrierId)){
						alert("请输入合法ID(只包含数字)");
						return false;
					}else{
						flag = true;
					}
				}else{
					flag = true;
				}
				
				
				var vstDeptCityId = $("#vstDeptCityId").val();
				if(isNaN(vstDeptCityId)){
					alert("请输入合法ID(只包含数字)");
					return false;
				}
				if(vstDeptCityId&&vstDeptCityId!=""){
					if (!re.test(vstDeptCityId)){
						alert("请输入合法ID(只包含数字)");
						return false;
					}else{
						flag = true;
					}
				}else{
					flag = true;
				}
				
				
				var vstArrvCityId = $("#vstArrvCityId").val();
				if(isNaN(vstArrvCityId)){
					alert("请输入合法ID(只包含数字)");
					return false;
				}
				if(vstArrvCityId&&vstArrvCityId!=""){
					if (!re.test(vstArrvCityId)){
						alert("请输入合法ID(只包含数字)");
						return false;
					}else{
						flag = true;
					}
				}else{
					flag = true;
				}
				
				var vstAirplaneId = $("#vstAirplaneId").val();
				if(isNaN(vstAirplaneId)){
					alert("请输入合法ID(只包含数字)");
					return false;
				}
				if(vstAirplaneId&&vstAirplaneId!=""){
					if (!re.test(vstAirplaneId)){
						alert("请输入合法ID(只包含数字)");
						return false;
					}else{
						flag = true;
					}
				}else{
					flag = true;
				}
				
				var flightInfoId = $("#flightInfoId").val();
				if(isNaN(flightInfoId)){
					alert("请输入合法ID(只包含数字)");
					return false;
				}
				if(flightInfoId&&flightInfoId!=""){
					if (!re.test(flightInfoId)){
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
				$("#vstBasicFlights").jqGrid('setGridParam', {
					url : "${request.contextPath}/sales/vst/queryVstBasicFlights",
					datatype : "json",
					mtype : "POST",
					postData : getQueryParams()
				}).trigger("reloadGrid");
			}
			
			function initGrid() {
				$("#vstBasicFlights").jqGrid({
						url : '${request.contextPath}/sales/vst/queryVstBasicFlights',
						datatype : "json",
						mtype : "POST",
						height : 'auto',// 高度，表格高度。可为数值、百分比或'auto'
						// width:1000,//这个宽度不能为百分比
						autowidth : true,// 自动宽
						colNames : [ 'VST基础航班ID', '出发机场CODE', '到达机场CODE', 'VST出发城市ID', 'VST目的城市ID', '承运人ID', '航班号',
								'对应航班表ID','VST机型ID', '创建时间', '更新时间', '同步标志'],
						colModel : [ {
							name : 'vstBasicFlightId',
							index : 'vstBasicFlightId',
							//formatter : formatLink,
							sortable : false
						}, {
							name : 'deptAirportCode',
							index : 'deptAirportCode',
							sortable : false
						}, {
							name : 'arrvAirportCode',
							index : 'arrvAirportCode',
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
							name : 'vstCarrierId',
							index : 'vstCarrierId',
							sortable : false
						}, {
							name : 'flightNo',
							index : 'flightNo',
							sortable : false
						}, {
							name : 'flightInfoId',
							index : 'flightInfoId',
							sortable : false
						}, {
							name : 'vstAirplaneId',
							index : 'vstAirplaneId',
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
							formatter : formatFlag,
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
			
			//格式化同步标识位
			function formatFlag(cellvalue, options, rowObject){
				var flagStr = "";
				if(rowObject.batchFlag=="SUCC"){
					flagStr="已同步";
				}else{
					flagStr="需同步";
				}
				return flagStr;
			}
			
			function formatLink(cellvalue, options, rowObject) {
				var url = "${request.contextPath}/sales/vst/queryVstProductDetail?vstProductId="+rowObject.vstProductId;
				return "<a href='" + url + "' style='color:blue;' target='_blank'>" + cellvalue + "</a>";
			}
			
			function getQueryParams(){
				var vstBasicFlight = {
					'vstBasicFlightId':$("#vstBasicFlightId").val(),
					'vstCarrierId':$("#vstCarrierId").val(),
					'vstDeptCityId':$("#vstDeptCityId").val(),
					'vstArrvCityId':$("#vstArrvCityId").val(),
					'flightInfoId':$("#flightInfoId").val(),
					'vstAirplaneId':$("#vstAirplaneId").val(),
					'flightNo':$("#flightNo").val(),
					'deptAirportCode':$("#deptAirportCode").val(),
					'arrvAirportCode':$("#arrvAirportCode").val(),
					'updateBeginTime':$("#updateBeginTime").val(),
					'updateEndTime':$("#updateEndTime").val(),
					'batchFlag':$("#batchFlag").val()
				};
				return vstBasicFlight;
			}
			
			function cleanCondition(){
				//$("#vstProductId").attr('value',null);
				$('input[type=text]').val(null);
				$("select").val(null);
			}
		</script>
	</head>
	<body>
	<div class="content content1">
		<input type="hidden" name="search" value="false">
		<div class="infor1">
			VST基础航班ID：<input type="text" id="vstBasicFlightId" name="vstBasicFlightId" width="100"/>
			航班号：<input type="text" id="flightNo" name="flightNo" width="100"/>
			VST承运人ID：<input type="text" id="vstCarrierId" name="vstCarrierId" width="100"/>
			<br/>
			VST出发城市ID：<input type="text" id="vstDeptCityId" name="vstDeptCityId" width="100"/>
			VST目的城市ID：<input type="text" id="vstArrvCityId" name="vstArrvCityId" width="100"/>
			航班表ID：<input type="text" id="flightInfoId" name="flightInfoId" width="100"/>
			<br/>
			出发机场CODE：<input type="text" id="deptAirportCode" name="deptAirportCode" width="100"/>
			到达机场CODE：<input type="text" id="arrvAirportCode" name="arrvAirportCode" width="100"/>
			VST机型ID：<input type="text" id="vstAirplaneId" name="arrvAirportCode" width="100"/>
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
		<table id="vstBasicFlights"></table>
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