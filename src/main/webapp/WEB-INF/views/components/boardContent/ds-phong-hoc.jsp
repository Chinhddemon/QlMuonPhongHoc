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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Danh sách Phòng Học</title>
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

                    td.table-option:hover>div,
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
            // cả hai đăng nhập cùng lúc báo lổi
            if (UIDManager && UIDRegular) {
                window.location.href = "../Error?Message=Lỗi UIDManager và UIDRegular đồng thời đăng nhập";
            }
            // Trường hợp người sử dụng là quản lý MARK: Manager
            if (UIDManager) {

                if (Usecase === "DsPH" && UsecasePath === "XemDsPH") {

                    // Chỉnh sửa phần tử nav theo Usecase
                    //Thêm lớp CSS menu-manager vào phần tử có lớp .board-bar để thay đổi giao diện điều hướng.
                    document.querySelector(".board-bar").classList.add("menu-manager");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    //Đặt nội dung của phần tử h2 trong .board-bar thành "Danh sách phòng học".
                    document.querySelector('.board-bar h2.title').textContent = "Danh sách phòng học";

                    // Chỉnh sửa nội dung của các thẻ trong table
                    // Thay đổi nội dung của tiêu đề bảng (thead th) có lớp MaGiangVien MaSinhVien thành "Mã phòng học".
                    document.querySelector('thead th.MaPhongHoc').textContent = "Mã phòng học";
                    //=> Hàm setUsecases dùng để kiểm tra trạng thái đăng nhập và các trường hợp sử dụng của người dùng. 
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
        //=> được sử dụng để thiết lập giá trị cho các phần tử trong một biểu mẫu dựa trên các giá trị đã được truyền vào (như SearchInput và SearchOption)
        function setFormValues() {
            //Nếu SearchInput tồn tại (không phải null hoặc undefined), giá trị của phần tử input trong .filter (giả sử là một phần tử input trong một biểu mẫu có lớp CSS là .filter) sẽ được đặt bằng giá trị của SearchInput.

            //if (SearchInput) document.querySelector(".filter input[name='searching']").value = SearchInput;
            //if (SearchOption === "MaPhongHoc") document.querySelector('.filter select[name="sort"] option[value="MaPhongHoc"]').selected = true;
            //else if (SearchOption === "SucChua") document.querySelector('.filter select[name="sort"] option[value="SucChua"]').selected = true;
            //else if (SearchOption === "TrangThai") document.querySelector('.filter select[name="sort"] option[value="TrangThai"]').selected = true;
            // else document.querySelector('.filter select[name="sort"] option[value="MaPhongHoc"]').selected = true;

            if (SearchInput) document.querySelector('.filter input').value = SearchInput;
            if (SearchOption === 'MaPhongHoc') document.querySelector('.filter option[value="MaPhongHoc"]').setAttribute('selected', 'selected');
            else if (SearchOption === 'SucChua') document.querySelector('.filter option[value="SucChua"]').setAttribute('selected', 'selected');
            else if (SearchOption === 'TrangThai') document.querySelector('.filter option[value="TrangThai"]').setAttribute('selected', 'selected');
            else if (SearchOption === 'Thoigian') document.querySelector('.filter option[value="Thoigian"]').setAttribute('selected', 'selected');
            else document.querySelector('.filter option[value="MaPhongHoc"]').setAttribute('selected', 'selected');
        }

        //=>thiết lập hđ biểu mẩu gửi đi
        function setFormAction() {
            const form = document.querySelector(".filter");
            const tableBody = document.querySelector("tbody");
            //=> Sử dụng phương thức document.querySelector để lấy tham chiếu đến phần tử có lớp CSS là .filter, đại diện cho biểu mẫu cần xử lý.
            //Lấy tham chiếu đến phần tử <tbody> trong bảng, giả sử đây là nơi dữ liệu bảng được hiển thị

            //phương thức addEventListener để gắn một sự kiện "submit" vào biểu mẫu.
            form.addEventListener("submit", function (event) {
                event.preventDefault();
                sortAction(form, tableBody);
            });
        }

        //=>hực hiện sắp xếp dữ liệu trong bảng dựa trên các thông tin nhập liệu từ biểu mẫu, bao gồm từ khóa tìm kiếm và cách sắp xếp được chọn.
        function sortAction() {
            //Lấy tham chiếu đến biểu mẫu có lớp CSS là .filter và tham chiếu đến phần tử <tbody> trong bảng
            const form = document.querySelector('.filter');
            const tableBody = document.querySelector('tbody');
            // ngăn chặn hành đọng mặt định biểu mẩu
            event.preventDefault();

            const searchTerm = form.searching.value.toLowerCase();
            const sortByClass = '.' + form.sort.value;

            const rows = Array.from(tableBody.getElementsByTagName('tr'));



            rows.sort((a, b) => {
                const aValue = a.querySelector(sortByClass).textContent.toLowerCase();
                const bValue = b.querySelector(sortByClass).textContent.toLowerCase();

                if (sortByClass === '.Thoigian') {
                    function parseTimeString(timeString) {
                        var trimmedTimeString = timeString.trim();
                        const [time, date] = trimmedTimeString.split(' ');
                        const [hours, minutes] = time.split(':');
                        const [day, month, year] = date.split('/');

                        // Month in JavaScript is 0-based, so we subtract 1
                        return new Date(year, month - 1, day, hours, minutes);
                    }

                    const aTime = parseTimeString(aValue);
                    const bTime = parseTimeString(bValue);

                    return bTime - aTime;
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
        }

        // Gọi hàm khi trang được load
        // MARK: DOMContentLoaded
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
        <h2 class="title"> Danh Sách Phòng Học</h2>
        <form class="filter" action="">
            <input type="search" name="searching" placeholder="Nhập nội dung tìm kiếm">
            <select name="sort">
                <option value="MaPhongHoc">Theo mã</option>
                <option value="SucChua">Theo Sức Chứa</option>
                <option value="TrangThai">Theo Trạng Thái</option>
                <option value="Thoigian">Theo Thời Gian</option>

            </select>
            <button type="submit">Lọc</button>
        </form>
        <hr>
    </nav>

    <main>

        <table>
            <thead>
                <tr id='row-click-id-${PhongHoc.idPhongHoc}' class="table-row">
                    <th class="Idphonghoc">Id Phòng Học </th>
                    <th class="MaPhongHoc">Mã Phòng Học</th>
                    <th class="SucChua">Sức Chứa</th>
                    <th class="Thoigian">Thời Gian</th>
                    <th class="TrangThai">Trạng Thái</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="PhongHoc" items="${DsPhongHoc}">
                    <tr id='row-click-id-${PhongHoc.idPhongHoc}' class="table-row">
                        <td class="IdPhongHoc">${PhongHoc.idPhongHoc}</td>
                        <td class="MaPhongHoc">${PhongHoc.maPhongHoc}</td>
                        <td class="SucChua">${PhongHoc.sucChua}</td>
                        <td class="Thoigian">
                            <fmt:formatDate var="_ActiveAt" value="${PhongHoc._ActiveAt}"
                                pattern="HH:mm dd/MM/yyyy" />
                            ${_ActiveAt}
                        </td>
                        <td class="TrangThai">
                            <c:choose>
                                <c:when test="${PhongHoc._Status == 'A'}">Sẵn sàng
                                </c:when>
                                <c:when test="${PhongHoc._Status == 'U'}">Chưa sẵn sàng
                                </c:when>
                                <c:when test="${PhongHoc._Status == 'M'}">Đang sửa chữa
                                </c:when>
                                <c:otherwise>Lỗi dữ liệu</c:otherwise>
                            </c:choose>
                        </td>
                        <c:if
                            test="${NextUsecaseTableRowChoose == null && NextUsecasePathTableRowChoose == null}">
                            <td id="table-option-id-${PhongHoc.idPhongHoc}" class="table-option">
                                <button id="button-option" type="button">
                                    <ion-icon name="ellipsis-vertical-outline"></ion-icon>
                                </button>
                                <div class="hover-dropdown-menu">
                                    <ul class="dropdown-menu">
                                        <li><a id="option-one-id-${PhongHoc.idPhongHoc}"
                                                href="#scriptSet024324">
                                                Xem chi tiết
                                            </a></li>
                                        <li><a id="option-two-id-${PhongHoc.idPhongHoc}"
                                                href="#scriptSet134656">
                                                Lịch mượn phòng giảng viên giảng dạy
                                            </a></li>
                                        <li><a id="option-three-id-${PhongHoc.idPhongHoc}"
                                                href="#scriptSet091020">
                                                Lịch mượn phòng giảng viên đã mượn
                                            </a></li>
                                    </ul>
                                </div>
                            </td>
                            <script id="scriptSet024324">
                                var tableLink = document.getElementById('option-one-id-${PhongHoc.idPhongHoc}');
                                tableLink.setAttribute('href', "../${NextUsecaseTableOption1}/${NextUsecasePathTableOption1}?MaGV=${PhongHoc.idPhongHoc}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
                            </script>
                            <script id="scriptSet134656">
                                var tableLink = document.getElementById('option-two-id-${PhongHoc.idPhongHoc}');
                                tableLink.setAttribute('href', "../${NextUsecaseTableOption2}/${NextUsecasePathTableOption2}?SearchInput=${PhongHoc.idPhongHoc}&SearchOption=GiangVien" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
                            </script>
                            <script id="scriptSet091020">
                                var tableLink = document.getElementById('option-three-id-${PhongHoc.idPhongHoc}');
                                tableLink.setAttribute('href', "../${NextUsecaseTableOption3}/${NextUsecasePathTableOption3}?Command=${NextUsecaseTableCommand3}&MaNguoiMuonPhongHoc=${PhongHoc.idPhongHoc}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
                            </script>
                        </c:if>
                    </tr>
                    <c:if
                        test="${NextUsecaseTableRowChoose != null && NextUsecasePathTableRowChoose != null}">
                        <script>
                            var rowLink = document.getElementById('row-click-id-${PhongHoc.idPhongHoc}');
                            rowLink.setAttribute('onclick', "location.href = '../${NextUsecaseTableRowChoose}/${NextUsecasePathTableRowChoose}?MaGV=${PhongHoc.idPhongHoc}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin + "'");
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
    <script type="module"
        src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>

</html>