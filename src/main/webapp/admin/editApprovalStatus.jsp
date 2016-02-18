<%-- 
    Document   : editApprovalStatus
    Created on : Jan 9, 2016, 4:11:56 PM
    Author     : estelle
--%>
<%@page import="com.ccsna.safetynet.Menu"%>
<%@page import="com.ccsna.safetynet.Validation"%>
<%@page import="com.ccsna.ccsna.SuccessStory"%>
<%@page import="com.ccsna.ccsna.SuccessStoryModel"%>
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
            <%
                String id = request.getParameter("id");
                SuccessStory story = new SuccessStoryModel().getById(Integer.parseInt(id));
                if (story != null) {

            %>

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

            <center>
                <div style=" margin-bottom: 30px; font-weight: bold; color: #1C90F4; margin-left: 0px;"><h3>Success Story Review</h3></div>
                <form class="editAgencyForm" id="editAgencyForm" method="post" action="<%=request.getContextPath()%>/add/successStory" style="margin-top: 20px;">
                    <table>
                        <tbody>
                            <tr>
                                <td>Name </td>
                                <td class="input-padding"><%=story.getFull_name()%></td>
                                <td><div class="formError">${error.fullname}</div></td>
                            </tr>
                            <tr>

                                <td>Email Address</td>
                                <td  class="input-padding"><%=story.getEmail()%></td>
                                <td><div class="formError">${error.emailAddress}</div></td>
                            </tr>
                            <% if (story.getAgency() != null && !story.getAgency().isEmpty()) {%>
                            <tr>

                                <td>Agency/Position</td>
                                <td class="input-padding"><%=story.getAgency()%></td>
                                <td><div class="formError">${error.agency}</div></td>
                            </tr>
                            <% }%>

                            <tr>
                                <td>Date Created</td>
                                <td class="input-padding"><%=Menu.convertDateToString(story.getDateCreated(), Menu.STRING_DATE_FORMAT)%> </td>
                                <td><div class="formError">${error.date_Created}</div></td>
                            </tr>
                            <tr>
                                <td>Content </td>
                                <td class="input-padding"><textarea style="width: 500px; min-height: 200px;"><%=story.getContent()%></textarea></td>
                                <td><div class="formError">${error.fullname}</div></td>
                            </tr>
                            <tr>
                                <td>Approval Status</td>
                                <td class="input-padding">
                                    <select name="approval_Status" style="width: 211px; margin-top: 10px;">
                                        <%=Menu.selectedApprovalStatus(story.getApprovalStatus())%>
                                    </select>
                                    <span class="astereks-required">*</span>
                                </td>
                                <td><div class="formError">${error.approval_Status}</div></td>
                            </tr>


                            <tr>
                                <td><input type="hidden" name="action" value="1"/>
                                    <input type="hidden" name="id" value="<%=story.getSsId()%>"/>
                                </td>
                                <td> <input  type="submit" name="submit"  class="btn btn-info" value="Edit" style="margin-top: 10px; width: 200px;"/></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </form><% }%>
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

</html>
