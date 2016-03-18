<#if userList??>
<form id="userSelectForm">
 <table width="100%" border="1" id="table01">
    <tr>
        <td width="13%">选择</td>
        <td width="23%">会员名称</td>
        <td width="21%">手机号码</td>
        <td width="21%">邮箱</td>
        <td width="22%">会员卡号</td>
    </tr>
    	<#list userList as user>
        <tr>
            <th><input onclick="chooseUserInfo(this.value);" type="radio" name="userId" userName="${user.userName}" value="${user.userId}"/></th>
            <th>${user.userName}</th>
            <th>${user.mobileNumber}</th>
            <th>${user.email}</td>
            <th>${user.memberShipCard}</th>
            <input id="grade_${user.userId}" type="hidden"  value="${user.grade}"/>
            <input id="mobileNumber_${user.userId}" type="hidden"  value="${user.mobileNumber}"/>
            <input id="userName_${user.userId}" type="hidden" value="${user.userName}"/>
             <input id="userNo_${user.userId}" type="hidden" value="${user.userNo}"/>
        </tr>
        </#list>
</table>
</form>
<#else>
没有搜索到相关的会员信息
</#if>