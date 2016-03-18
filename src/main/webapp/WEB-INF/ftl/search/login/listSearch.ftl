<!DOCTYPE html>
<html>
<head>
<title>驴妈妈机票后台会员登录查询</title>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<link href="js/resources/data/jquery-ui-themes.css" type="text/css"
	rel="stylesheet" />
<link href="js/resources/data/axure_rp_page.css" type="text/css"
	rel="stylesheet" />
<link href="js/resources/ref/styles.css" type="text/css"
	rel="stylesheet" />
<link href="js/resources/player/styles.css" type="text/css"
	rel="stylesheet" />
<link href="js/resources/player/styles_1.css" type="text/css"
	rel="stylesheet" />
<link href="js/resources/player/styles_2.css" type="text/css"
	rel="stylesheet" />

<script src="js/resources/jquery-1.7.1.min.js"></script>
<script src="js/resources/jquery-ui-1.8.10.custom.min.js"></script>
<script src="js/resources/axure/axQuery.js"></script>
<script src="js/resources/axure/globals.js"></script>
<script src="js/resources/axutils.js"></script>
<script src="js/resources/axure/annotation.js"></script>
<script src="js/resources/axure/axQuery.std.js"></script>
<script src="js/resources/axure/doc.js"></script>
<script src="js/resources/data/document.js"></script>
<script src="js/resources/messagecenter.js"></script>
<script src="js/resources/axure/events.js"></script>
<script src="js/resources/axure/action.js"></script>
<script src="js/resources/axure/expr.js"></script>
<script src="js/resources/axure/geometry.js"></script>
<script src="js/resources/axure/flyout.js"></script>
<script src="js/resources/axure/ie.js"></script>
<script src="js/resources/axure/model.js"></script>
<script src="js/resources/axure/repeater.js"></script>
<script src="js/resources/axure/sto.js"></script>
<script src="js/resources/axure/utils.temp.js"></script>
<script src="js/resources/axure/variables.js"></script>
<script src="js/resources/axure/drag.js"></script>
<script src="js/resources/axure/move.js"></script>
<script src="js/resources/axure/visibility.js"></script>
<script src="js/resources/axure/style.js"></script>
<script src="js/resources/axure/adaptive.js"></script>
<script src="js/resources/axure/tree.js"></script>
<script src="js/resources/axure/init.temp.js"></script>
<script src="js/resources/data/data.js"></script>
<script src="js/resources/axure/legacy.js"></script>
<script src="js/resources/axure/viewer.js"></script>
<script type="text/javascript" src="js/Calendar.js"></script>
<script type="text/javascript">
	$axure.utils.getTransparentGifPath = function() {
		return 'resources/images/transparent.gif';
	};
	$axure.utils.getOtherPath = function() {
		return 'resources/Other.html';
	};
	$axure.utils.getReloadPath = function() {
		return 'resources/reload.html';
	};

	function mouseOver(flightNo) {
		document.getElementById('divInfo_'+flightNo).style.visibility = 'visible';
	}

	function mouseOut(flightNo) {
		document.getElementById('divInfo_'+flightNo).style.visibility = 'hidden';
	}

	function seatsOver(seatId) {
		document.getElementById('tableInfo_'+seatId).style.visibility = 'visible';
	}

	function seatsOut(seatId) {
		document.getElementById('tableInfo_'+seatId).style.visibility = 'hidden';
	}

	function show() {
		alert(1111);
		$.ajax({
			url : 'http://localhost:8101/index.do',// 跳转到 action    
			data : {},
			type : 'get',
			// 		    dataType:'json',    
			success : function(data) {
				alert("sucess");
			},
			error : function() {
				// view("异常！");    
				alert("异常！");
			}
		});
	}

	function mm(flightNo,seatId){
		$.ajax({
			url : 'http://localhost:8101/order.do',// 跳转到 action    
			data : {"flightNo":flightNo,"seatId":seatId},
			type : 'get',
			// 		    dataType:'json',    
			success : function(data) {
				alert("sucess");
			},
			error : function() {
				// view("异常！");    
				alert("异常！");
			}
		});
		
	}
	

	
	
	
	
	function tt() {
		var departTimeSeg = $('#u1538_input').val();
		var departCity = $('#homecity_name').val();
		var arriveCity = $('#getcity_name').val();
		var departDate = $('#u93_input').val();
		var arriveDate = $('#u93_input').val();
		alert(departCity);
		alert(arriveCity);
		alert(departDate);
		alert(arriveDate);
		$.ajax({
			url : 'http://localhost:8101/search.do',// 跳转到 action    
			data : {"departTimeSeg":departTimeSeg,"departCity":departCity,"arriveCity":arriveCity,"departDate":departDate,"arriveDate":arriveDate,},
			type : 'get',
			// 		    dataType:'json',    
			success : function(data) {
				alert("sucess");
			},
			error : function() {
				// view("异常！");    
				alert("异常！");
			}
		});
	}
	
	function change(id) {
		if(id=='u6_input'){
			document.getElementById('wangfan').style.visibility = 'visible';
		}
		if(id=='u4_input'){
			document.getElementById('wangfan').style.visibility = 'hidden';
		}
	}
	
	function dd() {
		document.getElementById('wangfan').style.visibility = 'hidden';
	}
	
	function booking(flightNo,seatId){
		var carrierName = $("#carrierName_"+flightNo).val();
		var airplaneType = $("#airplaneModel_"+flightNo).val();
		var departureTime = $("#departureTime_"+flightNo).val();
		var arrivalTime = $("#arrivalTime_"+flightNo).val();
		var stopCount = $("#stopCount_"+flightNo).val();
		var departureAirportName = $("#departureAirportName_"+flightNo).val();
		var departureTermainalBuilding = $("#departureTermainalBuilding_"+flightNo).val();
		var stopCity = $("#stopCity_"+flightNo).val();
		var arrivalAirportName = $("#arrivalAirportName_"+flightNo).val();
		var arrivalTerminalBuilding = $("#arrivalTerminalBuilding_"+flightNo).val();
		
		var seatClassType = $("#seatClassType_"+seatId).val();
		var seatClassDesc = $("#seatClassDesc_"+seatId).val();
		var parPrice = $("#parPrice_"+seatId).val();
		var salePrice = $("#salePrice_"+seatId).val();
		var departCity = $("#homecity_name").val();
		var arriveCity = $("#getcity_name").val();
		var departDate = $("#u93_input").val();
		
		var tabStart = "<table style='width:936px' id='tabStart'>";
		var tabEnd = "</table>";
		
		var showTableHead = "<tr><td colspan='3'><span>去程 &nbsp;"+departCity+"-"+arriveCity+"&nbsp;"+departDate+"</span></td><td>"+
			"<a href='#' onclick='xg()'><span>修改航班</span></a></td></tr>"
		var showTable = "<tr><td><span>"+carrierName+flightNo+"</span><br/><span>计划机型："+airplaneType+"</span></td><td><span>"+
			departureTime+"---<font color='red'>经停</font>---"+arrivalTime+"</span><br/><span>"+departureAirportName+departureTermainalBuilding+
			"<font color='red'>"+stopCity+"</font></span>"+arrivalAirportName+arrivalTerminalBuilding+"<td><span>"+seatClassType+"</span><br/><span>"+
			seatClassDesc+"</span></td><td><span>￥"+salePrice+"</span><span>(含税费)</span>"+
		"</td></tr>";
		
		$("#wangfan").html(tabStart+showTableHead+showTable+tabEnd);
		
		$("#xuanze").remove();
		
		var departCity = $('#getcity_name').val();
		var arriveCity = $('#homecity_name').val();
		var departDate = $('#u93_input').val();
		
		
		$.ajax({
			url : 'http://localhost:8101/search.do',// 跳转到 action    
			data : {"departCity":departCity,"arriveCity":arriveCity,"departDate":departDate},
			type : 'get',
			// 		    dataType:'json',    
			success : function(data) {
			},
			error : function() {
				// view("异常！");    
				alert("异常！");
			}
		});
		
	}
	
	function arriveTimeSort(){
		var departTimeSeg = $('#u1538_input').val();
		var departCity = $('#homecity_name').val();
		var arriveCity = $('#getcity_name').val();
		var departDate = $('#u93_input').val();
		var arriveDate = $('#u93_input').val();
		var isOrder = $('#isOrder').val();
		if(isOrder == 'DSC'){
			isOrder = 'ASC';//ASC为从小到大
		}else{
			var isOrder = 'DSC';//DSC为从大到小
		}
		
		
		$.ajax({
			url : 'http://localhost:8101/search.do',// 跳转到 action    
			data : {"departTimeSeg":departTimeSeg,"departCity":departCity,"arriveCity":arriveCity,"departDate":departDate,"arriveDate":arriveDate,"isOrder":isOrder},
			type : 'get',
			// 		    dataType:'json',    
			success : function(data) {
			},
			error : function() {
				// view("异常！");    
				alert("异常！");
			}
		});
	}
	
	function xg(){
		$('#tabStart').remove();
	}
</script>


</head>
<body>
	<div id="jsContainer" class="jsContainer" style="height: 0">
		<div id="tuna_alert"
			style="display: none; position: absolute; z-index: 999; overflow: hidden;"></div>
		<div id="tuna_jmpinfo"
			style="visibility: hidden; position: absolute; z-index: 120;"></div>
		
	</div>
	<form action="search.do">
		<div id="base" class="">
			<!-- 单程 (单选框) -->
			<div id="u4" class="ax_单选框">
				<label for="u4_input"> <!-- Unnamed () -->
					<div id="u5" class="text">
						<p>
							<span>单程</span>
							<div id="showMsg"></div>
						</p>
					</div>
				</label> <input id="u4_input" value="1" type="radio" name="sail"
					data-label="单程" name="航程" checked  onclick="change(this.id);"/>
			</div>


			<!-- 往返 (单选框) -->
			<div id="u6" class="ax_单选框">
				<label for="u6_input"> <!-- Unnamed () -->
					<div id="u7" class="text">
						<p>
							<span>往返</span>
						</p>
					</div>
				</label> <input id="u6_input" type="radio" name="sail" value="2"
					data-label="往返" name="航程" onclick="change(this.id);"/>
			</div>


			<!-- Unnamed (垂直线) -->
			<div id="u8" class="ax_垂直线">
				<img id="u8_start" class="img "
					src="js/resources/images/transparent.gif" alt="u8_start" /> <img
					id="u8_end" class="img " src="js/resources/images/transparent.gif"
					alt="u8_end" /> <img id="u8_line" class="img "
					src="images/搜索结果页/u8_line.png" alt="u8_line" />
			</div>


			<!-- 机票类型 (动态面板) -->
			<div id="u9" class="ax_动态面板" data-label="机票类型">
				<div id="u9_state0" class="panel_state" data-label="单程">
					<div id="u9_state0_content" class="panel_state_content">

						<!-- 单程BG (形状) -->
						<div id="u10" class="ax_形状" data-label="单程BG">
							<img id="u10_img" class="img "
								src="js/resources/images/transparent.gif" />
							<!-- Unnamed () -->
							<div id="u11" class="text">
								<p>
									<span>&nbsp;</span>
								</p>
							</div>
						</div>

						<!-- 出发城市 (形状) -->
						<div id="u12" class="ax_文本" data-label="出发城市">
							<img id="u12_img" class="img "
								src="js/resources/images/transparent.gif" />
							<!-- Unnamed () -->
							<div id="u13" class="text">
								<p>
									<span>出发城市</span>
								</p>
							</div>
						</div>

						<!-- 出发城市 (文本框(单行)) -->
						<div id="u14" class="ax_文本框_单行_">
							<input type="text" value="${objSear.departCity}" size="15"
								id="homecity_name" name="departCity" mod="address|notice"
								mod_address_source="hotel" mod_notice_tip="中文/拼音" />
							<!-- 						<input type="text" value="${objSear.departCity}" -->
							<!-- 							id="homecity_name" name="departCity" /> -->
						</div>

						<!-- 出发城市 (文本框(单行)) [footnote] -->
						<div id="u14_ann" class="annotation"></div>

						<!-- 到达城市 (形状) -->
						<div id="u15" class="ax_文本" data-label="到达城市">
							<img id="u15_img" class="img "
								src="js/resources/images/transparent.gif" />
							<!-- Unnamed () -->
							<div id="u16" class="text">
								<p>
									<span>到达城市</span>
								</p>
							</div>
						</div>

						<!-- 到达城市 (文本框(单行)) -->
						<div id="u17" class="ax_文本框_单行_">
							<input type="text" value="${objSear.arriveCity}" size="15"
								id="getcity_name" name="arriveCity" mod="address|notice"
								mod_address_source="hotel" mod_notice_tip="中文/拼音" />
							<!-- 							<input type="text" value="${objSear.arriveCity}"  -->
							<!-- 							id="getcity_name" name="arriveCity" /> -->
						</div>

						<!-- 到达城市 (文本框(单行)) [footnote] -->
						<div id="u17_ann" class="annotation"></div>

						<!-- 出发日期 (形状) -->
						<div id="u18" class="ax_文本" data-label="出发日期">
							<img id="u18_img" class="img "
								src="js/resources/images/transparent.gif" />
							<!-- Unnamed () -->
							<div id="u19" class="text">
								<p>
									<span>出发日期</span>
								</p>
							</div>
						</div>

						<!-- 到达日期 (形状) -->
						<div id="u20" class="ax_文本" data-label="到达日期">
							<img id="u20_img" class="img "
								src="js/resources/images/transparent.gif" />
							<!-- Unnamed () -->
							<div id="u21" class="text">
								<p>
									<span>到达日期</span>
								</p>
							</div>
						</div>

						<!-- 出发日期 (文本框(单行)) -->
						<div id="u22" class="ax_文本框_单行_">
							<input id="u93_input" value="${objSear.departDate}" type="date"
								name="departDate" onClick="new Calendar().show(this);" readonly />
						</div>

						<!-- 出发日期 (文本框(单行)) [footnote] -->
						<div id="u22_ann" class="annotation"></div>

						<!-- 到达日期 (文本框(单行)) -->
						<div id="u23" class="ax_文本框_单行_">
							<input id="u93_input" value="${objSear.arriveDate}" type="date"
								name="arriveDate" onClick="new Calendar().show(this);" readonly />
						</div>


						<!-- 到达日期 (文本框(单行)) [footnote] -->
						<div id="u23_ann" class="annotation"></div>
					</div>
				</div>
			</div>
			
			
			<div class="ax_文本框_单行_">
				<div id="u23" class="ax_文本框_单行_">
					<input type="submit" value="搜索" />
				</div>
			</div>
	</form>
	
	
	<div id="wangfan" style="visibility: hidden;">
	</div>
	
	
	
	
	
	
	<!-- -------------------------------------------------------------------------------- -->
		
	<div id="u1519" class="ax_动态面板" data-label="结果列表">

<!-- -------------------------------------------------------------------------------- -->
				<!-- 选择航班 (形状) -->
				<div id="u1520" class="ax_文本" data-label="选择航班">
					<img id="u1520_img" class="img "
						src="js/resources/images/transparent.gif" />
					<!-- Unnamed () -->
					<div id="u1521" class="text">
						<p id="xuanze">
							<span>选择</span><span>航班:</span><span>&nbsp</span><span>${objSear.departCity}</span><span>&gt;</span><span>
								${objSear.arriveCity}</span><span>（<span>${departDate}</span><span>&nbsp</span><span>${week}</span>）
							</span>
						</p>
					</div>
				</div>

				<div id="u1522" class="ax_形状">
					<img id="u1522_img" class="img "
						src="js/resources/images/u1522.png" />
					<!-- Unnamed () -->
					<div id="u1523" class="text">
						<p>
							<span>查看30天&nbsp; </span>
						</p>
						<p>
							<span>最低价&nbsp; </span>
						</p>
					</div>
				</div>


				<!-- Unnamed (形状) -->
				<div id="u1524" class="ax_形状">
					<img id="u1524_img" class="img "
						src="js/resources/images/u1524.png" />
					<!-- Unnamed () -->
					<div id="u1525" class="text">
						<p>
							<span>&nbsp;</span>
						</p>
					</div>
				</div>

				<!-- arrowRight (形状) -->
				<div id="u1526" class="ax_形状" data-label="arrowRight">
					<img id="u1526_img" class="img "
						src="js/resources/images/arrowright_u1526.png" />
					<!-- Unnamed () -->
					<div id="u1527" class="text">
						<p>
							<span>&nbsp;</span>
						</p>
					</div>
				</div>

				<!-- arrowRight (形状) [footnote] -->
				<div id="u1526_ann" class="annotation"></div>

				<!-- arrowRight (形状) -->
				<div id="u1528" class="ax_形状" data-label="arrowRight">
					<img id="u1528_img" class="img "
						src="js/resources/images/arrowright_u1528.png" />
					<!-- Unnamed () -->
					<div id="u1529" class="text">
						<p>
							<span>&nbsp;</span>
						</p>
					</div>
				</div>

				<!-- arrowRight (垂直线) -->
				<div id="u1530" class="ax_垂直线" data-label="arrowRight">
					<img id="u1530_start" class="img "
						src="js/resources/images/transparent.gif" alt="u1530_start" /> <img
						id="u1530_end" class="img "
						src="js/resources/images/transparent.gif" alt="u1530_end" /> <img
						id="u1530_line" class="img "
						src="js/resources/images/arrowright_u1530_line.png"
						alt="u1530_line" />
				</div>

				<!-- arrowLeft (形状) -->
				<div id="u1531" class="ax_形状" data-label="arrowLeft">
					<img id="u1531_img" class="img "
						src="js/resources/images/arrowright_u1526.png" />
					<!-- Unnamed () -->
					<div id="u1532" class="text">
						<p>
							<span>&nbsp;</span>
						</p>
					</div>
				</div>

				<!-- arrowLeft (形状) [footnote] -->
				<div id="u1531_ann" class="annotation"></div>

				<!-- arrowLeft (形状) -->
				<div id="u1533" class="ax_形状" data-label="arrowLeft">
					<img id="u1533_img" class="img "
						src="js/resources/images/arrowright_u1528.png" />
					<!-- Unnamed () -->
					<div id="u1534" class="text">
						<p>
							<span>&nbsp;</span>
						</p>
					</div>
				</div>

				<!-- arrowLeft (垂直线) -->
				<div id="u1535" class="ax_垂直线" data-label="arrowLeft">
					<img id="u1535_start" class="img "
						src="js/resources/images/transparent.gif" alt="u1535_start" /> <img
						id="u1535_end" class="img "
						src="js/resources/images/transparent.gif" alt="u1535_end" /> <img
						id="u1535_line" class="img "
						src="js/resources/images/arrowright_u1530_line.png"
						alt="u1535_line" />
				</div>



				<!-- 筛选 (形状) -->
				<div id="u1536" class="ax_文本" data-label="筛选">
					<img id="u1536_img" class="img "
						src="js/resources/images/transparent.gif" />
					<!-- Unnamed () -->
					<div id="u1537" class="text">
						<p>
							<span>筛选</span><span>条件</span><span>：</span>
						</p>
					</div>
				</div>

				<!-- 筛选 (形状) [footnote] -->
				<div id="u1536_ann" class="annotation"></div>

				<!-- Unnamed (下拉列表框) -->
				
				<div id="u1538" class="ax_下拉列表框">
					<select id="u1538_input" onchange="tt();">
						<#list departureTimeSegment as departTime>
						<#if departTime_index=0>
							<option selected value="${departTime}">${departTime}</option>
						<#else>
							<option value="${departTime}">${departTime}</option>
						</#if>
						</#list>
					</select>
				</div>

				<!-- Unnamed (下拉列表框) -->
				<div id="u1539" class="ax_下拉列表框">
					<select id="u1539_input">
						<#list arrivalTimeSegment as arrivalTime>
						<#if arrivalTime_index=0>
							<option selected value="${arrivalTime}">${arrivalTime}</option>
						<#else>
							<option value="${arrivalTime}">${arrivalTime}</option>
						</#if>
						</#list>
					</select>
				</div>

				<!-- Unnamed (下拉列表框) -->
				<div id="u1540" class="ax_下拉列表框">
					<select id="u1540_input">
						<#list carrierCode as code>
						<#if code_index=0>
							<option selected value="${code}">${code}</option>
						<#else>
							<option value="${code}">${code}</option>
						</#if>
						</#list>
					</select>
				</div>

				<!-- Unnamed (下拉列表框) -->
				<div id="u1541" class="ax_下拉列表框">
					<select id="u1541_input">
						<#list seatClass as seat>
						<#if seat_index=0>
							<option selected value="${seat}">${seat}</option>
						<#else>
							<option value="${seat}">${seat}</option>
						</#if>
						</#list>
					</select>
				</div>

				<!-- 筛选 (形状) -->
				<div id="u1542" class="ax_文本" data-label="筛选">
					<img id="u1542_img" class="img "
						src="js/resources/images/transparent.gif" />
					<!-- Unnamed () -->
					<div id="u1543" class="text">
						<p>
							<span>您已选择</span><span>：</span>
						</p>
					</div>
				</div>

				<!-- 筛选 (形状) [footnote] -->
				<div id="u1542_ann" class="annotation"></div>


				<!-- Unnamed (复选框) -->
				<div id="u1548" class="ax_复选框">
					<label for="u1548_input"> <!-- Unnamed () -->
						<div id="u1549" class="text">
							<p>
								<span>直飞</span>
							</p>
						</div>
					</label> <input id="u1548_input" type="checkbox" value="checkbox" />
				</div>

				<!-- Unnamed (复选框) -->
				<div id="u1550" class="ax_复选框">
					<label for="u1550_input"> <!-- Unnamed () -->
						<div id="u1551" class="text">
							<p>
								<span>提供发票</span>
							</p>
						</div>
					</label> <input id="u1550_input" type="checkbox" value="checkbox" />
				</div>

				<!-- Unnamed (复选框) -->
				<div id="u1552" class="ax_复选框">
					<label for="u1552_input"> <!-- Unnamed () -->
						<div id="u1553" class="text">
							<p>
								<span>餐食</span>
							</p>
						</div>
					</label> <input id="u1552_input" type="checkbox" value="checkbox" />
				</div>

				<div id="u1554" class="ax_形状" data-label="搜索结果表头">
					<table width="1000" cellspacing="0" cellpadding="0"
						style="text-align: center">
						<tr>
							<th>航班信息</th>
							<th><a href="#" onclick="arriveTimeSort();">起抵时间<span><font >▼</font></span></a>
							<input type="hidden" id="isOrder" value="${isOrder}"/>
							</th>
							<th>飞行时长</th>
							<th>餐食</th>
							<th>票面价</th>
							<th>佣金</th>
							<th>销售额（含税）</th>
							<th></th>
						</tr>
						<#list flights as flight>
						<tr>
						    <input type="hidden" id="carrierName_${flight.flightNo}" value="${flight.carrierName}"/>
							<td><span>${flight.carrierName}</span><span>${flight.flightNo}</span><br />
								<span>计划机型: </span><span onmouseover="mouseOver('${flight.flightNo}');"
								onMouseOut="mouseOut('${flight.flightNo}');">${flight.airplaneModel.code}</span>
								<input type="hidden" id="airplaneModel_${flight.flightNo}" value="${flight.airplaneModel.code}"/>
							</td>
							<td><span>${flight.departureTime}</span>---<#if (flight.stopCount>0)><span><font color='red'>经停</font></span></#if></span>---<span>${flight.arrivalTime}</span><br/>
								<span>${flight.departureAirportName}${flight.departureTermainalBuilding}</span>
								---<span><#if (flight.stopCount>0) ><span><font color='red'>${flight.stopCity}</font></span></#if></span>---<span>${flight.arrivalAirportName}${flight.arrivalTerminalBuilding}</span>
								<input type="hidden" id="departureTime_${flight.flightNo}" value="${flight.departureTime}"/>
								<input type="hidden" id="arrivalTime_${flight.flightNo}" value="${flight.arrivalTime}"/>
								<input type="hidden" id="stopCount_${flight.flightNo}" value="${flight.stopCount}"/>
								<input type="hidden" id="departureAirportName_${flight.flightNo}" value="${flight.departureAirportName}"/>
								<input type="hidden" id="departureTermainalBuilding_${flight.flightNo}" value="${flight.departureTermainalBuilding}"/>
								<input type="hidden" id="stopCity_${flight.flightNo}" value="${flight.stopCity}"/>
								<input type="hidden" id="arrivalAirportName_${flight.flightNo}" value="${flight.arrivalAirportName}"/>
								<input type="hidden" id="arrivalTerminalBuilding_${flight.flightNo}" value="${flight.arrivalTerminalBuilding}"/>
							</td>
							<td>${flight.flyTimeMins}</td>
							<td>${flight.mealType}</td>
							<td>${flight.parPrice}</td>
							<td>${flight.profit}</td>
							<td>${flight.salePrice}</td>
							<td><a href="#"><span>选择</span></a></td>
							
						</tr>


						<#if flight.slightSeatInfos ?exists> <#list flight.slightSeatInfos
						as seat>
						<tr>
							<td>${seat.seatClassName}</td>
							<input type="hidden" id="seatClassName_${seat.id}" value="${seat.seatClassName}"/>
							<td><span>${seat.seatClassType}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
								onmouseover="seatsOver('${seat.id}');" onMouseOut="seatsOut('${seat.id}');">${seat.seatClassDesc}</sapan>
								<input type="hidden" id="seatClassType_${seat.id}" value="${seat.seatClassType}"/>
								<input type="hidden" id="seatClassDesc_${seat.id}" value="${seat.seatClassDesc}"/>
								<input type="hidden" id="salePrice_${seat.id}" value="${seat.salePrice}"/>
								</td>
							<td></td>
							<td></td>
							<td>${seat.parPrice}
								<input type="hidden" id="parPrice_${seat.id}" value="${seat.parPrice}"/>
							</td>
							<td>${seat.cashBack}</td>
							<td>￥<span>${seat.salePrice}</span><br /> <span>已优惠</span><span>${seat.promotion}</span></td>
							<td><input type="button" value="预定" onclick="booking('${flight.flightNo}','${seat.id}');"/></td>
						</tr>

						<tr colspan='7'>
							<td>
								<table id="tableInfo" width="400" border="1" cellspacing="0"
									cellpadding="0" style="text-align: center; visibility: hidden;">

									<#list seat.ticketRules as ticketRule > <#assign
									details=ticketRule.details> <#list details?keys as dekey>
									<#assign detail=details[dekey]> <#list detail as ticket> <#if
									ticket_index=0>
									<tr>
										<td rowspan="2">${ticketRule.passenger}</td>
										<td>${ticket.detailFeeDesc}</td>
										<td>${ticket.detailFeeType}</td>
									</tr>
									<#else>
									<tr>
										<td>${ticket.detailFeeDesc}</td>
										<td>${ticket.detailFeeType}</td>
									</tr>
									</#if> </#list> </#list> </#list>
								</table>
							</td>
						</tr>
						</#list>
						<tr>
							<td><input type="button" value="展开" onclick="show();" /></td>
						</tr>
						</#if>
						<tr colspan='7'>
							<td>
								<table id="divInfo" width="400" border="1" cellspacing="0"
									cellpadding="0" style="text-align: center; visibility: hidden;">
									<tr>
										<th>计划机型</th>
										<th>机型名称</th>
										<th>类型</th>
										<th>最少座位数</th>
										<th>最多座位数</th>
									</tr>
									<tr>
										<td>${flight.airplaneModel.code}</td>
										<td><span>${flight.airplaneModel.name}</span><span>${flight.airplaneModel.code}</span></td>
										<td>${flight.airplaneModel.airplaneType}</td>
										<td>${flight.airplaneModel.minSeats}</td>
										<td>${flight.airplaneModel.maxSeats}</td>
									</tr>
								</table>
							</td>
						</tr>
						</#list>
					</table>
				</div>
				
					<!-- ---------------------------------------------------------- -->		
	  </div>
	 
		<!-- ---------------------------------------------------------- -->		
	</div>


	<script type="text/javascript" src="js/fixdiv.js"></script>
	<script type="text/javascript" src="js/address.js"></script>
</body>
</html>