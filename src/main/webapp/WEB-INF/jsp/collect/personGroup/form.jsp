<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<link href="${ctx}/assets/css/formCss.css" rel="stylesheet">
<div class="modal-content">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title" id="myModalLabel">人员列表关联</h4>
  </div>
  <div class="modal-body">

    <!-- 数据元 表单项 -->
    <form id="personGropForm" class="form-horizontal" action="${ctx}/collect/personGroup" method="post">
      <div class="form-group">
        <c:if test="${personGroup.id != null}">
          <input type="hidden" name="id" value="${personGroup.id}"/>
        </c:if>
        <input type="hidden" name="gropInfo[id]" value="${ctgId}">
        <!-- 分类id -->
        <label for="dataCollectPerson" class="col-sm-2 control-label">人员列表</label>
        <div class="col-sm-3">
          <select class="form-control" id="dataCollectPerson" name="dataCollectPerson[id]" required>
            <c:forEach items="${dataCollectPersonList}" var ="person">
          		<option value="${person.id}" data-nameEN="${person.alias}" <c:if test="${person.id == personGroup.dataCollectPerson.id}">selected</c:if>>${person.alias}</option>
            </c:forEach>
          </select> 
        </div>  
       </div> 
    </form>
  </div>
  <div class="modal-footer">
    <button type="button" class="btn btn-success btn-white btn-round" onclick="$('#personGropForm').submit()"> <i class="ace-icon fa fa-floppy-o bigger-125"></i>保存</button>
    <button type="button" class="btn btn-danger btn-white btn-round" data-dismiss="modal"><i class="ace-icon fa fa-times bigger-125"></i>关闭</button>
  </div>
</div>