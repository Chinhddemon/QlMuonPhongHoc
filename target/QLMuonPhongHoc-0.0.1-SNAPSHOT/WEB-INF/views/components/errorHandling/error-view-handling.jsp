<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>ErrorHandling</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            text-decoration: none;
            border: none;
            outline: none;
            scroll-behavior: smooth;
            font-family: 'Poppins', sans-serif;
        }

        :root {
            --bg-color: #1E90FF;
            --second-bg-color: #20B2AA;
            --text-color: #fffbd3;
            --text-box-color: #fcdec9;
            --main-color: #FFB6C1;
            --main-box-color: black;
            --content-box-color: #fc913a;
            --admin-menu-color: #f26969;
            --manager-menu-color: #facb4b;
            --regular-menu-color: #3ec3c3;
        }

        html {
            font-size: 62.5%;
            overflow-x: hidden;
        }

        body {
            width: 100%;
            height: 100vh;
            background: var(--second-bg-color);
            display: flex;
            flex-direction: column;
            color: var(--text-color);
        }
    </style>
</head>

<body>
    <main>
        <h2 style="font-size: 5rem;">Có lỗi URL, hãy sửa lại!</h2>
        <p>${errorMessage}</p>
        <p>${errorPrintStackTrace}</p>
    </main>
</body>

</html>