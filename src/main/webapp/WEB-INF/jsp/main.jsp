<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta http-equiv="content-language" content="zh-CN" />
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta http-equiv="keywords" content="平台,业务" />
<meta http-equiv="description" content="通用业务平台" />
<meta name="author" content="Yunforge" />
<title>农产品价格采集系统</title>
<link rel="icon" href="${ctx}/favicon.ico" />
<link href="${ctx}/assets/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${ctx}/assets/css/carousel.css" rel="stylesheet">
<link href="${ctx}/assets/css/font-awesome.min.css" rel="stylesheet">
<link href="${ctx}/assets/css/main-common.css" rel="stylesheet">

</head>

<body style="background-color: #eef1f7;">
	<div class="container-fluid main">
		<div class="navbar-wrapper">
			<div class="container-fluid">
	<nav class="navbar navbar-inverse navbar-static-top">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="${ctx}/main">农产品价格采集系统</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav" id="nav_container">
					<li><a href="${ctx}/main"><i class="fa fa-home fa-lg">
						</i> 首页</a></li>
					<shiro:hasRole name="admin">
						<li><a href="${ctx}/index#page/desktop"><i
								class="fa fa-cog fa-lg"> </i> 系统管理</a></li>
								<li><a onclick="loadPage('${ctx}/main#page/collect/query/manager')" > <i
								class="fa fa-search fa-lg"> </i> 数据查询
						</a></li>
						<li><a onclick="loadPage('${ctx}/main#page/collect/analysis/manager')" > <i
								class="fa fa-bar-chart-o fa-lg"> </i> 综合分析
						</a></li>
					</shiro:hasRole>
					<shiro:hasRole name="price">
						<%-- <li><a onclick="loadPage('${ctx}/collect/dataReoprtedMain/manager')" > <i class="fa fa-edit fa-lg"> </i> 我的任务</a></li> --%>
						<li><a onclick="loadPage('${ctx}/main#page/collect/dataReoprtedMain/myTask')" > <i
								class="fa fa-edit fa-lg"> </i> 我的任务
						</a></li>
						<li><a onclick="loadPage('${ctx}/main#page/collect/taskMain/selfHistoryManager')" > <i
								class="fa fa-th-list fa-lg"> </i> 历史任务
						</a></li>
						<li><a onclick="loadPage('${ctx}/main#page/profile/profile')"> <i
								class="glyphicon glyphicon-user fa-md"></i> 个人中心
						</a></li>
					</shiro:hasRole>
					<shiro:hasRole name="leader">
						<li><a onclick="loadPage('${ctx}/main#page/collect/query/manager')" > <i
								class="fa fa-search fa-lg"> </i> 数据查询
						</a></li>
						<li><a onclick="loadPage('${ctx}/main#page/collect/analysis/manager')" > <i
								class="fa fa-bar-chart-o fa-lg"> </i> 综合分析
						</a></li>
					</shiro:hasRole>
					<li style="position: relation;"><c:choose>
							<c:when test="${sessionScope.userSession ==null}">
								<a id="userloginBtn"><i class="fa fa-user"> </i> 用户登录</a>
							</c:when>
							<c:otherwise>
								<a id="userlogoutBtn"><i class="fa fa-circle-o-notch fa-md ">
								</i> 退出登入</a>
							</c:otherwise>
						</c:choose> <!-- login  -->
						<div class="col-md " id="userloginPanel"
							style="position: absolute; right: 0px; top: 50px; width: 300px; height: 250px; display: none">
							<div class="panel panel-primary"
								style="height: 100%; overflow: hidden; border-color: #f5f5f5">
								<div class="panel-body">

									<button id="closeButtonID"
										style="position: absolute; right: 0px; top: 0px; background: red; color: #fff;">关闭</button>

									<ul class="nav nav-tabs" role="tablist">
										<li role="presentation" class="active"><a
											href="#normal-pane" role="tab" data-toggle="tab"
											aria-controls="normal-pane" aria-expanded="true"><i
												class="fa fa-user"> </i> 用户登录</a></li>
										<!-- <li role="presentation"><a href="#ca-pane" role="tab"
														data-toggle="tab" aria-controls="ca-pane"
														aria-expanded="true">证书登录</a></li> -->
									</ul>
									<div class="tab-content">
										<div class="tab-pane fade in active" id="normal-pane">



											<form name="accountForm" class="form-horizontal ">
												<div class="form-group" style="margin-top: 10px">
													<div class="col-sm-12">
														<input type="text" name="username" id="username"
															tabindex="1" class="form-control" value=""
															data-toggle="popover" placeholder="支持用户名/手机号登入" required
															autofocus>
													</div>
												</div>
												<div class="form-group">
													<div class="col-sm-12">
														<input value="" type="password" name="password"
															id="password" tabindex="2" class="form-control"
															data-toggle="popover" placeholder="密 码" required>
													</div>
												</div>

												<div class="form-group">
													<div class="col-sm-12">
														<label class="btn btn-success" id="submitLink"
															style="width: 100%"> 登入 </label>
													</div>
												</div>
											</form>
										</div>
										<div class="tab-pane fade " id="ca-pane">
											<br>
											<!-- <p class="remind">
															登入成功！<a href="#" target="_blank">使用帮助</a>
														</p> -->
											<div class="alert alert-success">登入成功！</div>
											<div class="alert alert-info">
												系统使用说明
												<button type="button" id="caLogin" class="btn btn-primary">帮助文档</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div></li>

					<li><a id="phoneClient"><i
							class="fa fa-mobile fa-lg green" style="font-size: 20px"> </i>
							手机客户端</a>
						<div class="tab-pane fade " id="downloadImage"
							style="position: absolute; right: 0px; top: 50px; z-index: -100; width: 170px; background: #eef1f7; height: 160px; text-align: center; display:">
							<img src="${ctx }/assets/images/main/appDownload.png" width="" />
						</div></li>
				</ul>
			</div>
		</div>
	</nav>
</div>

		</div>

		<div class="container white-container" id="index-container">

			


			<!-- ============Carousel=========== -->
			<%-- <div class="white-container-main row" style="">
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<!-- <li data-target="#myCarousel" data-slide-to="2"></li> -->
					</ol>
					<div class="carousel-inner" role="listbox">
						<div class="item active">
							<img class="first-slide" src="${ctx}/assets/images/main/bg5.jpg"
								alt="First slide">
							<div class="container">
								<div class="carousel-caption"></div>
							</div>
						</div>
						<div class="item">
							<img class="second-slide" src="${ctx}/assets/images/main/bg6.jpg"
								alt="Second slide">
							<div class="container">
								<div class="carousel-caption"></div>
							</div>
						</div>
					</div>
					<a class="left carousel-control" href="#myCarousel" role="button"
						data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#myCarousel" role="button"
						data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
					<div class="yf-mian-notice">
						<div class="y-row"></div>
					</div>
				</div>
			</div> --%>
			<!-- /.white-container-main -->
		</div>
		<!-- /.white-container -->
	</div>

	<div class="container-fluid footer-container"
		style="display: block; position: absolute; bottom: 40px; width: 100%; z-index: -11000">
		<div class="container">
			<!-- FOOTER -->
			<footer>
				<p>版权所有 ©2015-2016 广西农业信息中心</p>
				<p>
					技术支持：广州星尘科技有限公司 
				</p>
			</footer>
		</div>
	</div>

	<script src="${ctx}/assets/jquery/jquery-1.11.2.min.js"></script>
	<script src="${ctx}/assets/bootstrap/bootstrap.min.js"></script>
	<script src="${ctx}/assets/jquery/plugins/toast/jquery.toaster.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			
			//页面初始化加载
			initLoadPage();
				
			
			//window.location.reload();
			/* 下面js是监控不同的按钮或事件进行触发 */
			//登入：用户退出登入
			$("#userlogoutBtn").on("click", function() {
				$.ajax({
					url : "${ctx}/logout",
					data : {},
					type : "GET",
					dataType : 'json',
					complete : function(data) {
						$.toaster({
							title : '用户注销',
							priority : 'success',
							message : '成功！'
						});
						//setTimeout(window.location.host+"/pcs/main", 500)
						window.location.href="http://" +window.location.host+ "/pcs/main";
					}
				})
			});
			//登入：显示登入面板
			$("#userloginBtn").on("click", function() {
				
				$("#userloginPanel").toggle();
			});
			//登入：关闭登入面板
			$("#closeButtonID").on("click", function() {
				alert(window.location.host)
				$("#userloginPanel").toggle();
			});
			//登入：点击登入按钮触发，处理登入
			$("#submitLink").click(function() {
				var username = $("#username").val();
				var password = $("#password").val();
				$.ajax({
					url : "${ctx}/api/login",
					data : {
						"username" : username,
						"password" : password
					},
					type : "POST",
					dataType : 'json',
					success : function(json) {
						//console.log(json)
						var errorCode = json.data.result.errorCode;
						if (errorCode == '1') {
							/* $("#normal-pane").removeClass("in active");
							$("#ca-pane").addClass("in active"); */
							$("#userloginPanel").toggle();
							$.toaster({
								title : '用户登入',
								priority : 'success',
								message : '成功！'
							});
							setTimeout("window.location.reload();", 300)
							//window.location.reload();
						} else {
							$.toaster({
								title : '用户登入失败',
								priority : 'danger',
								message : '登入名或密码错误！'
							});
						}
					},
					complete : function(data) {
					}
				})
			});
			//手机客户端下载
			$("#phoneClient").on("mouseover", function() {
				$("#downloadImage").addClass("in active");
			});
			$("#phoneClient").on("mouseout", function() {
				$("#downloadImage").removeClass("in active");
			});

		});
		
		//页面初始化,将页面加载到DIV中（index-container）
		 function initLoadPage(){
			 var ctx="${ctx}";
				var url = document.URL;
				var start = url.indexOf("#page");
				if (start != -1) {
					$("#index-container").load(ctx+url.substr(start + 5),function(){ $("#index-container").fadeIn(100);})
				}else{
					$("#index-container").load(ctx+"/main/home",function(){ $("#index-container").fadeIn(100);})
				}
				
				if(navigator.userAgent.indexOf("Chrome") == -1) {
					alert('系统不支持IE浏览器，请下载谷歌浏览器！');
					window.location.href = "${ctx}/office/file/download?filename=GoogleChrome.exe&type=resource";
				}
			} 
		
		//页面跳转
		 function loadPage(action){
				$("#index-container").load(action,function(){ $("#index-container").fadeIn(100);})
				history.pushState([],"",action);
			} 
	
	</script>

</body>