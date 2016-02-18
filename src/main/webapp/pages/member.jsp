<%-- 
    Document   : member
    Created on : Oct 29, 2015, 5:17:40 PM
    Author     : estelle
--%>

<%@page import="com.ccsna.ccsna.NewsModel"%>
<%@page import="com.ccsna.ccsna.News"%>
<%@page import="com.ccsna.ccsna.MemberModel"%>
<%@page import="com.ccsna.safetynet.Validation"%>
<%@page import="com.ccsna.ccsna.Member"%>
<%@page import="com.ccsna.safetynet.UserAuthenticator"%>
<%@page import="com.ccsna.safetynet.Menu"%>
<%@page import="com.ccsna.ccsna.County"%>
<%@page import="com.ccsna.ccsna.Services"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="com.ccsna.ccsna.AgencyModel"%>
<%@page import="com.ccsna.ccsna.Agency"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SafetyNet Alliance </title>

        <%-- css --%>
        <link href="<%=request.getContextPath()%>/public/css/style.css" rel="stylesheet" type="text/css" media="all" />
        <link href="<%=request.getContextPath()%>/public/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="<%=request.getContextPath()%>/public/css/jquery.dataTables.css" rel="stylesheet" type="text/css" media="all" />
        <link href="<%=request.getContextPath()%>/public/css/jquery-ui.css" rel="stylesheet" type="text/css" media="all" />
        <link href="<%=request.getContextPath()%>/public/css/datepicker.css" rel="stylesheet" type="text/css" media="all" />

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
                            <li class="hvr-sweep-to-top cap"><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/aboutUs.jsp">About Us</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/agencyProfiles.jsp">Agency Profiles</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/alerts.jsp">Alerts</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/donations.jsp">Donations</a></li>
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/pages/successStory.jsp">Success Stories</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- script for menu -->
            <script>
                $("span.menu").click(function () {
                    $("ul.nav1").slideToggle(300, function () {
                    });
                });
                $(function () {
                    $("#tabs").tabs({
                        active: 0
                    });

                });
                $(document).ready(function () {
                    $("#agencyListTable").DataTable({
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
            <script src="<%=request.getContextPath()%>/public/js/responsiveslides.min.js"></script>
            <script>                 // You can also use "$(window).load(function() {"
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

                $(document).ready(function () {
                    $("#alertList").DataTable({
                        "pagingType": "full_numbers",
                        "oLanguage": {
                            "sEmptyTable": "No Records",
                            "sZeroRecords": "No Records"
                        },
                        "bSort": false
                    });
                });
            </script>

        </div>

        <div class="body_container" id="body_container">
            <%  Long value = 0l;
                Member loggedInMember = UserAuthenticator.loggedInUser(request.getSession());
                if (loggedInMember != null) {
                    loggedInMember = new MemberModel().findById(loggedInMember.getMemberId());
                    if (loggedInMember != null) {
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
                <div class="widget-box" id="tabs">

                    <div class="widget-title">

                        <ul class="nav nav-tabs" id="myTab">
                            <li class="nav-tabs-title"><a href="#members" data-toggle="tab">Members</a></li>
                            <li class="nav-tabs-title"><a href="#pInfo" data-toggle="">Personal Info</a></li>
                            <li class="nav-tabs-title"><a href="#alert" data-toggle="tab">Add Alert</a></li>
                            <li class="nav-tabs-title"><a href="#listAlert" data-toggle="tab">Added Alerts</a></li>
                            <li class="nav-tabs-title"><a href="#changePs" data-toggle="tab">Change Password</a></li>
                        </ul>

                    </div>

                    <div class="widget-content padding">

                        <div class="tab-content">

                            <div class="tab-pane" id="members" >
                                <table id="agencyListTable" class="table table-striped table-bordered table-condensed" >
                                    <thead>
                                    <th>No</th>
                                    <th>Name</th>
                                    <th>Private Contact</th>
                                    <th>Email Address</th>
                                    <th>Role</th>
                                    </thead>

                                    <tbody>
                                        <%  int count = 1;
                                            List<Member> members = new MemberModel().AgencyMemberList(loggedInMember.getAgency().getAgencyId());
                                            for (Member a : members) {
                                        %>
                                        <tr>
                                            <td><%=count++%></td>
                                            <td><%=a.getFirstName() + " " + a.getLastName()%></td>
                                            <td><%if (a.getPhoneNumber() != null && a.getPhoneNumber().compareTo(value) == 1) {%> 
                                                <%=a.getPhoneNumber()%>  <% } else { %> - <% }%>
                                            </td> 
                                            <td><%=a.getEmailAddress()%></td>
                                            <td><%=a.getRole()%></td>

                                        </tr>
                                        <% }%>
                                    </tbody>
                                </table>

                            </div>
                            <div class="tab-pane" id="pInfo" >
                                <form id="personalInfo" method="post" action="<%=request.getContextPath()%>/member/edit" style="float: left; margin-top: 20px;">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>Title</td>
                                                <td><input type="text"  name="title" id="title" value="<%if (loggedInMember.getTitle() != null && !loggedInMember.getTitle().isEmpty()) {%><%=loggedInMember.getTitle()%><% }%>"/> 
                                                </td>
                                                <td><div class="formError">${error.title}</div></td>

                                            </tr>
                                            <tr>
                                                <td>First Name </td>
                                                <td><input type="text"  name="firstName" id="firstName" value="<%=loggedInMember.getFirstName()%>"/> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.firstName}</div></td>

                                            </tr>
                                            <tr>
                                                <td>Other Names</td>
                                                <td><input type="text"  name="lastName" id="lastName" value="<%=loggedInMember.getLastName()%>"/> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.lastName}</div></td>

                                            </tr>
                                            <tr>
                                                <td>Email Address&nbsp;</td>
                                                <td><input type="text"  name="username" id="username" value="<%=loggedInMember.getEmailAddress()%>"/> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.username}</div></td>

                                            </tr>
                                            <tr>
                                                <td>Contact</td>
                                                <td><input type="text"  name="phoneNumber" id="phoneNumber" 
                                                           value="<% if (loggedInMember.getPhoneNumber() != null && (loggedInMember.getPhoneNumber().compareTo(value) == 1)) {%><%=loggedInMember.getPhoneNumber()%><% }%>"/>

                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.phoneNumber}</div></td>

                                            </tr>
                                            <tr>
                                                <td>Role</td>
                                                <td><input type="text"  name="role" id="role" value="<%=loggedInMember.getRole()%>"  readonly/> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.role}</div></td>

                                            </tr>
                                            <tr>
                                                <td><input type="hidden" name="option" value="0"/>
                                                    <input type="hidden" name="id" value="<%=loggedInMember.getMemberId()%>"/></td>
                                                <td> <input id="submitBtn" type="submit" name="submit"  class="btn btn-info" value="EDIT"/></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form>
                            </div>
                            <div class="tab-pane" id="alert">
                                <form id="newsForm" method="post" action="<%=request.getContextPath()%>/admin/news/add" enctype="multipart/form-data">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>Title </td>
                                                <td class="input-padding"><input type="text"  name="newsTitle" id="newsTitle"/>
                                                    <span class="astereks-required">*</span> 
                                                </td>
                                                <td><div class="formError">${error.title}</div></td>
                                            </tr>


                                            <tr>
                                                <td>Start Date</td>
                                                <td class="input-padding"><input type="text" name="start_Date" id="start_Date"/>
                                                </td>
                                                <td><div class="formError">${error.start_Date}</div></td>

                                            </tr>
                                            <tr>
                                                <td>End Date</td>
                                                <td class="input-padding"><input type="text" name="end_Date" id="end_Date"/>
                                                </td>
                                                <td><div class="formError">${error.end_Date}</div></td>

                                            </tr>
                                            <tr> 
                                                <td>Content</td>
                                                <td class="input-padding"><textarea name="content" style=" min-height:200px; width: 400px;"></textarea> 

                                                </td>
                                                <td><div class="formError">${error.content}</div></td> 
                                            </tr>

                                            <tr>
                                                <td> Upload Image&nbsp;</td>
                                                <td class="input-padding"><input type="file" name="attachment"/></td>
                                                <td><div class="formError">${error.attachment}</div></td>
                                            </tr>
                                            <tr>
                                                <td><input type="hidden" name="action" value="0"/><input type="hidden" name="type" value="<%=Menu.ALERT%>"/></td>
                                                <td> <input  type="submit" name="submit"  class="btn btn-info" value="Add News/Alert " style="margin-top: 10px; width: 200px;"/></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form>
                            </div>
                            <div class="tab-pane" id="listAlert">
                                <table id="alertList" class="table table-striped table-bordered table-condensed" >
                                    <thead>
                                    <th>No</th>
                                    <th>Title</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th></th>
                                    </thead>

                                    <tbody>
                                        <%  count = 1;
                                            List<News> news = new NewsModel().findByCreatedBy(Menu.ALERT, String.valueOf(loggedInMember.getMemberId()));
                                            for (News n : news) {
                                        %>
                                        <tr>
                                            <td><%=count++%></td>
                                            <td><%=n.getTitle()%></td>
                                            <td><%if (n.getStartDate() != null) {%><%=Menu.convertDateToString(n.getStartDate(), "MM-dd-yyyy")%><% } else { %> -<% }%></td>
                                            <td><%if (n.getEndDate() != null) {%><%=Menu.convertDateToString(n.getEndDate(), "MM-dd-yyyy")%><% } else { %> -<% }%></td>
                                            <td><a class="btn" href="<%=request.getContextPath()%>/pages/memberAlert.jsp?id=<%=n.getNewsId()%>" title="Click to Edit/View" id="edit">Edit</a></td> 
                                        </tr>
                                        <% }%>
                                    </tbody>
                                </table>    
                            </div>
                            <div class="tab-pane" id="changePs" >
                                <form id="changePsWord" method="POST" action="<%=request.getContextPath()%>/member/edit" class="" style="float: left; margin-top: 20px;">
                                    <table>
                                        <tbody>

                                            <tr>
                                                <td>Old Password</td>
                                                <td><input type="password"  name="oldPassword" id="oldPassword"/> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.oldPassword}</div></td>

                                            </tr>
                                            <tr>
                                                <td>New Password</td>
                                                <td><input type="password"  name="newPassword" id="newPassword"/> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.newPassword}</div></td>

                                            </tr>
                                            <tr>
                                                <td>Confirm New Password&nbsp;&nbsp;</td>
                                                <td><input type="password"  name="confirmPassword" id="confirmPassword"/> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.confirmPassword}</div></td>

                                            </tr>

                                            <tr>
                                                <td><input type="hidden" name="option" value="1"/>
                                                    <input type="hidden" name="id" value="<%=loggedInMember.getMemberId()%>"/>
                                                    <input type="hidden" name="username" value="<%=loggedInMember.getUsername()%>"/></td>
                                                <td> <input id="submitBtn" type="submit" name="submit"  class="btn btn-info" value="CHANGE"/></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form>
                            </div>

                        </div>

                    </div>
                </div>
            </center>

            <% }
                } else {
                    String failMsg = "Invalid Access, Login with Username and Password";
                    Validation.setAttributes(request, Validation.ERROR, failMsg);
                    response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
                }%>
        </div>

        <!--default footer starts here-->
        <%@include file="../default/footer.jsp" %>
        <!--default footer ends here-->
        <script>
            //validating the change password form
            $("#changePsWord").validate({
                rules: {
                    newPassword: {
                        required: true,
                        minlength: 6
                    },
                    confirmPassword: {
                        required: true,
                        minlength: 6,
                        equalTo: "#newPassword"
                    },
                    oldPassword: "required"
                },
                messages: {
                    newPassword: {
                        required: "New Password is required",
                        minlength: "Password length should be at least 6"
                    },
                    confirmPassword: {
                        required: "Confirm Password field is required",
                        minlength: "Password length should be at least 6",
                        equalTo: "New passwords do not match"
                    },
                    oldPassword: "Old password field is required"
                }
            });

            //validating the info form
            $("#personalInfo").validate({
                rules: {
                    firstName: "required",
                    otherNames: "required",
                    username: {
                        required: true,
                        email: true
                    }
                },
                messages: {
                    firstName: "required",
                    otherNames: "required",
                    username: {
                        required: true,
                        email: true,
                        remote: "Email already exist!"
                    }
                }
            });
        </script>
    </body>
</html>
