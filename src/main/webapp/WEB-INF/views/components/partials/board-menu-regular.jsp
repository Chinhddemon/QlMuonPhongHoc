<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<style>
    main {
    
        menu {
            max-width: 30%;
            height: 100%;
            background: var(--bg-color);
            display: flex;
            flex-direction: column;
            border: .2rem solid var(--main-box-color);
            border-radius: 2rem;
            box-shadow: 1px 1px 2px black;
            padding: 1.5rem;
            overflow: hidden;
    
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

    @media only screen and ( width <= 992px) {
        main menu li a {
            font-size: 2rem;
        }
    }

    @media only screen and (992px < width) {

        main menu li a {
            font-size: 2.5rem;
        }
    }

</style>
<menu class="board-menu">
    <li class="menu-home">
        <!-- URL sử dụng trong controller -->
        <a class="" href="Introduce.htm" target="board-content">
        <!-- <a class="" href="../GioiThieu/index.html" target="board-content"> -->
            Về ứng dụng
        </a>
    </li>
    <li class="menu-regular">
        <!-- URL sử dụng trong controller -->
        <a class="" href="MPH/ChonLMPH.htm?UIDRegular=${UIDRegular}" target="board-content">
            Mượn phòng học
        </a>
    </li>
    <li class="menu-regular">
        <!-- URL sử dụng trong controller -->
        <a class="" href="DPH/ChonLHP.htm?UIDRegular=${UIDRegular}" target="board-content">
            Đổi phòng học
        </a>
    </li>
</menu>
