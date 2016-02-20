<%-- 
    Document   : addMember
    Created on : Oct 6, 2015, 1:01:56 AM
    Author     : Esther Amo-Nyarko <estelle_7@ymail.com>
--%>



<%@page import="com.ccsna.safetynet.UserAuthenticator"%>
<%@page import="com.ccsna.safetynet.Validation"%>
<%@page import="com.ccsna.ccsna.News"%>
<%@page import="com.ccsna.ccsna.NewsModel"%>
<%@page import="com.ccsna.safetynet.Menu"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="com.ccsna.ccsna.Agency"%>
<%@page import="com.ccsna.ccsna.AgencyModel"%>
<%@page import="com.ccsna.ccsna.Member"%>
<%@page import="com.ccsna.ccsna.MemberModel"%>
<%@page import="com.ccsna.ccsna.ServiceModel"%>
<%@page import="com.ccsna.ccsna.Services"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ccsna.ccsna.County"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ccsna.ccsna.CountyModel"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SafetyNet Alliance </title>

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
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="Dental Care Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
              Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
            function hideURLbar(){ window.scrollTo(0,1); } 
        </script>
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
                            <li class="hvr-sweep-to-top"><a href="<%=request.getContextPath()%>/admin/news.jsp">News</a></li>
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
                $(document).ready(function () {
                    $("#memberListTable").DataTable({
                        "pagingType": "full_numbers",
                        "oLanguage": {
                            "sEmptyTable": "No Records",
                            "sZeroRecords": "No Records"
                        },
                        "bSort": false
                    });
                });
                $(document).ready(function () {
                    $("#serviceListTable").DataTable({
                        "pagingType": "full_numbers",
                        "oLanguage": {
                            "sEmptyTable": "No Records",
                            "sZeroRecords": "No Records"
                        },
                        "bSort": false
                    });
                });

                $(document).ready(function () {
                    $("#start_Date").datepicker({
                        dateFormat: "yy-m-dd"
                    });
                    $("#end_Date").datepicker({
                        dateFormat: "yy-m-dd"
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
                });</script>

        </div>

        <!-- end of header banner-->
        <div id="body_container" class="body_container">
            <% Long value = 0l;
                Member loggedInMember = UserAuthenticator.loggedInUser(request.getSession());
                if (loggedInMember != null) {
                    loggedInMember = new MemberModel().findById(loggedInMember.getMemberId());
                    if (loggedInMember != null && loggedInMember.getRole().equalsIgnoreCase(Menu.SUPER_ADMIN)) {
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
                <div class="widget-box" id="tabs">

                    <div class="widget-title">

                        <ul class="nav nav-tabs" id="myTab">
                            <li class=""><a href="#memTab" data-toggle="tab">Add Member</a></li>
                            <li class=""><a href="#membList" data-toggle="tab">Member List</a></li>
                            <li class=""><a href="#agcy" data-toggle="tab">Add Agency</a></li>
                            <li class=""><a href="#agcyList" data-toggle="tab">Agency List</a></li>
                            <li class=""><a href="#serv" data-toggle="tab">General Services</a></li>
                            <li class=""><a href="#newEvt" data-toggle="tab">News/Alerts</a></li>
                            <li class=""><a href="#newEvtList" data-toggle="tab">All New/Alerts</a></li>

                        </ul>

                    </div>
                    <div class="widget-content padding">

                        <div class="tab-content">

                            <div class="tab-pane" id="memTab" >
                                <form class="addMemberForm" id="addMemberForm" method="post" action="<%=request.getContextPath()%>/member/add" style="margin-top: 20px;">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>Title </td>
                                                <td class="input-padding"><input type="text"  name="title" id="title"/> 
                                                </td>
                                                <td><div class="formError">${error.title}</div></td>
                                                <td>Email Address</td>
                                                <td class="input-padding"><input type="text"  name="emailAddress" id="email"/> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.emailAddress}</div></td>
                                            </tr>
                                            <tr>
                                                <td class="input-padding">First Name </td>
                                                <td><input type="text"  name="firstName" id="fname"/> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.firstName}</div></td>

                                                <td >Other Names</td>
                                                <td><input type="text"  name="lastName" id="lname"/> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.lastName}</div></td>
                                            </tr>
                                            <tr>
                                                <td>Password</td>
                                                <td><input type="password"  name="password" id="user_password"/> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.Password}</div></td> 
                                                <td>Confirm Password</td>
                                                <td><input type="password"  name="confirm_Password" /> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.confirm_Password}</div></td> 
                                            </tr>
                                            <tr>
                                                <td>Contact Number</td>
                                                <td class="input-padding"><input type="text"  name="phoneNumber" id="phoneNumber"/> 

                                                </td>
                                                <td><div class="formError">${error.phoneNumber}</div></td>

                                                <td>Agency</td>
                                                <td>
                                                    <select name="agencyId" id="agencyId" style="width: 201px;">
                                                        <option value="">Select Agency </option>
                                                        <% ArrayList<Agency> agency = new AgencyModel().listAgency();
                                                            if (agency != null && !agency.isEmpty()) {
                                                                for (Agency a : agency) {%>
                                                        <option value="<%=a.getAgencyId()%>"><%=a.getFullname()%> </option>
                                                        <% }
                                                            }%>
                                                    </select>
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.agencyId}</div></td>

                                            </tr>


                                            <tr>   
                                                <td>Role</td>
                                                <td class="input-padding">
                                                    <select name="role" style="width: 201px;" >
                                                        <option value="">Select Role</option>
                                                        <% for (int i = 0; i < Menu.roles().size(); i++) {%>
                                                        <option value="<%=Menu.roles().get(i)%>"><%=Menu.roles().get(i)%></option>
                                                        <% }%>
                                                    </select>
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.role}</div></td>
                                                <td><input type="hidden" name="action" value="0"/><input type="hidden" name="option" value="0"/></td>
                                                <td> <input  type="submit" name="submit"  class="btn btn-info" value="Add Member" style="margin-top: 10px; width: 200px;"/></td>
                                                <td></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form></div><!--add member ends here -->

                            <!--displaying list of members start here --> 
                            <div class="tap-pane" id="membList">
                                <div><a href="<%=request.getContextPath()%>/export/excel" id="edit" style="float: right; margin-bottom: 10px;">Export Member List</a></div>
                                <table id="memberListTable" class="table table-striped table-bordered table-condensed" cellspacing="0">
                                    <thead>
                                    <th>No</th>
                                    <th>Name</th>
                                    <th>Agency</th>
                                    <th>Role</th>
                                    <th>Contact Number</th>
                                    <th>Email Address</th>
                                    <th>Action</th>
                                    </thead>

                                    <tbody>
                                        <%
                                            int count = 1;
                                            List<Member> members = new MemberModel().memberList();
                                            if (members != null && !members.isEmpty())
                                                for (Member m : members) {
                                        %>
                                        <tr>
                                            <td><%=count++%></td>
                                            <td><%=m.getFirstName()%> &nbsp; <%=m.getLastName()%></td>
                                            <td><%=m.getAgency().getFullname()%></td>
                                            <td><%=m.getRole()%></td>
                                            <td><%if (m.getPhoneNumber() != null && (m.getPhoneNumber().compareTo(value) == 1)) {%><%=m.getPhoneNumber()%> <% } else { %>-<% }%>
                                            </td>
                                            <td><%=m.getEmailAddress()%></td>
                                            <td> <a class="btn" href="<%=request.getContextPath()%>/admin/memberEdit.jsp?id=<%=m.getMemberId()%>" id="edit" title="Click to Edit">Edit</a></td> 
                                        </tr>
                                        <% }%>
                                    </tbody>
                                </table>

                            </div>
                            <!--displaying list of members ends here --> 

                            <!--adding and displaying service list --> 
                            <div class="tab-pane" id="serv">
                                <form class="addService" method="post" action="<%=request.getContextPath()%>/member/add" id="addService" style="margin-bottom: 30px;">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>Name of Service &nbsp;</td>
                                                <td class="input-padding"><input type="text"  name="serviceName" id="serviceName"/> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.serviceName}</div></td>
                                            </tr>
                                            <tr>
                                                <td>Type</td>
                                                <td class="input-padding">
                                                    <select name="type" style="width: 201px;" >
                                                        <option value="" style="color: tomato"> Select Service Type</option>
                                                        <% for (int i = 0; i < Menu.serviceType().size(); i++) {%>
                                                        <option value="<%=Menu.serviceType().get(i)%>"><%=Menu.serviceType().get(i)%></option>
                                                        <% } %>
                                                    </select>
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.type}</div></td>
                                            </tr>

                                            <tr>
                                                <td><input type="hidden" name="action" value="0"/>
                                                    <input type="hidden" name="option" value="2"/>
                                                </td>
                                                <td> <input  type="submit" name="submit"  class="btn btn-info" value="Add Service" style="margin-top: 10px;"/></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form><br>
                                <div>
                                    <table id="serviceListTable" class="table table-striped table-bordered table-condensed" data-rowlink="a">
                                        <thead>
                                        <th>No</th>
                                        <th>Name</th>
                                        <th>Type</th>
                                        <th>Action</th>
                                        </thead>

                                        <tbody>
                                            <%  count = 1;
                                                List<Services> serv = new ServiceModel().serviceList();
                                                for (Services s : serv) {
                                            %>
                                            <tr>
                                                <td><%=count++%></td>
                                                <td><%=s.getServiceName()%></td>
                                                <td><%=s.getService_Type()%></td>
                                                <td> <a class="btn" href="<%=request.getContextPath()%>/admin/serviceEdit.jsp?id=<%=s.getServiceId()%>" title="Click to View/Edit" id="edit">Edit</a></td> 
                                            </tr>
                                            <% }%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <!--adding and displaying service list ends here --> 
                            <div class="tap-pane" id="agcy">
                                <form class="agencyForm" id="agencyForm" method="post" action="<%=request.getContextPath()%>/member/add" accept-charset="utf-8">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>Agency Name </td>
                                                <td class="input-padding">
                                                    <input type="text"  name="fullName" id="fullName"/> <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.fullName}</div></td>
                                                <td>Web Site</td>
                                                <td class="input-padding"><input type="text"  name="website_Address" id="website_Address"/> 
                                                </td>
                                                <td><div class="formError">${error.website_Address}</div></td>
                                            </tr>

                                            <tr>
                                                <td>Private Contact Number</td>
                                                <td><input type="text"  name="private_Contact_Number" id="private_Contact_Number" /> 
                                                </td>
                                                <td><div class="formError">${error.private_Contact_Number}</div></td>
                                                <td>Public Contact Number&nbsp;</td>
                                                <td><input type="text"  name="public_Contact_Number" id="public_Contact_Number" /> 
                                                </td>
                                                <td><div class="formError">${error.public_Contact_Number}</div></td>
                                            </tr>
                                            <tr>

                                                <td>Password</td>
                                                <td><input type="password"  name="password" id="password_modal" /> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.Password}</div>
                                                <td>Confirm Password</td>
                                                <td><input type=password  name="confirm_password"  /> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.confirm_password}</div>
                                            </tr>
                                            <tr></tr>
                                            <tr >


                                                <td>Email Address </td>
                                                <td class="input-padding"><input type="text"  name="emailAddress" id="emailAddress"/> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.emailAddress}</div></td>


                                                <td>Street Address</td>
                                                <td class="input-padding"><input type="text"  name="streetAddress" id="stdAdd"/> 
                                                </td>
                                                <td><div class="formError">${error.streetAddress}</div></td>


                                            </tr>
                                            <tr>
                                                <td>Apartment/Suite Number &nbsp;</td>
                                                <td><input type="text"  name="apartmentNo" id="aptNo"/> 
                                                </td>
                                                <td><div class="formError">${error.apartmentNo}</div></td>
                                                <td class="input-padding">City</td>
                                                <td><input type="text"  name="city" id="city"/> 
                                                </td>
                                                <td><div class="formError">${error.city}</div></td>
                                            </tr>
                                            <tr>
                                                <td>State</td>
                                                <td><select name="state" id="state" style="width: 201px;">
                                                        <option value="">Select State</option>
                                                        <option value="Ohio">Ohio</option>
                                                    </select>
                                                </td>
                                                <td><div class="formError">${error.state}</div></td>
                                                <td class="input-padding">Zip Code</td>
                                                <td><input type="text"  name="zipcode" id="zipcode"/> 
                                                </td>
                                                <td><div class="formError">${error.zipcode}</div></td>

                                            </tr>
                                            <tr>

                                                <td>Hours of Operation&nbsp;</td>
                                                <td><textarea name="hours_Of_Operation" id="hours_Of_Operation" style="min-width: 201px;" placeholder="Please format in the way you want displayed"></textarea>
                                                </td>
                                                <td><div class="formError">${error.hours_Of_Operation}</div></td>
                                                <td>Required Verification</td>
                                                <td><textarea name="required_Verification" id="required_Verification" style="min-width: 201px;"></textarea>
                                                </td>
                                                <td><div class="formError">${error.required_Verification}</div></td>

                                            </tr>
                                            <tr>
                                                <td>Board Positions</td>
                                                <td><textarea name="board_Positions" id="board_Positions" style="min-width: 201px;"></textarea>
                                                </td>
                                                <td><div class="formError">${error.board_Positions}</div></td>

                                                <td>Mission Statement</td>
                                                <td><textarea name="mission" id="mission" style="min-width: 201px;"></textarea>
                                                </td>
                                                <td><div class="formError">${error.mission}</div></td>
                                            </tr>

                                            <tr>
                                                <td class="input-padding">Counties Served&nbsp;&nbsp;</td>
                                                <td>
                                                    <%  ArrayList<County> counties = new CountyModel().listCounty();
                                                        for (County c : counties) {
                                                            if (c.getIdCounty() == 4) { %>
                                                    <br>
                                                    <% }%>
                                                    <%=c.getCountyName()%> <input type="checkbox" name="counties_Served" value="<%=c.getIdCounty()%>" style="">
                                                    <% }%>
                                                    <span class="astereks-required">*</span> 
                                                </td>
                                                <td><div class="formError">${error.counties_Served}</div></td>

                                                <td><input type="hidden" name="action" value="0"/><input type="hidden" name="option" value="1"/></td>
                                                <td> <input style="margin-top: 10px; width:200px;" type="submit" name="submit"  class="btn btn-info" value="Add Agency"/></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form></div><!--add agency ends here -->
                            <div class="tab-pane" id="agcyList">
                                <div><a href="<%=request.getContextPath()%>/export/agency" id="edit" style="float: right; margin-bottom: 10px;">Export Agency List</a></div>
                                <table id="agencyListTable" class="table table-striped table-bordered table-condensed" >
                                    <thead>
                                    <th>No</th>
                                    <th>Name</th>
                                    <th>Email Address</th>
                                    <th>Private Contact </th>
                                    <th>Date Created </th>
                                    <th>Action</th>
                                    </thead>

                                    <tbody>
                                        <%  count = 1;
                                            List<Agency> agencies = new AgencyModel().listAgency();
                                            if (agency != null && !agency.isEmpty()) {
                                                for (Agency a : agencies) {
                                        %>
                                        <tr>
                                            <td><%=count++%></td>
                                            <td><%=a.getFullname()%></td>
                                            <td><%=a.getEmailAddress()%></td>
                                            <td><%if (a.getPrivateContactNumber() != null && (a.getPrivateContactNumber().compareTo(value) == 1)) {%><%=a.getPrivateContactNumber()%><%} else {%>-<%}%></td>
                                            <td><%if (a.getDateCreated() != null) {%><%=Menu.convertDateToString(a.getDateCreated(), "MM-dd-yyyy")%><%} else {%>-<%}%></td>
                                            <%-- <td><%if (a.getDateUpdated() != null) {%><%=Menu.convertDateToString(a.getDateUpdated(), "MM-dd-yyyy")%><%} else {%>-<%}%></td>--%>
                                            <td> <a class="btn" href="<%=request.getContextPath()%>/admin/agencyEdit.jsp?id=<%=a.getAgencyId()%>" title="Click To View/Edit" id="edit">Edit</a></td> 
                                            
                                        </tr>
                                        <% }
                                            }%>
                                    </tbody>
                                </table>

                            </div>
                            <div id="newEvt" class="tap-pane">
                                <form id="newsForm" method="post" action="<%=request.getContextPath()%>/news/add" enctype="multipart/form-data">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>Title </td>
                                                <td class="input-padding"><input type="text"  name="newsTitle" id="newsTitle"/>
                                                    <span class="astereks-required">*</span> 
                                                </td>
                                                <td><div class="formError">${error.title}</div></td>
                                            </tr>

                                           <!--
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
                                           -->
                                            <tr> 
                                                <td>Content</td>
                                                <td class="input-padding"><textarea name="content" style=" min-height:200px; width: 400px;"></textarea> 

                                                </td>
                                                <td><div class="formError">${error.content}</div></td> 
                                            </tr>
                                            <tr>
                                                <td>Type </td>
                                                <td class="input-padding">
                                                    <select name="type" id="type" style="width: 200px; margin-bottom: 10px;">
                                                        <option value="">Select Type </option>
                                                        <% for (int j = 0; j < Menu.newsType().size(); j++) {%>
                                                        <option value="<%=Menu.newsType().get(j)%>" > <%=Menu.newsType().get(j)%> </option>
                                                        <% }%>
                                                    </select><span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.news_Type}</div></td>
                                            </tr>
                                            <tr>
                                                <td> Upload Image/Pdf&nbsp;&nbsp;</td>
                                                <td class="input-padding"><input type="file" name="attachment"/></td>
                                                <td><div class="formError">${error.attachment}</div></td>
                                            </tr>
                                            <tr>
                                                <td><input type="hidden" name="action" value="0"/></td>
                                                <td> <input  type="submit" name="submit"  class="btn btn-info" value="Add News/Alert " style="margin-top: 10px; width: 200px;"/></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form>
                            </div><!--add news ends here -->
                            <script>  $(document).ready(function () {
                                    $("#newsTable").DataTable({
                                        "pagingType": "full_numbers",
                                        "oLanguage": {
                                            "sEmptyTable": "No Records",
                                            "sZeroRecords": "No Records"
                                        },
                                        "bSort": false
                                    });
                                });</script>

                            <div class="tab-pane" id="newEvtList">
                                <table id="newsTable" class="table table-striped table-bordered table-condensed" >
                                    <thead>
                                    <th>No</th>
                                    <th>Title</th>
                                    <th>Type</th>
                                    <!--<th>Start Date</th>
                                    <th>End Date</th>-->
                                    <th>Date Created</th>
                                    <th></th>
                                    </thead>

                                    <tbody>
                                        <%  count = 1;
                                            List<News> news = new NewsModel().newsList();
                                            for (News n : news) {
                                        %>
                                        <tr>
                                            <td><%=count++%></td>
                                            <td><%=n.getTitle()%></td>
                                            <td><%=n.getNewsType()%></td>
                                            <!--
                                            
                                            -->
                                            <td><%=Menu.convertDateToString(n.getDateCreated(), "MM-dd-yyyy")%></td>
                                            <td> <a class="btn" href="<%=request.getContextPath()%>/admin/newsEdit.jsp?id=<%=n.getNewsId()%>"  title="Click to Edit/View" id="edit">Edit</a></td> 
                                        </tr>
                                        <% }%>
                                    </tbody>
                                </table>

                            </div>

                        </div>
                    </div>
                </div></center>
                <% }
                    } else {
                        String failMsg = "Invalid Access, Login with Username and Password";
                        Validation.setAttributes(request, Validation.ERROR, failMsg);
                        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
                    }%>
        </div>

        <!--------------------------->
        <!-- footer -->
        <div class="footer">
            <div class="container">
                <div class="footer-bottom-at">
                    <div class="col-md-6 footer-grid">
                    </div>
                    <p class="footer-class"> © 2015 Safety Net Alliance. All rights reserved | <a href="<%=request.getContextPath()%>/public/privacy_policy.pdf" target="_blank" >Privacy Policy </a></p>
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
        //validating the member form
        $("#addMemberForm").validate({
            rules: {
                emailAddress: {
                    required: true,
                    email: true,
                    remote: {
                        url: "<%=request.getContextPath()%>/email/exist",
                        type: "post",
                        data: {
                            email: function () {
                                return $("#email").val();
                            }
                        }
                    }
                }
                ,
                firstName: "required",
                lastName: "required",
                role: "required",
                agencyId: "required",
                phoneNumber: {
                    digits: true,
                    rangelength: [10, 10]
                },
                password: {
                    required: true,
                    minlength: 6
                },
                confirm_Password: {
                    required: true,
                    minlength: 6,
                    equalTo: "#user_password"
                }

            },
            messages: {
                password: {
                    required: "Password is required",
                    minlength: "Your password must be at least 6 characters long"
                },
                confirm_Password: {
                    required: "Confirm Password is requried",
                    minlength: "Your password must be at least 6 characters long",
                    equalTo: "Passwords do not match"
                },
                firstName: "First Name is required",
                lastName: "LastName is required",
                role: "Role is required",
                agencyId: "Agency is required",
                emailAddress: {
                    required: "Email Address is required",
                    email: "Enter a valid email address",
                    remote: "Email address already in use"
                },
                phoneNumber: {
                    digits: "Contact should be numbers only",
                    rangelength: "Contact Number Length should be 10"
                }
            }

        });

        //validating the agency form
        $("#agencyForm").validate({
            rules: {
                fullName: "required",
                emailAddress: {
                    required: true,
                    email: true,
                    remote: {
                        url: "<%=request.getContextPath()%>/email/exist",
                        type: "post",
                        data: {
                            email: function () {
                                return $("#emailAddress").val();
                            }
                        }
                    }
                },
                password: {
                    required: true,
                    minlength: 6
                },
                confirm_password: {
                    required: true,
                    minlength: 6,
                    equalTo: "#password_modal"
                },
                private_Contact_Number: {
                    digits: true,
                    rangelength: [10, 10]
                },
                public_Contact_Number: {
                    digits: true,
                    rangelength: [10, 10]
                },
                zipcode: {
                    digits: true
                },
                services: "required",
                counties_Served: "required"

            },
            messages: {
                password: {
                    required: "Password is required",
                    minlength: "Your password must be at least 6 characters long"
                },
                confirm_password: {
                    required: "Confirm password is required",
                    minlength: "Your password must be at least 6 characters long",
                    equalTo: "Passwords do not match"
                },
                emailAddress: {
                    required: "Email Address is required",
                    email: "Enter a valid email address",
                    remote: "Email address already in use"
                },
                fullName: "Agency name is required",
                services: "Please select a service",
                counties_Served: "Please check a county",
                private_Contact_Number: {
                    digits: "Please enter numbers only",
                    rangelength: "Length of Contact Number should be 10"
                },
                public_Contact_Number: {
                    digits: "Please enter numbers only",
                    rangelength: "Length of Contact Number should be 10"
                },
                zipcode: {digits: "Please enter numbers only"}
            }

        });

        //validating the service form
        $("#addService").validate({
            rules: {
                serviceName: "required"
            },
            messages: {
                serviceName: "Please enter a service name"
            }

        });

        //validating the news form
        $("#newsForm").validate({
            rules: {
                newsTitle: {
                    required: true,
                    remote: {
                        url: "<%=request.getContextPath()%>/verify/title",
                        type: "post",
                        data: {
                            newsTitle: function () {
                                return $("#newsTitle").val();
                            }
                        }
                    }
                },
                type: "required"
            },
            messages: {
                newsTitle: {
                    required: "Title is required",
                    remote: "Title is already in use"
                },
                type: "Type is required"
            }
        });
    </script>
    <!-- //here ends scrolling icon -->
</body>
</html>