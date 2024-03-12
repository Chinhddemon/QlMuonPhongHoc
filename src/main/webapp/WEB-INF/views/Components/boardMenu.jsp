<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>

main menu {
    max-width: 30%;
    height: 100%;
    background: var(--bg-color);
    display: flex;
    flex-direction: column;
    border: .2rem solid var(--main-box-color);
    border-radius: 1rem;
    box-shadow: 1px 1px 2px black;
    padding: 1.5rem;
    overflow: hidden;
}
main menu li {
    display: flex;
    margin: .5rem;
    padding: 1.5rem;
    border: .5rem solid var(--content-box-color);
    border-radius: 2rem;
    justify-content: center;
}
main menu li a {
    font-weight: 500;
    color: var(--text-color);
    text-align: center;
}
main menu li.menu-home {
    border: none;
}
main menu li.menu-home a {
    font-weight: 700;
}
main menu li.menu-admin {
    background: var(--admin-menu-color);
}
main menu li.menu-manager {
    background: var(--manager-menu-color);
}
main menu li.menu-regular {
    background: var(--regular-menu-color);
}
@media only screen and ( width <= 992px) {/* Small devices (portrait tablets and large phones, 600px and up) */
    main menu li a {
        font-size: 2rem;
    }
}
@media only screen and ( 992px < width) {/* Medium devices (landscape tablets, 992px and up) */
    main menu li a {
        font-size: 3rem;
    }
</style>
		<menu class="board-menu">
            <li class="menu-home">
                <a class="" href="Components/BoardContent/welcome.html" target="board-content">
                    <span>Về ứng dụng</span>
                </a>
            </li>
            <li class="menu-manager">
                <a class="" href="Content/DsMPH.htm" target="board-content">
                    <span>Danh sách mượn phòng học</span>
                </a>
            </li>
            <li class="menu-manager">
                <a class="" href="Content/DsGV.htm" target="board-content">
                    <span>Danh sách giảng viên</span>
                </a>
            </li>
            <li class="menu-regular">
                <a class="" href="Content/MPH.htm" target="board-content">
                    <span>Mượn phòng học</span>
                </a>
            </li>
            <li class="menu-regular">
                <a class="" href="Content/DBH.htm" target="board-content">
                    <span>Đổi buổi học</span>
                </a>
            </li>
            <li class="menu-admin">
                <a class="" href="Content/QLTK.htm" target="board-content">
                    <span>Quản lý tài khoản</span>
                </a>
            </li>
            <li class="menu-admin">
                <a class="" href="Content/LSHD.htm" target="board-content">
                    <span>Lịch sử hoạt động</span>
                </a>
            </li>
        </menu>