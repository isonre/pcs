<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<link rel="stylesheet" href="${ctx}/assets/jquery/ui/css/jquery-ui.min.css" />
<link rel="stylesheet" href="${ctx}/assets/bootstrap/plugins/date-time/css/datepicker.min.css" />
<link rel="stylesheet" href="${ctx}/assets/jquery/plugins/jqGrid/css/ui.jqgrid.css" />
<link rel="stylesheet" href="${ctx}/assets/jquery/plugins/jstree/themes/proton/style.css" />
<style type="text/css">
	.ui-icon-triangle-1-e {
		left:3px;
		margin-left:0px;
		background-image:url('${ctx}/assets/jquery/plugins/jstree/themes/default/32px.png');
		background-position:-36px -4px;
	}
	.ui-icon-triangle-1-s {
		left:3px;
		margin-left:0px;
		background-image:url('${ctx}/assets/jquery/plugins/jstree/themes/default/32px.png');
		background-position:-4px -4px;
	}
	.ui-icon-radio-off {
		left:3px;
		margin-left:0px;
		background-image:url('${ctx}/assets/jquery/plugins/jstree/themes/default/32px.png');
		background-position:-263px -7px;
	}
</style>

<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->
		<table id="grid-table"></table>
		<div id="grid-pager"></div>
	</div><!-- /.col -->
</div><!-- /.row -->


<script type="text/javascript">
function textFormatter (cellvalue, options, rowObject) {
	return "<span style='position:relative;left:35px'>" + cellvalue + "</span>";
}
var scripts = [null,"${ctx}/assets/bootstrap/plugins/date-time/bootstrap-datepicker.min.js","${ctx}/assets/jquery/plugins/jqGrid/js/jquery.jqGrid.min.js","${ctx}/assets/jquery/plugins/jqGrid/js/i18n/grid.locale-cn.js", null]
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
	
	
	var g=$("a[href$='${ctx}/division']");
	g.closest("li").parent().parent().addClass('active open');
	g.closest("li").addClass('active');
	var f = g.next().get(0);
	
	var grid_selector = "#grid-table";
	var pager_selector = "#grid-pager";
	
	$(grid_selector).jqGrid({
		 url:'${ctx}/division/treeList',
		 treeGrid: true,
		 treeGridModel: 'adjacency',
		 ExpandColumn : 'divName',
		 treeIcons:{plus:'ui-icon-triangle-1-e',minus:'ui-icon-triangle-1-s',leaf:'ui-icon-radio-off'},
		 mtype: "POST",
		 datatype: 'json',
		 colNames:['ID', '区划名称','区划代码','记助码','版本','说明'],
		 colModel:[
		   		{name:'id',index:'id', hidden:true,key:true,width:20, sorttype:'int', editable: true},
		   		{name:'divName',index:'orgName',width:150, editable:true,formatter:textFormatter, sortable:false},	
		   		{name:'divCode',index:'divCode',width:200, editable:true, sortable:false},
		   		{name:'mnemonicCode',index:'mnemonicCode',width:100, editable:true, sortable:false},
		   		{name:'verNum',index:'verNum',width:100, sortable:false, editable:true},
		   		{name:'divDesc',index:'divDesc',width:300, sortable:false, editable:true}
		 ],
		 jsonReader : {
	            root: "rows",
	            repeatitems: false,
	            cell: "cell",
	            id: "id"
	     },
	     treeReader : {  
	         level_field: "level",  
	         parent_id_field: "pid",   
	         leaf_field: "isLeaf",  
	         expanded_field: "expanded"  
	     }, 
	     editurl:'${actionUrl}',
		 pager : pager_selector,     
		 height:'100%',
		 autowidth: true,
		 altRows: true,
		 viewrecords: true,	 
		 loadComplete : function() {
				var table = this;
				setTimeout(function(){
					styleCheckbox(table);
					
					updateActionIcons(table);
					updatePagerIcons(table);
					//enableTooltips(table);
				}, 0);
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
	
	/*
	 $(grid_selector).jqGrid('navButtonAdd',pager_selector,{
		    caption:"锁定",
		    buttonicon:"ace-icon fa fa-lock red",
	        onClickButton:function(){
		         var rowId = $(grid_selector).jqGrid('getGridParam','selrow');
		         if(rowId){
		        	 //alert(rowId);
	     		     $.ajax({
	     		    	    type : 'GET',
	     			  	    dataType : 'JSON',
	     			  		url : '${ctx}/user/lock/'+rowId,
	     			  		//data :{'id':rowId},
	     			  		success : function(data) {
	     			  		  alert(data.message);
	     			  		  $(grid_selector).trigger('reloadGrid');	
	     			        },
	     		    });
		         } else {
			         alert("请选择一行!");
		         }     							
	       } 
     });
	 
	 $(grid_selector).jqGrid('navButtonAdd',pager_selector,{
		    caption:"解锁",
		    buttonicon:"ace-icon fa fa-unlock blue",
	        onClickButton:function(){
		         var rowId = $(grid_selector).jqGrid('getGridParam','selrow');
		         if(rowId){
		        	 //alert(rowId);
	     		     $.ajax({
	     			  		type : 'GET',
	     			  	    dataType : 'JSON',
	     			  		url : '${ctx}/user/unLock/'+rowId,
	     			  		//data :{'id':rowId},
	     			  		success : function(data) {
	     			  		  alert(data.message);
	     			  		  $(grid_selector).trigger('reloadGrid');	
	     			        },
	     		    });
		         } else {
			         alert("请选择一行!");
		         }     							
	       } 
    });
	*/
	
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

  });
});

function abc() {
	$("div").find("div[class='tree-wrap tree-wrap-ltr']").each(function(i,ob) {
		ob.className = "";
	});
}
if(!+[1,]) {
	
} else {
	setInterval("abc()",500);
}

$("#grid-table").closest(".ui-jqgrid-bdiv").css({ "overflow-x" : "hidden" });
</script>