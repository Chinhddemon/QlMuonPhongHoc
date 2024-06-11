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
            <DsLichMuonPhong>:
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
    <title>Danh sách mượn phòng học</title>
    <!-- MARK: STYLE -->
    <%@ include file="../utils/style-default.jsp" %> <!-- Include the default style -->
    <%@ include file="../utils/url-setup.jsp" %> <!-- Include the url setup -->
    <style>
        /* MARK: boardBar design */
        nav {
            width: 100%;
            position: fixed;
            background: var(--bg-color);
            display: flex;
            flex-shrink: 0;
            justify-content: space-between;
            align-items: center;
            box-shadow: 1px 1px 2px black;
            padding: .5rem 2rem;
            gap: 2rem;
            overflow: hidden;
            z-index: 1000;

            a {
                font-weight: 500;
                color: var(--text-color);
            }

            a#add-object {
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
                    padding: .7rem;
                }

                input::placeholder {
                    color: black;
                }

                input:-webkit-autofill {
                    -webkit-background-clip: text;
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


                    td.LichMuonPhong,
                    td.LopSinhVien {
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
                    thead th {
                        border: .3rem solid var(--main-box-color);
                        border-radius: 1rem;
                        font-size: 1rem;
                    }

                    tbody {
                        td {
                            font-size: .8rem;
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
                padding: 6.5rem .5rem 1.5rem;

                table {
                    padding: .5rem 0;
                    border: .3rem solid var(--main-box-color);
                    border-radius: 1rem;

                    thead th {
                        border: .2rem solid var(--main-box-color);
                        border-radius: .4rem;
                        font-size: 1.8rem;
                    }

                    tbody td {
                        font-size: 1.4rem;
                    }
                }
            }
        }
    </style>
    <!-- Mark: SCRIPT -->
    <script>
        function setUsecases() {// MARK: setUsecases

            if (UIDManager && UIDRegular) {
                window.location.href = "../Error?Message=Lỗi UIDManager và UIDRegular đồng thời đăng nhập";
            }
            else if (UIDManager) {// Trường hợp người sử dụng là quản lý MARK: Manager

                // Chỉnh sửa phần tử nav theo Usecase
                document.querySelector('.board-bar').classList.add("menu-manager");

                // Ẩn phần tử button hướng dẫn
                document.querySelector('button#openGuide').classList.add("hidden");

                // Trường hợp xem danh sách lịch mượn phòng học theo bộ lọc
                if (Usecase === 'DsMPH' && UsecasePath === 'XemDsMPH') {

                }
                else {  //Xử lý lỗi ngoại lệ truy cập
                    window.location.href = "../Error?Message= Lỗi UID hoặc Usecase không tìm thấy";
                }
            }
            else if (UIDRegular) {// Trường hợp người sử dụng là người mượn phòng MARK: Regular

                // Chỉnh sửa phần tử nav theo Usecase
                document.querySelector('.board-bar').classList.add("menu-regular");

                // Ẩn các phần tử button trong nav
                document.querySelector('#add-object').classList.add("hidden");

                if (Usecase === 'MPH' && UsecasePath === 'ChonLMPH') {// Trường hợp lập thủ tục mượn phòng học MARK: ChonLMPH
                    document.querySelector('h2.title').textContent = "Danh sách buổi học tuần này";
                    document.querySelectorAll('.TrangThai').forEach(element => {
                        if (element.textContent === "Chưa mượn phòng") {
                            element.parentElement.classList.add("mark-remove");
                        }
                    });
                }
                else if (Usecase === 'MPH' && UsecasePath === 'LichSuMuonPhong') {// Trường hợp xem lịch sử mượn phòng học MARK: LichSuMuonPhong
                    document.querySelector('h2.title').textContent = "Lịch sử mượn phòng học";
                }
                else {  //Xử lý lỗi ngoại lệ truy cập
                    window.location.href = "../Error?Message= Lỗi UID hoặc Usecase không tìm thấy";
                }
            }
            else {  // Không phát hiện mã UID
                window.location.href = "../Login?Message=Không phát hiện mã UID";
            }

            document.querySelectorAll('.mark-remove').forEach(element => {// Xóa các phần được đánh dấu
                element.remove();
            });
        }
        function setHref() { // set uid for all a tag that has href, formaction, onclick attributes
            document.querySelectorAll('a[href]').forEach(function (element) {
                element.setAttribute('href', element.getAttribute('href') + '&UID=' + UIDRegular + UIDManager);
            });
            document.querySelectorAll('button[formaction]').forEach(function (element) {
                element.setAttribute('formaction', element.getAttribute('formaction') + '&UID=' + UIDRegular + UIDManager);
            });
            document.querySelectorAll('table[onclick]').forEach(function (element) {
                element.setAttribute('onclick', element.getAttribute('onclick').replace(/'$/, "&UID=" + UIDRegular + UIDManager + "'"));
            });
        }
        function setFormValues() {// MARK: setFormValues

            if (SearchInput) document.querySelector('.filter input').value = SearchInput;
            SearchOption = '.filter option[value="' + SearchOption + '"]';
            if(document.querySelector(SearchOption)) document.querySelector(SearchOption).setAttribute('selected', 'selected');
            else document.querySelector('.filter option[value="StartDatetime"]').setAttribute('selected', 'selected');
            if("${DsLichMuonPhong.size()}" === "0") document.getElementById('message').textContent = "Hiện không có lịch mượn phòng nào";
        }
        function setFormAction() {// MARK: setFormAction
            const form = document.querySelector('.filter');
            const tableBody = document.querySelector('tbody');

            form.addEventListener('submit', function (event) {
                sortAction(form, tableBody);
            });
        };    
        function sortAction() {// MARK: sortAction
            const form = document.querySelector('.filter');
            const tableBody = document.querySelector('tbody');

            event.preventDefault();

            const searchTerm = form.searching.value.toLowerCase();
            const sortByClass = '.' + form.sort.value;

            const rows = Array.from(tableBody.getElementsByTagName('tr'));

            rows.sort((a, b) => {
                const aValue = a.querySelector(sortByClass).textContent.toLowerCase();
                const bValue = b.querySelector(sortByClass).textContent.toLowerCase();

                if (sortByClass === '.StartDatetime') {
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

        document.addEventListener("DOMContentLoaded", function () {// Gọi hàm khi trang được load MARK: DOMContentLoaded
            setUsecases();
            setHref();
            setFormValues();
            setFormAction();
            sortAction();
        });
    </script>
</head>

<body>
    <!-- MARK:boardbar -->
    <nav class="board-bar">
        <a class="go-back" href="#" onclick="history.back();">
            Quay lại
        </a>
        <h2 class="title">
            Danh sách phiếu mượn phòng
        </h2>
        <form class="filter" action="">
            <input type="search" name="searching" placeholder="Nhập nội dung tìm kiếm">
            <select name="sort">
                <option value="StartDatetime">
                    Theo thời gian
                </option>
                <option value="GiangVien">
                    Theo giảng viên
                </option>
                <option value="LopSinhVien">
                    Theo lớp học
                </option>
                <option value="TrangThai">
                    Theo trạng thái
                </option>
            </select>
            <button type="submit">
                Lọc
            </button>
        </form>
        <hr>
        <a id="add-object" href="../DsHocPhan/ThemTTMPH?">
            Thêm phiếu mượn phòng
        </a>
        <c:if test="${NguoiDung.giangVien != null}">
            <c:choose>
                <c:when test="${NextUsecaseNavParams == 'XemTatCa'}">
                    <a href="../MPH/ChonLMPH?Command=XemTatCa">
                        Xem tất cả
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="../MPH/ChonLMPH?">
                        Xem theo giảng viên
                    </a>
                </c:otherwise>
            </c:choose>
        </c:if>
    </nav>
    <!-- MARK:boardcontent -->
    <main>
        <table>
            <thead>
                <tr>
                    <!-- <th class="LichMuonPhong">Mã lịch</th> -->
                    <th class="MonHoc">Môn học</th>
                    <th class="LopSinhVien">Lớp sinh viên</th>
                    <th class="NhomTo">Nhóm tổ</th>
                    <th class="GiangVien">Giảng viên</th>
                    <th class="PhongHoc">Phòng</th>
                    <th class="StartDatetime">Thời gian bắt đầu</th>
                    <th class="EndDatetime">Thời gian kết thúc</th>
                    <th class="MucDich">Mục đích</th>
                    <th class="TrangThai">Trạng thái</th>
                    <th class="table-option"></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="LichMuonPhong" items="${DsLichMuonPhong}">
                    <tr id='table-row-id-${LichMuonPhong.idLichMuonPhongAsString}' class="table-row">
                        <c:if test="${NextUsecaseTableRowChoose != null && NextUsecasePathTableRowChoose != null}">
                            <script>
                                // Chuyển hướng khi click vào hàng, nếu có Usecase và UsecasePath tương tác trực tiếp vào hàng
                                var rowLink = document.getElementById('table-row-id-${LichMuonPhong.idLichMuonPhongAsString}');
                                rowLink.setAttribute('onclick', "location.href = '../${NextUsecaseTableRowChoose}/${NextUsecasePathTableRowChoose}?IdLichMuonPhong=${LichMuonPhong.idLichMuonPhongAsString}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin + "'");
                                rowLink.style.cursor = "pointer";
                            </script>
                        </c:if>
                        <!-- <td class="LichMuonPhong">
                            ${LichMuonPhong.idLichMuonPhongAsString}
                        </td> -->
                        <td class="MonHoc">
                            ${LichMuonPhong.nhomToHocPhan.nhomHocPhan.monHoc.maMonHoc}
                            - ${LichMuonPhong.nhomToHocPhan.nhomHocPhan.monHoc.tenMonHoc}
                        </td>
                        <td class="LopSinhVien">
                            ${LichMuonPhong.nhomToHocPhan.nhomHocPhan.hocKy_LopSinhVien.lopSinhVien.maLopSinhVien}
                        </td>
                        <td class="NhomTo">
                            ${LichMuonPhong.nhomToHocPhan.nhomHocPhan.nhomAsString}
                            <c:if test="${LichMuonPhong.nhomToHocPhan.nhomTo != 0 && LichMuonPhong.nhomToHocPhan.nhomTo != 255}">
                                - ${LichMuonPhong.nhomToHocPhan.nhomToAsString}
                            </c:if>
                        </td>
                        <td class="GiangVien">
                            ${LichMuonPhong.nhomToHocPhan.giangVienGiangDay.nguoiDung.hoTen}
                        </td>
                        <td class="PhongHoc">
                            ${LichMuonPhong.phongHoc.maPhongHoc}
                        </td>
                        <td class="StartDatetime">
                            <fmt:formatDate var="startDatetime" value="${LichMuonPhong.startDatetime}"
                                pattern="HH:mm dd/MM/yyyy" />
                            ${startDatetime}
                        </td>
                        <td class="EndDatetime">
                            <fmt:formatDate var="endDatetime" value="${LichMuonPhong.endDatetime}"
                                pattern="HH:mm dd/MM/yyyy" />
                            ${endDatetime}
                        </td>
                        <td class="MucDich">
                            <c:choose>
                                <c:when test="${LichMuonPhong.mucDich == 'C'}">
                                    ${LichMuonPhong.nhomToHocPhan.mucDich == 'LT' ? "Học Lý thuyết"
                                    : LichMuonPhong.nhomToHocPhan.mucDich == 'TH' ? "Học Thực hành"
                                    : LichMuonPhong.nhomToHocPhan.mucDich == 'U' ? "Khác"
                                    : "Không xác định"}
                                </c:when>
                                <c:when test="${LichMuonPhong.mucDich == 'E'}">
                                    Kiểm tra
                                </c:when>
                                <c:when test="${LichMuonPhong.mucDich == 'F'}">
                                    Thi cuối kỳ
                                </c:when>
                                <c:when test="${LichMuonPhong.mucDich == 'O'}"> 
                                    Khác
                                </c:when>
                                <c:otherwise>
                                    Không xác định
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="TrangThai">
                            <c:choose>
                                <c:when test="${LichMuonPhong._DeleteAt != null}">
                                    Đã Xóa
                                </c:when>
                                <c:when
                                    test="${LichMuonPhong.muonPhongHoc != null && LichMuonPhong.muonPhongHoc._ReturnAt != null}">
                                    Đã trả phòng
                                </c:when>
                                <c:when
                                    test="${LichMuonPhong.muonPhongHoc != null && LichMuonPhong.muonPhongHoc._ReturnAt == null}">
                                    Chưa trả phòng
                                </c:when>
                                <c:when
                                    test="${LichMuonPhong.endDatetime < CurrentDateTime}">
                                    Quá hạn mượn phòng
                                </c:when>
                                <c:otherwise>
                                    Chưa mượn phòng
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <c:if
                            test="${NextUsecaseTableRowChoose == null && NextUsecasePathTableRowChoose == null}">
                            <!-- Nếu không có Usecase và UsecasePath thích hợp chuyển tiếp, hiển thị button option -->
                            <td id="table-option-id-${LichMuonPhong.idLichMuonPhongAsString}" class="table-option">
                                <button id="button-option" type="button">
                                    <ion-icon name="ellipsis-vertical-outline"></ion-icon>
                                </button>
                                <div class="hover-dropdown-menu">
                                    <ul class="dropdown-menu">
                                        <li><a id="option-one-id-${LichMuonPhong.idLichMuonPhongAsString}"
                                            href="../${NextUsecaseTableOption1}/${NextUsecasePathTableOption1}?IdLichMuonPhong=${LichMuonPhong.idLichMuonPhongAsString}">
                                            Xem chi tiết
                                        </a></li>
                                    </ul>
                                </div>
                            </td>
                        </c:if>
                    </tr>
                    
                </c:forEach>
            </tbody>
        </table>
        <p id="message"></p>
        <c:if test="${messageStatus != null}">
            <p>${messageStatus}</p>
        </c:if>
    </main>
    <!-- MARK: Dynamic component -->
    <button id="openGuide" class="step1" onclick="window.dialog.showModal()">Hướng dẫn</button>
    <%@ include file="../../components/partials/guide-dialog.jsp" %>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>

</html>