<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Quản lý mượn phòng học Học viện cơ sở</title>
    <%@ include file="components/utils/style-default.jsp" %> <!-- Include the default style -->
    <style>
        main {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            align-items: center;
            padding: .5rem;
            margin: 1rem;
            gap: 1.5rem;
            overflow: hidden;
        }

        @media only screen and (width <=992px) {

            /* Small devices (portrait tablets and large phones, 600px and up) */
            main menu li a {
                font-size: 2rem;
            }
        }

        @media only screen and (992px < width) {

            /* Medium devices (landscape tablets, 992px and up) */
            main menu li a {
                font-size: 3rem;
            }
        }
    </style>

    <head>
        <meta charset="utf-8">
        <title>Quản lý mượn phòng học Học viện cơ sở</title>
    </head>

<body>
    <main>
        <h1>Đây là trang giới thiệu
            <c:if test="${messageStatus != null}">
                <p>${messageStatus}</p>
            </c:if>
        </h1>
    </main>
</body>

</html>