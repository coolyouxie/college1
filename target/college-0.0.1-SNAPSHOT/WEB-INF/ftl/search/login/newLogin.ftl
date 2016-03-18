
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>机票-平台建单</title>
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/citychoose.css">
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/platfrom.css" />
<script type="text/javascript" src="${request.contextPath}/js/resources/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/common.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/jquery-ui.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript"> 
$(function() {	
		$("#depart").autocomplete({
		 	source: function(request, response) {
               $.ajax({
                   url: "city.do",
                   dataType: "json",
                   data: {cityName:$("#departCity").val()},
                   type:"POST",
                   success: function(data) {
//                 	   var citys = [];
//                 	   for(var i = 0;i<data.cities.length;i++){
// //                 		   alert(data.cities[i].name);
                		  
// 							citys[i]=data.cities[i].name;
                		   
//                 	   }    
                	  debugger;
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
                   data: {cityName:$("#arriveCity").val()},
                   type:"POST",
                   success: function(data) {
//                 	   var citys = [];
//                 	   for(var i = 0;i<data.cities.length;i++){
// //                 		   alert(data.cities[i].name);
                		  
// 							citys[i]=data.cities[i].name;
                		   
//                 	   }    
                	  
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
	})
	
	//核对用户输入的账号
	function checkAccount(){
	    $("#regist_userMobile").hide();
		var searchName= $.trim($("#searchName").val());
		if($.trim(searchName)==''){
			alert("请输入信息识别用户帐号");
			return;
		}
		$.ajax({
			url : "${request.contextPath}/loginUser/queryUserMember",
			cache : false,
			async : false,
			data : {
				"paramValue":searchName
				},
			type : "POST",
			datatype : "json",
			success: function(data){
			  $("#search_user_list").show();
              $("#search_user_list").html(data)
   			}
	    });
	}
		
		//点击注册用户，显示注册文本
	function showRegUserAccount(){
	   $("#regist_userMobile").show();
	   $("#search_user_list").hide();
	   $("#searchName").val("");
	   $("#search_user_list").html("")
	   $("#userPhone").val("")
	}
	
	//注册用户
	function regUserAccount(){
		var userPhone = $.trim($("#userPhone").val());
		var isMobile=/^(?:13\d|15\d|18\d)\d{5}(\d{3}|\*{3})$/;
        if($.trim(userPhone)=='' || userPhone.length!=11 || !isMobile.test(userPhone)){
			alert("请输入11位有效的电话号码!");
			return;
		}
		
		$.ajax({
			url : "${request.contextPath}/loginUser/registUserMember",
			cache : false,
			async : false,
			data : {
				"mobileNumber":userPhone
				},
			type : "POST",
			datatype : "json",
			success: function(data){
			if (data != "" && data.status == "SUCCESS") {
				alert(data.message);
		  	    $("#regist_userMobile").hide();
				$("#searchName").val("");
				$("#search_user_list").html("")
				$("#searchName").val(userPhone);
				checkAccount();
				$("#search_user_list").show();
			} else {
				alert(data.message);
			}
   			}
	    });
	}
</script>
	
</head>


<body>
<div class="build-wrap">
<input id="sessionUserId" type="hidden" name="sessionUserId" >
	<!--
	<h1>
    	
    	<a href="${request.contextPath}/order/toOrderList">已付款订单</a>
        <a href="${request.contextPath}/order/toOrderList">退款订单</a>
        <a href="${request.contextPath}/order/toCtmtAuditQueryPage">改签订单</a>
        
    </h1>
    -->
    <h1>
          当前操作用户：
    <#if operUser?exists>  
         ${operUser.oper}   
     </#if>
     </h1>
    <div class="content01 mt10 memberidentify">
	    <div class="hyidentify">会员识别
	    	<div class="hyinput">
		        <input id="vstOrderCheckId" type="checkbox"/><label>VST打包后台</label>
		        <input type="text" value="VST机票主订单"/>
		        <input id="vstOrderMainId" type="text"/>
		        <input type="text" value="VST机票子订单"/>
		        <input id="vstOrderId" type="text"/>
	        </div>
	    </div>

    	
        <ul>
        	<input id="searchName" name="searchName" type="text" placeholder="(模糊查询)会员名称/收集/邮箱/会员卡号" class="inputtxt per28" /> 
            <span>注：输入信息识别用户帐号，无账号则输入手机号注册新用户</span>
            <span class="bluebut"><a href="javascript:checkAccount()">核实账号</a></span>
            <span class="graybut chenk_a"><a href="javascript:showRegUserAccount();">注册新用户</a></span>
            <table width="100%" border="1" id="table01" style="display:none" class="table">
            </table>
          
          <div id="regist_userMobile" style="display:none">
		     <input class="inputtxt per28" id="userPhone" name="userPhone" type="text" placeholder="请输入11位的手机号码" /> 
             <span class="bluebut"><a href="javascript:regUserAccount()">确定</a></span>
		  </div>
            <div id="search_user_list" ></div>
            
        </ul>
    </div>
    <div class="content01 mt10">
    	<form id="formId" action="${request.contextPath}/search" method="post">
    	<div class="per40 fl">
        	<h2>机票查询</h2>
            <ul>
            	<dl>
                	<dt>航程类型</dt>
                    <dd>
                    <input name="doWay" type="radio" value="1" id="radio-single1" checked="true"/><span class="hangcheng">单程</span>
                    <input name="doWay" type="radio" value="2" id="radio-return1"/><span class="hangcheng">往返</span></dd>
                </dl>
            	<dl>
                	<dt>出发城市</dt>
                    <dd>
                        <!-- <input name="" type="text" class="input_a per70" /> -->
                        <div class="demo">
                          <div>
                            <input type="text" size="15" id="departCity" value="" name="departCity" mod="address|notice" mod_address_source="hotel" mod_address_suggest="" mod_address_reference="getcityid" placeholder="中文/拼音" style="color: gray;"
                            class="input_a per70" />
                            &nbsp;<a href="#" onclick="tranferCity();">换</a>
                          </div>
                        </div>
                        <!-- &nbsp;<a href="#">换</a> -->
                    </dd>
                </dl>
            	<dl>
                	<dt>到达城市</dt>
                    <dd>
                        <!-- <input name="" type="text" class="input_a per70" /> -->
                        <div class="demo">
                          <div>
                            <input type="text" size="15" id="arriveCity" name="arriveCity" mod="address|notice" mod_address_source="hotel" mod_address_suggest="" mod_address_reference="getcityid" placeholder="中文/拼音" style="color: gray;"
                            class="input_a per70" />
                          </div>
                        </div>
                    </dd>
                </dl>
                
            	<dl>
                	<dt>出发日期</dt>
                    <dd>
                        <!-- <input name="" type="text" class="input_a per70" /> -->
                        <div class="datechange">
                            <div class="input_date">
                                <input id="departDate" type="text" name="departDate" class="input_d per70" readonly="readonly" onfocus="WdatePicker({doubleCalendar:true,dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d',maxDate:'{%y+1}-%M-%d'})"/>
                            </div>
                            <div id="datepicker-0"></div>
                        </div>
                    </dd>
                </dl>
            	<dl id="dlArriveDate">
                	<dt>返回日期</dt>
                    <dd>
                        <!-- <input name="" type="text" class="input_a per70" /> -->
                        <div class="datechange">
                            <div class="input_date">
                                <input id="arriveDate" type="text" name="arriveDate" class="input_d per70" readonly="readonly" onfocus="WdatePicker({doubleCalendar:true,dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d',maxDate:'{%y+1}-%M-%d'})"/>
                            </div>
                            <div id="datepicker-1"></div>
                        </div>
                    </dd>
                </dl>
                <div class="bluebut mt10 tc">
                	<input id="vstOrderFormId" type="hidden" name="vstOrderId"/>
                	<input id="vstOrderMainFormId" type="hidden" name="vstOrderMainId"/>
                	<input id="isDirect" name="isDirect" type="checkbox" class="mr10"/>仅搜索直飞
                	<div class="search_a" onclick="search();"><a href="javascript:void(0);">搜索</a>
                	</div>
                </div>
            </ul>
        </div>
        </form>
<!--         <div class="per58 ml2 fl"> -->
<!--         	<h2>常见问题</h2> -->
<!--             <ul> -->
<!--             	<li><a href="#">? 婴儿票怎么购买？</a></li> -->
<!--                 <li><a href="#">? 如何购买儿童机票？</a></li> -->
<!--                 <li><a href="#">? 怎么申请改签？</a></li> -->
<!--                 <li><a href="#">? 怎么申请退票？</a></li> -->
<!--                 <li><a href="#">? 商家不给出票怎么办？</a></li> -->
<!--                 <li><a href="#">? 客户预订的机票短信没收到怎么办？</a></li> -->
<!--                 <li><a href="#">? 机票名字写错了怎么办？</a></li> -->
<!--                 <li><a href="#">? 如何确认机票订购成功？</a></li> -->
<!--             </ul> -->
<!--         </div> -->
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
</div>
<script type="text/javascript">
	$(function(){
		
			<#if validSession == 'false'>
				alert("会员信息已失效,请重新选择会员!");
			</#if>
			
			$(".chenk_a").click(function(){
					$("#table01").show()
				});
			
			$(':radio').each(function(){
				if($(this).val() == 1){
					$('#dlArriveDate').hide();
					$('#arriveDate').val(null); 
				}
			});
			
			
		})
		
	 
	function tranferCity(){
		var arriveCity = $('#arriveCity').val();
		var departCity = $('#departCity').val();
		$('#departCity').val(arriveCity);
		$('#arriveCity').val(departCity);
	}
	
	
	//选取会员信息
	function chooseUserInfo(obj){
		var userGrade = $("#userGrade_"+obj).val();
		var userName = $("#userName_"+obj).val();
		var userNo = $("#userNo_"+obj).val();
		var mobileNumber = $("#mobileNumber_"+obj).val();
		$.ajax({
			url : "${request.contextPath}/loginUser/chooseUserMember",
			cache : false,
			async : false,
			data : {
				"userName":userName,
				"userGrade":userGrade,
				"userNo":userNo,
				"userId":obj,
				"mobileNumber":mobileNumber
				},
			type : "POST",
			datatype : "json",
			success: function(data){
			if (data != "" && data.status == "SUCCESS") {
			    $("#sessionUserId").val(obj)
			  }
   			}
	    });
	}
		
	//单击选择往返程
	$('input:radio').click(function(){
		if($(this).val() == 1){
			$('#dlArriveDate').hide();
			//$('#arriveDate').attr('disabled',true);
			$('#arriveDate').val(null);
		}else{
			$('#dlArriveDate').show();
			//$('#arriveDate').attr('disabled',false);
		}
		
	})
	
	//点击搜索
	function search(){
	    var sessionUserId=$('#sessionUserId').val(); 
		var departCity = $('#departCity').val();
		var arriveCity = $('#arriveCity').val();
		var departDate = $('#departDate').val();
		var arriveDate = $('#arriveDate').val();
		if(sessionUserId==""){
			alert('请选取会员信息!');
			return;
		}
		if(departCity==""){
			alert('出发城市不能为空!');
			$('#departCity').focus();
			return;
		}
		if(arriveCity==""){
			alert('到达城市不能为空!');
			$('#arriveCity').focus();
			return;
		}
		if(departDate==""){
			alert('出发时间不能为空!');
//			$('#departDate').focus();
			return;
		}
		
		var regex = /\(\w*\)/;
		if(!regex.test($('#departCity').val()) || !regex.test($('#arriveCity').val())){
			alert('城市没有三字码!');
			return;
		}
		
		var radioVal = $("input:[name=doWay]:radio:checked").val(); 
		if(radioVal!="" && radioVal==2){
			if(arriveDate == null || arriveDate  == ""){
				alert("返回日期不能为空");
				return;
			}
			
			var start = new Date(departDate);
			var end = new Date(arriveDate);
			if(start >= end){
				alert("返回日期不能小于出发日期！");
				return;
			}
		}else{
		    $('#arriveDate').val(null);
		}
		
		if($.trim($('#vstOrderMainId').val()) != '' || $.trim($('#vstOrderId').val()) != ''){
			if(!document.getElementById("vstOrderCheckId").checked){
				alert("请勾选VST打包后台!");
				return false;
			}
		}
		
		if(document.getElementById("vstOrderCheckId").checked){
			if($('#vstOrderMainId').val() == null || $.trim($('#vstOrderMainId').val()) == ''){
				alert("请填写VST主订单ID");
				return false;
			}
			
			if($('#vstOrderId').val() == null || $.trim($('#vstOrderId').val()) == ''){
				alert("请填写VST子订单ID");
				return false;
			}
			
			$('#vstOrderFormId').val($('#vstOrderId').val());
			$('#vstOrderMainFormId').val($('#vstOrderMainId').val());
		}
		
		if(document.getElementById("isDirect").checked){
			$('#isDirect').val("DIRECT");
			$('#formId').submit();
		}else{
			$('#isDirect').val("NOT_DIRECT");
			$('#formId').submit();
		}
	}
</script>

<script type="text/javascript" src="${request.contextPath}/js/fixdiv.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/address.js"></script>
</body>
</html>
