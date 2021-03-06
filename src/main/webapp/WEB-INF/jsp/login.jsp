<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta http-equiv="content-language" content="zh-CN" />
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta http-equiv="keywords" content="平台,业务" />
<meta http-equiv="description" content="通用业务平台" />
<meta name="author" content="Yunforge" />
<title><spring:message code="app.title" /></title>
<script src="${ctx}/assets/jquery/jquery1x.min.js"></script>
<link rel="icon" href="${ctx}/favicon.ico" />
<link rel="stylesheet" type="text/css" media="screen" href="${ctx}/assets/bootstrap/css/bootstrap.min.css" />
 <!--[if lt IE 8]>
    <link href="${ctx}/assets/css/bootstrap-ie7.css" rel="stylesheet">
<![endif]-->
<link rel="stylesheet" type="text/css" media="screen" href="${ctx}/assets/css/font-awesome.min.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${ctx}/assets/css/default.css" />
<style type="text/css">
  .carousel-caption {
	left:5px;
  }
</style>


<!-- page specific plugin scripts -->
<!--[if lte IE 9]>
	<script src="${ctx}/assets/js/html5shiv.min.js"></script>
	<script src="${ctx}/assets/js/respond.min.js"></script>
<![endif]-->
<!--[if lte IE 8]>
	<script src="${ctx}/assets/js/excanvas.min.js"></script>
<![endif]-->
</head>
<body style="overflow:hidden;">
    <!-- 
        <object classid="clsid:707C7D52-85A8-4584-8954-573EFCE77488" id="JITDSignOcx" width="0" codebase="./JITDSign.cab#version=2,0,24,19"></object>
    -->
	<div id="header_outer" class="navbar navbar-inverse navbar-default navbar-fixed-top" role="navigation">
		<div class="container">	
			<div class="navbar-header">
				 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-header-collapse">
            		<span class="sr-only">导航切换</span>
            		<span class="icon-bar"></span>
            		<span class="icon-bar"></span>
            		<span class="icon-bar"></span>
          		</button>
				<a id="header_logo" class="navbar-brand" href="/"  title="<spring:message code="app.title" />	">
					<i class="glyphicon glyphicon-grain"></i>
					<spring:message code="app.title" />	
				</a><!-- /.brand -->
			</div>
			<div class="collapse navbar-collapse navbar-header-collapse">
				<ul id="header_menu" class="nav navbar-nav navbar-right">
				     <li class="active"><a href="#"><i class="fa fa-key"></i> 系统登录</a></li>
					 <li><a href="#"><i class="fa fa-question"></i> 系统帮助</a></li>
                     <li class="dropdown">
                		<a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-download"></i> 下载服务<b class="caret"></b></a>
                		<ul class="dropdown-menu">
                			<li><a href="#" onclick="downloadChrome()"><i class="fa fa-angle"></i> 谷歌浏览器</a></li>
                			<!-- 
                  			<li><a href="#" onclick="downloadIE8()"><i class="fa fa-angle"></i> IE8浏览器</a></li>
                			 -->
                 			<li><a href="#"><i class="fa fa-angle"></i> 数字证书插件</a></li>
                		</ul>
              		</li>
                </ul>
			</div>
		</div>
	</div>
	<div id="index-wrap">
   		<div id="carousel-wrap container">
   			<div class="row">
   	 			<div class="col-xs-12">
					<div id="myCarousel" class="carousel slide" data-ride="carousel">    
      					<div id="loginPictureDiv" class="carousel-inner" role="listbox">
          					<div class="item active">
          						<img src="${ctx}/assets/images/slide/slide-01.jpg" />
          						<div class="carousel-caption">
             						<h2>多元数据采集</h2>
           						</div>
        					</div>
        					<div class="item">
          						<img src="${ctx}/assets/images/slide/slide-02.jpg"/>
          						<div class="carousel-caption">
             						<h2>海量数据存储</h2>
           						</div>
        					</div>
        					<div class="item">
          						<img src="${ctx}/assets/images/slide/slide-03.jpg"/>
          						<div class="carousel-caption">
             						<h2>安全数据传输</h2>
           						</div>
        					</div>
        					<div class="item">
          						<img src="${ctx}/assets/images/slide/slide-04.jpg"/>
          						<div class="carousel-caption">
             						<h2>数据智能分析</h2>
           						</div>
        					</div>
     	    			</div>
  						<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
    						<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    						<span class="sr-only">Previous</span>
  						</a>
  						<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
    						<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    						<span class="sr-only">Next</span>
  						</a>
  					</div>
  				</div>
  			</div>
  		</div>
		<div id="loginDivId" class="login" style="width:400px;display:none;">		    
			<div class="container pull-right" style="width:400px">
				<div class="row" style="width:400px">	 
					<div class="col-xs-12" style="width:400px">
				  		<div class="panel panel-primary">
				    		<div class="panel-heading">
				           		<h3 class="panel-title">系统登录</h3>
				   			</div>
							<div class="panel-body">
								<ul class="nav nav-tabs" role="tablist">
									<li role="presentation" class="active"><a href="#normal-pane" role="tab" data-toggle="tab" aria-controls="normal-pane" aria-expanded="true">普通登录</a></li>
									<li role="presentation"><a href="#ca-pane" role="tab" data-toggle="tab" aria-controls="ca-pane" aria-expanded="true">证书登录</a></li>
								</ul>
								<div class="tab-content">
									<div class="tab-pane fade in active" id="normal-pane">
										<form class="form-horizontal" data-async id="loginForm" role="form" action="" method="POST">
						    				<div class="form-group">
												<label class="col-sm-3 control-label" for="username"><spring:message code="login.lable.username" /> :</label>
												<div class="col-sm-8">
													<input type="text" name="username" id="username" tabindex="1" class="form-control" value="" data-toggle="popover"  placeholder="<spring:message code="login.lable.username" />" required autofocus>
							    				</div>
											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label" for="password"><spring:message code="login.lable.password" /> :</label>
												<div class="col-sm-8">
													<input value="" type="password" name="password" id="password" tabindex="2" class="form-control"  data-toggle="popover" placeholder="<spring:message code="login.lable.password" />" required> 
							    				</div>
											</div>
											<c:if test="${jcaptchaEbabled}">
											<div class="form-group">
												<label class="col-sm-3 control-label" for="captcha"><spring:message code="login.lable.captcha" /> :</label>
												<div class="col-sm-5">
													<input type="text" name="captcha" id="captcha" tabindex="3" class="form-control" data-toggle="popover"  placeholder="<spring:message code="login.lable.captcha" />" required> 
							    				</div>
							    				<div class="col-sm-4">
							    					<a id="captchaLink" href="javascript:;"><img id="captchaImage"  src="${ctx}/jcaptcha.jpg" /></a>
							    				</div>
											</div>
											</c:if>
											<div class="form-group">
												<div class="col-sm-offset-3 col-sm-8">
													<div class="checkbox">
								   						<label>
								   							<input type="checkbox" id="rememberMe" name="rememberMe" value="rememberMe" tabindex="4"/><spring:message code="login.lable.rememberMe" />
							       						</label>
							    					</div>
							    				</div>
											</div>
											<div class="form-group">
												<div class="col-sm-offset-3 col-sm-8">
													<a href="javascript:void(0);" id="getPassWord"><spring:message code="login.btn.restPassword" /></a>
							    				</div>
											</div>
											<div class="form-group">
							   					<div class="col-sm-offset-3 col-sm-8">
							    					<button type="submit" class="btn btn-primary" id="submitLink"><spring:message code="button.login" /></button>
							    					<button type="reset" class="btn btn-danger" id="resetLink"><spring:message code="button.reset" /></button>
							   					</div>
											</div>
										</form>
										<h4 class="text-warning"><strong>安全须知:</strong></h4>
										<div class="remind">
											<ul>
												<li>请不要在网吧等场所的公用计算机上使用<span class="webName"></span>。</li>
												<li>请不要通过不明网站、电子邮件或论坛中的网页链接登录<span class="webName"></span>。</li>
												<li>使用完毕或暂离机器时请勿忘退出<span class="webName"></span>。</li>
											</ul>
										</div>
					  				</div>
					  				<div class="tab-pane fade" id="ca-pane">
					  					<p class="remind">若您知晓并愿意遵守<a href="#" target="_blank">《CA使用规范》</a>， 请点击“登录”进入<span class="webName"></span>。</p>
				     					<form name="caForm" method="post" action="auth">             
				     						<input type="hidden" id="signed_data" name="signed_data" /> 
						 					<input type="hidden" id="original_jsp" name="original_jsp" />			
				     						<ul class="loginBox hidden">
				    	 						<li><label for="caType">颁发者DN:</label><input type="text" id="RootCADN" value="" width="30" /></li>
				     						</ul>
					  						<div>              
				     							<button type="button" id="caLogin" class="btn btn-primary"><spring:message code="button.login" /></button>
				    						</div>         
				    						<div class="divider"></div>
											<div>
					      						<font color="red">
					      	  						<span id="msg"></span>
					      						</font>
											</div>
										</form>
										<h4 class="text-warning"><strong>敬请注意:</strong></h4>
										<div class="remind">
				      						<ul>
				        						<li>若您的电脑尚未安装USBKey驱动程序：</li>
				        						<li>供应商请点这里<a href="${ctx}/cadl/SiChuanCAUSBKeyDriver.exe"    style="color: red;">下载</a>安装，</li>
				        						<li>非供应商请点击这里<a href="${ctx}/cadl/ePass3003-SimpChinese.exe" style="color: red;" >下载</a>安装。</li>
				      						</ul>
				      										
				      						<h4 class="text-warning"><strong>安全须知:</strong></h4>
				      						<ul>
				        						<li>使用完毕或暂离机器时请退出系统并拔出USBKey。</li>
				        						<li>请妥善设置和保管USBKey的密码，不要告诉他人。</li>
				        						<li>若您的USBKey遗失，请尽快到<span class="webName">广西数字认证中心</span>办理证书恢复手续。</li>
				      						</ul>
				      					</div>	
					  				</div>
					  			</div>
					  		</div>
				    	</div>
					</div>
				</div>
			</div>
		</div>
	</div>		
    <footer>
      <div class="container" style="width:90%">
           <div class="row">
               <div class="col-xs-12">                  
                   <p class="text-center footer"><spring:message code="app.footer" /></p>
               </div>
           </div>
      </div>
    </footer>

  <!--[if !IE]> -->
  <script type="text/javascript">
	 window.jQuery || document.write("<script src='${ctx}/assets/jquery/jquery.min.js'>"+"<"+"/script>");
   </script>
  <!-- <![endif]-->

 <!--[if IE]>
 <script type="text/javascript">
 	window.jQuery || document.write("<script src='${ctx}/assets/js/jquery.min.js'>"+"<"+"/script>");
 </script>
 <![endif]-->

<script type="text/javascript">
	if('ontouchstart' in document.documentElement) document.write("<script src='${ctx}/assets/jquery/mobile/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="${ctx}/assets/bootstrap/bootstrap.min.js"></script>
	
 <script type="text/javascript">
    $(document).ready(function() {
  		$('#loginTab a:first').tab('show');
 		$("[data-toggle=popover]").popover({placement:'left',trigger:'manual',container: 'body'});
 		$("[data-toggle=popover]").click(function(){
	 		$("[data-toggle=popover]").popover('hide');
	 		return false;
		 });
 
 		var selector="${type}";
		if(selector!=""){
			$("#"+selector).attr("data-content", "${error}");
			$("#"+selector).popover('show');
 		}
 

 		$("#captchaLink").click(function() {
	 		$("#captchaImage").attr("src", '${ctx}/jcaptcha.jpg?'+new Date().getTime());
 		});
 
 		$("#caLogin").click(function() {
			$("#msg").html("");
			doDataProcess();
 		});
 
		//忘记密码，找回密码
 		$("#restPassword").click(function(){
	   		window.open('${ctx}/UserSecurityController.do?method=getPassword&step=1');
		 });
 
 		document.onkeydown = function(e){   
	  		var ev = document.all ? window.event : e;  
	   		if (ev.keyCode == 13) {
	   			$("#loginForm").submit();
        	 	return false;
       		}
		}
 		
		if(navigator.userAgent.indexOf("Chrome") == -1) {
			alert('系统不支持IE浏览器，请下载谷歌浏览器！');
			window.location.href = "${ctx}/office/file/download?filename=GoogleChrome.exe&type=resource";
		}
    });
  
	//根据原文和证书产生认证数据包
	function doDataProcess() {
		var auth_Content ="${original}";
		var dSign_Subject = $("RootCADN").val();
		if (auth_Content == "") {
			alert("认证原文不能为空!");
		} else {
			// 控制证书为一个时，不弹出证书选择框
			//JITDSignOcx.SetCertChooseType(1);
			if (dSign_Subject == "") {
				dSign_Subject = "CN=CEGN_OCA,O=SIC,S=BeiJing,C=CN|CN=SCEGB CA,OU=Class 2 Enterprise Individual Subscriber CA,OU=Terms of use at https://www.itrus.com.cn/ctnrpa (c)2008,OU=China Trust Network,O=四川省数字证书认证管理中心有限公司,C=CN";
			}

			JITDSignOcx.SetCert("SC", "", "", "",dSign_Subject, "");
			if (JITDSignOcx.GetErrorCode() != 0) {
				// alert("错误码："+JITDSignOcx.GetErrorCode()+"
				// 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
				return false;
			} else {
				var temp_DSign_Result = JITDSignOcx.DetachSignStr("", auth_Content);
				if (JITDSignOcx.GetErrorCode() != 0) {
					// alert("错误码："+JITDSignOcx.GetErrorCode()+"
					// 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
					return false;
				}
				// 如果Get请求，需要放开下面注释部分
				// while(temp_DSign_Result.indexOf('+')!=-1) {
				// temp_DSign_Result=temp_DSign_Result.replace("+","%2B");
				// }
				$("#signed_data").val(temp_DSign_Result);
			}
	   }

	   $("#original_jsp").val(auth_Content);
	   // document.forms[1].submit();
		// ishave();
		var flag = "N";
		var url = "${ctx}/AuthenController.do?method=doCAAuth";

		$.ajax({url : url,
			data : {
				signed_data : temp_DSign_Result,
				original_jsp : auth_Content,
				flag : flag
			},
			type : 'post',
			dataType : 'json',
			cache : 'false',
			success : function(json) {
				if (json.message == 'false') {
					$("#msg").html(json.errDesc);
					returnValue = false;
					return false;
				} else {
					var usrCaSn = json.usrCaSn;
					$.ajax({url : "${ctx}/caLogin.do",
						data : {
							"usrCaSn" : usrCaSn,
							"json" : JSON.stringify({"usrCaSn" : usrCaSn})
						},
						type : "POST",
						async : true,
						cache : 'false',
						dataType : 'json',
						success : function(json) {
							if (json.result)
								alert(json.result,{inco : 'info'});
							;
							if (json.failure)
								return;

							if (json.failure == "false") {
								$("#msg").html("<font color='red'>"+ json.response+ "</font>");
							} else {
								$("#msg").html("");
								// loadPage_fullScreen($("#initPath").val()+"/CaLoginController.do");
								//window.location.href = $("#initPath").val()+ "/ModelIndexController.do?method=toDeskTopIndex";
								window.location.href = "${ctx}/portal";
							}
						},
						error : function(
								XMLHttpRequest,
								textStatus,
								errorThrown) {
							
							window.location.href = "${ctx}/IndexViewController.do?method=index";
							/*
							if (XMLHttpRequest.Status == '404') {
								//window.location.href = $("#initPath").val()+ "/ModelIndexController.do?method=toDeskTopIndex";
								window.location.href = "${ctx}/index.do";
							} else {
								$("#msg").html("<font color='red'>请求异常，请检查网络连接</font>");
							}*/
						}
					})
					
				}
			},
			error : function(msg) {
				alert("请求异常，请检查网络连接");
			}
		});
	}
    
	function downloadIE8() {
		window.open('${ctx}/office/file/download?filename=IE8-WindowsXP-x86-CHS.exe&type=resource');
	}
	function downloadChrome() {
		window.open('${ctx}/office/file/download?filename=GoogleChrome.exe&type=resource');
	}
	
	function changeLoginDivStyle() {
		var w = parseInt($(window).width());
		var h = parseInt($(window).height());
		
		$("#loginPictureDiv").height((h-120) + "px");
		$("#loginDivId").width((w-200) + "px");
		$("#loginDivId")[0].style.display = "";
	}
	setInterval("changeLoginDivStyle()",100);

	//如果父页面不是登陆页面，就让父页面跳到登陆页面
	if(top != null && top.location != null && (top.location+"").indexOf("login") == -1) {	
		top.location.href = "${ctx}/login";
	}
 </script>
</body>
</html>