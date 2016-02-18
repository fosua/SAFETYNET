<%-- 
    Document   : memberEdit
    Created on : Oct 30, 2015, 1:52:31 AM
    Author     : estelle
--%>

<%@page import="com.ccsna.safetynet.Validation"%>
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
        });</script>
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
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/aboutUs.jsp">About Us</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/admin/newsItem.jsp">News/Alerts</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/admin/reviewDonations.jsp">Donations</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/admin/reviewSuccessStory.jsp">Success Stories</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/admin/reviewContactUs.jsp">Contact Us</a></li>
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
    <!-- end of header banner-->
<body>
    <div class="body_container">
        <%
            String id = request.getParameter("id");
            Long value = 0l;
            Member member = new MemberModel().findById(Integer.parseInt(id));
            if (member != null) {

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
            <div class="editHeader"><h3>Edit Member</h3></div>
            <form class="editMemberForm" id="editMemberForm" method="post" action="<%=request.getContextPath()%>/member/add" style="margin-top: 20px;">
                <table>
                    <tbody>
                        <tr>
                            <td>Title </td>
                            <td class="input-padding"><input type="text"  name="title" id="title" value="<%if (member.getTitle() != null && !member.getTitle().isEmpty()) {%><%=member.getTitle()%><% }%>" readonly/> 
                            </td>
                            <td><div class="formError">${error.title}</div></td>
                        </tr>
                        <tr>
                            <td class="input-padding">First Name </td>
                            <td><input type="text"  name="firstName" id="fname" value="<%=member.getFirstName()%>" readonly /> 

                            </td>
                            <td><div class="formError">${error.firstName}</div></td>
                        </tr>
                        <tr>

                            <td >Other Names</td>
                            <td><input type="text"  name="lastName" id="lname" value="<%=member.getLastName()%>" readonly/> 

                            </td>
                            <td><div class="formError">${error.lastName}</div></td>
                        </tr>

                        <tr>
                            <td>Contact Number</td>
                            <td class="input-padding"><input type="text"  name="phoneNumber" id="phoneNumber" value="<% if (member.getPhoneNumber() != null && member.getPhoneNumber() != value) {%><%=member.getPhoneNumber()%> <% }%>" readonly/> 

                            </td>
                            <td><div class="formError">${error.phoneNumber}</div></td>
                        </tr>

                        <tr>
                            <td>Date Created</td>
                            <td class="input-padding"><input name="" value="<%=Menu.convertDateToString(member.getDateCreated(), "MM-dd-yyyy")%>" readonly/>

                            </td>
                            <td><div class="formError">${error.dateCreated}</div></td>
                        </tr>
                        <% if (member.getDateUpdated() != null) {%>
                        <tr>
                            <td>Last Updated</td>
                            <td class="input-padding"> <input value="<%=Menu.convertDateToString(member.getDateUpdated(), "MM-dd-yyyy")%>" readonly/>

                            </td>
                            <td><div class="formError">${error.dateUpdated}</div></td>
                        </tr>
                        <% }%>
                        <tr>
                            <td >Role</td>
                            <td class="input-padding">
                                <select name="role" style="width: 211px;margin-bottom: 10px;">
                                    <%=Menu.selectedRolesMenu(member.getRole())%>
                                </select>

                                <span class="astereks-required">*</span>
                            </td>
                            <td><div class="formError">${error.role}</div></td>
                        </tr>
                        <tr>
                            <td>Status</td>
                            <td class="input-padding">
                                <select name="status" style="width: 211px; ">
                                    <%=Menu.selectedStatusMenu(member.getStatus())%>
                                </select>

                                <span class="astereks-required">*</span>
                            </td>
                            <td><div class="formError">${error.status}</div></td>
                        </tr>
                        
                        


                        <tr>
                            <td><input type="hidden" name="action" value="1"/><input type="hidden" name="option" value="0"/><input type="hidden" name="id" value="<%=member.getMemberId()%>"/></td>
                            <td> <input  type="submit" name="submit"  class="btn btn-info" value="Edit Member" style="margin-top: 10px; width: 200px;"/></td>
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
                    <p class="footer-class"> © 2015 Safety Net Alliance. All rights reserved | <a href="<%=request.getContextPath()%>/public/privacy_policy.pdf" target="_blank">Privacy Policy </a></p>
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
                //validating the member edit form
                //validating the member form
                $("#editMemberForm").validate({
        role: "required",
                status: "required",
                phoneNumber: {
                digits: true,
                        rangelength: [10, 10]
                }
        },
                messages: {
                firstName: "First Name is required",
                        role: "Role is required",
                        status: "Status is required",
                        phoneNumber: {
                        digits: "Contact should be numbers only",
                                rangelength: "Contact Number Length should be 10"
                        }
                }

        });
    </script>
    <!-- //here ends scrolling icon -->
</body>
</html>
