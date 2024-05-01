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
            <DsNhomHocPhan>:
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
    <title>Danh sách lớp</title>

    <style>
        /* MARK: CSS */
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
            background: var(--bg-color);
            display: flex;
            flex-shrink: 0;
            justify-content: space-between;
            align-items: center;
            box-shadow: 1px 1px 2px var(--main-box-color);
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
                flex-basis: 50rem;
                width: 100%;
                height: auto;
                display: flex;
                border: 2px solid var(--main-box-color);
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

                    td.IdNHP,
                    td.MonHoc,
                    td.LopSV {
                        overflow-wrap: anywhere;
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
                            font-size: .8rem;
                        }

                        td.To {
                            padding: 0 1rem;
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

                    thead th {
                        border: .2rem solid var(--main-box-color);
                        border-radius: .4rem;
                        font-size: 1.8rem;
                    }

                    tbody {
                        td {
                            font-size: 1.4rem;
                        }

                        td.To {
                            padding: 0 2rem;
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

        let urlParts = url.split('?');

        let paths = urlParts[0].split('/');
        let params = new URLSearchParams(urlParts[1]);

        // Lấy thông tin từ paths urls
        var Usecase = paths[paths.length - 2];
        var UsecasePath = paths[paths.length - 1];

        // Lấy thông tin từ params urls
        var SearchInput = params.get('SearchInput');
        var SearchOption = params.get('SearchOption');

        // Lấy giá trị của các tham số từ sessionScope
        var UIDManager = sessionStorage.getItem('UIDManager');
        var UIDRegular = sessionStorage.getItem('UIDRegular');
        var UIDAdmin = sessionStorage.getItem('UIDAdmin');

        // In ra console để kiểm tra
        //console.log(Usecase, UsecasePath, UIDManager,UIDRegular)
        //console.log(SearchInput, SearchOption)

        // MARK: setUsecases
        function setUsecases() {

            if (UIDManager && UIDRegular) {
                window.location.href = "../Error?Message=Lỗi UIDManager và UIDRegular đồng thời đăng nhập";
            }
            // Trường hợp người sử dụng là quản lý MARK: Manager
            else if (UIDManager) {

                // Trường hợp xem danh sách lớp học theo bộ lọc MARK: XemDsNHP
                if (Usecase === 'DsNHP' && UsecasePath === 'XemDsNHP') {

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");

                    // Ẩn phần tử button hướng dẫn
                    document.querySelector('button#openGuide').classList.add("hidden");

                } else if (Usecase === 'DsNHP' && UsecasePath === 'ThemTTMPH') {

                    // Ẩn các phần tử a trong nav
                    document.getElementById("add-object").classList.add("hidden");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Thêm lịch mượn phòng học";

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");

                    // Ẩn phần tử button hướng dẫn
                    document.querySelector('button#openGuide').classList.add("hidden");
                }
                else {  //Xử lý lỗi ngoại lệ truy cập
                    window.location.href = "../Error?Message= Lỗi UID hoặc Usecase không tìm thấy";
                }

            }
            // Trường hợp người sử dụng là người mượn phòng MARK: Regular
            else if (UIDRegular) {

                //Trường hợp lập thủ tục đổi buổi học MARK: ChonLHP
                if (Usecase === 'DPH' && UsecasePath === 'ChonLHP') {

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-regular");

                    // Ẩn các cột trong table
                    document.querySelector('table thead th.IdNHP').classList.add("hidden");
                    var IdNHPtbody = document.querySelectorAll('table tbody td.IdNHP');
                    IdNHPtbody.forEach((element) => { element.classList.add("hidden"); });

                }
                else {  //Xử lý lỗi ngoại lệ truy cập
                    window.location.href = "../Error?Message= Lỗi UID hoặc Usecase không tìm thấy";
                }
            }
            else {  // Không phát hiện mã UID
                window.location.href = "../Login?Message=Không phát hiện mã UID";
            }
        }

        // MARK: setFormValues
        function setFormValues() {

            if (SearchInput) document.querySelector('.filter input').value = SearchInput;

            if (SearchOption === 'GiangVien') document.querySelector('.filter option[value="GiangVien"]').setAttribute('selected', 'selected');
            else if (SearchOption === 'Ngay_BD') document.querySelector('.filter option[value="Ngay_BD"]').setAttribute('selected', 'selected');
            else document.querySelector('.filter option[value="GiangVien"]').setAttribute('selected', 'selected');

        }

        // MARK: setFormAction
        function setFormAction() {
            const form = document.querySelector('.filter');
            const tableBody = document.querySelector('tbody');

            form.addEventListener('submit', function (event) {
                sortAction(form, tableBody);
            });
        };
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
                    } else {
                        row.children[index].classList.remove("hidden");
                    }
                });

                // Thêm hàng vào tbody của bảng
                tableBody.appendChild(row);
            });
        }

        // Gọi hàm khi trang được load
        // MARK: DOMContentLoaded
        document.addEventListener("DOMContentLoaded", function () {
            setUsecases();
            setFormValues();
            // setFormAction();
            // sortAction(); 
        });


    </script>
</head>

<body>
    <!-- MARK: boardbar -->
    <nav class="board-bar">
        <a class="go-back" href="#" onclick="history.back();">Quay lại</a>
        <h2 class="title">Danh sách lớp học</h2>
        <form class="filter" action="">
            <input type="search" name="searching" placeholder="Nhập nội dung tìm kiếm">
            <select name="sort">
                <option value="GiangVien">Theo giảng viên</option>
                <option value="Ngay_BD">Theo thời gian</option>
            </select>
            <button type="submit">Lọc</button>
        </form>
        <a id="transfer-view" href="#scriptSet432576">Xem theo nhóm học phần</a>
        <script id="scriptSet543257">
            var tableLink = document.getElementById('transfer-view');
            tableLink.setAttribute('href', "../DsNHP/XemDsLHP?" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
        </script>
        <hr>
        <a id="add-object" href="#scriptSet432576">Thêm lớp học phần</a>
        <script id="scriptSet432576">
            var tableLink = document.getElementById('add-object');
            tableLink.setAttribute('href', "../CTLHP/ThemTTLHP?" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
        </script>
    </nav>
    <!-- MARK: boardcontent -->
    <main>
        <table>
            <thead>
                <tr>
                    <th class="IdNHP">Mã nhóm học phần</th>
                    <th class="MonHoc">Mã môn học</th>
                    <th class="TenMonHoc">Tên môn học</th>
                    <th class="LopSV">Lớp giảng dạy</th>
                    <th class="NhomTo">Nhóm tổ</th>
                    <th class="GiangVien">Giảng viên</th>
                    <th class="MucDich">Hình thức học</th>
                    <th class="Ngay_BD">Giai đoạn bắt đầu</th>
                    <th class="Ngay_KT">Giai đoạn kết thúc</th>
                    <th class="table-option"></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="NhomHocPhan" items="${DsNhomHocPhan}">
                    <c:set var="LopHocPhanSectionSize" value="${fn:length(NhomHocPhan.lopHocPhanSections)}" />
                    <c:forEach var="LopHocPhanSection" items="${NhomHocPhan.lopHocPhanSections}">
                        <c:if test="${LopHocPhanSection.nhomTo == -1}">
                            <c:set var="LopHocPhanSectionSize" value="${LopHocPhanSectionSize-1}" />
                        </c:if>
                    </c:forEach>
                    <tr id='row-click-id-${NhomHocPhan.idNHPAsString}' class="table-row">
                        <td class="IdNHP"
                            rowspan="${LopHocPhanSectionSize}">
                            ${NhomHocPhan.idNHPAsString}
                        </td>
                        <td class="MonHoc"
                            rowspan="${LopHocPhanSectionSize}">
                            ${NhomHocPhan.monHoc.maMH}
                        </td>
                        <td class="TenMonHoc"
                            rowspan="${LopHocPhanSectionSize}">
                            ${NhomHocPhan.monHoc.tenMH}
                        </td>
                        <td class="LopSV" rowspan="${LopHocPhanSectionSize}">
                            ${NhomHocPhan.lopSV.maLopSV}
                        </td>
                        <c:forEach var="LopHocPhanRoot" items="${NhomHocPhan.lopHocPhanSections}">
                            <c:if test="${LopHocPhanRoot.nhomToAsString == '255'}">
                                <td class="NhomTo">
                                    N-${NhomHocPhan.nhomAsString}
                                </td>
                                <td class="GiangVien">
                                    ${LopHocPhanRoot.giangVien.ttNgMPH.hoTen}
                                </td>
                                <td class="MucDich">
                                    ${LopHocPhanRoot.mucDich == 'LT' ? "Lý thuyết"
                                    : LopHocPhanRoot.mucDich == 'TH' ? "Thực hành"
                                    : LopHocPhanRoot.mucDich == 'TN' ? "Thí nghiệm"
                                    : LopHocPhanRoot.mucDich == 'U' ? "Khác"
                                    : "Không xác định"}
                                </td>
                                <td class="Ngay_BD">
                                    <fmt:formatDate var="keyngay_BD"
                                        value="${LopHocPhanRoot.ngay_BD}"
                                        pattern="dd/MM/yyyy" />
                                    ${keyngay_BD}
                                </td>
                                <td class="Ngay_KT">
                                    <fmt:formatDate var="keyngay_KT"
                                        value="${LopHocPhanRoot.ngay_KT}"
                                        pattern="dd/MM/yyyy" />
                                    ${keyngay_KT}
                                </td>
                                <c:if test="${NextUsecaseTableRowChoose == null && NextUsecasePathTableRowChoose == null}">
                                    <td id="table-option-id-${NhomHocPhan.idNHPAsString}"
                                        class="table-option" rowspan="${LopHocPhanSectionSize}">
                                        <!-- Nếu không có Usecase và UsecasePath thích hợp chuyển tiếp, hiển thị button option -->
                                        <button id="button-option" type="button">
                                            <ion-icon name="ellipsis-vertical-outline"></ion-icon>
                                        </button>
                                        <div class="hover-dropdown-menu">
                                            <ul class="dropdown-menu">
                                                <li><a id="option-one-id-${NhomHocPhan.idNHPAsString}"
                                                    href="#scriptSet452436">
                                                    Xem chi tiết
                                                </a></li>
                                                <li><a id="option-two-id-${NhomHocPhan.idNHPAsString}"
                                                    href="#scriptSet653275">
                                                    Sửa nhóm học phần
                                                </a></li>
                                                <li><a id="option-three-id-${NhomHocPhan.idNHPAsString}"
                                                    href="#scriptSet553535">
                                                    Xóa nhóm học phần
                                                </a></li>
                                                <li><a id="option-four-id-${NhomHocPhan.idNHPAsString}"
                                                    href="#scriptSet195728">
                                                    Lịch mượn phòng theo lớp sinh viên
                                                </a></li>
                                            </ul>
                                        </div>
                                        <script id="scriptSet452436">
                                            var tableLink = document.getElementById('option-one-id-${NhomHocPhan.idNHPAsString}');
                                            tableLink.setAttribute('href', "../${NextUsecaseTableOption1}/${NextUsecasePathTableOption1}?IdNHP=${NhomHocPhan.idNHPAsString}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
                                        </script>
                                        <script id="scriptSet653275">
                                            var tableLink = document.getElementById('option-two-id-${NhomHocPhan.idNHPAsString}');
                                            tableLink.setAttribute('href', "../${NextUsecaseTableOption2}/${NextUsecasePathTableOption2}?IdNHP=${NhomHocPhan.idNHPAsString}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
                                        </script>
                                        <script id="scriptSet553535">
                                            var tableLink = document.getElementById('option-three-id-${NhomHocPhan.idNHPAsString}');
                                            tableLink.setAttribute('href', "../${NextUsecaseTableOption3}/${NextUsecasePathTableOption3}?IdNHP=${NhomHocPhan.idNHPAsString}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
                                        </script>
                                        <script id="scriptSet195728">
                                            var tableLink = document.getElementById('option-four-id-${NhomHocPhan.idNHPAsString}');
                                            tableLink.setAttribute('href', "../${NextUsecaseTableOption4}/${NextUsecasePathTableOption4}?SearchInput=${NhomHocPhan.lopSV.maLopSV}&SearchOption=LopSV" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
                                        </script>
                                    </td>
                                </c:if>
                                <script>
                                    {
                                        // Hiệu ứng khi rê chuột vào hàng
                                        var row0NhomToLink = document.querySelector('#row-click-id-${NhomHocPhan.idNHPAsString} .NhomTo');
                                        var row0GiangVienLink = document.querySelector('#row-click-id-${NhomHocPhan.idNHPAsString} .GiangVien');
                                        var row0MucDichLink = document.querySelector('#row-click-id-${NhomHocPhan.idNHPAsString} .MucDich');
                                        var row0NgayBDLink = document.querySelector('#row-click-id-${NhomHocPhan.idNHPAsString} .Ngay_BD');
                                        var row0NgayKTLink = document.querySelector('#row-click-id-${NhomHocPhan.idNHPAsString} .Ngay_KT');
                                        function row0MouseOver() {
                                            document.querySelector('#row-click-id-${NhomHocPhan.idNHPAsString} .NhomTo').style.backgroundColor = "var(--main-color)";
                                            document.querySelector('#row-click-id-${NhomHocPhan.idNHPAsString} .GiangVien').style.backgroundColor = "var(--main-color)";
                                            document.querySelector('#row-click-id-${NhomHocPhan.idNHPAsString} .MucDich').style.backgroundColor = "var(--main-color)";
                                            document.querySelector('#row-click-id-${NhomHocPhan.idNHPAsString} .Ngay_BD').style.backgroundColor = "var(--main-color)";
                                            document.querySelector('#row-click-id-${NhomHocPhan.idNHPAsString} .Ngay_KT').style.backgroundColor = "var(--main-color)";
                                        }
                                        function row0MouseOut() {
                                            document.querySelector('#row-click-id-${NhomHocPhan.idNHPAsString} .NhomTo').style.backgroundColor = "";
                                            document.querySelector('#row-click-id-${NhomHocPhan.idNHPAsString} .GiangVien').style.backgroundColor = "";
                                            document.querySelector('#row-click-id-${NhomHocPhan.idNHPAsString} .MucDich').style.backgroundColor = "";
                                            document.querySelector('#row-click-id-${NhomHocPhan.idNHPAsString} .Ngay_BD').style.backgroundColor = "";
                                            document.querySelector('#row-click-id-${NhomHocPhan.idNHPAsString} .Ngay_KT').style.backgroundColor = "";
                                        }
                                        function handleMouseEvents(element) {
                                            element.addEventListener("mouseover", function () {
                                                row0MouseOver();
                                            });
                                            element.addEventListener("mouseout", function () {
                                                row0MouseOut();
                                            });
                                        }
                                        handleMouseEvents(row0NhomToLink);
                                        handleMouseEvents(row0GiangVienLink);
                                        handleMouseEvents(row0MucDichLink);
                                        handleMouseEvents(row0NgayBDLink);
                                        handleMouseEvents(row0NgayKTLink);

                                        // Chuyển hướng khi click vào hàng, nếu có Usecase và UsecasePath thích hợp chuyển tiếp
                                        if ("${NextUsecaseTableRowChoose}" !== "" && "${NextUsecasePathTableRowChoose}" !== "") {
                                            var location0Href = "location.href = '../${NextUsecaseTableRowChoose}/${NextUsecasePathTableRowChoose}?IdLHPSection=${LopHocPhanRoot.idLHPSectionAsString}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin + "'";
                                            row0NhomToLink.setAttribute('onclick', location0Href);
                                            row0GiangVienLink.setAttribute('onclick', location0Href);
                                            row0MucDichLink.setAttribute('onclick', location0Href);
                                            row0NgayBDLink.setAttribute('onclick', location0Href);
                                            row0NgayKTLink.setAttribute('onclick', location0Href);
                                            row0NhomToLink.style.cursor = "pointer";
                                            row0GiangVienLink.style.cursor = "pointer";
                                            row0MucDichLink.style.cursor = "pointer";
                                            row0NgayBDLink.style.cursor = "pointer";
                                            row0NgayKTLink.style.cursor = "pointer";
                                        }
                                    }
                                </script>
                            </c:if>
                        </c:forEach>
                        
                    </tr>
                    <c:forEach var="LopHocPhanSection" items="${NhomHocPhan.lopHocPhanSections}">
                        <c:if test="${LopHocPhanSection.nhomTo != 255 && LopHocPhanSection.nhomTo != -1}">
                            <tr id='row-click-id-${LopHocPhanSection.idLHPSectionAsString}' class="table-row">
                                <td class="NhomTo">
                                    T-${LopHocPhanSection.nhomToAsString}
                                </td>
                                <td class="GiangVien">
                                    ${LopHocPhanSection.giangVien.ttNgMPH.hoTen}
                                </td>
                                <td class="MucDich">
                                    ${LopHocPhanSection.mucDich == 'LT' ? "Lý thuyết"
                                    : LopHocPhanSection.mucDich == 'TH' ? "Thực hành"
                                    : LopHocPhanSection.mucDich == 'TN' ? "Thí nghiệm"
                                    : LopHocPhanSection.mucDich == 'U' ? "Khác"
                                    : "Không xác định"}
                                </td>
                                <td class="Ngay_BD">
                                    <fmt:formatDate var="valuengay_BD"
                                        value="${LopHocPhanSection.ngay_BD}"
                                        pattern="dd/MM/yyyy" />
                                    ${valuengay_BD}
                                </td>
                                <td class="Ngay_KT">
                                    <fmt:formatDate var="valuengay_KT"
                                        value="${LopHocPhanSection.ngay_KT}"
                                        pattern="dd/MM/yyyy" />
                                    ${valuengay_KT}
                                </td>
                                <script>
                                    {
                                        // Hiệu ứng khi rê chuột vào hàng
                                        var row1Link = document.querySelector('#row-click-id-${LopHocPhanSection.idLHPSectionAsString}');
    
                                        row1Link.addEventListener("mouseover", function () {
                                            this.style.backgroundColor = "var(--main-color)";
                                        });
                                        row1Link.addEventListener("mouseout", function () {
                                            this.style.backgroundColor = "";
                                        });
                                        // Chuyển hướng khi click vào hàng, nếu có Usecase và UsecasePath thích hợp chuyển tiếp
                                        if ("${NextUsecaseTableRowChoose}" !== "" && "${NextUsecasePathTableRowChoose}" !== "") {
                                            var location1Href = "location.href = '../${NextUsecaseTableRowChoose}/${NextUsecasePathTableRowChoose}?IdLHPSection=${LopHocPhanSection.idLHPSectionAsString}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin + "'";
                                            row1Link.setAttribute('onclick', location1Href);
                                            row1Link.style.cursor = "pointer";
                                        }
                                    }
                                </script>
                            </tr>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </tbody>
        </table>
        <c:if test="${messageStatus != '' || messageStatus != null}">
            <p>${messageStatus}</p>
        </c:if>
    </main>
    <!-- MARK: Dynamic component -->
    <button id="openGuide" class="step1" onclick="window.dialog.showModal()">Hướng dẫn</button>
    <%@ include file="../../components/partials/guide-dialog.jsp" %>
        <script type="module"
            src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>

</html>