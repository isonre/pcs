<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<link href="${ctx}/assets/css/formCss.css" rel="stylesheet">
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<div class="modal-content">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title" id="myModalLabel">任务主表 新增/编辑</h4>
  </div>
  <div class="modal-body">

    <!-- 数据元 表单项 -->
    <form id="taskMainForm" class="form-horizontal" action="${ctx}/collect/taskMain" method="post">
      <div class="form-group">
        <c:if test="${taskMain.id != null}">
          <input type="hidden" name="id" value="${taskMain.id}"/>
        </c:if>
        <label for="name" class="col-sm-2 control-label"><span style="color:red;"> * </span>任务名称</label>
        <div class="col-sm-8">
          <input type="text" class="form-control" id="name" name="name" rows="6" value="${taskMain.name}">
        </div>
        <%-- <label for="code" class="col-sm-2 control-label"><span style="color:red;"> * </span>编号</label>
        <div class="col-sm-3">
          <input type="text" class="form-control" id="code" name="code" value="${taskMain.code}">
        </div> --%>
      </div>
<%--       <div class="form-group">
        <label for="dataCollectPerson" class="col-sm-2 control-label">任务对象</label>
        <div class="col-sm-3">
          <select class="form-control" id="dataCollectCategory" name="dataCollectCategory[id]" required>
            <c:forEach items="${categoryList}" var ="category">
          		<option value="${category.id}" data-nameEN="${category.name}" <c:if test="${category.id == taskMain.dataCollectPerson.dataCollectCategory.id}">selected</c:if>>${category.name}</option>
            </c:forEach>
          </select> 
        
          <select class="form-control" id="dataCollectPerson" name="dataCollectPerson[id]" required>
            <c:forEach items="${categoryList}" var ="category">
          		<option disabled>${category.name}</option>
              <c:forEach items="${pointList}" var ="point">
                <c:if test="${point.dataCollectCategory.id == category.id}">
             	    <option disabled>&nbsp;&nbsp;${point.name}</option>
                  <c:forEach items="${personList}" var ="person">
                    <c:if test="${person.dataCollectPoint.id == point.id}">
                      <option value="${person.id}" data-nameEN="${person.name}" <c:if test="${person.id == taskMain.dataCollectPerson.id}">selected</c:if> >&nbsp;&nbsp;&nbsp;&nbsp;${person.name}</option>
                    </c:if>
                  </c:forEach>
                </c:if>
              </c:forEach>
            </c:forEach>
          </select> 
        </div>
      </div>   --%>
      <div class="form-group">
        <label for="beginDate" class="col-sm-2 control-label"><span style="color:red;"> * </span>开始日期</label>
        <div class="col-sm-3">
          <span style="position: relative; z-index: 9999;">
            <input type="text" class="form-control" id="beginDate" name="beginDate"  data-date-format="yyyy-mm-dd" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${taskMain.beginDate}"/>">
          </span>
        </div>
        <label for="endDate" class="col-sm-2 control-label"><span style="color:red;"> * </span>结束日期</label>
        <div class="col-sm-3">
          <span style="position: relative; z-index: 9999;">
            <input type="text" class="form-control" id="endDate" name="endDate"  data-date-format="yyyy-mm-dd" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${taskMain.endDate}"/>">
          </span>
        </div>
      </div>
      <div class="form-group">
        <label for="executeType" class="col-sm-2 control-label"><span style="color:red;"> * </span>执行类型</label>
        <div class="col-sm-3">
          <select name="executeType" id="executeType" class="form-control">
            <option value="1" <c:if test="${taskMain.executeType == 1}">selected</c:if>>每日执行</option>
            <option value="2" <c:if test="${taskMain.executeType == 2}">selected</c:if>>每周执行</option>
            <option value="3" <c:if test="${taskMain.executeType == 3}">selected</c:if>>每月执行</option>
          </select>
        </div>
        <label for="state" class="col-sm-2 control-label"><span style="color:red;"> * </span>状态</label>
        <div class="col-sm-3">
          <select name="state" id="state" class="form-control">
          <option value="1" <c:if test="${taskMain.state == 1}">selected</c:if>>在用</option>
            <option value="0" <c:if test="${taskMain.state == 0}">selected</c:if>>未启用</option>
            <option value="-1" <c:if test="${taskMain.state == -1}">selected</c:if>>到期</option>
            <option value="-2" <c:if test="${taskMain.state == -2}">selected</c:if>>停用</option>
          </select>
        </div>
      </div>   
       <div class="form-group">
       <label for="cron" class="col-sm-2 control-label">cron表达式</label>
	          <div class="col-sm-3">
	          <c:choose>
	          	<c:when test="${taskMain.cron !=null}">
	          	<input type="text" class="form-control" id="cron" name="cron" value="${taskMain.cron }">
	          	</c:when>
	          	<c:otherwise>
	          		<input type="text" class="form-control" id="cron" name="cron" value="* * 1-23 ? * *">
	          	</c:otherwise>
	          </c:choose>
	          </div>
	           <label for="cron" class="col-sm-5 control-label" style="text-align: left;color: red;">每项指标必填</label>
      </div>
      <div class="form-group">
        <label for="description" class="col-sm-2 control-label">描述</label>
        <div class="col-sm-8">
          <textarea name="description" id="description" class="form-control" rows="6" maxLength="500">${taskMain.description}</textarea>
        </div>
      </div> 
      <div class="form-group">
        <label for="remark" class="col-sm-2 control-label">备注</label>
        <div class="col-sm-8">
          <textarea name="remark" id="remark" class="form-control" rows="6" maxLength="500">${taskMain.remark}</textarea>
        </div>
      </div>
    </form>
  </div>
  <div class="modal-footer">
  <div class="form-group">
    <button type="button" class="btn btn-success btn-white btn-round" onclick="$('#taskMainForm').submit()"> <i class="ace-icon fa fa-floppy-o bigger-125"></i>保存</button>
    <button type="button" class="btn btn-danger btn-white btn-round" data-dismiss="modal"><i class="ace-icon fa fa-times bigger-125"></i>关闭</button>
  </div>
  </div>
</div>
<script>
</script>