<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Thông tin mượn phòng học</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;400&family=Roboto:wght@300;400;500;700&display=swap');
        /* html custom */
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
        /* boardBar design */
        nav {
            background: var(--bg-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 1px 1px 2px black;
            padding: 1.5rem 4rem;
            gap: 8rem;
            overflow: hidden;
        }
        nav a {
            background: transparent;
            font-weight: 500;
            color: var(--text-color);
            cursor: pointer;
        }
        nav h2 {
            flex-grow: 10;
            margin: 0 2rem;
        }
        nav span {
            flex-grow: 1;
            justify-content: center;
        }
        nav button {
            background: transparent;
            font-weight: 500;
            color: var(--text-color);
            cursor: pointer;
        }
        /* boardContent design */
        main {
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        main form {
            /* width: 70%; */
            max-width: 100rem;
            min-width: 50rem;
            height: 90%;
            background: var(--content-box-color);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: start;
            border: .2rem solid var(--main-box-color);
            border-radius: 1rem;
            box-shadow: 1px 1px 2px black;
            overflow: hidden;
        }
        main form p {
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: space-between;
        }
        main form p label {
            display: flex;
            align-items: center;
        }
        main form p input {
            flex-grow: 1;
            background: transparent;
            text-align: end;
        }
        main form p button {
            cursor: pointer;
        }
        main form p.board-main-content {
            display: flex;
            flex-direction: column;
        }
        main form p.board-main-content label {
            align-self: center;
        }
        main form p.board-main-content input {
            text-align: center;
        }
        main form p.submit {
            display: flex;
            justify-content: center;
            gap: 3rem;
        }
        @media only screen and ( width <= 768px) {/* Small devices (portrait tablets and large phones, 600px and up to 768px) */
            /* media boardBar design */
            nav a,
            nav button {
                font-size: 1.7rem;
            }
            nav h2 {
                font-size: 2rem;
            }
            /* media boardContent design */
            main form {
                padding: 6rem 4rem;
            }
            main form p input,
            main form button {
                font-size: 1.7rem;
            }
            main form p label {
                font-size: 2rem;
            }
            main form p.board-main-content label,
            main form p.board-main-content input {
                font-size: 2.2rem;
            }
        }
        @media only screen and ( 768px < width ) {/* Medium devices (landscape tablets, 768px and up) */
            /* media boardBar design */
            nav a,
            nav button {
                font-size: 2rem;
            }
            nav h2 {
                font-size: 2.2rem;
            }
            /* media boardContent design */
            main form {
                padding: 6rem 12rem;
            }
            main form p input,
            main form button {
                font-size: 2rem;
            }
            main form p label {
                font-size: 2.2rem;
            }
            main form p.board-main-content label {
                font-size: 3rem;
            }
            main form p.board-main-content input {
                font-size: 2.5rem;
            }
        }
    </style>
</head>

<body>
    <nav  class="board-bar">
        <a class="go-back" onclick="history.back()">Quay lại</a>
        <h2 class="title">Thông tin lịch mượn phòng</h2>
        <span></span>
        <button class="update-object" onclick="">Chỉnh sửa</button>
        <button class="remove-object" onclick="">Xóa</button>
    </nav>
    <main>
        <form class="board-content">
            <p class="board-main-content">
                <label>Mã lịch mượn phòng: </label>
                <input class="MaBuoiHoc MaCapPhep MaDoiBuoiHoc" type="text" value="${LichMPH.MaBH}${LichMPH.MaCP}${LichMPH.MaDBH}" disabled>
            </p>
            <p>
                <label>Giảng viên lớp học: </label>
                <input class="GiangVien" type="text" value="${LichMPH.GiangVien}" disabled>
            </p>
            <p>
                <label>Lớp học: </label>
                <input class="LopHoc" type="text" value="${LichMPH.LopHoc}" disabled>
            </p>
            <p>
                <button class="nav-object-DsNgMPH" type="submit" formaction="#">Danh sách cho phép mượn phòng học</button>
            </p>
            <p>
                <label>Phòng học: </label>
                <input class="PhongHoc" type="text" value="${LichMPH.PhongHoc}" disabled>
            </p>
            <p>
                <label>Thời gian bắt đầu: </label>
                <input class="ThoiGian_BD" type="text" value="${LichMPH.ThoiGian_BD}" disabled>
            </p>
            <p>
                <label>Thời gian kết thúc: </label>
                <input class="ThoiGian_KT" type="text" value="${LichMPH.ThoiGian_KT}" disabled>
            </p>
            <p>
                <label>Mục đích: </label>
                <input class="HinhThuc" type="text" value="${LichMPH.HinhThuc}" disabled>
            </p>
            <p>
                <label>Mục đích khác: </label>
                <input class="LyDo" type="text" value="${LichMPH.LyDo}" disabled>
            </p>
            <p>
                <label>Trạng thái: </label>
                <input class="TrangThai" type="text" value="${LichMPH.TrangThai}" disabled>
            </p>
            <p>
                <label>Người đã mượn phòng: </label>
                <input class="NguoiMuonPhong" type="text" value="${LichMPH.NguoiMuonPhong}" disabled>
            </p>
            <p>
                <label>Quản lý đã duyệt: </label>
                <input class="QuanLyDuyet" type="text" value="${LichMPH.QuanLy}" disabled>
            </p>
            <p>
                <label>Yêu cầu thêm khi mượn: </label>
                <input class="YeuCau" type="text" value="${LichMPH.YeuCau}" disabled>
            </p>
            <p class="submit">
                <button class="cancel-object" type="button" onclick="">Hủy bỏ</button>
                <button class="submit-object" type="submit" formaction="#">Cập nhật</button>
            </p>
        </form>
    </main>
</body>

</html>