<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>行程单查看</title>
	<link rel="stylesheet" href="${request.contextPath}/css/trip-list.css">
</head>
<body>
	<div class="content content1">
		<div class="breadnav"><span>首页</span> >行程单查看</div>
		<div class="cheak">
			<div class="part part1">
				<span>PNR：</span><input type="text" />
				<span>票号：</span><input type="text" />
				<span>出票日期：</span><input type="text" /> 至 <input type="text" />
			</div>
			<div class="part part2">
				<span>操作员：</span><input type="text" />
				<span>乘机人：</span><input type="text" />
				<span>乘机日期：</span><input type="text" /> 至 <input type="text" />
				<div class="click">
					<a href=""><div class="button">查询</div></a>
					<!--<a href=""><div class="button">打印</div></a> -->
				</div>
			</div>
		</div>
		<div class="list">
			<table>
				<tr class="border">
					<th width="8%"><input type="checkbox" class="teshu"/>流水号</th>
					<th width="12%">行程单号</th>
					<th width="12%">票号</th>
					<th width="8%">打印状态</th>
					<th width="10%">OFFICE</th>
					<th width="8%">PNR</th>
					<th width="8%">会员</th>
					<th width="8%">操作人</th>
					<th width="16%">操作时间</th>
					<th width="10%">操作</th>
				</tr>
				<tr>
					<td><input type="checkbox"/>1</td>
					<td><span>39489238545</span></td>
					<td>781-2140775658</td>
					<td>未打印</td>
					<td>SHA225</td>
					<td></td>
					<td></td>
					<td>小明</td>
					<td>2010-09-01 17：00</td>
					<td><a href="">打印</a></td>
				</tr>
				<tr>
					<td><input type="checkbox"/>2</td>
					<td></td>
					<td></td>
					<td>已使用</td>
					<td>SHA886</td>
					<td></td>
					<td></td>
					<td>小明</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><input type="checkbox"/>3</td>
					<td></td>
					<td></td>
					<td>已使用</td>
					<td>SHA886</td>
					<td></td>
					<td></td>
					<td>小明</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><input type="checkbox"/>4</td>
					<td></td>
					<td></td>
					<td>已冻结</td>
					<td>SHA886</td>
					<td></td>
					<td></td>
					<td>小明</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><input type="checkbox"/>5</td>
					<td></td>
					<td></td>
					<td></td>
					<td>SHA886</td>
					<td></td>
					<td></td>
					<td>小明</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><input type="checkbox"/>6</td>
					<td></td>
					<td></td>
					<td></td>
					<td>SHA886</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><input type="checkbox"/>7</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><input type="checkbox"/>8</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><input type="checkbox"/>9</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><input type="checkbox"/>10</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</div>
		<div class="turnpage"> 
			<span class="pageup">&lt;上一页</span><!-- 
			--><span class="page" style="background-color:#eaeaea">1</span><!-- 
			--><span class="page">2</span><!-- 
			--><span class="page">3</span><!-- 
			--><span>...</span><!-- 
			--><span class="pagedown">下一页&gt;</span><!-- 
			--><span class="nowpagecount">共27页,</span><!-- 
			--><span class="pageto">到第<input type="text">页</span><!-- 
			--><span class="pageskip">确定</span> 
		</div>
	</div>
</body>
</html>