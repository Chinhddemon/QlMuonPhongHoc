<!-- 
    Dữ liệu tiếp nhận:
        URL:
            Paths:
                Usecase         -   Usecase sử dụng
                UsecasePath     -   UsecasePath sử dụng
            Params:
                IdHocPhanSection            -   Id lớp học phần Section
        Controller:
            NextUsecaseTable       -   Usecase chuyển tiếp trong table
            NextUsecasePathTable   -   UsecasePath chuyển tiếp trong table
            CTNhomHocPhan
        SessionStorage:
            UIDManager
            UIDRegular
    Chuẩn View URL truy cập:   ../${Usecase}/${UsecasePath}?IdHocPhanSection=${IdHocPhanSection}
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
    <c:forEach var="HocPhanRoot" items="${CTNhomHocPhan.nhomToHocPhans}">
        <c:if test="${HocPhanRoot.nhomToAsString == '255'}">
            <c:set var="CTHocPhanRoot" value="${HocPhanRoot}" />
        </c:if>
    </c:forEach>
    <c:if test="${IdSection != ''}">
        <c:forEach var="HocPhanSection" items="${CTNhomHocPhan.nhomToHocPhans}">
            <c:if test="${HocPhanSection.idNhomToHocPhanAsString == IdSection}">
                <c:set var="CTHocPhanSection" value="${HocPhanSection}" />
            </c:if>
        </c:forEach>
    </c:if>
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

                    input:disabled,
                    select:disabled {
                        background: transparent;
                        border: none;
                        opacity: 1;
                    }
                }

                label.PhongHoc {
                    span {
                        flex-grow: 100;
                    }
                }

                label.GiangVien {
                    border-top: solid .2rem var(--content-box-color);
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

                div {
                    width: 100%;
                    height: 100%;
                    display: flex;
                    justify-content: space-around;
                    align-items: center;
                    margin-top: .4rem;
                    gap: 3rem;
                }

                div.add-layout,
                div.remove-layout {
                    justify-content: center;
                    align-items: center;
                }

                /* util */
                div.innocent {
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
                padding: 6rem 12rem;

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

        let urlParts = url.split('?');

        let paths = urlParts[0].split('/');
        let params = new URLSearchParams(urlParts[1]);

        // Lấy thông tin từ paths urls
        var Usecase = paths[paths.length - 2];
        var UsecasePath = paths[paths.length - 1];

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
                window.location.href = "../Error?message=Lỗi UIDManager và UIDRegular đồng thời đăng nhập";
            }
            // Trường hợp người sử dụng là quản lý MARK: Manager
            else if (UIDManager) {

                // Trường hợp xem thông tin lớp học MARK: XemTTHocPhan
                if (Usecase === 'CTHocPhan' && UsecasePath === 'XemTTHocPhan') {

                    // Ẩn các phần tử label và div trong form
                    document.querySelector('.board-content div.add-layout').classList.add("hidden");
                    document.querySelector('.board-content div.remove-layout').classList.add("hidden");
                    if ('${CTHocPhanSection}' == '') {
                        document.querySelector('.board-content div.innocent.HocPhan-Section').classList.add("hidden");
                    }

                    document.querySelector('.board-content label.XacNhan').classList.add("hidden");
                    document.querySelector('.board-content div.submit').classList.add("hidden");


                    // Ẩn các phần tử button trong form
                    document.querySelector('.board-content .cancel-object').classList.add("hidden");
                    document.querySelector('.board-content .conform-object').classList.add("hidden");
                    document.querySelector('.board-content .submit-object').classList.add("hidden");

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Mã học phần: ${CTNhomHocPhan.idNhomHocPhanAsString}${IdSection}";

                    // Hiện các phần tử button trong nav
                    document.querySelector('.board-bar .update-object').classList.remove("hidden");
                    document.querySelector('.board-bar .remove-object').classList.remove("hidden");

                }
                // Trường hợp chỉnh sửa thông tin lớp học MARK: SuaTTHocPhan
                else if (Usecase === 'CTHocPhan' && UsecasePath === 'SuaTTHocPhan') {

                    // Ẩn các phần tử label và div trong form
                    if ('${CTHocPhanSection}' != '') {
                        document.querySelector('.board-content div.add-layout').classList.add("hidden");
                    } else {
                        document.querySelector('.board-content div.innocent.HocPhan-Section').classList.add("hidden");
                        document.querySelector('.board-content div.remove-layout').classList.add("hidden");
                    }

                    // Ẩn các phần tử button trong nav
                    document.querySelector('.board-bar .update-object').classList.add("hidden");
                    document.querySelector('.board-bar .remove-object').classList.add("hidden");

                    // Ẩn các phần tử button trong form
                    document.querySelector('.board-content .submit-object').classList.add("hidden");

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Chỉnh sửa học phần với mã: ${CTNhomHocPhan.idNhomHocPhanAsString}${IdSection}";

                    // Bỏ thuộc tính disabled của các phần tử
                    document.querySelector('.board-content .MonHoc select').removeAttribute('disabled');
                    document.querySelector('.board-content .NhomTo input.Nhom').removeAttribute('disabled');
                    document.querySelector('.board-content .NhomTo input.To').removeAttribute('disabled');
                    document.querySelector('.board-content .LopSinhVien select').removeAttribute('disabled');
                    document.querySelector('.board-content .GiangVien.HocPhan-Root select').removeAttribute('disabled');
                    document.querySelector('.board-content .MucDich.HocPhan-Root select').removeAttribute('disabled');
                    document.querySelector('.board-content .StartDate.HocPhan-Root input').removeAttribute('disabled');
                    document.querySelector('.board-content .EndDate.HocPhan-Root input').removeAttribute('disabled');
                    if ('${CTHocPhanSection}' != '') {
                        document.querySelector('.board-content .GiangVien.HocPhan-Section select').removeAttribute('disabled');
                        document.querySelector('.board-content .MucDich.HocPhan-Section select').removeAttribute('disabled');
                        document.querySelector('.board-content .StartDate.HocPhan-Section input').removeAttribute('disabled');
                        document.querySelector('.board-content .EndDate.HocPhan-Section input').removeAttribute('disabled');
                    }
                    document.querySelector('.board-content .XacNhan input').removeAttribute('disabled');

                }
                // Trường hợp thêm thông tin lớp học MARK: ThemTTHocPhan
                else if (Usecase === 'CTHocPhan' && UsecasePath === 'ThemTTHocPhan') {

                    // Ẩn các phần tử label và div trong form
                    document.querySelector('.board-content div.innocent.HocPhan-Section').classList.add("hidden");
                    document.querySelector('.board-content div.remove-layout').classList.add("hidden");

                    // Ẩn các phần tử button trong nav
                    document.querySelector('.board-bar button.update-object').classList.add("hidden");
                    document.querySelector('.board-bar button.remove-object').classList.add("hidden");

                    // Ẩn các phần tử button trong form
                    document.querySelector('.board-content .submit-object').classList.add("hidden");

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Chỉnh sửa học phần với mã: ${CTNhomHocPhan.idNhomHocPhanAsString}${IdSection}";

                    // Bỏ thuộc tính disabled của các phần tử
                    document.querySelector('.board-content .MonHoc select').removeAttribute('disabled');
                    document.querySelector('.board-content .NhomTo input.Nhom').removeAttribute('disabled');
                    document.querySelector('.board-content .NhomTo input.To').removeAttribute('disabled');
                    document.querySelector('.board-content .LopSinhVien select').removeAttribute('disabled');
                    document.querySelector('.board-content .GiangVien.HocPhan-Root select').removeAttribute('disabled');
                    document.querySelector('.board-content .MucDich.HocPhan-Root select').removeAttribute('disabled');
                    document.querySelector('.board-content .StartDate.HocPhan-Root input').removeAttribute('disabled');
                    document.querySelector('.board-content .EndDate.HocPhan-Root input').removeAttribute('disabled');
                    document.querySelector('.board-content .XacNhan input').removeAttribute('disabled');

                }
                else {  //Xử lý lỗi ngoại lệ truy cập
                    window.location.href = "../Error?message= Lỗi UID hoặc Usecase không tìm thấy";
                }

            }
            else {  // Không phát hiện mã UID
                window.location.href = "../Login?message=Không phát hiện mã UID";
            }
        }
        // MARK: setFormValues
        function setFormValues() {

            // Đặt giá trị cho các thẻ select trong form
            document.querySelector('.board-content .MonHoc select').value = '${CTNhomHocPhan.monHoc.maMonHoc}';
            document.querySelector('.board-content .LopSinhVien select').value = '${CTNhomHocPhan.hocKy_LopSinhVien.lopSinhVien.maLopSinhVien}';
            document.querySelector('.board-content .GiangVien.HocPhan-Root select').value = '${CTHocPhanRoot.giangVienGiangDay.maGiangVien}';
            document.querySelector('.board-content .MucDich.HocPhan-Root select').value = '${CTHocPhanRoot.mucDich}';
            if ('${CTHocPhanSection}' !== '') {
                document.querySelector('.board-content .GiangVien.HocPhan-Section select').value = '${CTHocPhanSection.giangVienGiangDay.maGiangVien}';
                document.querySelector('.board-content .MucDich.HocPhan-Section select').value = '${CTHocPhanSection.mucDich}';
            }

            // Đặt giá trị cho các thẻ button trong form
            var tableLink1 = document.getElementById("option-one-id-${CTNhomHocPhan.idNhomHocPhanAsString}");
            tableLink1.setAttribute("formaction", "../${NextUsecaseSubmitOption1}/${NextUsecasePathSubmitOption1}?IdHocPhan=${CTNhomHocPhan.idNhomHocPhanAsString}${IdSection}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
            var tableLink2 = document.getElementById("option-two-id-${CTNhomHocPhan.idNhomHocPhanAsString}");
            tableLink2.setAttribute("formaction", "../${NextUsecaseSubmitOption2}/${NextUsecasePathSubmitOption2}?IdHocPhan=${CTNhomHocPhan.idNhomHocPhanAsString}${IdSection}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);
            var buttonDsNguoiMuonPhong = document.querySelector(".board-content .DsNguoiMuonPhong button");
            buttonDsNguoiMuonPhong.setAttribute("formaction", "../${NextUsecaseNavigate1}/${NextUsecasePathNavigate1}?IdLichMuonPhong=${CTLichMuonPhong.idLichMuonPhongAsString}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin);

        }

        // MARK: event functions
        function modifyToUpdateData() {

            // Thay đổi path thứ hai thành 'DSMPH'
            paths[paths.length - 1] = 'SuaTTHocPhan';

            // Tạo URL mới từ các phần tử đã thay đổi
            let newURL = paths.join('/') + '?' + params.toString();

            window.location.href = newURL;
        }
        function modifyToDeleteData() {

        }
        function addHocPhanSection() {
            document.querySelector('.board-content .GiangVien.HocPhan-Section select').removeAttribute('disabled');
            document.querySelector('.board-content .MucDich.HocPhan-Section select').removeAttribute('disabled');
            document.querySelector('.board-content .StartDate.HocPhan-Section input').removeAttribute('disabled');
            document.querySelector('.board-content .EndDate.HocPhan-Section input').removeAttribute('disabled');
            document.querySelector('.innocent').classList.remove("hidden");
            document.querySelector('.add-layout').classList.add("hidden");
            document.querySelector('.remove-layout').classList.remove("hidden");
        }
        function removeHocPhanSection() {
            document.querySelector('.board-content .GiangVien.HocPhan-Section select').setAttribute('disabled', 'disabled');
            document.querySelector('.board-content .MucDich.HocPhan-Section select').setAttribute('disabled', 'disabled');
            document.querySelector('.board-content .StartDate.HocPhan-Section input').setAttribute('disabled', 'disabled');
            document.querySelector('.board-content .EndDate.HocPhan-Section input').setAttribute('disabled', 'disabled');
            document.querySelector('.innocent').classList.add("hidden");
            document.querySelector('.add-layout').classList.remove("hidden");
            document.querySelector('.remove-layout').classList.add("hidden");
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
    <!-- MARK: Boardbar -->
    <nav class="board-bar">
        <a class="go-back" href="#" onclick="history.back();">Quay lại</a>
        <h2 class="title">SomeThingError!</h2>
        <button class="update-object hidden" onclick="modifyToUpdateData()">Chỉnh sửa</button>
        <button class="remove-object hidden" onclick="">Xóa</button>
    </nav>
    <!-- MARK: Boardcontent -->
    <main>
        <form class="board-content">
            <legend>Thông tin lớp học</legend>
            <label class="MonHoc">
                <span>Môn học: </span>
                <select disabled required name="MaMH">
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
            <label class="NhomTo">
                <span>Nhóm tổ: </span>
                <c:if test="${NextUsecaseSubmitOption1 == null && NextUsecasePathSubmitOption1 == null 
                        && NextUsecaseSubmitOption2 == null && NextUsecasePathSubmitOption2 == null}">
                    <c:if
                        test="${CTNhomHocPhan != null && (CTHocPhanSection == null || CTHocPhanSection.nhomToAsString == '00')}">
                        <input type="text" disabled value="${CTNhomHocPhan.nhomAsString}">
                    </c:if>
                    <c:if
                        test="${CTHocPhanSection != null && CTHocPhanSection.nhomToAsString != '00' && CTHocPhanSection.nhomToAsString != '255'}">
                        <input type="text" disabled
                            value="${CTNhomHocPhan.nhomAsString}-${CTHocPhanSection.nhomToAsString}">
                    </c:if>
                </c:if>
                <c:if test="${NextUsecaseSubmitOption1 != null && NextUsecasePathSubmitOption1 != null 
                    || NextUsecaseSubmitOption2 != null && NextUsecasePathSubmitOption2 != null}">
                    <input class="Nhom" type="text" disabled required
                        style="max-width: 40px; text-align: center;" pattern="[0-9]{2}" maxlength="2"
                        name="Nhom" value="${CTNhomHocPhan.nhomAsString}">
                    <input class="To" type="text" disabled style="max-width: 40px; text-align: center;"
                        pattern="[0-9]" maxlength="2" placeholder="" name="To"
                        value="${CTHocPhanSection.nhomToAsString == '00' ? '' : CTHocPhanSection.nhomToAsString}">
                </c:if>
            </label>
            <label class="LopSinhVien">
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
            <div class="DsNguoiMuonPhong">
                <button class="nav-object" type="submit" formaction="#scriptSet">
                    Danh sách người được mượn phòng
                </button>
            </div>
            <!-- MARK: First Section -->
            <br>
            <label class="GiangVien HocPhan-Root">
                <span>Giảng viên: </span>
                <select disabled required name="GiangVien-Root">
                    <option disabled selected hidden value="">
                        Chọn giảng viên
                    </option>
                    <c:choose>
                        <c:when test="${DsGiangVien != null}">
                            <c:forEach var="GiangVien" items="${DsGiangVien}">
                                <option value="${GiangVien.maGiangVien}">
                                    ${GiangVien.maGiangVien} - ${GiangVien.nguoiDung.hoTen}
                                </option>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <option disabled selected hidden value="${CTHocPhanRoot.giangVienGiangDay.maGiangVien}">
                                ${CTHocPhanRoot.giangVienGiangDay.maGiangVien} -
                                ${CTHocPhanRoot.giangVienGiangDay.nguoiDung.hoTen}
                            </option>
                        </c:otherwise>
                    </c:choose>
                </select>
            </label>
            <label class="MucDich HocPhan-Root">
                <span>Hình thức học: </span>
                <select disabled required name="MucDich-Root">
                    <option disabled selected hidden value="">
                        Chọn hình thức
                    </option>
                    <option value="LT">
                        Lý thuyết
                    </option>
                    <option value="TH">
                        Thực hành
                    </option>
                    <option value="TN">
                        Thí nghiệm
                    </option>
                    <option value="U">
                        Khác
                    </option>
                </select>
            </label>
            <label class="StartDate HocPhan-Root">
                <span>Giai đoạn bắt đầu: </span>
                <input type="date" disabled required name="StartDate-Root"
                    value="${CTHocPhanRoot.startDate}">
            </label>
            <label class="EndDate HocPhan-Root">
                <span>Giai đoạn kết thúc: </span>
                <input type="date" disabled required name="EndDate-Root"
                    value="${CTHocPhanRoot.endDate}">
            </label>
            <div class="add-layout HocPhan-Section">
                <button class="add-object HocPhan-Section" type="button" onclick="addHocPhanSection()">
                    Thêm thông tin
                </button>
            </div>
            <div class="innocent HocPhan-Section">
                <!-- MARK: Second Section -->
                <br>
                <label class="GiangVien HocPhan-Section">
                    <span>Giảng viên: </span>
                    <select disabled required name="GiangVien-Section">
                        <option disabled selected hidden value="">
                            Chọn giảng viên
                        </option>
                        <c:choose>
                            <c:when test="${DsGiangVien != null}">
                                <c:forEach var="GiangVien" items="${DsGiangVien}">
                                    <option value="${GiangVien.maGiangVien}">
                                        ${GiangVien.maGiangVien} - ${GiangVien.nguoiDung.hoTen}
                                    </option>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <option disabled selected hidden
                                    value="${CTHocPhanSection.giangVienGiangDay.maGiangVien}">
                                    ${CTHocPhanSection.giangVienGiangDay.maGiangVien} -
                                    ${CTHocPhanSection.giangVienGiangDay.nguoiDung.hoTen}
                                </option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </label>
                <label class="MucDich HocPhan-Section">
                    <span>Hình thức học: </span>
                    <select disabled required name="MucDich-Section">
                        <option disabled selected hidden value="">
                            Chọn hình thức
                        </option>
                        <option value="LT">
                            Lý thuyết
                        </option>
                        <option value="TH">
                            Thực hành
                        </option>
                        <option value="TN">
                            Thí nghiệm
                        </option>
                        <option value="U">
                            Khác
                        </option>
                    </select>
                </label>
                <label class="StartDate HocPhan-Section">
                    <span>Giai đoạn bắt đầu: </span>
                    <input type="date" disabled required name="StartDate-Section"
                        value="${CTHocPhanSection.startDate}">
                </label>
                <label class="EndDate HocPhan-Section">
                    <span>Giai đoạn kết thúc:</span>
                    <input type="date" disabled required name="EndDate-Section"
                        value="${CTHocPhanSection.endDate}">
                </label>
            </div>
            <div class="remove-layout HocPhan-Section">
                <button class="remove-object HocPhan-Section" type="button" onclick="removeHocPhanSection()">
                    Lược bỏ thông tin
                </button>
            </div>
            <label class="QuanLyKhoiTao">
                <span>Quản lý tạo lớp học: </span>
                <input type="text" disabled
                    value="${CTNhomHocPhan.quanLyKhoiTao.maQuanLy}${QuanLyKhoiTao.maQuanLy} - ${CTNhomHocPhan.quanLyKhoiTao.nguoiDung.hoTen}${QuanLyKhoiTao.nguoiDung.hoTen}" />
            </label>
            <label class="XacNhan">
                <span>Mã xác nhận: </span>
                <input type="text" disabled required name="XacNhan" />
            </label>
            <div class="submit">
                <button class="cancel-object" type="button" onclick="history.back()">
                    Hủy bỏ
                </button>
                <button id="option-one-id-${CTNhomHocPhan.idNhomHocPhanAsString}" class="submit-object" type="submit"
                    onsubmit="history.back();history.back();" formaction="#scriptSet" formmethod="post">
                    Cập nhật
                </button>
                <button id="option-two-id-${CTNhomHocPhan.idNhomHocPhanAsString}" class="conform-object" type="submit"
                    onsubmit="history.back();history.back();" formaction="#scriptSet" formmethod="post">
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