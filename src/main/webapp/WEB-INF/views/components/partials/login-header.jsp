<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<style>
    header {
        h2 {
            color: var(--text-color);
            font-weight: 600;
            user-select: none;
        }

        nav a {
            color: var(--text-color);
            font-weight: 400;
            margin-left: 3.5rem;
        }
    }

    @media only screen and (width <=992px) {

        /* Small devices (portrait tablets and large phones, 600px and up) */
        header {
            h2 {
                font-size: 2rem;
            }

            nav a {
                font-size: 1.5rem;
            }
        }
    }

    @media only screen and (992px < width) {

        /* Medium devices (landscape tablets, 992px and up) */
        header {
            h2 {
                font-size: 2.5rem;
            }

            nav a {
                font-size: 1.8rem;
            }
        }
    }
</style>
<h2>My PTIT</h2>
<nav>
    <a href="Login?Command=Home&uuid=${UIDManager}${UIDRegular}${UIDAdmin}">Home</a>
    <a href="#">Về ứng dụng</a>
    <a href="#">Chính sách</a>
    <a href="#">Điều khoản</a>
</nav>