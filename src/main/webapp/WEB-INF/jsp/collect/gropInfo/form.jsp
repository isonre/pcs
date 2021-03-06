<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<link href="${ctx}/assets/css/formCss.css" rel="stylesheet">
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<div class="modal-content">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title" id="myModalLabel">分组新增/编辑</h4>
  </div>
  <div class="modal-body">

    <!-- 数据元 表单项 -->
    <form id="gropInfoForm" class="form-horizontal" action="${ctx}/collect/gropInfo" method="post">
      <div class="form-group">
        <c:if test="${gropInfo.id != null}">
          <input type="hidden" name="id" value="${gropInfo.id}"/>
        </c:if>
        <label for="name" class="col-sm-2 control-label"><span style="color:red;"> * </span>名称</label>
        <div class="col-sm-3">
          <input type="text" class="form-control" id="name" name="name" value="${gropInfo.name}">
        </div>
      </div>
      <div class="form-group">
        <label for="state" class="col-sm-2 control-label">状态</label>
        <div class="col-sm-3">
          <select name="state" id="state" class="form-control">
            <option value="1" <c:if test="${gropInfo.state == 1}">selected</c:if>>启用</option>
            <option value="0" <c:if test="${gropInfo.state == 0}">selected</c:if>>停用</option>
          </select>
        </div>
      </div>   
      <div class="form-group">
        <label for="description" class="col-sm-2 control-label">描述</label>
        <div class="col-sm-8">
          <textarea name="explain" id="explain" class="form-control" rows="6" maxLength="100">${gropInfo.explain}</textarea>
        </div>
      </div> 
    </form>
  </div>
  <div class="modal-footer">
  <div class="form-group">
    <button type="button" class="btn btn-success btn-white btn-round" onclick="$('#gropInfoForm').submit()"> <i class="ace-icon fa fa-floppy-o bigger-125"></i>保存</button>
    <button type="button" class="btn btn-danger btn-white btn-round" data-dismiss="modal"><i class="ace-icon fa fa-times bigger-125"></i>关闭</button>
  </div>
  </div>
</div>
<script>
</script>