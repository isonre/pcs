<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<link href="${ctx}/assets/css/formCss.css" rel="stylesheet">
<link rel="stylesheet" href="${ctx}/assets/bootstrap-multiselect/css/bootstrap-multiselect.css" type="text/css"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<style>
.multiselect{
background-color: #82af6f!important;
border-color: #82af6f;
}
.btn:hover, .btn-default:hover, 
.btn:active, .btn-default:active, 
.open>.btn.dropdown-toggle,
 .open>.btn-default.dropdown-toggle{
background-color: #82af6f!important;
border-color: #82af6f;
}
</style>

<script>
  $(document).ready(function() {
//     $('#dataIDs').multiselect();
    });

  function goSubmit() {
    
	 if($("#agrProCategory2").val() == '') {
		  alert('农产品不能为空！');
		  return false;
	  }

	  
	//把多个指标的id用逗号隔开
    var dataIDsOb = $("#dataIDs")[0];
    var dataID = "";
    for(var i = 0;i < dataIDsOb.options.length;i++) {
      if(dataIDsOb.options[i].selected) {
        dataID += dataIDsOb.options[i].value + ",";
      }
    }
    if(dataID != '') {
      dataID = dataID.substring(0,dataID.length-1);
    }
    $("#dataID").val(dataID);
    
    if(dataID == "") {
    	alert('采集指标不能为空！');
		return false;
    }
    
    if($("#timeframe").val() == '') {
    	alert('填报月份不能为空！');
		return false;
    }
    var array = $("#timeframe").val().split(",");
    for(var i = 0;i < array.length;i++) {
    	if(array[i] == '' || isNaN(array[i]) || parseInt(array[i]) < 1 || parseInt(array[i]) > 12) {
        	alert('填报月份格式错误！');
    		return false;
    	}
    }
    
    $.ajax({
    	url:"${ctx}/collect/agrProCtg/checkLevel",
    	data:{'id':$("#agrProCategory2").val()},
    	dataType:"json",
    	success:function(data){
    		if(data.status) {
				if(data.data) {
	    		    $('#taskDetailForm').submit();
				} else {
					alert('请选择最底层农产品！');
		    		return false;
				}
    		}
    	}
    });
    	
  }

</script>
<div class="modal-content">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title" id="myModalLabel">任务细表 新增/编辑</h4>
  </div>
  <div class="modal-body">

    <!-- 数据元 表单项 -->
    <form id="taskDetailForm" class="form-horizontal" action="${ctx}/collect/taskDetail" method="post">
      <div class="form-group">
        <c:if test="${taskDetail.id != null}">
          <input type="hidden" name="id" value="${taskDetail.id}"/>
        </c:if>
        <!-- 分类id -->
        <input type="hidden" name="taskMain[id]" value="${tmId}">
        <label for="agrProReport" class="col-sm-2 control-label"><span style="color:red;"> * </span>农产品</label>
        <div class="col-sm-8">
          <input type="hidden" id="agrProCategory2" name="agrProCategory2[id]"  value="${apcId}">
          <div type="text" class="form-control def-cur" id="parentName" autocomplete="off">${apcName}</div>
          <span class="glyphicon glyphicon-chevron-down form-control-feedback" aria-hidden="true" style="right: 15px;"></span>
          <div id="bdctg_tree" class="hide float-menu col-sm-8" style="width: 95%;"></div>
        </div>
      </div>
      <div class="form-group">
        <label for="dataID" class="col-sm-2 control-label"><span style="color:red;"> * </span>采集指标</label>
        <div class="col-sm-4">
          <input type="hidden" name="dataID" id="dataID"/>
          <select id="dataIDs" class="form-control" multiple="multiple" style="height:230px">
            <c:forEach var="dataCollectIndexItem" items="${dataCollectIndexList}">
              <option value="${dataCollectIndexItem.indexCode}" <c:if test="${dataCollectIndexItem.selected == true}">selected</c:if>>${dataCollectIndexItem.indexName}</option>
            </c:forEach>
          </select>
        </div>
      </div> 
      <div class="form-group">
        <label for="timeframe" class="col-sm-2 control-label"><span style="color:red;"> * </span>填报的月份</label>
        <div class="col-sm-4">
          <input type="text" class="form-control" id="timeframe" name="timeframe" value="${taskDetail.timeframe }">
        </div>
        <label  class="col-sm-4 control-label" style="text-align: left;color: #FA7878;">用逗号隔开，如：2,3,7,8,9</label>
      </div>
       <div class="form-group">
        <label for="nullable" class="col-sm-2 control-label">是否必填</label>
        <div class="col-sm-3">
          <select name="nullable" id="nullable" class="form-control">
            <option value="1" <c:if test="${taskDetail.nullable == 1}">selected</c:if>>必填</option>
            <option value="2" <c:if test="${taskDetail.nullable == 2}">selected</c:if>>选填</option>
          </select>
        </div>
      </div>  
      <div class="form-group">
        <label for="remark" class="col-sm-2 control-label">备注</label>
        <div class="col-sm-8">
          <textarea name="remark" id="remark" class="form-control" rows="6" maxLength="500">${taskDetail.remark}</textarea>
        </div>
      </div>
    </form>
  </div>
  <div class="modal-footer">
    <div class="form-group">
      <button type="button" class="btn btn-success btn-white btn-round" onclick="goSubmit()"><i class="ace-icon fa fa-floppy-o bigger-125"></i>保存</button>
      <button type="button" class="btn btn-danger btn-white btn-round" data-dismiss="modal"><i class="ace-icon fa fa-times bigger-125"></i>关闭</button>
    </div>
  </div>
</div>