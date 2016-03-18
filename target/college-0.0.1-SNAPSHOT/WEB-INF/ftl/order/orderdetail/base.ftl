<script type="text/javascript">
$(function() {
   //确认备注
   $("#addOrderRemark").click(function() {
     if ($("#addOrderRemark").css('cursor') == 'no-drop')
		return;
     var remark = $("#orderRemark").val();
     var orderMainId = '${base.orderMainId}';
     var orderId = '${base.orderId}';
     var orderNo = '${base.orderNo}';
	 var remarkType = "BACK";
	 // 锁住
	 $("#addOrderRemark").css('cursor', 'no-drop');
     $.ajax({
			url : '${request.contextPath}/order/addOrderRemark',
			cache : false,
			async : false,
			data : {
				"remark":remark,
				"orderMainId":orderMainId,
				"orderId":orderId,
				"flightOrderNo.orderNo":orderNo,
				"remarkType":remarkType
				},
			type : "POST",
			datatype : "json",
			success: function(data){
			   alert("备注修改成功!");
			   $("#addOrderRemark").css('cursor', 'pointer');
			   queryOrderRemarkLast();
   			}
	    });
   	 });
   	 
     //清空备注
   	 $("#cleanRemark").click(function() {
     $("#orderRemark").val("");
  	 });
  	 
  	 //查询最新备注信息
  	 queryOrderRemarkLast();
  })
  
//去调左右空格onBlur
function trim(obj){
  var str = obj.value,
  str = str.replace(/^\s\s*/, ''),
  ws = /\s/,
  i = str.length;
  while (ws.test(str.charAt(--i)));
  obj.value=str.slice(0, i + 1);

}
// 只允许输入数值onkeyup
function formatNumber(obj){
    obj.value=obj.value.replace(/[^\d\.]/g,'');
}

//查询最新备注信息
function queryOrderRemarkLast()
{
	var orderMainId = '${base.orderMainId}';
	var orderId = '${base.orderId}';
	$.ajax({
	 	type:'POST',
		url:'${request.contextPath}/order/queryOrderRemarkLast/'+orderMainId+'/'+orderId+'/5',
		dataType:'html',
		success:function(data)
		{
			$("#order_remark_last_div").html(data);
	 	}
   	});
}

//加载可退金额
$(function() {
	var orderNoObj = new Object();
	var orderNoVal = $("#orderNo").val();
	orderNoObj.orderNo = orderNoVal;
	var orderMainId = '${base.orderMainId}';
	
	$.ajax({
		url : '${request.contextPath}/order/getAmountInfo',
		type : 'post',
		dataType : "json",
		contentType : "application/json;",
		data : JSON.stringify({
			flightOrderNo : orderNoObj,
			orderMainId : orderMainId,
		}),
		success : function(data) {
			if (data.status != "" && data.status == "SUCCESS") {
				$.each(data.results, function(i, value) {
					$("#totalPayed").text(value.flightOrderPayAmountInfo.totalPayed);
					$("#blockAmount").text(value.flightOrderPayAmountInfo.blockAmount);
					$("#actualRefunded").text(value.flightOrderPayAmountInfo.actualRefunded);
					$("#returnAmount").text(value.flightOrderPayAmountInfo.returnAmount);
				})

			} 
		},
	});

 })
  
  

	

 </script>
<div class="module1">

	<div class="main">
		<div class="area left">
			<div class="part">
				<span>订单号：</span>
				<p>${base.orderNo}</p>
				<span>主订单号：</span>
				<p>${base.orderMainNo}</p>
				<#if base.orderType == 'NORMAL'>
					<span>供应商订单号：</span>
					<p>
						<#if base.suppOrderNos??>
							<#list base.suppOrderNos as suppOrderNo>
							<input type="hidden" id="applySuppIssue" name = "applySuppIssue" value="${suppOrderNo}"/>
								${suppOrderNo}&nbsp;&nbsp;
							</#list>
						<#else>
							&nbsp;
						</#if>
					</p>	
				<#elseif base.orderType == 'RTVT'>	
					<span>供应商退票单号：</span>
					<p>
						<#if base.suppRefundNos??>
							<#list base.suppRefundNos as suppRefundNo>
								<input type="hidden" id="suppRefundNo" value="${suppRefundNo}"/>
								${suppRefundNo}&nbsp;&nbsp;
							</#list>
						<#else>
							&nbsp;
						</#if>
					</p>	
				</#if>
				<span>订单来源：</span>
				<p id="bookingSource">${(base.bookingSource.cnName)!'&nbsp;'}</p>
				<span>付款方式：</span>
				<p id="payType">
					<#if base.orderType == 'RTVT' && base.flightOrderRefunds??>
						<#list base.flightOrderRefunds as flightOrderRefund>
							${(flightOrderRefund.refundmentType.cnName)!'&nbsp;'}
						</#list>
					<#elseif (base.orderType == 'NORMAL' || base.orderType == 'CTMT') && base.flightOrderRefunds??>
						<#list base.flightOrderPayments as flightOrderPayment>
							${(flightOrderPayment.paymentType.cnName)!'&nbsp;'}
						</#list>		
					</#if>&nbsp;
				</p>
				<span>所属公司：</span>
				<p>&nbsp;</p>
				<span>所属产品经理：</span>
				<p>&nbsp;</p>
				<span>产品经理手机号：</span>
				<p>&nbsp;</p>
				<span>登录用户：</span>
				<p>${(base.flightOrderCustomer.customerName)!'&nbsp;'}</p>
				<span>联系人：</span>
				<p>${(base.flightOrderContacter.name)!'&nbsp;'}</p>
				<span>联系人电话：</span>
				<p>${(base.flightOrderContacter.cellphone)!'&nbsp;'}
				
				<#if base.flightOrderDetailBase.flightOrderStatus.orderCancelStatus != 'CANCEL_SUCC' >
				<a href="javascript:void(0);" onclick="openSmsDialog()" >[发送短信]</a>
				
				</#if>
				</p>
				<span>电子邮件：</span>
				<p>${(base.flightOrderContacter.email)!'&nbsp;'}</p>
			</div>
			<div class="part">
				<span>产品类型：</span>
				<p>${(base.product.cnName)!'&nbsp;'}</p>
				<span>产品名称：</span>
				<p>${(base.product.productType.cnName)!'&nbsp;'}</p>
				<span>用户退款总金额：</span>
				<p>&nbsp;<a href="">[查看明细]</a></p>
				<span>分销渠道减少总金额：</span>
				<p>&nbsp;</p>
			</div>
		</div>
		<div class="area middle">
			<div class="title">
				<p>主订单备注记录：</p>
				<span>附件（0）</span>
			</div>
			<textarea rows="4" placeholder="主订单内部流转备注" id="orderRemark"></textarea>
			<span class="word">0/500字</span>
			<div class="click">
				<a href="javascript:void(0);">
					<div class="button" id = "addOrderRemark">修改备注</div>
				</a> 
				<a href="javascript:;">
					<div class="button" id = "cleanRemark">清空备注</div>
				</a>
			</div>
			<#include "order/orderdetail/op.ftl">
			<div id="order_remark_last_div"></div> 
		</div>
		
		<div class="area right">
			<#include "order/orderdetail/status.ftl">

			<div class="centre order">
			
				<!--正常单 -->
				<#if base.orderType == "NORMAL">
					<h3>支付状态</h3>
					<span>付款情况：</span>
					<p>
						<#if base.flightOrderStatus??>
							${base.flightOrderStatus.orderPayStatus.cnName}
						</#if>
						<#if applyPay??>	
							<a href="javascript:void(0);" onclick="applyToPay('${request.contextPath}/order/orderPayInfoAjax')">支付</a>
						<#else>
						    <a href="javascript:void(0);" onclick="showPayResult('${request.contextPath}/order/searchOrderPayInfoAjax','${request.contextPath}/order/searchOrderRefundInfoAjax')">查看支付信息</a>
						</#if>
						<#if applyRefund??>	
							<a href="javascript:void(0);" onclick="toRefund('${request.contextPath}/order/showRefundInfoByAjax')">退款</a>
						</#if>
						<a href="javascript:void(0);" onclick="showRefundInfo('${request.contextPath}/order/searchOrderRefundInfoAjax')">查看退款信息</a>
					</p>
					<span>应付款：</span>
					<p>RMB ${base.flightOrderAmountDto.orderPrepaidAmount}元</p>
					<span>已收款：</span>
					<p>RMB ${base.flightOrderAmountDto.orderPayedAmount}元</p>
					<span>剩余款：</span>
					<p>RMB ${base.flightOrderAmountDto.orderPrepaidAmount - base.flightOrderAmountDto.orderPayedAmount}元</p>
							<span>支付等待时间：</span>
							<p><#if base.limitTime??>${base.limitTime?string("yyyy-MM-dd HH:mm:ss")}</#if></p>
				</#if>
				
				<!--改签 -->
				<#if base.orderType == "CTMT">
					<h3>支付状态</h3>
					<span>付款情况：</span>
					<p>
						<#if base.flightOrderStatus??>
							${base.flightOrderStatus.orderPayStatus.cnName}
						</#if>
						
						<#if applyPay??>	
							<a href="javascript:void(0);" onclick="applyToPay('${request.contextPath}/order/orderPayInfoAjax')">支付</a>
						<#else>
						    <a href="javascript:void(0);" onclick="showPayResult('${request.contextPath}/order/searchOrderPayInfoAjax','${request.contextPath}/order/searchOrderRefundInfoAjax')">查看</a>
						</#if>
					</p>
					<span>应付款：</span>
					<p>RMB ${base.flightOrderAmountDto.orderCTMTAmount.ctmtPrepaidAmount}元</p>
					<span>已收款：</span>
					<p>RMB ${base.flightOrderAmountDto.orderCTMTAmount.ctmtPayedAmount}元</p>
					<span>剩余款：</span>
					<p>RMB ${base.flightOrderAmountDto.orderCTMTAmount.ctmtPrepaidAmount - base.flightOrderAmountDto.orderCTMTAmount.ctmtPayedAmount}
						元</p>
					<#if applyPay??>	
							<span>支付等待时间：</span>
							<p><#if base.limitTime??>${base.limitTime?string("yyyy-MM-dd HH:mm:ss")}</#if></p>
						</#if>
				</#if>
				
				
				
					<!--退 -->
				<#if base.orderType == "RTVT">
					<h3>退款状态</h3>
					<span>退款情况：</span>
					<p>
						<#if base.flightOrderStatus??>
							${base.flightOrderStatus.orderPayStatus.cnName}
						</#if>
						<a href="javascript:void(0);" onclick="showRefundInfo('${request.contextPath}/order/searchOrderRefundInfoAjax')">查看</a>
						<#if applyRefund??>	
							<a href="javascript:void(0);" onclick="toRefund('${request.contextPath}/order/showRefundInfoByAjax')">退款</a>
						</#if>
					</p>
					<span>应退款：</span>
					<p>RMB ${base.flightOrderAmountDto.orderRTVTAmount.rtvtAmount}元</p>
					<span>已退款：</span>
					<p>RMB ${base.flightOrderAmountDto.orderRTVTAmount.orderRefundedAmount}元</p>
					<span>剩余款：</span>
					<p>RMB  ${base.flightOrderAmountDto.orderRTVTAmount.rtvtAmount -base.flightOrderAmountDto.orderRTVTAmount.orderRefundedAmount}
					  元</p>
				</#if>
			</div>

			<!--可退信息-->
			<div class="order" id="returnAmountInfo" style="padding:20px; line-height: 30px">
				    <p><span>支付总金额：</span>
					RMB <span id="totalPayed"></span> 元
					</p>
				  <p>
				  <span>冻结：</span>RMB <span id="blockAmount"></span> 元
				  </p>
				  <p>
				  <span>实退：</span>RMB <span id="actualRefunded"></span> 元
				  </p>
				  <p>
				  <span>可退：</span>RMB <span id="returnAmount"></span> 元
				  </p>
			</div>

			<#if applyCancel??>
			<div class="bottom order">
				<h3>
					订单取消<span>（正常订单）</span>
				</h3>
				<div class="choose moveright">
					<input type="radio" name="cancel" id="reason1" value="资源不确定" onclick="selectClear()"/> <label for="reason1">资源不确定</label>
				</div>
				<div class="choose">
					<input type="radio" name="cancel" id="reason2" value="信息不通过" onclick="selectClear()" /> <label for="reason2">信息不通过</label>
				</div>
				<div class="choose moveright">
					<input type="radio" name="cancel" id="reason3" value="客户通知取消" onclick="selectClear()" /> <label for="reason3">客户通知取消</label>
				</div>
				<div class="choose">
					<input type="radio" name="cancel" id="reason4" value="废单重下" onclick="selectClear()" /> <label for="reason4">废单重下</label>
				</div>
				<div class="choose moveright">
					<input type="radio" name="cancel" id="reason5" value="其他" onclick="selectClear()" /> <label for="reason5">其他</label>
				</div>
				
				<div class="cl"></div>
				<div class="reason">
					<span>取消备注：</span>
					<textarea name="cancelRemark" rows="4" cols="25" placeholder="订单取消备注" id="cancelRemark" wrap="physical"></textarea>
				</div>
			      <div class="click" style="float:right;" >
				   <a href="javascript:void(0);" style="padding-left:30px;"><div style="width:80px;height: 25px;background-color: #999;text-align: center;color: #fff;line-height: 25px;float: left;margin-right: 10px;" id = "cancel_Order" onclick="cancelOrder('${request.contextPath}/order/cancelOrderAjax');" >取消订单</div></a>
			     </div>
			</div>
			</#if>
		</div>
		<div class="cl"></div>
		<div class="area remark">
			<span>用户备注/特殊要求：</span>
			<p class="special">${(base.customerRemark)!'&nbsp;'}</p>
			<span>确认方式：</span>
			<p>
				<#if base.flightOrderDetailBase??&&base.flightOrderDetailBase.flightOrderContacter??>
					<#if base.flightOrderDetailBase.flightOrderContacter.confirmType??>
						${base.flightOrderDetailBase.flightOrderContacter.confirmType.cnName}
					</#if>
				</#if>&nbsp;
			</p>
			<span>相关订单：</span>
			<p>
				<a href="javascript:void(0);" onclick="changeOrderTab('relationTable', this)">[关联订单]</a>
				<a href="javascript:void(0);" onclick="changeOrderTab('sameTable', this)">[同主单订单]</a>
			</p>
		</div>
	</div>
</div>


		<!--显示支付失败信息-->
		<div class="office" id="showPayFailInfo" style="align:center;top:300px;dispaly:none;border:1px solid #e6e6e6;">
			<div class="o_title">
				支付失败信息<span class="o_close" id="closeRePay" >X</span>	
			</div>
			
			<div class="o_content"" id="payFailInfo" style="top:10px;font-size:25px;text-align:center;"">
	            <span style="color:red;padding-left:20px;"></span>
	        </div>
	        
	        <div class="o_submit">
				<a href="javascript:void(0);"><span class="cancle" onclick="closePayFailInfo()">关闭</span></a>
			</div>
			
		</div>
		
		

		

		<!--显示支付信息-->
		<div class="office" id="showPayOperate" style="align:center;top:300px;dispaly:none;border:1px solid #e6e6e6;">
			<div class="o_title">
				订单支付<span class="o_close op" id="closeOpPay">X</span>	
			</div>
			<div class="o_content" id="payMentValue" style="top:10px;font-size:18px;">
	                              订单金额: RMB <span style="color:red;">
	                             <#if base.orderType == "NORMAL">
	                              ${base.flightOrderAmountDto.orderPrepaidAmount}
	                         	  </#if>
	                             <#if base.orderType == "CTMT">
	                             ${base.flightOrderAmountDto.orderCTMTAmount.ctmtPrepaidAmount}
	                         	  </#if>
	                              
	                              
	                              </span>元
	        </div>					
			<div class="bottoms" style="padding:10px; width: 100%; overflow: hidden;">
				<div class="choose moveright" style="padding-left: 5%;float: left;line-height:30px;">
					<input type="radio" name="payType" id="reason2" value="YEE" onclick="selectPayType()" /> <label for="reason2">易宝电话支付</label>
					<input type="radio" name="payType" id="reason1" value="HUNDRED" onclick="selectPayType()"/><label for="reason1">百付电话支付</label>
					<input type="radio" name="payType" id="reason2" value="OFFLINE_CARD" onclick="selectPayType()" /> <label for="reason2">线下拉卡支付</label>
				 </div>
				<div class="choose" style="padding-left: 5%;float: left;line-height:30px;">
				    <input type="radio" name="payType" id="reason3" value="POS" onclick="selectPayType()" /> <label for="reason3">POS机支付</label>
                    <input type="radio" name="payType" id="reason4" value="KENDRION" onclick="selectPayType()" /> <label for="reason4">彬德POS机支付</label>
				    <input type="radio" name="payType" id="reason5" value="CASH" onclick="selectPayType()" /> <label for="reason5">现金支付</label>
					
				</div>
				<div class="choose" style="padding-left: 5%;float: left;line-height:30px;">
				    <input type="radio" name="payType" id="reason6" value="DUMMY" onclick="selectPayType()" /> <label for="reason6">虚拟支付</label>
                    <input type="radio" name="payType" id="reason7" value="OTHER" onclick="selectPayType()" /> <label for="reason7">其他支付</label>
				</div>
			</div>
			<div class="o_content" id="payOpNumber" style="text-align:left;" >
				*交易流水号：<input type="text" name="paymentSerialNumber" id="paymentSerialNumber" style="height: 25px;" />
			</div>
			<div class="o_remark">
				<span>备注：</span><textarea name="payRemark" rows="4" cols="20" id="payRemark" placeholder="订单支付备注" ></textarea>
			</div>
			<div class="o_submit">
				<a href="javascript:void(0);"><span class="sure" onclick="payCallBack('${request.contextPath}/order/orderPayCallbackAjax')">支付</span></a>
				<a href="javascript:void(0);"><span class="cancle" onclick="canclePayOperate()">取消</span></a>
			</div>
		</div>
	
	<!--显示支付结果信息-->
	  <div class="pay" id="showPayResult" style="align:center;top:300px; border:1px solid #e6e6e6;dispaly:none;left:30%">
			<div class="o_title">
				订单支付结果1<a href="javascript:void(0);"><span class="o_close" id="closeRePay" onclick="canclePayResult()">X</span>	</a>
			</div>
			
			<table id="showPayResultTable" style ="border=2; display: block;">  
	            <thead>  
	                <tr>  
	                    <th style='width:10%;'>支付订单号</th>  
	                    <th style='width:10%;'>交易流水号</th>
	                    <th style='width:10%;'>支付方式</th>
	                    <th style='width:10%;'>交易金额</th>
	                    <th style='width:10%;'>支付状态</th>
	                    <th style='width:10%;'>订单支付状态</th>
	   		            <th style='width:10%;'>交易时间</th>
	                    <th style='width:10%;'>对账流水号</th>
	                    <th style='width:10%;'>订单号</th>
	                    <th style='width:10%;'>引用订单号</th>
	                </tr>  
	            </thead>  
	            <tbody>  
	                <tr id="showPayResultCloneTr">  
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>
	               	   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>
	                 </tr>  
	             </tbody>  
		 	</table> 
		 	
		 	<table id="payRefundTable" style ="border=2; display: none;">  
	            <thead>  
	                <tr>  
	                 	<th style='width:10%;'>退款订单号</th>  
	                    <th style='width:15%;'>退款流水号</th>
	                    <th style='width:10%;'>退款方式</th>
	                    <th style='width:10%;'>退款金额</th>
	                    <th style='width:10%;'>退款状态</th>
	                    <th style='width:10%;'>订单退款状态</th>
	   		            <th style='width:15%;'>退款时间</th>
	                    <th style='width:10%;'>对账流水号</th>
	                    <th style='width:10%;'>订单号</th>
	                </tr>  
	            </thead>  
	            <tbody>  
	                <tr id="payRefundCloneTr">  
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>
  
	                 </tr>  
	             </tbody>  
		 	</table>
		 	
		 	 
	        			
			<div class="o_submit">
				<a href="javascript:void(0);"><span class="cancle" onclick="canclePayResult()">关闭</span></a>
			</div>
		</div>


		
		<!--显示退款信息-->
 	<div class="pay" id="showRefundOperate" style="align:center;top:300px;dispaly:none;border:1px solid #e6e6e6;">
			<div class="o_title">
				订单退款<span class="o_close op" id="closeOpRefund">X</span>	
			</div>
			
			
			<table id="showRefundOperateTable" style ="border=2; display: block;">  
	            <thead>  
	                <tr>  
	                 	<th style='width:10%;'>退款订单号</th>  
	                    <th style='width:15%;'>退款流水号</th>
	                    <th style='width:10%;'>退款方式</th>
	                    <th style='width:10%;'>退款金额</th>
	                    <th style='width:10%;'>退款状态</th>
	                    <th style='width:10%;'>订单退款状态</th>
	   		            <th style='width:15%;'>退款时间</th>
	                    <th style='width:10%;'>对账流水号</th>
	                    <th style='width:10%;'>订单号</th>
	                </tr>  
	            </thead>  
	            <tbody>  
	                <tr id="showRefundOperateCloneTr">  
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>
  
	                 </tr>  
	             </tbody>  
		 	</table>  
			
			<div class="o_remark">
				<span>备注：</span><textarea name="refundRemark" rows="4" cols="20" id="refundRemark" placeholder="订单退款备注" ></textarea>
			</div>
			<div class="o_submit">
				<a href="javascript:void(0);"><span class="sure" onclick="refund('${request.contextPath}/order/refund')">退款</span></a>
				<a href="javascript:void(0);"><span class="cancle" onclick="cancleRefundOperate()">取消</span></a>
			</div>
		</div>
		
		
		
	  <!--查看<退款>-->
	  <div class="pay" id="showRefundResult" style="align:center;top:300px; border:1px solid #e6e6e6;dispaly:none;">
			<div class="o_title">
				订单退款结果<span class="o_close" id="closeReRefund">X</span>	
			</div>
			
			<table id="showRefundResultTable" style ="border=2; display: block;">  
	            <thead>  
	                <tr>  
	                 	<th style='width:10%;'>退款订单号</th>  
	                    <th style='width:15%;'>退款流水号</th>
	                    <th style='width:10%;'>退款方式</th>
	                    <th style='width:10%;'>退款金额</th>
	                    <th style='width:10%;'>退款状态</th>
	                    <th style='width:10%;'>订单退款状态</th>
	   		            <th style='width:15%;'>退款时间</th>
	                    <th style='width:10%;'>对账流水号</th>
	                    <th style='width:10%;'>订单号</th>
	                </tr>  
	            </thead>  
	            <tbody>  
	                <tr id="showRefundResultCloneTr">  
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>
  
	                 </tr>  
	             </tbody>  
		 	</table> 
		 	
			<div class="o_submit">
				<a href="javascript:void(0);"><span class="cancle" onclick="cancleRefundResult()">关闭</span></a>
			</div>
		</div>


		<!--显示退款失败信息-->
		<div class="office" id="showToRefundFail" style="align:center;top:300px;dispaly:none;border:1px solid #e6e6e6;">
			<div class="o_title">
				退款失败信息<span class="o_close" id="closeRePay" >X</span>	
			</div>
			
			<div class="o_content"" id="toRefundFail" style="top:10px;font-size:25px;text-align:center;"">
	            <span style="color:red;padding-left:20px;"></span>
	        </div>
	        
	        <div class="o_submit">
				<a href="javascript:void(0);"><span class="cancle" onclick="closeShowToRefundFail()">关闭</span></a>
			</div>
			
		</div>


		
		
		
		<!--隐藏控件-->		
		<input type="hidden" name="paymentNoOperate" id="paymentNoOperate" /> 
	    <input type="hidden" name="payAmountOperate" id="payAmountOperate" />
	    <input type="hidden" name="payNoShow" id="payNoShow" /> 
	    <input type="hidden" name="payAmountShow" id="payAmountShow" />
	    <input type="hidden" name="payNumberShow" id="payNumberShow" />
	    <input type="hidden" name="payResultShow" id="payResultShow" />
	    <input type="hidden" name="refundNoShow" id="refundNoShow" /> 
	    <input type="hidden" name="refundAmountShow" id="refundAmountShow" />
	    <input type="hidden" name="refundNumberShow" id="refundNumberShow" />
	    <input type="hidden" name="refundResultShow" id="refundResultShow" />
	    <input type="hidden" name="payOperUrl" id="payOperUrl" />
		<input type="hidden" name="refundIds" id="refundIds" />
	    
		    <!--  短信弹框 -->
	<div class="office" id="smsDialog" style="align: center; top: 300px; dispaly: none; border: 1px solid #e6e6e6;width:500px">
		<div class="o_title">短信发送<span class="o_close" id="closeSmsDialog">关闭</span>
		</div>
		<div class="o_content" id="smsType" style="text-align: left;">
	
			<table border="1px">
				<tr>
					<td style="text-align: left; width: 150px"><span>&nbsp;&nbsp;&nbsp;&nbsp;联系人手机:</span></td>
					<td  style="width: 350px"><input id="smsMobile" type="text" readonly="readonly"value="${(base.flightOrderContacter.cellphone)!'&nbsp;'}"></<input></td>
				</tr>
				<tr>
					<td style="text-align: left; width: 150px"><span>&nbsp;&nbsp;&nbsp;&nbsp;短信模版:</span></td>
					<td >
					<select id="smsTypeName" onchange="changeSmsType(this.value,'${request.contextPath}/sms/getSmsContent/');">
							<option value="NULL">不使用模版</option>
							<#list smsTypeEnum as val>  
							   <option value="${val}">${val.cnName}</option>
							</#list>  
						</select>	
					</td>
				</tr>
					<tr>
					<td style="text-align: left; width: 150px"><span>&nbsp;&nbsp;&nbsp;&nbsp;发送内容:</span></td>
					<td  style="width: 200px">
					<textarea id="smsContent" rows="5" cols="38" style=" font-size:15px; color:#F00">发送内容····</textarea>
					</td>
				</tr>
	
			</table>
		</div>
	
		<div class="o_submit">
		<a href="javascript:void(0);"><span class="cancle"
			onclick="sendSms('${request.contextPath}/sms/sendSms')">发送</span></a> <a href="javascript:void(0);"><span
			class="cancle" onclick="closeSmsDialog()">关闭</span></a>
	</div>
</div>
		    <!--  取消订单时间更改 -->
	<div class="office" id="limitTimeDialog" style="align: center; top: 300px; dispaly: none; border: 1px solid #e6e6e6;width:270px">
		<div class="o_title">订单取消时间修改<span class="o_close" onclick="closelimitTimeDialog()">关闭</span>
		</div>
	 <span> 订单取消时间：</span><input type="text" name="limitTime" value="${limitTime}" id="limitTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
		<div class="o_submit">
		<a href="javascript:void(0);"><span class="cancle"
			onclick="editLimtTime('${request.contextPath}/order/editLimtTime')">保存</span></a> <a href="javascript:void(0);"><span
			class="cancle" onclick="closelimitTimeDialog()">关闭</span></a>
	</div>
</div>

	<!--显示重新下单前验舱验价信息失败-->
	<div class="office" id="verifyBookingAgainFail" style="align:center;top:300px;dispaly:none;border:1px solid #e6e6e6;">
		<div class="o_title">
			重新下单前验舱验价失败<span class="o_close" id="closeVerifyBookingAgainFailDialog" >X</span>	
		</div>
		
		<div class="o_content"" id="verifyBookingAgainFailMessage" style="top:10px;font-size:20px;text-align:center;">
	        <span style="color:red;padding-left:15px;"></span>
	    </div>
	    
	  <div class="o_submit">
		<a href="javascript:void(0);"><span class="cancle" onclick="closeVerifyBookingAgainFail()">关闭</span></a>
	  </div>
	</div>
	<!--显示重新下单前验舱验价信息成功-->
	<div class="office" id="verifyBookingAgainSucc" style="align:center;top:300px;dispaly:none;border:1px solid #e6e6e6;">
		<div class="o_title">
			重新下单确认<span class="o_close" id="closeVerifyBookingAgainSuccDialog" >X</span>	
		</div>
		
		<div class="o_content"" id="verifyBookingAgainSuccMessage" style="top:10px;font-size:20px;text-align:center;">
	        <span style="color:red;padding-left:15px;"></span>
	    </div>
	    
	  <div class="o_submit">
		 <div id="bookingAgainSuccButton"><a href="javascript:;"><span onclick="bookingAgain('${request.contextPath}/bookingAgain/apply')">确认</span></a></div>
	  </div>
	</div>


<script type="text/javascript">
	//订单Tab切换	
	function changeOrderTab(tableId, obj)
	{
		$('#'+tableId+'').css('display', '');
		if(tableId == 'relationTable')
			$('#sameTable').css('display', 'none');
		else
			$('#relationTable').css('display', 'none');
	}
</script>