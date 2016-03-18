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
			$("#airplaneList").jqGrid('setGridParam', {
				url : "${request.contextPath}/maindata/airplane/queryAirPlaneList",
				datatype : "json",
				mtype : "POST",
				postData : getParams()
			}).trigger("reloadGrid");
		}
		
		function getParams() {
			return {
				'name' : $("#name").val(),
				'code' : $("#code").val(),
				'search' : false
			}
		}
	
		function initGrid() {
			$("#airplaneList").jqGrid({
				url : "${request.contextPath}/maindata/airplane/queryAirPlaneList",
				datatype : "json",
				mtype : "POST",
				colNames : ['序号','机型名称','机型代码','类型','最少座位数','最大座位数','操作'],
				colModel : [ {
					name : 'id',
					index : 'id',
					align : 'center',
					width :30,
					sortable:false
				}, {
					name : 'name',
					index : 'name',
					align : 'center',
					sortable:false
				}, {
					name : 'code',
					index : 'code',
					align : 'center',
					width :50,
					sortable:false
				}, {
					name : 'airplaneType',
					index : 'airplaneType',
					align : 'center',
					width :40,
					sortable:false
				}, {
					name : 'minSeats',
					index : 'minSeats',
					align : 'center',
					width :60,
					sortable:false
				}, {
					name : 'maxSeats',
					index : 'maxSeats',
					align : 'center',
					width :60,
					sortable:false
				}, {
					name : 'operate',
					index : 'operate',
					align : 'center',
					width :50,
					sortable:false
				}
				],
				rowNum:10,            //每页显示记录数
		 	    autowidth: true,      //自动匹配宽度
		 	    pager: '#pager',      //表格数据关联的分页条，html元素
		   	    rowList:[10,20,50,500],   //分页选项，可以下拉选择每页显示记录数
		      	viewrecords: true,    //显示总记录数
		      	height:'auto',//高度，表格高度。可为数值、百分比或'auto'
			    //autoheight: true,     //设置高度
			    gridview:true,        //加速显示
				viewrecords: true,    //显示总记录数
				multiselect : false,
				sortable:true,        //可以排序
			    sortname: 'id',  //排序字段名
		        sortorder: "desc",    //排序方式：倒序
				caption : "机型列表",
				jsonReader : {
					root : "results",               // json中代表实际模型数据的入口  
					page : "pagination.page",       // json中代表当前页码的数据   
					records : "pagination.records", // json中代表数据行总数的数据   
					total:'pagination.total',       // json中代表页码总数的数据 
					repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#airplaneList").jqGrid('setGridParam', {
						postData : getParams()
					});
				},
				gridComplete:function(){  //在此事件中循环为每一行添加修改链接
                    var ids=jQuery("#airplaneList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                    	var id=ids[i];
                        operateClick= '<a href="#" style="color:blue" onclick="update('+id+')" >修改</a>';
                        jQuery("#airplaneList").jqGrid('setRowData', id , {operate:operateClick});
                    }
                }
			});
		}
		
		//新增
		function add() {
		   	window.open("${request.contextPath}/maindata/airplane/getAirPlane/0");
		}
		//修改
		function update(id) {
		   	window.open("${request.contextPath}/maindata/airplane/getAirPlane/"+id);
		}
		 
	</script>
</head>
<body>
	<div class="content content1">
	<div class="breadnav"><span>首页</span> > 机型</div>
	<form id="myForm">
		<div class="infor1">
			<div class="visitor message">
				<div class="main">
					<div class="part">
						<span>机型名称：</span>
						<input type="text" value="" id="name" maxlength="40" />
						<span>机型代码：</span>
						<input type="text" value="" id="code" maxlength="20" />
					</div>
				</div>
			</div>
		</div>
		<div class="click">
				<a href="javascript:;"><div class="button" onclick="query()">查询</div></a> 
		        <a href="javascript:;"><div class="button" onclick="add()">新增</div></a>
		</div>
		</form>
		  <div class="content1" style="margin-top:50px;">
			<table id="airplaneList"></table>
	        <div id="pager"></div>
          </div>
        <br>
        <br>
	</div>
	 
</body>
</html>