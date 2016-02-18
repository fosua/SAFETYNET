<%-- 
    Document   : successStory
    Created on : Nov 23, 2015, 12:56:14 AM
    Author     : estelle
--%>
<%@page import="com.ccsna.ccsna.SuccessStory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ccsna.ccsna.SuccessStoryModel"%>
<%@page import="com.ccsna.safetynet.Validation"%>
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
            jQuery(document).ready(function ($) {
                $(".scroll").click(function (event) {
                    event.preventDefault();
                    $('html,body').animate({scrollTop: $(this.hash).offset().top}, 1000);
                });
                $("#success_Story_div").hide();
                $("#myStory").click(function (event) {
                    event.preventDefault();
                    $("#success_Story_div").show();
                });
            });</script>
        <!-- script for menu -->
        <script>
            $("span.menu").click(function () {
                $("ul.nav1").slideToggle(300, function () {
                });
            });</script>
        <!-- //script for menu -->
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



        </div>
    <center>

        <div class="body_container" id="body_container">
            <div class="sslink"> <p><u><a href="#" id="myStory">Submit My Success Story</a></u></p></div><br>

            <% if (request.getSession().getAttribute(Validation.ERROR) != null) {%>
            <div class="alert alert-danger" style="text-align: center">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <%="ERROR: " + request.getSession().getAttribute(Validation.ERROR)%>
            </div>
            <% Validation.removeAttributes(request, Validation.ERROR);
            } else if (request.getSession().getAttribute(Validation.SUCCESS) != null) {%>
            <div class="alert alert-success" style="text-align: center">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <%= request.getSession().getAttribute(Validation.SUCCESS)%>
            </div>
            <%   Validation.removeAttributes(request, Validation.SUCCESS);
                }%>
            <div id="success_Story_div">
                <form  method="post" action="<%=request.getContextPath()%>/add/successStory" id="success_Story_form">
                    <table>
                        <tbody>
                            <tr>
                                <td>Full Name</td>
                                <td class="input-padding"><input type="text"  name="fullName" id="fullName"/>
                                    <span class="astereks-required">*</span> 
                                </td>
                                <td><div class="formError">${error.fullName}</div></td>
                            </tr>
                            <tr>
                                <td>Email Address</td>
                                <td class="input-padding"><input type="text"  name="emailAddress" id="emailAddress"/>
                                    <span class="astereks-required">*</span> 
                                </td>
                                <td><div class="formError">${error.emailAddress}</div></td>
                            </tr>
                            <tr>
                                <td>Agency&AMP;Position &nbsp;&nbsp;</td>
                                <td class="input-padding"><input type="text"  name="agency" id="agency"/>

                                </td>
                                <td><div class="formError">${error.agency}</div></td>
                            </tr>

                            <tr> 
                                <td>Story Content</td>
                                <td class="input-padding">
                                    <textarea name="content" id="content"></textarea> 
                                    <span class="astereks-required">*</span>
                                </td>
                                <td><div class="formError">${error.content}</div></td> 
                            </tr>

                            <tr>
                                <td><input type="hidden" name="action" value="0"/></td>
                                <td><input  type="submit" name="submit"  class="btn btn-info" value="submit"  style="margin-top: 10px; width: 200px;"/></td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </div><br>
            <div id="ssList" >
                <%
                    int counter = 1;
                    ArrayList<SuccessStory> stories = new SuccessStoryModel().successStoryList(0, 3);
                    if (stories != null && !(stories.isEmpty())) {
                        for (SuccessStory story : stories) {
                            if (counter % 2 != 0) {

                %>
                <div class="ssStory" style="background-color: #F9F9FF">
                    <p>   <%=story.getContent()%></p>
                    <p>  <b> <i>-&Tab;<%=story.getFull_name()%><%if (story.getAgency() != null && !story.getAgency().isEmpty()) {%><%=", " + story.getAgency()%><% } %></i></b></p>
                </div> <br>

                <% } else {%>
                <div class="ssStory" style="background-color: #d9edf7">
                    <p><%=story.getContent()%></p>
                    <p> <b><i>-&Tab;<%=story.getFull_name()%><%if (story.getAgency() != null && !story.getAgency().isEmpty()) {%><%=", " + story.getAgency()%><% } %></i></b></p>
                </div> <br>

                <%  }
                            counter++;
                        }
                    }%>
            </div>
            <div id="edit"><button  style="width:400px; height: 40px;">No More Stories To Load</button></div>
        </div>
    </center>

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
        //validating the success story form
        $("#success_Story_form").validate({
            rules: {
                fullName: "required",
                emailAddress: {
                    email: true,
                    required: true
                },
                content: "required"
            },
            messages: {
                fullName: "Full Name is required",
                emailAddress: {
                    email: "Please enter a correct email address format",
                    required: "Email Address is required"
                },
                content: "Story Content  is required"
            }

        });

        $("#edit").hide();
        var i = 0;
        function yHandler() {
            var wrap = document.getElementById('ssList');
            var contentHeight = wrap.offsetHeight;
            var yOffset = window.pageYOffset;
            var y = yOffset + window.innerHeight;
            if (y >= contentHeight) {
                i = i + 3;
                console.log("i is : " + i);
                $.ajax({
                    type: "POST",
                    url: "<%=request.getContextPath()%>/successStory/load",
                    data: {"row": i
                    },
                    //contentType: "application/json; charset=utf-8",
                    //dataType: "json",
                    //async: true,
                    cache: false,
                    success: function (response)
                    {
                        if (response == "") {
                            $("#edit").show();
                        } else {
                            $("#ssList").append(response);
                        }
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
</body>
</html>



