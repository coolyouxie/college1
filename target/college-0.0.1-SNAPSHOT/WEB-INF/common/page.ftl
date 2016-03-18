<#macro pagination value uri=uri refreshId='list-page' >
<#if value?exists>
共有${value.totalCount}记录,${value.totalPages}页 当前是${value.pageNo}页
<a href="${uri}?${value.fullUrl}&pageNo=1" class="ajax" refreshId='${refreshId}' >首页</a>
<#if value.isHasPre()>
<a href="${uri}?${value.fullUrl}&pageNo=${value.pageNo-1}" class="ajax" refreshId='${refreshId}' >上一页</a>
<#else>
<a href="javascript:;">上一页</a>
</#if>
<#if value.isHasNext()>
<a href="${uri}?${value.fullUrl}&pageNo=${value.pageNo+1}"  class="ajax" refreshId='${refreshId}'  >下一页</a><#else>
<a href="javascript:;">下一页</a>
</#if>
<a href="${uri}?${value.fullUrl}&pageNo=${value.totalPages}" class="ajax" refreshId='${refreshId}' >末页</a>
<a href="${uri}?${value.fullUrl}&pageNo=${value.pageNo}" class="ajax refresh" refreshId='${refreshId}' >刷新</a>
<#else>
Controller 中未定义page对象
</#if>
</#macro>

<#macro linkpage value=page uri=uri param='' class="colorbox" refreshId='list-page' >
<#if value?exists>
 <a href="${uri}?${value.fullUrl}&pageNo=${value.pageNo}&param=${param}"  class="${class}" refreshId='${refreshId}'  ><#nested></a>
</#if>
</#macro>

<#macro pagesort field value=page  sort='desc' uri=uri refreshId='list-page' >
<#if value?exists>
 <a href="${uri}?${value.url}&pageNo=${value.pageNo}&o.field=${field}&o.sort=${value.o.togger}"  class="ajax" refreshId='${refreshId}'  ><#nested>
  <#if field==value.o.field!><img src="${base }/res/app/images/${value.o.sort}.gif" /></#if>
 </a>
</#if>
</#macro>
