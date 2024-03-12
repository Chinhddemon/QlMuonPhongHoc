<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Danh sách mượn phòng học</title>
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
            padding: .5rem 2rem;
            gap: 2rem;
            overflow: hidden;
        }

        nav a {
            font-weight: 500;
            color: var(--text-color);
        }

        nav a.add-object {
            text-align: end;
        }

        nav h2 {
            cursor: default;
        }

        nav form.filter {
            position: relative;
            flex-basis: 100rem;
            width: 100%;
            height: auto;
            display: flex;
            border: 2px solid #162938;
            border-radius: .7rem;
            gap: 1rem;
            overflow: hidden;
        }

        nav form.filter input {
            flex-grow: 10;
            min-width: 2rem;
            height: 100%;
            background: transparent;
            border: none;
            outline: none;
            font-size: 1em;
            font-weight: 500;
            color: #162938;
            padding: 1rem;
        }

        nav form.filter input::placeholder {
            color: black;
        }

        nav form.filter select {
            border-left: 2px solid #162938;
            border-right: 2px solid #162938;
            cursor: pointer;
            transition: .1s;
        }

        nav form.filter select:hover {
            background-color: var(--main-color);
            border-radius: 1rem;
        }

        nav form.filter button {
            width: 4rem;
            border-left: 2px solid #162938;
            cursor: pointer;
            transition: .1s;
        }

        nav form.filter button:hover {
            width: 6rem;
            background-color: var(--main-color);
            border-top-left-radius: 2rem;
            border-bottom-left-radius: 2rem;
        }

        /* boardContent design */
        table tr th {
            background: var(--content-box-color);
            cursor: default;
        }

        table tbody tr {
            cursor: pointer;
            transition: .1s;
        }

        table tbody tr:hover {
            background-color: var(--content-box-color);
        }

        table tr td.MaBuoiHoc,
        table tr td.MaDoiBuoiHoc,
        table tr td.LopHoc {
            overflow-wrap: anywhere;
        }

        @media only screen and (width <=768px) {

            /* Small devices (portrait tablets and large phones, 600px and up to 768px) */
            /* media boardBar design */
            nav a {
                font-size: 1.7rem;
            }

            nav h2 {
                font-size: 2rem;
            }

            /* media boardContent design */
            table {
                margin-top: 1rem;
            }

            table thead tr th {
                border: .3rem solid black;
                border-radius: 1rem;
                font-size: 1.7rem;
            }

            table tbody tr td {
                text-align: center;
                border-right: .2rem solid black;
                border-bottom: .2rem solid black;
                font-size: 1.5rem;
            }

            table tbody tr td:last-child {
                border-right: none;
            }
        }

        @media only screen and (768px < width) {

            /* Medium devices (landscape tablets, 768px and up) */
            /* media boardBar design */
            nav a {
                font-size: 2rem;
            }

            nav h2 {
                font-size: 2.2rem;
            }

            /* media boardContent design */
            table {
                margin: 1.5rem;
                padding: .5rem 0;
                border: .3rem solid black;
                border-radius: 1rem;
                overflow: hidden;
            }

            table tr th {
                border: .2rem solid black;
                border-radius: .4rem;
                font-size: 2.1rem;
            }

            table tr td {
                text-align: center;
                border-right: .2rem solid black;
                border-bottom: .2rem solid black;
                font-size: 2rem;
            }
        }
    </style>
</head>

<body>
    <nav class="board-bar">
        <a class="turn-back" href="#">Quay lại</a>
        <h2 class="title">Danh sách lịch mượn phòng học</h2>
        <form class="filter" action="">
            <input type="search" name="searching" placeholder="Tìm kiếm">
            <select name="sort">
                <option value="Time" selected>Theo thời gian</option>
                <option value="GiangVien">Theo giảng viên</option>
                <option value="LopGiangDay">Theo lớp học</option>
                <option value="Id">Theo loại thủ tục</option>
            </select>
            <button type="submit">Lọc</button>
        </form>
        <!-- Sử dụng Usecase với trường hợp sử dụng là thêm thông tin mượn phòng học ( Form=ThemTTMPH ) -->
        <a class="add-object" href="../TTMượnPhòngHọc/index.html?UC=QLMPH&Form=ThemTTMPH">Thêm lịch mượn phòng</a>
    </nav>
    <table>
        <thead>
            <tr>
                <th class="MaBuoiHoc MaCapPhep MaDoiBuoiHoc">Mã lịch mượn phòng</th>       <!-- Mã buổi học, mã cấp phép và mã đổi buổi học được xem như là mã lịch mượn phòng -->
                <th class="GiangVien">Giảng viên</th>
                <th class="LopHoc">Lớp học</th>
                <th class="PhongHoc">Phòng học</th>
                <th class="ThoiGian_BD">Thời gian mượn</th>
                <th class="ThoiGian_KT">Thời gian trả</th>
                <th class="HinhThuc">Mục đích</th>                  <!-- Hình thức mượn phòng -->
                <th class="TrangThai">Tình trạng</th>               <!-- Trạng thái phòng được mượn, bỏ trống nếu chưa được mượn -->
            </tr>
        </thead>
        <tbody>
            <!-- <c:forEach var="LichMPH" items="${DsLichMPH}"> -->
                <!-- Sử dụng Usecase với trường hợp sử dụng là xem thông tin mượn phòng học ( Display=TTMPH ) -->
                <!-- <tr onclick="location.href = '../TTMượnPhòngHọc/index.html?UC=QLMPH&Display=TTMPH&MaBH=${LichMPH.MaMaBH}&MaCP=${LichMPH.MaCP}&MaDBH=${LichMPH.MaDBH}';">
                    <td class="MaBuoiHoc">B${LichMPH.MaBH}</td>
                    <td class="MaCapPhep">C${LichMPH.MaCP}</td>
                    <td class="MaDoiBuoiHoc">D${LichMPH.MaMaDBH}</td>
                    <td class="GiangVien">${LichMPH.GiangVien}</td>
                    <td class="LopGiangDay">${LichMPH.LopGiangDay}</td>
                    <td class="PhongHoc">${LichMPH.PhongHoc}</td>
                    <td class="ThoiGian_BD">${LichMPH.ThoiGian_BD}</td>
                    <td class="ThoiGian_KT">${LichMPH.ThoiGian_KT}</td>
                    <td class="HinhThuc">${LichMPH.HinhThuc}</td>
                    <td class="TrangThai">${LichMPH.TrangThai}</td>
                </tr> -->
            <!-- </c:forEach> -->

            <!-- Mẫu dữ liệu -->
            <!-- Sử dụng Usecase với trường hợp sử dụng là xem thông tin mượn phòng học ( Display=TTMPH ) -->
            <tr onclick="location.href = '../TTMượnPhòngHọc/index.html?UC=QLMPH&Display=TTMPH&MaBH=100213&MaCP=&MaDBH=';">
                    <td class="MaBuoiHoc">B100213</td>
                    <td class="MaCapPhep" hidden></td>
                    <td class="MaDoiBuoiHoc" hidden></td>
                    <td class="GiangVien">Ngô Cao Hy</td>
                    <td class="LopGiangDay">D21CQCN01-N</td>
                    <td class="PhongHoc">2B31</td>
                    <td class="ThoiGian_BD">7:00 02/03/2024</td>
                    <td class="ThoiGian_KT">10:30 02/03/2024</td>
                    <td class="HinhThuc">Học thực hành</td>
                    <td class="TrangThai manager-view">Đã mượn</td>
            </tr>
            <!-- Sử dụng Usecase với trường hợp sử dụng là xem thông tin mượn phòng học ( Display=TTMPH ) -->
            <tr onclick="location.href = '../TTMượnPhòngHọc/index.html?UC=QLMPH&Display=TTMPH&MaBH=&MaCP=100214&MaDBH=';">
                    <td class="MaBuoiHoc" hidden></td>
                    <td class="MaCapPhep">C100214</td>
                    <td class="MaDoiBuoiHoc" hidden></td>
                    <td class="GiangVien">Nguyễn Hữu Vinh</td>
                    <td class="LopHoc">D21CQCN01-N</td>
                    <td class="PhongHoc">2A08</td>
                    <td class="ThoiGian_BD">7:00 08/03/2024</td>
                    <td class="ThoiGian_KT">10:30 08/03/2024</td>
                    <td class="HinhThuc">Khác</td>
                    <td class="TrangThai admin-view manager-view">Đã hủy</td>
            </tr>
            <tr onclick="location.href = '../TTMượnPhòngHọc/index.html?UC=QLMPH&Display=TTMPH&MaBH=&MaCP=&MaDBH=100214;">
                <td class="MaBuoiHoc" hidden></td>
                <td class="MaDoiBuoiHoc">D100214</td>
                <td class="GiangVien">Nguyễn Thị Bích Nguyên</td>
                <td class="LopHoc">D21CQCN02-N</td>
                <td class="PhongHoc">2A08</td>
                <td class="ThoiGian_BD">13:00 10/03/2024</td>
                <td class="ThoiGian_KT">16:30 10/03/2024</td>
                <td class="HinhThuc">Học lý thuyết</td>
                <td class="TrangThai"></td>
            </tr>
        </tbody>
    </table>
</body>

</html>