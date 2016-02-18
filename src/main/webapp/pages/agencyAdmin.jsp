<%-- 
    Document   : agencyAdmin
    Created on : Oct 29, 2015, 5:17:12 PM
    Author     : estelle
--%>

<%@page import="com.ccsna.ccsna.NewsModel"%>
<%@page import="com.ccsna.ccsna.News"%>
<%@page import="com.ccsna.ccsna.CountyModel"%>
<%@page import="java.util.ArrayList"%>
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
        <script type="text/javascript" src="<%=request.getContextPath()%>/public/js/pairselect.min.js"></script>
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

            $(document).ready(function () {
                $("#alertList").DataTable({
                    "pagingType": "full_numbers",
                    "oLanguage": {
                        "sEmptyTable": "No Records",
                        "sZeroRecords": "No Records"
                    },
                    "bSort": false
                });
                
                $("#start_Date").datepicker({
                    dateFormat: "yy-m-dd"
                });
                $("#end_Date").datepicker({
                    dateFormat: "yy-m-dd"
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
                });</script>

        </div>
        <div class="body_container" id="body_container">
            <%
                Long value = 0l;
                Member loggedInMember = UserAuthenticator.loggedInUser(request.getSession());
                if (loggedInMember != null) {
                    loggedInMember = new MemberModel().findById(loggedInMember.getMemberId());
                    if (loggedInMember != null) {
                        Agency agency = loggedInMember.getAgency();
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
                            <li class="nav-tabs-title"><a href="#myAgency" data-toggle="tab">Agency Profile</a></li>
                            <li class="nav-tabs-title"><a href="#addMember" data-toggle="">Add Member</a></li>
                            <li class="nav-tabs-title"><a href="#listMember" data-toggle="tab">Member List</a></li>
                            <li class="nav-tabs-title"><a href="#services" data-toggle="tab">Our Services</a></li>
                            <li class="nav-tabs-title"><a href="#alert" data-toggle="tab">Add Alerts</a></li>
                            <li class="nav-tabs-title"><a href="#listAlert" data-toggle="tab">Alert List</a></li>
                            <li class="nav-tabs-title"><a href="#changePs" data-toggle="tab">Change Password</a></li>
                        </ul>

                    </div>

                    <div class="widget-content padding">

                        <div class="tab-content">

                            <div class="tab-pane" id="myAgency" >
                                <form class="agencyForm" id="agencyForm" method="post" action="<%=request.getContextPath()%>/agency/update" accept-charset="utf-8">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>Agency Name </td>
                                                <td class="input-padding">
                                                    <input type="text"  name="fullName" id="fullName" value="<%=agency.getFullname()%>"/> <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.fullName}</div></td>
                                                <td>Web Site</td>
                                                <td class="input-padding"><input type="text"  name="website_Address" id="website_Address" value="<%=agency.getWebsiteAddress()%>"/> 
                                                </td>
                                                <td><div class="formError">${error.website_Address}</div></td>
                                            </tr>

                                            <tr>
                                                <td>Private Contact Number</td>
                                                <td><input type="text"  name="private_Contact_Number" id="private_Contact_Number" value="<%if (agency.getPrivateContactNumber() != null && agency.getPrivateContactNumber().compareTo(value) == 1) {%> <%=agency.getPrivateContactNumber()%><% } %>"/> 
                                                </td>
                                                <td><div class="formError">${error.private_Contact_Number}</div></td>
                                                <td>Public Contact Number&nbsp;</td>
                                                <td><input type="text"  name="public_Contact_Number" id="public_Contact_Number" value="<%if (agency.getPublicContactNumber() != null && agency.getPublicContactNumber().compareTo(value) == 1) {%><%=agency.getPublicContactNumber()%> <% }%>"/> 
                                                </td>
                                                <td><div class="formError">${error.public_Contact_Number}</div></td>
                                            </tr>
                                            <tr>


                                                <td>Email Address </td>
                                                <td class="input-padding"><input type="text"  name="emailAddress" id="emailAddress" value="<%=agency.getEmailAddress()%>" readonly/> 
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.emailAddress}</div></td>


                                                <td>Street Address</td>
                                                <td class="input-padding"><input type="text"  name="streetAddress" id="stdAdd" value="<%=agency.getStreetAddress()%>"/> 
                                                </td>
                                                <td><div class="formError">${error.streetAddress}</div></td>


                                            </tr>
                                            <tr>
                                                <td>Apartment/Suite Number &nbsp;</td>
                                                <td><input type="text"  name="apartmentNo" id="aptNo" value="<%=agency.getApartmentNo()%>"/> 
                                                </td>
                                                <td><div class="formError">${error.apartmentNo}</div></td>
                                                <td class="input-padding">City</td>
                                                <td><input type="text"  name="city" id="city" value="<%=agency.getCity()%>"/> 
                                                </td>
                                                <td><div class="formError">${error.city}</div></td>
                                            </tr>
                                            <tr>
                                                <td>State</td>
                                                <td><select name="state" id="state" style="width: 201px;">
                                                        <option value="Ohio">Ohio</option>
                                                    </select>
                                                </td>
                                                <td><div class="formError">${error.state}</div></td>
                                                <td class="input-padding">Zip Code</td>
                                                <td><input type="text"  name="zipcode" id="zipcode" value="<%if (agency.getZipcode() != null && agency.getZipcode().compareTo(value) == 1) {%><%=agency.getZipcode()%><% }%>"/> 
                                                </td>
                                                <td><div class="formError">${error.zipcode}</div></td>

                                            </tr>
                                            <tr>

                                                <td>Hours of Operation&nbsp;</td>
                                                <td><textarea name="hours_Of_Operation" id="hours_Of_Operation" style="min-width: 201px;" placeholder="Please format in the way you want displayed"><%=agency.getHoursOfOperation().trim()%></textarea>
                                                </td>
                                                <td><div class="formError">${error.hours_Of_Operation}</div></td>
                                                <td>Required Verification</td>
                                                <td><textarea name="required_Verification" id="required_Verification" style="min-width: 201px;"><%=agency.getRequiredVerification()%></textarea>
                                                </td>
                                                <td><div class="formError">${error.required_Verification}</div></td>

                                            </tr>
                                            <tr>
                                                <td>Board Positions</td>
                                                <td><textarea name="board_Positions" id="board_Positions" style="min-width: 201px;"><%=agency.getBoardPositions()%></textarea>
                                                </td>
                                                <td><div class="formError">${error.board_Positions}</div></td>

                                                <td>Mission Statement</td>
                                                <td><textarea name="mission" id="mission" style="min-width: 201px;"><%=agency.getMission()%></textarea>
                                                </td>
                                                <td><div class="formError">${error.mission}</div></td>
                                            </tr>

                                            <tr>
                                                <td class="input-padding">Counties Served&nbsp;&nbsp;</td>
                                                <td>
                                                    <%  int ct = 1;
                                                        ArrayList<County> county = Menu.agencyCounties(agency);
                                                        for (County c : county) {
                                                            ct++;
                                                    %>
                                                    <%=c.getCountyName()%> <input type="checkbox" name="counties_Served" value="<%=c.getIdCounty()%>" checked >
                                                    <%if (ct == 4) {%><br>
                                                    <% }
                                                        } %>
                                                    <% ArrayList<County> allCounty = new CountyModel().nonAgencyCounty(agency.getAgencyId());
                                                        for (County c : allCounty) {
                                                            ct++;
                                                    %>
                                                    <%=c.getCountyName()%> <input type="checkbox" name="counties_Served" value="<%=c.getIdCounty()%>" >
                                                    <%if (ct == 4) {%><br>
                                                    <% }
                                                        }%>
                                                </td>
                                                <td><div class="formError">${error.counties_Served}</div></td>

                                                <td><input type="hidden" name="action" value="1"/><input type="hidden" name="option" value="0"/><input type="hidden" name="id" value="<%=agency.getAgencyId()%>"/></td>
                                                <td> <input style="margin-top: 10px; width:200px;" type="submit" name="submit"  class="btn btn-info" value="Edit Agency"/></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form>
                            </div>
                            <div class="tab-pane" id="addMember" >
                                <form class="addMemberForm" id="addMemberForm" method="post" action="<%=request.getContextPath()%>/agency/update" style="margin-top: 20px;">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>Title </td>
                                                <td class="input-padding"><input type="text"  name="title" id="title"/> 
                                                </td>
                                                <td><div class="formError">${error.title}</div></td>
                                            </tr>
                                            <tr>
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
                                            </tr>
                                            <tr>
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
                                            </tr>
                                            <tr>
                                                <td>Confirm Password&nbsp;&nbsp;</td>
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
                                            </tr>
                                            <tr>
                                                <td>Agency</td>
                                                <td>
                                                    <select name="agencyId" id="agencyId" style="width: 201px; margin-bottom: 10px">
                                                        <option value="">Select Agency </option>
                                                        <option value="<%=loggedInMember.getAgency().getAgencyId()%>"><%=loggedInMember.getAgency().getFullname()%> </option>

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
                                                        <% for (int i = 0; i < Menu.agencyRoles().size(); i++) {%>
                                                        <option value="<%=Menu.agencyRoles().get(i)%>"><%=Menu.agencyRoles().get(i)%></option>
                                                        <% }%>
                                                    </select>
                                                    <span class="astereks-required">*</span>
                                                </td>
                                                <td><div class="formError">${error.role}</div></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td> <input  type="submit" name="submit"  class="btn btn-info" value="Add Member" style="margin-top: 10px; width: 200px;"/></td>
                                                <td><input type="hidden" name="action" value="0"/><input type="hidden" name="option" value="1"/></td>


                                            </tr>
                                        </tbody>
                                    </table>
                                </form>
                            </div>
                            <div class="tab-pane" id="listMember" >
                                <div><a href="<%=request.getContextPath()%>/export/excel?agency=<%=loggedInMember.getAgency().getAgencyId()%>" id="edit" style="float: right; margin-bottom: 10px;">Export Member List</a></div>
                                <table id="agencyListTable" class="table table-striped table-bordered table-condensed" >
                                    <thead>
                                    <th>No</th>
                                    <th>Name</th>
                                    <th>Private Contact</th>
                                    <th>Email Address</th>
                                    <th>Role</th>
                                    <th>Action</th>
                                    </thead>

                                    <tbody>
                                        <%  int count = 1;
                                            List<Member> members = new MemberModel().AgencyMemberList(loggedInMember.getAgency().getAgencyId());
                                            for (Member m : members) {
                                        %>
                                        <tr>
                                            <td><%=count++%></td>
                                            <td><%=m.getFirstName() + " " + m.getLastName()%></td>
                                            <td><%if (m.getPhoneNumber() != null && m.getPhoneNumber().compareTo(value) == 1) {%> 
                                                <%=m.getPhoneNumber()%>  <% } else { %> - <% }%>
                                            </td> 
                                            <td><%=m.getEmailAddress()%></td>
                                            <td><%=m.getRole()%></td>
                                            <td> <a class="btn" href="<%=request.getContextPath()%>/pages/agencyMemberEdit.jsp?id=<%=m.getMemberId()%>" title="Click to View/Edit" id="edit">Edit</a></td> 

                                        </tr>
                                        <% }%>
                                    </tbody>
                                </table>
                            </div>
                            <div class="tab-pane" id="services" >
                                <form class="serviceForm" id="serviceForm" method="post" action="<%=request.getContextPath()%>/agency/update" style="float: left;">
                                    <table>
                                        <tr>
                                            <td>
                                                <select id="MasterSelectBox" multiple class="ourServ" >
                                                    <%=Menu.nonAgencyServicesMenu("", agency.getAgencyId())%>
                                                </select>
                                            </td>

                                            <td><button id="btnAdd" >>></button><br>
                                                <button id="btnRemove" ><<</button>
                                            </td>
                                            <td>
                                                <select id="PairedSelectBox" multiple class="ourServ" name="ourServices">

                                                    <%=Menu.agencyServicesMenu("", agency.getAgencyId())%>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td> <input type="hidden" name="option" value="2"/> <input type="hidden" name="ourServices" id="ourServices"/></td>
                                            <td> <input type="hidden" name="id" value="<%=loggedInMember.getAgency().getAgencyId()%>" /></td>
                                            <td> <input id="submitBtn" type="submit" name="submit"  class="btn btn-info" value="SAVE" style="margin-left: 50px; margin-top: 10px;"/></td>
                                        </tr>
                                    </table>
                                </form>

                            </div>
                            <div class="tab-pane" id="changePs" >
                                <form id="changePsWord" method="POST" action="<%=request.getContextPath()%>/agency/update" class="" style="float: left; margin-top: 20px;">
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
                                                <td><input type="hidden" name="option" value="3"/>
                                                    <input type="hidden" name="id" value="<%=loggedInMember.getMemberId()%>"/>
                                                    <input type="hidden" name="username" value="<%=loggedInMember.getUsername()%>"/></td>
                                                <td> <input id="submitBtn" type="submit" name="submit"  class="btn btn-info" value="CHANGE"/></td>
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
                                            <td><a class="btn" href="<%=request.getContextPath()%>/pages/editAlert.jsp?id=<%=n.getNewsId()%>" title="Click to Edit/View" id="edit">Edit</a></td> 
                                        </tr>
                                        <% }%>
                                    </tbody>
                                </table>    
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
                    /*emailAddress: {
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
                     },*/
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
                    /* emailAddress: {
                     required: "Email Address is required",
                     email: "Enter a valid email address",
                     remote: "Email address already in use"
                     },*/
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

            $(document).ready(function () {

                $("#MasterSelectBox").pairMaster();
                $("#btnAdd").click(function (e) {
                    e.preventDefault();
                    $("#MasterSelectBox").addSelected("#PairedSelectBox");
                    //$("#MasterSelectBox").append("#PairedSelectBox");
                });
                $("#btnRemove").click(function (e) {
                    e.preventDefault();
                    $("#PairedSelectBox").removeSelected("#MasterSelectBox");
                });
                $("#PairedSelectBox option").prop("selected", "selected");

            });


            //validating the alert
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
                    //type: "required"
            }
            messages: {
            newsTitle: {
            required: "Title is required",
                    remote: "Title is already in use"
            }
            //type: "Type is required"
            }
            });
        </script>
        <!-- //here ends scrolling icon -->
    </body>
</html>

