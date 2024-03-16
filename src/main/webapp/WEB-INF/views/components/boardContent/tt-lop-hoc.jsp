<!-- 
    Dữ liệu tiếp nhận:
        URL:
            Paths:
                Usecase         -   Usecase sử dụng
                UsecasePath     -   UsecasePath sử dụng
            Params:
                MaLopHoc        -   Mã lớp học
        Controller:
            NextUsecase-Table       -   Usecase chuyển tiếp trong table
            NextUsecasePath-Table   -   UsecasePath chuyển tiếp trong table
            TTLopHoc:
                MaLH        -   Mã lớp học
                GiangVien   -   Họ tên giảng viên
                MaLopSV     -   Mã lớp giảng dạy
                MaMH        -   Mã môn học
                TenMH       -   Tên môn học
                Ngay_BD     -   Kỳ học bắt đầu
                Ngay_KT     -   Kỳ học kết thúc
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

        // Lấy phần pathname của URL và loại bỏ đuôi ".htm" (nếu có)
        var urlWithoutExtension = url.replace(/\.htm$/, '');

        let urlParts = urlWithoutExtension.split('?');
        let paths = urlParts[0].split('/');
        let params = new URLSearchParams(urlParts[1]);

        // // Lấy thông tin từ phần tử của mảng
        // var Usecase = paths[paths.length - 2];
        // var UsecasePath = paths[paths.length - 1];

        // Lấy giá trị của các tham số từ request
        // var UIDManager = '<%= request.getAttribute("UIDManager") %>';
        // var UIDRegular = '<%= request.getAttribute("UIDRegular") %>';

        // Bỏ các dòng code lấy giá trị từ URL khi connect với controller
        var urlParams = new URLSearchParams(window.location.search);

        // Lấy giá trị của các tham số từ URL
        var Usecase = urlParams.get('Usecase');
        var UsecasePath = urlParams.get('Display') || urlParams.get('Form');
        var UIDManager = urlParams.get('UIDManager');
        var UIDRegular = urlParams.get('UIDRegular');

        var LastUsecase = urlParams.get('Usecase');
        var LastUsecasePath = urlParams.get('UsecasePath');
        var LastForm = urlParams.get('Form');

        // In ra console để kiểm tra
        // console.log(Usecase, UsecasePath, UIDManager,UIDRegular)
        // console.log(SearchInput, SearchOption)

        function setUsecases() {

            // Trường hợp xem thông tin lớp học
            if (UIDManager && Usecase === 'TTLH' && UsecasePath === 'XemTTLH') {

                // Chỉnh sửa phần tử nav theo Usecase
                document.querySelector('.board-bar').classList.add("menu-manager");

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
            else if (UIDManager && Usecase === 'TTLH' && UsecasePath === 'SuaTTLH') {

                // Chỉnh sửa phần tử nav theo Usecase
                document.querySelector('.board-bar').classList.add("menu-manager");

                // Thay đổi nội dung của các thẻ trong nav
                document.querySelector('.board-bar h2.title').textContent = "Chỉnh sửa lớp học mã: ";
                // Ẩn các phần tử button trong nav
                document.querySelector('.board-bar .update-object').classList.add("hidden");
                document.querySelector('.board-bar .remove-object').classList.add("hidden");

                // Ẩn các phần tử button trong form
                document.querySelector('.board-content .submit-object').classList.add("hidden");

                // Bỏ thuộc tính disabled của các phần tử
                document.querySelector('.board-content .GiangVien select').removeAttribute('disabled');
                document.querySelector('.board-content .MaLopSV select').removeAttribute('disabled');
                document.querySelector('.board-content .MaMH select').removeAttribute('disabled');
                document.querySelector('.board-content .Ngay_BD input').removeAttribute('disabled');
                document.querySelector('.board-content .Ngay_KT input').removeAttribute('disabled');
                document.querySelector('.board-content .XacNhan input').removeAttribute('disabled');

                // Hiện các phần tử button trong form
                document.querySelector('.board-content .submit').classList.remove("hidden");
                document.querySelector('.board-content .cancel-object').classList.remove("hidden");
                document.querySelector('.board-content .conform-object').classList.remove("hidden");

            }
            else { //Xử lý lỗi ngoại lệ truy cập
                window.location.href = "../ErrorHandling/index.html";
            }
        }

        // Hàm đặt giá trị cho các thẻ input trong form
        function setFormValues() {
            const urlParams = new URLSearchParams(window.location.search);

            // Lấy giá trị của các tham số từ request
            // var MaLH = '<%= request.getAttribute("MaLH") %>';
            // var IdGV = '<%= request.getAttribute("IdGV") %>';
            // var GiangVien = '<%= request.getAttribute("GiangVien") %>';
            // var MaLopSV = '<%= request.getAttribute("MaLopSV") %>';
            // var MaMH = '<%= request.getAttribute("MaMH") %>';
            // var TenMH = '<%= request.getAttribute("TenMH") %>';
            // var Ngay_BD = '<%= request.getAttribute("Ngay_BD") %>';
            // var Ngay_KT = '<%= request.getAttribute("Ngay_KT") %>';

            // Bỏ các dòng code lấy giá trị từ URL khi connect với controller
            // Lấy giá trị của các tham số từ URL
            const MaLH = urlParams.get('MaLH');
            const IdGV = urlParams.get('IdGV');
            const GiangVien = urlParams.get('GiangVien');
            const MaLopSV = urlParams.get('MaLopSV');
            const MaMH = urlParams.get('MaMH');
            const TenMH = urlParams.get('TenMH');
            const Ngay_BD = urlParams.get('Ngay_BD');
            const Ngay_KT = urlParams.get('Ngay_KT');


            const title = document.querySelector('.board-bar h2.title');
            // Đặt nội dung văn bản của phần tử này
            title.textContent = title.textContent + (MaLH ? MaLH : "");



            // Hiển thị dữ liệu trên HTML
            document.querySelector('.board-content .MaLH input').value = MaLH;
            document.querySelector('.board-content .GiangVien select').value = GiangVien;
            document.querySelector('.board-content .MaLopSV select').value = MaLopSV;
            document.querySelector('.board-content .MaMH select').value = MaMH;
            document.querySelector('.board-content .Ngay_BD input').value = Ngay_BD;
            document.querySelector('.board-content .Ngay_KT input').value = Ngay_KT;
        }

        // Gọi hàm setFormValues khi trang được load
        document.addEventListener("DOMContentLoaded", function () {
            setUsecases();
            setFormValues();
        });

        // Gọi hàm settingToUpdateData khi thao tác với nút update-object
        function settingToUpdateData() {
            // // Thay đổi path thứ hai thành 'DSMPH'
            // UsecasePath = 'SuaTTMPH';

            // Tạo URL mới từ các phần tử đã thay đổi
            // let newURL = paths.join('/') + '.htm' + '?' + params.toString(); ;

            // Bỏ các dòng code khi connect với controller
            params.set('Display', '');
            params.set('Form', 'SuaTTLH');

            let newURL = paths.join('/') + '?' + params.toString();

            // Thay đổi URL và reload lại trang
            history.back();
            history.pushState(null, '', newURL);
            window.location.reload();
        }
        function settingToDeleteData() {

        }
        function settingToCancelChangeData() {
            // // Thay đổi path thứ hai thành 'DSMPH'
            // UsecasePath = 'TTMPH';

            // Tạo URL mới từ các phần tử đã thay đổi
            // let newURL = paths.join('/') + '.htm' + '?' + params.toString(); ;

            // Bỏ các dòng code khi connect với controller
            params.set('Display', '');
            params.set('Form', 'TTLH');

            let newURL = paths.join('/') + '?' + params.toString();

            // Thay đổi URL và reload lại trang
            history.back();
            history.pushState(null, '', newURL);
            window.location.reload();
        }
        function settingToSubmitData() {

        }
    </script>
</head>

<body>
    <nav class="board-bar">
        <a class="go-back" onclick="history.back();">Quay lại</a>
        <h2 class="title">SomeThingError!</h2>
        <button class="update-object hidden" onclick="settingToUpdateData()">Chỉnh sửa</button>
        <button class="remove-object hidden" onclick="">Xóa</button>
    </nav>
    <main>
        <form class="board-content">
            <legend>Thông tin lớp học</legend>
            <label class="MaLH">
                <span>Mã lớp học: </span>
                <input type="text" disabled>
            </label>
            <label class="GiangVien">
                <span>Giảng viên: </span>
                <select disabled>
                    <option value="Nguyễn Đức Thịnh">Nguyễn Đức Thịnh</option>
                    <option value="Nguyễn Ngọc Duy">Nguyễn Ngọc Duy</option>
                    <option value="Nguyễn Thị Bích Nguyên">Nguyễn Thị Bích Nguyên</option>
                </select>
            </label>
            <label class="MaLopSV">
                <span>Lớp giảng dạy: </span>
                <select disabled>
                    <option value="D22CQCN01-N">D22CQCN01-N</option>
                    <option value="D21CQAT01-N">D21CQAT01-N</option>
                    <option value="D21CQCN01-N">D21CQCN01-N</option>
                </select>
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
                <input type="text" disabled>
            </label>
            <label class="Ngay_KT">
                <span>Kỳ học kết thúc: </span>
                <input type="text" disabled>
            </label>
            <label class="XacNhan">
                <span>Mã xác nhận: </span>
                <input type="text" disabled required>
            </label>
            <div class="submit">
                <button class="cancel-object" type="button" onclick="settingToCancelChangeData()">Hủy
                    bỏ</button>
                <button class="submit-object" type="submit" formaction="#">Cập nhật</button>
                <button class="conform-object" type="submit" formaction="#">Xác nhận</button>
            </div>
        </form>
    </main>
</body>

</html>