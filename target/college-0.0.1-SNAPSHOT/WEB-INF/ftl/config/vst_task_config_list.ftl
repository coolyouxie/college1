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
		
		//初始化编辑弹框
		editDialog = $('#EditDialog').dialog({
		    title:'VST任务配置编辑',
		    width:350,
			height:320,
			modal:false,
			autoOpen:false,
			open:function(event,ui){
				//隐藏右上角关闭按钮
				$(".ui-dialog-titlebar-close", $(this).parent()).hide();
			},
			buttons: {
		        '保存': function() {
		            edit(null,null,'UPDATE');
		        },
		        '取消': function() {
		            $(this).dialog('close');
		        }
		    }
		});
		
		$("#depart").autocomplete({
		 	source: function(request, response) {
               $.ajax({
                   url: "city.do",
                   dataType: "json",
                   data: {cityName:$("#deptCity").val()},
                   type:"POST",
                   success: function(data) {
                	   response($.map(data.cities, function(item) {
                		    return {
	                		     label: item.name,
	                		     value: item.name
                		    };
                		   }));
                   }
               });
            }
        });
        
        $("#arrive").autocomplete({
		 	source: function(request, response) {
               $.ajax({
                   url: "city.do", 
                   dataType: "json",
                   data: {cityName:$("#arrvCity").val()},
                   type:"POST",
                   success: function(data) {
                	   response($.map(data.cities, function(item) {
                		    return {
	                		     label: item.name,
	                		     value: item.name
                		    };
                		   }));
                   }
               });
            }
        });
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
			url : "${request.contextPath}/schedule/vstTask/queryVstTaskConfigList",
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
		var deptCity = $("#deptCity").val();
		var arrvCity = $("#arrvCity").val();
		var deptCode = getCityCode(deptCity);
		var arrvCode = getCityCode(arrvCity);
		return {
			'deptCityCode' : deptCode,
			'arrvCityCode' : arrvCode,
			'search' : false
		}
	}
	
	function initGrid() {
		$("#list").jqGrid({
							url : "${request.contextPath}/schedule/vstTask/queryVstTaskConfigList",
							datatype : "json",
							mtype : "POST",
							postData : getParams(),
							colNames : [ '编号', '出发城市CODE', '到达城市CODE', '运行时间',
									'运行频率(分钟/次)', '工号','上次运行开始时间','上次运行结束时间','运行状态', '创建时间','更新时间',
									'计次', '状态','操作' ],
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
								name : 'runTimeStr',
								index : 'runTimeStr',
								align : 'center',
								width : 100,
								formatter : getRunTimeStr,
								sortable : false
							}, {
								name : 'rate',
								index : 'rate',
								align : 'center',
								width : 100,
								sortable : false
							}, {
								name : 'workerNo',
								index : 'workerNo',
								align : 'center',
								width : 90,
								sortable : false
							}, {
								name : 'lastStartTimeStr',
								index : 'lastStartTimeStr',
								width : 120,
								align : 'center',
								sortable : false
							}, {
								name : 'lastEndTimeStr',
								index : 'lastEndTimeStr',
								width : 120,
								align : 'center',
								sortable : false
							}, {
								name : 'runFlag',
								index : 'runFlag',
								width : 80,
								align : 'center',
								sortable : false,
								formatter:getRunStatus
							}, {
								name : 'createTimeStr',
								index : 'createTimeStr',
								width : 120,
								align : 'center',
								sortable : false
							}, {
								name : 'updateTimeStr',
								index : 'updateTimeStr',
								width : 120,
								align : 'center',
								sortable : false
							}, {
								name : 'runTimes',
								index : 'runTimes',
								width : 60,
								align : 'center',
								sortable : false
							}, {
								name : 'activeFlag',
								index : 'activeFlag',
								align : 'center',
								width : 60,
								formatter:getStatus,
								sortable : false
							}, {
								name : 'operator',
								index : 'operator',
								width : 120,
								align : 'center',
								//formatter:handleButton,
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
							},
							gridComplete : function() { //在此事件中循环为每一行添加日志、废保和查看链接
								var ids = jQuery("#list").jqGrid('getDataIDs');
								var rowData = jQuery("#list").jqGrid('getRowData');
								for ( var i = 0; i < ids.length; i++) {
									var id = ids[i];
									var url = '<a href="#" style="color:blue" onclick="disable('+ id + ')" >禁用</a> '
									if(rowData[i].activeFlag=="禁用中"){
										url = '<a href="#" style="color:blue" onclick="enable('+ id + ')" >启用</a> '
									}
									var url1 = "${request.contextPath}/vstTask/toTaskOpLogByTaskId?vstTaskConfigId="+id;
									operateClick = '<a href="#" style="color:blue" onclick="excute('+ id + ')" >执行</a> '
													+'<a href="#" style="color:blue" onclick="openEditDialog('+ id + ')" >编辑</a> '
													+url
													+'<a href="'+url1+'" style="color:blue" target="_blank" >日志</a>';
									jQuery("#list").jqGrid('setRowData', id, {
										operator : operateClick
									});
								}
							}
						});
	}
	
	function getStatus(cellvalue, options, rowObject){
		var status = "";
		if(cellvalue=="ACTIVE"||cellvalue=='active'){
			status = "启用中";
		}else{
			status = '禁用中';
		}
		return status;
	}
	
	function getRunStatus(cellvalue, options, rowObject){
		var status = "";
		if(cellvalue==1){
			status = "运行中";
		}else{
			status = '运行完成';
		}
		return status;
	}
	
	function getRunTimeStr(cellvalue, options, rowObject){
		if(rowObject.runTimeStart=="00:00"&&"24:00"==rowObject.runTimeEnd){
			return "全天";
		}
		return rowObject.runTimeStart+"-"+rowObject.runTimeEnd;
	}
	
	function excute(id){
		$.ajax({
			url : "${request.contextPath}/schedule/vstTask/excuteVstTask",
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
						'id' : id,
						'handleUpdateTimeStr' : $("#handleUpdateTime").val() + " 00:00:00"
				}),
			success : function(data) {
				if (data.result.flag) {
					alert("操作成功！");
					window.location.reload();
				} else {
					alert(data.result.message);
				}
			}
		});
	}
	
	function disable(id){
		edit(id,'INACTIVE','DISABLE');
	}
	
	function enable(id){
		edit(id,'ACTIVE','ENABLE');
	}
	
	function reloadGrid(){
		$("#list").jqGrid('setGridParam', {
						url : "${request.contextPath}/schedule/vstTask/queryVstTaskConfigList",
						datatype : "json",
						mtype : "POST",
						postData : getParams()
					}).trigger("reloadGrid");
	}

	//添加配置
	function add() {
		if(!setParam()){
			return;
		}
		var deptCity = $("#deptCity").val();
		var arrvCity = $("#arrvCity").val();
		var deptCode = getCityCode(deptCity);
		var arrvCode = getCityCode(arrvCity);
		var runTimeEnd = $("#runTimeEnd").val();
		if(runTimeEnd=="00:00"){
			runTimeEnd = "24:00";
		}
		$.ajax({
			url : "${request.contextPath}/schedule/vstTask/saveVstTaskConfig",
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
						'deptCityCode' : deptCode,
						'arrvCityCode' : arrvCode,
						'runTimeStart' : $("#runTimeStart").val(),
						'runTimeEnd' : runTimeEnd,
						'activeFlag' : 'ACTIVE',
						'handleFlag' : 'ADD',
						'runTimes':0,
						'rate' : $("#rate").val()
				}),
			success : function(data) {
				if (data.flag) {
					alert("操作成功！");
					window.location.reload();
				} else {
					alert(data.message);
				}
			}
		});
	}
	
	//对比时间
	function compareTime(startTime,endTime){
		if(startTime==endTime&&endTime=="00:00"){
			return true;
		}
	    if(endTime<=startTime){
	        return false;
	    }
	    return true;
	}
	
	//设置和验证参数
	function setParam(){
		var deptCity = $("#deptCity").val();
		var arrvCity = $("#arrvCity").val();
		var runTimeStart = $("#runTimeStart").val();
		var runTimeEnd = $("#runTimeEnd").val();
		if(runTimeEnd=="00:00"){
			runTimeEnd = "24:00";
		}
		var rate = $("#rate").val();
		if(deptCity==''||arrvCity==''||runTimeStart==''||runTimeEnd==''||rate==''){
			alert("数据不能为空!");
			return false;
		}
		var flag = compareTime(runTimeStart,runTimeEnd);
		if(!flag){
			alert("请设置合理的运行时间");
			return false;
		}
		var deptCode = getCityCode(deptCity);
		var arrvCode = getCityCode(arrvCity);
		var vstTaskConfig = {
			'deptCityCode' : deptCode,
			'arrvCityCode' : arrvCode,
			'runTimeStart' : $("#runTimeStart").val(),
			'runTimeEnd' : $("#runTimeEnd").val(),
			'rate' : $("#rate").val()
		}
		return vstTaskConfig;
	}
	
	//获取城市CODE
	function getCityCode(city){
		var code = city.substring(city.indexOf("(")+1,city.indexOf(")"));
		return code;
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
					initGrid();
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
	
	//编辑配置
	function openEditDialog(id){
		editDialog.dialog('open');
		$("#vstTaskConfigId").val(id);
		$.ajax({
			url : "${request.contextPath}/schedule/vstTask/getVstTaskConfigById",
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
				'vstTaskConfig':{
					'id' : id
				}
			}),
			success : function(data) {
				 $("#deptCityCodeSpan").html(data.resultDto.deptCityCode);
				 $("#arrvCityCodeSpan").html(data.resultDto.arrvCityCode);
				 $("#runTimeStartEdit").val(data.resultDto.runTimeStart);
				 $("#runTimeEndEdit").val(data.resultDto.runTimeEnd);
				 $("#rateEdit").val(data.resultDto.rate);
				 $("#runFlag").val(data.resultDto.runFlag);
			}
		});
	}
	
	
	
	//编辑
	function edit(id,activeFlag,handleFlag) {
		var runTimeStart = $("#runTimeStartEdit").val();
		var runTimeEnd = $("#runTimeEndEdit").val();
		var deptCode = $("#deptCityCodeSpan").html();
		var arrvCode = $("#arrvCityCodeSpan").html();
		var tempId = id;
		var tempActiveFlag = activeFlag;
		var runFlag = $("#runFlag").val();
		//如果结束时间为0点，则设置为24
		if(runTimeEnd=="00:00"){
			runTimeEnd = "24:00";
		}
		var rate = $("#rateEdit").val();
		var vstTaskConfig = null;
		if(id!=null&&activeFlag!=null){
			runTimeStart = "";
			runTimeEnd = "";
			deptCode = "";
			arrvCode = "";
			rate = "";
		}else{
			if(runTimeStart==''||runTimeEnd==''||rate==''){
				alert("数据不能为空!");
				return;
			}
			tempId=$("#vstTaskConfigId").val();
			tempActiveFlag = "";
		}

		$.ajax({
			url : "${request.contextPath}/schedule/vstTask/saveVstTaskConfig",
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
						'id':tempId,
						'runTimeStart':runTimeStart,
						'runTimeEnd':runTimeEnd,
						'activeFlag':tempActiveFlag,
						'deptCityCode':deptCode,
						'arrvCityCode':arrvCode,
						'handleFlag':handleFlag,
						'rate':rate,
						'runFlag':runFlag
			}),
			success : function(data) {
				if(!data){
					alert("操作失败");
					return;
				}
				if (data.flag) {
					alert("操作完成");
					editDialog.dialog('close');
					window.location.reload();
				} else {
					alert("操作失败");
				}
			}
		}); 
	}
	
</script>
</head>
<body>
	<div class="content content1">
		<div class="breadnav">
			<span>首页</span> >VST任务配置中心
		</div>
		<form id="myForm">
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
						<div class="part">
							人工选择更新时间：<input type="text" value="" id="handleUpdateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" class="Wdate" />
						</div>
						<div style="position:absolute;top:7%;right:15%;">
							<span style="color:red;width:28%">例：08:00-09:00，表示早上8点到9点之间运行<br/>选择00:00-00:00时,表示全天运行</span>
						</div>
					</div>
				</div>
			</div>
			
			<div class="click">
				<a href="javascript:;"><div class="button" onclick="add()">添加</div></a> 
				<a href="javascript:;"><div class="button" onclick="query()">查询</div></a>
				<a href="javascript:;"><div class="button" onclick="reset()">清空</div></a>
			</div>
		</form>
		<div class="content1" style="margin-top: 50px;">
			<table id="list"></table>
			<div id="pager"></div>
		</div>
		<br> <br>
	</div>
	
	
	<#--编辑弹出窗口-->
	<div id="EditDialog" style="display:none;">
		<input type="hidden" id="vstTaskConfigId" />
		<table>
			<tr height="35">
				<td align="right">
					出发城市：
				</td>
				<td>
					<span style="color: red;" id="deptCityCodeSpan"></span>
				</td>
			</tr>
			<tr height="35">
				<td align="right">到达城市：</td>
				<td>
					<span style="color: red;" id="arrvCityCodeSpan"></span>
				</td>
			</tr>
			<tr height="35">	
				<td align="right">运行时间(起点)：</td>
				<td>
					<input type="text" value="" id="runTimeStartEdit" onclick="WdatePicker({dateFmt:'HH:mm'})" style="width:100px;" class="Wdate" />
				</td>
			</tr>
			<tr height="35">	
				<td align="right">运行时间(终点)：</td>
				<td>
					<input type="text" value="" id="runTimeEndEdit" onclick="WdatePicker({dateFmt:'HH:mm'})" style="width:100px;" class="Wdate" />
				</td>
			</tr>
			<tr height="35">
				<td align="right">运行频率(分钟/次)：</td>
				<td>
					<input type="text" id="rateEdit" />
				</td>
			</tr>
			<tr height="35">
				<td align="right">运行状态：</td>
				<td>
					<select id="runFlag">
					  <option value ="" selected = "selected">请选择</option>
					  <option value ="1">运行中</option>
					  <option value="2">运行完成</option>
					</select>
				</td>
			</tr>
		</table>
	</div>
	
	<div style="height:0" class="jsContainer" id="jsContainer"> 
     <div style="display:none;position:absolute;z-index:999;overflow:hidden;" id="tuna_alert"></div> 
     <div style="visibility:hidden;position:absolute;z-index:120;" id="tuna_jmpinfo"></div> 
     <div style="width: 0px; height: 0px;">
      <div style="display:none;position:absolute;top:0;z-index:120;overflow:hidden;-moz-box-shadow:2px 2px 5px #333;-webkit-box-shadow:2px 2px 5px #333;" id="tuna_address">
       <div id="address_warp">
        <div id="address_message">
         &nbsp;
        </div>
        <div id="address_list">
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
        </div>
        <div id="address_p" class="address_pagebreak">
         <a name="p" href="javascript:;" id="address_arrowl">&lt;-</a>
         <a class="address_current" name="1" href="javascript:;" id="address_p1">1</a>
         <a name="2" href="javascript:;" id="address_p2">2</a>
         <a name="3" href="javascript:;" id="address_p3">3</a>
         <a name="4" href="javascript:;" id="address_p4">4</a>
         <a name="5" href="javascript:;" id="address_p5">5</a>
         <a name="n" href="javascript:;" id="address_arrowr">-&gt;</a>
        </div>
       </div>
      </div>
     </div>
    </div>
	
	<script type="text/javascript" src="${request.contextPath}/js/fixdiv.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/address.js"></script>
</body>
</html>