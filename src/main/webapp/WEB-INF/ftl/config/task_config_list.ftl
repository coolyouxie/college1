
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



<script type="text/javascript">
	$(function() {
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
			url : "${request.contextPath}/taskConfig/queryTaskConfigList",
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
			'depCityCode' : $("#depCityCode").val(),
			'arrCityCode' : $("#arrCityCode").val(),
			'search' : false
		}
	}

	function initGrid() {
		$("#list")
				.jqGrid(
						{
							url : "${request.contextPath}/taskConfig/queryTaskConfigList",
							datatype : "json",
							mtype : "POST",
							colNames : [ '出发城市', '到达城市', '开始日(T+N)',
									'结束日(T+N)', '开始执行时刻(h)', '结束执行时刻(h)',
									'执行频率', '操作' ],
							colModel : [ {
								name : 'depCityCode',
								index : 'depCityCode',
								align : 'center',
								sortable : false
							}, {
								name : 'arrCityCode',
								index : 'arrCityCode',
								align : 'center',
								sortable : false
							}, {
								name : 'startDay',
								index : 'startDay',
								align : 'center',
								sortable : false
							}, {
								name : 'endDay',
								index : 'endDay',
								align : 'center',
								sortable : false
							}, {
								name : 'startHour',
								index : 'startHour',
								align : 'center',
								sortable : false
							}, {
								name : 'endHour',
								index : 'endHour',
								align : 'center',
								sortable : false
							}, {
								name : 'rate',
								index : 'rate',
								align : 'center',
								sortable : false
							}, {
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

									operateClick = '<a href="#" style="color:blue" onclick="openEditDialog('+ id + ')" >编辑</a> <a href="#" style="color:blue" onclick="deleteConfig('+ id + ')" >删除</a>';
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
	
	
	function deleteConfig(id){
		
		  var r=confirm("确定要删除吗？")
		  if (r==false){
		  	return;
		  }
		
		
		$.ajax({
			url : "delete",
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
				request : setDeleteRequest(id)
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
	function setDeleteRequest(id){
		var request = new Object;
		request.id = id;
		return request;
	}
	
	//编辑
	function openEditDialog(id){
		$('#EditDialog').dialog({
		    title:'任务配置编辑',
		    width:350,
			height:320,
			modal:'true'
		});
		
		 $("#taskCofnigId").val(id);
	
		$.ajax({
			url : "get",
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
				request : setDeleteRequest(id)
			}),
			success : function(data) {
				
				 $("#depCityCodeSpan").html(data.depCityCode);
				 $("#arrCityCodeSpan").html(data.arrCityCode);
				 
				 mytest(data.depCityCode,data.arrCityCode);
				 $("#startDayInput").val(data.startDay);
				 $("#endDayInput").val(data.endDay);
				 $("#startHourInput").val(data.startHour);
				 $("#endHourInput").val(data.endHour);
				 $("#rateInput").val(data.rate);
			
			}
		}); // ajax-end
	}
	
	
	
	//编辑
	function edit() {
				var depCityCode = $("#depCityCodeInput").val();
		var arrCityCode = $("#arrCityCodeInput").val();
		var startDay = $("#startDayInput").val();
		var endDay = $("#endDayInput").val();
		var startHour = $("#startHourInput").val();
		var endHour = $("#endHourInput").val();
		var rate = $("#rateInput").val();
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
		var taskCofnigId = $("#taskCofnigId").val();
		var depCityCode = $("#depCityCodeInput").val();
		var arrCityCode = $("#arrCityCodeInput").val();
		var startDay = $("#startDayInput").val();
		var endDay = $("#endDayInput").val();
		var startHour = $("#startHourInput").val();
		var endHour = $("#endHourInput").val();
		var rate = $("#rateInput").val();
		var request = new Object;
		request.id = taskCofnigId;
		request.depCityCode = depCityCode;
		request.arrCityCode = arrCityCode;
		request.startDay = startDay;
		request.endDay = endDay;
		request.startHour = startHour;
		request.endHour = endHour;
		request.rate = rate;
		return request;
	}
	
	
	function mytest(depCityCode,arrCityCode){
			$.ajax({
			url : "getCityList",
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
				   var htmlarr="";
				   var selectdep="";
				   var selectarr="";
					$.each(citys,function(i,n){
						if(data[i]['code']==depCityCode){
							selectdep='selected="selected"';
							htmldep+="<option  "+selectdep+" value="+data[i]['code']+">"+data[i]['name']+"("+data[i]['code']+")</option>";
						}else{
							htmldep+="<option   value="+data[i]['code']+">"+data[i]['name']+"("+data[i]['code']+")</option>";
						}
						})
						//arr
					$.each(citys,function(i,n){
						if(data[i]['code']==arrCityCode){
							selectarr='selected="selected"';
							htmlarr+="<option  "+selectarr+" value="+data[i]['code']+">"+data[i]['name']+"("+data[i]['code']+")</option>";
						}else{
							htmlarr+="<option   value="+data[i]['code']+">"+data[i]['name']+"("+data[i]['code']+")</option>";
						}
						})
		             $("#depCityCodeInput").empty().append(htmldep);
					 $("#arrCityCodeInput").empty().append(htmlarr);
		             
			}
		}); // ajax-end
	
	}
	
	
	
</script>
</head>
<body>
	<div class="content content1">
		<div class="breadnav">
			<span>首页</span> >任务配置中心
		</div>
		<form id="myForm">
			<div class="infor1">

				<div class="visitor message">

					<div class="main">
						<div class="part">


							出发城市： 
									<select  id="depCityCode" length="300px" >
							<option value=""></option>
							<#list citys as city> 
							<option value="${city.code}">${city.name}(${city.code})</option>
								</#list>
							</select>
							
							到达城市：
									<select id="arrCityCode" length="300px" >
							<option value=""></option>
							<#list citys as city> 
							<option value="${city.code}">${city.name}(${city.code})</option>
								</#list>
							</select>
							开始日(T+N)：<input type="text" value="" id="startDay" length="300px" />
							截至日(T+N)：<input type="text" value="" id="endDay" length="300px" /><br />
							开始执行时刻：<input type="text" value="" id="startHour" length="300px" />
							结束执行时刻：<input type="text" value="" id="endHour" length="300px" />
							频率：<input type="text" value="" id="rate" length="300px" /> </span>
						</div>
					</div>
				</div>

			</div>
			<div class="click">
				<a href="javascript:;"><div class="button"
						onclick="add()">添加</div></a> 
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
	
			<input type="hidden" id="taskCofnigId" />
			<table>
				<tr height="35">	
					<td align="right">出发城市<span  style="color: red;" id="depCityCodeSpan"></span>：</td>
					
					<td>
						<select id="depCityCodeInput" length="300px" >
							<option value=""></option>
							<#list citys as city> 
							<option value="${city.code}">${city.name}(${city.code})</option>
								</#list>
							</select>
					</td>
				</tr>
				<tr height="35">	
					<td align="right">到达城市<span style="color: red;"  id="arrCityCodeSpan"></span>：</td>
					<td>
						<select id="arrCityCodeInput" length="300px" >
							<option value=""></option>
							<#list citys as city> 
							<option value="${city.code}">${city.name}(${city.code})</option>
								</#list>
							</select>
					</td>
				</tr>
				<tr height="35">	
					<td align="right">开始日(T+N)：</td>
					<td>
						<input type="text" id="startDayInput" />
					</td>
				</tr>
				<tr height="35">	
					<td align="right">截至日(T+N)：</td>
					<td>
						<input type="text" id="endDayInput" />
					</td>
				</tr>
				<tr height="35">	
					<td align="right">开始执行时刻：</td>
					<td>
						<input type="text" id="startHourInput" />
					</td>
				</tr>
				<tr height="35">	
					<td align="right">截至执行时刻：</td>
					<td>
						<input type="text" id="endHourInput" />
					</td>
				</tr>
				<tr height="35">	
					<td align="right">频率：</td>
					<td>
						<input type="text" id="rateInput" />
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