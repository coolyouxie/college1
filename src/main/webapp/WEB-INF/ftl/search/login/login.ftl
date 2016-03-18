<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>驴妈妈机票后台会员登录查询</title>
<script type="text/javascript" src="js/Calendar.js"></script>
</head>
<body>
<div id="jsContainer" class="jsContainer" style="height:0">
    <div id="tuna_alert" style="display:none;position:absolute;z-index:999;overflow:hidden;"></div>
    <div id="tuna_jmpinfo" style="visibility:hidden;position:absolute;z-index:120;"></div>
</div>
	<form action="/search.do">
	<table width="400" border="1" cellspacing="0" cellpadding="0" style="text-align:center">
		<tr>
			<td >
				<div id="u73" class="ax_文本" data-label="航程类型">
	              <div id="u74" class="text">
	                <p><span>航程类型</span></p>
	              </div>
	            </div>
			</td>
			<td>
	              <input id="u69_input" type="radio" value="1" data-label="单程" name="sail" checked/>单程
	              <input id="u71_input" type="radio" value="2" data-label="往返" name="sail"/>往返
			</td>
		</tr>
		<tr >
			<td>
				<div id="u75" class="ax_文本" data-label="出发城市">
              <div id="u76" class="text">
                <p><span>出发城市</span></p>
              </div>
            </div>
			</td>	
			<td>	
				<input type="text" size="15" id="homecity_name" name="departCity" mod="address|notice" mod_address_source="hotel" mod_notice_tip="中文/拼音" />
<!-- 				<input type="text" name="departCity" id="homecity_name"> -->
			</td>	
		</tr>
		<tr>	
			<td>
				 <div id="u77" class="ax_文本" data-label="到达城市">
              <div id="u78" class="text">
                <p><span>到达城市</span></p>
              </div>
            </div>

			</td>	
			<td>
				<input type="text" size="15" id="getcity_name" name="arriveCity" mod="address|notice" mod_address_source="hotel"  mod_notice_tip="中文/拼音" />
<!-- 				<input type="text" name="arriveCity" id="getcity_name"> -->
			</td>
		</tr>
		<tr>
			<td>
				 <div id="u91" class="ax_文本" data-label="出发日期">
                    <div id="u92" class="text">
                      <p><span>出发</span><span>日期</span></p>
                    </div>
                  </div>
			</td>
			<td>
				<input id="u93_input" type="date" name="departDate" data-label="出发日期" onClick="new Calendar().show(this);" readonly/>
			</td>
		</tr>
		<tr>
			<td>
				 <div id="u91" class="ax_文本" data-label="到达日期">
                    <div id="u92" class="text">
                      <p><span>返回</span><span>日期</span></p>
                    </div>
                 </div>
			</td>
			<td>
				<input id="u93_input" type="date" name="arriveDate" data-label="到达日期" onClick="new Calendar().show(this);" readonly/>
			</td>
		</tr>
		<tr>
			<td>
				<input id="u71_input" type="checkbox" name="ifVessel"/>仅搜索直飞
			</td>
			<td>
				<input id="u71_input" type="submit" value="搜索"/>
			</td>
		</tr>	
</table>
</form>
<script type="text/javascript" src="js/fixdiv.js"></script>
<script type="text/javascript" src="js/address.js"></script>
</body>
</html>