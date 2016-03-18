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
			$(function (){
				initGrid();
			});

			function query(){
				$("#vstSyncConfigDatas").jqGrid('setGridParam',
					{
			 			url:"${request.contextPath}/sales/vst/queryVstSyncConfig",
			 			datatype : "json",
			 			mtype : "POST",
				 		postData : getQueryParams()
					}
				).trigger("reloadGrid");
			}

			function initGrid() 
			{
				$("#vstSyncConfigDatas").jqGrid({
					url : '${request.contextPath}/sales/vst/queryVstSyncConfig',
					datatype : "json",
					mtype : "POST",
					height:'auto',//高度，表格高度。可为数值、百分比或'auto'
			        //width:1000,//这个宽度不能为百分比
			        autowidth:true,//自动宽
					colNames:['同步状态', '上次同步开始时间','上次同步结束时间'],
					colModel : [ 
					{
						name : 'syncFlag',
						index : 'syncFlag',formatter:formatStatus,
						sortable:false
					},
					{
						name : 'lastStartTimeStr',
						index : 'lastStartTimeStr',
						sortable:false
					},
					{
						name : 'lastEndTimeStr',
						index : 'lastEndTimeStr',
						sortable:false
					}],
		            autowidth : true,
					rowNum : 10,
					pager : '#pager',
					viewrecords : true,
					rowList:[10,20,50,200],   //分页选项，可以下拉选择每页显示记录数
					multiselect : false,//复选框
					caption : "VST同步信息查询",
					jsonReader : {
						root : "results",
						page : "pagination.page", //当前页
						records : "pagination.records", //总记录数
						total:'pagination.total',
						repeatitems : false
					},
					onPaging : function(pgButton) {
						$("#vstSyncConfigDatas").jqGrid('setGridParam', {
							postData : getQueryParams()
						});
					}
				});
			}

			function getQueryParams(){
				return null;
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
    		function resetStatus(){
    			$.ajax({
    				url : "${request.contextPath}/sales/vst/resetVSTSyncStatus",
					cache : false,
					async : false,
					type : "GET",
					datatype : "json",
    				success:function(response){
    					alert(response.message);
    				}
    			});
    		}
		</script>
	</head>
	<body>
	<div class="content content1">
        <input type="hidden" name="search" value="false">
		<div class="infor1">
		</div>
		<div class="click">
			<a href="javascript:void(0);" onclick="query();"><div class="button">查询</div></a>
			<a href="javascript:void(0);" onclick="resetStatus();"><div class="button">重置状态</div></a>
		</div>
	</div>

	<div class="content content1" style="margin-top:50px;">
		<table id="vstSyncConfigDatas"></table>
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