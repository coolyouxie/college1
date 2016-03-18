<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/citychoose.css">
<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css" />
<link type="text/css" rel="stylesheet" href="${request.contextPath}/css/jquery-ui.css" />
<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css" />
<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css" />
<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/common.js"></script>
<#--<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>-->
<script type="text/javascript" src="${request.contextPath}/js/jquery-ui.js"></script>
<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
<script src="${request.contextPath}/js/Calendar.js"></script>

<script type="text/javascript">
	var editDialog = null;
	$(function() {
		//初始化grid
		initGrid();
	});
	

	//查询列表信息   
	function query() {
		var depCityCode = $("#depCityCode").val();
		var arrCityCode = $("#arrCityCode").val();

		if (depCityCode == '' || arrCityCode == '') {
			//alert("城市不能为空!");
			//return;
		}

		$("#list").jqGrid('setGridParam', {
			url : "${request.contextPath}/vstTask/queryVstTaskOpLogs",
			datatype : "json",
			mtype : "POST",
			postData : {
				id:$("#vstTaskConfigId").val()
			}
		}).trigger("reloadGrid");
	}

	//清空查询信息   
	function reset() {
		document.getElementById("myForm").reset()
	}
	
	function getParams(){
		var taskOpLog = {
			'vstTaskConfigId' : $("#vstTaskConfigId").val()
		};
		return taskOpLog;
	}

	function initGrid() {
		$("#list").jqGrid({
							url : "${request.contextPath}/vstTask/queryVstTaskOpLogs",
							datatype : "json",
							mtype : "POST",
							postData : getParams(),
							colNames : [ '编号', '出发城市CODE', '到达城市CODE', 'VST任务ID',
									'推送基础航班数', '推送商品数','操作者','操作类型','操作时间', '备注' ],
							colModel : [ {
								name : 'id',
								index : 'id',
								align : 'center',
								width : 90,
								sortable : false
							}, {
								name : 'deptCityCode',
								index : 'deptCityCode',
								align : 'center',
								width : 96,
								sortable : false
							}, {
								name : 'arrvCityCode',
								index : 'arrvCityCode',
								align : 'center',
								width : 96,
								sortable : false
							}, {
								name : 'vstTaskConfigId',
								index : 'vstTaskConfigId',
								align : 'center',
								width : 100,
								sortable : false
							}, {
								name : 'basicFlightCount',
								index : 'basicFlightCount',
								align : 'center',
								width : 100,
								sortable : false
							}, {
								name : 'goodsCount',
								index : 'goodsCount',
								align : 'center',
								width : 90,
								sortable : false
							}, {
								name : 'oper.oper',
								index : 'oper.oper',
								width : 120,
								align : 'center',
								sortable : false
							}, {
								name : 'taskOpTypeStr',
								index : 'taskOpTypeStr',
								width : 120,
								align : 'center',
								sortable : false
							}, {
								name : 'opTimeStr',
								index : 'opTimeStr',
								width : 80,
								align : 'center',
								sortable : false,
								//formatter:getRunStatus
							}, {
								name : 'remark',
								index : 'remark',
								width : 120,
								align : 'center',
								sortable : false
							} ],
							rowNum : 10, //每页显示记录数
							autowidth : true, //自动匹配宽度
							pager : $('#pager'), //表格数据关联的分页条，html元素
							rowList : [ 10, 20, 50, 500 ], //分页选项，可以下拉选择每页显示记录数
							viewrecords : true, //显示总记录数
							height : 'auto',//高度，表格高度。可为数值、百分比或'auto'
							//autoheight: true,     //设置高度
							gridview : true, //加速显示
							viewrecords : true, //显示总记录数
							multiselect : false,
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
							}
						});
	}
	
	function reloadGrid(){
		$("#list").jqGrid('setGridParam', {
						url : "${request.contextPath}/vstTask/queryVstTaskOpLogs",
						datatype : "json",
						mtype : "POST",
						postData : {
							id:$("#vstTaskConfigId").val()
						}
					}).trigger("reloadGrid");
	}
</script>
</head>
<body>
	<div class="content content1">
		<div class="breadnav">
			<span>首页</span> >VST任务日志中心
		</div>
		<input type="hidden" id="vstTaskConfigId" value="${vstTaskConfigId}"/>
		<form id="myForm" style = "display:none">
			<div class="infor1">
				<div class="visitor message">
					<div class="main">
						<div class="part">
							出发城市：
							<input type="text" size="15" id="deptCity" value="" name="deptCity" mod="address|notice" mod_address_source="hotel" mod_address_suggest="" mod_address_reference="getcityid" placeholder="中文/拼音" style="color: gray;" class="input_a per70" />
							到达城市：
							<input type="text" size="15" id="arrvCity" value="" name="arrvCity" mod="address|notice" mod_address_source="hotel" mod_address_suggest="" mod_address_reference="getcityid" placeholder="中文/拼音" style="color: gray;" class="input_a per70" />
							运行时间：<input type="text" value="" id="runTimeStart" onfocus="WdatePicker({dateFmt:'HH:mm'})" style="width:100px;" class="Wdate" />
							-<input type="text" value="" id="runTimeEnd" onfocus="WdatePicker({dateFmt:'HH:mm'})" style="width:100px;" class="Wdate" />
							<br/>
							频率：<input type="text" value="" id="rate" length="300px" />分钟/次<span style="color:red;width:17%">频率设为0时，表示实时查询</span>
						</div>
						<div style="position:absolute;top:7%;right:15%;">
							<span style="color:red;width:28%">例：08:00-09:00，表示早上8点到9点之间运行<br/>选择00:00-00:00时,表示全天运行</span>
						</div>
					</div>
				</div>
			</div>
		</form>
		<div class="content1" style="margin-top: 50px;">
			<table id="list"></table>
			<div id="pager"></div>
		</div>
		<br> <br>
	</div>
</body>
</html>