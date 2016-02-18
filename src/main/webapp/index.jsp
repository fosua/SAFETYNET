<%-- 
    Document   : index
    Created on : Sep 17, 2015, 12:03:48 PM
    Author     : Esther Amo-Nyarko <estelle_7@ymail.com>
--%>

<%@page import="com.ccsna.ccsna.SuccessStoryModel"%>
<%@page import="com.ccsna.ccsna.SuccessStory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.ccsna.ccsna.News"%>
<%@page import="com.ccsna.safetynet.Menu"%>
<%@page import="com.ccsna.ccsna.NewsModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>SafetyNet Alliance</title>

        <%-- css --%>
        <link href="<%=request.getContextPath()%>/public/css/style.css" rel="stylesheet" type="text/css" media="all" />
        <link href="<%=request.getContextPath()%>/public/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <%-- //css --%>

        <%-- fonts --%>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Raleway:400,100,200,300,500,600,700,800,900' rel='stylesheet' type='text/css'>
        <%-- //fonts --%>

        <%-- js --%>
        <script src="<%=request.getContextPath()%>/public/js/jquery-1.11.1.min.js"></script>
        <script src="<%=request.getContextPath()%>/public/js/responsiveslides.min.js"></script>
        <%-- //js --%>

        <%-- for-mobile-apps --%>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="Dental Care Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
              Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
            function hideURLbar(){ window.scrollTo(0,1); }
        </script>
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
                        <li><a href="<%=request.getContextPath()%>/admin/login.jsp">Member Login</a></li>|
                        <li><a href="<%=request.getContextPath()%>/pages/contactUs.jsp">Contact Us</a></li> 
                    </ul>
                </div>
            </div>
            <div class="clear"></div>   
        </div>    

        <!-- //header -->

        <!-- menu -->	
        <div class="header-banner">
            <div class="container">
                <div class="banner-navigation">
                    <div class="banner-nav">
                        <span class="menu"><img src="<%=request.getContextPath()%>/public/images/menu.png" alt=" "/></span>
                        <ul class="nav1">
                            <li class="hvr-sweep-to-top cap"><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/aboutUs.jsp">About Us</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/news.jsp">News</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/donations.jsp">Donations</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/successStory.jsp">Success Stories</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/contactUs.jsp">Contact Us</a></li>  
                        </ul>
                    </div>
                </div>
            </div>
            <!-- //menu -->
            <!-- script for menu -->
            <script>
                $("span.menu").click(function () {
                    $("ul.nav1").slideToggle(300, function () {
                        // Animation complete.
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
        <!-- end of header banner-->

        <!-- welcome -->
        <div class="welcome">
            <div class="container">
                <div class="welcome-head text-center">
                    <h2>Our Mission</h2>
                    <p>
                        To increase the efficiency and effectiveness of emergency services provided to Clermont County low-income families through collaboration. 
                    </p>
                    <h2>Our Purpose</h2>
                    <p>
                        To provide the most effective emergency assistance continuum for low-income individuals and families in need.
                    </p>
                </div>
                <div class="welcome-grids">
                    <div class="col-md-6 welcome-left">
                        <!-- testimonials -->

                        <div class="testimonials">
                            <h3>Latest Testimonials</h3>

                            <div class="callbacks_container">
                                <ul class="rslides" id="slider3">
                                    <%
                                        ArrayList<SuccessStory> stories = new SuccessStoryModel().successStoryList(0,3);
                                        if (stories != null && !stories.isEmpty()) {
                                            for (SuccessStory story : stories) {

                                    %>
                                    <li>
                                        <div class="testimonials-grids">

                                             <div class="ssStory">
                                                <p><%=story.getContent()%>&Tab;&Tab;&Tab;&Tab;&Tab;<i><b><a href="<%=request.getContextPath()%>/pages/successStory.jsp">. Read More</a></b></i></p>
                                                <p><i>-&nbsp;<%=story.getFull_name()%><%if (story.getAgency() != null && !story.getAgency().isEmpty()) {%><%=", " + story.getAgency()%><% } %></i></p>
                                            </div>

                                        </div>
                                    </li>
                                    <% }
                                        }%>
                                </ul>
                            </div>

                        </div> 
                        <!-- //testimonials -->

                    </div>

                    <div class="col-md-21 welcome-right">

                        <div class="side-bar-menu">
                            <a class="wrapper" href="<%=request.getContextPath()%>/public/IndividualAgreement.pdf" title="One person who is not affiliated with any agency, regularly attends meetings and provides assistance to those in need  of foood, shelter or utilties assistance." target="_blank">
                                <p class="big-text">INDIVIDUAL</p>
                                <p class="tiny-text">How To Become A Member</p>
                            </a>
                        </div>
                        <div class="side-bar-menu">
                            <a title="Any non-profit, business, church, bank, or other agency who supports the collaborative by attending or following the initiative providing monetary, material or community based support otherwise." href="<%=request.getContextPath()%>/public/PartnerAgreement.pdf" target="_blank">
                                <p class="big-text">PARTNER</p>
                                <p class="tiny-text">How To Become A Supporting Partner</p>
                            </a>
                        </div>
                        <div class="side-bar-menu">
                            <a href="<%=request.getContextPath()%>/public/AgencyAgreement.pdf" title="Any non-profit, business, church or agency who has someone who regularly attends meetings and who provides assistance to members of the community by providing either food, shelter, or utilities assistance" target="_blank">
                                <p class="big-text">AGENCY</p>
                                <p class="tiny-text">How To Become A Partner Agency </p>
                            </a>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <!-- //end of welcome -->

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

        <!-- Slider-starts-Here -->
        <script>
            // You can also use "$(window).load(function() {"
            $(function () {
                // Slideshow 4
                $("#slider3").responsiveSlides({
                    auto: true,
                    pager: true,
                    nav: false,
                    pause:true,
                    speed:500,
                    timeout:15000 ,
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
        <!--//End-slider-script -->

        <!-- here stars scrolling icon -->
        <script type="text/javascript">
            $(document).ready(function () {

                $().UItoTop({easingType: 'easeOutQuart'});

            });
        </script>
        <!-- //here ends scrolling icon -->
    </body>
</html>
