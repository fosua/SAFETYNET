<%-- 
    Document   : alerts
    Created on : Nov 23, 2015, 12:55:30 AM
    Author     : estelle
--%>
<%@page import="com.ccsna.safetynet.Validation"%>
<%@page import="com.ccsna.safetynet.UserAuthenticator"%>
<%@page import="com.ccsna.ccsna.Member"%>
<%@page import="com.ccsna.ccsna.MemberModel"%>
<%@page import="com.ccsna.ccsna.AgencyModel"%>
<%@page import="com.ccsna.ccsna.News"%>
<%@page import="java.util.List"%>
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
        <link href="<%=request.getContextPath()%>/public/css/jquery.dataTables.css" rel="stylesheet" type="text/css" media="all" />
        <link href="<%=request.getContextPath()%>/public/css/jquery-ui.css" rel="stylesheet" type="text/css" media="all" />
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
            //scrolling
            jQuery(document).ready(function ($) {
                $(".scroll").click(function (event) {
                    event.preventDefault();
                    $('html,body').animate({scrollTop: $(this.hash).offset().top}, 1000);
                });
            });

            //toggle menu
            $("span.menu").click(function () {
                $("ul.nav1").slideToggle(300, function () {
                });
            });

            //pagination for alerts table
            $(document).ready(function () {
                $("#alerts").DataTable({
                    "pagingType": "full_numbers",
                    "oLanguage": {
                        "sEmptyTable": "No Records",
                        "sZeroRecords": "No Records"
                    },
                    "bSort": false
                });
            });


            // slide 4 show up
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
                        <li><a href="<%=request.getContextPath()%>/login/logout?option=1">Logout</a></li> |
                        <li><a href="<%=request.getContextPath()%>/pages/contactUs.jsp">Contact Us</a></li>
                    </ul>
                </div>
            </div>
            <div class="clear"></div>   
        </div>    

        <!-- //header -->
        <div class="header-banner">
            <div class="container">
                <% Long value = 0l;
                    Member loggedInMember = UserAuthenticator.loggedInUser(request.getSession());
                    if (loggedInMember != null) {
                        loggedInMember = new MemberModel().findById(loggedInMember.getMemberId());
                        if (loggedInMember != null) {
                %>
                <div class="banner-navigation">
                    <div class="banner-nav">
                        <span class="menu"><img src="<%=request.getContextPath()%>/public/images/menu.png" alt=" "/></span>
                        <ul class="nav1">
                            <% if (loggedInMember.getRole().equalsIgnoreCase(Menu.AGENCY_ADMIN)) {%>
                            <li class="hvr-sweep-to-top cap"><a href="<%=request.getContextPath()%>/pages/agencyAdmin.jsp">Admin Home</a></li>
                                <% } else {%>
                            <li class="hvr-sweep-to-top cap"><a href="<%=request.getContextPath()%>/pages/member.jsp">Member Home</a></li>
                                <% }%>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/aboutUs.jsp">About Us</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/agencyProfiles.jsp">Agency Profiles</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/alerts.jsp">Alerts</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/donations.jsp">Donations</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/successStory.jsp">Success Stories</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    <center>
        <div class="body_container" id="body_container">
            <script>

                //pop up open and close
                function popupbox_open(el) {
                    window.scrollTo(0, 0);

                    var anchors = document.querySelectorAll('a.pop-up-click');
                    var light = document.querySelectorAll('.pop-up-show');
                    var fade = document.querySelectorAll('.pop-up-fade');

                    for (var i = 0; i < anchors.length; i++) {
                        if (anchors[i] == el) {
                            light[i].style.display = 'block';
                            fade[i].style.display = 'block';
                        }
                    }
                }

                function popupbox_close() {
                    var els = document.querySelectorAll('.pop-up-show, .pop-up-fade');

                    for (var i = 0; i < els.length; i++) {
                        els[i].style.display = 'none';
                    }
                }


            </script>
            <table id="alerts" class="table table-striped table-bordered table-condensed" >
                <thead>
                <th>Date Posted</th>
                <th>Title</th>
                <th>Posted By</th>
                </thead>

                <tbody>
                    <%  value = 0l;
                        List<News> newsList = new NewsModel().findNewsList("news_Type", Menu.ALERT);
                        for (News n : newsList) {
                    %>
                    <tr>
                        <td><%=Menu.convertDateToString(n.getDateCreated(), "MM-dd-yyyy")%></td>
                        <td><a href="#" id="edit" class="pop-up-click"title="Click to View More Info" onclick="popupbox_open(this)"><%=n.getTitle()%></a>
                            <p class="pop-up-show"><b style="color: #ff9900"><i>Message</i></b><br><%=n.getContent()%></p>
                            <p class="pop-up-fade" onClick="popupbox_close()"></p>
                        </td>
                        <td>
                            <% if (n.getCreatedBy() != null && !n.getCreatedBy().isEmpty()) {
                                    Member m = new MemberModel().findById(Integer.parseInt(n.getCreatedBy()));
                                    if (m != null) {
                            %>
                            <%=m.getFirstName() + " " + m.getLastName()%>
                            <% }%>
                        </td>
                    </tr>
                    <% }
                        }%>
                </tbody>
            </table>

        </div>
    </center>
    <% }
        } else {
            String failMsg = "Invalid Access, Login with Username and Password";
            Validation.setAttributes(request, Validation.ERROR, failMsg);
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
         }%>


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

    <!-- here stars scrolling icon -->
    <script type="text/javascript">
        $(document).ready(function () {
            $().UItoTop({easingType: 'easeOutQuart'});

        });
    </script>
    <!-- //here ends scrolling icon -->
</body>
</html>



