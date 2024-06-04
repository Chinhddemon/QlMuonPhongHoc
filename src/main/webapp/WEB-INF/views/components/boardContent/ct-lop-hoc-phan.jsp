<!-- 
    Dữ liệu tiếp nhận:
        URL:
            Paths:
                Usecase         -   Usecase sử dụng
                UsecasePath     -   UsecasePath sử dụng
            Params:
                IdNhomHocPhan            -   Id lớp học phần Section
        Controller:
            NextUsecaseTable       -   Usecase chuyển tiếp trong table
            NextUsecasePathTable   -   UsecasePath chuyển tiếp trong table
            CTNhomHocPhan
        SessionStorage:
            UIDManager
            UIDRegular
    Chuẩn View URL truy cập:   ../${Usecase}/${UsecasePath}?IdNhomHocPhan=${IdNhomHocPhan}
-->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Thông tin mượn phòng học</title>
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
            padding: 1.5rem 4rem;
            gap: 4rem;
            overflow: hidden;
            z-index: 1000;

            a {
                background: transparent;
                font-weight: 500;
                color: var(--text-color);
                cursor: pointer;
            }

            h2 {
                flex-grow: 1;
                margin: 0 2rem;
            }

            form {
                background: transparent;
                font-weight: 500;
                color: var(--text-color);

                input {
                    max-width: 7rem;
                    box-shadow: .1rem 0 .7rem var(--main-box-color);
                    font-weight: 700;
                    text-align: center;
                    transition: 2s;
                }

                input:valid {
                    background-color: var(--text-color);
                }

                button {
                    background: transparent;
                    font-weight: 500;
                    color: var(--text-color);
                    cursor: pointer;
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
            flex-grow: 1;
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            padding-top: 5rem;

            form {
                width: 75rem;
                min-width: 50rem;
                background: var(--main-color);
                display: flex;
                flex-direction: column;
                justify-content: space-around;
                align-items: center;
                border: .2rem solid var(--main-box-color);
                border-radius: 2.5rem;
                margin: 1rem;
                box-shadow: 1px 1px 2px black;
                overflow: hidden;

                legend {
                    align-self: center;
                    padding-bottom: 2rem;
                }

                label {
                    width: 100%;
                    height: 100%;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    gap: 1rem;
                    padding-top: .6rem;

                    span {
                        flex-grow: 1;
                    }

                    div,
                    input,
                    select {
                        text-align: end;
                        justify-content: end;
                        border-right: .2rem solid var(--main-box-color);
                        border-bottom: .3rem solid var(--main-box-color);
                        border-radius: 1rem;
                        white-space: nowrap;
                        padding: .5rem;
                        opacity: .7;
                        appearance: none;
                    }

                    div.as-disabled,
                    input:disabled:not(.as-enable),
                    select:disabled:not(.as-enable) {
                        background: transparent;
                        border: none;
                        opacity: 1;
                    }
                }

                label.XacNhan {
                    max-width: 85%;
                    align-self: center;

                    input {
                        max-width: 7rem;
                        box-shadow: .1rem 0 .7rem var(--main-box-color);
                        font-weight: 700;
                        text-align: center;
                        transition: 2s;
                    }

                    input:valid {
                        background-color: var(--text-color);
                    }
                }

                label.NhomTo.MucDich {
                    input {
                        max-width: 4rem;
                        text-align: center;
                    }
                    input:disabled {
                        max-width: 3rem;
                    }
                }

                hr {
                    border: none;
                    border-top: .2rem solid var(--main-box-color);
                    margin: 0.5rem;
                    width: 85%;
                }

                div {
                    display: flex;
                    justify-content: space-around;
                    align-items: center;
                    margin-top: .4rem;
                    gap: 3rem;
                }

                /* util */
                div.innocent {
                    width: 100%;
                    height: 100%;
                    flex-direction: inherit;
                    justify-content: inherit;
                    align-items: inherit;
                    gap: 0;
                    padding: 0;
                    margin: 0;
                    overflow: inherit;
                }

                button {
                    cursor: pointer;
                    border: .2rem solid black;
                    border-radius: .5rem;
                    padding: .4rem;
                    transition: .1s;
                }

                button:hover {
                    background-color: var(--text-box-color);
                    border-radius: 1rem;
                }
            }
        }

        /* MARK: Media */
        @media only screen and (width <=768px) {

            /* Small devices (portrait tablets and large phones, 600px and up to 768px) */
            /* media boardBar design */
            nav {

                a,
                button {
                    font-size: 1rem;
                }

                h2 {
                    font-size: 1.3rem;
                }
            }

            /* media boardContent design */
            main form {
                padding: 6rem 8rem;

                legend {
                    font-size: 2rem;
                }

                label {
                    font-size: 1.3rem;

                    span {
                        font-size: 1.3rem;
                        font-weight: 600;
                    }

                    div,
                    input,
                    button,
                    select {
                        font-size: 1.3rem;
                    }
                }

                button {
                    font-size: 1rem;
                }
            }
        }

        @media only screen and (768px < width) {

            /* Medium devices (landscape tablets, 768px and up) */
            /* media boardBar design */
            nav {

                a,
                button {
                    font-size: 1.4rem;
                }

                h2 {
                    font-size: 1.8rem;
                }
            }

            /* media boardContent design */
            main form {
                padding: 6rem 12rem;

                legend {
                    font-size: 2.5rem;
                }

                label {
                    font-size: 1.5rem;

                    span {
                        font-size: 1.5rem;
                        font-weight: 600;
                    }

                    div,
                    input,
                    button,
                    select {
                        font-size: 1.5rem;
                    }
                }

                button {
                    font-size: 1.3rem;
                }
            }
        }
    </style>
    <!--  MARK: SCRIPT -->
    <script id="dynamic-tasks">
        var maxItems = 10; // Số lượng tối đa các thẻ con trong container
        var currentItems = parseInt("${fn:length(CTNhomHocPhan.nhomToHocPhans)}"); // Số lượng thẻ con ban đầu

        function removeNhomToHocPhan(event) { // Xóa thẻ innocent chứa nút xóa
            const innocentDiv = event.parentNode;
            innocentDiv.remove();

            currentItems--;

            // Khi xóa một thẻ con, hiển thị lại nút "Thêm thông tin" nếu chưa đạt số lượng tối đa
            if (currentItems < maxItems) {
                document.querySelector('.add-object').disabled = false;
            }
        }
        function addNhomToHocPhan() {// Thêm thẻ innocent mới
            if (currentItems < maxItems) {
                // Lấy HTML từ template
                const template = document.getElementById('NhomToHocPhan-template');
                //copy content of template
                const templateClone = template.cloneNode(true);
                templateClone.classList.remove('hidden');
                templateClone.id = ''; // Remove id to prevent duplicate id
                templateClone.querySelectorAll('select, input').forEach(select => {
                    select.removeAttribute('disabled');
                });
                template.parentNode.appendChild(templateClone);

                currentItems++;

                // Nếu đã đạt tối đa số lượng thẻ con cho phép, ẩn nút "Thêm thông tin"
                if (currentItems >= maxItems) {
                    document.querySelector('.add-object').disabled = true;
                }
            } else {
                alert('Đã đạt số lượng tối đa thẻ con cho phép!');
            }
        }
        function parseDate(dateString) {
            const [day, month, year] = dateString.split('/').map(Number);
            return new Date(year, month - 1, day);
        }
        function validateFormSubmit() {
            // Kiểm tra nếu currentItems bằng 0
            if (currentItems === 0) {
                // Hiển thị thông báo lỗi
                alert('Thông tin không hợp lệ: Chưa có thông tin cho nhóm học phần!');

                // Ngăn không cho form submit
                return false;
            }
            const startDateHocKy = parseDate(document.querySelector('#StartDateHocKy div').textContent);
            const endDateHocKy = parseDate(document.querySelector('#EndDateHocKy div').textContent);
            document.querySelectorAll('.StartDate input:not([disabled])').forEach(element => {
                const startDate = new Date(element.value);
                console.log(startDate < startDateHocKy)
                console.log(startDate, startDateHocKy)
                if (startDate < startDateHocKy) {
                    alert('Thông tin không hợp lệ: Ngày bắt đầu và kết thúc học phần phải nằm trong giai đoạn học kỳ!');
                    return false;
                }
            });
            document.querySelectorAll('.EndDate input:not([disabled])').forEach(element => {
                const endDate = new Date(element.value);
                console.log(endDate > endDateHocKy)
                console.log(endDate, endDateHocKy)
                if (endDate > endDateHocKy) {
                    alert('Thông tin không hợp lệ: Ngày bắt đầu và kết thúc học phần phải nằm trong giai đoạn học kỳ!');
                    return false;
                }
            });
            return true;
        }
        function validateFormDelete() {
            // Lấy giá trị của select
            const xacNhanForm = document.querySelector('.remove-object');
            const xacNhanInput = xacNhanForm.querySelector('input[type="text"]');
            if (xacNhanInput.disabled === true) {
                // remove disabled and hidden
                xacNhanInput.removeAttribute('disabled');
                xacNhanInput.classList.remove('hidden');
                xacNhanForm.querySelector('.remove-object span').classList.remove('hidden');
                return false;
            }

            return true;
        }
    </script>
    <script id="main">
        function setUsecases() {// MARK: setUsecases
            /* 
                Form hiển thị các thông tin cơ bản
                Sau đó dựa vào các thẻ đánh dấu và usecase để hiển thị và thiết lập thao tác
                Phân lớp các thẻ treo theo các class sau:
                    - Xem: 
                        Hiển thị thông tin cơ bản của học phần
                    - Them: 
                        Hiển thị thông tin cơ bản và các thao tác thêm thông tin học phần
                    - ChinhSua:
                        Hiển thị thông tin cơ bản và các thao tác chỉnh sửa thông tin học phần
            */
            // Tạo các biến cần thiết lập
            let removeMarkSelectors = null;
            let removeDisabledSelectors = null;
            let titleSelector = ".board-bar h2.title";
            let titleName = null;

            // Thiết lập các biến theo trường hợp sử dụng
            if (UIDManager && UIDRegular) {// Trường hợp xung đột đăng nhập
                window.location.href = "../Error?message=Lỗi UIDManager và UIDRegular đồng thời đăng nhập";
            }
            else if (UIDManager) {// Trường hợp người sử dụng là quản lý MARK: Manager
                
                // Chỉnh sửa phần tử
                document.querySelector('.board-bar').classList.add("menu-manager");

                if (Usecase === 'CTHocPhan' && UsecasePath === 'XemTTHocPhan') {// Trường hợp xem thông tin lớp học MARK: XemTTHocPhan
                    removeMarkSelectors = ".Xem";
                    titleName = "Mã học phần: ${CTNhomHocPhan.idNhomHocPhanAsString}";
                }
                else if (Usecase === 'CTHocPhan' && UsecasePath === 'ThemTTHocPhan') {// Trường hợp thêm thông tin lớp học MARK: ThemTTHocPhan
                    removeMarkSelectors = ".Them";
                    removeDisabledSelectors = ".Them input, .Them select";
                    titleName = "Thêm học phần mới";
                    document.querySelector("#DsSinhVien button").textContent = "Nhập danh sách sinh viên";
                }
                else if (Usecase === 'CTHocPhan' && UsecasePath === 'SuaTTHocPhan') {// Trường hợp chỉnh sửa thông tin lớp học MARK: SuaTTHocPhan
                    removeMarkSelectors = ".ChinhSua";
                    removeDisabledSelectors = ".ChinhSua input, .ChinhSua select";
                    titleName = "Chỉnh sửa học phần với mã: ${CTNhomHocPhan.idNhomHocPhanAsString}";
                    document.querySelector("#DsSinhVien button").textContent = "Chỉnh sửa danh sách sinh viên";
                }
                else {//Xử lý lỗi ngoại lệ truy cập
                    window.location.href = "../Error?message= Lỗi UID hoặc Usecase không tìm thấy";
                }
            }
            else {// Trường hợp không phát hiện thông tin đăng nhập
                window.location.href = "../Login?message=Không phát hiện mã UID";
            }

            // Thực thi lệnh
            document.querySelectorAll(removeMarkSelectors).forEach((element) => {// Loại bỏ các phần tử được đánh dấu
                element.classList.remove("mark-remove");
            });
            if (document.querySelectorAll(removeDisabledSelectors)) {// Kích hoạt phần tử
                document.querySelectorAll(removeDisabledSelectors).forEach((element) => {
                    element.removeAttribute("disabled");
                });
            }
            document.querySelector(titleSelector).textContent = titleName;// Chỉnh sửa nội dung
            document.querySelectorAll('.mark-remove').forEach(element => {// Xóa các phần được đánh dấu
                element.remove();
            });
        }
        function setHref() { // set uid for all a tag that has href, formaction attributes
            document.querySelectorAll('a[href]').forEach(function (element) {
                element.setAttribute('href', element.getAttribute('href') + '&UID=' + UIDRegular + UIDManager);
            });
            document.querySelectorAll('button[formaction]').forEach(function (element) {
                element.setAttribute('formaction', element.getAttribute('formaction') + '&UID=' + UIDRegular + UIDManager);
            });
        }
        function setFormValues() {// MARK: setFormValues
            // Đặt giá trị cho các thẻ select trong form
            document.querySelector('#MonHoc select').value = '${CTNhomHocPhan.monHoc.maMonHoc}';
            document.querySelector('#LopSinhVien select').value = '${CTNhomHocPhan.hocKy_LopSinhVien.lopSinhVien.maLopSinhVien}';
        }

        document.addEventListener("DOMContentLoaded", function () {// Gọi hàm khi trang được load MARK: DOMContentLoaded
            setUsecases();
            setHref();
            setFormValues();
        });
    </script>
</head>

<body>
    <!-- MARK: Boardbar -->
    <nav class="board-bar">
        <a class="go-back" href="#" 
            onclick="history.back();">
            Quay lại
        </a>
        <h2 class="title">
            SomethingError!
        </h2>
        <a class="update-object Xem mark-remove" href="../CTHocPhan/SuaTTHocPhan?IdNhomHocPhan=${CTNhomHocPhan.idNhomHocPhanAsString}">
            Chỉnh sửa
        </a>
        <form class="remove-object Xem mark-remove" 
            onsubmit="return validateFormDelete()">
            <input type="hidden" name="IdNhomHocPhan" value="${CTNhomHocPhan.idNhomHocPhanAsString}">
            <span class="hidden">Xác nhận xóa: </span>
            <input class="hidden" type="text" required disabled name="XacNhan" />
            <button type="submit" formaction="../CTHocPhan/XoaTTHocPhan?" formmethod="post">
                Xóa
            </button>
        </form>
    </nav>
    <!-- MARK: Boardcontent -->
    <main>
        <form class="board-content" 
            onsubmit="return validateFormSubmit()">
            <legend>Thông tin học phần</legend>
            <div class="innocent NhomHocPhan">
                <input type="hidden" required name="IdNhomHocPhan" value="${CTNhomHocPhan.idNhomHocPhanAsString}">
                <label id="MonHoc" class="Them ChinhSua">
                    <span>Môn học: </span>
                    <select disabled required name="MaMonHoc">
                        <option disabled selected hidden value="">
                            Chọn môn học
                        </option>
                        
                        <c:choose>
                            <c:when test="${DsMonHoc != null}">
                                <c:forEach var="MonHoc" items="${DsMonHoc}">
                                    <option value="${MonHoc.maMonHoc}">
                                        ${MonHoc.maMonHoc} - ${MonHoc.tenMonHoc}
                                    </option>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <option disabled selected hidden value="${CTNhomHocPhan.monHoc.maMonHoc}">
                                    ${CTNhomHocPhan.monHoc.maMonHoc} - ${CTNhomHocPhan.monHoc.tenMonHoc}
                                </option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </label>
                <label id="LopSinhVien" class="Them ChinhSua">
                    <span>Lớp giảng dạy: </span>
                    <select disabled required name="MaLopSinhVien">
                        <option disabled selected hidden value="">
                            Chọn lớp sinh viên
                        </option>
                        <c:choose>
                            <c:when test="${DsLopSinhVien != null}">
                                <c:forEach var="LopSinhVien" items="${DsLopSinhVien}">
                                    <option value="${LopSinhVien.maLopSinhVien}">
                                        ${LopSinhVien.maLopSinhVien}
                                    </option>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <option disabled selected hidden value="${CTNhomHocPhan.hocKy_LopSinhVien.lopSinhVien.maLopSinhVien}">
                                    ${CTNhomHocPhan.hocKy_LopSinhVien.lopSinhVien.maLopSinhVien}
                                </option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </label>
                <label id="Nhom" class="Them ChinhSua">
                    <span>Nhóm: </span>
                    <input type="text" disabled required
                        style="max-width: 40px; text-align: center;" pattern="[0-9]{2}" maxlength="2"
                        name="Nhom" value="${CTNhomHocPhan.nhomAsString}">
                </label>
                <label id="HocKy">
                    <span>Học kỳ: </span>
                    <div class="as-disabled">
                        <!-- Template -->
                        <c:choose>
                            <c:when test="${CTNhomHocPhan.hocKy_LopSinhVien.maHocKy == 'K2023-1'}">
                                Học kỳ 1 - năm học 2023
                            </c:when>
                            <c:when test="${CTNhomHocPhan.hocKy_LopSinhVien.maHocKy == 'K2023-2'}">
                                Học kỳ 2 - năm học 2023
                            </c:when>
                            <c:when test="${CTNhomHocPhan.hocKy_LopSinhVien.maHocKy == 'K2023-3'}">
                                Học kỳ hè - năm học 2023
                            </c:when>
                            <c:when test="${CTNhomHocPhan.hocKy_LopSinhVien.maHocKy == 'K2024-1'}">
                                Học kỳ 1 - năm học 2024
                            </c:when>
                            <c:when test="${CTNhomHocPhan.hocKy_LopSinhVien.maHocKy == 'K2024-2'}">
                                Học kỳ 2 - năm học 2024
                            </c:when>
                            <c:when test="${CTNhomHocPhan.hocKy_LopSinhVien.maHocKy == 'K2024-3'}">
                                Học kỳ hè - năm học 2024
                            </c:when>
                        </c:choose>
                    </div>
                </label>
                <label id="StartDateHocKy">
                    <span>Ngày bắt đầu học kỳ: </span>
                    <div class="as-disabled">
                        <fmt:formatDate var="startDate" 
                            value="${CTNhomHocPhan.hocKy_LopSinhVien.startDate}" 
                            pattern="dd/MM/yyyy" />
                            ${startDate}
                    </div>
                </label>
                <label id="EndDateHocKy">
                    <span>Ngày kết thúc học kỳ: </span>
                    <div class="as-disabled">
                        <fmt:formatDate var="endDate" 
                            value="${CTNhomHocPhan.hocKy_LopSinhVien.endDate}" 
                            pattern="dd/MM/yyyy" />
                            ${endDate}
                    </div>
                </label>
                <div id="DsSinhVien">
                    <button class="nav-object" type="submit" formaction="../${NextUsecaseNavigate1}/${NextUsecasePathNavigate1}?">
                        Danh sách sinh viên
                    </button>
                </div>
                <hr>
            </div>
            <div id="NhomToHocPhan-container" class="innocent">
                <div id="NhomToHocPhan-template" class="innocent NhomToHocPhan hidden">
                    <input disabled type="hidden" name="IdNhomToHocPhan" value="-1">
                    <label class="GiangVien">
                        <span>Giảng viên: </span>
                        <select disabled required name="MaGiangVien">
                            <option disabled selected hidden value="">Chọn giảng viên</option>
                            <c:forEach var="GiangVien" items="${DsGiangVien}">
                                <option value="${GiangVien.maGiangVien}">
                                    ${GiangVien.maGiangVien} - ${GiangVien.nguoiDung.hoTen}
                                </option>
                            </c:forEach>
                        </select>
                    </label>
                    <label class="NhomTo MucDich">
                        <span>Hình thức học: </span>
                        <select disabled required name="MucDich">
                            <option disabled selected hidden value="">
                                Chọn hình thức học
                            </option>
                            <option value="LT">
                                Lý thuyết
                            </option>
                            <option value="TH">
                                Thực hành
                            </option>
                            <option value="U">
                                Khác
                            </option>
                        </select>
                    </label>
                    <label class="StartDate">
                        <span>Ngày bắt đầu: </span>
                        <input type="date" disabled required name="StartDate">
                    </label>
                    <label class="EndDate">
                        <span>Ngày kết thúc:</span>
                        <input type="date" disabled required name="EndDate">
                    </label>
                    <button class="remove-object" type="button" onclick="removeNhomToHocPhan(this)">
                        Lược bỏ thông tin
                    </button>
                    <hr>
                </div>
                <c:forEach var="NhomToHocPhan" items="${CTNhomHocPhan.nhomToHocPhans}">
                    <c:if test="${NhomToHocPhan.nhomTo != -1}">
                        <div class="innocent NhomToHocPhan-${NhomToHocPhan.idNhomToHocPhanAsString}">
                            <input type="hidden" name="IdNhomToHocPhan" value="${NhomToHocPhan.idNhomToHocPhan}">
                            <label class="GiangVien Them ChinhSua">
                                <span>Giảng viên: </span>
                                <select disabled required name="MaGiangVien">
                                    <option disabled selected hidden value="">Chọn giảng viên</option>
                                    <c:if test="${NhomToHocPhan.giangVienGiangDay != null}">
                                        <option selected
                                            value="${NhomToHocPhan.giangVienGiangDay.maGiangVien}">
                                            ${NhomToHocPhan.giangVienGiangDay.maGiangVien} - ${NhomToHocPhan.giangVienGiangDay.nguoiDung.hoTen}
                                        </option>
                                    </c:if>
                                    <c:forEach var="GiangVien" items="${DsGiangVien}">
                                        <c:if test="${GiangVien.maGiangVien != NhomToHocPhan.giangVienGiangDay.maGiangVien}">
                                            <option value="${GiangVien.maGiangVien}">
                                                ${GiangVien.maGiangVien} - ${GiangVien.nguoiDung.hoTen}
                                            </option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </label>
                            <label class="NhomTo MucDich-${NhomToHocPhan.idNhomToHocPhanAsString} Them ChinhSua">
                                <span>Hình thức học: </span>
                                <select disabled required name="MucDich"
                                    value="${NhomToHocPhan.mucDich}">
                                    <option disabled selected hidden value="">
                                        Chọn hình thức học
                                    </option>
                                    <option value="LT">
                                        Lý thuyết
                                    </option>
                                    <option value="TH">
                                        <c:choose>
                                            <c:when test="${NhomToHocPhan.nhomTo != 0 && NhomToHocPhan.nhomTo != 255}">
                                                Thực hành Tổ-${NhomToHocPhan.nhomToAsString}
                                            </c:when>
                                            <c:otherwise>
                                                Thực hành
                                            </c:otherwise>
                                        </c:choose>
                                    </option>
                                    <option value="U">
                                        Khác
                                    </option>
                                </select>
                                <script>
                                    document.querySelector('.NhomTo.MucDich-${NhomToHocPhan.idNhomToHocPhanAsString} select').value = '${NhomToHocPhan.mucDich}';
                                </script>
                            </label>
                            <label class="StartDate Them ChinhSua">
                                <span>Ngày bắt đầu: </span>
                                <input type="date" disabled required name="StartDate"
                                    value="${NhomToHocPhan.startDate}">
                            </label>
                            <label class="EndDate Them ChinhSua">
                                <span>Ngày kết thúc:</span>
                                <input type="date" disabled required name="EndDate"
                                    value="${NhomToHocPhan.endDate}">
                            </label>
                            <button class="remove-object Them ChinhSua mark-remove" type="button" onclick="removeNhomToHocPhan(this)">
                                Lược bỏ thông tin
                            </button>
                            <hr>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
            <button class="add-object Them ChinhSua mark-remove" type="button" onclick="addNhomToHocPhan()">
                Thêm thông tin
            </button>
            <label class="QuanLyKhoiTao Them ChinhSua mark-remove">
                <span>Quản lý tạo lớp học: </span>
                <div class="as-disabled">
                    "${CTNhomHocPhan.quanLyKhoiTao.maQuanLy}${QuanLyKhoiTao.maQuanLy} - ${CTNhomHocPhan.quanLyKhoiTao.nguoiDung.hoTen}${QuanLyKhoiTao.nguoiDung.hoTen}"
                </div>
            </label>
            <label class="XacNhan Them ChinhSua mark-remove">
                <span>Mã xác nhận: </span>
                <input type="text" disabled required name="XacNhan" />
            </label>
            <div class="submit Them ChinhSua mark-remove">
                <input type="hidden" name="UID" value="${UIDRegular}${UIDManager}" />
                <button type="button" onclick="history.back()">
                    Hủy bỏ
                </button>
                <button class="submit-object ChinhSua mark-remove" type="submit"
                    onsubmit="history.back();history.back();" 
                    formaction="../${NextUsecaseSubmitOption1}/${NextUsecasePathSubmitOption1}?" 
                    formmethod="post">
                    Cập nhật
                </button>
                <button class="conform-object Them mark-remove" type="submit"
                    onsubmit="history.back();history.back();" 
                    formaction="../${NextUsecaseSubmitOption2}/${NextUsecasePathSubmitOption2}?" 
                    formmethod="post">
                    Xác nhận
                </button>
            </div>
            <c:if test="${messageStatus != null}">
                <p>${messageStatus}</p>
            </c:if>
        </form>
    </main>
</body>

</html>