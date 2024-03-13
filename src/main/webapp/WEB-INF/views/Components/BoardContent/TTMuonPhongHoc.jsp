<!-- Điều hướng nhận điều kiện:
        UC              -   Usecase sử dụng
        Display         -   UC/Display sử dụng
        Form            -   UC/Form sử dụng
        UIDManager      -   UsecaseID quản lý
        UIDRegular      -   UsecaseID người mượn phòng
    Điều hướng nhận thông tin:
        MaLMPH          -   Mã lịch mượn phòng
        MaLH            -   Mã lớp học
        IdGV            -   Id giảng viên
        GiangVien       -   Họ tên giảng viên
        MaLopSV         -   Mã lớp giảng dạy
        MaMH            -   Mã môn học
        TenMH           -   Tên môn học
        MaPH            -   Mã phòng học    
        ThoiGian_BD     -   Thời gian mượn
        ThoiGian_KT     -   Thời gian trả
        HinhThuc        -   Hình thức
        LyDo            -   Lý do
        TrangThai       -   Trạng thái mượn
        NgMPH           -   Người mượn phòng học
        VaiTro          -   Vai trò người mượn phòng
        QL_Duyet        -   Quản lý duyệt
        YeuCau          -   Yêu cầu khi mượn
-->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
            scroll-behavior: smooth;
            font-family: 'Poppins', sans-serif;
        }
        *.hidden {
            display: none;
        }
        :root {
            --bg-color: #f1dc9c;
            --second-bg-color: #fcf0cf; 
            --text-color: #71706E;
            --text-box-color: #fcdec9;
            --main-color: #f3e0a7;
            --main-box-color: rgba(0, 0, 0, .7);
            --content-box-color: #b9b4a3;
            --admin-menu-color: #e9b4b4;
            --manager-menu-color: #ffda72;
            --regular-menu-color: #78c5c5;
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
                justify-content: space-between;
                align-items: start;
                border: .2rem solid var(--main-box-color);
                border-radius: 2.5rem;
                box-shadow: 1px 1px 2px black;
                overflow: hidden;

                legend {
                    align-self: center;
                    padding-bottom: 4rem;
                }
                label {
                    width: 100%;
                    height: 100%;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    gap: 1rem;

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
                div {
                    width: 100%;
                    height: 100%;
                    display: flex;
                    justify-content: space-around;
                    align-items: center;
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
                    font-size: 1.7rem;
                }
                h2 {
                    font-size: 2rem;
                }
            } 
            /* media boardContent design */
            main form {
                padding: 6rem 4rem;

                legend{
                    font-size: 2.5rem;
                }
                label {
                    font-size: 2rem;

                    input,
                    button {
                        font-size: 1.7rem;
                    }
                }
                button {
                    font-size: 2rem;
                }
            } 
        }
        @media only screen and ( 768px < width ) {/* Medium devices (landscape tablets, 768px and up) */
            /* media boardBar design */
            nav {
                a,
                button {
                    font-size: 2rem;
                }
                h2 {
                    font-size: 2.2rem;
                }
            } 
            /* media boardContent design */
            main form {
                padding: 6rem 12rem;

                legend {
                    font-size: 3rem;
                }
                label {
                    font-size: 2.2rem;

                    input,
                    button {
                        font-size: 2rem;
                    }
                }
                button {
                    font-size: 2.2rem;
                }
            }
        }
    </style>
    <script>
        //Hàm thay đổi thuộc tính cho các label trong form
        function setUsecases() {
            const urlParams = new URLSearchParams(window.location.search);
            
            // Lấy giá trị của các tham số từ URL
            const UC = urlParams.get('UC');
            const Display = urlParams.get('Display');
            const Form = urlParams.get('Form');
            const UIDManager = urlParams.get('UIDManager');
            const UIDRegular = urlParams.get('UIDRegular');

            console.log(UC, Display, Form, UIDManager,UIDRegular)
            // Trường hợp xem thông tin lịch mượn phòng học
            if( UIDManager && UC === 'DsMPH' && Display === 'TTMPH') {

                // Thay đổi nội dung của các thẻ trong nav
                document.querySelector('.board-bar h2.title').textContent = "Mã mượn phòng học: ";

                // Ẩn các phần tử button trong form
                document.querySelector('.board-content .cancel-object').classList.add("hidden");
                document.querySelector('.board-content .conform-object').classList.add("hidden");
                document.querySelector('.board-content .submit-object').classList.add("hidden");

                // Ẩn phần tử button hướng dẫn
                document.querySelector('button#openGuide').classList.add("hidden");

            } 
            // Trường hợp thêm thông tin lịch mượn phòng học
            else if( UIDManager && UC === 'DsMPH' && Form === 'ThemTTMPH' ) {

                // Thay đổi nội dung của các thẻ trong nav
                document.querySelector('.board-bar h2.title').textContent = "Thêm thông tin lịch mượn phòng";
                // Ẩn các phần tử button trong nav
                document.querySelector('.board-bar .update-object').classList.add("hidden");
                document.querySelector('.board-bar .remove-object').classList.add("hidden");

                // Thay đổi nội dung của các thẻ trong form
                document.querySelector('.board-content .DsNgMPH button').textContent = "Nhập danh sách cho phép mượn phòng học";

                // Ẩn các phần tử label trong form
                document.querySelector('.board-content .GiangVien').classList.add("hidden");
                document.querySelector('.board-content .MaLopSV').classList.add("hidden");
                document.querySelector('.board-content .TenMH').classList.add("hidden");
                document.querySelector('.board-content .TrangThai').classList.add("hidden");
                document.querySelector('.board-content .NgMPH').classList.add("hidden");
                document.querySelector('.board-content .VaiTro').classList.add("hidden");
                document.querySelector('.board-content .QL_Duyet').classList.add("hidden");
                document.querySelector('.board-content .YeuCau').classList.add("hidden");
                // Ẩn các phần tử button trong form
                document.querySelector('.board-content .conform-object').classList.add("hidden");
                // Bỏ thuộc tính disabled của các phần tử 
                document.querySelector('.board-content .MaPH input').removeAttribute('disabled');
                document.querySelector('.board-content .ThoiGian_BD input').removeAttribute('disabled');
                document.querySelector('.board-content .ThoiGian_KT input').removeAttribute('disabled');
                document.querySelector('.board-content .HinhThuc select').removeAttribute('disabled');
                document.querySelector('.board-content .LyDo input').removeAttribute('disabled');

                // Ẩn phần tử button hướng dẫn
                document.querySelector('button#openGuide').classList.add("hidden");

            } 
            // Trường hợp lập thủ tục mượn phòng học
            else if ( UIDRegular && UC === 'MPH' & Display === 'YCMPH' ){

                // Thay đổi nội dung của các thẻ trong nav
                document.querySelector('.board-bar h2.title').textContent = "Thủ tục mượn phòng với mã: ";
                // Ẩn các phần tử button trong nav
                document.querySelector('.board-bar .update-object').classList.add("hidden");
                document.querySelector('.board-bar .remove-object').classList.add("hidden");

                // Ẩn các phần tử label trong form
                document.querySelector('.board-content .LyDo').classList.add("hidden");
                document.querySelector('.board-content .NgMPH').classList.add("hidden");
                document.querySelector('.board-content .VaiTro').classList.add("hidden");
                document.querySelector('.board-content .QL_Duyet').classList.add("hidden");
                // Ẩn các phần tử button trong form
                document.querySelector('.board-content .DsNgMPH').classList.add("hidden");
                document.querySelector('.board-content .submit-object').classList.add("hidden");

                // Bỏ thuộc tính disabled của các phần tử
                document.querySelector('.board-content .YeuCau input').removeAttribute('disabled');

            }
            // Trường hợp lập thủ tục đổi buổi học
            else if ( UIDRegular && UC === 'DBH' & Display === 'TTDBH' ){

                // Thay đổi nội dung của các thẻ trong nav
                document.querySelector('.board-bar h2.title').textContent = "Thủ tục đổi buổi học";
                // Ẩn các phần tử button trong nav
                document.querySelector('.board-bar .update-object').classList.add("hidden");
                document.querySelector('.board-bar .remove-object').classList.add("hidden");

                // Ẩn các phần tử label trong form
                document.querySelector('.board-content .TrangThai').classList.add("hidden");
                document.querySelector('.board-content .NgMPH').classList.add("hidden");
                document.querySelector('.board-content .VaiTro').classList.add("hidden");
                document.querySelector('.board-content .QL_Duyet').classList.add("hidden");
                // Ẩn các phần tử button trong form
                document.querySelector('.board-content .DsNgMPH').classList.add("hidden");
                document.querySelector('.board-content .submit-object').classList.add("hidden");

                // Bỏ thuộc tính disabled của các phần tử
                document.querySelector('.board-content .MaPH input').removeAttribute('disabled');
                document.querySelector('.board-content .ThoiGian_BD input').removeAttribute('disabled');
                document.querySelector('.board-content .ThoiGian_KT input').removeAttribute('disabled');
                document.querySelector('.board-content .HinhThuc select').removeAttribute('disabled');
                document.querySelector('.board-content .LyDo input').removeAttribute('disabled');
                document.querySelector('.board-content .YeuCau input').removeAttribute('disabled');

            } 
            // else { //Xử lý lỗi ngoại lệ truy cập
            //     window.location.href = "../ErrorHandling/index.html";
            // }
        }

        // Hàm đặt giá trị cho các thẻ input trong form
        function setFormValues() {
            const urlParams = new URLSearchParams(window.location.search);
                
            // Lấy giá trị của các tham số từ URL
            const MaLMPH = urlParams.get('MaLMPH');
            const MaLH = urlParams.get('MaLH');
            const GiangVien = urlParams.get('GiangVien');
            const MaLopSV = urlParams.get('MaLopSV');
            const MaMH = urlParams.get('MaMH');
            const TenMH = urlParams.get('TenMH');
            const MaPH = urlParams.get('MaPH');
            const ThoiGian_BD = urlParams.get('ThoiGian_BD');
            const ThoiGian_KT = urlParams.get('ThoiGian_KT');
            const HinhThuc = urlParams.get('HinhThuc');
            const LyDo = urlParams.get('LyDo');
            const TrangThai = urlParams.get('TrangThai');
            const NgMPH = urlParams.get('NgMPH');
            const VaiTro = urlParams.get('VaiTro');
            const QL_Duyet = urlParams.get('QL_Duyet');
            const YeuCau = urlParams.get('YeuCau');

            const title = document.querySelector('.board-bar h2.title');
            // Đặt nội dung văn bản của phần tử này
            title.textContent = title.textContent + ( MaLMPH ? MaLMPH : "" );
            
            // Hiển thị dữ liệu trên HTML
            document.querySelector('.board-content .GiangVien input').value = GiangVien;
            document.querySelector('.board-content .MaLopSV input').value = MaLopSV;
            document.querySelector('.board-content .TenMH input').value = TenMH;
            document.querySelector('.board-content .MaPH input').value = MaPH;
            document.querySelector('.board-content .ThoiGian_BD input').value = ThoiGian_BD;
            document.querySelector('.board-content .ThoiGian_KT input').value = ThoiGian_KT;
            document.querySelector('.board-content .HinhThuc select').value = HinhThuc;
            document.querySelector('.board-content .LyDo input').value = LyDo;
            document.querySelector('.board-content .TrangThai input').value = TrangThai;
            document.querySelector('.board-content .NgMPH input').value = NgMPH;
            document.querySelector('.board-content .VaiTro input').value = VaiTro;
            document.querySelector('.board-content .QL_Duyet input').value = QL_Duyet;
            if ( YeuCau ) document.querySelector('.board-content .YeuCau input').value = YeuCau;
        }

        // Gọi hàm setFormValues khi trang được load
        document.addEventListener("DOMContentLoaded", function () {
            setUsecases();
            setFormValues();
        });

    </script>
</head>

<body>
    <nav  class="board-bar">
        <a class="go-back" onclick="history.back()">Quay lại</a>
        <h2 class="title">SomeThingError!</h2>
        <button class="update-object" onclick="">Chỉnh sửa</button>
        <button class="remove-object" onclick="">Xóa</button>
    </nav>
    <main>
        <form class="board-content">
            <legend>Thông tin mượn phòng học</legend>
            <label class="GiangVien">
                <span>Giảng viên: </span>
                <input id="GiangVien" type="text" disabled> 
            </label>
            <label class="MaLopSV">
                <span>Lớp giảng dạy: </span>
                <input id="" type="text" disabled>
            </label>
            <label class="TenMH">
                <span>Tên môn học: </span>
                <input type="text" disabled>
            </label>
            <label class="MaPH">
                <span>Phòng học: </span>
                <input type="text" disabled>
            </label>
            <div class="DsNgMPH">
                <button class="nav-object" type="submit" formaction="#">Danh sách cho phép mượn phòng học</button>
            </div>
            <label class="ThoiGian_BD">
                <span>Thời gian bắt đầu: </span>
                <input type="text" disabled>
            </label>
            <label class="ThoiGian_KT">
                <span>Thời gian kết thúc: </span>
                <input type="text" disabled>
            </label>
            <label class="HinhThuc">
                <span>Mục đích: </span>
                <select disabled>
                    <option value="Học lý thuyết">Học lý thuyết</option>
                    <option value="Học thực hành">Học thực hành</option>
                    <option value="Khác">Khác</option>
                </select>
            </label>
            <label class="LyDo">
                <span>Lý do: </span> 
                <input type="text" disabled>
            </label>
            <label class="TrangThai">
                <span>Trạng thái: </span> 
                <input type="text" disabled>
            </label>
            <label  class="NgMPH">
                <span>Người đã mượn phòng: </span> 
                <input type="text" disabled>
            </label>
            <label class="VaiTro" hidden>
                <span>Đối tượng mượn phòng: </span> 
                <input type="text" disabled>
            </label>
            <label class="QL_Duyet">
                <span>Quản lý đã duyệt: </span> 
                <input type="text" disabled>
            </label>
            <label class="YeuCau">
                <span>Yêu cầu thêm khi mượn: </span> 
                <input type="text" value="MC+R+MT" disabled>
            </label>
            <div>
                <button class="cancel-object" type="button" onclick="history.back()">Hủy bỏ</button>
                <button class="submit-object" type="submit" formaction="#">Cập nhật</button>
                <button class="conform-object" type="submit" formaction="#">Xác nhận</button>
            </div>
        </form>
    </main>
    <button id="openGuide" onclick="window.dialog.showModal()">Hướng dẫn</button>
    <dialog id="dialog">
        <form method="dialog">
            <div>Hướng dẫn</div>
            <p>
                1. Chọn lớp học mà sinh viên, giảng viên cần mượn phòng giảng dạy.<br>
                <b>2. Cung cấp thêm thông tin mượn phòng để quản lý duyệt.</b> <br>
                3. Chờ quản lý kiểm tra thông tin và nhận đồ xài :&gt;
            </p>
            <button>Close</button>
        </form>
    </dialog>
    <style>
        button#openGuide {
            position: absolute;
            bottom: 0px;
            right: 0px;
            border: .2rem solid black;
            border-radius: 1rem;
            padding: .3rem;
        }
        button#openGuide.hidden {
            display: none;
        }
        button#closeGuide {
            border: .2rem solid black;
            border-radius: 1rem;
            padding: .3rem;
        }
        dialog {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            border: .2rem solid black;
            border-radius: 1rem;
            padding: .5rem;
        
            b {
                color: blue;
            }
        }
        dialog::backdrop {
            background-color: var(--bg-color);
            opacity: .2;
        }
        @media only screen and ( width <= 768px) {/* Small devices (portrait tablets and large phones, 600px and up to 768px) */
            dialog {
                div {
                    font-size: 1.5rem;
                }
                p {
                    font-size: 1rem;
                }
            }
        }
        @media only screen and ( 768px < width ) {/* Medium devices (landscape tablets, 768px and up) */
            dialog {
                div {
                    font-size: 2.2rem;
                }
                p {
                    font-size: 1.5rem;
                }
            }
        }
    </style>
    <script>
        function onClick(event) {
            if (event.target === dialog) {
              dialog.close();
            }
          }
        const dialog = document.querySelector("dialog");
        dialog.addEventListener("click", onClick);
    </script>
</body>

</html>