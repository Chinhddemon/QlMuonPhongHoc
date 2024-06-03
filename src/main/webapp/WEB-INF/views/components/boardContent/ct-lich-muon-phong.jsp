<!-- mucDich
    Dữ liệu tiếp nhận:
        URL:
            Paths:
                Usecase         -   Usecase sử dụng
                UsecasePath     -   UsecasePath sử dụng
            Params:
                IdLichMuonPhong       -   Id Lịch mượn phòng học
                IdHocPhan    -   Id lớp học phần Section
        Controller:
            NextUsecaseTable        -   Usecase chuyển tiếp trong table
            NextUsecasePathTable    -   UsecasePath chuyển tiếp trong table
            CTLichMuonPhong			    -	Chi tiết lịch mượn phòng học
            CTNhomToHocPhan	    - 	Chi tiết giai đoạn lớp học phần
        SessionStorage:
            UIDManager
            UIDRegular
        Chuẩn View URL truy cập:   ../${Usecase}/${UsecasePath}?IdLichMuonPhong=${IdLichMuonPhong}&IdHocPhan=${IdHocPhan}
-->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Thông tin mượn phòng học</title>
    <!-- MARK: STYLE -->
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;400&family=Roboto:wght@300;400;500;700&display=swap");

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

        /* util */
        *.hidden {
            display: none;
        }

        :root {
            --bg-color: #f1dc9c;
            --second-bg-color: #fcf0cf30;
            --text-color: #555453;
            --text-box-color: #fcdec9;
            --main-color: #f3e0a7;
            --main-box-color: rgba(0, 0, 0, 0.7);
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
                border: 0.2rem solid var(--main-box-color);
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

                label#XacNhan {
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

                button {
                    cursor: pointer;
                    border: 0.2rem solid black;
                    border-radius: 0.5rem;
                    padding: 0.4rem;
                    transition: 0.1s;
                }

                button:hover {
                    background-color: var(--text-box-color);
                    border-radius: 1rem;
                }
            }
        }

        /* MARK: media */
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
                padding: 3rem 8rem;

                legend {
                    font-size: 2rem;
                }

                label {
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
                padding: 3rem 12rem;

                legend {
                    font-size: 2.5rem;
                }

                label {
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
        // MARK: utility functions
        function toLocalISOString(date) {
            // Chuyển đổi ngày giờ thành giờ địa phương
            const localDate = new Date(date - date.getTimezoneOffset() * 60000);

            // Loại bỏ giây và mili giây nếu cần
            localDate.setSeconds(0);
            localDate.setMilliseconds(0);

            // Chuyển đổi thành chuỗi ISO và loại bỏ ký tự 'Z' ở cuối
            return localDate.toISOString().slice(0, -1);
        }
        function updateLocalTimeInput(tag) {
            // Gán giá trị của input thành thời gian hiện tại dưới dạng ISO
            tag.value = toLocalISOString(new Date());
        }

        // MARK: event functions
        function validateFormSubmit() {
            // Lấy giá trị của select
            var selectValue = document.querySelector("#PhongHoc select").value;
            var startDatetime = document.querySelector("#StartDatetime input, #EndDatetime input").value;
            // Kiểm tra nếu giá trị select không phải là giá trị mặc định (chọn một option)
            if (selectValue === "") {
                alert("Vui lòng chọn phòng học.");
                return false;
            }
            if (startDatetime === "") {
                alert("Vui lòng nhập đầy đủ thông tin thời gian bắt đầu và kết thúc.");
                return false;
            }
            // Cho phép gửi form nếu đã chọn option
            return true;
        }
    </script>
    <script id="url-setup">
        // Lấy địa chỉ URL hiện tại
        var url = window.location.href;

        let urlParts = url.split("?");

        let paths = urlParts[0].split('/');
        let params = new URLSearchParams(urlParts[1]);

        // Lấy thông tin từ paths urls
        var Usecase = paths[paths.length - 2];
        var UsecasePath = paths[paths.length - 1];

        // Lấy giá trị của các tham số từ sessionScope
        var UIDManager = sessionStorage.getItem("UIDManager");
        var UIDRegular = sessionStorage.getItem("UIDRegular");
        var UIDAdmin = sessionStorage.getItem("UIDAdmin");

        // In ra console để kiểm tra
        //console.log(Usecase, UsecasePath, UIDManager,UIDRegular)
        //console.log(SearchInput, SearchOption)
    </script>
    <script id="main-setup">
        function setUsecases() {// MARK: setUsecases
            /* 
                Form hiển thị các thông tin cơ bản
                Sau đó dựa vào các thẻ đánh dấu và usecase để hiển thị và thiết lập thao tác
                Phân lớp các thẻ treo theo các class sau:
                    ChuaMuonPhong:      Xem 
                        -       Hiển thị thông tin cơ bản của lịch mượn phòng chưa mượn
                    DangMuonPhong:      Xem 
                        -       Hiển thị thông tin cơ bản của lịch mượn phòng đang mượn
                    QuaHanMuonPhong:    Xem 
                        -       Hiển thị thông tin cơ bản của lịch mượn phòng quá hạn
                    DaMuonPhong:        Xem 
                        -       Hiển thị thông tin cơ bản của lịch mượn phòng đã mượn
                    Them:               Thêm 
                        -       Hiển thị thông tin cơ bản và các thao tác thêm thông tin lịch mượn phòng
                    ChinhSua:           Sửa 
                        -       Hiển thị thông tin cơ bản và các thao tác chỉnh sửa thông tin lịch mượn phòng
                    TraPhongHoc:        Sửa 
                        -       Hiển thị thông tin cơ bản và các thao tác cập nhật thông tin trả phòng học
                    MuonPhongHoc:       Thêm 
                        -       Hiển thị thông tin cơ bản và các thao tác mượn phòng học
                    DoiPhongHoc:        Thêm-Sửa 
                        -       Hiển thị thông tin cơ bản và các thao tác đổi phòng học
            */
            // Tạo các biến cần thiết lập
            const TrangThaiMuonPhong = "${CTLichMuonPhong.muonPhongHoc._ReturnAt}" !== "" ? "Đã trả phòng" : "${CTLichMuonPhong.muonPhongHoc}" !== "" ? "Đang mượn phòng" : "${CTLichMuonPhong.endDatetime < CurrentDateTime}" === "true" ? "Quá hạn mượn phòng" : "Chưa mượn phòng";
            let removeMarkSelectors = null;
            let removeDisabledSelectors = null;
            let setAsEnableSelectors = null;
            let titleSelector = ".board-bar h2.title";
            let titleName = null;

            // Thiết lập các biến theo trường hợp sử dụng
            if (UIDManager && UIDRegular) {// Trường hợp xung đột đăng nhập
                window.location.href = "../Error?Message=Lỗi UIDManager và UIDRegular đồng thời đăng nhập";
            }
            else if (UIDManager) {// Trường hợp người sử dụng là quản lý MARK: Manager

                // Ẩn phần tử
                document.querySelector("button#openGuide").classList.add("mark-remove");

                // Chỉnh sửa phần tử
                document.querySelector(".board-bar").classList.add("menu-manager");

                if (Usecase === "CTMPH" && UsecasePath === "XemTTMPH") {// Trường hợp xem thông tin lịch mượn phòng học MARK: XemTTMPH
                    switch (TrangThaiMuonPhong) {
                        case "Chưa mượn phòng":     removeMarkSelectors = ".ChuaMuonPhong";    break;
                        case "Đang mượn phòng":     removeMarkSelectors = ".DangMuonPhong";    break;
                        case "Quá hạn mượn phòng":  removeMarkSelectors = ".QuaHanMuonPhong";  break;
                        case "Đã trả phòng":        removeMarkSelectors = ".DaMuonPhong";      break;
                    }
                    titleName = "Mã lịch mượn phòng: ${CTLichMuonPhong.idLichMuonPhongAsString}";
                }
                else if (Usecase === "CTMPH" && UsecasePath === "ThemTTMPH") {// Trường hợp thêm thông tin lịch mượn phòng học MARK: ThemTTMPH
                    removeMarkSelectors = ".Them";
                    removeDisabledSelectors = ".Them input, .Them select";
                    titleName = "Thêm thông tin lịch mượn phòng";
                }
                else if (Usecase === "CTMPH" && UsecasePath === "SuaTTMPH") {// Trường hợp chỉnh sửa thông tin lịch mượn phòng học MARK: SuaTTMPH
                    removeMarkSelectors = ".ChinhSua";
                    removeDisabledSelectors = ".ChinhSua input, .ChinhSua select";
                    titleName = "Chỉnh sửa thông tin lịch mượn phòng mã: ${CTLichMuonPhong.idLichMuonPhongAsString}";
                }
                else if (Usecase === "CTMPH" && UsecasePath === "TraTTMPH") {// Trường hợp trả thiết bị đã mượn phòng học MARK: TraTTMPH
                    removeMarkSelectors = ".DangMuonPhong, .TraPhongHoc, .ThietLapTraPhongHoc";
                    removeDisabledSelectors = ".TraPhongHoc input, .TraPhongHoc select";
                    setAsEnableSelectors = ".ThietLapTraPhongHoc input";
                    titleName = "Trả thiết bị mượn phòng với mã: ${CTLichMuonPhong.idLichMuonPhongAsString}";
                }
                else {//Xử lý lỗi ngoại lệ truy cập
                    window.location.href = "../Error?Message= Lỗi UID hoặc Usecase không tìm thấy";
                }
            } 
            else if (UIDRegular) {// Trường hợp người sử dụng là người mượn phòng MARK: Regular

                // Kiểm tra trạng thái mượn phòng
                if (TrangThaiMuonPhong !== "Chưa mượn phòng") {
                    window.location.href = "../Login?Message=Lỗi truyền tải dữ liệu.";
                }

                // Chỉnh sửa phần tử
                document.querySelector(".board-bar").classList.add("menu-regular");

                if ((Usecase === "MPH") & (UsecasePath === "MPH")) {// Trường hợp lập thủ tục mượn phòng học MARK: MPH
                    removeMarkSelectors = ".MuonPhongHoc, .ThietLapMuonPhongHoc";
                    removeDisabledSelectors = ".MuonPhongHoc input, .MuonPhongHoc select";
                    setAsEnableSelectors = ".ThietLapMuonPhongHoc input";
                    titleName = "Thủ tục mượn phòng học";
                }
                else if ((Usecase === "DPH") & (UsecasePath === "DPH")) {// Trường hợp lập thủ tục đổi phòng học MARK: DPH
                    removeMarkSelectors = ".DoiPhongHoc, .ThietLapDoiPhongHoc";
                    removeDisabledSelectors = ".DoiPhongHoc input, .DoiPhongHoc select";
                    setAsEnableSelectors = ".ThietLapDoiPhongHoc input";
                    titleName = "Thủ tục đổi phòng học";
                } 
                else {//Xử lý lỗi ngoại lệ truy cập
                    window.location.href = "../Error?Message= Lỗi UID hoặc Usecase không tìm thấy";
                }
            } 
            else {// Trường hợp không phát hiện thông tin đăng nhập
                window.location.href = "../Login?Message=Không phát hiện mã UID";
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
            if (document.querySelectorAll(setAsEnableSelectors)) {// Kích hoạt phần tử thiết lập tự động
                document.querySelectorAll(setAsEnableSelectors).forEach((element) => {
                    element.classList.add("as-enable");
                    updateLocalTimeInput(element);
                    setInterval(() => {
                        updateLocalTimeInput(element);
                    }, 60000);
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
            document.querySelectorAll("#MucDich select option").forEach((element) => {
                if ((element.value === "LT" || element.value === "TH" || element.value === "TN") && element.value !== "${CTLichMuonPhong.nhomToHocPhan.mucDich}${CTNhomToHocPhan.mucDich}") {
                    element.setAttribute("disabled", "disabled");
                }
            });
            if("${CTLichMuonPhong.mucDich}" === "C" || "${CTNhomToHocPhan}" !== "") {
                document.querySelector("#MucDich select").value = "${CTLichMuonPhong.nhomToHocPhan.mucDich}${CTNhomToHocPhan.mucDich}";
            }
            else {
                document.querySelector("#MucDich select").value = "${CTLichMuonPhong.mucDich}";
            }
            document.querySelector("#PhongHoc select").value = "${CTLichMuonPhong.phongHoc.idPhongHoc}";

        }

        document.addEventListener("DOMContentLoaded", function () {// Gọi hàm khi trang được load MARK: DOMContentLoaded
            setUsecases();
            setHref();
            setFormValues();
        });
    </script>
</head>

<body>
    <!-- MARK: boardbar -->
    <nav class="board-bar">
        <a class="go-back" href="#"
            onclick="history.back();">
            Quay lại
        </a>
        <h2 class="title">
            SomethingError!
        </h2>
        <a class="update-object TraPhongHoc DangMuonPhong mark-remove" href="../CTMPH/TraTTMPH?IdLichMuonPhong=${CTLichMuonPhong.idLichMuonPhong}">
            Xác nhận trả phòng
        </a>
        <a class="update-object ChuaMuonPhong mark-remove" href="../CTMPH/SuaTTMPH?IdLichMuonPhong=${CTLichMuonPhong.idLichMuonPhong}">
            Chỉnh sửa
        </a>
        <a class="remove-object ChuaMuonPhong QuaHanMuonPhong DaMuonPhong mark-remove" href="../CTMPH/XoaTTMPH?IdLichMuonPhong=${CTLichMuonPhong.idLichMuonPhong}">
            Xóa
        </a>
    </nav>
    </nav>
    <!-- MARK: boardContent -->
    <main>
        <form class="board-content" onsubmit="return validateFormSubmit()">
            <legend>Thông tin lich mượn phòng</legend>
            <label id="MonHoc">
                <span>Môn học: </span>
                <div class="as-disabled">
                    ${CTLichMuonPhong.nhomToHocPhan.nhomHocPhan.monHoc.maMonHoc}${CTNhomToHocPhan.nhomHocPhan.monHoc.maMonHoc} - ${CTLichMuonPhong.nhomToHocPhan.nhomHocPhan.monHoc.tenMonHoc}${CTNhomToHocPhan.nhomHocPhan.monHoc.tenMonHoc}
                </div>
            </label>
            <label id="NhomTo">
                <span>Nhóm tổ: </span>
                <div class="as-disabled">
                    <c:if test="${CTLichMuonPhong != null && CTLichMuonPhong.nhomToHocPhan.nhomToAsString == '00'
                    || CTNhomToHocPhan != null && CTNhomToHocPhan.nhomToAsString =='00'}">
                        ${CTLichMuonPhong.nhomToHocPhan.nhomHocPhan.nhomAsString}${CTNhomToHocPhan.nhomHocPhan.nhomAsString}
                    </c:if>
                    <c:if test="${CTLichMuonPhong != null && CTLichMuonPhong.nhomToHocPhan.nhomToAsString != '00'
                    || CTNhomToHocPhan != null && CTNhomToHocPhan.nhomToAsString !='00'}">
                        ${CTLichMuonPhong.nhomToHocPhan.nhomHocPhan.nhomAsString}${CTNhomToHocPhan.nhomHocPhan.nhomAsString} - ${CTLichMuonPhong.nhomToHocPhan.nhomToAsString}${CTNhomToHocPhan.nhomToAsString}
                    </c:if>
                </div>
            </label>
            <label id="LopSinhVien">
                <span>Lớp giảng dạy: </span>
                <div class="as-disabled">
                    ${CTLichMuonPhong.nhomToHocPhan.nhomHocPhan.hocKy_LopSinhVien.lopSinhVien.maLopSinhVien}${CTNhomToHocPhan.nhomHocPhan.hocKy_LopSinhVien.lopSinhVien.maLopSinhVien}
                </div>
            </label>
            <label id="GiangVien">
                <span>Giảng viên: </span>
                <div class="as-disabled">
                    ${CTLichMuonPhong.nhomToHocPhan.giangVienGiangDay.nguoiDung.hoTen}${CTNhomToHocPhan.giangVienGiangDay.nguoiDung.hoTen}
                </div>
            </label>
            <label id="PhongHoc" class="Them ChinhSua DoiPhongHoc">
                <span>Phòng học: </span>
                <select disabled required name="IdPhongHoc">
                    <option disabled selected hidden value="">Chọn phòng</option>
                    <c:if test="${CTLichMuonPhong.phongHoc != null}">
                        <option selected value="${CTLichMuonPhong.phongHoc.idPhongHoc}">
                            ${CTLichMuonPhong.phongHoc.maPhongHoc}
                        </option>
                    </c:if>
                    <c:forEach var="PhongHoc" items="${DsPhongHoc}">
                        <c:if test="${PhongHoc.idPhongHoc != CTLichMuonPhong.phongHoc.idPhongHoc}">
                            <option value="${PhongHoc.idPhongHoc}">
                                ${PhongHoc.maPhongHoc}
                            </option>
                        </c:if>
                    </c:forEach>
                </select>
            </label>
            <label id="StartDatetime" class="Them ChinhSua ThietLapDoiPhongHoc">
                <span>Thời gian bắt đầu: </span>
                <fmt:formatDate var="startDatetime" value="${CTLichMuonPhong.startDatetime}"
                    pattern="yyyy-MM-dd'T'HH:mm" />
                <input type="datetime-local" disabled name="StartDatetime" value="${startDatetime}" />
            </label>
            <label id="EndDatetime" class="Them ChinhSua DoiPhongHoc">
                <span>Thời gian kết thúc: </span>
                <fmt:formatDate var="endDatetime" value="${CTLichMuonPhong.endDatetime}"
                    pattern="yyyy-MM-dd'T'HH:mm" />
                <input type="datetime-local" disabled name="EndDatetime" value="${endDatetime}" />
            </label>
            <label id="MucDich" class="Them ChinhSua DoiPhongHoc">
                <span>Mục đích: </span>
                <select disabled required name="MucDich">
                    <option disabled selected hidden value="">Mục đích sử dụng</option>
                    <option value="LT">
                        Học lý thuyết
                    </option>
                    <option value="TH">
                        Học thực hành
                    </option>
                    <option value="E">
                        Kiểm tra
                    </option>
                    <option value="F">
                        Thi cuối kỳ
                    </option>
                    <option value="O">
                        Khác
                    </option>
                </select>
            </label>
            <label id="TrangThai" class="ChuaMuonPhong QuaHanMuonPhong DangMuonPhong DaMuonPhong mark-remove">
                <span>Trạng thái: </span>
                <div class="as-disabled">
                    <c:choose>
                        <c:when test="${NextUsecaseSubmitOption1 == 'CTMPH' && NextUsecasePathSubmitOption1 == 'TraTTMPH'}">
                            Tiến hành xác nhận trả phòng
                        </c:when>
                        <c:when test="${CTLichMuonPhong._DeleteAt != null}">
                            Đã hủy
                        </c:when>
                        <c:when test="${CTLichMuonPhong.muonPhongHoc != null && CTLichMuonPhong.muonPhongHoc._ReturnAt != null}">
                            Đã mượn phòng
                        </c:when>
                        <c:when test="${CTLichMuonPhong.muonPhongHoc != null && CTLichMuonPhong.muonPhongHoc._ReturnAt == null}">
                            Chưa xác nhận trả phòng
                        </c:when>
                        <c:when test="${CTLichMuonPhong.endDatetime < CurrentDateTime}">
                            Quá hạn mượn phòng
                        </c:when>
                        <c:otherwise>
                            Chưa mượn phòng
                        </c:otherwise>
                    </c:choose>
                </div>
            </label>
            <label id="QuanLyKhoiTao" class="Them ChinhSua ChuaMuonPhong QuaHanMuonPhong DangMuonPhong DaMuonPhong mark-remove">
                <span>Quản lý tạo lịch: </span>
                <div class="as-disabled">
                    ${CTLichMuonPhong.quanLyKhoiTao.maQuanLy}${QuanLyKhoiTao.maQuanLy} - ${CTLichMuonPhong.quanLyKhoiTao.nguoiDung.hoTen}${QuanLyKhoiTao.nguoiDung.hoTen}
                </div>
            </label>
            <div id="DsSinhVien" class="ChuaMuonPhong QuaHanMuonPhong DangMuonPhong DaMuonPhong mark-remove">
                <button class="nav-object" type="submit" formaction="../${NextUsecaseNavigate1}/${NextUsecasePathNavigate1}?IdNhomHocPhan=${CTLichMuonPhong.nhomToHocPhan.nhomHocPhan.idNhomHocPhan}">
                    Danh sách sinh viên học phần
                </button>
            </div>
            <hr class="DangMuonPhong DaMuonPhong MuonPhongHoc DoiPhongHoc mark-remove">
            <label id="NguoiMuonPhong" class="DangMuonPhong DaMuonPhong MuonPhongHoc DoiPhongHoc mark-remove">
                <span>Người mượn phòng: </span>
                <div class="as-disabled">
                    <c:choose>
                        <c:when test="${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.giangVien != null}">
                            ${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.giangVien.maGiangVien} - ${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.giangVien.nguoiDung.hoTen}
                        </c:when>
                        <c:when test="${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.sinhVien != null}">
                            ${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.sinhVien.maSinhVien} - ${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.sinhVien.nguoiDung.hoTen}
                        </c:when>
                        <c:when test="${NguoiMuonPhong != null}">
                            <c:if test="${NguoiMuonPhong.giangVien != null}">
                                ${NguoiMuonPhong.giangVien.maGiangVien} - ${NguoiMuonPhong.hoTen}
                            </c:if>
                            <c:if test="${NguoiMuonPhong.sinhVien != null}">
                                ${NguoiMuonPhong.sinhVien.maSinhVien} - ${NguoiMuonPhong.hoTen}
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            Lỗi dữ liệu!
                        </c:otherwise>
                    </c:choose>
                </div>
            </label>
            <label id="DoiTuong" class="DangMuonPhong DaMuonPhong MuonPhongHoc DoiPhongHoc mark-remove">
                <span>Đối tượng mượn phòng: </span>
                <div class="as-disabled">
                    <c:choose>
                        <c:when test="${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.giangVien.maChucDanh_NgheNghiep == 'V.07.01.01'
                                    || CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.giangVien.maChucDanh_NgheNghiep == 'V.07.01.02'
                                    || CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.giangVien.maChucDanh_NgheNghiep == 'V.07.01.03'
                                    || NguoiMuonPhong.giangVien.maChucDanh_NgheNghiep == 'V.07.01.01'
                                    || NguoiMuonPhong.giangVien.maChucDanh_NgheNghiep == 'V.07.01.02'
                                    || NguoiMuonPhong.giangVien.maChucDanh_NgheNghiep == 'V.07.01.03'}">
                            Giảng viên
                        </c:when>
                        <c:when test="${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.giangVien.maChucDanh_NgheNghiep == 'V.07.01.23'
                                    || NguoiMuonPhong.giangVien.maChucDanh_NgheNghiep == 'V.07.01.23'}">
                            Trợ giảng
                        </c:when>
                        <c:when test="${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.sinhVien != null
                                    || NguoiMuonPhong.sinhVien != null}">
                            Sinh viên
                        </c:when>
                        <c:otherwise>
                            Lỗi dữ liệu!
                        </c:otherwise>
                    </c:choose>
                </div>
            </label>
            <label id="QuanLyDuyet" class="DangMuonPhong DaMuonPhong MuonPhongHoc DoiPhongHoc mark-remove">
                <span>Quản lý duyệt mượn phòng: </span>
                <div class="as-disabled">
                    ${CTLichMuonPhong.muonPhongHoc.quanLyDuyet.maQuanLy}${QuanLyDuyet.maQuanLy} - ${CTLichMuonPhong.muonPhongHoc.quanLyDuyet.nguoiDung.hoTen}${QuanLyDuyet.nguoiDung.hoTen}
                </div>
            </label>
            <label id="ThoiGianMuon" class="DangMuonPhong DaMuonPhong ThietLapMuonPhongHoc mark-remove">
                <span>Thời điểm mượn phòng: </span>
                <fmt:formatDate var="_CreateAt" value="${CTLichMuonPhong.muonPhongHoc._TransferAt}"
                    pattern="yyyy-MM-dd'T'HH:mm" />
                <input type="datetime-local" disabled value="${_CreateAt}" />
            </label>
            <label id="ThoiGianTra" class="DaMuonPhong ThietLapTraPhongHoc mark-remove">
                <span>Thời điểm trả phòng: </span>
                <fmt:formatDate var="_ReturnAt" value="${CTLichMuonPhong.muonPhongHoc._ReturnAt}"
                    pattern="yyyy-MM-dd'T'HH:mm" />
                <input type="datetime-local" disabled value="${_ReturnAt}" />
            </label>
            <label id="YeuCau" class="DangMuonPhong DaMuonPhong MuonPhongHoc DoiPhongHoc mark-remove">
                <span>Yêu cầu thiết bị: </span>
                <input type="text" disabled name="YeuCau" value="${CTLichMuonPhong.muonPhongHoc.yeuCau}" />
            </label>
            <label id="XacNhan" class="Them ChinhSua TraPhongHoc MuonPhongHoc DoiPhongHoc mark-remove">
                <span>Mã xác nhận: </span>
                <input type="text" disabled required name="XacNhan" />
            </label>
            <div id="submit" class="Them ChinhSua TraPhongHoc MuonPhongHoc MuonPhongHoc DoiPhongHoc mark-remove">
                <button id="cancel-object" type="button" onclick="history.back()">
                    Hủy bỏ
                </button>
                <button class="ChinhSua TraPhongHoc mark-remove" type="submit"
                    onsubmit="history.back();history.back();" formaction="../${NextUsecaseSubmitOption1}/${NextUsecasePathSubmitOption1}?IdLichMuonPhong=${CTLichMuonPhong.idLichMuonPhongAsString}" formmethod="post">
                    Cập nhật
                </button>
                <button class="Them MuonPhongHoc DoiPhongHoc mark-remove" type="submit"
                    onsubmit="history.back();history.back();" formaction="../${NextUsecaseSubmitOption2}/${NextUsecasePathSubmitOption2}?IdLichMuonPhong=${CTLichMuonPhong.idLichMuonPhongAsString}&IdNhomToHocPhan=${CTNhomToHocPhan.idNhomToHocPhanAsString}" formmethod="post">
                    Xác nhận
                </button>
            </div>
            <c:if test="${CTLichMuonPhong == null && CTNhomToHocPhan == null}">
                <c:set var="messageStatus" value="Có lỗi xảy ra khi tải dữ liệu." />
            </c:if>
            <c:if test="${messageStatus != null}">
                <p>${messageStatus}</p>
            </c:if>
        </form>
    </main>
    <!-- MARK: Dynamic component -->
    <button id="openGuide" class="step2" onclick="window.dialog.showModal()">Hướng dẫn</button>
    <%@ include file="../../components/partials/guide-dialog.jsp" %>
</body>

</html>