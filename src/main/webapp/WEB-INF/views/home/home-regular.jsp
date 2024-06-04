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
    <%@ include file="../components/utils/style-default.jsp" %> <!-- Include the default style -->
    <style>
        header {
            background: var(--second-bg-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: .1rem solid var(--main-box-color);
            /*border-bottom-left-radius: 1rem;*/
            /*border-bottom-right-radius: 1rem;*/
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
                max-width: 25%;
                width: 30rem;
                height: 100%;
                background: var(--bg-color);
                display: grid;
                border-right: .2rem solid var(--main-box-color);
                /* border-radius: .2rem; */
                box-shadow: 1px 1px 2px black;
                /* padding: 1.5rem; */
                overflow: auto;
    
                li {
                    display: flex;
                    margin: .5rem;
                    border: .5rem solid var(--content-box-color);
                    border-radius: 2rem;
                    justify-content: center;
                }
    
                a {
                    margin: 1.5rem;
                    font-weight: 500;
                    color: var(--text-color);
                    text-align: center;
                }
    
                li.menu-home {
                    border: none;
                }
    
                li.menu-home a {
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
            background: var(--second-bg-color);
            padding: .5rem 3% 1rem;
            display: flex;
            flex-direction: row;
            align-items: center;
            border-top: .2rem solid var(--main-box-color);
            gap: 3rem;
        }

        @media only screen and (width <=992px) {
            main menu li a {
                font-size: 1.5rem;
            }
        }
    
        @media only screen and (992px < width) {
    
            main menu li a {
                font-size: 2rem;
            }
        }
    </style>
    <script th:inline="javascript">
        // Lấy giá trị của các tham số từ modelAttributes
        var UIDRegular = "${requestScope.UIDRegular}";
        var UIDManager = "";
        var UIDAdmin = "";
        var OTP = "";
        var OTPAdmin = "";

        if (!UIDRegular) {
            // Lấy giá trị của các tham số từ sessionScope
            UIDRegular = sessionStorage.getItem('UIDRegular');
        }

        sessionStorage.setItem("UIDRegular", UIDRegular);
        sessionStorage.setItem("UIDManager", UIDManager);
        sessionStorage.setItem("UIDAdmin", UIDAdmin);
        sessionStorage.setItem("OTP", OTP);
        sessionStorage.setItem("OTPAdmin", OTPAdmin);

        function checkUID() {
            if (!UIDRegular) {
                window.location.href = "Login";
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

        function setHref() {
            document.querySelectorAll('a[href]').forEach(function (element) {
                element.setAttribute('href', element.getAttribute('href') + '&UID=' + UIDRegular);
            });
        }

        document.addEventListener("DOMContentLoaded", function () {
            checkUID();
            // setFunctions(); // Chưa sử dụng -->
            setHref();
        });
    </script>
</head>

<body>
    <header>
        <%@ include file="../components/partials/app-header.jsp" %>
    </header>

    <main>
        <menu class="board-menu">
            <li class="menu-home">
                <a class="" href="Introduce?" target="board-content">
                    Về ứng dụng
                </a>
            </li>
            <li class="menu-regular">
                <a class="" href="MPH/ChonLMPH?" target="board-content">
                    Mượn phòng học
                </a>
            </li>
            <li class="menu-regular">
                <a class="" href="DPH/ChonHocPhan?" target="board-content">
                    Đổi phòng học
                </a>
            </li>
            <li class="menu-regular">
                <a class="expand-item non-active" href="DsLopHocPhan/XemDsLopHocPhan?" target="board-content">
                    Xem thông tin học phần
                </a>
            </li>
            
            <li class="menu-regular">
                <a class="" href="DsMPH/LichSuMuonPhong?" target="board-content">
                    Lịch sử đã mượn phòng
                </a>
            </li>
        </menu>
        <iframe class="board-content" name="board-content" src="Introduce"></iframe>
    </main>

    <footer>
        <%@ include file="../components/partials/app-footer.jsp" %>
    </footer>
</body>

</html>