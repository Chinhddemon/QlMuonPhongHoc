<!-- 
    Dữ liệu tiếp nhận:
        URL:
            Paths:
                Usecase         -   Usecase sử dụng
                UsecasePath     -   UsecasePath sử dụng
            Params:
                IdLHP            -   Id lớp học
        Controller:
            NextUsecaseTable       -   Usecase chuyển tiếp trong table
            NextUsecasePathTable   -   UsecasePath chuyển tiếp trong table
            CTLopHocPhan
        SessionStorage:
            UIDManager
            UIDRegular
Chuẩn View URL truy cập:   ../${Usecase}/${UsecasePath}.htm?IdLHP=${IdLHP}
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
                    padding: .2rem;

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
        @media only screen and ( width <= 768px) {/* Small devices (portrait tablets and large phones, 600px and up to 768px) */
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

                legend{
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
        @media only screen and ( 768px < width ) {/* Medium devices (landscape tablets, 768px and up) */
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

                legend{
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
        // Lấy phần pathname của URL và loại bỏ đuôi ".htm" (nếu có)
        let paths = urlParts[0].replace(/\.htm$/, '').split('/');
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

        	if ( UIDManager && UIDRegular ) {
               	window.location.href = "../Error.htm?Message=Lỗi UIDManager và UIDRegular đồng thời đăng nhập";
        	}
            // MARK: Manager
            // Trường hợp người sử dụng là quản lý
            else if ( UIDManager ) {

                // Trường hợp xem thông tin lớp học
                if ( Usecase === 'CTLHP' && UsecasePath === 'XemCTLHP') {

                    // Ẩn các phần tử label trong form
                    document.querySelector('.board-content .XacNhan').classList.add("hidden");

                    // Ẩn các phần tử button trong form
                    document.querySelector('.board-content .submit').classList.add("hidden");
                    document.querySelector('.board-content .cancel-object').classList.add("hidden");
                    document.querySelector('.board-content .conform-object').classList.add("hidden");
                    document.querySelector('.board-content .submit-object').classList.add("hidden");

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");

                    // Chỉnh sửa nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Mã học phần: ${CTLopHocPhan.idNHP}${IdSection}";

                    // Hiện các phần tử button trong nav
                    document.querySelector('.board-bar .update-object').classList.remove("hidden");
                    document.querySelector('.board-bar .remove-object').classList.remove("hidden");

                    // Thêm thuộc tính disabled của các phần tử 
                    const listInput = document.querySelectorAll('.board-content input');
                    for (var i = 0; i < listInput.length; i++) { // Lặp qua từng thẻ input
                        listInput[i].setAttribute('disabled', 'true');
                    }
                    const listSelect = document.querySelectorAll('.board-content select');
                    for (var i = 0; i < listSelect.length; i++) { // Lặp qua từng thẻ select
                        listSelect[i].setAttribute('disabled', 'true');
                    }

                }
                // Trường hợp chỉnh sửa thông tin lớp học
                else if ( Usecase === 'CTLHP' && UsecasePath === 'SuaCTLHP') {

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");

                    // Thay đổi nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Chỉnh sửa học phần với mã: ${CTLopHocPhan.idNHP}${IdSection}";
                    // Ẩn các phần tử button trong nav
                    document.querySelector('.board-bar .update-object').classList.add("hidden");
                    document.querySelector('.board-bar .remove-object').classList.add("hidden");

                    // Ẩn các phần tử button trong form
                    document.querySelector('.board-content .submit-object').classList.add("hidden");

                    // Bỏ thuộc tính disabled của các phần tử
                    document.querySelector('.board-content .GiangVien input').removeAttribute('disabled');
                    document.querySelector('.board-content .LopSV input').removeAttribute('disabled');
                    document.querySelector('.board-content .MonHoc select').removeAttribute('disabled');
                    document.querySelector('.board-content .Ngay_BD input').removeAttribute('disabled');
                    document.querySelector('.board-content .Ngay_KT input').removeAttribute('disabled');
                    document.querySelector('.board-content .XacNhan input').removeAttribute('disabled');

                    // Hiện các phần tử button trong form
                    document.querySelector('.board-content .submit').classList.remove("hidden");
                    document.querySelector('.board-content .cancel-object').classList.remove("hidden");
                    document.querySelector('.board-content .conform-object').classList.remove("hidden");

                }
                else {  //Xử lý lỗi ngoại lệ truy cập
                    window.location.href = "../Error.htm?Message= Lỗi UID hoặc Usecase không tìm thấy";
                }

            }
            else {  // Không phát hiện mã UID
                window.location.href = "../Login.htm?Message=Không phát hiện mã UID";
           	}
        }
        // MARK: setFormValues
        function setFormValues() {
			
        	// Đặt giá trị cho các thẻ select trong form
            document.querySelector('.board-content .MonHoc select').value = '${CTLopHocPhan.monHoc.maMH}';
            
        }

        // MARK: event functions
        function modifyToUpdateData() {
            
        	// Thay đổi path thứ hai thành 'DSMPH'
            paths[paths.length - 1] = 'SuaCTLHP';

            // Tạo URL mới từ các phần tử đã thay đổi
            let newURL = paths.join('/') + '.htm' + '?' + params.toString();

            window.location.href = newURL;
        }
        function modifyToDeleteData() {

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
                        <select disabled required
                            name="MaMH">
                            <option disabled selected hidden
                                value="">
                                Chọn môn học
                            </option>
                            <c:choose>
                                <c:when test="${DsMonHoc == null}">
                                    <option disabled selected hidden
                                        value="${CTLopHocPhan.monHoc.maMH}">
                                        ${CTLopHocPhan.monHoc.maMH} - ${CTLopHocPhan.monHoc.tenMH}
                                    </option>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="MonHoc" items="${DsMonHoc}" >
                                        <option value="${MonHoc.maMH}">
                                            ${MonHoc.maMH} - ${MonHoc.tenMH}
                                        </option>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </select>
                    </label>
                    <label class="NhomTo">
                        <span>Nhóm tổ: </span>
                        <c:if test="${IdSection == '000000' || IdSection == ''}">
                            <input id="test3" type="text" disabled
                                value="${CTLopHocPhan.nhom}">
                        </c:if>
                        <c:if test="${IdSection != '000000' || IdSection != ''}">
                            <c:forEach var="CTLopHocPhanSection" items="${CTLopHocPhan.lopHocPhanSections}">
                                <c:if test="${CTLopHocPhanSection.nhomTo != '00' && CTLopHocPhanSection.nhomTo != ''}">
                                    <input id="test1" type="text" disabled
                                        value="${CTLopHocPhan.nhom}-${CTLopHocPhanSection.nhomTo}">
                                </c:if>
                                <c:if test="${CTLopHocPhanSection.nhomTo == '00'}">
                                    <input id="test1" type="text" disabled
                                        value="${CTLopHocPhan.nhom}">
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </label>
                    <label class="LopSV">
                        <span>Lớp giảng dạy: </span>
                        <input type="text" disabled
                            value="${CTLopHocPhan.lopSV.maLopSV}">
                    </label>
            <!-- MARK: First Section -->
            <c:forEach var="CTLopHocPhanRoot" items="${CTLopHocPhan.lopHocPhanSections}"><c:if test="${CTLopHocPhanRoot.nhomTo == ''}"><br>
                    <label class="GiangVien LHP-Root">
                        <span>Giảng viên: </span>
                        <input type="text" disabled
                            value="${CTLopHocPhanRoot.giangVien.ttNgMPH.hoTen}">
                    </label>
                    <label class="MucDich LHP-Root">
                        <span>Mục đích: </span>
                        <select disabled required
                            name="MucDich">
                            <option disabled selected hidden 
                                value="">
                                Hình thức học
                            </option>
                            <option 
                                value="LT">
                                Học lý thuyết
                            </option>
                            <option 
                                value="TH">
                                Học thực hành
                            </option>
                            <option 
                                value="U">
                                Khác
                            </option>
                        </select>
                        <script>
                            document.querySelector('.board-content .MucDich.LHP-Root select').value = '${CTLopHocPhanRoot.mucDich}';
                        </script>
                    </label>
                    <label class="Ngay_BD LHP-Root">
                        <span>Giai đoạn bắt đầu: </span>
                        <input type="date" disabled
                            name="ThoiGian_KT" 
                            value="${CTLopHocPhanRoot.ngay_BD}">
                    </label>
                    <label class="Ngay_KT LHP-Root">
                        <span>Giai đoạn kết thúc: </span>
                        <input type="date" disabled
                            name="ThoiGian_KT" 
                            value="${CTLopHocPhanRoot.ngay_KT}">
                    </label>
            </c:if></c:forEach>
            <!-- MARK: Second Section -->
            <c:if test="${IdSection != ''}">
                <c:forEach var="CTLopHocPhanSection" items="${CTLopHocPhan.lopHocPhanSections}"><c:if test="${CTLopHocPhanSection.idLHPSection == IdSection}"><br>
                    <label class="GiangVien LHP-Section">
                        <span>Giảng viên: </span>
                        <input type="text" disabled
                            value="${CTLopHocPhanSection.giangVien.ttNgMPH.hoTen}">
                    </label>
                    <label class="MucDich LHP-Section">
                        <span>Mục đích: </span>
                        <select disabled required
                            name="MucDich LHP-Section">
                            <option disabled selected hidden 
                                value="">
                                Hình thức học
                            </option>
                            <option 
                                value="LT">
                                Học lý thuyết
                            </option>
                            <option 
                                value="TH">
                                Học thực hành
                            </option>
                            <option 
                                value="U">
                                Khác
                            </option>
                        </select>
                        <script>
                            document.querySelector('.board-content .MucDich.LHP-Section select').value = '${CTLopHocPhanSection.mucDich}';
                        </script>
                    </label>
                    <label class="Ngay_BD LHP-Section">
                        <span>Giai đoạn bắt đầu: </span>
                        <input type="date" disabled
                            name="ThoiGian_KT" 
                            value="${CTLopHocPhanSection.ngay_BD}">
                    </label>
                    <label class="Ngay_KT LHP-Section">
                        <span>Giai đoạn kết thúc: </span>
                        <input type="date" disabled
                            name="ThoiGian_KT" 
                            value="${CTLopHocPhanSection.ngay_KT}">
                    </label>
                </c:if></c:forEach>
            </c:if>
                    <label class="XacNhan">
                        <span>Mã xác nhận: </span>
                        <input type="text" disabled required>
                    </label>
                    <div class="submit">
                        <button class="cancel-object" type="button" onclick="history.back()">Hủy bỏ</button>
                        <button class="submit-object" type="submit" onclick="history.back();history.back()" formaction="#">Cập nhật</button>
                        <button class="conform-object" type="submit" onclick="history.back();history.back()" formaction="#">Xác nhận</button>
                    </div>
                    <c:if test="${errorMessage != '' || errorMessage != null}">
                        <p>${errorMessage}</p>
                    </c:if>
        </form>
    </main>
</body>

</html>