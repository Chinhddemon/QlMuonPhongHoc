<!-- 
    Dữ liệu tiếp nhận:
        URL:
            Paths:
                Usecase         -   Usecase sử dụng
                UsecasePath     -   UsecasePath sử dụng
            Params:
                MaLopHoc        -   Mã lớp học
        Controller:
            NextUsecaseTable       -   Usecase chuyển tiếp trong table
            NextUsecasePathTable   -   UsecasePath chuyển tiếp trong table
            TTLopHoc:
                maLH        -   Mã lớp học
                giangVien   -   Họ tên giảng viên
                maLopSV     -   Mã lớp giảng dạy
                maMH        -   Mã môn học
                tenMH       -   Tên môn học
                ngay_BD     -   Kỳ học bắt đầu
                ngay_KT     -   Kỳ học kết thúc
        SessionStorage:
            UIDManager
            UIDRegular
Chuẩn View URL truy cập:   ../${Usecase}/${UsecasePath}.htm?LopHoc=${LopHoc}
-->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Thông tin mượn phòng học</title>
    <style>
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
            --second-bg-color: #fcf0cf; 
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
            height: 100vh;
            background: var(--second-bg-color);
            display: flex;
            flex-direction: column;
            color: var(--text-color);
        }
        /* boardBar design */
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
        /* boardContent design */
        main {
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;

            form {
                max-width: 100rem;
                min-width: 50rem;
                height: 90%;
                background: var(--main-color);
                display: flex;
                flex-direction: column;
                justify-content: space-around;
                align-items: start;
                border: .2rem solid var(--main-box-color);
                border-radius: 2.5rem;
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
                    justify-content: space-between;
                    align-items: center;
                    gap: 2rem;

                    input,
                    select {
                        flex-grow: 1;
                        text-align: end;
                        border-right: .2rem solid var(--main-box-color);
                        border-bottom: .3rem solid var(--main-box-color);
                        border-radius: 1rem;
                        padding: 1rem;
                        opacity: .7;
                    }
                    input:disabled,
                    select:disabled {
                        background: transparent;
                        border: none;
                        opacity: 1;
                    }
                }
                label.XacNhan {
                    width: 80%;
                    align-self: center;
                    font-weight: 700;

                    input {
                        box-shadow: .1rem 0 .7rem var(--main-box-color);
                        font-weight: 700;
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
                padding: 6rem 4rem;

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
        // // Lấy địa chỉ URL hiện tại
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

        // In ra console để kiểm tra
        //console.log(Usecase, UsecasePath, UIDManager,UIDRegular)
        //console.log(SearchInput, SearchOption)

        function setUsecases() {

        	if ( UIDManager && UIDRegular ) {
               	window.location.href = "../Error.htm?Message=Lỗi UIDManager và UIDRegular đồng thời đăng nhập";
        	}
            // Trường hợp người sử dụng là quản lý
            else if ( UIDManager ) {

                // Trường hợp xem thông tin lớp học
                if ( Usecase === 'TTLH' && UsecasePath === 'XemTTLH') {

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");
                    // Thay đổi nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Mã lớp học: ${TTLopHoc.maLH}";

                    // Hiện các phần tử button trong nav
                    document.querySelector('.board-bar .update-object').classList.remove("hidden");
                    document.querySelector('.board-bar .remove-object').classList.remove("hidden");

                    // Thay đổi nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Mã lớp học: ";

                    // Ẩn các phần tử label trong form
                    document.querySelector('.board-content .XacNhan').classList.add("hidden");
                    // Ẩn các phần tử button trong form
                    document.querySelector('.board-content .submit').classList.add("hidden");
                    document.querySelector('.board-content .cancel-object').classList.add("hidden");
                    document.querySelector('.board-content .conform-object').classList.add("hidden");
                    document.querySelector('.board-content .submit-object').classList.add("hidden");

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
                else if ( Usecase === 'TTLH' && UsecasePath === 'SuaTTLH') {

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");

                    // Thay đổi nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Chỉnh sửa lớp học với mã: ${TTLopHoc.maLH}";
                    // Ẩn các phần tử button trong nav
                    document.querySelector('.board-bar .update-object').classList.add("hidden");
                    document.querySelector('.board-bar .remove-object').classList.add("hidden");

                    // Ẩn các phần tử button trong form
                    document.querySelector('.board-content .submit-object').classList.add("hidden");

                    // Bỏ thuộc tính disabled của các phần tử
                    document.querySelector('.board-content .GiangVien input').removeAttribute('disabled');
                    document.querySelector('.board-content .MaLopSV input').removeAttribute('disabled');
                    document.querySelector('.board-content .MaMH select').removeAttribute('disabled');
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
        function setFormValues() {
			
        	// Đặt giá trị cho các thẻ select trong form
            document.querySelector('.board-content .MaMH select').value = '${TTLichMPH.maMH}';
            
        }

        // Gọi hàm settingToUpdateData khi thao tác với nút update-object
        function modifyToUpdateData() {
            
        	// Thay đổi path thứ hai thành 'DSMPH'
            paths[paths.length - 1] = 'SuaTTLH';

            // Tạo URL mới từ các phần tử đã thay đổi
            let newURL = paths.join('/') + '.htm' + '?' + params.toString();

            window.location.href = newURL;
        }
        function settingToDeleteData() {

        }
        function settingToSubmitData() {

        }

        // Gọi hàm khi trang được load
        document.addEventListener("DOMContentLoaded", function () {
            setUsecases();
            setFormValues();
        });
    </script>
</head>

<body>
    <nav class="board-bar">
        <a class="go-back" onclick="history.back();">Quay lại</a>
        <h2 class="title">SomeThingError!</h2>
        <button class="update-object hidden" onclick="modifyToUpdateData()">Chỉnh sửa</button>
        <button class="remove-object hidden" onclick="">Xóa</button>
    </nav>
    <main>
        <form class="board-content">
            <legend>Thông tin lớp học</legend>
            <label class="MaLH">
                <span>Mã lớp học: </span>
                <input type="text" value="${TTLopHoc.maLH}" disabled>
            </label>
            <label class="GiangVien">
                <span>Giảng viên: </span>
                <input type="text" value="${TTLopHoc.giangVien}" disabled>
            </label>
            <label class="MaLopSV">
                <span>Lớp giảng dạy: </span>
                <input type="text" value="${TTLopHoc.maLopSV}" disabled>
            </label>
            <label class="MaMH TenMH">
                <span>Môn học: </span>
                <select disabled>
                    <option value="INT1359-3">INT1341 - Toán rời rạc 2</option>
                    <option value="INT1341">INT1341 - Nhập môn trí tuệ nhân tạo</option>
                    <option value="INT1340">INT1340 - Nhập môn công nghệ phần mềm</option>
                </select>
            </label>
            <label class="Ngay_BD">
                <span>Kỳ học bắt đầu: </span>
                <input type="text" value="${TTLopHoc.ngay_BD}" disabled>
            </label>
            <label class="Ngay_KT">
                <span>Kỳ học kết thúc: </span>
                <input type="text" value="${TTLopHoc.ngay_KT}" disabled>
            </label>
            <label class="XacNhan">
                <span>Mã xác nhận: </span>
                <input type="text" disabled required>
            </label>
            <div class="submit">
                <button class="cancel-object" type="button" onclick="history.back()">Hủy
                    bỏ</button>
                <button class="submit-object" type="submit" formaction="#">Cập nhật</button>
                <button class="conform-object" type="submit" formaction="#">Xác nhận</button>
            </div>
        </form>
    </main>
</body>

</html>