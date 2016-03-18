<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>行程单统计</title>
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
			'bspStartNo':$("#bspStartNo").val(),
			'bspEndNo':$("#bspEndNo").val(),
			'operName':$("#operName").val(),
			'startDetailDate':$("#startDetailDate").val(),
			'endDetailDate':$("#endDetailDate").val(),
			}
	}
	
	function initGrid() {
		$("#ticketBspStatisticalList").jqGrid({
			url : "${request.contextPath}/ticket/searchBSPStatistics",
			datatype : "json",
			mtype : "POST",
			height:'auto',//高度，表格高度。可为数值、百分比或'auto'
	        autowidth:true,//自动宽
			colNames:['入库单号','起始单号','终止单号','入库数量','出库数量','未使用数量','已打印','已作废','已回收','Office','入库时间'],
			colModel : [ 
			{name : 'id',index:'id',editable:true,sortable:false,align:'center'},
			{name : 'bspStartNo',index:'bspStartNo',sortable:false,align:'center'},
			{name : 'bspEndNo',index:'bspEndNo',sortable:false,align:'center'},
			{name : 'storageCount',index:'storageCount',sortable:false,align:'center'},
			{name : 'outStorageCount',index:'outStorageCount',sortable:false,align:'center'},
			{name : 'unUsedCount',index:'unUsedCount',sortable:false,align:'center'},
			{name : 'printCount',index:'printCount',sortable:false,align:'center'},
			{name : 'invalidCount',index:'invalidCount',sortable:false,align:'center'},
			{name : 'recycleCount',index:'recycleCount',sortable:false,align:'center'},
			{name : 'officeNo',index:'officeNo',width:120,align:"center",sortable:false},
			{name : 'createTime',index:'createTime',sortable:false,align:'center'}
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
			sortname: 'bspStartNo',  //排序字段名
		    sortorder: "desc",    //排序方式：倒序，本例中设置默认按id倒序排序
			caption : "行程单入库查询",
			
			jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			},
			onPaging : function(pgButton) {
				$("#ticketBspStatisticalList").jqGrid('setGridParam', {
					postData : getQueryParams()
				});
			},
			
			loadComplete:function(data){ //完成服务器请求后，回调函数
				if(data.records==0){ //如果没有记录返回，追加提示信息，删除按钮不可用
					$("p").appendTo($("#list")).addClass("nodata").html('找不到相关数据！');
				}else{ //否则，删除提示，删除按钮可用
					$("p.nodata").remove();
				}
			}
		 });
	} 


    //查询列表信息   
	function searchBspStatistical() {
		$("#ticketBspStatisticalList").jqGrid('setGridParam', {
			 url : "${request.contextPath}/ticket/searchBSPStatistics",
			 datatype : "json",
			 mtype : "POST",
			 postData : getQueryParams()
		}).trigger("reloadGrid");
	}
	
</script> 
</head>
<body>
	<div class="content content1">
	 <form>
		<div class="breadnav"><span>首页</span> > 行程单统计</div>
		<div class="cheak">
			<div class="part part1">
				<span>行程单号：</span><input type="text" name="bspStartNo" id="bspStartNo" /> 至 <input type="text" name="bspEndNo" id="bspEndNo" />
			    <span>入库时间：</span><input type="text" name="startDetailDate" id="startDetailDate" onClick="new Calendar().show(this);" readonly /> 至 <input type="text" name="endDetailDate" id="endDetailDate" onClick="new Calendar().show(this);" readonly />		
			</div>
			<div class="part part2">
				<span>操作员：</span><input type="text" name="operName" id="operName" />
				<div class="click">
					<a href="#"><div class="button" onclick="searchBspStatistical()" >查询</div></a>
				</div>
			</div>
		</div>
	</form>
	</div>

	<div class="content content1">
     <table id="ticketBspStatisticalList"></table>
     <div id="pager"></div>
     </div>
     <br>
     <br>
 
</body>
</html>