<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<link rel="stylesheet" href="${ctx}/assets/jquery/ui/css/jquery-ui.min.css" />
<link rel="stylesheet" href="${ctx}/assets/jquery/plugins/jqGrid/css/ui.jqgrid.css" />
<link rel="stylesheet" href="${ctx}/assets/bootstrap/plugins/date-time/css/datepicker.min.css" />
<link rel="stylesheet" href="${ctx}/assets/jquery/plugins/jstree/themes/proton/style.css" />

<script>
	function goSearch() {
		
		var year = $("#year").val();
		var month = $("#month").val();
		
		var postData = {"year":year,
						"month":month
						};
	
	    $("#grid-table").jqGrid('setGridParam',{  
	        datatype:'json',  
	        postData:postData
	    }).trigger("reloadGrid");
	}
</script>
<div class="row">
	<div class="col-xs-12">
		<div class="btn-group" style="display:none">
			<button id="showTaskBtn" type="button" class="btn btn-info btn-blue btn-sm btn-round" data-toggle="modal">
				<i class="fa fa-eye"></i>   
				查看
			</button>
		</div>
		
		
		<div style="margin-top:5px;margin-bottom:5px;">
			上报时间：
			<select id="year" name="year">
				<option value="">-=未选择=-</option>
				<c:forEach var="year" items="${yearList}">
					<option value="${year}" <c:if test="${currentYear == year}"> selected </c:if>>${year}</option>
				</c:forEach>
			</select>年
			<select id="month" name="month">
				<option value="">-=未选择=-</option>
				<c:forEach var="month" items="${monthList}">
					<option value="${month}" <c:if test="${currentMonth == month}"> selected </c:if>>${month}</option>
				</c:forEach>
			</select>月
			&nbsp;
			
			<button type="button" onclick="goSearch()" class="btn btn-default btn-info btn-minier btn-round">
			     <i class="ace-icon glyphicon glyphicon-search bigger-150 icon-only"></i>
			</button>
			<!-- 
			<button type="button" onclick="goSearch()" class="btn btn-default btn-info btn-sm btn-round">查询</button>
			 -->
		</div>
		
		<div class="space-6"></div>
		<table id="grid-table"></table>
		<div id="grid-pager"></div>
	</div><!-- /.col -->
</div><!-- /.row -->

<script type="text/javascript">


function icoFormatter1 (cellvalue, options, rowObject) {
	if(cellvalue == 0) {
		return "<span class=\"label label-warning arrowed arrowed-right\">未完成</span>";
	} else {
		return "<span class=\"label label-success arrowed-in arrowed-in-right\">已完成</span>";
	}
}

var scripts = [null,"${ctx}/assets/jquery/plugins/jstree/jstree.min.js","${ctx}/assets/jquery/plugins/jquery-form/jquery-form.min.js","${ctx}/assets/jquery/plugins/validation/jquery.validate.min.js","${ctx}/assets/jquery/plugins/validation/localization/messages_zh.min.js","${ctx}/assets/bootstrap/plugins/date-time/bootstrap-datepicker.min.js","${ctx}/assets/jquery/plugins/jqGrid/js/jquery.jqGrid.min.js","${ctx}/assets/jquery/plugins/jqGrid/js/i18n/grid.locale-cn.js","${ctx}/assets/bootstrap/plugins/bootbox/bootbox.min.js","${ctx}/assets/js/agrims.js", null]
//var scripts = [null,"${ctx}/assets/jquery/ui/jquery-ui.custom.min.js","${ctx}/assets/jquery/plugins/jquery-form/jquery-form.min.js","${ctx}/assets/jquery/plugins/validation/jquery.validate.min.js","${ctx}/assets/jquery/plugins/validation/localization/messages_zh.min.js","${ctx}/assets/bootstrap/plugins/date-time/bootstrap-datepicker.min.js","${ctx}/assets/bootstrap/plugins/date-time/locales/bootstrap-datepicker.zh-CN.js","${ctx}/assets/bootstrap/plugins/bootbox/bootbox.min.js","${ctx}/assets/jquery/plugins/jqGrid/js/jquery.jqGrid.min.js","${ctx}/assets/jquery/plugins/jqGrid/js/i18n/grid.locale-cn.js","${ctx}/assets/js/agrims.js", null]
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
  jQuery(function($) {
	var ctx='${ctx}';
	
	//resize to fit page size
	$(window).on('resize.jqGrid', function () {
		$(grid_selector).jqGrid( 'setGridWidth', $(".page-content").width() );
		$("#grid-table").closest(".ui-jqgrid-bdiv").css({ "overflow-x" : "hidden" });
    });
	
	//resize on sidebar collapse/expand
	var parent_column = $(grid_selector).closest('[class*="col-"]');
	$(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
		if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
			//setTimeout is for webkit only to give time for DOM changes and then redraw!!!
			setTimeout(function() {
				$(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
				$("#grid-table").closest(".ui-jqgrid-bdiv").css({ "overflow-x" : "hidden" });
			}, 0);
		}
    });
	
	
	var g=$("a[href$='${ctx}/index#page/office/task/waitlist']");
	g.closest("li").parent().parent().addClass('active open');
	g.closest("li").addClass('active');
	var f = g.next().get(0);
	
	var grid_selector = "#grid-table";
	var pager_selector = "#grid-pager";
	var pageSize=${pageSize};
	
	//,'发布时间'   {name:'beginTime',index:'beginTime',width:100,editable: true, sortable:false},		
	$(grid_selector).jqGrid({
		 url:'${ctx}/office/task/waitlist',
		 datatype: 'JSON',
		 colNames:['ID','任务编号', '任务名称','任务期数','上报时间','状态'],
		 colModel:[
		   		{name:'id',index:'id', hidden:true,width:100, editable: true, sortable:false},
		   		{name:'taskNum',index:'taskNum',width:50,editable: true, sortable:false},
		   		{name:'taskName',index:'taskName',width:150,editable: true, sortable:false},
		   		{name:'taskNo',index:'taskNo',width:50,editable: true, sortable:false},
		   		{name:'endTime',index:'endTime',width:100,editable: true, sortable:false},
		   		{name:'status',index:'status', width:80, fixed:true, sortable:false, resize:false,
		   			formatter:icoFormatter1,
		   			editable: false
		   		}
		 ],
		 jsonReader : {
				root: "rows",
	            page: "page",
	            total: "total",
	            records: "records",
	            repeatitems: false,
	            cell: "cell",
	            id: "id"
	     },
	     editurl:'${actionUrl}',
	     loadonce:false,
		 rownumbers: true,
		 rowNum:pageSize,
		 rowList:[10,15,20],
		 pager : pager_selector,
		 height:'100%',
		 autowidth: true,
		 altRows: true,
		 viewrecords: true,
		 multiselect: false,		 
		 loadComplete : function() {
			 var table = this;
				setTimeout(function(){
					updateActionIcons(table);
					updatePagerIcons(table);
					enableTooltips(table);
					
					$(table).find("tr").each(function(i,ob) {
						ob.style.cursor = "pointer";
					});
				}, 0);
		},
		onSelectRow: function(id){ 
			showRow(id);
		}
    });
		
$(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size
	
	//enable search/filter toolbar
	//jQuery(grid_selector).jqGrid('filterToolbar',{defaultSearch:true,stringResult:true})
	//jQuery(grid_selector).filterToolbar({});
	
	//switch element when editing inline
	function aceSwitch( cellvalue, options, cell ) {
		setTimeout(function(){
			$(cell) .find('input[type=checkbox]')
				.addClass('ace ace-switch ace-switch-5')
				.after('<span class="lbl"></span>');
		}, 0);
	}
	//enable datepicker
	function pickDate( cellvalue, options, cell ) {
		setTimeout(function(){
			$(cell) .find('input[type=text]')
					.datepicker({format:'yyyy-mm-dd' , autoclose:true}); 
		}, 0);
	}
	
	//navButtons
	$(grid_selector).jqGrid('navGrid',pager_selector,
	  {
		edit: false,
		editicon : 'ace-icon fa fa-pencil blue',
		edittext:"编辑",
		add: false,
		addicon : 'ace-icon fa fa-plus-circle purple',
		del: false,
		delicon : 'ace-icon fa fa-trash-o red',
		search: false,
		searchicon : 'ace-icon fa fa-search orange',
		searchtext:"查找",
		refresh: true,
		refreshicon : 'ace-icon fa fa-refresh green',
		refreshtext:"刷新",
		view: false,
		viewicon : 'ace-icon fa fa-search-plus grey',
		viewtext:"查看"
		},
		{
			//edit record form
			//closeAfterEdit: true,
			recreateForm: true,
			beforeShowForm : function(e) {
				var form = $(e[0]);
				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
				style_edit_form(form);
			}
		},
		{
			//new record form
			closeAfterAdd: true,
			recreateForm: true,
			viewPagerButtons: false,
			beforeShowForm : function(e) {
				var form = $(e[0]);
				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
				style_edit_form(form);
			}
		},
		{
			//delete record form
			recreateForm: true,
			beforeShowForm : function(e) {
				var form = $(e[0]);
				if(form.data('styled')) return false;
				
				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
				style_delete_form(form);
				
				form.data('styled', true);
			},
			onClick : function(e) {
				alert(1);
			}
		},
		{
			//search form
			recreateForm: true,
			afterShowSearch: function(e){
				var form = $(e[0]);
				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
				style_search_form(form);
			},
			afterRedraw: function(){
				style_search_filters($(this));
			}
			,
			multipleSearch: false,
			/**
			multipleGroup:true,
			showQuery: true
			*/
		},
		{
			//view record form
			recreateForm: true,
			beforeShowForm: function(e){
				var form = $(e[0]);
				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
			}
		}
	);
	
	
	function style_edit_form(form) {
		//enable datepicker on "sdate" field and switches for "stock" field
		form.find('input[name=sdate]').datepicker({format:'yyyy-mm-dd' , autoclose:true})
			.end().find('input[name=stock]')
				.addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
				   //don't wrap inside a label element, the checkbox value won't be submitted (POST'ed)
				  //.addClass('ace ace-switch ace-switch-5').wrap('<label class="inline" />').after('<span class="lbl"></span>');

		//update buttons classes
		var buttons = form.next().find('.EditButton .fm-button');
		buttons.addClass('btn btn-sm').find('[class*="-icon"]').hide();//ui-icon, s-icon
		buttons.eq(0).addClass('btn-primary').prepend('<i class="ace-icon fa fa-check"></i>');
		buttons.eq(1).prepend('<i class="ace-icon fa fa-times"></i>')
		
		buttons = form.next().find('.navButton a');
		buttons.find('.ui-icon').hide();
		buttons.eq(0).append('<i class="ace-icon fa fa-chevron-left"></i>');
		buttons.eq(1).append('<i class="ace-icon fa fa-chevron-right"></i>');		
	}
	
	function style_delete_form(form) {
		var buttons = form.next().find('.EditButton .fm-button');
		buttons.addClass('btn btn-sm btn-white btn-round').find('[class*="-icon"]').hide();//ui-icon, s-icon
		buttons.eq(0).addClass('btn-danger').prepend('<i class="ace-icon fa fa-trash-o"></i>');
		buttons.eq(1).addClass('btn-default').prepend('<i class="ace-icon fa fa-times"></i>')
	}
	
	function style_search_filters(form) {
		form.find('.delete-rule').val('X');
		form.find('.add-rule').addClass('btn btn-xs btn-primary');
		form.find('.add-group').addClass('btn btn-xs btn-success');
		form.find('.delete-group').addClass('btn btn-xs btn-danger');
	}
	
	function style_search_form(form) {
		var dialog = form.closest('.ui-jqdialog');
		var buttons = dialog.find('.EditTable')
		buttons.find('.EditButton a[id*="_reset"]').addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'ace-icon fa fa-retweet');
		buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'ace-icon fa fa-comment-o');
		buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').attr('class', 'ace-icon fa fa-search');
	}
	
	function beforeDeleteCallback(e) {
		var form = $(e[0]);
		if(form.data('styled')) return false;
		
		form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
		style_delete_form(form);
		
		form.data('styled', true);
	}
	
	function beforeEditCallback(e) {
		var form = $(e[0]);
		form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
		style_edit_form(form);
	}
	
	
	
	//it causes some flicker when reloading or navigating grid
	//it may be possible to have some custom formatter to do this as the grid is being created to prevent this
	//or go back to default browser checkbox styles for the grid
	function styleCheckbox(table) {
	/**
		$(table).find('input:checkbox').addClass('ace')
		.wrap('<label />')
		.after('<span class="lbl align-top" />')
	
	
		$('.ui-jqgrid-labels th[id*="_cb"]:first-child')
		.find('input.cbox[type=checkbox]').addClass('ace')
		.wrap('<label />').after('<span class="lbl align-top" />');
	*/
	}
	
	
	//unlike navButtons icons, action icons in rows seem to be hard-coded
	//you can change them like this in here if you want
	function updateActionIcons(table) {
		
		var replacement = 
		{
			'ui-ace-icon fa fa-pencil' : 'ace-icon fa fa-pencil blue',
			'ui-ace-icon fa fa-trash-o' : 'ace-icon fa fa-trash-o red',
			'ui-icon-disk' : 'ace-icon fa fa-check green',
			'ui-icon-cancel' : 'ace-icon fa fa-times red'
		};
		$(table).find('.ui-pg-div span.ui-icon').each(function(){
			var icon = $(this);
			var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
			if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
		})
		
	}
	
	//replace icons with FontAwesome icons like above
	function updatePagerIcons(table) {
		var replacement = 
		{
			'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
			'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
			'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
			'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
		};
		$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
			var icon = $(this);
			var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
			
			if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
		})
	}
	
	function enableTooltips(table) {
		$('.navtable .ui-pg-button').tooltip({container:'body'});
		$(table).find('.ui-pg-div').tooltip({container:'body'});
	}
	
	//var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');
	
	$(document).on('ajaxloadstart', function(e) {
		$(grid_selector).jqGrid('GridUnload');
		$('.ui-jqdialog').remove();
	});
	
	$("#showTaskBtn").click(function(e){
		var rowId = $(grid_selector).jqGrid('getGridParam','selrow');
		if(rowId){
			showRow(rowId);
		}else{
			bootbox.alert("请选择一条记录!");
		}
		e.preventDefault();
	});
	
  });
});

function showRow(id){
	window.location.href="${ctx}/index#page/office/task/viewInput/"+id;
}


$("#grid-table").closest(".ui-jqgrid-bdiv").css({ "overflow-x" : "hidden" });

</script>