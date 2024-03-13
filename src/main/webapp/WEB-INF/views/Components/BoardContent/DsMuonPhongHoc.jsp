<!-- Điều hướng nhận điều kiện:
        UC              -   Usecase sử dụng
        Display         -   UC/Display sử dụng
        Form            -   UC/Form sử dụng
        UIDManager      -   UsecaseID quản lý
        UIDRegular      -   UsecaseID người mượn phòng
    Xử lý thông tin từ controller:
        MaLMPH = MaBH ? "B" + MaBH : (MaCP ? "C" + MaCP : ( MaDBH ? "D" + MaDBH : ""))
        TrangThai = IdMPH || MaDBH ? (_DeleteAt ? "Đã hủy" : "Đã mượn phòng") : "Chưa mượn phòng"  
    Điều hướng nhận thông tin:
        SearchInput - Dữ liệu tìm kiếm
        SearchOption
        <LichMPH> với thông tin:
        MaLMPH          -   Mã lịch mượn phòng
        MaLH            -   Mã lớp học
        IdGV            -   Id giảng viên
        GiangVien       -   Họ tên giảng viên
        MaLopSV         -   Mã lớp giảng dạy
        MaMH            -   Mã môn học
        TenMH           -   Tên môn học
        MaPH            -   Mã phòng học    
        ThoiGian_BD     -   Thời gian mượn
        ThoiGian_KT     -   Thời gian trả
        HinhThuc        -   Hình thức
        LyDo            -   Lý do
        TrangThai       -   Trạng thái mượn
        NgMPH           -   Người mượn phòng học
        VaiTro          -   Vai trò người mượn phòng
        QL_Duyet        -   Quản lý duyệt
        YeuCau          -   Yêu cầu khi mượn
-->
<!--    
    Test data CSDL
    Thử ghép data từ nhiều bảng như trên
    Bộ lọc trang web:
        Vào trang web nào với Usecase thì bỏ thông tin. VD: Mượn phòng học thì bỏ thông tin lịch mượn phòng đã mượn.
-->
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

        *.hidden {
            display: none;
        }

        :root {
            --bg-color: #f1dc9c;
            --second-bg-color: #fcf0cf;
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

            a {
                font-weight: 500;
                color: var(--text-color);
            }

            a.add-object {
                text-align: end;
            }

            h2 {
                cursor: default;
            }

            form {
                position: relative;
                flex-basis: 100rem;
                width: 100%;
                height: auto;
                display: flex;
                border: 2px solid #162938;
                border-radius: .7rem;
                gap: 1rem;
                overflow: hidden;

                input {
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

                input::placeholder {
                    color: black;
                }

                select {
                    border-left: 2px solid #162938;
                    border-right: 2px solid #162938;
                    cursor: pointer;
                    transition: .1s;
                }

                select:hover {
                    background-color: var(--text-box-color);
                    border-radius: 1rem;
                }

                button {
                    width: 4rem;
                    border-left: 2px solid #162938;
                    cursor: pointer;
                    transition: .1s;
                }

                button:hover {
                    width: 5rem;
                    background-color: var(--text-box-color);
                    border-top-left-radius: 1rem;
                    border-bottom-left-radius: 1rem;
                }

            }
        }

        /* boardContent design */

        table {
            tr th {
                background: var(--main-color);
                cursor: default;
            }

            tbody tr {
                cursor: pointer;
                transition: .1s;
            }

            tbody tr.hidden {
                display: none;
            }

            tbody tr:hover {
                background-color: var(--main-color);
            }

            tr td.MaBuoiHoc,
            tr td.MaDoiBuoiHoc,
            tr td.LopGiangDay {
                overflow-wrap: anywhere;
            }
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
    <script>
        function setUsecases() {
            const urlParams = new URLSearchParams(window.location.search);

            // Lấy giá trị của các tham số từ URL
            const UC = urlParams.get('UC');
            const Display = urlParams.get('Display');
            const Form = urlParams.get('Form');
            const UIDManager = urlParams.get('UIDManager');
            const UIDRegular = urlParams.get('UIDRegular');

            const SearchInput = urlParams.get('SearchInput');
            const SearchOption = urlParams.get('SearchOption');

            // console.log(UC, Display, Form, UIDManager,UIDRegular)
            // console.log(SearchInput, SearchOption)
            // Trường hợp xem danh sách lịch mượn phòng học
            if (UIDManager && UC === 'DsMPH' && Display === 'DsMPH') {

                // Ẩn phần tử button hướng dẫn
                document.querySelector('button#openGuide').classList.add("hidden");

            }
            // Trường hợp xem danh sách lịch mượn phòng học theo giảng viên
            else if (UIDManager && UC === 'DsGV' && Display === 'DsMPH') {

                if (SearchInput) document.querySelector('.filter input').value = SearchInput;
                if (SearchOption) document.querySelector('.filter option[value="GiangVien"]').setAttribute('selected', 'selected');

                // Ẩn phần tử button hướng dẫn
                document.querySelector('button#openGuide').classList.add("hidden");

            }
            // Trường hợp lập thủ tục mượn phòng học
            else if (UIDRegular && UC === 'MPH' & Display === 'YCMPH') {

                // Ẩn các phần tử button trong nav
                document.querySelector('.board-bar .add-object').classList.add("hidden");

                // Ẩn các phần tử label trong form
                document.querySelector('.board-content .DsNgMPH').classList.add("hidden");
                // Ẩn các phần tử button trong form
                document.querySelector('.board-content .submit-object').classList.add("hidden");

                // Bỏ thuộc tính disabled của các phần tử input
                document.querySelector('.board-content .YeuCau input').removeAttribute('disabled');

            }
            else {
                window.location.href = "../ErrorHandling/index.html";
            }
        }

        function sortbyTerm() {
            const form = document.querySelector('.filter');
            const tableBody = document.querySelector('tbody');

            form.addEventListener('submit', function (event) {
                event.preventDefault();

                const searchTerm = form.searching.value.toLowerCase();
                const sortBy = form.sort.value;

                const rows = Array.from(tableBody.getElementsByTagName('tr'));

                rows.sort((a, b) => {
                    const aValue = a.querySelector(`.${sortBy}`).textContent.toLowerCase();
                    const bValue = b.querySelector(`.${sortBy}`).textContent.toLowerCase();

                    if (sortBy === 'ThoiGian_BD') {
                        function parseTimeString(timeString) {
                            const [time, date] = timeString.split(' ');
                            const [hours, minutes] = time.split(':');
                            const [day, month, year] = date.split('/');

                            // Month in JavaScript is 0-based, so we subtract 1
                            return new Date(year, month - 1, day, hours, minutes);
                        }

                        const aTime = parseTimeString(aValue);
                        const bTime = parseTimeString(bValue);

                        return aTime - bTime;
                    } else {
                        return aValue.localeCompare(bValue);
                    }
                });

                tableBody.innerHTML = '';
                rows.forEach(row => {
                    const containsSearchTerm = searchTerm === '' || Array.from(row.children).some(cell => cell.textContent.toLowerCase().includes(searchTerm));
                    if (containsSearchTerm) {
                        tableBody.appendChild(row);
                    }
                });
            });
        }

        document.addEventListener("DOMContentLoaded", function () {
            setUsecases();
            sortbyTerm();
        });
    </script>
</head>

<body>
    <nav class="board-bar">
        <a class="go-home" href="../Login/index.html?UIDManager=${UIDManager}&UIDRegular=${UIDRegular}"
            target="_parent">Trang chủ</a>
        <h2>Danh sách lịch mượn phòng học</h2>
        <form class="filter" action="">
            <input type="search" name="searching" placeholder="Tìm kiếm" disabled>
            <select name="sort">
                <option value="ThoiGian_BD">Theo thời gian</option>
                <option value="GiangVien">Theo giảng viên</option>
                <option value="MaLopSV">Theo lớp học</option>
                <option value="HinhThuc">Theo loại thủ tục</option>
            </select>
            <button type="submit">Lọc</button>
        </form>
        <hr>
        <!-- Sử dụng Usecase với trường hợp sử dụng là thêm thông tin mượn phòng học
    điều hướng với điều kiện:
        UC=DsMPH
        Form=ThemTTMPH
        UIDManager
-->
        <a class="add-object"
            href="../TTMuonPhongHoc/index.html?UC=DsMPH&Form=ThemTTMPH&UIDManager=123456987">Thêm lịch mượn
            phòng</a>
    </nav>
    <table>
        <thead>
            <tr>
                <th class="MaLMPH">Mã lịch mượn phòng</th> <!-- Mã lịch mượn phòng -->
                <th class="GiangVien">Giảng viên</th>
                <th class="MaLopSV">Lớp học</th>
                <th class="MaMH">Lớp học</th>
                <th class="PhongHoc">Phòng học</th>
                <th class="ThoiGian_BD">Thời gian mượn</th>
                <th class="ThoiGian_KT">Thời gian trả</th>
                <th class="HinhThuc">Mục đích</th> <!-- Hình thức mượn phòng -->
                <th class="TrangThai">Trạng thái</th> <!-- Trạng thái -->
            </tr>
        </thead>
        <tbody>
            <!-- <c:forEach var="LichMPH" items="${LichMPH}"> -->
            <!-- Sử dụng Usecase với trường hợp sử dụng là xem thông tin mượn phòng học với thông tin lịch mượn phòng đã chọn 
            điều hướng với điều kiện: 
                UC=DsMPH
                Display=TTMPH
                UIDManager
            điều hướng với thông tin:
                MaLMPH=${LichMPH.MaLMPH}
                MaLH=${LichMPH.MaLH}
                IdGV==${LichMPH.IdGV}
                GiangVien=${LichMPH.GiangVien}
                MaLopSV=${LichMPH.MaLopSV}
                MaMH=${LichMPH.MaMH}
                TenMH=${LichMPH.TenMH}
                MaPH=${LichMPH.MaPH}
                ThoiGian_BD=${LichMPH.ThoiGian_BD}
                ThoiGian_KT=${LichMPH.ThoiGian_KT}
                HinhThuc=${LichMPH.HinhThuc}
                LyDo=${LichMPH.LyDo}
                TrangThai=${LichMPH.TrangThai}
                NgMPH=${LichMPH.NgMPH}
                VaiTro=${LichMPH.VaiTro}
                QL_Duyet=${LichMPH.QL_Duyet}
                YeuCau=${LichMPH.YeuCau}
        -->
            <!-- Sử dụng Usecase với trường hợp sử dụng là lập thủ tục mượn phòng học với thông tin lịch mượn phòng đã chọn 
            điều hướng với điều kiện: 
                UC=MPH
                Display=YCMPH
                UIDRegular
            điều hướng với thông tin:
                MaLMPH=${LichMPH.MaLMPH}
                MaLH=${LichMPH.MaLH}
                IdGV==${LichMPH.IdGV}
                GiangVien=${LichMPH.GiangVien}
                MaLopSV=${LichMPH.MaLopSV}
                MaMH=${LichMPH.MaMH}
                TenMH=${LichMPH.TenMH}
                MaPH=${LichMPH.MaPH}
                ThoiGian_BD=${LichMPH.ThoiGian_BD}
                ThoiGian_KT=${LichMPH.ThoiGian_KT}
                HinhThuc=${LichMPH.HinhThuc}
                LyDo=${LichMPH.LyDo}
                TrangThai=${LichMPH.TrangThai}
                NgMPH=${LichMPH.NgMPH}
                VaiTro=${LichMPH.VaiTro}
                QL_Duyet=${LichMPH.QL_Duyet}
                YeuCau=${LichMPH.YeuCau}
        -->
            <!-- <tr onclick="location.href = '../TTMuonPhongHoc/index.html?UC=${UC}&Display=${Display}&Form=${Form}&UIDManager=${UIDManager}&UIDRegular=${UIDRegular}&MaLMPH=${LichMPH.MaLMPH}&MaLH=${LichMPH.MaLH}&GiangVien=${LichMPH.GiangVien}&MaLopSV=${LichMPH.MaLopSV}&MaMH=${LichMPH.MaMH}&TenMH=${LichMPH.TenMH}&MaPH=${LichMPH.MaPH}&ThoiGian_BD=${LichMPH.ThoiGian_BD}&ThoiGian_KT=${LichMPH.ThoiGian_KT}&HinhThuc=${LichMPH.HinhThuc}&LyDo=${LichMPH.LyDo}&TrangThai=${LichMPH.TrangThai}&NgMPH=${LichMPH.NgMPH}&VaiTro=${LichMPH.VaiTro}&QL_Duyet=${LichMPH.QL_Duyet}&YeuCau=${LichMPH.YeuCau}';">
            <td class="MaLMPH">B${LichMPH.MaLMPH}</td>
            <td class="GiangVien">${LichMPH.GiangVien}</td>
            <td class="LopGiangDay">${LichMPH.MaLopSV}</td>
            <td class="TenMH">${LichMPH.TenMH}</td>
            <td class="MaPH">${LichMPH.MaPH}</td>
            <td class="ThoiGian_BD">${LichMPH.ThoiGian_BD}</td>
            <td class="ThoiGian_KT">${LichMPH.ThoiGian_KT}</td>
            <td class="HinhThuc">${LichMPH.HinhThuc}</td>
            <td class="TrangThai">${LichMPH.TrangThai}</td>
        </tr> -->
            <!-- </c:forEach> -->

            <!-- Mẫu dữ liệu -->
            <!-- Test data cho lập thủ tục mượn phòng học -->
            <tr
                onclick="location.href = '../TTMuonPhongHoc/index.html?UC=MPH&Display=YCMPH&UIDRegular=123456987&MaLMPH=B100213&MaLH=L123&GiangVien=Nguy%E1%BB%85n%20%C4%90%E1%BB%A9c%20Th%E1%BB%8Bnh&MaLopSV=D22CQCN01-N&MaMH=INT1359-3&TenMH=To%C3%A1n%20r%E1%BB%9Di%20r%E1%BA%A1c%202&MaPH=2B31&ThoiGian_BD=7%3A00%2002%2F03%2F2024&ThoiGian_KT=10%3A30%2002%2F03%2F2024&HinhThuc=H%E1%BB%8Dc%20th%E1%BB%B1c%20h%C3%A0nh&LyDo=&TrangThai=Ch%C6%B0a%20m%E1%BB%B1%E1%BB%9Dn&NgMPH=&VaiTro=&QL_Duyet=&YeuCau=';">
                <td class="MaLMPH">B100213</td>
                <td class="GiangVien">Nguyễn Đức Thịnh</td>
                <td class="MaLopSV">D21CQCN02-N</td>
                <td class="TenMH">Toán rời rạc 2</td>
                <td class="MaPH">2B31</td>
                <td class="ThoiGian_BD">7:00 02/03/2024</td>
                <td class="ThoiGian_KT">10:30 02/03/2024</td>
                <td class="HinhThuc">Học thực hành</td>
                <td class="TrangThai">Chưa mượn</td>
            </tr>
            <!-- Test data rỗng -->
            <tr
                onclick="location.href = '../TTMuonPhongHoc/index.html?UC=DsMPH&Display=TTMPH&UIDManager=123456987';">
                <td class="MaLMPH">C100214</td>
                <td class="GiangVien"></td>
                <td class="MaLopSV"></td>
                <td class="TenMH"></td>
                <td class="MaPH">2A08</td>
                <td class="ThoiGian_BD">7:00 18/03/2024</td>
                <td class="ThoiGian_KT">10:30 18/03/2024</td>
                <td class="HinhThuc">Khác</td>
                <td class="TrangThai">Đã hủy</td>
            </tr>
            <!-- Test data cho xem thông tin lịch mượn phòng -->
            <tr
                onclick="location.href = '../TTMuonPhongHoc/index.html?UC=DsMPH&Display=TTMPH&UIDManager=123456987&MaLMPH=D100214&GiangVien=Nguy%E1%BB%85n%20Th%E1%BB%8B%20B%C3%ADch%20Nguy%C3%AAn&MaLopSV=D21CQCN01-N&TenMH=Nh%E1%BA%ADp%20m%C3%B4n%20c%C3%B4ng%20ngh%E1%BB%87%20ph%E1%BA%A7n%20m%E1%BB%81m&MaPH=2A08&ThoiGian_BD=13%3A00%2028%2F02%2F2024&ThoiGian_KT=16%3A30%2028%2F02%2F2024&HinhThuc=H%E1%BB%8Dc%20l%C3%BD%20thuy%E1%BA%BFt&LyDo=%C4%90%E1%BB%95i%20ph%C3%B2ng%20h%E1%BB%8Dc&TrangThai=%C4%90%C3%A3%20m%C6%B0%E1%BB%A3n&NgMPH=Ng%C3%B4%20Cao%20Hy&VaiTro=Tr%E1%BB%A3%20gi%E1%BA%A3ng&QL_Duyet=Th%C3%A1i%20V%C4%83n%20Anh%20Ch%C3%ADnh&YeuCau=MC%2BR%2BMT';">
                <td class="MaLMPH">D100214</td>
                <td class="GiangVien">Nguyễn Thị Bích Nguyên</td>
                <td class="MaLopSV">D21CQCN01-N</td>
                <td class="TenMH">Nhập môn công nghệ phần mềm</td>
                <td class="MaPH">2A08</td>
                <td class="ThoiGian_BD">13:00 28/02/2024</td>
                <td class="ThoiGian_KT">16:30 28/02/2024</td>
                <td class="HinhThuc">Học lý thuyết</td>
                <td class="TrangThai">Đã mượn</td>
            </tr>
        </tbody>
    </table>
    <button id="openGuide" onclick="window.dialog.showModal()">Hướng dẫn</button>
    <dialog id="dialog">
        <form method="dialog">
            <div>Hướng dẫn</div>
            <p>
                <b>1. Chọn lịch học mà sinh viên, giảng viên cần mượn phòng giảng dạy.<br></b>
                2. Cung cấp thêm thông tin mượn phòng để quản lý duyệt. <br>
                3. Chờ quản lý kiểm tra thông tin và nhận đồ xài :&gt;
            </p>
            <button>Close</button>
        </form>
    </dialog>
    <style>
        button#openGuide {
            position: absolute;
            bottom: 0px;
            right: 0px;
            border: .2rem solid black;
            border-radius: 1rem;
            padding: .3rem;
        }

        button#openGuide.hidden {
            display: none;
        }

        button#closeGuide {
            border: .2rem solid black;
            border-radius: 1rem;
            padding: .3rem;
        }

        dialog {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            border: .2rem solid black;
            border-radius: 1rem;
            padding: .5rem;

            b {
                color: blue;
            }
        }

        dialog::backdrop {
            background-color: var(--bg-color);
            opacity: .2;
        }

        @media only screen and (width <=768px) {

            /* Small devices (portrait tablets and large phones, 600px and up to 768px) */
            dialog {
                div {
                    font-size: 1.5rem;
                }

                p {
                    font-size: 1rem;
                }
            }
        }

        @media only screen and (768px < width) {

            /* Medium devices (landscape tablets, 768px and up) */
            dialog {
                div {
                    font-size: 2.2rem;
                }

                p {
                    font-size: 1.5rem;
                }
            }
        }
    </style>
    <script>
        function onClick(event) {
            if (event.target === dialog) {
                dialog.close();
            }
        }

        const dialog = document.querySelector("dialog");
        dialog.addEventListener("click", onClick);
    </script>
</body>

</html>