<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <title>Dashio - Bootstrap Admin Template</title>

  <!-- Favicons -->
  <link href="${pageContext.request.contextPath}/img/favicon.png" rel="icon">
  <link href="${pageContext.request.contextPath}/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Bootstrap core CSS -->
  <link href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!--external css-->
  <link href="${pageContext.request.contextPath}/lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/zabuto_calendar.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/lib/gritter/css/jquery.gritter.css" />
  <link href="${pageContext.request.contextPath}/css/style.css" type="text/css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/css/style-responsive.css" type="text/css" rel="stylesheet" />
 
  <script src="${pageContext.request.contextPath}/lib/chart-master/Chart.js"></script>

<!-- DataTables 관련 -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
<script src="http://code.jquery.com/jquery-2.1.1.js"></script>
</head>
<body>
	<section id="container"> 
	<!-- 헤더 부분 --> 
	<tiles:insertAttribute name="header" />
	<!-- 사이드바 부분 --> 
	<tiles:insertAttribute name="sidebar" /> 
	<!-- 컨텐츠 부분 --> 
	<tiles:insertAttribute name="content" /> 
	<!-- 푸터부분 -->
	<tiles:insertAttribute name="footer" /> 
	</section>
	<!-- js placed at the end of the document so the pages load faster -->
	  <script src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.min.js"></script>
	  <script class="include" type="text/javascript" src="${pageContext.request.contextPath}/lib/jquery.dcjqaccordion.2.7.js"></script>
	  <script src="${pageContext.request.contextPath}/lib/jquery.scrollTo.min.js"></script>
	  <script src="${pageContext.request.contextPath}/lib/jquery.nicescroll.js" type="text/javascript"></script>
	  <script src="${pageContext.request.contextPath}/lib/jquery.sparkline.js"></script>
	  <!--common script for all pages-->
	  <script src="${pageContext.request.contextPath}/lib/common-scripts.js"></script>
	  <script type="text/javascript" src="${pageContext.request.contextPath}/lib/gritter/js/jquery.gritter.js"></script>
	  <script type="text/javascript" src="${pageContext.request.contextPath}/lib/gritter-conf.js"></script>
	  <!--script for this page-->
	  <script src="${pageContext.request.contextPath}/lib/sparkline-chart.js"></script>
	  <script src="${pageContext.request.contextPath}/lib/zabuto_calendar.js"></script>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							var unique_id = $.gritter
									.add({
										// (string | mandatory) the heading of the notification
										title : 'Welcome to Dashio!',
										// (string | mandatory) the text inside the notification
										text : 'Hover me to enable the Close Button. You can hide the left sidebar clicking on the button next to the logo.',
										// (string | optional) the image to display on the left
										image : 'img/ui-sam.jpg',
										// (bool | optional) if you want it to fade out on its own or just sit there
										sticky : false,
										// (int | optional) the time you want it to be alive for before fading out
										time : 8000,
										// (string | optional) the class name you want to apply to that specific message
										class_name : 'my-sticky-class'
									});

							return false;
						});
	</script>
	<script type="application/javascript">
		
    $(document).ready(function() {
      $("#date-popover").popover({
        html: true,
        trigger: "manual"
      });
      $("#date-popover").hide();
      $("#date-popover").click(function(e) {
        $(this).hide();
      });

      $("#my-calendar").zabuto_calendar({
        action: function() {
          return myDateFunction(this.id, false);
        },
        action_nav: function() {
          return myNavFunction(this.id);
        },
        ajax: {
          url: "show_data.php?action=1",
          modal: true
        },
        legend: [{
            type: "text",
            label: "Special event",
            badge: "00"
          },
          {
            type: "block",
            label: "Regular event",
          }
        ]
      });
    });

    function myNavFunction(id) {
      $("#date-popover").hide();
      var nav = $("#" + id).data("navigation");
      var to = $("#" + id).data("to");
      console.log('nav ' + nav + ' to: ' + to.month + '/' + to.year);
    }
  
	</script>
	<!-- 테이블 관련  -->

	<script>
		$(document).ready(function() {
			$('#AdminTable').DataTable({
				"columnDefs" : [ {
					"width" : "15%",
					"targets" : 3
				} ]
			});
		});
	</script>

	<script type="text/javascript" charset="utf8"
		src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
	<!-- 테이블 관련 end -->
  <!--common script for all pages-->
  <script src="${pageContext.request.contextPath}/lib/common-scripts.js"></script>
  <!--script for this page-->
  <script src="${pageContext.request.contextPath}/lib/jquery-ui-1.9.2.custom.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/lib/bootstrap-fileupload/bootstrap-fileupload.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/lib/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/lib/bootstrap-daterangepicker/date.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/lib/bootstrap-daterangepicker/daterangepicker.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/lib/bootstrap-daterangepicker/moment.min.js"></script>

  <script src="${pageContext.request.contextPath}/lib/advanced-form-components.js"></script>
</body>
</html>