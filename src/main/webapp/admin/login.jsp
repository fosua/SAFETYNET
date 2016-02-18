<%-- 
    Document   : login
    Created on : Sep 16, 2015, 1:27:59 AM
    Author     : Esther Amo-Nyarko 
--%>

<%@page import="com.ccsna.safetynet.Validation"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>


        <!--default header starts here-->
        <%@include file="../default/header.jsp" %>

    <div class="body_container" id="body_container">
        <center>
            <form id="loginFrom" method="POST" action="<%=request.getContextPath()%>/login/logout" class="">
                <table>
                    <tbody>

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
                    <tr>
                        <td>EMAIL ADDRESS&nbsp;</td>
                        <td><input type="text"  name="username" id="username"/> 
                            <span class="astereks-required">*</span>
                        </td>
                        <td><div class="formError">${error.username}</div></td>

                    </tr>
                    <tr>
                        <td>PASSWORD</td>
                        <td><input type="password"  name="password" id="password"/> 
                            <span class="astereks-required">*</span>
                        </td>
                        <td><div class="formError">${error.password}</div></td>

                    </tr>

                    <tr>
                        <td><input type="hidden" name="option" value="0"/></td>
                        <td> <input id="submitBtn" type="submit" name="submit"  class="btn btn-info" value="SIGN IN"/></td>
                    </tr>
                    </tbody>
                </table>
            </form>
        </center>
    </div>

    <!--default footer starts here-->
    <%@include file="../default/footer.jsp" %>
    <!--default footer ends here-->
    <script>
        //validating the news form
        $("#loginFrom").validate({
            rules: {
                username: {
                    required: true,
                    email: true
                },
                password: "required"
            },
            messages: {
                username: {
                    required: "Email Address is required!",
                    email: "Email Adddress is invalid!"
                },
                password: "Password is required!"
            }
        });
    </script>
</body>
</html>
