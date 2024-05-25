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
            <DsGiangVien>
            <DsSinhVien>
        SessionStorage:
            UIDManager
            UIDRegular
    Chuẩn View URL truy cập:   ../${Usecase}/${UsecasePath}?SearchInput=${SearchInput}&SearchOption=${SearchOption}
-->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Danh sách người dùng</title>
    <style>
        /* MARK: STYLE */
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
            transition: .2s;
            scroll-behavior: smooth;
            font-family: 'Poppins', sans-serif;
        }

        *.hidden {
            display: none;
        }

        :root {
            --bg-color: #f1dc9c;
            --second-bg-color: #fcf0cf30;
            --text-color: #555453;
            --text-box-color: #fcdec9;
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
            min-height: 100vh;
            background: var(--second-bg-color);
            display: flex;
            flex-direction: column;
            color: var(--text-color);
        }

        /* MARK: boardBar design */
        nav {
            width: 100%;
            position: fixed;
            background: var(--bg-color);
            display: flex;
            flex-shrink: 0;
            justify-content: space-between;
            align-items: center;
            box-shadow: 1px 1px 2px var(--main-box-color);
            padding: .5rem 2rem;
            gap: 2rem;
            overflow: hidden;
            z-index: 1000;

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
                flex-basis: 50rem;
                width: 100%;
                height: auto;
                display: flex;
                border: 2px solid var(--main-box-color);
                border-radius: 0.7rem;
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
                    color: var(--main-box-color);
                    padding: .7rem;
                }

                input::placeholder {
                    color: black;
                }

                input:-webkit-autofill {
                    -webkit-background-clip: text;
                }

                select {
                    border-left: 2px solid var(--main-box-color);
                    border-right: 2px solid var(--main-box-color);
                    cursor: pointer;
                    transition: .1s;
                }

                select:hover {
                    background-color: var(--text-box-color);
                    border-radius: 1rem;
                }

                button {
                    width: 4rem;
                    border-left: 2px solid var(--main-box-color);
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

        /* MARK: boardContent design */
        main {
            table {
                width: 100%;
                overflow: visible;
                cursor: default;

                thead th {
                    background: var(--main-color);
                }

                tbody {
                    tr {
                        transition: .1s;
                    }

                    tr:hover {
                        background-color: var(--main-color);
                    }

                    tr.table-row {
                        position: relative;
                        overflow: visible;
                    }

                    td {
                        height: 3rem;
                        text-align: center;
                        border-right: .2rem solid var(--main-box-color);
                        border-bottom: .2rem solid var(--main-box-color);
                    }

                    td.MaGiangVien MaSinhVien,
                    td.Email {
                        overflow-wrap: anywhere;
                    }
                    td.DiaChi {
                        text-overflow: ellipsis;
                        white-space: nowrap;
                        overflow: hidden;
                    }

                    td.table-option {
                        font-size: 3rem;
                        padding: 0 .3rem;

                        button {
                            background: transparent;
                            cursor: pointer;

                            ion-icon {
                                font-size: 2rem;
                            }
                        }

                        div {
                            position: absolute;
                            top: -2rem;
                            right: 2rem;
                            height: auto;
                            display: flex;
                            padding: 1rem;
                            transform-origin: right;
                            transform: scale(0, .5);
                            transition: .2s;
                            opacity: .6;
                            z-index: 1;

                            ul {
                                background: var(--text-box-color);
                                border: .1rem solid var(--text-color);
                                border-radius: .3rem;
                                display: flex;
                                flex-direction: column;
                                padding: .5rem;

                                li {
                                    background: var(--text-box-color);
                                    width: max-content;
                                    display: inline-flex;
                                    overflow: visible;
                                    z-index: 1;

                                    a {
                                        font-weight: 500;
                                        color: var(--text-color);
                                    }
                                }
                            }

                        }
                    }
                    td.table-option:hover > div,
                    td.table-option div:hover {
                        opacity: 1;
                        transform: scale(1, 1);
                    }
                }
            }
        }

        /* MARK: media */
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
                padding-top: 6rem;

                table {
                    thead tr th {
                        border: 0.3rem solid var(--main-box-color);
                        border-radius: 1rem;
                        font-size: 1rem;
                    }

                    tbody {
                        td {
                            font-size: 0.8rem;
                        }

                        td.DiaChi {
                            max-width: 10rem;
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
                padding: 6.5rem 0.5rem 1.5rem;

                table {
                    padding: 0.5rem 0;
                    border: 0.3rem solid var(--main-box-color);
                    border-radius: 1rem;

                    thead th {
                        border: 0.2rem solid var(--main-box-color);
                        border-radius: 0.4rem;
                        font-size: 1.8rem;
                    }

                    tbody {
                        td {
                            font-size: 1.4rem;
                        }

                        td.DiaChi {
                            max-width: 15rem;
                        }
                    }
                }
            }
        }
    </style>
    <script>
        // MARK: SCRIPT
        // // Lấy địa chỉ URL hiện tại
        var url = window.location.href;

        let urlParts = url.split("?");

        let paths = urlParts[0].split('/');
        let params = new URLSearchParams(urlParts[1]);

        // Lấy thông tin từ paths urls
        var Usecase = paths[paths.length - 2];
        var UsecasePath = paths[paths.length - 1];

        // Lấy thông tin từ params urls
        var SearchInput = params.get("SearchInput");
        var SearchOption = params.get("SearchOption");

        // Lấy giá trị của các tham số từ sessionScope
        var UIDManager = sessionStorage.getItem("UIDManager");
        var UIDRegular = sessionStorage.getItem("UIDRegular");
        var UIDAdmin = sessionStorage.getItem("UIDAdmin");

        // In ra console để kiểm tra
        //console.log(Usecase, UsecasePath, UIDManager,UIDRegular)
        //console.log(SearchInput, SearchOption)

        // MARK: setUsecases
        function setUsecases() {
            if (UIDManager && UIDRegular) {
                window.location.href = "../Error?Message=Lỗi UIDManager và UIDRegular đồng thời đăng nhập";
            }
            // Trường hợp người sử dụng là quản lý MARK: Manager
            if (UIDManager) {

                // Trường hợp xem danh sách người mượn phòng học của lịch mượn phòng MARK: XemDsNguoiMuonPhongHoc
                if (Usecase === 'DsND' && UsecasePath === 'XemDsNguoiMuonPhongHoc') {

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");
                    
                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Danh sách người mượn lịch mượn phòng: ${CTLichMPH.idLMPHAsString}";

                    // Chỉnh sửa nội dung của các thẻ trong table
                    document.querySelector('thead th.MaGiangVien MaSinhVien').textContent = "Mã người mượn phòng";

                }
                // Trường hợp xem danh sách giảng viên MARK: XemDsGV
                else if (Usecase === "DsND" && UsecasePath === "XemDsGV") {

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector(".board-bar").classList.add("menu-manager");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Danh sách giảng viên";

                    // Chỉnh sửa nội dung của các thẻ trong table
                    document.querySelector('thead th.MaGiangVien MaSinhVien').textContent = "Mã giảng viên";

                }
                // Trường hợp xem danh sách sinh viên MARK: XemDsSV
                else if (Usecase === "DsND" && UsecasePath === "XemDsSV") {

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector(".board-bar").classList.add("menu-manager");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Danh sách sinh viên";

                    // Chỉnh sửa nội dung của các thẻ trong table
                    document.querySelector('thead th.MaGiangVien MaSinhVien').textContent = "Mã sinh viên";

                }
                else { //Xử lý lỗi ngoại lệ truy cập
                    window.location.href = "../Error?Message= Lỗi UID hoặc Usecase không tìm thấy";
                }
            }
            // Trường hợp người sử dụng là người mượn phòng MARK: Regular
            else if (UIDRegular) {
                window.location.href = "../Error?Message= Lỗi UID hoặc Usecase không tìm thấy";
            }
            else { //Xử lý lỗi ngoại lệ truy cập
                window.location.href = "../Login?Message=Không phát hiện mã UID";
            }
        }

        // MARK: setFormValues
        function setFormValues() {

            if (SearchInput) document.querySelector(".filter input").value = SearchInput;

            if (SearchOption === "MaGiangVien MaSinhVien") document .querySelector('.filter option[value="MaGiangVien MaSinhVien"]') .setAttribute("selected", "selected");
            else if (SearchOption === "HoTen") document.querySelector('.filter option[value="HoTen"]') .setAttribute("selected", "selected");
            else if (SearchOption === "NgaySinh") document .querySelector('.filter option[value="NgaySinh"]') .setAttribute("selected", "selected");
            else document .querySelector('.filter option[value="MaGiangVien MaSinhVien"]') .setAttribute("selected", "selected");

        };

        // MARK: setFormAction
        function setFormAction() {
            const form = document.querySelector(".filter");
            const tableBody = document.querySelector("tbody");

            form.addEventListener("submit", function (event) {
                sortAction(form, tableBody);
            });
        }

        // MARK: sortAction
        function sortAction() {
            const form = document.querySelector('.filter');
            const tableBody = document.querySelector('tbody');

            event.preventDefault();

            const searchTerm = form.searching.value.toLowerCase();
            const sortByClass = '.' + form.sort.value;

            const rows = Array.from(tableBody.getElementsByTagName('tr'));

            rows.sort((a, b) => {
                const aValue = a.querySelector(sortByClass).textContent.toLowerCase();
                const bValue = b.querySelector(sortByClass).textContent.toLowerCase();

                if (sortByClass === '.NgaySinh') {
                    function parseTimeString(timeString) {
                        var trimmedDateString = timeString.trim();
                        const [day, month, year] = trimmedDateString.split('/');

                        // Month in JavaScript is 0-based, so we subtract 1
                        return new Date(year, month - 1, day);
                    }

                    const aTime = parseTimeString(aValue);
                    const bTime = parseTimeString(bValue);

                    return aTime - bTime;
                } else if (sortByClass === '.HoTen') {
                    // Sắp xếp theo Họ Tên, chữ cái sau cùng trước và sử dụng chữ cái cuối cùng
                    const aLastName = aValue.split(' ').pop();
                    const bLastName = bValue.split(' ').pop();
        
                    if (aLastName !== bLastName) {
                        return aLastName.localeCompare(bLastName);
                    }
                    // Nếu chữ cái cuối cùng giống nhau, so sánh bình thường
                } else if (sortByClass === '.DoiTuong') {
                    return bValue.localeCompare(aValue);
                }
                return aValue.localeCompare(bValue);
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
        }

        // Gọi hàm khi trang được load
        document.addEventListener("DOMContentLoaded", function () {
            setUsecases();
            setFormValues();
            setFormAction();
            sortAction();
        });
    </script>
</head>

<body>
    <nav class="board-bar">
        <a class="go-back" href="#" onclick="history.back();">Quay lại</a>
        <h2 class="title"></h2>
        <form class="filter" action="">
            <input type="search" name="searching" placeholder="Nhập nội dung tìm kiếm">
            <select name="sort">
                <option value="MaGiangVien MaSinhVien">Theo mã</option>
                <option value="HoTen">Theo họ tên</option>
                <option value="NgaySinh">Theo ngày sinh</option>
                <c:if test="${DsGiangVien != null && DsSinhVien == null}">
                    <option value="DoiTuong">Theo đối tượng</option>
                </c:if>
            </select>
            <button type="submit">Lọc</button>
        </form>
        <hr>
    </nav>
    <main>
        <table>
            <thead>
                <tr id='row-click-id-${NguoiMuonPhongHoc.idNguoiMuonPhongHoc}' class="table-row">
                    <th class="MaGiangVien MaSinhVien">Mã đối tượng người dùng</th>
                    <th class="HoTen">Họ tên</th>
                    <th class="Email">Email</th>
                    <th class="SDT">Số điện thoại</th>
                    <th class="NgaySinh">Ngày sinh</th>
                    <th class="GioiTinh">Giới tính</th>
                    <c:choose>
                        <c:when test="${DsGiangVien != null && DsSinhVien != null}">
                            <th class="DoiTuong-Lop DoiTuong">
                                Đối tượng
                            </th>
                        </c:when>
                        <c:when test="${DsGiangVien != null}">
                            <th class="DoiTuong">
                                Đối tượng
                            </th>
                        </c:when>
                        <c:when test="${DsSinhVien != null}">
                            <th class="DoiTuong">
                                Đối tượng
                            </th>
                            <th class="Lop">
                                Lớp
                            </th>
                        </c:when>
                        <c:otherwise>Lỗi dữ liệu!</c:otherwise>
                    </c:choose>
                    <c:if test="${DsSinhVien == null || DsGiangVien == null}">
                        <th class="DiaChi">Địa chỉ</th>
                    </c:if>
                    <th class="table-option"></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="GiangVien" items="${DsGiangVien}">
                    <tr id='row-click-id-${GiangVien.maGiangVien}' class="table-row">
                        <td class="MaGiangVien">${GiangVien.maGiangVien}</td>
                        <td class="HoTen">${GiangVien.nguoiDung.hoTen}</td>
                        <td class="Email">${GiangVien.emailGiangVien}</td>
                        <td class="SDT">${GiangVien.sdt}</td>
                        <td class="NgaySinh">
                            <fmt:formatDate var="ngaySinh"
                                value="${GiangVien.nguoiDung.ngaySinh}"
                                pattern="dd/MM/yyyy" />
                            ${ngaySinh}
                        </td>
                        <td class="GioiTinh">
                            <c:choose>
                                <c:when test="${GiangVien.nguoiDung.gioiTinh == 0}">Nam</c:when>
                                <c:when test="${GiangVien.nguoiDung.gioiTinh == 1}">Nữ</c:when>
                                <c:when test="${GiangVien.nguoiDung.gioiTinh == 9}">Không ghi nhận</c:when>
                                <c:otherwise>Lỗi dữ liệu!</c:otherwise>
                            </c:choose>
                        </td>
                        <td class="DoiTuong">
                            <c:choose>
                                <c:when test="${GiangVien.maChucDanh_NgheNghiep == 'V.07.01.01'
                                    || GiangVien.maChucDanh_NgheNghiep == 'V.07.01.02'
                                    || GiangVien.maChucDanh_NgheNghiep == 'V.07.01.03'}">
                                    Giảng viên
                                </c:when>
                                <c:when test="${GiangVien.maChucDanh_NgheNghiep == 'V.07.01.23'}">
                                    Trợ giảng
                                </c:when>
                                <c:otherwise>
                                    Lỗi dữ liệu
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <c:if test="${DsSinhVien == null}">
                            <td class="DiaChi">${GiangVien.nguoiDung.diaChi}</td>
                        </c:if>
                        <c:if test="${NextUsecaseTableRowChoose == null && NextUsecasePathTableRowChoose == null}">
                            <!-- Nếu không có Usecase và UsecasePath thích hợp chuyển tiếp, hiển thị button option -->
                            <td id="table-option-id-${GiangVien.maGiangVien}" class="table-option">
                                <button id="button-option" type="button">
                                    <ion-icon name="ellipsis-vertical-outline"></ion-icon>
                                </button>
                                <div class="hover-dropdown-menu">
                                    <ul class="dropdown-menu">
                                        <li><a id="option-one-id-${GiangVien.maGiangVien}"
                                            href="#scriptSet024324">
                                            Xem chi tiết
                                        </a></li>
                                        <li><a id="option-two-id-${GiangVien.maGiangVien}"
                                            href="#scriptSet134656">
                                            Lịch mượn phòng giảng viên giảng dạy
                                        </a></li>
                                        <li><a id="option-three-id-${GiangVien.maGiangVien}"
                                            href="#scriptSet091020">
                                            Lịch mượn phòng giảng viên đã mượn 
                                        </a></li>
                                    </ul>
                                </div>
                            </td>
                            <script id="scriptSet024324">
                                var tableLink = document.getElementById('option-one-id-${GiangVien.maGiangVien}');
                                tableLink.setAttribute('href', "../${NextUsecaseTableOption1}/${NextUsecasePathTableOption1}?MaGV=${GiangVien.maGiangVien}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
                            </script>
                            <script id="scriptSet134656">
                                var tableLink = document.getElementById('option-two-id-${GiangVien.maGiangVien}');
                                tableLink.setAttribute('href', "../${NextUsecaseTableOption2}/${NextUsecasePathTableOption2}?SearchInput=${GiangVien.maGiangVien}&SearchOption=GiangVien" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
                            </script>
                            <script id="scriptSet091020">
                                var tableLink = document.getElementById('option-three-id-${GiangVien.maGiangVien}');
                                tableLink.setAttribute('href', "../${NextUsecaseTableOption3}/${NextUsecasePathTableOption3}?Command=${NextUsecaseTableCommand3}&MaNguoiMuonPhongHoc=${GiangVien.maGiangVien}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
                            </script>
                        </c:if>
                    </tr>
                    <c:if test="${NextUsecaseTableRowChoose != null && NextUsecasePathTableRowChoose != null}">
                        <script>
                            // Chuyển hướng khi click vào hàng, nếu có Usecase và UsecasePath thích hợp chuyển tiếp
                            var rowLink = document.getElementById('row-click-id-${GiangVien.maGiangVien}');
                            rowLink.setAttribute('onclick', "location.href = '../${NextUsecaseTableRowChoose}/${NextUsecasePathTableRowChoose}?MaGV=${GiangVien.maGiangVien}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin + "'");
                            rowLink.style.cursor = "pointer";
                        </script>
                    </c:if>
                </c:forEach>
                <c:forEach var="SinhVien" items="${DsSinhVien}">
                    <tr id='row-click-id-${SinhVien.maSinhVien}' class="table-row">
                        <td class="MaSinhVien">${SinhVien.maSinhVien}</td>
                        <td class="HoTen">${SinhVien.nguoiDung.hoTen}</td>
                        <td class="Email">${SinhVien.emailSinhVien}</td>
                        <td class="SDT">${SinhVien.sdt}</td>
                        <td class="NgaySinh">
                            <fmt:formatDate var="ngaySinh"
                                value="${SinhVien.nguoiDung.ngaySinh}"
                                pattern="dd/MM/yyyy" />
                            ${ngaySinh}
                        </td>
                        <td class="GioiTinh">
                            <c:choose>
                                <c:when test="${SinhVien.nguoiDung.gioiTinh == 0}">Nam</c:when>
                                <c:when test="${SinhVien.nguoiDung.gioiTinh == 1}">Nữ</c:when>
                                <c:when test="${SinhVien.nguoiDung.gioiTinh == 9}">Không ghi nhận</c:when>
                                <c:otherwise>Lỗi dữ liệu!</c:otherwise>
                            </c:choose>
                        </td>
                        <c:choose>
                            <c:when test="${DsGiangVien != null && DsSinhVien != null}">
                                <td class="DoiTuong-Lop">
                                    Sinh viên
                                    - ${SinhVien.lopSinhVien.maLopSinhVien}
                                </td>
                            </c:when>
                            <c:when test="${DsSinhVien != null}">
                                <td class="Lop">
                                    ${SinhVien.lopSinhVien.maLopSinhVien}
                                </td>
                            </c:when>
                        </c:choose>
                        <c:if test="${DsGiangVien == null}">
                            <td class="DiaChi">${SinhVien.nguoiDung.diaChi}</td>
                        </c:if>
                        <c:if test="${NextUsecaseTableRowChoose == null && NextUsecasePathTableRowChoose == null}">
                            <!-- Nếu không có Usecase và UsecasePath thích hợp chuyển tiếp, hiển thị button option -->
                            <td id="table-option-id-${SinhVien.maSinhVien}" class="table-option">
                                <button id="button-option" type="button">
                                    <ion-icon name="ellipsis-vertical-outline"></ion-icon>
                                </button>
                                <div class="hover-dropdown-menu">
                                    <ul class="dropdown-menu">
                                        <li><a id="option-one-id-${SinhVien.maSinhVien}"
                                            href="#scriptSet673678">
                                            Xem chi tiết
                                        </a></li>
                                        <li><a id="option-two-id-${SinhVien.maSinhVien}"
                                            href="#scriptSet123486">
                                            Lịch mượn phòng sinh viên đã mượn
                                        </a></li>
                                        <!-- <li><a id="option-three-id-${SinhVien.maSinhVien}"
                                            href="#scriptSet091020">
                                            Lịch mượn phòng giảng viên đã mượn 
                                        </a></li> -->
                                    </ul>
                                </div>
                            </td>
                            <script id="scriptSet673678">
                                var tableLink = document.getElementById('option-one-id-${SinhVien.maSinhVien}');
                                tableLink.setAttribute('href', "../${NextUsecaseTableOption1}/${NextUsecasePathTableOption1}?MaGV=${SinhVien.maSinhVien}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
                            </script>
                            <script id="scriptSet123486">
                                var tableLink = document.getElementById('option-two-id-${SinhVien.maSinhVien}');
                                tableLink.setAttribute('href', "../${NextUsecaseTableOption2}/${NextUsecasePathTableOption2}?Command=${NextUsecaseTableCommand2}&MaNguoiMuonPhongHoc=${SinhVien.maSinhVien}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
                            </script>
                            <!-- <script id="scriptSet091020">
                                var tableLink = document.getElementById('option-three-id-${SinhVien.maSinhVien}');
                                tableLink.setAttribute('href', "../${NextUsecaseTableOption3}/${NextUsecasePathTableOption3}?Command=${NextUsecaseTableCommand3}&MaNguoiMuonPhongHoc=${SinhVien.maSinhVien}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
                            </script> -->
                        </c:if>
                    </tr>
                    <c:if test="${NextUsecaseTableRowChoose != null && NextUsecasePathTableRowChoose != null}">
                        <script>
                            // Chuyển hướng khi click vào hàng, nếu có Usecase và UsecasePath thích hợp chuyển tiếp
                            var rowLink = document.getElementById('row-click-id-${SinhVien.maSinhVien}');
                            rowLink.setAttribute('onclick', "location.href = '../${NextUsecaseTableRowChoose}/${NextUsecasePathTableRowChoose}?MaSV=${SinhVien.maSinhVien}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin + "'");
                            rowLink.style.cursor = "pointer";
                        </script>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
        <c:if test="${messageStatus != null}">
            <p>${messageStatus}</p>
        </c:if>
    </main>
    <!-- MARK: Dynamic component -->
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>

</html>