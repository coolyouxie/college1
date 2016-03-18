<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${request.contextPath}/jquery/jqueryui/jquery-ui.css" type="text/css" />
<link rel="stylesheet" href="${request.contextPath}/bootstrap/css/bootstrap v3.3.5.min.css" type="text/css" />
<link rel="stylesheet" href="${request.contextPath}/jquery/jqGrid/css/ui.jqgrid.css" type="text/css" />
<script src="${request.contextPath}/jquery/jQuery v1.11.3.min.js"></script>
<script src="${request.contextPath}/jquery/jqueryui/jquery-ui.js"></script>
<script src="${request.contextPath}/jquery/jqueryui/jquery-ui-cn.js"></script>
<script src="${request.contextPath}/bootstrap/js/bootstrap v3.3.5.min.js"></script>
<script src="${request.contextPath}/jquery/jqGrid/js/grid.base.js"></script>
<script src="${request.contextPath}/jquery/jqGrid/js/grid.common.js"></script>
<script src="${request.contextPath}/jquery/jqGrid/js/i18n/grid.locale-cn.js"></script>
<script src="${request.contextPath}/jquery/jqGrid/js/jquery.jqGrid.js"></script>
<script src="${request.contextPath}/jquery/jqGrid/js/grid.pivot.js"></script>


<script type="text/javascript">
	var editDialog = null;
	$(function() {
		//初始化编辑弹框
		editDialog = $('#EditDialog').dialog({
		    title:'更新教师信息',
			width:350,
			height:320,
			modal:true,
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
	});
	jQuery(document).ready(function(){
		$('#birthday').datepicker();
		$("birthdayEdit").datepicker();
		jQuery("#list").jqGrid({
		    url:"${request.contextPath}/teacher/queryTeachers",
		    datatype: "json",
		    mtype : "POST",
		    jsonReader : {
								root : "resultList", // json中代表实际模型数据的入口  
								page : "pagination.page", // json中代表当前页码的数据   
								records : "pagination.records", // json中代表数据行总数的数据   
								total : 'pagination.total', // json中代表页码总数的数据 
								repeatitems : false
							// 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
							},
		    colNames : [ '姓名', '编号', '性别', '出生日期', '等级', '专业', '班主任', '操作' ],
		    colModel : [ {
								name : 'name',
								index : 'name',
								align : 'center',
								sortable : false
							}, {
								name : 'code',
								index : 'code',
								align : 'center',
								sortable : false
							}, {
								name : 'sex',
								index : 'sex',
								align : 'center',
								sortable : false
							}, {
								name : 'birthdayStr',
								index : 'birthdayStr',
								align : 'center',
								sortable : false
							}, {
								name : 'level',
								index : 'level',
								align : 'center',
								sortable : false
							}, {
								name : 'major.id',
								index : 'major.id',
								align : 'center',
								sortable : false
							}, {
								name : 'headMaster',
								index : 'headMaster',
								align : 'center',
								sortable : false
							}, {
								name : 'operate',
								index : 'operate',
								align : 'center',
								sortable : false
							} ],
		    pager: '#pager',
		    rowNum:10,
		    rowList:[10,20,30],
		    sortname: 'id',
		    viewrecords: true,
		    sortorder: "desc",
		    caption: "教师列表",
		    gridComplete : function() { //在此事件中循环为每一行添加日志、废保和查看链接
								var ids = jQuery("#list").jqGrid('getDataIDs');
								for ( var i = 0; i < ids.length; i++) {
									var id = ids[i];
									var rowData = $('#list').jqGrid('getRowData', id);
									operateClick = '<a href="${request.contextPath}/teacher/getTeacherById/'+id+'" style="color:blue" >编辑</a> <a href="#" style="color:blue" onclick="deleteConfig('+ id + ')" >删除</a>';
									jQuery("#list").jqGrid('setRowData', id, {
										operate : operateClick
									});
								}
							}
		});
	});

	//查询列表信息   
	function query() {
		$("#list").jqGrid('setGridParam', {
			url : "${request.contextPath}/teacher/queryTeachers",
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

	/**function initGrid() {
		$("#list").jqGrid(
						{
							url : "${request.contextPath}/teacher/queryTeachers",
							datatype : "json",
							mtype : "POST",
							colNames : [ '姓名', '编号', '性别', '年龄', '等级', '专业', '班主任', '操作' ],
							colModel : [ {
								name : 'name',
								index : 'name',
								align : 'center',
								sortable : false
							}, {
								name : 'code',
								index : 'code',
								align : 'center',
								sortable : false
							}, {
								name : 'sex',
								index : 'sex',
								align : 'center',
								sortable : false
							}, {
								name : 'age',
								index : 'age',
								align : 'center',
								sortable : false
							}, {
								name : 'level',
								index : 'level',
								align : 'center',
								sortable : false
							}, {
								name : 'major.id',
								index : 'major.id',
								align : 'center',
								sortable : false
							}, {
								name : 'headMaster',
								index : 'headMaster',
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
	*/

	//添加
	function add() {
		var name = $("#name").val();
		var birthday = $("#birthday").val();
		var level = $("#level").val();
		var majorId = $("#majorId").val();
		var sex = $("#sex").val();
		var headMaster = false;
		if($('#headMaster').is(':checked')) {
		    headMaster = true;
		}
		if(name==''||birthday==''||level==''||majorId==''||sex==''){
			alert("数据不能为空!");
			return;
		}
		$.ajax({
			url : "${request.contextPath}/teacher/saveTeacherInfo",
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
						'name' : name,
						'birthdayStr' : birthday,
						'level' : level,
						'sex' : sex,
						'headMaster' : headMaster
				}),
			success : function(data) {
				if (data.flag == 'true') {
					alert("成功！");
					window.location.reload();
				} else {
					alert("失败！");
				}
			}
		}); // ajax-end
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
		editDialog.dialog('open');
		$('#EditDialog').dialog({
		    title:'更新教师信息',
		    width:350,
			height:320,
			modal:'true'
		});
		$.ajax({
			url : "${request.contextPath}/teacher/getTeacherById",
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
				'id' : id
			}),
			success : function(data) {
				 $("#nameEdit").html(data.teacher.name);
				 $("#birthdayEdit").html(data.teacher.birthday);
				 $("#levelEdit").val(data.teacher.level);
				 $("#sexEdit").val(data.teacher.sex);
				 //$("#majorEdit").val(data.teacher.major.id);
			}
		});
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
</script>
</head>
<body>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

	<#--编辑弹出窗口-->
	<div id="EditDialog" style="display:none;">
		<input type="hidden" id="idEdit" />
		<table>
			<tr height="35">
				<td align="right">
					姓名：
				</td>
				<td>
					<span style="color: red;" id="nameEdit"></span>
				</td>
			</tr>
			<tr height="35">	
				<td align="right">出生日期：</td>
				<td>
					<input type="text" value="" id="birthdayEdit" />
				</td>
			</tr>
			<tr height="35">	
				<td align="right">职称：</td>
				<td>
					<input type="text" value="" id="levelEdit" />
				</td>
			</tr>
			<tr height="35">
				<td align="right">性别：</td>
				<td>
					<input type="text" id="sexEdit" />
				</td>
			</tr>
			<tr height="35">
				<td align="right">专业：</td>
				<td>
					<input type="text" id="majorEdit" />
				</td>
			</tr>
			<tr>
				<td></td>
				<td><input id="headMasterEdit" type="checkbox">班主任</td>
			</tr>
		</table>
	</div>
	<div class="row">
		<div class="col-lg-1">
		</div>
		<div class="col-lg-2">
			<div class="input-group input-group-lg">
				<span class="input-group-addon">姓名</span>
				<input type="text" id="name" class="form-control" placeholder="姓名" aria-describedby="sizing-addon3">
			</div>
		</div>
		<div class="col-lg-3">
			<div class="input-group input-group-lg">
				<span class="input-group-addon" >出生日期</span>
				<input id="birthday" type="text" class="form-control" placeholder="出生日期" aria-describedby="sizing-addon3">
			</div>
		</div>
		<div class="col-lg-2">
			<div class="input-group input-group-lg">
				<span class="input-group-addon">职称</span>
				<input id="level" type="text" class="form-control" placeholder="职称" aria-describedby="sizing-addon3">
			</div>
		</div>
	</div>
	<br/>
	<div class="row">
		<div class="col-lg-1">
		</div>
		<div class="col-lg-2">
			<div class="input-group input-group-lg">
				<span class="input-group-addon" >专业</span>
				<input type="text" id="majorId" class="form-control" placeholder="专业" aria-describedby="sizing-addon3">
			</div>
		</div>
		<div class="col-lg-2">
			<div class="input-group input-group-lg">
				<span class="input-group-addon">性别</span>
				<input type="text" id="sex" class="form-control" placeholder="性别" aria-describedby="sizing-addon3">
			</div>
		</div>
		<div class="col-lg-2">
			<div class="checkbox">
				<label>
					<input id="headMaster" type="checkbox">班主任
				</label>
			</div>
		</div>
	</div>
	<br/>
	<div class="row">
		<div class="col-lg-2">
		</div>
		<div class="col-lg-2">
			<label> &nbsp;</label>
		</div>
		<div class="col-lg-2">
			<label> &nbsp;</label>
		</div>
		<div class="col-lg-2">
			<label> &nbsp;</label>
		</div>
		<div class="col-lg-2">
			<a class="btn btn-info" onclick="add()">添加</a>
			<a class="btn btn-info" onclick="query()">查询</a>
		</div>
	</div>
	
	<form id="myForm">
		<div class="row">
			<div class="col-lg-1">
			</div>
			<div class="col-lg-7" style="margin-top: 30px;">
				<table id="list"></table>
				<div id="pager"></div>
			</div>
			
		</div>
	</form>
</body>
</html>