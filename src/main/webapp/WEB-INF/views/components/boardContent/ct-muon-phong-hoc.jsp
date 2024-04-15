<!-- mucDich
    Dữ liệu tiếp nhận:
        URL:
            Paths:
                Usecase         -   Usecase sử dụng
                UsecasePath     -   UsecasePath sử dụng
            Params:
                IdLichMPH       -   Id Lịch mượn phòng học
                IdLH        	-   Id lớp học
        Controller:
            NextUsecaseTable        -   Usecase chuyển tiếp trong table
            NextUsecasePathTable    -   UsecasePath chuyển tiếp trong table
            CTLichMPH			    -	Chi tiết lịch mượn phòng học
            CTLopHocPhanSection	    - 	Chi tiết giai đoạn lớp học phần
        SessionStorage:
            UIDManager
            UIDRegular
        Chuẩn View URL truy cập:   ../${Usecase}/${UsecasePath}.htm?MaLichMPH=${MaLichMPH}&MaLopHoc=${MaLopHoc}
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
            scroll-behavior: smooth;
            font-family: "Poppins", sans-serif;
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
            background: var(--bg-color);
            display: flex;
            flex-shrink: 0;
            justify-content: space-between;
            align-items: center;
            box-shadow: 1px 1px 2px black;
            padding: 1.5rem 4rem;
            gap: 4rem;
            overflow: hidden;

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
                label.ThoiGian_BD,
                label.ThoiGian_KT {
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
        // Lấy phần pathname của URL và loại bỏ đuôi ".htm" (nếu có)
        let paths = urlParts[0].replace(/\.htm$/, "").split("/");
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
            if (UIDManager && UIDRegular) {
                window.location.href =
                    "../Error.htm?Message=Lỗi UIDManager và UIDRegular đồng thời đăng nhập";
            }
            // Trường hợp người sử dụng là quản lý MARK: Manager
            else if (UIDManager) {
                // Trường hợp xem thông tin lịch mượn phòng học MARK: XemTTMPH
                if (Usecase === "CTMPH" && UsecasePath === "XemTTMPH") {
                    // Ẩn các phần tử label trong form
                    if ("${CTLichMPH.lyDo}" === "") {
                        document.querySelector(".board-content .LyDo").classList.add("hidden");
                    }
                    if ("${CTLichMPH.muonPhongHoc}" === "") {
                        document.querySelector(".board-content .TrangThai").classList.add("hidden");
                        document.querySelector(".board-content .NgMPH").classList.add("hidden");
                        document.querySelector(".board-content .DoiTuong").classList.add("hidden");
                        document.querySelector(".board-content .QuanLyDuyet").classList.add("hidden");
                        document.querySelector(".board-content .ThoiGian_MPH").classList.add("hidden");
                        document.querySelector(".board-content .ThoiGian_TPH").classList.add("hidden");
                        document.querySelector(".board-content .YeuCau").classList.add("hidden");
                    }
                    else if ("${CTLichMPH.muonPhongHoc.thoiGian_TPH}" === "") {
                        document.querySelector(".board-content .ThoiGian_TPH input").classList.add("hidden");
                    }
                    document.querySelector(".board-content .XacNhan").classList.add("hidden");
                    document.querySelector(".board-content .submit").classList.add("hidden");

                    // Ẩn các phần tử button trong form
                    document.querySelector(".board-content .cancel-object").classList.add("hidden");
                    document.querySelector(".board-content .conform-object").classList.add("hidden");
                    document.querySelector(".board-content .submit-object").classList.add("hidden");

                    // Ẩn phần tử button hướng dẫn
                    document.querySelector("button#openGuide").classList.add("hidden");

                    // Hiện các phần tử button trong nav
                    if ("${CTLichMPH.muonPhongHoc.thoiGian_MPH}" === "") {
                        document.querySelector(".board-bar .update-object").classList.remove("hidden");
                        document.querySelector(".board-bar .remove-object").classList.remove("hidden");
                    }
                    if ("${CTLichMPH.muonPhongHoc.thoiGian_TPH}" !== "") {
                        document.querySelector(".board-bar .remove-object").classList.remove("hidden");
                    }
                    if ("${CTLichMPH.muonPhongHoc.thoiGian_MPH}" !== "" && "${CTLichMPH.muonPhongHoc.thoiGian_TPH}" === "") {
                        document.querySelector(".board-bar .TPH-udpate-object").classList.remove("hidden");
                    }

                    // Hiện các phần tử button trong form
                    document.querySelector(".board-content .DsNgMPH").classList.remove("hidden");

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector(".board-bar").classList.add("menu-manager");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector(".board-bar h2.title").textContent = "Mã mượn phòng học: ${CTLichMPH.idLMPH}";
                }
                // Trường hợp thêm thông tin lịch mượn phòng học MARK: ThemTTMPH
                else if (Usecase === "CTMPH" && UsecasePath === "ThemTTMPH") {
                    // Ẩn các phần tử button trong nav
                    document.querySelector(".board-bar .update-object").classList.add("hidden");
                    document.querySelector(".board-bar .remove-object").classList.add("hidden");

                    // Ẩn các phần tử label trong form
                    document.querySelector(".board-content .TrangThai").classList.add("hidden");
                    document.querySelector(".board-content .NgMPH").classList.add("hidden");
                    document.querySelector(".board-content .DoiTuong").classList.add("hidden");
                    document.querySelector(".board-content .QuanLyDuyet").classList.add("hidden");
                    document.querySelector(".board-content .ThoiGian_MPH").classList.add("hidden");
                    document.querySelector(".board-content .ThoiGian_TPH").classList.add("hidden");
                    document.querySelector(".board-content .YeuCau").classList.add("hidden");
                    document.querySelector(".board-content .LyDo").classList.add("hidden");

                    // Ẩn các phần tử button trong form
                    document.querySelector(".board-content .submit-object").classList.add("hidden");

                    // Ẩn phần tử button hướng dẫn
                    document.querySelector("button#openGuide").classList.add("hidden");

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector(".board-bar").classList.add("menu-manager");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector(".board-bar h2.title").textContent = "Thêm thông tin lịch mượn phòng";

                    // Chỉnh sửa nội dung của các thẻ trong form
                    document.querySelector(".board-content .DsNgMPH button").textContent = "Nhập danh sách người được mượn phòng";

                    // Bỏ thuộc tính disabled của các phần tử
                    document.querySelector(".board-content .PhongHoc select").removeAttribute("disabled");
                    document.querySelector(".board-content .ThoiGian_BD input").removeAttribute("disabled");
                    document.querySelector(".board-content .ThoiGian_KT input").removeAttribute("disabled");
                    document.querySelector(".board-content .XacNhan input").removeAttribute("disabled");
                }
                // Trường hợp chỉnh sửa thông tin lịch mượn phòng học MARK: SuaTTMPH
                else if (Usecase === "CTMPH" && UsecasePath === "SuaTTMPH") {
                    // Ẩn các phần tử button trong nav
                    document.querySelector(".board-bar .update-object").classList.add("hidden");
                    document.querySelector(".board-bar .remove-object").classList.add("hidden");

                    // Ẩn các phần tử label trong form
                    document.querySelector(".board-content .NgMPH").classList.add("hidden");
                    document.querySelector(".board-content .TrangThai").classList.add("hidden");
                    document.querySelector(".board-content .DoiTuong").classList.add("hidden");
                    document.querySelector(".board-content .QuanLyDuyet").classList.add("hidden");
                    document.querySelector(".board-content .ThoiGian_MPH").classList.add("hidden");
                    document.querySelector(".board-content .ThoiGian_TPH").classList.add("hidden");
                    document.querySelector(".board-content .YeuCau").classList.add("hidden");

                    // Ẩn các phần tử button trong form
                    document.querySelector(".board-content .DsNgMPH").classList.add("hidden");
                    document.querySelector(".board-content .conform-object").classList.add("hidden");

                    // Ẩn phần tử button hướng dẫn
                    document.querySelector("button#openGuide").classList.add("hidden");

                    //Thiết lập thuộc tính của các phần tử
                    document.querySelector(".board-content .LyDo input").setAttribute("required", "required");
                    document.querySelector(".board-content .LyDo input").setAttribute("placeholder", "Lý do thay đổi thông tin");

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector(".board-bar").classList.add("menu-manager");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector(".board-bar h2.title").textContent = "Chỉnh sửa lịch mượn phòng mã: ${CTLichMPH.idLMPH}";

                    // Bỏ thuộc tính disabled của các phần tử
                    document.querySelector(".board-content .PhongHoc select").removeAttribute("disabled");
                    document.querySelector(".board-content .ThoiGian_BD input").removeAttribute("disabled");
                    document.querySelector(".board-content .ThoiGian_KT input").removeAttribute("disabled");
                    document.querySelector(".board-content .LyDo input").setAttribute("required", "required");
                    document.querySelector(".board-content .LyDo input").removeAttribute("disabled");
                    document.querySelector(".board-content .XacNhan input").removeAttribute("disabled");

                    // Hiện các phần tử button trong form
                    document.querySelector(".board-content .submit").classList.remove("hidden");
                    document.querySelector(".board-content .cancel-object").classList.remove("hidden");
                    document.querySelector(".board-content .submit-object").classList.remove("hidden");
                }
                // Trường hợp trả thiết bị đã mượn phòng học MARK: TraTTMPH
                else if (Usecase === "CTMPH" && UsecasePath === "TraTTMPH") {
                    // Ẩn các phần tử button trong nav
                    document.querySelector(".board-bar .update-object").classList.add("hidden");
                    document.querySelector(".board-bar .remove-object").classList.add("hidden");

                    // Ẩn các phần tử label trong form
                    if ("${CTLichMPH.lyDo}" === "") {
                        document.querySelector(".board-content .LyDo").classList.add("hidden");
                    }

                    // Ẩn các phần tử button trong form
                    document.querySelector(".board-content .DsNgMPH").classList.add("hidden");
                    document.querySelector(".board-content .conform-object").classList.add("hidden");

                    // Ẩn phần tử button hướng dẫn
                    document.querySelector("button#openGuide").classList.add("hidden");

                    // Hiện các phần tử button trong form
                    document.querySelector(".board-content .submit").classList.remove("hidden");
                    document.querySelector(".board-content .cancel-object").classList.remove("hidden");
                    document.querySelector(".board-content .submit-object").classList.remove("hidden");

                    //Thiết lập thuộc tính của các phần tử
                    document.querySelector(".board-content .ThoiGian_TPH input").classList.add("as-enable");

                    // Thiết lập hàm cho các phần tử
                    var ThoiGian_TPH = document.querySelector(".board-content .ThoiGian_TPH input");
                    updateLocalTimeInput(ThoiGian_TPH);
                    setInterval(updateLocalTimeInput(ThoiGian_TPH), 60000);

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector(".board-bar").classList.add("menu-manager");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector(".board-bar h2.title").textContent = "Trả thiết bị mượn phòng với mã: ${CTLichMPH.idLMPH}";

                    // Bỏ thuộc tính disabled của các phần tử
                    document.querySelector(".board-content .XacNhan input").removeAttribute("disabled");
                } else {
                    //Xử lý lỗi ngoại lệ truy cập
                    window.location.href = "../Error.htm?Message= Lỗi UID hoặc Usecase không tìm thấy";
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
                    document.querySelector(".board-content .LyDo").classList.add("hidden");
                    document.querySelector(".board-content .QuanLyKhoiTao").classList.add("hidden");
                    document.querySelector(".board-content .DoiTuong").classList.add("hidden");
                    document.querySelector(".board-content .QuanLyDuyet").classList.add("hidden");
                    document.querySelector(".board-content .ThoiGian_MPH").classList.add("hidden");
                    document.querySelector(".board-content .ThoiGian_TPH").classList.add("hidden");

                    // Ẩn các phần tử button trong form
                    document.querySelector(".board-content .DsNgMPH").classList.add("hidden");
                    document.querySelector(".board-content .submit-object").classList.add("hidden");

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector(".board-bar").classList.add("menu-regular");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector(".board-bar h2.title").textContent = "Thủ tục mượn phòng với mã:  ${CTLichMPH.idLMPH}";

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
                    document.querySelector(".board-content .ThoiGian_MPH").classList.add("hidden");
                    document.querySelector(".board-content .ThoiGian_TPH").classList.add("hidden");

                    // Ẩn các phần tử button trong form
                    document.querySelector(".board-content .DsNgMPH").classList.add("hidden");
                    document.querySelector(".board-content .submit-object").classList.add("hidden");

                    //Thiết lập thuộc tính của các phần tử
                    document.querySelector(".board-content .LyDo input").setAttribute("required", "required");
                    document.querySelector(".board-content .LyDo input").setAttribute("placeholder", "Lý do đổi phòng học");

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector(".board-bar").classList.add("menu-regular");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector(".board-bar h2.title").textContent = "Thủ tục đổi buổi học";

                    // Bỏ thuộc tính disabled của các phần tử
                    document.querySelector(".board-content .PhongHoc select").removeAttribute("disabled");
                    document.querySelector(".board-content .ThoiGian_BD input").removeAttribute("disabled");
                    document.querySelector(".board-content .ThoiGian_KT input").removeAttribute("disabled");
                    document.querySelector(".board-content .LyDo input").removeAttribute("disabled");
                    document.querySelector(".board-content .YeuCau input").removeAttribute("disabled");
                    document.querySelector(".board-content .XacNhan input").removeAttribute("disabled");
                } else {
                    //Xử lý lỗi ngoại lệ truy cập
                    window.location.href = "../Error.htm?Message= Lỗi UID hoặc Usecase không tìm thấy";
                }
            } else {
                // Không phát hiện mã UID
                window.location.href = "../Login.htm?Message=Không phát hiện mã UID";
            }
        }

        // MARK: setFormValues
        function setFormValues() {
            // Đặt giá trị cho các thẻ select trong form
            document.querySelector(".board-content .MucDich select").value = "${CTLichMPH.lopHocPhanSection.mucDich}${CTLopHocPhanSection.mucDich}";
            document.querySelector(".board-content .PhongHoc select").value = "${CTLichMPH.phongHoc.idPH}";

            // Đặt giá trị cho các thẻ button trong form
            var tableLink1 = document.getElementById("option-one-id-${CTLichMPH.idLMPH}");
            tableLink1.setAttribute("formaction", "../${NextUsecaseSubmitOption1}/${NextUsecasePathSubmitOption1}.htm?IdLichMPH=${CTLichMPH.idLMPH}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
            var tableLink2 = document.getElementById("option-two-id-${CTLichMPH.idLMPH}");
            tableLink2.setAttribute("formaction", "../${NextUsecaseSubmitOption2}/${NextUsecasePathSubmitOption2}.htm?IdLHPSection=${CTLopHocPhanSection.idLHPSection}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);

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
            let newURL = paths.join("/") + ".htm" + "?" + params.toString();

            window.location.href = newURL;
        }

        function modifyToUpdateData() {
            // Thay đổi path thứ hai
            paths[paths.length - 1] = "SuaTTMPH";

            // Tạo URL mới từ các phần tử đã thay đổi
            let newURL = paths.join("/") + ".htm" + "?" + params.toString();

            window.location.href = newURL;
        }

        function modifyToDeleteData() { }

        function validateForm() {
            // Lấy giá trị của select
            var selectValue = document.querySelector(".board-content .MucDich select").value;

            // Kiểm tra nếu giá trị select không phải là giá trị mặc định (chọn một option)
            if (selectValue === "") {
                // Hiển thị thông báo lỗi
                alert("Vui lòng chọn mục đích mượn phòng.");
                // Ngăn chặn việc gửi form
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
        <button class="TPH-udpate-object hidden" onclick="modifyToTPHUpdateData()">
            Xác nhận trả phòng
        </button>
        <button class="update-object hidden" onclick="modifyToUpdateData()">
            Chỉnh sửa
        </button>
        <button class="remove-object hidden" onclick="">Xóa</button>
    </nav>
    <!-- MARK: boardContent -->
    <main>
        <form class="board-content" onsubmit="return validateForm()">
            <legend>Thông tin lich mượn phòng</legend>
            <label class="MonHoc">
                <span>Môn học: </span>
                <input type="text" disabled
                    value="${CTLichMPH.lopHocPhanSection.nhomHocPhan.monHoc.maMH}${CTLopHocPhanSection.nhomHocPhan.monHoc.maMH} - ${CTLichMPH.lopHocPhanSection.nhomHocPhan.monHoc.tenMH}${CTLopHocPhanSection.nhomHocPhan.monHoc.tenMH}" />
            </label>
            <label class="NhomTo">
                <span>Nhóm tổ: </span>
                <c:if
                    test="${CTLichMPH.lopHocPhanSection.nhomToAsString == '00' || CTLichMPH.lopHocPhanSection.nhomToAsString == '255'}">
                    <input type="text" disabled
                        value="${CTLichMPH.lopHocPhanSection.nhomHocPhan.nhomAsString}">
                </c:if>
                <c:if
                    test="${CTLichMPH.lopHocPhanSection.nhomToAsString != '00' && CTLichMPH.lopHocPhanSection.nhomToAsString != '255'}">
                    <input type="text" disabled
                        value="${CTLichMPH.lopHocPhanSection.nhomHocPhan.nhomAsString}-${CTLichMPH.lopHocPhanSection.nhomToAsString}">
                </c:if>
            </label>
            <label class="MaLopSV">
                <span>Lớp giảng dạy: </span>
                <input type="text" disabled
                    value="${CTLichMPH.lopHocPhanSection.nhomHocPhan.lopSV.maLopSV}${CTLopHocPhanSection.nhomHocPhan.lopSV.maLopSV}" />
            </label>
            <label class="GiangVien">
                <span>Giảng viên: </span>
                <input type="text" disabled
                    value="${CTLichMPH.lopHocPhanSection.giangVien.ttNgMPH.hoTen}${CTLopHocPhanSection.giangVien.ttNgMPH.hoTen}" />
            </label>
            <label class="PhongHoc">
                <span>Phòng học: </span>
                <select disabled required name="IdPH">
                    <option disabled selected hidden value="">Chọn phòng</option>
                    <c:choose>
                        <c:when test="${DsPhongHoc != null}">
                            <c:forEach var="PhongHoc" items="${DsPhongHoc}">
                                <option value="${PhongHoc.idPH}">
                                    ${PhongHoc.maPH}
                                </option>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <option disabled selected hidden value="${CTLichMPH.phongHoc.idPH}">
                                ${CTLichMPH.phongHoc.maPH}
                            </option>
                        </c:otherwise>
                    </c:choose>
                </select>
            </label>
            <label class="ThoiGian_BD">
                <span>Thời gian bắt đầu: </span>
                <fmt:formatDate var="thoiGian_BD" value="${CTLichMPH.thoiGian_BD}"
                    pattern="yyyy-MM-dd'T'HH:mm" />
                <input type="datetime-local" disabled name="ThoiGian_BD" value="${thoiGian_BD}" />
            </label>
            <label class="ThoiGian_KT">
                <span>Thời gian kết thúc: </span>
                <fmt:formatDate var="thoiGian_KT" value="${CTLichMPH.thoiGian_KT}"
                    pattern="yyyy-MM-dd'T'HH:mm" />
                <input type="datetime-local" disabled name="ThoiGian_KT" value="${thoiGian_KT}" />
            </label>
            <label class="MucDich">
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
                    <option value="U">
                        Khác
                    </option>
                </select>
            </label>
            <label class="LyDo">
                <span>Lý do chỉnh sửa: </span>
                <input type="text" disabled name="LyDo" value="${CTLichMPH.lyDo}" placeholder="" />
            </label>
            <label class="TrangThai">
                <span>Trạng thái: </span>
                <input type="text" disabled value='${NextUsecaseSubmitOption1 == "CTMPH" && NextUsecasePathSubmitOption1 == "TraTTMPH" ? "Tiến hành xác nhận trả phòng"
                    :	CTLichMPH._DeleteAt != null ? "Đã hủy" 
                    : CTLichMPH.muonPhongHoc != null && CTLichMPH.muonPhongHoc.thoiGian_TPH != null ? "Đã mượn phòng"
                    : CTLichMPH.muonPhongHoc != null && CTLichMPH.muonPhongHoc.thoiGian_TPH == null ? "Chưa xác nhận trả phòng"
                    : "Chưa mượn phòng"}' />
            </label>
            <div class="DsNgMPH">
                <button class="nav-object" type="submit" formaction="#">
                    Danh sách người được mượn phòng
                </button>
            </div>
            <label class="QuanLyKhoiTao">
                <span>Quản lý tạo lịch: </span>
                <input type="text" disabled
                    value="${CTLichMPH.quanLyKhoiTao.maQL}${QuanLyKhoiTao.maQL} - ${CTLichMPH.quanLyKhoiTao.hoTen}${QuanLyKhoiTao.hoTen}" />
            </label>
            <label class="NgMPH">
                <span>Người mượn phòng: </span>
                <input type="text" disabled
                    value="${CTLichMPH.muonPhongHoc.nguoiMuonPhong.maNgMPH}${NgMuonPhong.maNgMPH} - ${CTLichMPH.muonPhongHoc.nguoiMuonPhong.hoTen}${NgMuonPhong.hoTen}" />
            </label>
            <label class="DoiTuong">
                <span>Đối tượng mượn phòng: </span>
                <input type="text" disabled value="${CTLichMPH.muonPhongHoc.nguoiMuonPhong.doiTuongNgMPH.maDoiTuongNgMPH == 'GV' ? 'Giảng viên'
                    : CTLichMPH.muonPhongHoc.nguoiMuonPhong.doiTuongNgMPH.maDoiTuongNgMPH == 'SV' ? 'Sinh viên'
                    : 'Lỗi dữ liệu!'}" />
            </label>
            <label class="QuanLyDuyet">
                <span>Quản lý duyệt mượn phòng: </span>
                <input type="text" disabled
                    value="${CTLichMPH.muonPhongHoc.quanLyDuyet.maQL} - ${CTLichMPH.muonPhongHoc.quanLyDuyet.hoTen}" />
            </label>
            <label class="ThoiGian_MPH">
                <span>Thời điểm mượn phòng: </span>
                <fmt:formatDate var="thoiGian_MPH" value="${CTLichMPH.muonPhongHoc.thoiGian_MPH}"
                    pattern="yyyy-MM-dd'T'HH:mm" />
                <input type="datetime-local" disabled value="${thoiGian_MPH}" />
            </label>
            <label class="ThoiGian_TPH">
                <span>Thời điểm trả phòng: </span>
                <fmt:formatDate var="thoiGian_TPH" value="${CTLichMPH.muonPhongHoc.thoiGian_TPH}"
                    pattern="yyyy-MM-dd'T'HH:mm" />
                <input type="datetime-local" disabled value="${thoiGian_TPH}" />
            </label>
            <label class="YeuCau">
                <span>Yêu cầu thiết bị: </span>
                <input type="text" disabled name="YeuCau" value="${CTLichMPH.muonPhongHoc.yeuCau}" />
            </label>
            <label class="XacNhan">
                <span>Mã xác nhận: </span>
                <input type="text" disabled required name="XacNhan" />
            </label>
            <div class="submit">
                <button class="cancel-object" type="button" onclick="history.back()">
                    Hủy bỏ
                </button>
                <button id="option-one-id-${CTLichMPH.idLMPH}" class="submit-object" type="submit"
                    onclick="history.back();history.back();" formaction="#scriptSet" formmethod="post">
                    Cập nhật
                </button>
                <button id="option-two-id-${CTLichMPH.idLMPH}" class="conform-object" type="submit"
                    onclick="history.back();history.back();" formaction="#scriptSet" formmethod="post">
                    Xác nhận
                </button>
            </div>
            <c:if test="${errorMessage != null}">
                <p>${errorMessage}</p>
            </c:if>
        </form>
    </main>
    <!-- MARK: Dynamic component -->
    <button id="openGuide" class="step2" onclick="window.dialog.showModal()">Hướng dẫn</button>
    <%@ include file="../../components/partials/guide-dialog.jsp" %>
</body>

</html>