<%-- 
    Document   : reviewSuccessStory
    Created on : Jan 9, 2016, 1:58:56 PM
    Author     : estelle
--%>

<%@page import="com.ccsna.ccsna.News"%>
<%@page import="com.ccsna.ccsna.NewsModel"%>
<%@page import="com.ccsna.safetynet.Validation"%>
<%@page import="com.ccsna.safetynet.Menu"%>
<%@page import="java.util.List"%>
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
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/admin/news.jsp">News</a></li>
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
                <div class="body_container" id="body_container">
                    <div id="ssList">
                        <%  int counter = 1;
                            List<News> newsList = new NewsModel().findNewsList("news_Type", Menu.NEWS, 0, 5);
                            for (News n : newsList) {
                                if (counter % 2 != 0) {

                        %> 
                        <div style = "background-color: #F9F9FF" class="news_item">
                            <p><i><b><%=n.getTitle().toUpperCase()%></b>&nbsp;- &nbsp;Posted on &Tab;<%=Menu.convertDateToString(n.getDateCreated(), "MM-dd-yyyy")%>.</i>
                                &nbsp;<% if (n.getLarge_File_Name() != null && !n.getLarge_File_Name().isEmpty()) {%><a href="<%=request.getContextPath()%>/<%=n.getLarge_File_Name()%>" target="_blank">Click To Read News Content</a><%}%>
                            </p>
                        </div>
                        <% } else {%>
                        <div style = "background-color:#d9edf7" class="news_item">
                            <p><i><b><%=n.getTitle().toUpperCase()%></b>&nbsp;- &nbsp;Posted on &Tab;<%=Menu.convertDateToString(n.getDateCreated(), "MM-dd-yyyy")%>.</i>
                                &nbsp;<% if (n.getLarge_File_Name() != null && !n.getLarge_File_Name().isEmpty()) {%><a href="<%=request.getContextPath()%>/<%=n.getLarge_File_Name()%>" target="_blank">Click To Read News Content</a><%}%>
                            </p>
                        </div>

                        <% }
                                counter++;
                            }%>
                    </div>
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

        var i = 0;
        function yHandler() {
            var wrap = document.getElementById('ssList');
            var contentHeight = wrap.offsetHeight;
            var yOffset = window.pageYOffset;
            var y = yOffset + window.innerHeight;
            if (y >= contentHeight) {
                i = i + 5;
                console.log("i is : " + i);
                $.ajax({
                    type: "POST",
                    url: "<%=request.getContextPath()%>/news/load",
                    data: {"row": i
                    },
                    //contentType: "application/json; charset=utf-8",
                    //dataType: "json",
                    //async: true,
                    cache: false,
                    success: function (response)
                    {
                        $("#ssList").append(response);

                    },
                    error: function (response)
                    {

                    }
                });
            }

        }
        window.onscroll = yHandler;

    </script>
    <!-- //here ends scrolling icon -->
</html>
