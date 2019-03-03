<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>

    <!-- add and edit modal -->
    <div class="modal fade" id="modalDialog" tabindex="-1" role="dialog" aria-labelledby="新增" data-backdrop="static">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <!-- content -->
        </div>
      </div>
    </div>
    
    <div class="modal fade" id="pageDialog" tabindex="-1" role="dialog" aria-labelledby="关联" data-backdrop="static">
      <div class="modal-lg"  style="min-width: 100%;min-height: 1138px;">
        <div class="modal-content" style="min-width: 100%;min-height: 1138px;border: 0px;">
        
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" id="close-dialog"></span></button>
           <div className="modal-body" style="min-width: 100%;min-height: 1138px;">
            <iframe src="" id="modalPage" class="modalFrame" frameborder="0" style="width:100%; min-height:1138px;"></iframe>
           </div>
        </div>
      </div>
    </div>

<div class="container-fluid">
	<div class="row">
      <div class="widget-box">
        <div class="widget-header widget-header-flat">
          <h4 class="widget-title">指标管理</h4>
          <div class="widget-toolbar" style="line-height: 32px;">
            <label>
              <small>
                <button name="newTakMain" class="btn btn-white btn-success btn-sm btn-round" style="line-height: 20px;"><i class="ace-icon fa fa-plus bigger-100 green"></i>新建</button>
              </small>
            </label>
          </div>
        </div>

        <div class="widget-body">
          <div class="widget-main">

    		    <!-- table -->
    		    <div class="fix-table-container">
    		      <table class="table table-striped table-bordered table-hover js-table fix-table " id="takMainTable">
    		        <thead>
    		          <tr>
    		           <th class="text-center" style="width: 20px;">序号</th>
    		           <th class="text-center" style="width: 40px;">编码</th>
    		           <th class="text-center" style="width: 200px;">名称</th>
    		           <th class="text-center" style="width: 40px;">编辑</th>
    		           <th class="text-center" style="width: 40px;">删除</th>
    		          </tr>
    		         </thead>
    		        <tbody>
    		        </tbody>
    		      </table>
    		    </div>
          </div>
        </div>
      </div>
	</div>
  </div>

<div class="loadDiv" id="dcpContainer"></div>
  
    <script>
    
    var scripts = [
          			null,
          			"${ctx}/assets/jquery/ui/jquery-ui.custom.min.js",
          			"${ctx}/assets/jquery/plugins/jquery-form/jquery-form.min.js",
          			"${ctx}/assets/jquery/plugins/validation/jquery.validate.min.js",
          			"${ctx}/assets/jquery/plugins/validation/localization/messages_zh.min.js",
          			"${ctx}/assets/bootstrap/plugins/date-time/bootstrap-datepicker.min.js",
          			"${ctx}/assets/bootstrap/plugins/date-time/locales/bootstrap-datepicker.zh-CN.js",
          			"${ctx}/assets/bootstrap/plugins/bootbox/bootbox.min.js",
          			"${ctx}/assets/jquery/plugins/jqGrid/js/jquery.jqGrid.min.js",
          			"${ctx}/assets/jquery/plugins/jqGrid/js/i18n/grid.locale-cn.js",
          			"${ctx}/assets/jquery/plugins/lixi_common/ajax_render.js",
          			"${ctx}/assets/jquery/plugins/lixi_common/jquery.serialize-object.min.js",
          			"${ctx}/assets/jquery/plugins/toast/jquery.toaster.js",
          			"${ctx}/assets/jquery/plugins/lixi_common/utils.js",
          			"${ctx}/assets/jquery/plugins/jstree/jstree.min.js",
          			"${ctx}/assets/jquery/plugins/lixi_common/js-table.js",
          			"${ctx}/assets/js/agrims.js", null ]
          	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
          		jQuery(function($) {
          			$('#takMainTable').jstable({pager:true,template:genRowTemplate()});
          	        reloadTakMainTable();

          	        //search form init
          	        $("#searchForm").ajaxForm({
          	          beforeSubmit:function(arr, $form, options) { 
          	            var searchUrl = $form.attr('action')+ '?' +$form.serialize();
          	            $('#takMainTable').jstable('set_params',{url:searchUrl});
          	            return false;        
          	          },
          	          dataType : 'json',
          	        });
          	      //init iframe
          	        var iframe = document.getElementById("modalPage");  
          	        if (iframe.attachEvent) {  
          	            iframe.attachEvent("onload", function() {   
          	              $('#pageDialog').modal("show"); 
          	            });  
          	        } else {  
          	            iframe.onload = function() {  
          	              $('#pageDialog').modal("show");
          	            };  
          	        }

          	        //action bar new
          	        $('button[name="newTakMain"]').click(function (){
          	          var url = '${ctx}/dataCollectIndex/edit?id=&date='+new Date().getTime();
          	          showModal(url, dataCollectPointFormInit);
          	        });


          		});
          	});
    
 
      $(document).ready(function () {
     
      });

      function reloadTakMainTable(){
        ajaxRenderTable('${ctx}/dataCollectIndex/queryList',genRowTemplate());
      }

      function showModal(url, callback){
        $.get(url, function (data){
          var modal = $('#modalDialog');
          var modal_content =  modal.find('.modal-content');
          modal_content.html(data);
          if (callback) {
            callback();
          };
          modal.modal('show');
        });
      }
      
      function dataCollectPointFormInit () {
        var form = $('#modalDialog').find('form').eq(0);;
        //validate init
        form.validate({ 
          rules : {
            indexName : {
              required : true,
              maxlength: 100,
            },
            indexCode : {
              required : true
            }
          },
          errorClass: 'text-warning',
          errorPlacement: function(error, element) {
            error.css('position','absolute').css('font-size','xx-small').insertAfter(element);
          },
          submitHandler: function (form) {
            ajaxFormSubmit(form, function(data, status) {
              if(data.data) {
                $.toaster({ title : '成功', priority : 'success', message : data.message });
                $(form).parents('.modal').modal('hide');
                reloadTakMainTable();
              }else {
                $.toaster({ title : '失败', priority : 'warning', message : data.message });
              }
            });
          }
        });

      }

      //common
      function ajaxFormSubmit(form, successCallback) {
        var cfg = {
          success: successCallback, // post-submit callback 
          url: $(form).attr("action"),
          type: $(form).attr("method") ? $(form).attr("method") : 'post', // 'get' or 'post', override for form's 'method' attribute 
          dataType: 'json', // 'xml', 'script', or 'json' (expected server response type) 
          contentType: 'application/json',
          data: JSON.stringify($(form).serializeObject()),
        };
        $.ajax(cfg);
      }

      //js table
      //js table action view
      $('#takMainTable').on('click', 'a[name="edit"]', function () {
        var _this = $(this);
        var date_element = _this.parents('.data-row');
        var url = '${ctx}/dataCollectIndex/edit?id=' + date_element.attr('id');
        showModal(url, dataCollectPointFormInit);
      });

         
      $('#takMainTable').on('click', 'td.row-select,a[name="delete"]', function () {
        var _this = $(this);
	      var date_element = _this.parents('.data-row');
	      $.ajax({
	        url:"${ctx}/dataCollectIndex/delete",
	        data:{'id':date_element.attr('id')},
	        type:"get",
	        dataType:"json",
	        success:function(data){
	        	alert(data.message);
	        	reloadTakMainTable();
	        }
	       });
      });
          
      // row all selectos init
      $('#row_all_selector').click(function (){
        if($(this).prop('checked')){
          getRowSelectors().prop('checked',true);
        }else{
          getRowSelectors().prop('checked',false);
        }
      });

      function genRowTemplate(node) {
          var tamplate = '<tr id="{id}" class="data-row">'
        	  			  + '<th>{_index}</th>\
                            <td title="{indexCode}">{indexCode}</td>\
                            <td title="{indexName}">{indexName}</td>\
                            <td style="text-align: center;cursor: pointer;" >\
                            <div class="btn-group" role="group" aria-label="编辑" style="margin-left:5px">\
                            <a class="green" name="edit"><i class="ace-icon fa fa-cog bigger-150"></i></a>\
                            </div>\
                            </td>\
                            <td style="text-align: center;cursor: pointer;" >\
                            <div class="btn-group" role="group" aria-label="删除">\
                            <a class="red" name="delete"><i class="ace-icon fa fa-times bigger-150"></i></a>\
                            </div>\
                            </td>\
                          </tr>';
          return tamplate;
        }

        function ajaxRenderTable(url, template){
          $('#takMainTable').jstable('set_params',{ url: url,template:template});
        }

        function getRowSelectors(node){
          return $('tbody .js-row_selector');
        }

        function getSelectedRowsId(node){
          return $('tbody .js-row_selector:checked').parents('tr').map(function(){
            return $(this).prop('id');
          });
        }

    </script>
    <link href="${ctx}/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${ctx}/assets/jquery/plugins/jstree/themes/default/style.min.css" />
    <link rel="stylesheet" href="${ctx}/assets/bootstrap/plugins/date-time/css/datepicker.min.css" />
    <link href="${ctx}/assets/css/mgr-common.css" rel="stylesheet">