<%-- 
    Document   : reviewSuccessStory
    Created on : Jan 9, 2016, 1:58:56 PM
    Author     : estelle
--%>

<%@page import="com.ccsna.safetynet.Validation"%>
<%@page import="com.ccsna.safetynet.Menu"%>
<%@page import="com.ccsna.ccsna.SuccessStory"%>
<%@page import="java.util.List"%>
<%@page import="com.ccsna.ccsna.SuccessStoryModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>SafetyNet Alliance</title>

        <%-- css --%>
        <link href="<%=request.getContextPath()%>/public/css/style.css" rel="stylesheet" type="text/css" media="all" />
        <link href="<%=request.getContextPath()%>/public/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="<%=request.getContextPath()%>/public/css/jquery.dataTables.css" rel="stylesheet" type="text/css" media="all" />
        <%-- //css --%>

        <%-- fonts --%>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Raleway:400,100,200,300,500,600,700,800,900' rel='stylesheet' type='text/css'>
        <%-- //fonts --%>

        <%-- js --%>
        <script type="text/javascript" src="<%=request.getContextPath()%>/public/js/jquery-1.11.1.min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/public/js/move-top.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/public/js/easing.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/public/js/jquery-ui.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/public/js/jquery.validate.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/public/js/jquery.localScroll.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/public/js/jquery.serialScroll.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/public/js/jquery.dataTables.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/public/js/bootstrap.js"></script>

        <%-- //js --%>

        <%-- for-mobile-apps --%>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="Dental Care Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
              Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
            function hideURLbar(){ window.scrollTo(0,1); } </script>
            <%-- //for-mobile-apps --%>

        <%-- start-smoth-scrolling --%>
        <script type="text/javascript" src="<%=request.getContextPath()%>/public/js/move-top.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/public/js/easing.js"></script>
        <script type="text/javascript">
            jQuery(document).ready(function ($) {
                $(".scroll").click(function (event) {
                    event.preventDefault();
                    $('html,body').animate({scrollTop: $(this.hash).offset().top}, 1000);
                });
            });

        </script>
        <%-- start-smoth-scrolling --%>

    </head>
    <body>
        <!-- header -->	
        <div class="header">
            <div class="left-header">
                <div class="logo-banner">
                    <img src="<%=request.getContextPath()%>/public/images/CCSNABanner.jpg"  />
                </div>
            </div>
            <div class="right-header">
                <div class="right-header-menu">
                    <ul>
                        <li><a href="<%=request.getContextPath()%>/login/logout?option=1">Logout</a></li>|
                        <li><a href="<%=request.getContextPath()%>/pages/contactUs.jsp">Contact Us</a></li> 
                    </ul>
                </div>
            </div>
            <div class="clear"></div>   
        </div>    

        <!-- //header -->
        <div class="header-banner">
            <div class="container">
                <div class="banner-navigation">
                    <div class="banner-nav">
                        <span class="menu"><img src="<%=request.getContextPath()%>/public/images/menu.png" alt=" "/></span>
                        <ul class="nav1">
                            <li class="hvr-sweep-to-top cap"><a href="<%=request.getContextPath()%>/admin/management.jsp">Admin Home</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/aboutUs.jsp">About Us</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/admin/newsItem.jsp">News/Alerts</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/admin/reviewDonations.jsp">Donations</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/admin/reviewSuccessStory.jsp">Success Stories</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/reviewContactUs.jsp">Contact Us</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- script for menu -->
            <script>
                $("span.menu").click(function () {
                    $("ul.nav1").slideToggle(300, function () {
                        // Animation complete.
                    });
                });

                $(document).ready(function () {
                    $("#success_Story_List").DataTable({
                        "pagingType": "full_numbers",
                        "oLanguage": {
                            "sEmptyTable": "No Records",
                            "sZeroRecords": "No Records"
                        },
                        "bSort": false
                    });
                });
            </script>
            <!-- //script for menu -->

            <!-- banner Slider starts Here -->
            <script>
                // You can also use "$(window).load(function() {"
                $(function () {
                    // Slideshow 4
                    $("#slider4").responsiveSlides({
                        auto: true,
                        pager: true,
                        nav: true,
                        speed: 500,
                        namespace: "callbacks",
                        before: function () {
                            $('.events').append("<li>before event fired.</li>");
                        },
                        after: function () {
                            $('.events').append("<li>after event fired.</li>");
                        }
                    });

                });
            </script>				

        </div>
        <div id="body_container" class="body_container">
            <center>
                <% if (request.getSession().getAttribute(Validation.ERROR) != null) {%>
                <div class="alert alert-danger" style="text-align: center">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <%="ERROR: " + request.getSession().getAttribute(Validation.ERROR)%>
                </div>
                <% Validation.removeAttributes(request, Validation.ERROR);
                } else if (request.getSession().getAttribute(Validation.SUCCESS) != null) {%>
                <div class="alert alert-success" style="text-align: center">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <%="SUCCESS: " + request.getSession().getAttribute(Validation.SUCCESS)%>
                </div>
                <%   Validation.removeAttributes(request, Validation.SUCCESS);
                    }%>
                <!--displaying list of all submitted success stories start --> 
                <div class="tap-pane" id="storyList">
                    <table id="success_Story_List" class="table table-striped table-bordered table-condensed" cellspacing="0">
                        <thead>
                        <th>Submitted By</th>
                        <th>Email Address</th>
                        <th>Agency/Position</th>
                        <th>Date Submitted</th>
                        <th>Approval Status</th>
                        </thead>

                        <tbody>
                            <%
                                List<SuccessStory> successStories = new SuccessStoryModel().successStoryList();
                                for (SuccessStory story : successStories) {
                            %>
                            <tr>
                                <td><%=story.getFull_name()%></td>
                                <td><%=story.getEmail()%></td>
                                <td><% if (story.getAgency() != null && !story.getAgency().isEmpty()) {%><%=story.getAgency()%><% }else {%>-<% } %></td>
                                <td><% if (story.getDateCreated() != null) {%><%=Menu.convertDateToString(story.getDateCreated(), "MM-dd-yyyy")%><% } else { %>-<% }%></td>
                                <td><% if (story.getApprovalStatus().equalsIgnoreCase(Menu.PENDING)) {%><a class="btn" href="<%=request.getContextPath()%>/admin/editApprovalStatus.jsp?id=<%=story.getSsId()%>" id="edit" title="Click to Edit Status"><%=Menu.PENDING%></a>
                                    <% } else if (story.getApprovalStatus().equalsIgnoreCase(Menu.APPROVED)) {%> <a  class="btn" style="color: mediumaquamarine"href="#"><%=story.getApprovalStatus()%></a> <% } else if (story.getApprovalStatus().equalsIgnoreCase(Menu.DENIED)) {%> <a  class="btn" style="color: red "href="#"><%=story.getApprovalStatus()%></a> <% }%>
                                </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>

                </div>
                <!-- display end here -->
            </center>
        </div>
        <!-- footer -->
        <div class="footer">
            <div class="container">
                <div class="footer-bottom-at">
                    <div class="col-md-6 footer-grid">
                    </div>
                    <div class="col-md-6 footer-grid-in">
                        <p class="footer-class"> © 2015 Safety Net Alliance. All rights reserved | <a target="_blank" href="<%=request.getContextPath()%>/public/privacy_policy.pdf"  > Privacy Policy </a></p>
                    </div>
                    <div class="clearfix"> </div>
                </div>
            </div>
        </div>

        <!-- //footer -->
    </body>
    <!-- here stars scrolling icon -->
    <script type="text/javascript">
        $(document).ready(function () {
            $().UItoTop({easingType: 'easeOutQuart'});

        });

    </script>
    <!-- //here ends scrolling icon -->
</html>
