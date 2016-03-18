<!DOCTYPE html>
<html>
  <head>
    <#include "common/common_head.ftl"/>
  </head>
  <body>
  <div class="iframe_content">   
    <div class="p_box">
        <form method="POST" action='/order/findFlightOrderList' id="searchOrderForm">
            <table class="s_table">
                <tbody>
                 <tr>
                 <td class="s_label">订单号：</td>
                        <td class="w18"><input type="text" id="orderNo" name="orderNo" value="${orderForm.orderNo!''}"></td>
                        <td class="s_label">PNR：</td>
                        <td class="w18"><input type="text" id="pnr" name="pnr" value="${orderForm.pnr!''}"></td>
                        <td class="s_label">联系人：</td>
                        <td class="w18"><input type="text" id="contactsName" name="contactsName" value="${orderForm.contactsName!''}"></td>
                        <td class="s_label">联系电话：</td>
                         <td class="w18"><input type="text" id="contactsCellphone" name="contactsCellphone" value="${orderForm.contactsCellphone!''}"></td>
                        </tr>
                        <tr>
                        <td class="s_label">票           号：</td>
                        <td class="w18"><input type="text" id="flightTicketNo" name="flightTicketNo" value="${orderForm.flightTicketNo!''}"></td>
                        <td class="s_label">乘客姓名：</td>
                         <td class="w18"><input type="text" id="customerName" name="customerName" value="${orderForm.customerName!''}"></td>
                        <td class="p_label">下单时间：</td>
		                <td>
		                    <input errorEle="searchValidate" type="text" name="flightOrderTime" class="Wdate w110" id="d4321" onFocus="WdatePicker({readOnly:'true',dateFmt:'yyyy-MM-dd HH:mm'})">
		                </td>
                        <td class="s_label">订单状态：</td>
                         <td class="w18">
                    	  <select name="orderForm.orderType">
                    		        <option value="">不限</option>
			                    	<option value='Y'<#if orderForm.orderType == 'Y'>selected</#if>>无</option>
			                    	<option value='N'<#if orderForm.orderType == 'N'>selected</#if>>无</option>
                    	</select>
                          </td>
                        </tr>
                        <tr>
                        <td class="s_label">出发城市：</td>
                         <td class="w18"><input type="text" id="departureAirportName" name="departureAirportName" value="${orderForm.departureAirportName!''}"></td>
                        <td class="s_label">到达城市：</td>
                        <td class="w18"><input type="text" id="arrivalAirportName" name="arrivalAirportName" value="${orderForm.arrivalAirportName!''}"></td>
                        <td class="p_label">起飞时间：</td>
                        <td>
                            <input errorEle="searchValidate" type="text" name="departureDate" class="Wdate w110" id="d4321" onFocus="WdatePicker({readOnly:'true',dateFmt:'H:mm'})">
                         </td>
                        <td class="s_label">航空公司：</td>
                         <td class="w18"><input type="text" id="carrierName" name="carrierName" value="${orderForm.carrierName!''}"></td>
                       </tr>
                       <tr>
                        <td class="s_label">航班号：</td>
                         <td class="w18"><input type="text" id="flightNo" name="flightNo" value="${orderForm.flightNo!''}"></td>
                        <td class="operate mt10" style="margin-left:300px;width:400px;"><a class="btn btn_cc1" id="search_button">查询</a></td>
                    </tr>
                </tbody>
            </table>    
        </form>
    </div>
    
    <!-- 主要内容显示区域\\ -->
    <div class="p_box">
      <table class="p_table table_center">
        <thead>
            <tr>
                <th>订单号</th>
                <th>PNR(大/小)</th>
                <th>新PNR(大/小)</th>
                <th>乘机人</th>
                <th>票号</th>
                <th>航程</th>
                <th>航班号</th>
                <th>航班日期</th>
                <th>创单日期</th>
                <th>订单状态</th>
            </tr>
        </thead>
        <tbody>
        <tr>
                <td><a href="javascript:void(0);" class="searchOrderInfo" id="searchOrderInfo">F0000001</a></td>
                <td>H23YJ1/M23YJ1</td>
                <td>H23YJ1/M23YJ1</td>
                <td>CHEN/RUYI</td>
                <td>1022454554</td>
                <td>上海-厦门</td>
                <td>CA1312</td>
                <td>2014-05-24 12:30</td>
                <td>2014-04-30 13:41</td>
                <td>已出票</td>
                
                </tr>
            <#list orderList as flightOrder> 
            <tr>
                <td>${flightOrder.orderNo!''}</td>
                <td>${flightOrder.oldPnr!''}</td>
                <td>${flightOrder.pnr!''}</td>
                <td>${flightOrder.customerName!''}</td>
                <td>${flightOrder.flightTicketNo!''}</td>
                <td>${flightOrder.arriveDistrictString!''}</td>
                <td>${flightOrder.flightNo!''}</td>
                <td>${flightOrder.createTime!''}</td>
                <td>${flightOrder.flightNo!''}</td>
                <td>${flightOrder.flightNo!''}</td>
                </tr>
            </#list>
        </tbody>
    </table>
    </div><!-- div p_box -->
    </div><!-- //主要内容显示区域 -->
    <#include "common/common_foot.ftl"/>
    <script>
        //查询
        $("#search_button").on('click',function(){
        	if(!$("#searchOrderForm").validate().form()){
           	 	return false;
        	}
            $("#searchOrderForm").submit();
        });
        
  //查询订单详情信息
$("a.searchOrderInfo").bind("click",function(){
	window.open("/order/findFlightOrderDetails");
	return false;
});
        
    </script>
  </body>
</html>
