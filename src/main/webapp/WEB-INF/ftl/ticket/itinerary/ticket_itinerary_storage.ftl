<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>行程单入库</title>
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
		$(".checkall").click(function(){
			if($(".checkall").get()[0].checked){
				$(".c_list input[name='genre']").each(function(){
					$(this).get()[0].checked = true;
				});
			}
			else{
				$(".c_list input[name='genre']").each(function(){
					$(this).get()[0].checked = false;
				});
			}
		});
		
		$(".o_close").click(function(){
			$(".office").css("display","none");
		});
		$(".o_submit .cancle").click(function(){
			$(".office").css("display","none");
		});
	})

	function showTicketStorage(){
	  $("#addBspStroage").css("display","block");
	}
	
	function getQueryParams(){
    	return {
			'bspStartNo':$("#bspStartNo").val(),
			'bspEndNo':$("#bspEndNo").val(),
			'operName':$("#operName").val(),
			'startStorageDate':$("#startDate").val(),
			'endStorageDate':$("#endDate").val(),
			'invetoryBspStatus':$("#invetoryStatus").find("option:selected").val()
			}
	}
	
	function formatOperate(cellvalue, options, rowObject){
		alert(cellvalue);
	}
	
	function initGrid() {
		$("#ticketStorageList").jqGrid({
			url : "${request.contextPath}/ticket/searchBSPStore",
			datatype : "json",
			mtype : "POST",
			height:'auto',//高度，表格高度。可为数值、百分比或'auto'
	        autowidth:true,//自动宽
			colNames:['入库单号', '起始单号','终止单号', '入库数量','Office','备注','操作员','入库时间','操 作'],
			colModel : [ 
			{name : 'id',index:'id',editable:true,sortable:false,align:'center'},
			{name : 'bspStartNo',index:'bspStartNo',sortable:false,align:'center'},
			{name : 'bspEndNo',index:'bspEndNo',sortable:false,align:'center'},
			{name : 'invetoryNumber',index:'invetoryNumber',sortable:false,align:'center'},
			{name : 'officeNo',index:'officeNo',sortable:false,align:'center'},
			{name : 'bspRemark',index:'bspRemark',sortable:false,align:'center'},
			{name : 'operName',index:'operName',sortable:false,align:'center'},
			{name : 'createTime',index:'createTime',sortable:false,align:'center'},
			{name :'invetoryStatusName',index:'invetoryStatusName',width:120,align:"center",sortable:false}
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
				$("#ticketStorageList").jqGrid('setGridParam', {
					postData : getQueryParams()
				});
			},
			
			//operateClick= "<a href='#' style='color:#f60' onclick='updateStorage("+id+")'>修改office</a> | <a href='#'  style='color:#f60' onclick='cancelStorage("+id+")' >取消入库</a>";
			 gridComplete:function(){  //在此事件中循环为每一行添加修改和删除链接
                    var ids=jQuery("#ticketStorageList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                        var id=ids[i];
                        var operateClick = ""; 
                        var model = jQuery("#ticketStorageList").jqGrid('getRowData', id);
                        var inventoryStatus = model.invetoryStatusName;
                        if(inventoryStatus=='已入库'){
	                        operateClick= "<a href='#'  style='color:#f60' onclick='cancelStorage("+id+")' >取消入库</a>";
	                        jQuery("#ticketStorageList").jqGrid('setRowData', ids[i], {invetoryStatusName:operateClick});	
                        }else if(inventoryStatus=='已取消'){
                        	operateClick= '已取消';
	                        jQuery("#ticketStorageList").jqGrid('setRowData', ids[i], {invetoryStatusName:operateClick});	
                        }
                        
                    }
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
	function searchTicketStorage() {
		$("#ticketStorageList").jqGrid('setGridParam', {
			 url : "${request.contextPath}/ticket/searchBSPStore",
			 datatype : "json",
			 mtype : "POST",
			 postData : getQueryParams()
		}).trigger("reloadGrid");
	}
	
	
	
	 //取消入库
	function cancelStorage(id) {
	   $.ajax({
			url : "${request.contextPath}/ticket/cancelBSPStore",
			type:'post',
	        dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
				id:id
			 }),
			success: function(data){
			   alert(data.message);
			   searchTicketStorage();
   			},
   			error: function (data) {
             	alert(eval('(' + data.responseText + ')').message);
            }
	    });
	   }
	   
	   //修改office
	function updateStorage(id) {
        //alert(id);
	    //var model = jQuery("#ticketStorageList").jqGrid('getRowData', id);
       // alert(model.Id);
	   // $("#bspStartNos").val(model.bspStartNo);
		//$("#bspEndNos").val(model.bspEndNo);
		//$("#bspRemark").val(model.bspRemark)
		//$(".office").css("display","block");
           
	   }
	
	</script>
</head>
<body>
	<div class="content content1">
	 <form>
		<div class="breadnav"><span>首页</span> > 行程单入库</div>
		<div class="cheak">
			<div class="part part1">
				<span>行程单号：</span><input type="text" name="bspStartNo" id="bspStartNo" /> 至 <input type="text" name="bspEndNo" id="bspEndNo" />
				<span>操作员：</span><input type="text" name="operName" id="operName" />
				<div class="click">
					<a href="#"><div class="button" onclick="showTicketStorage()">新增</div></a>
				</div>
			</div>
			<div class="part part2">
			    <span>入库日期：</span><input type="text" name="startDate" id="startDate" onClick="new Calendar().show(this);" readonly /> 至 <input type="text" name="endDate" id="endDate" onClick="new Calendar().show(this);" readonly />		
				<span>订单类型：</span>
				<select id="invetoryStatus" name="invetoryStatus" >
					<#list orderInvetoryStatusEnum as val>
					   <option value="${val}">${val.cnName}</option>
					</#list>  
		     	</select>	
				<div class="click">
					<a href="#"><div class="button" onclick="searchTicketStorage()" >查询</div></a>
				</div>
			</div>
			
		</div>
	</form>
	</div>
	
	<div class="content content1">
     <table id="ticketStorageList"></table>
     <div id="pager"></div>
     </div>
     <br>
     <br>
 
 <#include "ticket/itinerary/ticket_itinerary_storage_add.ftl">
</body>
</html>
