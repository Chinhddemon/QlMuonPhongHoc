<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Quản lý mượn phòng học Học viện cơ sở</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;400&family=Roboto:wght@300;400;500;700&display=swap');
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
    --text-border-color: #FFB6C1;
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
header {
    background: var(--bg-color);
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: .1rem solid var(--main-box-color);
    border-radius: 1rem;
    box-shadow: 1px 1px 2px black;
    padding: 2rem 6%;
    overflow: hidden;
}
main {
    flex-grow: 1;
    display: flex;
    flex-direction: row;
    justify-content: space-around;
    align-items: center;
    padding: .5rem;
    margin: 1rem;
    gap: 1.5rem;
    overflow: hidden;
}
main .board-content {
    flex-grow: 1;
    height: 100%;
    background: var(--bg-color);
    border: .3rem solid var(--main-box-color);
    border-radius: 1rem;
    box-shadow: 1px 1px 2px var(--main-box-color);
}
footer {
    padding: .5rem 3% 1rem;
    display: flex;
    flex-direction: row;
    align-items: center;
    gap: 3rem;
}
</style>
</head>

<body>
	<header>
		<%@ include file="Components/appHeader.jsp" %>
	</header>

	<main>
		<%@ include file="Components/boardMenu.jsp" %>
		<iframe class="board-content" name="board-content" src=""></iframe>
	</main>
	
	<footer>
		<%@ include file="Components/appFooter.jsp" %>
	</footer>
</body>

</html>