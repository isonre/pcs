<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>

<script type="text/javascript">
$(document).ready(function() {
	jQuery.struts2_jquery.require("js/base/jquery.ui.datepicker.min.js");
	jQuery.struts2_jquery.require("i18n/jquery.ui.datepicker-zh-CN.min.js");
	
	$.subscribe('itemPerm', function(event,data) {
		  <shiro:lacksRole name="ROLE_ADMIN">
		   $('#exportItemBtn').hide();
		  </shiro:lacksRole>
	});
	
	$.subscribe('viewItem', function(event,data) {
		 var rowId = jQuery("#"+data.id).jqGrid('getGridParam','selrow');
		 if(rowId){
			 $('#itemViewDialog').empty().load("<s:url value="/item/viewForm.action"/>",{id:rowId}).dialog('open');
			 return false;
		 }else{
			 jAlert("请选择要查看的纪录!");
		 }			 
    });
	
	 $.subscribe('archiveItem', function(event,data) {
		    var selectedIds = jQuery("#itemTable").jqGrid('getGridParam','selarrrow');
			 var ids = [];
			 if (selectedIds==null || selectedIds.length==0){
				 jAlert("请选择要归档的采购项目!");
				 return false;
			 }
			 for(var i=0;i<selectedIds.length;i++){
				 ids.push(selectedIds[i]);
			 } 
			 var params={"ids":ids};
		     $.ajax({
				  		type : 'POST',
				  		url : '<s:url value="/item/archive.action"/>',
				  		data :jQuery.param(params,true),
				  		success : function(response) {
				  		  jAlert(response.message,"消息框");
				  		 jQuery("#itemTable").trigger('reloadGrid');	
				},
				dataType : 'JSON'
			});
	  });
	  
	  $.subscribe('exportItem', function(event,data) {
		    var selectedIds = jQuery("#"+data.id).jqGrid('getGridParam','selarrrow');
			 var ids = [];
			 if (selectedIds!=null && selectedIds.length>0){
				 for(i=0;i<selectedIds.length;i++){
					 ids.push(selectedIds[i]);
				} 
				 var params={"ids":ids,pageSize:10};
				 $.fileDownload('<s:url value="/item/exportSelected.action"/>', { httpMethod : "POST", data:jQuery.param(params,true)});
		    	 return false;
			 }else{
				 var postData=$("#"+data.id).jqGrid('getGridParam', 'postData');
				 var filters=postData.filters;
				if(filters!="undefined" && filters!=null){
						$.fileDownload('<s:url value="/item/exportFinished.action"/>', { httpMethod : "POST", data: {filters : filters,pageSize:10}});
				}else{
					   $.fileDownload('<s:url value="/item/exportFinished.action"/>', { httpMethod : "POST", data: {pageSize:10}});
				 }
		     }
	  });
	  
	 $.subscribe('viewActivity', function(event,data) {
			 var rowId = jQuery("#"+data.id).jqGrid('getGridParam','selrow');
			 if(rowId){
				 $('#activityDialog').empty().load("<s:url value="/item/activity/query.action"/>",{itemId:rowId}).dialog('open');
				 return false;
			 }else{
				 jAlert("请选择要查看进度的纪录!");
			 }		 
		 });
});
</script>
<div class="app-panel">
	<div class="title">当前位置：采购计划 &gt;&gt; 项目查询 &gt;&gt; 完成项目</div>
	<div class="toolbar">
		<sj:a onClickTopics="archiveItem" button="true"
			buttonIcon="ui-icon-folder-collapsed">
			<s:text name="button.archive" />
		</sj:a>
		<sj:a onClickTopics="closeApp" button="true"
			buttonIcon="ui-icon-close">
			<s:text name="button.close" />
		</sj:a>
	</div>
</div>
<div id="itemWrapper">
	<s:url var="itemTypeSelect" action="select"
		namespace="/base/dictionary">
		<s:param name="dictId" value="19" />
	</s:url>
	<s:url var="purchaseMethodSelect" action="select"
		namespace="/base/dictionary">
		<s:param name="dictId" value="21" />
	</s:url>
	<s:url var="purchaseModeSelect" action="select"
		namespace="/base/dictionary">
		<s:param name="dictId" value="20" />
	</s:url>
	<s:url var="listFinished" action="listFinished" namespace="/item" />
	<sjg:grid id="itemTable" dataType="json" href="%{listFinished}"
		pager="true" rownumbers="true" multiselect="true" multiboxonly="true"
		navigator="true" navigatorSearch="true"
		navigatorSearchOptions="{caption:'查询',multipleSearch:true,closeAfterSearch: true, drag: true, closeOnEscape: true}"
		navigatorAdd="false" navigatorEdit="false" navigatorView="false"
		navigatorDelete="false"
		navigatorExtraButtons="{
    					seperator: { 
    						title : 'seperator'  
    					}, 
    					viewBtn : { 
    		    			caption:'查看',
	    					title : '查看', 
	    					icon: 'ui-icon-document',
	    					topic: 'viewItem'
    					},
    				    activityBtn : { 
    		    			caption:'进度',
	    					title : '进度', 
	    					icon: 'ui-icon-calendar',
	    					topic: 'viewActivity'
    					},
    					seperator: { 
    						title : 'seperator'  
    					},
    					exportBtn : {
    					    id:'exportBtn', 
    		  			    caption:'导出',
	    					title : '导出记录', 
	    					icon: 'ui-icon-print',
	    					topic: 'exportItem'
    					}
    				}"
		onCompleteTopics="resizeGrid,itemPerm" gridModel="itemList"
		rowList="10,15,20" rowNum="20" viewrecords="true" height="380"
		width="1140" shrinkToFit="false">
		<sjg:gridColumn name="id" index="id" hidden="true" title="#ID"
			sortable="false" width="50" />
		<sjg:gridColumn name="submitted" index="submitted" title="上报日期"
			sortable="true" search="true"
			searchoptions="{sopt:['eq','ne','ge','le'],dataInit: function(element) {$(element).datepicker({dateFormat: 'yy-mm-dd'})}}"
			formatter="date"
			formatoptions="{newformat : 'Y-m-d', srcformat : 'Y-m-d H:i:s'}"
			width="100" />
		<sjg:gridColumn name="orgName" index="orgName" jsonmap="org.orgName"
			title="采购单位(部门)" sortable="false" search="true"
			searchoptions="{sopt:['eq','ne','bw','cn']}" width="200" />
		<sjg:gridColumn name="orgCode" index="orgCode" jsonmap="org.orgCode"
			title="单位编码" sortable="false" search="true"
			searchoptions="{sopt:['eq','ne','bw','cn']}" width="100" />
		<sjg:gridColumn name="itemName" index="itemName" title="项目名称"
			sortable="true" search="true"
			searchoptions="{sopt:['eq','ne','bw','cn']}" width="300" />
		<sjg:gridColumn name="itemCode" index="itemCode" title="项目编号"
			sortable="true" search="true" sorttype="text"
			searchoptions="{sopt:['eq','ne','bw','cn']}" width="150" />
		<sjg:gridColumn name="itemQuantity" index="itemQuantity" title="数量"
			sortable="false" search="false"
			searchoptions="{sopt:['eq','ne','ge','le']}"
			formatter="numberFormatter" width="150" />
		<sjg:gridColumn name="fundTotal" index="fundTotal" title="采购预算(万元)"
			sortable="false" search="false"
			searchoptions="{sopt:['eq','ne','ge','le']}" formatter="fundLink"
			width="150" />
		<sjg:gridColumn name="fundSource" index="fundSource" title="经费开支渠道"
			sortable="true" search="false" width="300" />
		<sjg:gridColumn name="itemType" index="itemType"
			jsonmap="itemType.itemName" title="项目分类" searchtype="select"
			searchoptions="{sopt:['eq','ne'],dataUrl : '%{itemTypeSelect}'}"
			sortable="false" search="true" width="150" />
		<sjg:gridColumn name="purchaseMethod" index="purchaseMethod"
			jsonmap="purchaseMethod.itemName" title="采购方式" searchtype="select"
			searchoptions="{sopt:['eq','ne'],dataUrl : '%{purchaseMethodSelect}'}"
			sortable="false" search="true" width="120" />
		<sjg:gridColumn name="purchaseMode" index="purchaseMode"
			jsonmap="purchaseMode.itemName" title="组织方式" sortable="false"
			search="true" searchtype="select"
			searchoptions="{sopt:['eq','ne'],dataUrl : '%{purchaseModeSelect}'}"
			width="120" />
		<sjg:gridColumn name="orgCat" index="orgCat"
			jsonmap="org.orgType.itemName" title="单位分类" sortable="true"
			search="false" width="80" />
		<sjg:gridColumn name="superintendent" index="superintendent"
			title="项目负责人" sortable="false" search="true"
			searchoptions="{sopt:['eq','ne','bw','cn']}" width="80" />
		<sjg:gridColumn name="archived" index="archived" title="归档"
			sortable="true" editoptions="{value:'true:false'}" search="false"
			formatter="checkbox" width="100" />
		<sjg:gridColumn name="username" index="username" title="录入人"
			sortable="false" search="false" width="80" />
		<sjg:gridColumn name="created" index="created" title="创建日期"
			sortable="true" sorttype="date" search="false" formatter="date"
			formatoptions="{newformat : 'Y-m-d', srcformat : 'Y-m-d H:i:s'}"
			width="80" />
	</sjg:grid>
</div>
<sj:dialog id="activityDialog" title="项目进度" modal="true"
	autoOpen="false" width="830" height="360"
	buttons="{
         '关闭':function() {$(this).dialog('close');}
  }">
</sj:dialog>
<sj:dialog id="itemViewDialog" title="采购项目信息" modal="true"
	autoOpen="false" width="960" height="560" indicator="indicator"
	buttons="{
         '关闭':function() {$(this).dialog('close');}
  }" />
<sj:dialog id="fundDialog" autoOpen="false" modal="false"
	resizable="false" title="资金来源" width="885" height="340"
	indicator="indicator"
	buttons="{
         '关闭':function() {$(this).dialog('close');}
  }" />