<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>

    <style>
      .float-menu{
        max-height: 400px;
        overflow-y: scroll;
        position: absolute;
        top: 100%;
        /* left: 0; */
        z-index: 1000;
        float: left;
        min-width: 160px;
        padding: 5px 0;
        margin: 2px 0 0;
        font-size: 14px;
        text-align: left;
        list-style: none;
        background-color: #fff;
        background-clip: padding-box;
        border: 1px solid rgba(0,0,0,.15);
        border-radius: 4px;
        box-shadow: 0 6px 12px rgba(0,0,0,.175);
      }
      #newTopCtg{
        margin-bottom: 10px;
      }
      .def-cur{
        cursor: default;
      }
      .tree-toggle{
        cursor:pointer;
      }
      .tree-toggle-open{
        transform:rotate(45deg);
        -ms-transform:rotate(45deg);   /* IE 9 */
        -moz-transform:rotate(45deg);  /* Firefox */
        -webkit-transform:rotate(45deg); /* Safari 和 Chrome */
        -o-transform:rotate(45deg);  /* Opera */
      }
      .leaf .tree-toggle{
        display: none;
      }
    </style>
    
    <!-- add and edit modal -->
    <div class="modal fade" id="addOrEditDialog" tabindex="-1" role="dialog" aria-labelledby="农产品分类编辑" data-backdrop="static">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <!-- content -->
        </div>
      </div>
    </div>

    <div class="toolbar container-fluid">
    <div class="widget-box transparent ui-sortable-handle">
	  <div class="widget-header" style="margin-left:-15px;">
	    <h4 class="widget-title lighter">农产品管理</h4>
	
	    <div class="widget-toolbar no-border">
	      <button id="newTopCtg" class="btn btn-white btn-success btn-sm btn-round" style="line-height: 20px;"><i class="ace-icon fa fa-plus bigger-100 green"></i>创建顶级分类</button>
	    </div>
	  </div>
	  
	</div>
      <div class="search-bar row" style="width: 400px;float: left;">
        <form class="form-inline" id="searchForm" action="${ctx}/collect/agrProCtg" method="get">
          <div class="form-group">
            <label for="name">名称:&nbsp;&nbsp;</label>
            <input type="text" class="form-control" name="name">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button  type="submit" class="btn btn-info btn-white btn-round">查询</button>
          </div>
        </form>
      </div>

    </div>

	<div class="fix-table-container">
    <table class="table table-striped table-bordered table-hover js-tree-table fix-table" id="ctgTable">
      <thead>
        <tr>
          <th class="text-center" style="width: 40px;">排序</th>
          <th class="text-center" style="width: 350px;">名称</th>
          <th class="text-center" style="width: 120px;">编码</th>
          <th class="text-center" style="width: 50px;">状态</th>
          <th class="text-center" style="width: 250px;">说明</th>
          <th class="text-center" style="width: 80px;">添加子分类</th>
          <th class="text-center" style="width: 70px;">编辑</th>
          <th class="text-center" style="width: 70px;">删除</th>
        </tr>
      </thead>
      <tbody>
        <tr class="tree-node root-node" id="0" style="display:none;" data-hierarchy="0">
      </tbody>
    </table>
    </div>

    <script>
    
    var scripts = [
          			null,
          			"${ctx}/assets/jquery/plugins/validation/jquery.validate.min.js",
          			"${ctx}/assets/jquery/plugins/validation/localization/messages_zh.min.js",
          			"${ctx}/assets/bootstrap/plugins/bootbox/bootbox.min.js",
          			"${ctx}/assets/jquery/plugins/lixi_common/utils.js",
          			"${ctx}/assets/jquery/plugins/lixi_common/ajax_render.js",
          			"${ctx}/assets/jquery/plugins/lixi_common/jquery.serialize-object.min.js",
          			"${ctx}/assets/jquery/plugins/toast/jquery.toaster.js",
          			"${ctx}/assets/jquery/plugins/jqGrid/js/i18n/grid.locale-cn.js",
          			"${ctx}/assets/jquery/plugins/lixi_common/ajax_render.js",
          			"${ctx}/assets/jquery/plugins/lixi_common/jquery.serialize-object.min.js",
          			"${ctx}/assets/jquery/plugins/toast/jquery.toaster.js",
          			"${ctx}/assets/jquery/plugins/jquery-form/jquery-form.min.js",
          			"${ctx}/assets/jquery/plugins/jstree/jstree.min.js", null ]
    
   	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
   		jQuery(function($) {
   	        //init ajax form 
   	        $("#searchForm").ajaxForm({
   	          success : function(data) {  
   	            clearTable();
   	            renderTable(data, genSearchNodeTemplate());
   	          },
   	          dataType : 'json',
   	        });

   	        $('#newTopCtg').click(function (){
   	          showModal('${ctx}/collect/agrProCtg/view/new?pid=0', editFormInit);
   	        });

   	        //tree action new
   	        $('.js-tree-table').on('click', 'a[name="new-child"]', function () {
   	          var _this = $(this);
   	          var node = _this.parents('.tree-node');
   	          var url = '${ctx}/collect/agrProCtg/view/new?pid=' + node.attr('id');
   	          showModal(url, editFormInit);
   	        });

   	        $('.js-tree-table').on('click', 'a[name="edit"]', function () {
   	          var _this = $(this);
   	          var node = _this.parents('.tree-node');
   	          var url = '${ctx}/collect/agrProCtg/view/edit?id=' + node.attr('id');
   	          showModal(url, editFormInit);
   	        });

   	        $('.js-tree-table').on('click', 'a[name="del"]', function () {
   	          var _this = $(this);
   	          var node = _this.parents('.tree-node');
   	          bootbox.confirm('将会删除分类及分类下的所有数据,确定要删除吗?',function (result) {
   	            if(result) {  
   	              var node_id = node.attr('id');
   	              var url = '${ctx}/collect/agrProCtg/' + node_id +'?del';
   	              $.post(url, {id: node_id}, function (result){
   	                if(result.status){
   	                  $.toaster({ title : '成功', priority : 'success', message : result.message });
   	                  removeNode(node);
   	                }else{
   	                  $.toaster({ title : '失败', priority : 'warning', message : result.message });
   	                }
   	              }); 
   	            } 
   	          });
   	        });

   	        //tree table init
   	        loadNode($('.root-node'), getDataUrl($('.root-node')));
   			
   			});
   	 });
    
	  $(document).ready(function () {
	
	  });
      
      //new action
      function showModal(url, callback){
        $.get(url, function (data){
          var modal = $('#addOrEditDialog');
          var modal_content =  modal.find('.modal-content');
          modal_content.html(data);
          callback();
          modal.modal('show');
        });
      }

      function editFormInit () {
        var form = $('#basicDataCtgEditForm');
        form.validate({ 
          rules : {
            name : {
              required : true
            },
            code:{
              required : true
            },
            sort: {
              digits : true
            },
            explain : {
              maxlength : 500
            }
          },
          errorClass: 'text-warning',
          errorPlacement: function(error, element) {
            error.insertAfter(element.parent());
          },
          submitHandler: function (form) {
            ajaxFormSubmit(form, function(data, status) {
              if(data.data) {
                var pnode = getNode('#'+data.extra.pid);
                //新增 冗余操作 获得处理一致性
                //编辑 清楚页面内数据
                removeNode(getNode('#'+data.data.id));
                //$('.js-tree-table').find('#'+data.data.id).remove();

                //genNode
                pnode.find('.tree-toggle').addClass('tree-toggle-open');
                reloadNode(pnode);
                $.toaster({ title : '成功', priority : 'success', message : data.message });
                $(form).parents('.modal').modal('hide');
              }else {
                $.toaster({ title : '失败', priority : 'warning', message : data.message });
              }
            });
          }
        });

        //jstree init
        $('div#parentName').click(function(){
          var _this = $(this);
          var jstree = $('#bdctg_tree');
          if (!jstree.data('loaded')) {
            $('#bdctg_tree').jstree({
              'core' : {
                'dblclick_toggle':false,
                'check_callback' : true, 
                'multiple' : false,
                'data' : {
                  'url' : function (node) {
                    return '${ctx}/collect/agrProCtgsTreeNode/all';
                  },
                  'data' : function (node) {
                    return { 'pid' : node.id == '#' ? 0 : node.id};
                  }
                }
              }
            }).on('select_node.jstree', function (e, data) {
              var selectedNode =  data.instance.get_node(data.selected[0]);
              $('div#parentName').text(selectedNode.text);
              $('input#pid').val(selectedNode.id);
              $('#bdctg_tree').addClass('hide');
            }).on('loaded.jstree', function () {
              var _jstree = $('#bdctg_tree').jstree(true);
              _jstree.create_node('#', {'id':'0', 'text':'作为顶级分类'}, 'first');
              var cur_id = $('#basicDataCtgEditForm input[name="id"]').val();
              var children_node = _jstree.get_node('#').children;
              for(var i = 0; i < children_node.length; i++){ 
                if(cur_id == children_node[i]){ 
                  _jstree.disable_node(_jstree.get_node(cur_id));
                  $(this).find('#'+cur_id).removeClass('jstree-closed').addClass('jstree-leaf');
                } 
              }
            }).on('after_open.jstree',function (e, data){
              var _jstree = data.instance;
              var cur_id = $('#basicDataCtgEditForm input[name="id"]').val();
              var children_node = data.node.children;
              for(var i = 0; i < children_node.length; i++){ 
                if(cur_id == children_node[i]){ 
                  _jstree.disable_node(_jstree.get_node(cur_id));
                  $(this).find('#'+cur_id).removeClass('jstree-closed').addClass('jstree-leaf');
                } 
              }
            });
            jstree.data('loaded', true);
          }
          jstree.toggleClass('hide');
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
          //clearForm: true        // clear all form fields after successful submit 
          //resetForm: true        // reset the form after successful submit 

          // $.ajax options can be used here too, for example: 
          //timeout:   3000 
        };
        $.ajax(cfg);
      }

      //js tree table
        // tree-toggle
        $('.js-tree-table').on('click', '.tree-toggle', function () {
          var _this = $(this);
          var node = _this.parents('.tree-node');
          _this.toggleClass('tree-toggle-open');
          if (_this.hasClass("tree-toggle-open")) {
            //opne show or load
            nodeToggleOn(node);
          } else{
            //close just hide
            nodeToggleOff(node);
          };
        });

        //show node's children
        function nodeToggleOn(node){
          var children = getChildren(node);
          if (children.length > 0) {
            children.toggle(true);
            children.each(function (){
              var _this = $(this);
              if (_this.find('.tree-toggle').hasClass("tree-toggle-open")) {
                nodeToggleOn(_this);
              };
            });
          } else {
            //load children
            loadNode(node, getDataUrl(node));
          } ;
        }

        //hide node's children
        function nodeToggleOff(node){
         var children = getChildren(node);
         if (children.length > 0) {
          children.toggle(false);
          children.each(function (){
            var _this = $(this);
            if (_this.find('.tree-toggle').hasClass("tree-toggle-open")) {
              nodeToggleOff(_this);
            };
          });
         };
        }

        function genNodeTemplate(node) {
          var hierarchy = node.data('hierarchy');
          var next_hierarchy = hierarchy+1;
          var space = new Array(next_hierarchy*3+3).join('&nbsp;');
          var tamplate = '<tr id="{id}" class="tree-node children-node {nodeType}" data-hierarchy="' + next_hierarchy + '" data-parent="'+ node.attr('id') +'">' +
                            '<td>{sort}</td>\
                            <td scope="row" title="{name}">'+ space +'<span class="glyphicon glyphicon-triangle-right tree-toggle"></span>{name}</td>\
                            <td>{code}</td>\
                            <td>{state}</td>\
                            <td title="{explain}">{explain}</td>\
                            <td style="text-align: center;cursor: pointer;" >\
                            <div class="btn-group" role="group" aria-label="添加子分类">\
                            <a class="blue" name="new-child"><i class="ace-icon fa fa-list bigger-140"></i></a>\
                            </div></td>\
                            <td style="text-align: center;cursor: pointer;" >\
                            <div class="btn-group" role="group" aria-label="编辑">\
                            <a class="green" name="edit"><i class="ace-icon fa fa-pencil-square-o bigger-140"></i></a>\
                            </div></td>\
                            <td style="text-align: center;cursor: pointer;" >\
                            <div class="btn-group" role="group" aria-label="删除">\
                            <a class="red" name="del"><i class="ace-icon fa fa-times bigger-140"></i></a>\
                            </div></td>\
                          </tr>';
          return tamplate;
        }

        function genSearchNodeTemplate() {
          //var hierarchy = node.data('hierarchy');
          var next_hierarchy = 1;
          var space = new Array(next_hierarchy*3+3).join('&nbsp;');
          var tamplate = '<tr id="{id}" class="tree-node children-node {nodeType}" data-hierarchy="' + next_hierarchy + '" data-parent="{pid}">' +
                            '<td>{sort}</td>\
                            <td scope="row" tittle="{name}">'+ space +'<span class="glyphicon glyphicon-triangle-right tree-toggle"></span>{name}</td>\
                            <td>{code}</td>\
                            <td>{state}</td>\
                            <td title="{explain}">{explain}</td>\
                            <td style="text-align: center;cursor: pointer;" >\
                            <div class="btn-group" role="group" aria-label="添加子分类">\
                            <a class="blue" name="new-child"><i class="ace-icon fa fa-list bigger-140"></i></a>\
                            </div></td>\
                            <td style="text-align: center;cursor: pointer;" >\
                            <div class="btn-group" role="group" aria-label="编辑">\
                            <a class="green" name="edit"><i class="ace-icon fa fa-pencil-square-o bigger-150"></i></a>\
                            </div></td>\
                            <td style="text-align: center;cursor: pointer;" >\
                            <div class="btn-group" role="group" aria-label="删除">\
                            <a class="red" name="del"><i class="ace-icon fa fa-times bigger-150"></i></a>\
                            </div></td>\
                          </tr>';
          return tamplate;
        }

        function renderTable(data, template){
          $('.js-tree-table .root-node').json_render(data, template);
        }

        function loadNode(node, dataUrl){
          if (node.length <= 0) {
            return;
          };
          node.ajax_render({
                            ajax:{url: dataUrl},
                            template: genNodeTemplate(node),
                            finish: checkNodeType
                          });
        };

        function checkNodeType(node) {
          if(getChildren(node).length > 0){
            node.removeClass('leaf').addClass('node');
          }else{
            node.addClass('leaf').removeClass('node');
          }
        }
        function reloadNode (node, data) {
          // body...
          // var template = genNodeTemplate(node);
          if (node.length <= 0) {
            return;
          };
          removeChildrens(node);
          loadNode(node, getDataUrl(node));
        }

        function removeChildrens(node) {
          $(getChildrens(node)).remove();
        }

        //移除节点及其所有子孙节点
        function removeNode(node){
          removeChildrens(node);
          node.remove();
          checkNodeType($('#'+node.data('parent')));
        }

        function getChildren (node) {
          return node.nextAll('[data-parent="'+ node.attr('id') +'"]');
        }

        function getChildrens (node) {
          var children = getChildren(node);
          return children.toArray().concat(children.toArray().reduce(function(p, c){
            return p.concat(getChildrens($(c)));
          }, []))
        }

        function clearTable(){
          $('.js-tree-table tbody tr').not('.root-node').remove();
        }

        function getDataUrl(node){
          return '${ctx}/collect/agrProCtg?pid='+node.attr('id');
          
        }

        function getNode (selector) {
          return $('.js-tree-table').find(selector);
        }
    </script>
    <link href="${ctx}/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${ctx}/assets/jquery/plugins/jstree/themes/default/style.min.css" />
    <link href="${ctx}/assets/css/mgr-common.css" rel="stylesheet">
    