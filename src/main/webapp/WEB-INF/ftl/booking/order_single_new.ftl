<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>填写订单-单程</title>
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="${request.contextPath}/js/resources/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/messages_cn.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/area_tankuang.css">

<style>
     input,textarea{border:1px solid #e4e4e4;}
     
     .address input{border:1px solid #e4e4e4;}
     
     .error {
        	color:Red; 
     }

     
      
</style>
</head>
<body>
<form id="myform">  
	  <#if userMember?exists>   
			<input type="hidden" name="userName" id="userName_book" value="${userMember.userName}"/>
			<input type="hidden" name="userId" id="userId_book" value="${userMember.userId}"/>
			<input type="hidden" name="userNo" id="userNo_book" value="${userMember.userNo}"/>
			<input type="hidden" name="grade" id="grade_book" value="${userMember.grade}"/>        
			<input type="hidden" name="mobileNumber" id="mobileNumber_book" value="${userMember.mobileNumber}"/>        
     </#if>
	<div class="container">
		<div class="nav">
			<a href=""> 首页</a>&nbsp;&gt;&nbsp;<a href="">航班查询</a>&nbsp;&gt;&nbsp;填写订单 (会员：${userMember.userName})
		</div>
		<div id="bookingFlightInfo">
		<#include "booking/booking_flightInfo_new.ftl">
		 </div>
		 <div class="passenger">
			<div class="title">保险信息</div>
			<div class="msg">
				<div class="div-list">
					<table class="list" style="width:70%;" id="insuranceTab">
						<#include "booking/insurance-info.ftl">
					  </table>
				</div>	  	
				</div>
				</div>
				</div>

			<div class="passenger">
			<div class="title">乘客信息</div>
			
			<div class="msg">
			   <#if passengersList??>
				<ul class="name">
					<li style="left:20px;"><img src="images/order/user.png"></li>
					<input type="hidden" name="passengersSize" id="passengersSize" value="${passengersList?size}" />
					<#list passengersList as passengers>
					<#if passengers_index < 5 >
					 <li>
					<#else>
					  <li style="display:none;" id="pasSizeAll_${passengers_index}">
					</#if>
					<input type="checkbox" onclick="checkAtrrPassenger('${passengers.receiverId}')" name="receiverName${passengers.receiverId}" id="receiverName_${passengers.receiverId}" value="${passengers.receiverName}">${passengers.receiverName}</input>
					<input type="hidden" name="receiverId" id="receiverId_${passengers.receiverId}" value="${passengers.receiverId}" />
					<input type="hidden" name="certType" id="certType_${passengers.receiverId}" value="${passengers.certType}" /> 
					<input type="hidden" name="certNo" id="certNo_${passengers.receiverId}" value="${passengers.certNo}" /> 
					<input type="hidden" name="receiverGender" id="receiverGender_${passengers.receiverId}" value="${passengers.receiverGender}" /> 
					<input type="hidden" name="mobileNumber" id="mobileNumber_${passengers.receiverId}" value="${passengers.mobileNumber}" /> 
					<input type="hidden" name="birthday" id="birthday_${passengers.receiverId}" value="${(passengers.birthday?string('yyyy-MM-dd'))!''}" />
					<input type="hidden" name="peopleType" id="peopleType_${passengers.receiverId}" value="${passengers.peopleType}" /> 
					</li>
				   </#list>
				   <#if 5 < passengersList?size >
					<li id="searchAll"><a href="javascript:void(0);" onclick="searchAllPassenger()">查看所有</a></li>
					<li id="retractionAll" style="display:none;"><a href="javascript:void(0);" onclick="retractionAllPassenger()">收起所有</a></li>
					</#if>
				</ul>
				</#if>
				<div class="div-list">
					<table class="list" id="passengers">
						<tr>
							<td width="10%">乘客类型</td>
							<td width="6%">姓名</td>
							<td width="6%">性别</td>
							<td width="15%">证件类型</td>
							<td  width="20%">证件号码</td>
							<td  width="15%">出生日期</td>
							<td  width="15%">手机号码</td>
							<td  width="6%">操作</td>
						</tr>
					</table>
					<div class="add" style="cursor: pointer;" onclick="addPassengerInfo();">
						<img src="images/order/add.png"> 添加乘客
					</div>
				</div>
			</div>
		</div>
		<div class="order">
			<div class="title">订单信息</div>
			<div class="msg">
				  <span class="span-1"><font>联系人：</font><input type="text" id="contactName"  name="contactName"  style="width:60%;border:1px solid #e4e4e4;" class="required"><font color="red"  style="width:15px;">&nbsp;*</font></span>
				  <span class="span-2"><font>联系人手机：</font><input type="text" id="contactCellphone" name="contactCellphone" style="width:60%;border:1px solid #e4e4e4;" class="required isMobile" onchange="checkMobile();" ><font color="red"  style="width:15px;">&nbsp;*</font></span> 
				  <span class="span-3"><font>电子邮件：</font><input type="text" id="contactEmail" name="contactEmail" style="width:60%;border:1px solid #e4e4e4;" class="email"></span>
				<div>
					<font>内部备注：</font>
					<textarea id="backRemark"></textarea>
				</div>
				<div>
					<font>用户备注：</font>
					<textarea id="customerRemark"></textarea>
				</div>
			</div>
		</div>
		<div class="distribution">
			<div class="title">配送信息</div>
			<div class="msg">
				<div>
					配送方式：
					 <#list expressTypeEnum as val>
					 	<span><input type="radio"  onclick="setCurExpressCode(this.value);"  value="${val}" name="expressType"  <#if val=='NO_NEED'>checked=checked</#if>>${val.cnName}</span>
					</#list>
					<input type="hidden" id="curExpressType" >
					<input type="hidden" id="curExpressCode" >
				</div>
				<ul id="address_ul">
				</ul>
				<!--<a class="all">展开所有</a>-->
				<div class="address" id="addressDiv" style="display:none;">
					<span><img src="images/order/add.png">添加地址 </span>
					<div class="div-1">
						<span>收件人：</span><input type="text" id="addressRecipient" name="addressRecipient"  ><font color="red" style="width:15px;">&nbsp;*</font>
					</div>
					<div>
						<span>手机号码：</span><input type="text" id="addressCellphone"  name="addressCellphone" >
					</div>
					<div>
						<span>固定电话：</span><input type="text" id="addressTelephone" name="addressTelephone" >
					</div>
					<div class="div-4">
						<!--<span>配送地址：</span><select><option>选择省</option></select><select><option>选择市</option></select><select><option>选择区</option></select>-->
						<input type="text" placeholder="详细街道地址，无需重复填写省市区" id="addressAddress"  name="addressAddress" ><font color="red" style="width:15px;">&nbsp;*</font>
					</div>
					<div class="div-5">
						<span>邮政编码：</span><input type="text" id="addressPostCode"  name="addressPostCode" >
						<!--<a href="javascript:void(0)">查询邮政</a>-->
						<input type="button" style="border: 0 none; background: #FF8500; color: #FFFFFF;  height: 28px; line-height: 28px;margin-left: 10px; vertical-align: middle; width: 50px;" value="保存" onclick="addAddress();">
					</div>
				</div>
				<!--
				<div class="company">
					<span>配送公司：</span><select><option>驴妈妈</option></select>
					<div>&yen;20</div>
					<a href="">配送范围和费用介绍</a>
				</div>
				-->
			</div>
		</div>
		<div class="money">
			<div class="top">
				<div class="first-child">应付金额：</div>
				<div id="last-child" class="last-child">
					&yen;<span></span>
				</div>
			</div>
			<div style="clear: left;"></div>
			<div class="more">
				<img src="images/order/sanjiao.png">
			</div>
			<ul class="ul-1">
				
			</ul>
		</div>
		<div class="detail">
			<table class="tab-detail">
				<tr class="tr-1">
					<td rowspan="2"><a class="a-detail"><img
							src="images/order/down.png"><span>展开明细</span></a></td>
					<td>票面价</td>
					<td>-&nbsp;优惠金额</td>
					<td>+&nbsp;机建</td>
					<td>+&nbsp;燃油</td>
					<td>+&nbsp;保险</td>
					<td>+&nbsp;附加费</td>
					<td>+&nbsp;快递费</td>
					<td rowspan="2" class="last-td">应收合计：<span id="receiveAmount">&yen;</span>
						<button class="btn-one" id="booking">去核对</button>
						<button class="btn1">去支付</button>
						<button class="btn2">上一步</button>
						<button class="btn3">取消订单</button></td>
				</tr>
				<tr class="tr-2 top">
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr class="tr-title">
					<td colspan="8">
						<table class="tab-detail">
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div>
	</form>
	<form id="qicheng_form" action="search" method="post">
	</form>
	<form id="huicheng_form" action="search" method="post">
	</form>
</body>
<input id="vstOrderId" type="hidden" name="vstOrderId" value="${vstOrderId}"/>
<input id="vstOrderMainId" type="hidden" name="vstOrderMainId" value="${vstOrderMainId}"/>
<input id="bookingCount" type="hidden" value="0">
<!--下拉选项框  -->
<div>
 <div id="passengerTypeAddHtml" style="visibility:hidden;">
	    <#list passengerTypeEnum as val>
	    	<#if val=='ADULT'>
				<option value="${val}">${val.cnName}</option>
			</#if>
			
			<#if val=='CHILDREN' && (products > 1)>
				<option value="${val}">${val.cnName}</option>
			</#if>
		</#list>
  </div>
  <div id="genderAddHtml" style="visibility:hidden;">
	      <#list genderEnum as val>
			<option value="${val}">${val.cnName}</option> 
		 </#list>
  </div>
  <div id="passengerIDCardTypeAddHtml" style="visibility:hidden;"> 
	     <#list idCardTypeEnum as val>
			<option value="${val}">${val.cnName}</option>
		 </#list>
  </div>
  
   <input type="hidden" id="curOrderTotalSalesAmount"/>
</div>



<script type="text/javascript">

   //设置自动补全的数据源
   function passengersSouce() {
        var passengers=new Array();
        var selPassengers=new Array()
        var hasSel = "";
        $('input[id^=receiverName_]').each(function() {  
             if($(this).attr("checked")=="checked"){
            	 var curId = $(this).attr("id");
            	 selPassengers.push(curId.substring(curId.indexOf("_")+1));
             }
        });
       <#if passengersList??>
		 <#list passengersList as passengers>
		       var passengerId = '${passengers.receiverId}';
		       if($.inArray(passengerId, selPassengers)<0){
		    	   var passengerObj = new Object();
				   passengerObj.label ='${passengers.receiverName}'+","+getCertTypeName('${passengers.certType}')+","+'${passengers.certNo}';
				   passengerObj.value=passengerId;
				   passengers.push(passengerObj);
		       }
	    </#list>
	   </#if>
        return passengers;
    }
   
   function getCertTypeName(certType){
	   
	   switch(certType){
		   case 'ID':
			     return '身份证'
			     break;
		   case 'PASSPORT':
			     return '护照'
			     break;
		   case 'OFFICER':
			     return '军官证'
			     break;
		   case 'SOLDIER':
			     return '士兵证'
			     break;
		   case 'TAIBAO':
			     return '台胞证'
			     break;
		   default:
		      return '其他'
     }
   }
  

//判断乘机人的手机号码是否为空，根据填写联系人的号码补充乘机人信息
function checkMobile(){
     var contactCellPhoneVal=$("#contactCellphone").val();
     $('#passengers input[name^=cellphone_]').each(function() { $(this).attr('name', 'cellphone');});	
	 $('#passengers tr').each(function(){
    	var cellphoneVal =  $(this).find("[name='cellphone']").val();
    	if(cellphoneVal==""){
    	$(this).find("[name='cellphone']").val(contactCellPhoneVal)
    	}
     });
   }
   
    $(".tankuang_hover").mouseover(function(e){ 
		this.myTitle = this.title;
		this.title = "";     
		var tooltip = "<div class='area_model tankuang_show'>"+ this.myTitle +"<\/div>"; //创建 div 元素        
		$("body").append(tooltip);    //把它追加到文档中
			$(".tankuang_show").css({
			  	"top": (e.pageY+20) + "px",                 
			  	"left": (e.pageX+10)  + "px"             
			}).show("fast");      //设置x坐标和y坐标，并且显示
		}).mouseout(function(){                 
			this.title = this.myTitle;         
			$(".tankuang_show").hide();   //移除      
		}).mousemove(function(e){         
			$(".tankuang_show").css({                 
				"top": (e.pageY+20) + "px",                 
				"left": (e.pageX+10)  + "px"             
		});     
	}); 
    
	

//身份证号码验证
function isIdCardNo(num) {
		var factorArr = new Array(7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,1);
		var parityBit=new Array("1","0","X","9","8","7","6","5","4","3","2");
		var varArray = new Array();
		var intValue;
		var lngProduct = 0;
		var intCheckDigit;
		var intStrLen = num.length;
		var idNumber = num;
		
		// initialize
		if ((intStrLen != 15) && (intStrLen != 18)) {
		    return false;
		}
		// check and set value
		for(i=0;i<intStrLen;i++) {
		     	varArray[i] = idNumber.charAt(i);
				if ((varArray[i] < '0' || varArray[i] > '9') && (i != 17)) {
				  return false;
				} else if (i < 17) {
				   varArray[i] = varArray[i] * factorArr[i];
				}
		 }
		
		if (intStrLen == 18) {
			  //check date
			 var date8 = idNumber.substring(6,14);
			 if (isDate8(date8) == false) {
			     return false;
			 }
			 // calculate the sum of the products
			for(i=0;i<17;i++) {
				   lngProduct = lngProduct + varArray[i];
			}
			// calculate the check digit
			intCheckDigit = parityBit[lngProduct % 11];
			// check last digit
			if (varArray[17] != intCheckDigit) {
			   return false;
			}
		}else{
		     //length is 15
			//check date
			var date6 = idNumber.substring(6,12);
			if (isDate6(date6) == false) {
			   return false;
			}
		}
		return true;
}

//判断是否为“YYYYMM”式的时期
function isDate6(sDate) {
	if(!/^[0-9]{6}$/.test(sDate)) {
	return false;
	}
	var year, month, day;
	year = sDate.substring(0, 4);
	month = sDate.substring(4, 6);
	if (year < 1700 || year > 2500) return false
	if (month < 1 || month > 12) return false
	return true;
}

//判断是否为“YYYYMMDD”式的时期
function isDate8(sDate) {
		if(!/^[0-9]{8}$/.test(sDate)) {
		     return false;
		}
		var year, month, day;
		year = sDate.substring(0, 4);
		month = sDate.substring(4, 6);
		day = sDate.substring(6, 8);
		var iaMonthDays = [31,28,31,30,31,30,31,31,30,31,30,31]
		if (year < 1700 || year > 2500) return false
		if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) iaMonthDays[1]=29;
		if (month < 1 || month > 12) return false
		if (day < 1 || day > iaMonthDays[month - 1]) return false
		return true;
}

//根据日期获取两个两者之间的年数,判断乘客类型
function getDateDiffCardType(departureDateVal,birthDateVal) { 
	var birthDateArr=birthDateVal.split("-"); 
	var flightDepartureDateArr=departureDateVal.split("-"); 
	var intDays = flightDepartureDateArr[0] -birthDateArr[0] - 1; 
	if (birthDateArr[1] < flightDepartureDateArr[1] || birthDateArr[1] == flightDepartureDateArr[1] && birthDateArr[2] <= flightDepartureDateArr[2]) { 
	   intDays++; 
	} 
	var cardTypeVal;
	if(intDays>=12){
       cardTypeVal="ADULT";
    }if(intDays<12 && intDays>=2){
       cardTypeVal="CHILDREN"; 
    }
	//initAjax();
	return cardTypeVal; 
} 


//根据身份证信息获取出生日期，性别
function getPassengerBirth(i) {
 	//判断身份证与出生日期
	var passengerIDCardType = $('#passengers select[name=passengerIDCardType_'+i+']').val();
	var passengerIDCardNo =  $('#passengers input[name=passengerIDCardNo_'+i+']').val();
    var gender;
	if(passengerIDCardType=="ID"){
		var passengerBirth = getBirthdatByIdNo(passengerIDCardNo, i, true);
		//根据身份证获取乘客生日日期
		$('#passengers input[name=passengerBirthday_'+i+']').val(passengerBirth);
		
		//截取身份证号的倒数第二位，区分性别
		var tmpStr = passengerIDCardNo.substring(16, 17);
		if(tmpStr%2==0){
			gender = "FEMALE";
		}else{
			gender = "MALE";
		}
		$('#passengers select[name=gender_'+i+']').val(gender);
	}
}

//当其他证件类型时候，选取生日区分乘客类型
 function getBirthdatByValue(mid) {
    var birthDateVal = $('#passengers input[name=passengerBirthday_'+mid+']').val();
	var flightDepartureDate= $("#flightDepartureDate").val();
	var cardTypeVals=getDateDiffCardType(flightDepartureDate,birthDateVal);
    $('#passengers select[name=passengerType_'+mid+']').val(cardTypeVals);
	initAjax();
 }

 //根据身份证号获取出生日期
 function getBirthdatByIdNo(iIdNo, i, needInitAjax) {
		var tmpStr = "";
		var idDate = "";
		var tmpInt = 0;
		var strReturn = "";
		iIdNo = $.trim(iIdNo);
		if (iIdNo.length == 15) {
			tmpStr = iIdNo.substring(6, 12);
			tmpStr = "19" + tmpStr;
			tmpStr = tmpStr.substring(0, 4) + "-" + tmpStr.substring(4, 6) + "-" + tmpStr.substring(6);
		}else {
			tmpStr = iIdNo.substring(6, 14);
			tmpStr = tmpStr.substring(0, 4) + "-" + tmpStr.substring(4, 6) + "-" + tmpStr.substring(6)
		}
		
		var flightDepartureDate= $("#flightDepartureDate").val();
		//根据身份证号信息，区分乘客类型
		var cardTypeVals=getDateDiffCardType(flightDepartureDate,tmpStr);
        $('#passengers select[name=passengerType_'+i+']').val(cardTypeVals);
		if(needInitAjax){
			initAjax();
		}

		return tmpStr;
  }
	
   	$(function(){
   	    addPassengerInfo();
	   	// 手机号码验证    
	    jQuery.validator.addMethod("isMobile", function(value, element) {    
	      var length = value.length;    
	      return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));    
	    }, "请正确填写您的手机号码。");
	    
		// 身份证号码验证
	    jQuery.validator.addMethod("isIdCardNo", function(value, element) { 
	      return this.optional(element) || isIdCardNo(value);    
	    }, "请输入正确的身份证号码。"); 
	    
	     // 邮政编码验证    
	    jQuery.validator.addMethod("isZipCode", function(value, element) {    
	      var zip = /^[0-9]{6}$/;    
	      return this.optional(element) || (zip.test(value));    
	    }, "请正确填写您的邮政编码。");  
   	
	 	//initTiketRules();
	 	initAjax();
   	
   	});
   	
   	
	function initTiketRules(){
		
        <#list segList as flightInfos>
		var m = 0;
		var n = 0;
		var childHeadTd = "";
		var auditHeadTd = "";
		<#list flightInfos.ticketRuleForms as ticketRuleForm>
			<#list ticketRuleForm.heads as head>
				<#if ticketRuleForm.passengerType == 'ADULT'>
					auditHeadTd = auditHeadTd+"<td class='last-td'>"+ '${head}'+"</td>";
				</#if>
				<#if ticketRuleForm.passengerType == 'CHILDREN'>
					childHeadTd = childHeadTd+"<td class='last-td'>"+ '${head}'+"</td>";
				</#if>
			</#list>
		</#list>
		
		if(auditHeadTd != ""){
			m++;
		}
		if(childHeadTd != ""){
			n++;
		}
		
		var auditVtTd = "";
		var childVtTd = "";
		<#list flightInfos.ticketRuleForms as ticketRuleForm>
			<#list ticketRuleForm.vts as vt>
				<#if ticketRuleForm.passengerType == 'ADULT'>
					if('${vt}' == ''){
						auditVtTd = auditVtTd+"<td class='last-td'>&yen;"+ '${vt}'+"</td>";
					}else{
						auditVtTd = auditVtTd+"<td class='last-td'>&yen;"+ '${vt}'+"</td>";
					}
				</#if>
				<#if ticketRuleForm.passengerType == 'CHILDREN'>
					if('${vt}' == ''){
						childVtTd = childVtTd+"<td class='last-td'>&yen;"+ '${vt}'+"</td>";
					}else{
						childVtTd = childVtTd+"<td class='last-td'>&yen;"+ '${vt}'+"</td>";
					}
				</#if>
			</#list>
		</#list>
		if(auditVtTd != ""){
			m++;
		}
		if(childVtTd != ""){
			n++;
		}
		
		var auditRtTd = "";
		var childRtTd = "";
		<#list flightInfos.ticketRuleForms as ticketRuleForm>
			<#list ticketRuleForm.rts as rt>
				<#if ticketRuleForm.passengerType == 'ADULT'>
					if('${rt}' == ''){
						auditRtTd = auditRtTd+"<td class='last-td'>"+ '${rt}'+"</td>";
					}else{
						auditRtTd = auditRtTd+"<td class='last-td'>&yen;"+ '${rt}'+"</td>";
					}
				</#if>
				<#if ticketRuleForm.passengerType == 'CHILDREN'>
					if('${rt}' == ''){
						childRtTd = childRtTd+"<td class='last-td'>"+ '${rt}'+"</td>";
					}else{
						childRtTd = childRtTd+"<td class='last-td'>&yen;"+ '${rt}'+"</td>";
					}
				</#if>
			</#list>
		</#list>
		if(auditRtTd != ""){
			m++;
		}
		if(childRtTd != ""){
			n++;
		}
		
		var auditCtTd = "";
		var childCtTd = "";
		<#list flightInfos.ticketRuleForms as ticketRuleForm>
			<#list ticketRuleForm.cts as ct>
				<#if ticketRuleForm.passengerType == 'ADULT'>
					if('${ct}' == ''){
						auditCtTd = auditCtTd+"<td class='last-td'>"+ '${ct}'+"</td>";
					}else{
						auditCtTd = auditCtTd+"<td class='last-td'>&yen;"+ '${ct}'+"</td>";
					}
				</#if>
				<#if ticketRuleForm.passengerType == 'CHILDREN'>
					if('${ct}' == ''){
						childCtTd = childCtTd+"<td class='last-td'>"+ '${ct}'+"</td>";
					}else{
						childCtTd = childCtTd+"<td class='last-td'>&yen;"+ '${ct}'+"</td>";
					}
				</#if>
			</#list>
		</#list>
		if(auditCtTd != ""){
			m++;
		}
		if(childCtTd != ""){
			n++;
		}
		
		var auditMtTd = "";
		var childMtTd = "";
		<#list flightInfos.ticketRuleForms as ticketRuleForm>
			<#list ticketRuleForm.mts as mt>
			<#if ticketRuleForm.passengerType == 'ADULT'>
				if('${mt}' == ''){
					auditMtTd = auditMtTd+"<td class='last-td'>"+ '${mt}'+"</td>";
				}else{
					auditMtTd = auditMtTd+"<td class='last-td'>&yen;"+ '${mt}'+"</td>";
				}
			</#if>
			<#if ticketRuleForm.passengerType == 'CHILDREN'>
				if('${mt}' == ''){
					childMtTd = childMtTd+"<td class='last-td'>"+ '${mt}'+"</td>";
				}else{
					childMtTd = childMtTd+"<td class='last-td'>&yen;"+ '${mt}'+"</td>";
				}
			</#if>
			</#list>
		</#list>
		if(auditMtTd != ""){
			m++;
		}
		if(childMtTd != ""){
			n++;
		}
		
		var auditTicketDesc = "";
		var childTicketDesc = "";
		<#list flightInfos.ticketRuleForms as ticketRuleForm>
			<#list ticketRuleForm.ticketRuleDesc as desc>
			<#if ticketRuleForm.passengerType == 'ADULT'>
				if('${desc}' == ''){
					auditTicketDesc = auditTicketDesc+"<td class='last-td'>"+ '${desc}'+"</td>";
				}else{
					auditTicketDesc = auditTicketDesc+"<td colspan='2' class='last-td'>"+ '${desc}'+"</td>";
				}
			</#if>
			<#if ticketRuleForm.passengerType == 'CHILDREN'>
				if('${desc}' == ''){
					childTicketDesc = childTicketDesc+"<td class='last-td'>"+ '${desc}'+"</td>";
				}else{
					childTicketDesc = childTicketDesc+"<td colspan='2' class='last-td'>"+ '${desc}'+"</td>";
				}
			</#if>
			</#list>
		</#list>
		if(auditTicketDesc != ""){
			m++;
		}
		if(childTicketDesc != ""){
			n++;
		}
		
		var auditRtType = "";
		var childRtType = "";
		<#list flightInfos.ticketRuleForms as ticketRuleForm>
			<#assign rts=ticketRuleForm.rts>
			<#if (rts?size>0)>
				<#if ticketRuleForm.passengerType == 'ADULT'>
				auditRtType = "<tr>"+"<td>退票费</td>"+auditRtTd+"</tr>";
				</#if>
				<#if ticketRuleForm.passengerType == 'CHILDREN'>
				childRtType = "<tr>"+"<td>退票费</td>"+childRtTd+"</tr>";
				</#if>
			</#if>
		</#list>
		
		var auditCtType = "";
		var childCtType = "";
		<#list flightInfos.ticketRuleForms as ticketRuleForm>
			<#assign cts=ticketRuleForm.cts>
			<#if (cts?size>0)>
				<#if ticketRuleForm.passengerType == 'ADULT'>
				auditCtType = "<tr>"+"<td>改期费</td>"+auditCtTd+"</tr>";
				</#if>
				<#if ticketRuleForm.passengerType == 'CHILDREN'>
				childCtType = "<tr>"+"<td>改期费</td>"+childCtTd+"</tr>";
				</#if>
			</#if>
		</#list>
		
		var auditMtType = "";
		var childMtType = "";
		<#list flightInfos.ticketRuleForms as ticketRuleForm>
			<#assign mts=ticketRuleForm.mts>
			<#if (mts?size>0)>
				<#if ticketRuleForm.passengerType == 'ADULT'>
				auditMtType = "<tr>"+"<td>签转费</td>"+auditMtTd+"</tr>";
				</#if>
				<#if ticketRuleForm.passengerType == 'CHILDREN'>
				childMtType = "<tr>"+"<td>签转费</td>"+childMtTd+"</tr>";
				</#if>
			</#if>
		</#list>
		
		var auditDescType = "";
		var childDescType = "";
		<#list flightInfos.ticketRuleForms as ticketRuleForm>
			<#assign descs=ticketRuleForm.ticketRuleDesc>
			<#if (descs?size>0)>
				<#if ticketRuleForm.passengerType == 'ADULT'>
				auditDescType = "<tr>"+"<td>退改详情</td>"+auditTicketDesc+"</tr>";
				</#if>
				<#if ticketRuleForm.passengerType == 'CHILDREN'>
				childDescType = "<tr>"+"<td>退改详情</td>"+childTicketDesc+"</tr>";
				</#if>
			</#if>
		</#list>
		
		var auditDiv = '<table class="withdraw"><tr><td rowspan="'+m+'" width="24px">成<br/>人<br/>票</td>'+
		'<td></td>'+auditHeadTd+'</tr>'+auditRtType+auditCtType+auditMtType+auditDescType+'</table>';
		var childDiv = '<table class="withdraw"><tr><td rowspan="'+n+'" width="24px">儿<br/>童<br/>票</td>'+
		'<td></td>'+childHeadTd+'</tr>'+childRtType+childCtType+childMtType+childDescType+'</table>';
		
		<#if flightInfos.flightTripType == "DEPARTURE">
		$('#singleWay').css('display','block');
		$('#singleWay').append(auditDiv);
		$('#singleWay').append(childDiv);
		<#else>
		$('#returnTrip').css('display','block');
		$('#returnTrip').append(auditDiv);
		$('#returnTrip').append(childDiv);
		</#if>
		</#list>
	}
	
/*乘客信息序号*/
function idSort(){
//    $("#passengers").find(" tr").not(":nth-child(1)").each(function(i){
//        $(this).find('td').eq(0).html($(this).index());
//    });
}

//获取当前会员信息
function getUserMember(){
	var obj = new Object;
	obj.customerId=$("#userNo_book").val();
	obj.customerName=$("#userName_book").val();
	obj.customerLevel=$("#grade_book").val();
	obj.customerCode=$("#userId_book").val();
	obj.customerCellphone = $("#mobileNumber_book").val();
	return obj;
}
	
//选择联系人类型
//$(".passengerType").change(function(){
//	initAjax();
//})
       
//删除联系人
function delPassengerInfo(obj){
	 var delTrId = $(obj).parent().parent().attr("id");
	 var receiveId = delTrId.substring(delTrId.indexOf("_")+1)
     $(obj).parent().parent().remove();
	 $("#receiverName_"+receiveId).attr("checked",false);
     idSort();
     initAjax();
   }
   
 	   
//添加联系人信息    
var passI = 0;
function addPassengerInfo(){
	  passI++;
	  var i = passI;
      var addPassengerInfo ='<tr id="passengerTr_'+i+'"><td style="display:none;" id="passengerTdIds_'+i+'" ">'+i+'</td>'
      +'<td><select name="passengerType_'+i+'" id="passengerType_'+i+'" class="passengerType" onchange="initAjax();">'+$("#passengerTypeAddHtml").html()+'</select></td>'
      +'<td><input type="text" name="passengerName_'+i+'" id="passengerName_'+i+'" class="required"  /></td>'
      +'<td class="td-4"><select name="gender_'+i+'" id="gender_'+i+'" >'+$("#genderAddHtml").html()+'</select></td>'
      +'<td><select name="passengerIDCardType_'+i+'" id="passengerIDCardType_'+i+'" oninput="onIDCardTypeChange(this);" onPropertyChange="onIDCardTypeChange(this);">'+$("#passengerIDCardTypeAddHtml").html()+'</select></td>'
      +'<td><input type="text" name="passengerIDCardNo_'+i+'" id="passengerIDCardNo_'+i+'" " class="required isIdCardNo" oninput="getPassengerBirth('+i+');" onPropertyChange="getPassengerBirth('+i+')"></td>'
      +'<td><input type="text" name="passengerBirthday_'+i+'" id="passengerBirthday_'+i+'" onchange="getBirthdatByValue('+i+')"  onfocus="WdatePicker({dateFmt:\'yyyy-MM-dd\'})" style="width:100px;"  readonly="readonly" class="Wdate required"></td>'
      +'<td><input type="text" name="cellphone_'+i+'" id="cellphone_'+i+'" class="isMobile"></td>'
      +'<td style="display:none;"><input type="hidden" name="passengerId" id="passengerId_'+i+'"/> </td>'
      +'<td><a class="remove" href="javascript:void(0);" onclick="delPassengerInfo(this);">删除</a></td>';
	  $("#passengers").append(addPassengerInfo);
	  var curReceiveId;
	  var passengersSource = passengersSouce();
	  $("#passengerName_"+i).autocomplete({
	        source: passengersSource,
	        select: function( event, ui) {
	        	curReceiveId = ui.item.value;
			},
			close: function() {
				autoCompletePassenger(i,curReceiveId);
			    curReceiveId="";
		     }
	   });
	  idSort();
	  initAjax();
 }


function autoCompletePassenger(i,receiveId){
	     $("#passengerType_"+i).val($("#peopleType_"+receiveId).val());
	     $("#passengerName_"+i).val($("#receiverName_"+receiveId).val());
	     $("#passengerIDCardNo_"+i).val($("#certNo_"+receiveId).val());
	     $("#passengerIDCardType_"+i).val($("#certType_"+receiveId).val());
	     $("#gender_"+i).val($("#receiverGender_"+receiveId).val());
	     $("#passengerBirthday_"+i).val($("#birthday_"+receiveId).val());
	     $("#cellphone_"+i).val($("#mobileNumber_"+receiveId).val());
	     $("#passengerTr_"+i).attr("id","passengerTr_"+receiveId);
	     $("#receiverName_"+receiveId).attr("checked",true);
}
    	
//选择证件类型
function onIDCardTypeChange(obj){
   if($(obj).val()=="ID"){
         $(obj).parent().parent().find("[name^='passengerIDCardNo_']").attr("class","required isIdCardNo");
   }else{
         $(obj).parent().parent().find("[name^='passengerIDCardNo_']").attr("class","required");
   }
}

//判断填写的身份证信息是否有重复
function  checkPassengerIDCardNo(obj){
        var certNoVal=$(obj).val();
        $('#passengers input[name^=passengerIDCardNo_]').each(function() { $(this).attr('name', 'passengerIDCardNo'); });
		var checkBoolean="false";
		$('#passengers tr').each(function(){
			var $passengerIDCardNo =  $(this).find("[name='passengerIDCardNo']").val();
			if($passengerIDCardNo==certNoVal){
			   checkBoolean="true";
			}
        })
     if(checkBoolean!="" && checkBoolean=="true"){
            alert("该乘客身份证信息已添加，请重新填写！！！");
    	    $(obj).parent().parent().remove();
            idSort();
            initAjax();
            i--;
     }
}
	
//查看所有联系人
function searchAllPassenger(){
	var pasSize= $("#passengersSize").val();
	for(var i=5;i<pasSize;i++){
       $("#pasSizeAll_"+i).css('display','block');
    };
    $("#searchAll").css('display','none');
    $("#retractionAll").css('display','block');
}

//收起所有联系人
function retractionAllPassenger(){
	var pasSize= $("#passengersSize").val();
	for(var i=5;i<pasSize;i++){
       $("#pasSizeAll_"+i).css('display','none');
    };
    $("#searchAll").css('display','block');
    $("#retractionAll").css('display','none');
}

//点击添加联系人
var checkType='0';
function checkAtrrPassenger(pid){
	var receiverId= $('#receiverId_'+pid).val();
	var receiverName= $('#receiverName_'+pid).val();
	var certNo= $('#certNo_'+pid).val();
	var mobileNumber= $('#mobileNumber_'+pid).val();
	var certType= $('#certType_'+pid).val();

	
	
	var birthday;
	var receiverGender;
	var peopleType;
	var flightDepartureDate= $("#flightDepartureDate").val();
	if(certType=="ID"){
		var passengerBirth = getBirthdatByIdNo(certNo, pid, false);
		//根据身份证获取乘客生日日期
		 birthday=passengerBirth;
		
		//截取身份证号的倒数第二位，区分性别
		var tmpStr = certNo.substring(16, 17);
		var genderVal;
		if(tmpStr%2==0){
			genderVal = "FEMALE";
		}else{
			genderVal = "MALE";
		}
		receiverGender=genderVal;

	   //根据身份证号信息，区分乘客类型
       peopleType=getDateDiffCardType(flightDepartureDate,passengerBirth);
       
      }else{
           birthday= $('#birthday_'+pid).val();
           receiverGender= $('#receiverGender_'+pid).val();
           peopleType= $("#peopleType_"+pid).val();
        }

	var receiverNameVal = $("input[name='receiverName"+pid+"']:checked").val();
	var flag=false;
	if(typeof(receiverNameVal)!="undefined"){
		//判断是否添加重复的
		$('#passengers tr').each(function(){
 	    	var $passengerIDCardType =  $(this).find("[name^='passengerIDCardType_']").val();
 	    	var $passengerIDCardNo =  $(this).find("[name^='passengerIDCardNo_']").val();
 	    	if($passengerIDCardNo==certNo && $passengerIDCardType==certType){
 	    	    flag=true;
 	    	    return false;
 	    	}
 	     })
 	     
 	    if(!flag){
	     var choosePassengerInfo = ' <tr id="passengerTr_'+pid+'"><td style="display:none;" id="passengerTdIds_'+pid+'">'+pid+'</td>'
          +'<td><select name="passengerType_'+pid+'" id="passengerTypes_'+pid+'" class="passengerType" onchange="initAjax();">'+$("#passengerTypeAddHtml").html()+'</select></td>'
          +'<td><input type="text" name="passengerName_'+pid+'" id="passengerNames_'+pid+'" class="required" /></td>'
          +'<td class="td-4"><select name="gender_'+pid+'" id="genders_'+pid+'" >'+$("#genderAddHtml").html()+'</select></td>'
          +'<td><select name="passengerIDCardType_'+pid+'" id="passengerIDCardTypes_'+pid+'" oninput="onIDCardTypeChange(this);" onPropertyChange="onIDCardTypeChange(this);">'+$("#passengerIDCardTypeAddHtml").html()+'</select></td>'
          +'<td><input type="text" name="passengerIDCardNo_'+pid+'" id="passengerIDCardNos_'+pid+'"  class="required isIdCardNo" oninput="getPassengerBirth('+pid+');" onPropertyChange="getPassengerBirth('+pid+');"></td>'
          +'<td><input type="text" name="passengerBirthday_'+pid+'" id="passengerBirthdays_'+pid+'" onchange="getBirthdatByValue('+pid+')" onfocus="WdatePicker({dateFmt:\'yyyy-MM-dd\'})" style="width:100px;"  readonly="readonly" class="Wdate required"></td>'
          +'<td><input type="text" name="cellphone_'+pid+'" id="cellphones_'+pid+'" class="isMobile"></td>'
          +'<td style="display:none;"><input type="hidden" name="passengerId" id="passengerIds_'+pid+'"/> </td>'
          +'<td><a class="remove" href="javascript:void(0);" onclick="delPassengerInfo(this)" id="'+pid+'">删除</a></td>';
		  $("#passengers").append(choosePassengerInfo);
		  $("#genders_"+pid).val(receiverGender)
		  $("#passengerIds_"+pid).val(receiverId);
		  $("#passengerTypes_"+pid).val(peopleType);
		  $("#passengerNames_"+pid).val(receiverName);
		  $("#passengerIDCardTypes_"+pid).val(certType);
	      $("#passengerIDCardNos_"+pid).val(certNo);
		  $("#passengerBirthdays_"+pid).val(birthday);
		  $("#cellphones_"+pid).val(mobileNumber);
		  idSort();
		  initAjax();
//		  i++;
		}else{
		   alert("该乘客身份证信息已添加，请重新填写！！！");
           $("#receiverName_"+pid).attr("checked",false);
		}
	}else{
        $("#passengerTr_"+pid).remove();
        idSort();
        initAjax();
//        i--;
	}
}

		
//获取乘机人信息
function getFlightOrderPassengers(){
	 var arrayList = new Array();
	 var index = 0;
 	    $('#passengers tr').each(function(){
 	        var $passengerTypeFake = $(this).find("[name='passengerType']").val();
 	    	if(typeof($passengerTypeFake) == "undefined"){
 	    		return true;
 	    	}
 	    	var $uuid = $(this).find("[name='passengerId']").val();
 	    	var $passengerType = $(this).find("[name='passengerType']").val();
 	    	var $passengerName =  $(this).find("[name='passengerName']").val();
 	    	var $gender =  $(this).find("[name='gender']").val();
 	    	var $passengerIDCardType =  $(this).find("[name='passengerIDCardType']").val();
 	    	var $passengerIDCardNo =  $(this).find("[name='passengerIDCardNo']").val();
 	    	var $passengerBirthday =  $(this).find("[name='passengerBirthday']").val();
 	    	var $cellphone =  $(this).find("[name='cellphone']").val();
 	    	var passengerObj = new Object;
 	    	passengerObj.uuid=$uuid;
 	    	passengerObj.passengerType = $passengerType;
 	    	passengerObj.passengerName = $passengerName;
 	    	passengerObj.gender = $gender;
 	    	passengerObj.passengerIDCardType = $passengerIDCardType;
 	    	passengerObj.passengerIDCardNo = $passengerIDCardNo;
 	    	var birthDay = $passengerBirthday;
 	    	var arr1 = birthDay.split("-");  
 	    	passengerObj.passengerBirthday = new Date(arr1[0],parseInt(arr1[1])-1,arr1[2]);
 	    	passengerObj.cellphone = $cellphone;
 	    	arrayList[index++] = passengerObj;
		});
	    return arrayList;	
	}
	
	
	//订单联系人信息
	function getContact(){
		return {
			name:$('#contactName').val(),
			cellphone:$('#contactCellphone').val(),
			email:$('#contactEmail').val()
		};
	}
	
	
	//预订请求明细对象列表
	function getOrderBookingDetailRequest(){
	
	
	   var bookingCount = $('#bookingCount').val();
	   var arrayList = new Array();
	    if(parseInt(bookingCount) >= 2){
           	 var  departureAirportCodes = $('input[name=request_departureAirportCode]');
	       	 var arrivalAirportCodes =   $('input[name=request_arrivalAirportCode]');
	       	 var departureDates =   $('input[name=request_departureDate]');
	       	 var  flightNos = $('input[name=request_flightNo]');
	       	 var flightTripTypes =   $('input[name=request_flightTripType]');
	       	 var parPrices =   $('input[name=request_parPrice]');
	       	 var  policyIds = $('input[name=request_policyId]');
	       	 var pricePolicyIds =   $('input[name=request_pricePolicyId]');
	       	 var seatClassCodes =   $('input[name=request_seatClassCode]');
	       	 var  request_indexs = $('input[name=request_request_index]');
       	 	 $.each(request_indexs,function(i){
			    var request = new Object();
				request.departureAirportCode = $(departureAirportCodes[i]).val();
				request.arrivalAirportCode = $(arrivalAirportCodes[i]).val();
				request.departureDate = $(departureDates[i]).val();
				request.flightNo = $(flightNos[i]).val();
				request.flightTripType =$(flightTripTypes[i]).val();
				request.parPrice =$(parPrices[i]).val();
				request.policyId = $(policyIds[i]).val();
				request.pricePolicyId = $(pricePolicyIds[i]).val();
				request.seatClassCode = $(seatClassCodes[i]).val();
				arrayList[$(request_indexs[i]).val()] =request;
              });
	    }else{
	    	 var arrayList = new Array();
			<#list detailRequests as request >
				var request = new Object();
				request.departureAirportCode = '${request.departureAirportCode}'; 
				request.arrivalAirportCode = '${request.arrivalAirportCode}';
				request.departureDate = '${request.departureDate}';
				request.flightNo = '${request.flightNo}';
				request.flightTripType = '${request.flightTripType}';
				request.parPrice = '${request.parPrice}';
				request.policyId = '${request.policyId}';
				request.pricePolicyId = '${request.pricePolicyId}';
				request.seatClassCode = '${request.seatClassCode}';
				arrayList['${request_index}'] =request;
			</#list>
	    }
		return arrayList;
	}
	
	
	//订单备注信息
	function getOrderRemark(){
		var arrayList = new Array();
		var isExistRemark = typeof($('#customerRemark').val())!="undefined";
		var isExistBackRemark = typeof($('#backRemark').val())!="undefined";
		var total = 0;
		if(isExistRemark){
			var remark = new Object();
			remark.remarkType = "CUSTOMER";
			remark.remark = $('#customerRemark').val();
			arrayList[total] = remark;
			total++;
		}
		if(isExistBackRemark){
			var remark = new Object();
			remark.remarkType = "BACK";
			remark.remark = $('#backRemark').val();
			arrayList[total] = remark;
		}	
		return arrayList;
	}
	

	
	function getSalesOrderObject(){
		var obj = new Object;
		obj.salesOrderId = $('#vstOrderId').val();
		obj.salesMainOrderId = $('#vstOrderMainId').val();
		return obj;
	}
	
	
	//设置订单快递信息
	function getOrderExpress(){
		//取得单选框的数据
		if($("#curExpressType").val()!=""){
			   var expressObj = $('input[name="addressRadio"]:checked').parent();
			   	var obj = new Object;
				obj.expressType = $("#curExpressType").val();
				obj.recipient =expressObj.find('input[name="addressRecipient"]').val();
				obj.cellphone=expressObj.find('input[name="addressCellphone"]').val();
				obj.telephone=expressObj.find('input[name="addressTelephone"]').val();
				obj.address=expressObj.find('input[name="addressAddress"]').val();
				obj.postCode=expressObj.find('input[name="addressPostCode"]').val();
				var expressWay = new Object;
				expressWay.code = $("#curExpressCode").val();
				obj.expressWay = expressWay;
				return obj;
		 }
		return null;
	  }
	  
	
	   //测试到订单详情页面
		$("#testOrderDetailView").click(function() {
			$.ajax({
					url : "/queryFlightOrderDetail/283/411",
					dataType : "json",
					contentType : "application/json;",
					type : "POST",
					data:{orderMainId:"283",
							orderId:"411"},
					success : function(data) {
						window.location.href = "/showFlightOrderDetailView";
					}
			});
		});
		
	
	  //去核对
	 $("#booking").click(function() {
	         if($('#passengers tr:gt(0)').length==0){
	             alert("请先填写乘客信息！");
	             return false;
	         }
		     checkMobile();
		     $("#myform").validate({ 
				 onsubmit:true,// 是否在提交是验证 
				 onfocusout:false,// 是否在获取焦点时验证 
				 onkeyup :false,// 是否在敲击键盘时验证  
				 submitHandler: function(form) {
				        //验证成功，提交核对
				         if($("#curExpressType").val()=="EXPRESS"&&$('input[name="addressRadio"]:checked').length==0){
				            alert("快递信息尚未填写完成！");
				            return;
				         }
				         //判断身份证与出生日期
				         var passengerTdIds = $('#passengers [id^=passengerTdIds]');
				       	 var  passengerIDCardTypes = $('#passengers select[name^=passengerIDCardType]');
				       	 var passengerIDCardNos =  $('#passengers input[name^=passengerIDCardNo]');
				       	 var passengerBirthdays =  $('#passengers input[name^=passengerBirthday]');
				       	 var isCanPass = true;
				       	 $.each(passengerIDCardTypes,function(i){
							  if(passengerIDCardTypes[i].value=="ID"){
							       if(getBirthdatByIdNo($(passengerIDCardNos[i]).val(),$(passengerTdIds[i]).text())!=$(passengerBirthdays[i], true).val()){
							           alert("身份证号与出身日期不符合，请修改！");
							           //$(passengerBirthdays[i]).focus();
							            isCanPass = false;
							            return false;
							       }
							  }
                        });
				       	 
				       	 if(isCanPass){
				       	     	toBooking();
				       	 }
		         }, 
				 invalidHandler: function(form, validator) {  //不通过回调 
					 return false; 
				 } 
          }); 
		 
	});
	
	
	 function toBooking(){
	        
		   	if($("#booking").css('cursor') == 'no-drop'){
				   return;
				}
			    var insuranceInfo = "";
			    $('input[name="insurance"]:checked').each(function(){
				   insuranceInfo=insuranceInfo+$(this).val()+"_"+$("#insurance_"+$(this).val()).val()+",";
				});
			    $("#booking").css('cursor', 'no-drop');
			    var bookingSource;
			    if($('#vstOrderId').val() != null && $('#vstOrderId').val() != ''){
			    	bookingSource = 'VST_PACKAGE_BACK';
			    }else{
			    	bookingSource = 'LAMAMA_BACK';
			    }
			    
                $('#passengers select[name^=passengerType_]').each(function() {   $(this).attr('name', 'passengerType'); });
				$('#passengers input[name^=passengerName_]').each(function() { $(this).attr('name', 'passengerName'); });
				$('#passengers select[name^=gender_]').each(function() {   $(this).attr('name', 'gender'); });
				$('#passengers select[name^=passengerIDCardType_]').each(function() { $(this).attr('name', 'passengerIDCardType'); });
				$('#passengers input[name^=passengerIDCardNo_]').each(function() { $(this).attr('name', 'passengerIDCardNo'); });
				$('#passengers input[name^=passengerBirthday_]').each(function() { $(this).attr('name', 'passengerBirthday'); });
				$('#passengers input[name^=cellphone_]').each(function() { $(this).attr('name', 'cellphone');});	
			    
				var bookingCount = $('#bookingCount').val();
			    var isReBooking = 'false';
			    if(bookingCount == 1){
			    	isReBooking = 'true';
			    }
			    $('#bookingCount').val(parseInt($('#bookingCount').val())+1)
				$.ajax({
						url : "${request.contextPath}/bookingSubmit/",
						dataType:"json",
						contentType:"application/json;",
						data : JSON.stringify({
						routeType:'${routeType}',
						deptCityName:"${deptCity}",
		                arrvCityName:"${arrvCity}",
		                relationRequest:getSalesOrderObject(),
						bookingSource : bookingSource,
		                insuranceInfo:insuranceInfo,
						flightOrderExpress:getOrderExpress(),
						flightOrderRemarks:getOrderRemark(),
						flightOrderContacter:getContact(),
						isRebooking:isReBooking,
						flightOrderBookingDetailRequests:getOrderBookingDetailRequest(),
						flightOrderPassengers : getFlightOrderPassengers(),
						flightOrderCustomer : getUserMember(),
						orderTotalSalesAmount : $("#curOrderTotalSalesAmount").val()
					}),
					type : "POST",
					success : function(data) {
						var status = data.status;
						if(status == 'FAIL'){
							alert(data.message);
							$("#booking").css('cursor', 'pointer');
							$.ajax({
								url : "${request.contextPath}/ajaxBookingFlightInfo/",
								cache : false,
								async : false,
								data : {
									},
								type : "POST",
								datatype : "json",
								success: function(data){
									$('#bookingFlightInfo').html();
									$('#bookingFlightInfo').html(data);
									initAjax();
					   			}
						    });
						}
						if(status == 'SUCCESS'){
							var orderMainid = data.results[0].orderMainDto.id;
							window.location.href = "${request.contextPath}/showBooking/"+orderMainid;
						}
					},
					error:function(data)
					{
						$("#booking").css('cursor', 'pointer');
						alert(eval('(' + data.responseText + ')').message);
						initAjax();
					}
				});
	 }
	
    /*tab切换*/
    $(".order-tab").each(function(i,obj){
        $(obj).find("button").on("click",function(){
            $(obj).find(".withdraw").css("display","none");
            $(obj).find(".withdraw").eq($(this).index()).css("display","block");
            return false;
        });
    });
    
    /*配送信息地址*/
    $(".distribution").each(function(i,obj){
        $(obj).find(".msg ul li").each(function(i){
            if(i>=5){
                $(this).css("display","none");
            }
        });
        $(obj).find(".all").on("click",function(){
            $(obj).find(".msg ul li").each(function(i){
                if(i>=5){
                    $(this).css("display","block");
                }
            });
        });
    });
    
    $(".detail .tab-detail .a-detail").on("click",function(){
        if($(this).find("span").text()=="展开明细"){
            $(this).find("img").attr("src","images/order/ksanjiao2.png");
            $(this).find("span").html("收起明细");
            $(".detail .tab-detail .tr-title").show();
        }else if($(this).find("span").text()=="收起明细"){
            $(this).find("img").attr("src","images/order/down.png")
            $(this).find("span").html("展开明细");
            $(".detail .tab-detail .tr-title").hide();
        }
    });
    
    /*去核对*/
    $(".detail .tab-detail .btn-one").on("click",function(){
       
    });
	    
    /*上一步*/
    $(".detail .tab-detail .btn2").on("click",function(){

    });
   
	function addAddress(){
	
	  var addressRecipient = $('.address #addressRecipient').val();
	  var addressCellphone = $('.address #addressCellphone').val();
	  var addressTelephone = $('.address #addressTelephone').val();
	  var addressAddress = $('.address #addressAddress').val();
	  var addressPostCode = $('.address #addressPostCode').val();
	 if($.trim(addressRecipient)==''){
	      alert("收件人不能为空！");
	      $('.address #addressRecipient').focus(); 
	      return;
	  }
	   if($.trim(addressCellphone)==''&&$.trim(addressTelephone)==''){
	      alert("手机号码号码和固定电话必填一个！");
	      $('.address #addressCellphone').focus(); 
	      return;
	  }
	  
	  if(!(addressCellphone.length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(addressCellphone))){
	      alert("请输入正确的手机号码！");
	      $('.address #addressCellphone').focus(); 
	      return;
	  }
	  
	  if($.trim(addressAddress)==''){
	      alert("地址不能为空！");
	     $('.address #addressAddress').focus(); 
	      return;
	  }
	  if($.trim(addressPostCode)==''){
	      alert("邮政编码不能为空！");
	     $('.address #addressPostCode').focus(); 
	      return;
	  }
	  
	  var zip = /^[0-9]{6}$/;    
	  if(!zip.test(addressPostCode)){
	      alert("请输入正确的邮编号！");
	      $('.address #addressPostCode').focus(); 
	      return;
	   }
	 
	  var curAddressInfo = '<input type="hidden" name="addressRecipient" value="'+addressRecipient+'">'
					+'<input type="hidden" name="addressCellphone" value="'+addressCellphone+'">'
					+'<input type="hidden" name="addressTelephone" value="'+addressTelephone+'">'
					+'<input type="hidden" name="addressAddress" value="'+addressAddress+'">'
					+'<input type="hidden" name="addressPostCode" value="'+addressPostCode+'">';
	  var addressftl = '<li>'+curAddressInfo+'<input type="radio" name="addressRadio" checked=checked >'+addressAddress+'（'+addressRecipient+'）'+addressTelephone+' '+addressCellphone+'</li>';
	  $("#address_ul").append(addressftl);
	  $('.address #addressRecipient').val("");
	  $('.address #addressCellphone').val("");
	  $('.address #addressTelephone').val("");
	  $('.address #addressAddress').val("");
	  $('.address #addressPostCode').val("");
	}
    
    	
    	$(".insuranceTypeChange").change(function(){
    		var data = $(this).attr('data');
    		if($("#input_"+data).attr("checked")){
    			initAjax();
    		}
    	})
    
        
       function initAjax(){
    		var bookingSource;
		    if($('#vstOrderId').val() != null && $('#vstOrderId').val() != ''){
		    	bookingSource = 'VST_PACKAGE_BACK';
		    }else{
		    	bookingSource = 'LAMAMA_BACK';
		    }
        	$.ajax({
    			url : "${request.contextPath}/calculate/amountCalculate",
    			dataType:"json",
    			contentType:"application/json;",
    			data : JSON.stringify({
    				passengerDetailDtos:getPassengerDetailDtos(),
    				expressRequest:getExpressRequest(),
    				bookingSource : bookingSource
    			}),
    			type : "POST",
    			success : function(data) {
    				showPriceInfo(data);
    			}
    		});
        }
    	
    	function showPriceInfo(data){
    		var amountDetail = data.bookingPassengerTypeAndAmounts;
			$('#last-child span').text(data.amountCalculatorDto.orderPrepaidAmount);
			$('#receiveAmount').text(data.amountCalculatorDto.orderPrepaidAmount);
			$("#curOrderTotalSalesAmount").val(data.amountCalculatorDto.orderTotalSalesAmount);
			var str = "";
			var str2 = "";
			var str3 = 0;
			for(var i = 0;i<amountDetail.length;i++){
				var passengerType;
				if(amountDetail[i].passengerType == 'ADULT'){
					passengerType = '成人';
				}
				if(amountDetail[i].passengerType == 'CHILDREN'){
					passengerType = '儿童';
				}
				str = str + "<li><span>"+passengerType+"</span><span class='last-child'>&yen;"+(amountDetail[i].singleParpriceAmout+amountDetail[i].singleAirportFeeAmount+amountDetail[i].singleFuelsurTaxAmount)+"&times;"+amountDetail[i].passengerCount+"人</span></li>" +
				"<li><span>"+passengerType+"票：</span><span class='last-child'>&yen;"+amountDetail[i].singleParpriceAmout+"</span></li>" +
				"<li><span>机建费：</span><span class='last-child'>&yen;"+amountDetail[i].singleAirportFeeAmount+"</span></li>" +
				"<li><span>燃油税: </span><span class='last-child'>&yen;"+amountDetail[i].singleFuelsurTaxAmount+"</span></li>";
				str3 = str3 + amountDetail[i].passengerCount;
			}
			$('.more').text("明细（"+str3+"名乘客）");
			$('.ul-1').html(str);
			
			$('.detail .tab-detail tr:eq(1)').each(function(){
				$(this).find('td').eq(0).text(data.amountCalculatorDto.orderTicketAmount);	
				$(this).find('td').eq(1).text(data.amountCalculatorDto.orderDiscountTotalAmount);
				$(this).find('td').eq(2).text(data.amountCalculatorDto.orderAirportTaxAmount);
				$(this).find('td').eq(3).text(data.amountCalculatorDto.orderFuelTaxAmount);
				$(this).find('td').eq(4).text(data.amountCalculatorDto.orderInsuranceAmount);
				$(this).find('td').eq(5).text(data.amountCalculatorDto.orderPlusAmount);
				$(this).find('td').eq(6).text(data.amountCalculatorDto.orderExpressAmount);
			});
			
			for(var i=0;i<amountDetail.length;i++){
				var auditType = "";
				if(amountDetail[i].passengerType == 'ADULT'){
					auditType = "成人&times;";
				}
				if(amountDetail[i].passengerType == 'CHILDREN'){
					auditType = "儿童&times;";
				}
				str2 = str2 + "<tr><td class='td-1'>"+auditType+amountDetail[i].passengerCount+"</td><td>"+amountDetail[i].totalParpriceAmount+"</td><td>"+amountDetail[i].totalOrderDiscountAmount+"</td><td>"+amountDetail[i].totalAirportFeeAmount+"</td>"+
				"<td>"+amountDetail[i].totalFuelsurTaxAmount+"</td><td>"+amountDetail[i].totalInsuranceAmount+"</td><td>&nbsp;</td><td>&nbsp;</td></tr>";
			}
			
			var str3 = "<tr class='tr-2'><td>&nbsp;</td><td>"+data.amountCalculatorDto.orderTicketAmount+"</td><td>"+data.amountCalculatorDto.orderDiscountTotalAmount+"</td>"+
				"<td>"+data.amountCalculatorDto.orderAirportTaxAmount+"</td>"+
				"<td>"+data.amountCalculatorDto.orderFuelTaxAmount+"</td><td>"+data.amountCalculatorDto.orderInsuranceAmount+"</td><td>"+data.amountCalculatorDto.orderPlusAmount+"</td><td>"+data.amountCalculatorDto.orderExpressAmount+"</td></tr>"
			
			$(".tr-title td .tab-detail").html(str2+str3);
    	}
    	
    	
        function modifyOWFlight(){
        	var departForm = $('#qicheng_form');
        	departForm.html($('#modifyOWFlightDiv').html());
        	departForm.submit();
        }
        
        function modifyRTFlight(){
        	var returnForm = $('#huicheng_form');
        	returnForm.html($('#modifyRTFlightDiv').html());
        	returnForm.submit();
        }
        
    	function getPassengerDetailDtos(){
    		var passengerDetailDtos = new Array();
    		var insuranceCalculatRequests = new Array();
    		var j = 0;
    		var m = 0;
    		
    		$("input[name='insurance']").each(function(){
        		if($(this).attr("checked")){
        			var obj = new Object();
        			obj.insuranceCount = $('#insurance_'+$(this).val()).val();
        			obj.insuranceId = $(this).val();
        			insuranceCalculatRequests[m++] = obj;
        		}
        	})
    		
    		var passengers = $('#passengers tr:gt(0)').length;
    		for(var i = 1;i<=passengers;i++){
    			var passengerType = $('#passengers tr:eq('+i+') td:eq(1)').find('select').val();
    			if('${segList?size}' == 1){
        			var obj = new Object();
        			obj.flightTripType = 'DEPARTURE';
        			obj.passengerType = passengerType;
        			obj.flightSimpleInfo = getFlightSimpleInfoDto('DEPARTURE',passengerType);
        			obj.insuranceCalculatRequests = insuranceCalculatRequests;
        			passengerDetailDtos[j++]=obj;
        		}
    			
    			if('${segList?size}' == 2){
        			var obj1 = new Object();
        			obj1.flightTripType = 'DEPARTURE';
        			obj1.passengerType = passengerType;
        			obj1.flightSimpleInfo = getFlightSimpleInfoDto('DEPARTURE',passengerType);
        			obj1.insuranceCalculatRequests = insuranceCalculatRequests;
        			passengerDetailDtos[j++]=obj1;
        			
        			var obj2 = new Object();
        			obj2.flightTripType = 'RETURN';
        			obj2.passengerType = passengerType;
        			obj2.flightSimpleInfo = getFlightSimpleInfoDto('RETURN',passengerType);
        			obj2.insuranceCalculatRequests = insuranceCalculatRequests;
        			passengerDetailDtos[j++]=obj2;
        		}
    		}
    		return passengerDetailDtos;
    	}
    	
    	function setCurExpressCode(expressType){
        	
        
     	   if(expressType=='EXPRESS'){
     	      $("#addressDiv").css("display","block");
     	      $("#curExpressCode").val('${defaultExpressWayCode}');
     	      $("#curExpressType").val(expressType);
     	   }else{
     	      $("#curExpressCode").val("");
     	      $("#curExpressType").val("");
     	      $("#addressDiv").css("display","none");
     	      $("#address_ul").html("");
     	   }
     	   initAjax();
     	}
     	
     	function getExpressRequest(){
             var expressRequest = new Object();
             expressRequest.expressCode = $("#curExpressCode").val();
             return expressRequest;
         }
    	
    	function getFlightSimpleInfoDto(flightType,passengerType){
    		var obj = new Object();
    		<#list segList as flightInfos>
    			if('${flightInfos.flightTripType}' == flightType){
    				<#list flightInfos.flightSearchFlightInfoDto.seats as seat>
	    				obj.carrierCode = '${flightInfos.flightSearchFlightInfoDto.carrierCode}';
	    				obj.departureAirportCode = '${flightInfos.flightSearchFlightInfoDto.departureAirportCode}';
	    				obj.arrivalAirportCode = '${flightInfos.flightSearchFlightInfoDto.arrivalAirportCode}';
	    				obj.seatClassCode = '${seat.seatClassCode}';
	    				obj.policyId = '${seat.policyId}';
	    				obj.pricePolicyId = '${seat.pricePolicyId}';
	    				var departDate = '${flightInfos.flightSearchFlightInfoDto.departureDate}';
	    				var arr1 = departDate.split("-");  
	    				obj.departureDate = new Date(arr1[0],parseInt(arr1[1])-1,arr1[2]);
	    				obj.bookingSource = 'LAMAMA_BACK';
	    				obj.carrierCode = '${flightInfos.flightSearchFlightInfoDto.carrierCode}';
	    				obj.flightNo = '${flightInfos.flightSearchFlightInfoDto.flightNo}';
	    				obj.yParPrice = '${flightInfos.flightSearchFlightInfoDto.yParPrice}';
	    				obj.passengerType = passengerType;
	    				<#assign fuelsurTaxs = flightInfos.flightSearchFlightInfoDto.fuelsurTaxs>
	    				<#list fuelsurTaxs?keys as itemKey>
	    					if('${itemKey}' == 'ADULT'){
	    						obj.fuelsurTax = '${fuelsurTaxs[itemKey]}';
	    					}
	    				</#list>
	    				
	    				<#assign airportFees = flightInfos.flightSearchFlightInfoDto.airportFees>
	    				<#list airportFees?keys as itemKey>
	    					if('${itemKey}' == 'ADULT'){
	    						obj.airportFee = '${airportFees[itemKey]}';
	    					}
	    				</#list>
					</#list>
    			}
        	</#list>
			return obj;    		
    	}
    	
    	//控制如果选择了保险，手机号必填
    	function onInsuranceSel(){
    	    var isSel = false;
    	   	$('.passenger input[name=insurance]').each(function() {
	   	        if($(this).attr("checked")=="checked"){
	   	            isSel = true;
	   	            return false;
	   	        }
    	   	 });
    	   	 if(isSel){
    	   	    $('#passengers input[name^=cellphone_]').each(function() { $(this).attr('class', 'required isMobile'); });
    	   	 }else{
    	   	     $('#passengers input[name^=cellphone_]').each(function() { $(this).attr('class', 'isMobile'); });
    	   	 }
    	     initAjax();
    	}
    
</script>
</html>