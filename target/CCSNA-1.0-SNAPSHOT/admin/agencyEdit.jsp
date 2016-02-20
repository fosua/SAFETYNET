<%-- 
    Document   : agencyEdit
    Created on : Nov 5, 2015, 2:01:38 PM
    Author     : estelle
--%>

<%@page import="com.ccsna.safetynet.Validation"%>
<%@page import="com.ccsna.ccsna.Services"%>
<%@page import="com.ccsna.ccsna.County"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="com.ccsna.ccsna.AgencyModel"%>
<%@page import="com.ccsna.ccsna.Agency"%>
<%@page import="com.ccsna.ccsna.Member"%>
<%@page import="com.ccsna.ccsna.MemberModel"%>
<%@page import="com.ccsna.safetynet.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <title>SafetyNet Alliance</title>

    <%-- css --%>
    <link href="<%=request.getContextPath()%>/public/css/style.css" rel="stylesheet" type="text/css" media="all" />
    <link href="<%=request.getContextPath()%>/public/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <link href="<%=request.getContextPath()%>/public/css/jquery-ui.css" rel="stylesheet" type="text/css" media="all" />
    <%-- //css --%>

    <%-- fonts --%>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,100,200,300,500,600,700,800,900' rel='stylesheet' type='text/css'>
    <%-- //fonts --%>

    <%-- js --%>        
    <script type="text/javascript" src="<%=request.getContextPath()%>/public/js/bootstrap-datepicker.js"></script>
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
            <div class="banner-navigation">
                <div class="banner-nav">
                    <span class="menu"><img src="<%=request.getContextPath()%>/public/images/menu.png" alt=" "/></span>
                    <ul class="nav1">
                        <li class="hvr-sweep-to-top cap"><a href="<%=request.getContextPath()%>/admin/management.jsp">Admin Home</a></li>
                        <li class="hvr-sweep-to-top"><a href="#">About Us</a></li>
                        <li class="hvr-sweep-to-top"><a href="#">News/Alerts</a></li>
                        <li class="hvr-sweep-to-top"><a href="#">Donations</a></li>
                        <li class="hvr-sweep-to-top"><a href="#">Success Stories</a></li>
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
            }
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
            });</script>				

    </div>
    <div class="body_container">
        <%
            String id = request.getParameter("id");
            Agency agency = new AgencyModel().findById(Integer.parseInt(id));
            if (agency != null) {

        %>
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
            <div class="editHeader" ><h3>Agency Profile</h3></div>
            <form class="editAgencyForm" id="editAgencyForm" method="post" action="<%=request.getContextPath()%>/member/add" style="margin-top: 20px;">
                <table>
                    <tbody>
                        <tr>
                            <td>Name </td>
                            <td class="input-padding"><%=agency.getFullname()%></td>
                            <td><div class="formError">${error.fullname}</div></td>
                        </tr>
                        <% if (agency.getPrivateContactNumber() != null && agency.getPrivateContactNumber() != 0l) {%>
                        <tr>
                            <td>Contact Number</td>
                            <td class="input-padding"><%=agency.getPrivateContactNumber()%></td>
                            <td><div class="formError">${error.private_Contact_Number}</div></td>
                        </tr>
                        <% }%>
                        <tr>

                            <td>Email Address</td>
                            <td  class="input-padding"><%=agency.getEmailAddress()%></td>
                            <td><div class="formError">${error.emailAddress}</div></td>
                        </tr>
                        <% if (agency.getWebsiteAddress() != null && !agency.getWebsiteAddress().isEmpty()) {%>
                        <tr>

                            <td>Web Site</td>
                            <td class="input-padding"><%=agency.getWebsiteAddress()%></td>
                            <td><div class="formError">${error.website_Address}</div></td>
                        </tr>
                        <% }%>
                        <% if (!Menu.agencyAddress(agency).isEmpty()) {%>
                        <tr>
                            <td>Address</td>
                            <td class="input-padding"><%=Menu.agencyAddress(agency)%> </td>
                            <td><div class="formError">${error.address}</div></td>
                        </tr>
                        <% } %>
                        <%if (agency.getMission() != null && !agency.getMission().isEmpty()) {%>
                        <tr>
                            <td>Mission Statement&nbsp;&nbsp;</td>
                            <td class="input-padding"><%=agency.getMission()%></td>
                            <td><div class="formError">${error.mission}</div></td>
                        </tr>
                        <% } %>

                    <td>Counties Served</td>
                    <td class="input-padding">
                        <%Set cList = agency.getCounties();
                            int i = 0;
                            for (Iterator itr = cList.iterator(); itr.hasNext();) {
                                County c = (County) itr.next();
                                i++;
                                if (agency.getCounties().size() > i) {%>
                        <%=c.getCountyName()%>,  
                        <%} else {%>
                        <%=c.getCountyName()%>
                        <% }%>
                        <% }%>

                    </td>
                    <td><div class="formError">${error.counties_Served}</div></td>
                        <%  Set sList = agency.getServiceses();
                            if (!sList.isEmpty() && sList != null) {
                                i = 0;
                        %>
                    <tr>
                        <td>Services Provided</td>
                        <td class="input-padding">
                            <%for (Iterator itr = sList.iterator(); itr.hasNext();) {
                                    Services s = (Services) itr.next();
                                    i++;
                                    if (agency.getServiceses().size() > i) {%>
                            <%=s.getServiceName()%>, &nbsp;  
                            <%} else {%>
                            <%=s.getServiceName()%>
                            <% }%>  </td>
                        <td><div class="formError">${error.service_Provided}</div></td>
                    </tr>
                    <% }
                        }%>

                    
                        <%if (agency.getHoursOfOperation() != null && !agency.getHoursOfOperation().isEmpty()) {%>
                    <tr>
                        <td>Hours of Operations&nbsp;</td>
                        <td class="input-padding"><%=agency.getHoursOfOperation()%></td>
                        <td><div class="formError">${error.hours_Of_Operation}</div></td>
                    </tr>
                    <% } %>
                    <%if (agency.getBoardPositions() != null && !agency.getBoardPositions().isEmpty()) {%>
                    <tr>
                        <td>Board Positions &nbsp;&nbsp;</td>
                        <td class="input-padding"><%=agency.getBoardPositions()%></td>
                        <td><div class="formError">${error.board_Positions}</div></td>
                    </tr>
                    <% }%>
                    <tr>
                        <td>Date Created</td>
                        <td class="input-padding"><%=Menu.convertDateToString(agency.getDateCreated(), Menu.STRING_DATE_FORMAT)%> </td>
                        <td><div class="formError">${error.date_Created}</div></td>
                    </tr>
                    <% if (agency.getDateUpdated() != null) {%>
                    <tr>
                        <td>Last Updated</td>
                        <td class="input-padding"><%=Menu.convertDateToString(agency.getDateUpdated(), Menu.STRING_DATE_FORMAT)%> </td>
                        <td><div class="formError">${error.date_Updated}</div></td>
                    </tr>
                    <% }%>
                    <tr>
                        <td>Status</td>
                        <td class="input-padding">
                            <select name="status" style="width: 211px; margin-top: 10px;">
                                <%=Menu.selectedStatusMenu(agency.getStatus())%>
                            </select>

                            <span class="astereks-required">*</span>
                        </td>
                        <td><div class="formError">${error.status}</div></td>
                    </tr>

                    <tr>
                        <td><input type="hidden" name="action" value="4"/>
                            <input type="hidden" name="option" value="1"/>
                            <input type="hidden" name="id" value="<%=agency.getAgencyId()%>"/>
                        </td>
                        <td> <input  type="submit" name="submit"  class="btn btn-info" value="Edit Agency Status" style="margin-top: 10px; width: 200px;"/></td>
                        <td></td>
                    </tr>
                    </tbody>
                </table>
            </form>
        </center>
        <% }%>
    </div>
    <!-- footer -->
    <div class="footer">
        <div class="container">
            <div class="footer-bottom-at">
                <div class="col-md-6 footer-grid">
                </div>
                <div class="col-md-6 footer-grid-in">
                    <p class="footer-class"> © 2015 Safety Net Alliance. All rights reserved | <a href="<%=request.getContextPath()%>/public/privacy_policy.pdf">Privacy Policy </a></p>
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

        //validating the agency edit form
        $("#editAgencyForm").validate({
            rules: {
                status: "required"
            },
            messages: {
                status: "Status is required"
            }

        });
    </script>
    <!-- //here ends scrolling icon -->
</body>
</html>
