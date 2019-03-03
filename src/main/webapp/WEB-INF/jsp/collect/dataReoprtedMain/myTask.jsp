<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>我的任务</title>
</head>
<body>
	<div class="row" style="background: #fff;">
		<div class="left_content" style="width: 830px; float: left;">
			<!-- <div class="" id="search_content"
				style="height: 60px; border-bottom: 0px solid green;">

			</div> -->
			<div id="task_content" style="margin-top: 10px;">
				<header>
					<div id="fdw-pricing-table">
						<div class="container-fluid" style="width:780px">
							<div class="row">
						      <div class="widget-box">
						      	<table class="zebra" style="width: 100%;border-bottom:none;">
    									<thead>
    										<tr>
    											<th style="border-bottom:none" align="center"><div style="width:100%;text-align:center;">任务列表</div></th>
    										</tr>
    									</thead>
    								</table>
									  <table class="table table-striped table-bordered table-hover js-table fix-table" style="width: 100%" id="takMainTable">
								        <thead>
								          <tr>
								           <th class="text-center" style="width: 300px;">任务名</th>
								           <th class="text-center" style="width: 100px;">期数</th>
								           <th class="text-center" style="width: 100px;text-align: center;">执行类型</th>
 								           <th class="text-center" style="width: 80px;" >状态</th>
								           <th class="text-center" style="width: 80px;">填报</th>
								           <th class="text-center hide" style="width: 30px;" >code</th>
								          </tr>
								         </thead>
								        <tbody>
								        </tbody>
								    </table>
								    <table class="zebra" style="width: 100%;border-bottom:none;margin-top:30px;">
    									<thead>
    										<tr>
    											<th style="border-bottom:none" align="center"><div style="width:100%;text-align:center;color:red;">未按时上报任务列表</div></th>
    										</tr>
    									</thead>
    								</table>
								    <table class="table table-striped table-bordered table-hover js-table fix-table" style="width: 100%" id="unTable">
								        <thead>
								          <tr>
								           <th class="text-center" style="width: 300px;">任务名</th>
								           <th class="text-center" style="width: 100px;">期数</th>
								           <th class="text-center" style="width: 100px;text-align: center;">执行类型</th>
								           <th class="text-center" style="width: 80px;" >状态</th>
								           <th class="text-center" style="width: 80px;">填报</th>
								           <th class="text-center hide" style="width: 30px;" >code</th>
								          </tr>
								         </thead>
								        <tbody>
								        </tbody>
								    </table>
						      </div>
							</div>
						  </div>
					</div>
				</header>
			</div>
		</div>
		<div class="right_content"
			style="background:; width: 340px; float: left; height: 100%">
			<div id="message_content" style="margin-top: 10px; background: ;">
				<table class="zebra" style="width: 100%">
							<thead>
								<tr>
									<th>我的信息</th>
								</tr>
							</thead>
							<tr>
								<td>任务到期提醒，您有${total}个任务填报中！</td>
							</table>
				</div>
			</div>
		</div>
		<script src="${ctx}/assets/jquery/ui/jquery-ui.custom.min.js"></script>
		<script src="${ctx}/assets/jquery/plugins/jquery-form/jquery-form.min.js"></script>
		<script src="${ctx}/assets/jquery/plugins/validation/jquery.validate.min.js"></script>
		<script src="${ctx}/assets/jquery/plugins/validation/localization/messages_zh.min.js"></script>
		<script src="${ctx}/assets/bootstrap/plugins/date-time/bootstrap-datepicker.min.js"></script>
		<script src="${ctx}/assets/bootstrap/plugins/date-time/locales/bootstrap-datepicker.zh-CN.js"></script>
		<script src="${ctx}/assets/bootstrap/plugins/bootbox/bootbox.min.js"></script>
		<script src="${ctx}/assets/jquery/plugins/jqGrid/js/jquery.jqGrid.min.js"></script>
		<script src="${ctx}/assets/jquery/plugins/jqGrid/js/i18n/grid.locale-cn.js"></script>
		<script src="${ctx}/assets/jquery/plugins/lixi_common/ajax_render.js"></script>
		<script src="${ctx}/assets/jquery/plugins/lixi_common/jquery.serialize-object.min.js"></script>
		<script src="${ctx}/assets/jquery/plugins/toast/jquery.toaster.js"></script>
		<script src="${ctx}/assets/jquery/plugins/lixi_common/utils.js"></script>
		<script src="${ctx}/assets/jquery/plugins/jstree/jstree.min.js"></script>
		<script src="${ctx}/assets/jquery/plugins/lixi_common/js-table.js"></script>
		<script src="${ctx}/assets/js/agrims.js"></script>
		<script>

  		function viewTaskMain(id) {
  			reloadTaskDetailPage(id);
  		}
		
  		function ajaxRenderTable(url, template){
  	     $('#takMainTable').jstable('set_params',{ url: url,template:template});
  	  }

      function ajaxRenderTable2(url, template){
         $('#unTable').jstable('set_params',{ url: url,template:template});
      }

      function reloadTakMainTable(){
          ajaxRenderTable('${ctx}/collect/dataReoprtedMain/myTask/list',genRowTemplate());
            //清空takDetailTable表
          $('#taskDetailTable').data('tmId', null);
          $('#dcpContainer').html('');
      }

      function reloadunTable2(){
      ajaxRenderTable2('${ctx}/collect/dataReoprtedMain/myunTask/list',rowTemplate());
         //清空takDetailTable表
        $('#unTable').data('tmId', null);
        $('#dcpContainer').html('');
      }
		
        function genRowTemplate(node) {
          var tamplate = '<tr id="{id}" class="data-row">' +
                           '\
                            <td title="{taskName}" class="row-select"style=";cursor: pointer;">{taskName}</td>\
                            <td title="{period}">{period}</td>\
                            <td title="{executeType}" style="text-align: center;"> {executeType}</td>\
                            <td title="{reportedStatus}" style="text-align: center;"><span class="btn btn-xs btn-primary">{reportedStatus}</span></td>\
                            <td class="viewTaskMain" title="填报" onclick="viewTaskMain(' + '\'{id}\'' + ')" style="text-align: center;cursor: pointer;" >\
                            <a class="blue" name="view"><i class="glyphicon glyphicon-edit"></i></a>\
                            <td  title="{editable}" class="editable hide">{editable}</td>\
                            </td>\
                          </tr>';
          return tamplate;
        }
        
        /* 表2-开始 */
        function rowTemplate(node) {
           var tamplate = '<tr id="{id}" class="data-row">' +
                            '\
                             <td title="{taskName}" class="row-select"style=";cursor: pointer;">{taskName}</td>\
                             <td title="{period}">{period}</td>\
                             <td title="{executeType}" style="text-align: center;"> {executeType}</td>\
                             <td title="{reportedStatus}" style="text-align: center;"><span class="btn btn-xs btn-primary">{reportedStatus}</span></td>\
                             <td class="viewTaskMain" title="填报" onclick="viewTaskMain(' + '\'{id}\'' + ')" style="text-align: center;cursor: pointer;" >\
                             <a class="blue" name="view"><i class="glyphicon glyphicon-edit"></i></a>\
                             <td  title="{editable}" class="editable hide">{editable}</td>\
                             </td>\
                           </tr>';
           return tamplate;
         }

			$(function() {
				$("[data-toggle='tooltip']").tooltip({
					html : true
				});
				
				$('#takMainTable').jstable({pager:true,template:genRowTemplate()});
      	        reloadTakMainTable();
      	        
      	  		$('#unTable').jstable({pager:true,template:rowTemplate()});
	   		 	reloadunTable2();
			});
			
			$('.taskEditBtn').on('click',  function() {
				var tm_set = $(this);
				reloadTaskDetailPage(tm_set.attr('id'));
			});
			
			function reloadTaskDetailPage(dmId) {
				var url = '${ctx}/main#page/collect/dataReoprtedDetail/manager?dmId=' + dmId;
				loadPage(url);
			}
			
			$('#taskDetailTable').on('finish.table.jstable', function () {
				 //checkEditable()
	    })
	           
		    function checkEditable() {
				var t=$('#takMainTable');
				var tb=t.children("tbody");
				tb.children("tr").each(function(){
				var edit=$(this).find(".editable").first().text();
				if(edit!=1){
					$(this).find(".viewTaskMain").first().attr("disabled","true");
				}
			  });
			}
		</script>
	</body>
</html>