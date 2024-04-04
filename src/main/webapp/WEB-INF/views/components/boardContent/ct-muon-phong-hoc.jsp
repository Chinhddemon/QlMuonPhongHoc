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
            NextUsecaseTable       -   Usecase chuyển tiếp trong table
            NextUsecasePathTable   -   UsecasePath chuyển tiếp trong table
            CTLichMPH			-	Chi tiết lịch mượn phòng học
            CTLopHocPhan	    - 	Chi tiết lớp học phần
        SessionStorage:
            UIDManager
            UIDRegular
    Chuẩn View URL truy cập:   ../${Usecase}/${UsecasePath}.htm?MaLichMPH=${MaLichMPH}&MaLopHoc=${MaLopHoc}
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
            min-height: 100vh;
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

                    input,
                    select {
                        flex-grow: 1;
                        text-align: end;
                        border-right: .2rem solid var(--main-box-color);
                        border-bottom: .3rem solid var(--main-box-color);
                        border-radius: 1rem;
                        padding: .5rem;
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
                    max-width: 85%;
                    align-self: center;
                    font-weight: 700;

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
                padding: 3rem 8rem;

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
                padding: 3rem 12rem;

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

        function setUsecases() {

        	if ( UIDManager && UIDRegular ) {
               	window.location.href = "../Error.htm?Message=Lỗi UIDManager và UIDRegular đồng thời đăng nhập";
        	}
            // Trường hợp người sử dụng là quản lý
            else if ( UIDManager ) {

                // Trường hợp xem thông tin lịch mượn phòng học
                if( Usecase === 'CTMPH' && UsecasePath === 'XemTTMPH') {
            
                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");
                    
                    // Hiện các phần tử button trong nav
                    document.querySelector('.board-bar .update-object').classList.remove("hidden");
                    document.querySelector('.board-bar .remove-object').classList.remove("hidden");
            
                    // Thay đổi nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Mã mượn phòng học: ${CTLichMPH.idLMPH}";
            
                    // Ẩn các phần tử label trong form
                                        document.querySelector('.board-content .XacNhan').classList.add("hidden");
                    document.querySelector('.board-content .submit').classList.add("hidden");
                    // Ẩn các phần tử button trong form
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
            
                    // Hiện các phần tử button trong form
                    document.querySelector('.board-content .DsNgMPH').classList.remove("hidden");
            
                    // Ẩn phần tử button hướng dẫn
                    document.querySelector('button#openGuide').classList.add("hidden");
            
                }
                // Trường hợp thêm thông tin lịch mượn phòng học
                else if( Usecase === 'CTMPH' && UsecasePath === 'ThemTTMPH' ) {
            
                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");
            
                    // Thay đổi nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Thêm thông tin lịch mượn phòng";
                    // Ẩn các phần tử button trong nav
                    document.querySelector('.board-bar .update-object').classList.add("hidden");
                    document.querySelector('.board-bar .remove-object').classList.add("hidden");
            
                    // Thay đổi nội dung của các thẻ trong form
                    document.querySelector('.board-content .DsNgMPH button').textContent = "Nhập danh sách người được mượn phòng";
            
                    // Ẩn các phần tử label trong form
                                        document.querySelector('.board-content .TrangThai').classList.add("hidden");
                    document.querySelector('.board-content .NgMPH').classList.add("hidden");
                    document.querySelector('.board-content .DoiTuong').classList.add("hidden");
                    document.querySelector('.board-content .QuanLyDuyet').classList.add("hidden");
                    document.querySelector('.board-content .ThoiGian_MPH').classList.add("hidden");
                    document.querySelector('.board-content .ThoiGian_TPH').classList.add("hidden");
                    document.querySelector('.board-content .YeuCau').classList.add("hidden");
                    // Ẩn các phần tử button trong form
                    document.querySelector('.board-content .conform-object').classList.add("hidden");
                    // Bỏ thuộc tính disabled của các phần tử 
                    document.querySelector('.board-content .GiangVien input').removeAttribute('disabled');
                    document.querySelector('.board-content .MaLopSV input').removeAttribute('disabled');
                    document.querySelector('.board-content .MonHoc input').removeAttribute('disabled');
                    document.querySelector('.board-content .MaPH input').removeAttribute('disabled');
                    document.querySelector('.board-content .ThoiGian_BD input').removeAttribute('disabled');
                    document.querySelector('.board-content .ThoiGian_KT input').removeAttribute('disabled');
                    document.querySelector('.board-content .MucDich select').removeAttribute('disabled');
                    document.querySelector('.board-content .LyDo input').removeAttribute('disabled');
                    document.querySelector('.board-content .XacNhan input').removeAttribute('disabled');
            
                    // Ẩn phần tử button hướng dẫn
                    document.querySelector('button#openGuide').classList.add("hidden");
            
                }
                // Trường hợp chỉnh sửa thông tin lịch mượn phòng học
                else if( Usecase === 'CTMPH' && UsecasePath === 'SuaTTMPH' ) {
                	
                	// Thiết lập trạng thái của trang
                	isEditing = true
            
                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");
            
                    // Thay đổi nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Chỉnh sửa lịch mượn phòng mã: ${CTLichMPH.idLMPH}";
                    // Ẩn các phần tử button trong nav
                    document.querySelector('.board-bar .update-object').classList.add("hidden");
                    document.querySelector('.board-bar .remove-object').classList.add("hidden");
            
                    // Ẩn các phần tử button trong form
                    document.querySelector('.board-content .DsNgMPH').classList.add("hidden");
                    document.querySelector('.board-content .submit-object').classList.add("hidden");
            
                    // Bỏ thuộc tính disabled của các phần tử
                                        document.querySelector('.board-content .MaPH input').removeAttribute('disabled');
                    document.querySelector('.board-content .ThoiGian_BD input').removeAttribute('disabled');
                    document.querySelector('.board-content .ThoiGian_KT input').removeAttribute('disabled');
                    document.querySelector('.board-content .MucDich select').removeAttribute('disabled');
                    document.querySelector('.board-content .LyDo input').removeAttribute('disabled');
                    document.querySelector('.board-content .YeuCau input').removeAttribute('disabled');
                    document.querySelector('.board-content .XacNhan input').removeAttribute('disabled');
            
                    // Hiện các phần tử button trong form
                    document.querySelector('.board-content .submit').classList.remove("hidden");
                    document.querySelector('.board-content .cancel-object').classList.remove("hidden");
                    document.querySelector('.board-content .conform-object').classList.remove("hidden");
            
                    // Ẩn phần tử button hướng dẫn
                    document.querySelector('button#openGuide').classList.add("hidden");
            
                }
                else {  //Xử lý lỗi ngoại lệ truy cập
                    window.location.href = "../Error.htm?Message= Lỗi UID hoặc Usecase không tìm thấy";
                }
                
            }
            // Trường hợp người sử dụng là người mượn phòng 
            else if ( UIDRegular ) {

                // Trường hợp lập thủ tục mượn phòng học
                if ( Usecase === 'MPH' & UsecasePath === 'MPH' ){
            
                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-regular");
            
                    // Thay đổi nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Thủ tục mượn phòng với mã:  ${CTLichMPH.idLMPH}";
                    // Ẩn các phần tử button trong nav
                    document.querySelector('.board-bar .update-object').classList.add("hidden");
                    document.querySelector('.board-bar .remove-object').classList.add("hidden");
            
                    // Ẩn các phần tử label trong form
                                        document.querySelector('.board-content .TrangThai').classList.add("hidden");
                    document.querySelector('.board-content .LyDo').classList.add("hidden");
                    document.querySelector('.board-content .QuanLyKhoiTao').classList.add("hidden");
                    document.querySelector('.board-content .DoiTuong').classList.add("hidden");
                    document.querySelector('.board-content .QuanLyDuyet').classList.add("hidden");
                    document.querySelector('.board-content .ThoiGian_MPH').classList.add("hidden");
                    document.querySelector('.board-content .ThoiGian_TPH').classList.add("hidden");
                    // Ẩn các phần tử button trong form
                    document.querySelector('.board-content .DsNgMPH').classList.add("hidden");
                    document.querySelector('.board-content .submit-object').classList.add("hidden");
            
                    // Bỏ thuộc tính disabled của các phần tử
                    document.querySelector('.board-content .YeuCau input').removeAttribute('disabled');
                    document.querySelector('.board-content .XacNhan input').removeAttribute('disabled');
            
                }
                // Trường hợp lập thủ tục đổi phòng học
                else if ( Usecase === 'DPH' & UsecasePath === 'DPH' ){
            
                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-regular");
            
                    // Thay đổi nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Thủ tục đổi buổi học";
                    // Ẩn các phần tử button trong nav
                    document.querySelector('.board-bar .update-object').classList.add("hidden");
                    document.querySelector('.board-bar .remove-object').classList.add("hidden");
            
                    // Ẩn các phần tử label trong form
                                        document.querySelector('.board-content .TrangThai').classList.add("hidden");
                    document.querySelector('.board-content .QuanLyKhoiTao').classList.add("hidden");
                    document.querySelector('.board-content .DoiTuong').classList.add("hidden");
                    document.querySelector('.board-content .QuanLyDuyet').classList.add("hidden");
                    document.querySelector('.board-content .ThoiGian_MPH').classList.add("hidden");
                    document.querySelector('.board-content .ThoiGian_TPH').classList.add("hidden");
                    // Ẩn các phần tử button trong form
                    document.querySelector('.board-content .DsNgMPH').classList.add("hidden");
                    document.querySelector('.board-content .submit-object').classList.add("hidden");

                    //Thêm thuộc tính required của các phần tử
                    document.querySelector('.board-content .LyDo input').setAttribute('required', 'required');
            
                    // Bỏ thuộc tính disabled của các phần tử
                    document.querySelector('.board-content .MaPH input').removeAttribute('disabled');
                    document.querySelector('.board-content .ThoiGian_BD input').removeAttribute('disabled');
                    document.querySelector('.board-content .ThoiGian_KT input').removeAttribute('disabled');
                    document.querySelector('.board-content .MucDich select').removeAttribute('disabled');
                    document.querySelector('.board-content .LyDo input').removeAttribute('disabled');
                    document.querySelector('.board-content .YeuCau input').removeAttribute('disabled');
                    document.querySelector('.board-content .XacNhan input').removeAttribute('disabled');
            
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
            document.querySelector('.board-content .MucDich select').value = '${CTLichMPH.mucDich}';
            
        }

        // Gọi hàm settingToUpdateData khi thao tác với nút update-object
        function modifyToUpdateData() {
            // Thay đổi path thứ hai thành 'DSMPH'
            paths[paths.length - 1] = 'SuaTTMPH';

            // Tạo URL mới từ các phần tử đã thay đổi
            let newURL = paths.join('/') + '.htm' + '?' + params.toString();

            window.location.href = newURL;

        }
        function modifyToDeleteData() {

        }
        function submitData() {

        }
        function validateForm() {
            // Lấy giá trị của select
            var selectValue = document.querySelector('.board-content .MucDich select').value;

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

        // Gọi hàm khi trang được load
        document.addEventListener("DOMContentLoaded", function () {
            setUsecases();
            setFormValues();
        });
    </script>
</head>

<body>
    <nav class="board-bar">
        <a class="go-back" href="#" onclick="history.back();">Quay lại</a>
        <h2 class="title">SomeThingError!</h2>
        <button class="update-object hidden" onclick="modifyToUpdateData()">Chỉnh sửa</button>
        <button class="remove-object hidden" onclick="">Xóa</button>
    </nav>
    <main>
        <form class="board-content" onsubmit="return validateForm()">
            <legend>Thông tin lich mượn phòng</legend>
            <label class="GiangVien">
                <span>Giảng viên: </span>
                <input type="text" value="${CTLichMPH.lopHocPhan.giangVien.ttNgMPH.hoTen}${CTLopHocPhan.giangVien.ttNgMPH.hoTen}" disabled>
            </label>
            <label class="MaLopSV">
                <span>Lớp giảng dạy: </span>
                <input type="text" value="${CTLichMPH.lopHocPhan.lopSV.maLopSV}${CTLopHocPhan.lopSV.maLopSV}" disabled>
            </label>
            <label class="MonHoc">
                <span>Tên môn học: </span>
                <input type="text" value="${CTLichMPH.lopHocPhan.monHoc.maMH}${CTLopHocPhan.monHoc.maMH} - ${CTLichMPH.lopHocPhan.monHoc.tenMH}${CTLopHocPhan.monHoc.tenMH}" disabled>
            </label>
                        <label class="MaPH">
                <span>Phòng học: </span>
                <input type="text" name="MaPH" value="${CTLichMPH.phongHoc.maPH}" disabled>
            </label>
            <label class="ThoiGian_BD">
                <span>Thời gian bắt đầu: </span>
                <input type="text" name="ThoiGian_BD" value="${CTLichMPH.thoiGian_BD}" disabled>
            </label>
            <label class="ThoiGian_KT">
                <span>Thời gian kết thúc: </span>
                <input type="text" name="ThoiGian_KT" value="${CTLichMPH.thoiGian_KT}" disabled>
            </label>
            <label class="MucDich">
                <span>Mục đích: </span>
                <select name="MucDich" disabled required>
                	<option value="" disabled selected hidden>Bỏ trống</option>
                	<option value="Học lý thuyết">Học lý thuyết</option>
                	<option value="Học thực hành">Học thực hành</option>
                    <option value="Khác">Khác</option>
                </select>
            </label>	
            <label class="LyDo">
                <span>Lý do: </span>
                <input type="text"  name="LyDo" value="${CTLichMPH.lyDo}" disabled>
            </label>
            <label class="TrangThai">
                <span>Trạng thái: </span>
                <input type="text"  value='${CTLichMPH._DeleteAt != null ? "Đã hủy" 
                                            : LichMPH.muonPhongHoc != null && LichMPH.muonPhongHoc.thoiGian_TPH != "" ? "Đã mượn phòng"
                                            : LichMPH.muonPhongHoc != null && LichMPH.muonPhongHoc.thoiGian_TPH == "" ? "Chưa xác nhận trả phòng"
                                            : "Chưa mượn phòng"}' disabled>
            </label>
            <div class="DsNgMPH">
                <button class="nav-object" type="submit" formaction="#">Danh sách cho phép mượn phòng
                    học</button>
            </div>
            <label class="QuanLyKhoiTao">
                <span>Quản lý tạo lịch mượn phòng: </span>
                <input type="text" value="${QuanLyKhoiTao.maQL} - ${QuanLyKhoiTao.hoTen}" disabled>
            </label>
            <label class="NgMPH">
                <span>Người mượn phòng: </span>
                <input type="text" value="${NgMPH.maNgMPH} - ${NgMPH.hoTen}" disabled>
            </label>
            <label class="DoiTuong">
                <span>Đối tượng mượn phòng: </span>
                <input type="text" value="${NgMPH.doiTuongNgMPH.tenDoiTuongNgMPH}" disabled>
            </label>
            <label class="QuanLyDuyet">
                <span>Quản lý đã duyệt: </span>
                <input type="text" value="${QuanLyDuyet.maQL} - ${QuanLyDuyet.hoTen}" disabled>
            </label>
            <label class="ThoiGian_MPH">
                <span>Thời điểm mượn phòng: </span> 
                <input type="text" value="${CTLichMPH.muonPhongHoc.thoiGian_MPH}" disabled>
            </label>
            <label class="ThoiGian_TPH">
                <span>Thời điểm trả phòng: </span> 
                <input type="text" value="${CTLichMPH.muonPhongHoc.thoiGian_TPH}" disabled>
            </label>
            <label class="YeuCau">
                <span>Yêu cầu thiết bị: </span>
                <input type="text" name="YeuCau" value="${CTLichMPH.muonPhongHoc.yeuCau}" disabled>
            </label>
            <label class="XacNhan">
                <span>Mã xác nhận: </span>
                <input type="text" name="XacNhan" disabled required>
            </label>
            <div class="submit">
                <button class="cancel-object" type="button" onclick="history.back()">Hủy bỏ</button>
                <button id="option-one-id-${CTLichMPH.idLMPH}" class="submit-object" type="submit" formaction="#scriptSet" formmethod="post">Cập nhật</button>
                <script>
                    var tableLink = document.getElementById('option-one-id-${CTLichMPH.idLMPH}');
                    tableLink.setAttribute('formaction', "../${NextUsecaseSubmitOption1}/${NextUsecasePathSubmitOption1}.htm?IdLichMPH=${CTLichMPH.idLMPH}" + "&UID=" + UIDManager + UIDRegular);
                </script>
                <button id="option-two-id-${CTLichMPH.idLMPH}" class="conform-object" type="submit" formaction="#scriptSet" formmethod="post">Xác nhận</button>
                <script>
                    var tableLink = document.getElementById('option-two-id-${CTLichMPH.idLMPH}');
                    tableLink.setAttribute('formaction', "../${NextUsecaseSubmitOption2}/${NextUsecasePathSubmitOption2}.htm?IdLichMPH=${CTLichMPH.idLMPH}" + "&UID=" + UIDManager + UIDRegular);
                </script>
            </div>
        </form>
    </main>
    <button id="openGuide" class="step2" onclick="window.dialog.showModal()">Hướng dẫn</button>
    <%@ include file="../../components/partials/guide-dialog.jsp" %>
</body>

</html>