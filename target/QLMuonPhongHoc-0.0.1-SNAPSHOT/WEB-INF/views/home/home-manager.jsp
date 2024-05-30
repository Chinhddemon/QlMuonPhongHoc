<!-- Điều hướng nhận điều kiện:
		UIDManager      
	Điều hướng nhận thiết lập sẵn:
		addressContact
		emailContact
		phoneContact
	Điều hướng nhận thông tin:
		OTP
-->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Quản lý mượn phòng học Học viện cơ sở</title>
    <style>
        /* MARK: STYLE*/
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;400&family=Roboto:wght@300;400;500;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            text-decoration: none;
            border: none;
            outline: none;
            font-size: 1rem;
            transition: .2s;
            scroll-behavior: smooth;
            font-family: 'Poppins', sans-serif;
        }

        :root {
            --bg-color: #ffe2c7c2;
            --second-bg-color: rgb(255 241 226 / 79%);
            --text-color: #71706E;
            --text-box-color: #fcdec9;
            --main-color: #f3e0a7;
            --main-box-color: rgba(0, 0, 0, .7);
            --content-box-color: #b9b4a3;
            --admin-menu-color: #e9b4b4;
            --manager-menu-color: #ffda72;
            --regular-menu-color: #78c5c5;
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
            border-bottom-left-radius: 1rem;
            border-bottom-right-radius: 1rem;
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

            menu {
                max-width: 30%;
                width: 40rem;
                height: 100%;
                background: var(--bg-color);
                display: grid;
                border: .2rem solid var(--main-box-color);
                /* border-radius: .2rem; */
                box-shadow: 1px 1px 2px black;
                padding: 1.5rem;
                overflow: auto;

                li {
                    display: flex;
                    flex-direction: column;
                    justify-content: center;

                    a {
                        font-weight: 500;
                        color: var(--text-color);
                        text-align: center;
                    }
                }

                li.wrapper {
                    margin: .5rem;
                    border: .5rem solid var(--content-box-color);
                    border-radius: 2rem;

                    a.open-expand-item {
                        border-bottom: .4rem solid var(--content-box-color);
                        border-radius: 1.8rem;
                        background: transparent;
                        padding: 1rem;
                        cursor: pointer;
                    }

                    div.expandable-items {
                        display: flex;
                        flex-direction: column;
                        justify-content: center;
                        flex-basis: content;
                        margin: 1.5rem .5rem .5rem;
                        gap: 1.5rem;
                        overflow: hidden;

                        a {
                            flex-basis: content;
                            border: .3rem solid var(--content-box-color);
                            border-radius: 2rem;
                            background: floralwhite;
                            padding: .5rem 2rem;
                            overflow: hidden;
                        }
                    }

                    .non-active {
                        flex-basis: 0 !important;
                        border: none !important;
                        border-bottom: none !important;
                        border-top: none !important;
                        border-left: none !important;
                        border-right: none !important;
                        margin: 0 !important;
                        gap: 0 !important;
                        
                    }
                }

                li.menu-home {
                    border: none;
                }

                li.menu-home a.open-expand-item {
                    font-weight: 700;
                }

                li.menu-admin {
                    background: var(--admin-menu-color);
                }

                li.menu-manager {
                    background: var(--manager-menu-color);
                }

                li.menu-regular {
                    background: var(--regular-menu-color);
                }
            }

            iframe {
                flex-grow: 1;
                height: 100%;
                background: var(--bg-color);
                border: .3rem solid var(--main-box-color);
                border-radius: 2rem;
                box-shadow: 1px 1px 2px var(--main-box-color);
            }
        }

        footer {
            padding: .5rem 3% 1rem;
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 3rem;
        }

        @media only screen and (width <=992px) {
            main menu li button,
            main menu li a {
                font-size: 1.5rem;
            }
        }

        @media only screen and (992px < width) {
            main menu li button,
            main menu li a {
                font-size: 2rem;
            }
        }
    </style>
    <script>
        // MARK: SCRIPT
        // Lấy giá trị của các tham số từ modelAttributes
        var UIDRegular = ""
        var UIDManager = "${requestScope.UIDManager}";
        var UIDAdmin = "${requestScope.UIDAdmin}";
        var OTP = "${requestScope.OTP}";
        var OTPAdmin = "${requestScope.OTPAdmin}";

        if (!UIDManager) {
            // Lấy giá trị của các tham số từ sessionScope
            UIDManager = sessionStorage.getItem('UIDManager');
            UIDAdmin = sessionStorage.getItem('UIDAdmin');
        }

        sessionStorage.setItem("UIDRegular", UIDRegular);
        sessionStorage.setItem("UIDManager", UIDManager);
        sessionStorage.setItem("UIDAdmin", UIDAdmin);
        sessionStorage.setItem("OTP", OTP);
        sessionStorage.setItem("OTPAdmin", OTPAdmin);

        // MARK: checkUID
        function checkUID() {
            if (!UIDManager) {
                window.location.href = "Login";
            }
            if (!OTP && !OTPAdmin) {
                window.location.href = "Login?Message=Lỗi không tìm thấy mã OTP.";
            }
        }

        // MARK: toggleExpand
        function toggleExpand(item) {
            var expandableItem = item.nextElementSibling;
            var parentExpandableItem = expandableItem.parentNode;
        
            document.querySelectorAll('.open-expand-item').forEach(function (element) {
                if (element !== item) {
                    element.classList.add('non-active');
                } else {
                    element.classList.toggle('non-active');
                }
            });
            document.querySelectorAll('.expandable-items').forEach(function (element) {
                var parentElement = element.parentNode;
                if (parentElement !== parentExpandableItem) {
                    element.classList.add('non-active');
                } else {
                    element.classList.toggle('non-active');
                }
            });
            document.querySelectorAll('.expand-item').forEach(function (element) {
                var parentElement = element.parentNode.parentNode;
                if (parentElement !== parentExpandableItem) {
                    element.classList.add('non-active');
                } else {
                    element.classList.toggle('non-active');
                }
            });
        }

        // MARK: setFunctions
        function setFunctions() {
            document.querySelectorAll('.open-expand-item').forEach(function (element) {
                element.setAttribute('onclick', 'toggleExpand(this)');
            });
        }

        // MARK: setHref
        function setHref() {
            document.querySelectorAll('a[href]').forEach(function (element) {
                element.setAttribute('href', element.getAttribute('href') + '&UID=' + UIDManager + UIDAdmin);
            });
        }

        document.addEventListener("DOMContentLoaded", function () {
            checkUID();
            setFunctions();
            setHref();
        });
    </script>
</head>

<body>
    <header>
        <%@ include file="../components/partials/app-header.jsp" %>
    </header>

    <main>
        <!-- MARK: BoardMenu -->
        <menu class="board-menu">
            <li class="wrapper menu-home">
                <a class="open-expand-item non-active" href="Introduce?" target="board-content">
                    Về ứng dụng
                </a>
                <div class="expandable-items non-active">
                    <a class="expand-item non-active" href="#" target="board-content">
                        Tính năng
                    </a>
                    <a class="expand-item non-active" href="#" target="board-content">
                        Hướng dẫn sử dụng
                    </a>
                </div>
            </li>
            <li class="wrapper menu-manager">
                <a class="open-expand-item non-active" href="DsMPH/XemDsMPH?Command=TheoNgay" target="board-content">
                    Mượn phòng
                </a>
                <div class="expandable-items non-active">
                    <a class="expand-item non-active" href="DsMPH/XemDsMPH?Command=TheoNgay" target="board-content">
                        Lịch mượn theo ngày
                    </a>
                    <a class="expand-item non-active" href="DsMPH/XemDsMPH?Command=ChuaTraPhong" target="board-content">
                        Lịch chưa trả phòng
                    </a>
                    <a class="expand-item non-active" href="DsMPH/XemDsMPH?Command=TheoHocKy" target="board-content">
                        Lịch mượn theo học kỳ
                    </a>
                </div>
            </li>
            <li class="wrapper menu-manager">
                <a class="open-expand-item non-active">
                    Thông tin Ứng dụng
                </a>
                <div class="expandable-items non-active">
                    <a class="expand-item non-active" href="DsND/XemDsGV?" target="board-content">
                        Giảng viên
                    </a>
                    <a class="expand-item non-active" href="DsND/XemDsSV?" target="board-content">
                        Sinh viên
                    </a>
                    <a class="expand-item non-active" href="DsNhomHocPhan/XemDsNhomHocPhan?" target="board-content">
                        Lớp học
                    </a>
                    <a class="expand-item non-active" href="none" target="board-content">
                        Phòng học
                    </a>
                </div>
            </li>
            <li class="wrapper menu-admin">
                <a class="open-expand-item non-active">
                    Thống kê mượn phòng
                </a>
                <div class="expandable-items non-active">
                    <a class="expand-item non-active" href="none" target="board-content">
                        Tổng quan
                    </a>
                    <a class="expand-item non-active" href="none" target="board-content">
                        Theo học kỳ
                    </a>
                    <!--<a class="expand-item" href="none" target="board-content">
                        Theo ngày
                    </a>   -->
                    <a class="expand-item non-active" href="none" target="board-content">
                        Theo giảng viên
                    </a>
                    <a class="expand-item non-active" href="none" target="board-content">
                        Theo học phần
                    </a>
                    <a class="expand-item non-active" href="none" target="board-content">
                        Phòng học
                    </a>
                </div>
            </li>
            <li class="wrapper menu-admin">
                <a class="open-expand-item non-active">
                    Quản lý hệ thống
                </a>
                <div class="expandable-items non-active">
                    <a class="expand-item non-active" href="none" target="board-content">
                        Người dùng
                    </a>
                    <a class="expand-item non-active" href="none" target="board-content">
                        Quản lý
                    </a>
                    <a class="expand-item non-active" href="none" target="board-content">
                        Thiết lập người dùng
                    </a>
                </div>
            </li>
            <li class="wrapper menu-admin">
                <a class="open-expand-item non-active">
                    Lịch sử hoạt động
                </a>
                <div class="expandable-items non-active">
                    <a class="expand-item non-active" href="DsMPH/XemDsMPH?Command=LichSu" target="board-content">
                        Lịch mượn phòng
                    </a>
                    <a class="expand-item non-active" href="none" target="board-content">
                        Quản lý
                    </a>
                    <a class="expand-item non-active" href="none" target="board-content">
                        Người dùng
                    </a>
                </div>
            </li>
        </menu>
        <!-- MARK: BoardContent -->
        <iframe class="board-content" name="board-content" src="Introduce"></iframe>
    </main>

    <footer>
        <%@ include file="../components/partials/app-footer.jsp" %>
    </footer>
</body>

</html>