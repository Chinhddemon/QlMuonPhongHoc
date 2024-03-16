<!-- 
    Dữ liệu tiếp nhận:
        URL:
            Paths:
                Usecase         -   Usecase sử dụng
                UsecasePath     -   UsecasePath sử dụng
            Params:
                SearchInput     -   Input tìm kiếm
                SearchOption    -   Option tìm kiếm
        Controller:
            NextUsecaseTable       -   Usecase chuyển tiếp trong table
            NextUsecasePathTable   -   UsecasePath chuyển tiếp trong table
            <DsLichMPH>:
                maLMPH          -   Mã lịch mượn phòng
                maLH            -   Mã lớp học
                giangVien       -   Họ tên giảng viên
                maLopSV         -   Mã lớp giảng dạy
                maMH            -   Mã môn học
                tenMH           -   Tên môn học
                maPH            -   Mã phòng học    
                thoiGian_BD     -   Thời gian mượn
                thoiGian_KT     -   Thời gian trả
                hinhThuc        -   Hình thức
                lydo            -   Lý do tạo lịch mượn phòng học
                trangThai       -   Trạng thái mượn phòng học
                ngMPH           -   Người mượn phòng học
                vaiTro          -   Vai trò người mượn phòng
                qL_Duyet        -   Quản lý duyệt
                thoiGian_MPH    -   Thời gian mượn phòng học
                yeuCauHocCu     -   Yêu cầu học cụ
        SessionStorage:
            UIDManager
            UIDRegular
    Chuẩn View URL truy cập:   ../${Usecase}/${UsecasePath}.htm?SearchInput=${SearchInput}&SearchOption=${SearchOption}
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
            font-size: 1rem;
            scroll-behavior: smooth;
            font-family: 'Poppins', sans-serif;
        }

        *.hidden {
            display: none;
        }

        html {
            font-size: 62.5%;
            overflow-x: hidden;
        }

        :root {
            --bg-color: #f1dc9c;
            --second-bg-color: #fcf0cf;
            --text-color: #555453;
            --text-box-color: #fcdec9;
            --main-color: #f3e0a7;
            --main-box-color: rgba(0, 0, 0, .7);
            --content-box-color: #b9b4a3;
            --admin-menu-color: #e9b4b4;
            --manager-menu-color: #ffda72;
            --regular-menu-color: #87e9e9;
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
            background-color: var(--bg-color);
            display: flex;
            flex-shrink: 0;
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
                    font-size: 1rem;
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

        nav.menu-manager {
            background: var(--manager-menu-color);
        }

        nav.menu-regular {
            background: var(--regular-menu-color);
        }

        nav.menu-admin {
            background: var(--admin-menu-color);
        }

        /* boardContent design */
        main {
            table {
                width: 100%;

                thead th {
                    background: var(--main-color);
                    cursor: default;
                }

                tbody {
                    tr {
                        cursor: pointer;
                        transition: .1s;
                    }

                    tr:hover {
                        background-color: var(--main-color);
                    }

                    td.MaBuoiHoc,
                    td.MaDoiBuoiHoc,
                    td.LopGiangDay {
                        overflow-wrap: anywhere;
                    }
                }
            }
        }

        @media only screen and (width <=768px) {

            /* Small devices (portrait tablets and large phones, 600px and up to 768px) */
            /* media boardBar design */
            nav {
                a {
                    font-size: 1rem;
                }

                h2 {
                    font-size: 1.3rem;
                }
            }

            /* media boardContent design */
            main {
                padding-top: 1rem;

                table {
                    thead th {
                        border: .3rem solid var(--main-box-color);
                        border-radius: 1rem;
                        font-size: 1rem;
                    }

                    tbody {
                        td {
                            text-align: center;
                            border-right: .2rem solid var(--main-box-color);
                            border-bottom: .2rem solid var(--main-box-color);
                            font-size: .8rem;
                        }

                        td:last-child {
                            border-right: none;
                        }
                    }
                }
            }
        }

        @media only screen and (768px < width) {

            /* Medium devices (landscape tablets, 768px and up) */
            /* media boardBar design */
            nav {
                a {
                    font-size: 1.4rem;
                }

                h2 {
                    font-size: 1.8rem;
                }
            }

            /* media boardContent design */
            main {
                padding: 1.5rem .5rem;

                table {
                    padding: .5rem 0;
                    border: .3rem solid var(--main-box-color);
                    border-radius: 1rem;
                    overflow: hidden;

                    thead th {
                        border: .2rem solid var(--main-box-color);
                        border-radius: .4rem;
                        font-size: 1.8rem;
                    }

                    tbody td {
                        text-align: center;
                        border-right: .2rem solid var(--main-box-color);
                        border-bottom: .2rem solid var(--main-box-color);
                        font-size: 1.4rem;
                    }
                }
            }
        }
    </style>
    <script>
        // // Lấy địa chỉ URL hiện tại
        var url = window.location.href;

        let urlParts = url.split('?');
        // Lấy phần pathname của URL và loại bỏ đuôi ".htm" (nếu có)
        let paths = urlParts[0].replace(/\.htm$/, '').split('/');
        let params = new URLSearchParams(urlParts[1]);

        // Lấy thông tin từ paths urls
        var Usecase = paths[paths.length - 2];
        var UsecasePath = paths[paths.length - 1];

        // Tạo dynamic memory cho paths
        var LastUsecase = null
        var LastUsecasePath = null

        // Lấy thông tin từ params urls
        var SearchInput = params.get('SearchInput')
        var SearchOption = params.get('SearchOption')

        // Lấy giá trị của các tham số từ sessionScope
        var UIDManager = sessionStorage.getItem('UIDManager');
        var UIDRegular = sessionStorage.getItem('UIDRegular');

        // In ra console để kiểm tra
        //console.log(Usecase, UsecasePath, UIDManager,UIDRegular)
        //console.log(SearchInput, SearchOption)

        function setUsecases() {

            // Trường hợp xem danh sách lịch mượn phòng học theo bộ lọc
            if (UIDManager && Usecase === 'DsMPH' && UsecasePath === 'XemDsMPH') {

                // Chỉnh sửa phần tử nav theo Usecase
                document.querySelector('.board-bar').classList.add("menu-manager");
                
                if (SearchInput) document.querySelector('.filter input').value = SearchInput;
                if (SearchOption) document.querySelector('.filter option[value="GiangVien"]').setAttribute('selected', 'selected');

                // Ẩn phần tử button hướng dẫn
                document.querySelector('button#openGuide').classList.add("hidden");

            }
            // Trường hợp lập thủ tục mượn phòng học
            else if (UIDRegular && Usecase === 'MPH' & UsecasePath === 'ChonLMPH') {

                // Chỉnh sửa phần tử nav theo Usecase
                document.querySelector('.board-bar').classList.add("menu-regular");

                // Ẩn các phần tử button trong nav
                document.querySelector('.board-bar .add-object').classList.add("hidden");

                // Ẩn các phần tử label trong form
                document.querySelector('.board-content .DsNgMPH').classList.add("hidden");
                // Ẩn các phần tử button trong form
                document.querySelector('.board-content .submit-object').classList.add("hidden");

                // Bỏ thuộc tính disabled của các phần tử input
                document.querySelector('.board-content .Yeucau input').removeAttribute('disabled');

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
                const sortByClass = '.' + form.sort.value;

                const rows = Array.from(tableBody.getElementsByTagName('tr'));

                rows.sort((a, b) => {
                    const aValue = a.querySelector(sortByClass).textContent.toLowerCase();
                    const bValue = b.querySelector(sortByClass).textContent.toLowerCase();

                    if (sortByClass === '.ThoiGian_BD') {
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
                    // Duyệt qua tất cả các ô trong hàng
                    Array.from(row.children).forEach((cell, index) => {
                        // Nếu hàng không chứa từ khóa tìm kiếm, ẩn cột đó bằng cách thiết lập style.UsecasePath thành "none"
                        if (!containsSearchTerm) {
                            row.children[index].classList.add("hidden");
                        }
                        else {
                            row.children[index].classList.remove("hidden");
                        }
                    });

                    // Thêm hàng vào tbody của bảng
                    tableBody.appendChild(row)
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
        <!-- URL sử dụng trong controller -->
        <a class="go-home" href="../Home.htm" target="_parent">Trang chủ</a>
        <h2>Danh sách lịch mượn phòng học</h2>
        <form class="filter" action="">
            <input type="search" name="searching" placeholder="Nhập nội dung tìm kiếm">
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
                Usecase=DsMPH
                UsecasePath=ThemTTMPH
                UIDManager
        -->
        <!-- URL sử dụng trong controller -->
        <a class="add-object" href="../TTMPH/ThemTTMPH">Thêm lịch mượn phòng</a>
    </nav>
    <main>
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
                <!-- Sử dụng Usecase với trường hợp sử dụng là xem thông tin mượn phòng học với thông tin lịch mượn phòng đã chọn 
                    điều hướng với điều kiện: 
                        NextUsecase-table=TTMPH
                        NextUsecasePath-table=XemTTMPH
                        UIDManager
                -->
                <!-- Sử dụng Usecase với trường hợp sử dụng là lập thủ tục mượn phòng học với thông tin lịch mượn phòng đã chọn 
                    điều hướng với điều kiện: 
                        NextUsecase-table=MPH
                        NextUsecasePath-table=YCMPH
                -->
                <c:forEach var="LichMPH" items="${DsLichMPH}">
                <!-- URL sử dụng trong controller -->
                    <tr onclick="location.href = '../${NextUsecaseTable}/${NextUsecasePathTable}.htm?LichMPH=${LichMPH}';">
                        <td class="MaLMPH">${LichMPH.maLMPH}</td>
                        <td class="GiangVien">${LichMPH.giangVien}</td>
                        <td class="MaLopSV">${LichMPH.maLopSV}</td>
                        <td class="TenMH">${LichMPH.tenMH}</td>
                        <td class="MaPH">${LichMPH.maPH}</td>
                        <td class="ThoiGian_BD">${LichMPH.thoiGian_BD}</td>
                        <td class="ThoiGian_KT">${LichMPH.thoiGian_KT}</td>
                        <td class="HinhThuc">${LichMPH.hinhThuc}</td>
                        <td class="TrangThai">${LichMPH.trangThai}</td>
                    </tr>
                </c:forEach>

                <!-- Mẫu dữ liệu -->
                <!-- Test data cho lập thủ tục mượn phòng học -->
                <!-- <tr
                    onclick="location.href = '../TTMuonPhongHoc/index.html?Usecase=MPH&Display=MPH&UIDRegular=123456987&MaLMPH=B100213&MaLH=L123&GiangVien=Nguy%E1%BB%85n%20%C4%90%E1%BB%A9c%20Th%E1%BB%8Bnh&MaLopSV=D22CQCN01-N&MaMH=INT1359-3&TenMH=To%C3%A1n%20r%E1%BB%9Di%20r%E1%BA%A1c%202&MaPH=2B31&ThoiGian_BD=7%3A00%2002%2F03%2F2024&ThoiGian_KT=10%3A30%2002%2F03%2F2024&HinhThuc=H%E1%BB%8Dc%20th%E1%BB%B1c%20h%C3%A0nh&LyDo=&TrangThai=Ch%C6%B0a%20m%E1%BB%B1%E1%BB%9Dn&NgMPH=&VaiTro=&QL_Duyet=&YeuCauHocCu=';">
                    <td class="MaLMPH">B100213</td>
                    <td class="GiangVien">Nguyễn Đức Thịnh</td>
                    <td class="MaLopSV">D21CQCN02-N</td>
                    <td class="TenMH">Toán rời rạc 2</td>
                    <td class="MaPH">2B31</td>
                    <td class="ThoiGian_BD">7:00 02/03/2024</td>
                    <td class="ThoiGian_KT">10:30 02/03/2024</td>
                    <td class="HinhThuc">Học thực hành</td>
                    <td class="TrangThai">Chưa mượn</td>
                </tr> -->
                <!-- Test data rỗng -->
                <!-- <tr
                    onclick="location.href = '../TTMuonPhongHoc/index.html?Usecase=TTMPH&Display=XemTTMPH&UIDManager=123456987';">
                    <td class="MaLMPH">C100214</td>
                    <td class="GiangVien"></td>
                    <td class="MaLopSV"></td>
                    <td class="TenMH"></td>
                    <td class="MaPH">2A08</td>
                    <td class="ThoiGian_BD">7:00 18/03/2024</td>
                    <td class="ThoiGian_KT">10:30 18/03/2024</td>
                    <td class="HinhThuc">Khác</td>
                    <td class="TrangThai">Đã hủy</td>
                </tr> -->
                <!-- Test data cho xem thông tin lịch mượn phòng -->
                <!-- <tr
                    onclick="location.href = '../TTMuonPhongHoc/index.html?Usecase=TTMPH&Display=XemTTMPH&UIDManager=123456987&MaLMPH=D100214&GiangVien=Nguy%E1%BB%85n%20Th%E1%BB%8B%20B%C3%ADch%20Nguy%C3%AAn&MaLopSV=D21CQCN01-N&TenMH=Nh%E1%BA%ADp%20m%C3%B4n%20c%C3%B4ng%20ngh%E1%BB%87%20ph%E1%BA%A7n%20m%E1%BB%81m&MaPH=2A08&ThoiGian_BD=13%3A00%2028%2F02%2F2024&ThoiGian_KT=16%3A30%2028%2F02%2F2024&HinhThuc=H%E1%BB%8Dc%20l%C3%BD%20thuy%E1%BA%BFt&LyDo=%C4%90%E1%BB%95i%20ph%C3%B2ng%20h%E1%BB%8Dc&TrangThai=%C4%90%C3%A3%20m%C6%B0%E1%BB%A3n&NgMPH=Ng%C3%B4%20Cao%20Hy&VaiTro=Tr%E1%BB%A3%20gi%E1%BA%A3ng&QL_Duyet=Th%C3%A1i%20V%C4%83n%20Anh%20Ch%C3%ADnh&YeuCauHocCu=MC%2BR%2BMT';">
                    <td class="MaLMPH">D100214</td>
                    <td class="GiangVien">Nguyễn Thị Bích Nguyên</td>
                    <td class="MaLopSV">D21CQCN01-N</td>
                    <td class="TenMH">Nhập môn công nghệ phần mềm</td>
                    <td class="MaPH">2A08</td>
                    <td class="ThoiGian_BD">13:00 28/02/2024</td>
                    <td class="ThoiGian_KT">16:30 28/02/2024</td>
                    <td class="HinhThuc">Học lý thuyết</td>
                    <td class="TrangThai">Đã mượn</td>
                </tr> -->
            </tbody>
        </table>
    </main>
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