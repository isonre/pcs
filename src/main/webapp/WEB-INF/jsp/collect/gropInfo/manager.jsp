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
          <h4 class="widget-title">分组</h4>

          <div class="widget-toolbar" style="line-height: 32px;">
            <label>
              <small>
                <button name="newGropInfo" id="newGropInfo" class="btn btn-white btn-success btn-sm btn-round" style="line-height: 20px;"><i class="ace-icon fa fa-plus bigger-100 green"></i>新建</button>
              </small>
            </label>
            <label>
              <small>
				<button name="delGropInfo" id="delGropInfo" class="btn btn-white btn-danger btn-sm btn-round" style="line-height: 20px;"><i class="ace-icon fa fa-trash-o bigger-120 red"></i>删除</button>
              </small>
            </label>
          </div>
        </div>

        <div class="widget-body">
          <div class="widget-main">
			      <div class="" style="margin-bottom:10px;">
  		        <form class="form-inline" id="searchForm" action="${ctx}/collect/gropInfo" method="get">
  		          <div class="form-group">
  		            <label for="name">名称</label>
  		            <input type="text" class="form-control" name="search_LIKE_name">
  		          </div>
  		          <div class="btn-group">
  		             <button  type="submit" class="btn btn-info btn-white btn-round">查询</button>
  		          </div>
  		        </form>
		        </div>
          
    		    <!-- table -->
    		    <div class="fix-table-container">
    		      <table class="table table-striped table-bordered table-hover js-table fix-table " id="gropInfoTable">
    		        <thead>
    		          <tr>
    		           <th class="text-left" style="width: 70px;"><input type="checkbox" id="row_all_selector">序号</th>
    		           <th class="text-center" style="width: 350px;">分组名称</th>
    		           <th class="text-center" style="width: 80px;" >状态</th>
    		           <th class="text-center" style="width: 80px;">说明</th>
    		           <th class="text-center" style="width: 80px;">操作</th>
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
          			$('#gropInfoTable').jstable({pager:true,template:genRowTemplate()});
          	        reloadGropInfoTable();

          	        //search form init
          	        $("#searchForm").ajaxForm({
          	          beforeSubmit:function(arr, $form, options) { 
          	            var searchUrl = $form.attr('action')+ '?' +$form.serialize();
          	            $('#gropInfoTable').jstable('set_params',{url:searchUrl});
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
          	        $('button[name="newGropInfo"]').click(function (){

          	            showModal('${ctx}/collect/gropInfo/view/new',gropInfoFormInit);
          	        });

          	        //action bar del
          	        $('button[name="delGropInfo"]').click(function (){
          	          var ids = getSelectedRowsId();
          	          if (!ids || ids.length <= 0) {
          	            bootbox.alert("请选择操作的目标!");
          	          }else{
          	            bootbox.confirm('确定要删除吗?',function(result){
          	              if(result) { 
          	                params = ids.map(function (index,id){
          	                  return 'id='+id;
          	                }).toArray().join('&');

          	                var url = '${ctx}/collect/gropInfo?del&' + params;
          	                $.post(url, function (result){
          	                  if(result.status){
          	                    $.toaster({ title : '成功', priority : 'success', message : result.message });
          	                    reloadGropInfoTable();
          	                  }else{
          	                    $.toaster({ title : '失败', priority : 'warning', message : result.message });
          	                  }
          	                }); 
          	              }
          	            });
          	          }
          	        });
          		});
          	});
    
 
      $(document).ready(function () {
     
      });

      function reloadPersonGropPage(ctgId){
        var url = '${ctx}/collect/personGroup/manager?ctgId='+ ctgId;
          $(".loadDiv").load(url);
      }

      function reloadGropInfoTable(){
        ajaxRenderTable('${ctx}/collect/gropInfo',genRowTemplate());
        //清空takDetailTable表
       $('#personGropTable').data('tmId', null);
       $('#dcpContainer').html('');
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
      
      function gropInfoFormInit () {
        var form = $('#modalDialog').find('form').eq(0);;
        //validate init
        form.validate({ 
          rules : {
            name : {
              required : true,
              maxlength: 100,
            },
            explain: {
              maxlength: 500
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
                reloadGropInfoTable();
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
        $('#gropInfoTable').on('click', 'a[name="edit"]', function () {
          var _this = $(this);
          var date_element = _this.parents('.data-row');
          var url = '${ctx}/collect/gropInfo/view/edit?id=' +  date_element.attr('id');
          showModal(url, gropInfoFormInit);
        });

        
         //js table action showDcp
        $('#gropInfoTable').on('click', 'td.row-select,a[name="detail"]', function () {
          var tm_set = $(this).parents('tr');
          tm_set.css("color","#F08080").siblings().css("color","#000"); 
          tm_set.css("background","#FFE4C4").siblings().css("background","#fff");
          reloadPersonGropPage(tm_set.attr('id'));
        });
         
        // row all selectos init
        $('#row_all_selector').click(function (){
          if($(this).prop('checked')){
            getRowSelectors().prop('checked',true);
          }else{
            getRowSelectors().prop('checked',false);
          }
        })

        function genRowTemplate(node) {
          var tamplate = '<tr id="{id}" class="data-row">' +
                           '<th><input type="checkbox" class="js-row_selector">{_index}</th>\
                            <td title="{name}" class="row-select"style=";cursor: pointer;"><a  href="javascript:void(0);">{name}</a></td>\
                            <td title="{state}" style="text-align: center;"><span class="badge badge-primary">{state}</span></td>\
                            <td title="{explain}">{explain}</td>\
                            <td title="编辑"style="text-align: center;cursor: pointer;" >\
                            <a class="green" name="edit"><i class="ace-icon fa fa-pencil-square-o bigger-150"></i></a>\
                            </td>\
                          </tr>';
          return tamplate;
        }

        function ajaxRenderTable(url, template){
          $('#gropInfoTable').jstable('set_params',{ url: url,template:template});
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
    