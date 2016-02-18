<%-- 
    Document   : aboutUsEdit
    Created on : Jan 4, 2016, 2:15:47 AM
    Author     : estelle
--%>

<%@page import="java.util.List"%>
<%@page import="org.apache.poi.xwpf.usermodel.XWPFParagraph"%>
<%@page import="java.net.URL"%>
<%@page import="com.ccsna.safetynet.DocReadWrite"%>
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
        <script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
        <script>tinymce.init({selector: 'textarea'});</script>

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
                        <li><a href="<%=request.getContextPath()%>/admin/login.jsp">Member Login</a></li>|
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
                            <li style="margin-left: 40px;"class="hvr-sweep-to-top cap"><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/aboutUs.jsp">About Us</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/news.jsp">News</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/donations.jsp">Donations</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/successStory.jsp">Success Stories</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/contactUs.jsp">Contact Us</a></li>  
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
        <div id="body_container" class="body_container">
            <form>
                <table>
                    <tr> 
                    <textarea class="textarea_content">
                        <% List<XWPFParagraph> paragraphs = new DocReadWrite().readDocFile("");
                            for (XWPFParagraph para : paragraphs) {
                        %>
                        <p><%=para.getText()%><br></p>
                            <% }%>
                    </textarea>
                    </tr>
                    <tr><input type="submit" name="submit"  class="btn btn-info" value="Submit" style="margin-top: 10px; width: 100px; float: right;"/></tr>
                </table>
            </form>
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
    </body>

    <!-- //footer -->

    <!-- here stars scrolling icon -->
    <script type="text/javascript">
        $(document).ready(function () {
            $().UItoTop({easingType: 'easeOutQuart'});

        });

    </script>
    <!-- //here ends scrolling icon -->
</html>
