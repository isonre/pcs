<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/jsp/common/common.jsp" %>

<c:url var="component" value="/test"/>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>products</title>

    <!-- Bootstrap -->
    <link href="${ctx}/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="${ctx}/assets/css/font-awesome.min.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
    .dui-option{
      cursor: pointer;
      border: 1px #C1AEAE solid;
    }
    .dui-option.active{
      border: 2px red solid;
    }
    </style>
  </head>
  <body>
    <div class="topic">
      <div class="constraint">
        <div>
          <span class="clable">农产品类别</span>
          <ul name="ctype" class="t1-condition list-inline dui-controller" data-value="水果" data-quote="true">
            <li data-value="" class="dui-option">全部</li>
            <li data-value="水果" class="dui-option">水果</li>
          </ul>
        </div>
        <div>
          <span class="clable">农产品</span>
          <ul name="cname" class="t1-condition list-inline dui-controller" data-quote="true">
            <li data-value="" class="dui-option">全部</li>
            <li data-value="香蕉" class="dui-option">香蕉</li>
          </ul>
        </div>
        <div>
          <span class="clable">区域选择</span>
          <select name="region" class="t1-condition" >
            <option value="南宁市">南宁</option>
             <option value="北海市">北海市</option>
          </select>
        </div>
      </div>
      <div class="table"></div>
      <div class="chart"></div>
    </div>
    <div class="container-fluid" name=''>

    </div>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
     <script src="${ctx}/assets/jquery/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="${ctx}/assets/bootstrap/bootstrap.min.js"></script>
    <script src="${ctx}/assets/js/component/dui-helper.js"></script>
    <script type="text/javascript" src="${ctx}/assets/moment/min/moment.min.js"></script>
    <script type="text/javascript" src="${ctx}/assets/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"></script>
    <script src="${ctx}/assets/datepicker/bootstrap-datepicker.js"></script>
    <script src="${ctx}/assets/datepicker/bootstrap-datepicker.zh-CN.js"></script>
    <script src="${ctx}/assets/js/echart/dist/echarts-all.js"></script>
    <script src="${ctx}/assets/js/echart/mycharts.js"></script>
    $(document).ready(function(){
      duiHelper.load({
		container:  $('.container-fluid'),
        cid: 'jiance_firstchart_day',
        condition: duiHelper.getCondition($('.t1-condition'))
      });
    });
 
    </script>
  </body>
</html>