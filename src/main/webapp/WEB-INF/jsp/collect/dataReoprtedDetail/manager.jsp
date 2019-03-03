<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<link href="${ctx}/assets/css/mgr-common.css" rel="stylesheet">
<div class="container-fluid">
	<div class="row">
		<div class="col-xs-12" >
			 <div class="btn-group btn-group-sm" style="margin-top: 10px;margin-bottom: 10px;width:100%">
			 	<c:choose>
			 		<c:when test="${reportedStatus == 0}">
			 			<h5 style="float:right;">任务状态：<span style="color:#21C2E0">填报中</span></h5>
			 			<button type="button" class="btn btn-warning" onclick="detailForm();">保存数据</button>
						<button type="button" class="btn btn-success" name="reportedData" onclick="reportedData();">上报数据</button>
					</c:when>
			 		<c:when test="${reportedStatus == 1}"><h5 style="float:right;">任务状态：<span style="color:#ec971f;">已上报，等待审核中</span></h5></c:when>
			 		<c:when test="${reportedStatus == 2}"><h5 style="float:right;">任务状态：<span style="color:#1CB177;">审核通过</span></h5></c:when>
			 		<c:otherwise>
			 			<h5 style="float:right;">任务状态：<span style="color:#D32828">已驳回，请重新填报</span></h5>
						<button type="button" class="btn btn-warning" onclick="detailForm();">保存数据</button>
						<button type="button" class="btn btn-success" name="reportedData" onclick="reportedData();">上报数据</button>
			 		</c:otherwise>
			 	</c:choose>
			 </div>
		</div>

		<!-- right -->
		<div class="col-xs-12" >
			<table class="table table-bordered"id="table">
			  <thead>	
				  <tr>
					  <th class="text-center" style="width: 200px;">农产品</th>
					  <th class="text-center" style="width: 200px;">指标</th>
					  <th class="text-center" style="width: 200px;">指标值</th>
					  <th class="text-center" style="width: 100px">是否必填</th>
					  <th class="text-center" style="width: 200">备注</th>
					  <th class="text-center hide" style="width: 30px;" >code</th>
				  </tr>
			   </thead>
			   <tbody>
				   <c:forEach var="detailItem" items="${detailList}">
				      <tr id="${detailItem.id}" class="detail-row"><td class="text-center">${detailItem.taskDetail.agrProCategory2.name}</td>
				      	  <td class="text-center">${detailItem.dataName}</td>
				      	  <td class="text-center"><input class="indexValue" style="width:150px;" type="text" id="data" name="data" value="${detailItem.data}"
				      	  	  <c:if test="${reportedStatus == 1 || reportedStatus == 2}">disabled</c:if>/>
				      	  </td>
				      	  <td class="text-center">
					      	  <c:if test="${detailItem.taskDetail.nullable ==1 }"><lable class="text-success">是</lable></c:if>
					      	  <c:if test="${detailItem.taskDetail.nullable ==2 }"><lable class="text-warning">否</lable></c:if>
					      </td> 
					      <td class="text-center">${detailItem.remark}</td>
				      </tr>
				   </c:forEach>
			    </tbody>
		    </table>
		</div>
	</div>
</div>
<script src="${ctx}/assets/jquery/plugins/jstree/jstree.min.js"></script>
<script src="${ctx}/assets/jquery/plugins/lixi_common/js-table.js"></script>
<script src="${ctx}/assets/jquery/plugins/lixi_common/ajax_render.js"></script>
<script src="${ctx}/assets/jquery/plugins/lixi_common/utils.js"></script>
<script src="${ctx}/assets/bootstrap/plugins/bootbox/bootbox.min.js"></script>
<script>

	$(document).ready(function() {
		hebing(0);
		hebing(4);
	});
	
	$("input.indexValue").change(function(){
		if(isNaN($('input.indexValue').val()))
			{
				alert('请不要输入除数字和小数点外的任何字符');
				$(this).val('0');
			}
	}) 
	
	//合并相同的品种
	function hebing(cellNum) {
		var rows = $("#table")[0].rows;
		for(var i = 1;i < rows.length;i++) {
			var count = 1;
			for(var j = i+1;j < rows.length;j++) {
				if(rows[i].cells[cellNum].innerHTML == rows[j].cells[cellNum].innerHTML) {
					count++;
					rows[j].cells[cellNum].style.display = "none";
				}
			}
			rows[i].cells[cellNum].rowSpan = count;
			i += (count-1);
		}
	}

    function getDcpSelectedRowsId(node) {
		return $('tbody .detail-row').map(function() {
			return $(this).prop('id');
		});
	}
	
	function getDcpSelectedRowsData(node) {
		return $('tbody .detail-row input').map(function() {
			return $(this).prop('value');
		});
	}

	function detailForm() {
		var ids = getDcpSelectedRowsId();
		var datas = getDcpSelectedRowsData();
		var params = new Array();
		
		for(var i =0;i<ids.length;i++){
			params.push({
            	id: ids[i],
            	data:  datas[i]
			 });
		}
		
		 var str_json = JSON.stringify(params);
		 console.log(str_json);
   
		bootbox.confirm('确定要保存吗?', function(result) {
			if (result) {
				
/*  				idParams = ids.map(function(index, id) {
					return 'id=' + id;
				}).toArray().join('&');

				dataParams = datas.map(function(index, data) {
					return 'data=' + data;
				}).toArray().join('&'); 

				var url = '${ctx}/collect/dataReoprtedDetail?' + idParams + '&'
						+ dataParams; */
				
/* 				$.post(url, function(result) {
					if (result.status) {
						$.toaster({
							title : '成功',
							priority : 'success',
							message : result.message
						});
						location.reload(); 
					} else {
						$.toaster({
							title : '失败',
							priority : 'warning',
							message : result.message
						});
					}
				}); */
				
	            $.ajax({
	                url: '${ctx}/collect/dataReoprtedDetail',
	                type: 'POST',
	                data: {'data':str_json},
	                dataType: 'json',
	                success: function (data) {
	                	$.toaster({
							title : '成功',
							priority : 'success',
							message : result.message
						});
	                	alert("保存成功 !")
						location.reload();
	                },
	                error: function (xhr) {
	                	$.toaster({
							title : '失败',
							priority : 'warning',
							message : result.message
						});
	                }
	            });
				
			}
		});

	}
	
	function reportedData(){
		
		bootbox.confirm('确定要上报吗?', function(result) {
			if (result) {
				var url = '${ctx}/collect/dataReoprtedMain/reoprted?dmId=${dmId}';
				
				$.get(url, function(result) {
					if (result.status) {
						$.toaster({
							title : '成功',
							priority : 'success',
							message : result.message
						});
						location.reload(); 
					} else {
						$.toaster({
							title : '失败',
							priority : 'warning',
							message : result.message
						});
					}
				});
			}
			});
	}
</script>
