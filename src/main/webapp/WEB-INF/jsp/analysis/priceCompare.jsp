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
    <title>重点农产品价格监测</title>

    <!-- Bootstrap -->
    <link href="${ctx}/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctx}/assets/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx}/assets/css/analysis/common.css" rel="stylesheet">
    <link href="${ctx}/assets/bootstrap-datetimepicker/bootstrap-datetimepicker.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
    
    </style>
  </head>
  <body>
    <!-- topic begin -->
    <div class="container">
      <div class="topic">
        <!-- constraint begin -->
        <div class="constraint">
          <form action="" class="form-inline">
            <div class="row">
              <div class="col-sm-12">
                <span class="clable">农产品类别: </span>
                <ul id="ctg" name="ctg" class="ctg-list list-inline dui-controller" data-custom="true"></ul>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12">
                <span class="clable">农产品: </span>
                <ul name="products" class="t-condition list-inline dui-controller products-list" data-parent="ctg"  data-custom="true"></ul>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12">
                <span class="clable">地区：</span>
                <select id="region1" name="region" class="region-list" >
                </select>
              </div>
            </div>
            <div  class="row">
              <div class="form-group col-sm-4">
                <span class="clable">时间选择：</span>
                <div class="input-group date datePicker ">
                  <input type="text" class="form-control t-condition" name="cdate" />
                  <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                  </span>
                </div>
              </div>
              <div class="form-group col-sm-4">
                <span class="clable">快捷切换：</span>
                <input type="radio" name="atime"  value="day" class="date-condition t1-condition" checked="checked" id="date-day"> 本日
                <input type="radio" name="atime"  value="day" class="date-condition t1-condition" id="date-day"> 本周
                <input type="radio" name="atime"  value="month" class="date-condition t1-condition" id="date-month"> 本月
              </div>
              <div class="form-group">
                <div class="col-sm-1">
                  <button class="btn btn-default search-btn" data-target="table1" type="button">查询</button>
                </div>
              </div>
            </div>
          </form>
        </div>
        <!-- constraint end -->
      
        <!-- subjects begin -->
        <div class="subject">
          <!-- <span class="title">销量,价格,涨幅</span> -->
          <div class="content">
            <div class="constraint">
              
            </div>
            <div class="visual-container">
              <div id="table" class="table-container" data-table="priceSale_ps" data-condition="t-condition">
              </div>
              <div id="tableChart" class="chart"></div>
            </div>
          </div>
        </div>

         <!-- subjects end -->
      </div>
    </div>
    <!-- topic end -->

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="${ctx}/assets/jquery/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="${ctx}/assets/bootstrap/bootstrap.min.js"></script>
    <script src="${ctx}/assets/js/component/dui-helper.js"></script>
    <script type="text/javascript" src="${ctx}/assets/moment/min/moment.min.js"></script>
    <script type="text/javascript" src="${ctx}/assets/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"></script>
    <script src="${ctx}/assets/datepicker/bootstrap-datepicker.js"></script>
    <script src="${ctx}/assets/datepicker/bootstrap-datepicker.zh-CN.js"></script>
    <script src="${ctx}/assets/js/bluebird.min.js"></script>
    <script src="${ctx}/assets/js/lodash.min.js"></script>
    <script src="${ctx}/assets/js/echart/dist/echarts-all.js"></script>
    <script src="${ctx}/assets/js/echart/mycharts.js"></script>
    <script src="${ctx}/assets/js/component/common.js"></script>

    <script>
      // 思路：在pricecompositequery.jsp页面中
      //       加载每日、每周、每月、每年的价格统计模板、
      //       农产品价格明细模板、交易地农产品价格明细模板，
      //       农产品类别、农产品、区域、交易地作为公共的条件，
      //       选择不同的时间显示不同的模板
      var CROPTYPES_MAP = {}, REGIONS_MAP = {};
      $(document).ready(function(){
        //chart init
        $('.subject')
        .on(
          'loaded.tbl.dui',
          '.dui-component',
          function (e, component) {
            if (component.attr('id') == 'table2') {
              drawTable2Chart(component);
            } else if (component.attr('id') == 'table3') {
              drawTable3Chart(component);
            };
          }
        );

        //初始化时间控件
        datePickInit({
          locale : 'zh-CN',
          useCurrent : false,
          format : 'YYYY-MM-DD',
          viewMode : 'days',
          defaultDate : new Date()
        });

        /**
         * 页面初始化时从后台获取json格式的农产品类别显示在前台页面
         */ 
        var ctgsRequest = $.getJSON('${ctx}/analysis/ctgs')
        , regionsRequest = $.getJSON('${ctx}/analysis/regions');
        Promise
        .all([ctgsRequest, regionsRequest])
        .spread(function(ctgs, regions) {
          // init ctgslist
          renderOption(ctgs, $('.ctg-list'));
          // init proudctslist
          Promise.reduce(ctgs, function(myMap, ctg, index){
            return $.getJSON('${ctx}/analysis/ctgs/' + ctg.code + '/products')
            .then(function (products){
              if (index == 0 ) {
                renderOption(products, $('.products-list'));
              };
              myMap[ctg.code] = products;
              return myMap;
            });
          }, CROPTYPES_MAP)
          .then(function () {
            //所有分类加载完毕
            console.log(CROPTYPES_MAP);
          });

          // init regionslist
          renderOption(regions, $('.region-list'));
          // init regionslist
          Promise.reduce(regions, function(myMap, region, index){
            return $.getJSON('${ctx}/analysis/regions/' + region.code + '/markets')
            .then(function (markets){
              if (index == 0 ) {
                renderOption(markets, $('.markets-list'));
              };
              myMap[region.code] = markets;
              return myMap;
            });
          }, REGIONS_MAP)
          .then(function () {
            console.log(REGIONS_MAP);
          });
          return;
        }).then(function() {
          //table init
          $('.table-container').each(function () {
            loadTable($(this));
          });

          //sub list listening init
          _.forEach($('.products-list'), function(element) {
            var parent = $(element).data('parent');
            $('#'+parent).on('change', function(e, value) {
              var key = value || $(this).val();
              renderOption(CROPTYPES_MAP[key], element);
            });
          });
          _.forEach($('.markets-list'), function(element) {
            var parent = $(element).data('parent');
            $('#'+parent).on('change', function(e, value) {
              var key = value || $(this).val();
              renderOption(REGIONS_MAP[key], element);
            });
          });
        });

      });//ready end
      

      <!--加载每日、每周、每月、每季度、每年的价格统计、农产品明细、交易地明细-->
      $('.date-condition').click(function(){
        var datePicker = $(this).parents('.row').find('.datePicker');
        if ($(this).val() == 'day') {
          dayPicker(datePicker);
        } else if ($(this).val() == 'month') {
          monthPicker(datePicker);
        } else {
          yearPicker(datePicker);
        };
      });
    </script>
    
    <div id="footer">
    
  </div>
  </body>
</html>