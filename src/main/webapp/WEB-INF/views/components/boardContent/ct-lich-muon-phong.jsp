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
    <style>
        /* MARK: STYLE */
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

            button {
                background: transparent;
                font-weight: 500;
                color: var(--text-color);
                cursor: pointer;
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
                align-items: start;
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

                    input,
                    select {
                        flex-grow: 1;
                        text-align: end;
                        border-right: .2rem solid var(--main-box-color);
                        border-bottom: .3rem solid var(--main-box-color);
                        border-radius: 1rem;
                        padding: .5rem;
                        opacity: .7;
                        appearance: none;
                    }

                    input:disabled:not(.as-enable),
                    select:disabled:not(.as-enable) {
                        background: transparent;
                        border: none;
                        opacity: 1;
                    }
                }

                label.PhongHoc,
                label.MucDich,
                label.StartDatetime,
                label.EndDatetime {
                    span {
                        flex-grow: 100;
                    }
                }

                label.XacNhan {
                    max-width: 85%;
                    align-self: center;

                    input {
                        max-width: 7rem;
                        box-shadow: 0.1rem 0 0.7rem var(--main-box-color);
                        font-weight: 700;
                        text-align: center;
                        transition: 2s;
                    }

                    input:valid {
                        background-color: var(--text-color);
                    }
                }

                div {
                    width: 100%;
                    height: 100%;
                    display: flex;
                    justify-content: space-around;
                    align-items: center;
                    margin-top: 0.4rem;
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
    <script>
        // MARK: SCRIPT
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

        // MARK: setUsecases
        function setUsecases() {
            const TrangThaiMuonPhong = "${CTLichMuonPhong.muonPhongHoc._ReturnAt}" !== "" ? "Đã trả phòng" : 
                                        "${CTLichMuonPhong.muonPhongHoc}" !== "" ? "Đang mượn phòng" : 
                                        "${CTLichMuonPhong.endDatetime < CurrentDateTime}" === "true" ? "Quá hạn mượn phòng" : 
                                        "Chưa mượn phòng";
            const DoiTuongSuDung = UIDAdmin ? "Admin" : UIDManager ? "Manager" : UIDRegular ? "Regular" : "Unknown";
            const QuyenHan = UIDAdmin || UIDManager ? "QuanLyDuocXem" : "";
            
            if (UIDManager && UIDRegular) {
                window.location.href = "../Error?Message=Lỗi UIDManager và UIDRegular đồng thời đăng nhập";
            }
            // Trường hợp người sử dụng là quản lý MARK: Manager
            else if (UIDManager) {

                // Ẩn phần tử button hướng dẫn
                document.querySelector("button#openGuide").classList.add("hidden");

                // Chỉnh sửa phần tử nav theo Usecase
                document.querySelector(".board-bar").classList.add("menu-manager");

                // Trường hợp xem thông tin lịch mượn phòng học MARK: XemTTMPH
                if (Usecase === "CTMPH" && UsecasePath === "XemTTMPH") {
                    // Hiện các phần tử
                    if (TrangThaiMuonPhong === "Chưa mượn phòng") {
                        document.querySelectorAll(".ChuaMuonPhong").forEach((element) => {
                            element.classList.remove("hidden");
                        });
                    } else if (TrangThaiMuonPhong === "Đang mượn phòng") {
                        document.querySelectorAll(".DangMuonPhong").forEach((element) => {
                            element.classList.remove("hidden");
                        });
                    } else if (TrangThaiMuonPhong === "Quá hạn mượn phòng") {
                        document.querySelectorAll(".QuaHanMuonPhong").forEach((element) => {
                            element.classList.remove("hidden");
                        });
                    } else if (TrangThaiMuonPhong === "Đã trả phòng") {
                        document.querySelectorAll(".DaMuonPhong").forEach((element) => {
                            element.classList.remove("hidden");
                        });
                    }

                    // Chỉnh sửa nội dung
                    document.querySelector(".board-bar h2.title").textContent = "Mã lịch mượn phòng: ${CTLichMuonPhong.idLichMuonPhongAsString}";
                }
                // Trường hợp thêm thông tin lịch mượn phòng học MARK: ThemTTMPH
                else if (Usecase === "CTMPH" && UsecasePath === "ThemTTMPH") {
                    // Hiện các phần tử
                    document.querySelectorAll(".ThemThongTin").forEach((element) => {
                        element.classList.remove("hidden");
                    });

                    // Kích hoạt phần tử
                    document.querySelectorAll(".board-content .ThemThongTin:not(.KhongChinhSua) input, .board-content .ThemThongTin:not(.KhongChinhSua) select")
                    .forEach((element) => {
                        element.removeAttribute("disabled");
                    });

                    // Chỉnh sửa nội dung
                    document.querySelector(".board-bar h2.title").textContent = "Thêm thông tin lịch mượn phòng";
                    document.querySelector(".board-content .DsNguoiMuonPhong button").textContent = "Nhập danh sách người được mượn phòng";
                }
                // Trường hợp chỉnh sửa thông tin lịch mượn phòng học MARK: SuaTTMPH
                else if (Usecase === "CTMPH" && UsecasePath === "SuaTTMPH") {
                    // Hiện các phần tử
                    document.querySelectorAll(".ChinhSuaThongTin").forEach((element) => {
                        element.classList.remove("hidden");
                    });

                    // Kích hoạt phần tử
                    document.querySelectorAll(".ChinhSuaThongTin:not(.KhongChinhSua) input, .ChinhSuaThongTin:not(.KhongChinhSua) select")
                    .forEach((element) => {
                        element.removeAttribute("disabled");
                    });

                    // Chỉnh sửa nội dung
                    document.querySelector(".board-bar h2.title").textContent = "Chỉnh sửa lịch mượn phòng mã: ${CTLichMuonPhong.idLichMuonPhongAsString}";
                }
                // Trường hợp trả thiết bị đã mượn phòng học MARK: TraTTMPH
                else if (Usecase === "CTMPH" && UsecasePath === "TraTTMPH") {
                    // Hiện các phần tử
                    document.querySelectorAll(".DangMuonPhong").forEach((element) => {
                        element.classList.remove("hidden");
                    });
                    document.querySelectorAll(".TraPhongHoc").forEach((element) => {
                        element.classList.remove("hidden");
                    });

                    // Kích hoạt phần tử
                    document.querySelector(".board-content .ThoiGianTra input").classList.add("as-enable");

                    // Thiết lập hàm cho phần tử
                    var ThoiGianTra = document.querySelector(".board-content .ThoiGianTra input");
                    updateLocalTimeInput(ThoiGianTra);
                    setInterval(updateLocalTimeInput(ThoiGianTra), 60000);

                    // Chỉnh sửa nội dung
                    document.querySelector(".board-bar h2.title").textContent = "Trả thiết bị mượn phòng với mã: ${CTLichMuonPhong.idLichMuonPhongAsString}";
                } else {
                    //Xử lý lỗi ngoại lệ truy cập
                    window.location.href = "../Error?Message= Lỗi UID hoặc Usecase không tìm thấy";
                }
            }
            // MARK: Regular
            // Trường hợp người sử dụng là người mượn phòng
            else if (UIDRegular) {
                // Trường hợp lập thủ tục mượn phòng học
                if ((Usecase === "MPH") & (UsecasePath === "MPH")) {
                    // Ẩn các phần tử button trong nav
                    document.querySelector(".board-bar .update-object").classList.add("hidden");
                    document.querySelector(".board-bar .remove-object").classList.add("hidden");

                    // Ẩn các phần tử label trong form
                    document.querySelector(".board-content .TrangThai").classList.add("hidden");
                    //document.querySelector(".board-content .LyDo").classList.add("hidden");
                    document.querySelector(".board-content .QuanLyKhoiTao").classList.add("hidden");
                    document.querySelector(".board-content .DoiTuong").classList.add("hidden");
                    document.querySelector(".board-content .QuanLyDuyet").classList.add("hidden");
                    document.querySelector(".board-content .ThoiGianMuon").classList.add("hidden");
                    document.querySelector(".board-content .ThoiGianTra").classList.add("hidden");

                    // Ẩn các phần tử button trong form
                    document.querySelector(".board-content .DsNguoiMuonPhong").classList.add("hidden");
                    document.querySelector(".board-content .submit-object").classList.add("hidden");

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector(".board-bar").classList.add("menu-regular");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector(".board-bar h2.title").textContent = "Thủ tục mượn phòng học";

                    // Bỏ thuộc tính disabled của các phần tử
                    document.querySelector(".board-content .YeuCau input").removeAttribute("disabled");
                    document.querySelector(".board-content .XacNhan input").removeAttribute("disabled");
                }
                // Trường hợp lập thủ tục đổi phòng học
                else if ((Usecase === "DPH") & (UsecasePath === "DPH")) {
                    // Ẩn các phần tử button trong nav
                    document.querySelector(".board-bar .update-object").classList.add("hidden");
                    document.querySelector(".board-bar .remove-object").classList.add("hidden");

                    // Ẩn các phần tử label trong form
                    document.querySelector(".board-content .TrangThai").classList.add("hidden");
                    document.querySelector(".board-content .QuanLyKhoiTao").classList.add("hidden");
                    document.querySelector(".board-content .DoiTuong").classList.add("hidden");
                    document.querySelector(".board-content .QuanLyDuyet").classList.add("hidden");
                    document.querySelector(".board-content .ThoiGianMuon").classList.add("hidden");
                    document.querySelector(".board-content .ThoiGianTra").classList.add("hidden");

                    // Ẩn các phần tử button trong form
                    document.querySelector(".board-content .DsNguoiMuonPhong").classList.add("hidden");
                    document.querySelector(".board-content .submit-object").classList.add("hidden");

                    //Thiết lập thuộc tính của các phần tử
                    //document.querySelector(".board-content .LyDo input").setAttribute("required", "required");
                    //document.querySelector(".board-content .LyDo input").setAttribute("placeholder", "Lý do đổi phòng học");
                    //document.querySelector(".board-content .LyDo span").textContent = "Lý do đổi phòng học:";
                    document.querySelector(".board-content .StartDatetime input").classList.add("as-enable");

                    // Thiết lập hàm cho các phần tử
                    var StartDatetime = document.querySelector(".board-content .StartDatetime input");
                    updateLocalTimeInput(StartDatetime);
                    setInterval(updateLocalTimeInput(StartDatetime), 60000);

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector(".board-bar").classList.add("menu-regular");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector(".board-bar h2.title").textContent = "Thủ tục đổi buổi học";

                    // Bỏ thuộc tính disabled của các phần tử
                    document.querySelector(".board-content .PhongHoc select").removeAttribute("disabled");
                    document.querySelector(".board-content .EndDatetime input").removeAttribute("disabled");
                    //document.querySelector(".board-content .LyDo input").removeAttribute("disabled");
                    document.querySelector(".board-content .YeuCau input").removeAttribute("disabled");
                    document.querySelector(".board-content .XacNhan input").removeAttribute("disabled");
                } else {
                    //Xử lý lỗi ngoại lệ truy cập
                    window.location.href = "../Error?Message= Lỗi UID hoặc Usecase không tìm thấy";
                }
            } else {
                // Không phát hiện mã UID
                window.location.href = "../Login?Message=Không phát hiện mã UID";
            }
        }

        // MARK: setFormValues
        function setFormValues() {
            // Đặt giá trị cho các thẻ select trong form
            document.querySelectorAll(".board-content .MucDich select option").forEach((element) => {
                if ((element.value === "LT" || element.value === "TH" || element.value === "TN") && element.value !== "${CTLichMuonPhong.nhomToHocPhan.mucDich}${CTNhomToHocPhan.mucDich}") {
                    element.setAttribute("disabled", "disabled");
                }
            });
            if("${CTLichMuonPhong.mucDich}" === "C" || "${CTNhomToHocPhan}" !== "") {
                document.querySelector(".board-content .MucDich select").value = "${CTLichMuonPhong.nhomToHocPhan.mucDich}${CTNhomToHocPhan.mucDich}";
            }
            else {
                document.querySelector(".board-content .MucDich select").value = "${CTLichMuonPhong.mucDich}";
            }
            document.querySelector(".board-content .PhongHoc select").value = "${CTLichMuonPhong.phongHoc.idPhongHoc}";

            // Đặt giá trị cho các thẻ button trong form
            var tableLink1 = document.getElementById("option-one-id-${CTLichMuonPhong.idLichMuonPhongAsString}");
            tableLink1.setAttribute("formaction", "../${NextUsecaseSubmitOption1}/${NextUsecasePathSubmitOption1}?IdLichMuonPhong=${CTLichMuonPhong.idLichMuonPhongAsString}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
            var tableLink2 = document.getElementById("option-two-id-${CTLichMuonPhong.idLichMuonPhongAsString}");
            tableLink2.setAttribute("formaction", "../${NextUsecaseSubmitOption2}/${NextUsecasePathSubmitOption2}?IdLichMuonPhong=${CTLichMuonPhong.idLichMuonPhongAsString}&IdNhomToHocPhan=${CTNhomToHocPhan.idNhomToHocPhanAsString}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
            var buttonDsNguoiMuonPhong = document.querySelector(".board-content .DsNguoiMuonPhong button");
            buttonDsNguoiMuonPhong.setAttribute("formaction", "../${NextUsecaseNavigate1}/${NextUsecasePathNavigate1}?IdLichMuonPhong=${CTLichMuonPhong.idLichMuonPhongAsString}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);

        }

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

        // MARK: event functions
        function modifyToTPHUpdateData() {
            // Thay đổi path thứ hai
            paths[paths.length - 1] = "TraTTMPH";

            // Tạo URL mới từ các phần tử đã thay đổi
            let newURL = paths.join("/") + "?" + params.toString();

            window.location.href = newURL;
        }

        function modifyToUpdateData() {
            // Thay đổi path thứ hai
            paths[paths.length - 1] = "SuaTTMPH";

            // Tạo URL mới từ các phần tử đã thay đổi
            let newURL = paths.join("/") + "?" + params.toString();

            window.location.href = newURL;
        }

        function modifyToDeleteData() { }

        function validateForm() {
            // Lấy giá trị của select
            var selectValue = document.querySelector(".board-content .PhongHoc select").value;
            var startDatetime = document.querySelector(".board-content .StartDatetime input, .board-content .EndDatetime input").value;
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

        function updateLocalTimeInput(tag) {
            // Gán giá trị của input thành thời gian hiện tại dưới dạng ISO
            tag.value = toLocalISOString(new Date());
        }

        // MARK: DOMContentLoaded
        // Gọi hàm khi trang được load
        document.addEventListener("DOMContentLoaded", function () {
            setUsecases();
            setFormValues();
        });
    </script>
</head>

<body>
    <!-- MARK: boardbar -->
    <nav class="board-bar">
        <a class="go-back" href="#" onclick="history.back();">Quay lại</a>
        <h2 class="title">SomeThingError!</h2>
        <button class="update-object TraPhongHoc DangMuonPhong hidden" onclick="modifyToTPHUpdateData()">
            Xác nhận trả phòng
        </button>
        <button class="update-object ChuaMuonPhong hidden" onclick="modifyToUpdateData()">
            Chỉnh sửa
        </button>
        <button class="remove-object ChuaMuonPhong QuaHanMuonPhong DaMuonPhong hidden" onclick="">Xóa</button>
    </nav>
    <!-- MARK: boardContent -->
    <main>
        <form class="board-content" onsubmit="return validateForm()">
            <legend>Thông tin lich mượn phòng</legend>
            <label class="MonHoc">
                <span>Môn học: </span>
                <input type="text" disabled
                    value="${CTLichMuonPhong.nhomToHocPhan.nhomHocPhan.monHoc.maMonHoc}${CTNhomToHocPhan.nhomHocPhan.monHoc.maMonHoc} - ${CTLichMuonPhong.nhomToHocPhan.nhomHocPhan.monHoc.tenMonHoc}${CTNhomToHocPhan.nhomHocPhan.monHoc.tenMonHoc}" />
            </label>
            <label class="NhomTo">
                <span>Nhóm tổ: </span>
                <c:if test="${CTLichMuonPhong != null && CTLichMuonPhong.nhomToHocPhan.nhomToAsString == '00' || CTLichMuonPhong.nhomToHocPhan.nhomToAsString == '255'
                    || CTNhomToHocPhan != null && CTNhomToHocPhan.nhomToAsString =='00' || CTNhomToHocPhan.nhomToAsString == '255'}">
                    <input type="text" disabled
                        value="${CTLichMuonPhong.nhomToHocPhan.nhomHocPhan.nhomAsString}${CTNhomToHocPhan.nhomHocPhan.nhomAsString}">
                </c:if>
                <c:if test="${CTLichMuonPhong != null && CTLichMuonPhong.nhomToHocPhan.nhomToAsString != '00' && CTLichMuonPhong.nhomToHocPhan.nhomToAsString != '255'
                    || CTNhomToHocPhan != null && CTNhomToHocPhan.nhomToAsString !='00' && CTNhomToHocPhan.nhomToAsString != '255'}">
                    <input type="text" disabled
                        value="${CTLichMuonPhong.nhomToHocPhan.nhomHocPhan.nhomAsString}${CTNhomToHocPhan.nhomHocPhan.nhomAsString} - ${CTLichMuonPhong.nhomToHocPhan.nhomToAsString}${CTNhomToHocPhan.nhomToAsString}">
                </c:if>
            </label>
            <label class="MaLopSinhVien">
                <span>Lớp giảng dạy: </span>
                <input type="text" disabled
                    value="${CTLichMuonPhong.nhomToHocPhan.nhomHocPhan.hocKy_LopSinhVien.lopSinhVien.maLopSinhVien}${CTNhomToHocPhan.nhomHocPhan.hocKy_LopSinhVien.lopSinhVien.maLopSinhVien}" />
            </label>
            <label class="GiangVien">
                <span>Giảng viên: </span>
                <input type="text" disabled
                    value="${CTLichMuonPhong.nhomToHocPhan.giangVienGiangDay.nguoiDung.hoTen}${CTNhomToHocPhan.giangVienGiangDay.nguoiDung.hoTen}" />
            </label>
            <label class="PhongHoc ThemThongTin ChinhSuaThongTin">
                <span>Phòng học: </span>
                <select disabled required name="IdPhongHoc">
                    <option disabled selected hidden value="">Chọn phòng</option>
                    <c:choose>
                        <c:when test="${DsPhongHoc != null}">
                            <c:forEach var="PhongHoc" items="${DsPhongHoc}">
                                <option value="${PhongHoc.idPhongHoc}">
                                    ${PhongHoc.maPhongHoc}
                                </option>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <option disabled selected hidden value="${CTLichMuonPhong.phongHoc.idPhongHoc}">
                                ${CTLichMuonPhong.phongHoc.maPhongHoc}
                            </option>
                        </c:otherwise>
                    </c:choose>
                </select>
            </label>
            <label class="StartDatetime ThemThongTin ChinhSuaThongTin">
                <span>Thời gian bắt đầu: </span>
                <fmt:formatDate var="startDatetime" value="${CTLichMuonPhong.startDatetime}"
                    pattern="yyyy-MM-dd'T'HH:mm" />
                <input type="datetime-local" disabled name="StartDatetime" value="${startDatetime}" />
            </label>
            <label class="EndDatetime ThemThongTin ChinhSuaThongTin">
                <span>Thời gian kết thúc: </span>
                <fmt:formatDate var="endDatetime" value="${CTLichMuonPhong.endDatetime}"
                    pattern="yyyy-MM-dd'T'HH:mm" />
                <input type="datetime-local" disabled name="EndDatetime" value="${endDatetime}" />
            </label>
            <label class="MucDich ThemThongTin ChinhSuaThongTin">
                <span>Mục đích: </span>
                <select disabled required name="MucDich">
                    <option disabled selected hidden value="">Mục đích sử dụng</option>
                    <option value="LT">
                        Học lý thuyết
                    </option>
                    <option value="TH">
                        Học thực hành
                    </option>
                    <option value="TN">
                        Học thí nghiệm
                    </option>
                    <option value="E">
                        Kiểm tra
                    </option>
                    <option value="F">
                        Thi cuối kỳ
                    </option>
                    <option value="U">
                        Khác
                    </option>
                </select>
            </label>
            <label class="TrangThai QuanLyDuocXem hidden">
                <span>Trạng thái: </span>
                <input type="text" disabled value='${NextUsecaseSubmitOption1 == "CTMPH" && NextUsecasePathSubmitOption1 == "TraTTMPH" ? "Tiến hành xác nhận trả phòng"
                    :	CTLichMuonPhong._DeleteAt != null ? "Đã hủy" 
                    : CTLichMuonPhong.muonPhongHoc != null && CTLichMuonPhong.muonPhongHoc._ReturnAt != null ? "Đã mượn phòng"
                    : CTLichMuonPhong.muonPhongHoc != null && CTLichMuonPhong.muonPhongHoc._ReturnAt == null ? "Chưa xác nhận trả phòng"
                    : CTLichMuonPhong.endDatetime < CurrentDateTime ? "Quá hạn mượn phòng"
                    : "Chưa mượn phòng"}' />
            </label>
            <div class="DsNguoiMuonPhong ThemThongTin QuanLyDuocXem hidden">
                <button class="nav-object" type="submit" formaction="#scriptSet">
                    Danh sách người được mượn phòng
                </button>
            </div>
            <label class="QuanLyKhoiTao ThemThongTin ChinhSuaThongTin KhongChinhSua QuanLyDuocXem hidden">
                <span>Quản lý tạo lịch: </span>
                <input type="text" disabled
                    value="${CTLichMuonPhong.quanLyKhoiTao.maQuanLy}${QuanLyKhoiTao.maQuanLy} - ${CTLichMuonPhong.quanLyKhoiTao.nguoiDung.hoTen}${QuanLyKhoiTao.nguoiDung.hoTen}" />
            </label>
            <label class="NguoiMuonPhong DangMuonPhong DaMuonPhong hidden">
                <span>Người mượn phòng: </span>
                <c:choose>
                    <c:when test="${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.giangVien != null}">
                        <input type="text" disabled
                            value="${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.giangVien.maGiangVien} - ${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.giangVien.nguoiDung.hoTen}" />
                    </c:when>
                    <c:when test="${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.sinhVien != null}">
                        <input type="text" disabled
                            value="${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.sinhVien.maSinhVien} - ${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.sinhVien.nguoiDung.hoTen}" />
                    </c:when>
                    <c:when test="${GiangVien != null}">
                        <input type="text" disabled
                            value="${GiangVien.maGiangVien} - ${GiangVien.nguoiDung.hoTen}" />
                    </c:when>
                    <c:when test="${SinhVien != null}">
                        <input type="text" disabled
                            value="${SinhVien.maSinhVien} - ${SinhVien.nguoiDung.hoTen}" />
                    </c:when>
                    <c:otherwise>
                        <input type="text" disabled value="Lỗi dữ liệu!" />
                    </c:otherwise>
                </c:choose>
            </label>
            <label class="DoiTuong DangMuonPhong DaMuonPhong hidden">
                <span>Đối tượng mượn phòng: </span>
                <input type="text" disabled value="${CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.giangVien != null ? 'Giảng viên'
                    : CTLichMuonPhong.muonPhongHoc.nguoiMuonPhong.sinhVien != null ? 'Sinh viên'
                    : 'Lỗi dữ liệu!'}" />
            </label>
            <label class="QuanLyDuyet DangMuonPhong DaMuonPhong hidden">
                <span>Quản lý duyệt mượn phòng: </span>
                <input type="text" disabled
                    value="${CTLichMuonPhong.muonPhongHoc.quanLyDuyet.maQuanLy} - ${CTLichMuonPhong.muonPhongHoc.quanLyDuyet.nguoiDung.hoTen}" />
            </label>
            <label class="ThoiGianMuon DangMuonPhong DaMuonPhong hidden">
                <span>Thời điểm mượn phòng: </span>
                <fmt:formatDate var="_CreateAt" value="${CTLichMuonPhong.muonPhongHoc._TransferAt}"
                    pattern="yyyy-MM-dd'T'HH:mm" />
                <input type="datetime-local" disabled value="${_CreateAt}" />
            </label>
            <label class="ThoiGianTra TraPhongHoc DaMuonPhong hidden">
                <span>Thời điểm trả phòng: </span>
                <fmt:formatDate var="_ReturnAt" value="${CTLichMuonPhong.muonPhongHoc._ReturnAt}"
                    pattern="yyyy-MM-dd'T'HH:mm" />
                <input type="datetime-local" disabled value="${_ReturnAt}" />
            </label>
            <label class="YeuCau DangMuonPhong DaMuonPhong hidden">
                <span>Yêu cầu thiết bị: </span>
                <input type="text" disabled name="YeuCau" value="${CTLichMuonPhong.muonPhongHoc.yeuCau}" />
            </label>
            <label class="XacNhan ThemThongTin ChinhSuaThongTin TraPhongHoc hidden">
                <span>Mã xác nhận: </span>
                <input type="text" disabled required name="XacNhan" />
            </label>
            <div class="submit ThemThongTin ChinhSuaThongTin TraPhongHoc hidden">
                <button class="cancel-object ThemThongTin ChinhSuaThongTin TraPhongHoc hidden" type="button" onclick="history.back()">
                    Hủy bỏ
                </button>
                <button id="option-one-id-${CTLichMuonPhong.idLichMuonPhongAsString}" class="submit-object ChinhSuaThongTin TraPhongHoc hidden" type="submit"
                    onsubmit="history.back();history.back();" formaction="#scriptSet" formmethod="post">
                    Cập nhật
                </button>
                <button id="option-two-id-${CTLichMuonPhong.idLichMuonPhongAsString}" class="conform-object ThemThongTin hidden" type="submit"
                    onsubmit="history.back();history.back();" formaction="#scriptSet" formmethod="post">
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