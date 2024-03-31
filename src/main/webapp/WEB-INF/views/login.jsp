<!-- Điều hướng nhận điều kiện:
        UIDManager
        UIDRegular
    Điều hướng nhận thiết lập sẵn:
        addressContact  -   Địa chỉ liên hệ
        emailContact    -   Email liên hệ
        phoneContact    -   Số điện thoại liên hệ
-->
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
        font-size: 1rem;
        scroll-behavior: smooth;
        font-family: 'Poppins', sans-serif;
    }
    :root {
        --bg-color: #f1dc9c;
        --second-bg-color: #fcf0cf; 
        --text-color: #555453;
        --text-box-color: #ffecdf;
        --main-color: #f3e0a7;
        --main-box-color: rgba(0, 0, 0, .7);
        --content-box-color: #b9b4a3;
        --admin-menu-color: #e9b4b4;
        --manager-menu-color: #ffda72;
        --regular-menu-color: #87e9e9;
    }
    html {
        font-size: 62.5%;
        overflow-x: hidden;
    }
    body {
        width: 100%;
        height: 100vh;
        background: var(--text-box-color);
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

        .wrapper {
            position: relative;
            width: 400px;
            height: 410px;
            background: var(--second-bg-color);
            border: 2px solid rgba(255, 255, 255, .5);
            border-radius: 20px;
            backdrop-filter: blur(20px);
            box-shadow: 0 0 30px rgba(0, 0, 0, .5);
            display: block;
            justify-content: center;
            align-items: center;
            overflow: hidden;

            .form-box {
                width: 100%;
                padding: 40px;

                h2 {
                    font-size: 4em;
                    color: #162938;
                    text-align: center;
                }
                h3 {
                    font-size: 2em;
                    color: #2b475d;
                    text-align: center;
                }

                .input-box {
                    position: relative;
                    width: 100%;
                    height: 50px;
                    border-bottom: 2px solid #162938;
                    margin: 30px 0;
            
                    label {
                        position: absolute;
                        top: 50%;
                        left: 5px;
                        transform: translateY(-50%);
                        font-size: 1em;
                        color: #162938;
                        font-weight: 500;
                        pointer-events: none;
                        transition: .5s;
                    }
                    input {
                        width: 100%;
                        height: 100%;
                        background: transparent;
                        border: none;
                        outline: none;
                        font-size: 1em;
                        font-weight: 600;
                        color: #162938;
                        padding: 0 35px 0 5px;
                    }
                    input:-webkit-autofill { 
                        -webkit-background-clip: text;
                    }
                    input:focus~label,
                    input:valid~label {
                        top: -5px;
                    }
                    .icon {
                        position: absolute;
                        right: 8px;
                        font-size: 2.5rem;
                        color: #162938;
                        line-height: 57px;

                        ion-icon {
                            font-size: 2.5rem;
                        }
                    }
                }
                .btn {
                    width: 100%;
                    height: 45px;
                    background: #162938;
                    border: none;
                    border-radius: 6px;
                    outline: none;
                    cursor: pointer;
                    font-size: 1em;
                    font-weight: 500;
                    color: #fff; 
                }
            }
            .form-box.login {
                position: absolute;
                transform: translateX(0);
                transition: transform .18s ease;
            }
        }
        
    }
    footer {
        padding: .5rem 3% 1rem;
        display: flex;
        flex-direction: row;
        align-items: center;
        gap: 3rem;

        p span {
            display: inline-flex;
        }
    }
    @media only screen and ( width <= 992px) {/* Small devices (portrait tablets and large phones, 600px and up) */
    	header {
            h2 {
                font-size: 2rem;
            }

            nav a {
                font-size: 1.5rem;
            }
        }
        main menu li a {
            font-size: 2rem;
        }
        footer {
            p,
            p a,
            p span {
                font-size: 1rem;
            }
        } 
    }
    @media only screen and ( 992px < width) {/* Medium devices (landscape tablets, 992px and up) */
        main menu li a {
            font-size: 3rem;
        }
        footer {
            p,
            p a,
            p span {
                font-size: 1.7rem;
            }
        } 
    }
    </style>
    <script th:inline="javascript">
        // Lấy giá trị của các tham số từ modelAttributes
        var UIDManager = "${UIDManager}";
        var UIDRegular = "${UIDRegular}";
        var UIDAdmin = "${UIDAdmin}";
    </script>
</head>

<body>
    <header>
        <%@ include file="components/partials/login-header.jsp" %>
    </header>

    <main>
        <div class="wrapper">
            <div class="form-box login">
                <h2>MyPTIT</h2>
                <h3>
                    <p>Ứng dụng</p>
                    <p>mượn phòng học</p> 
                </h3>
                <form action="Login.htm" method="post">
                    <div class="input-box">
                        <span class="icon">
                            <ion-icon name="person-circle-outline"></ion-icon>
                        </span>
                        <input type="text" name="tenDangNhap" required>
                        <label>Tên đăng nhập</label>
                    </div>
                    <div class="input-box">
                        <span class="icon">
                            <ion-icon name="lock-closed"></ion-icon>
                        </span>
                        <input type="password" name="matKhau" required>
                        <label>Mật khẩu</label>
                    </div>
                    <button type="submit" class="btn">
                        Login
                    </button>
				    <p>${errorMessage}</p>
                </form>        
            </div>
        </div>
    </main>

    <footer>
        <%@ include file="components/partials/app-footer.jsp" %>
    </footer>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>

</html>