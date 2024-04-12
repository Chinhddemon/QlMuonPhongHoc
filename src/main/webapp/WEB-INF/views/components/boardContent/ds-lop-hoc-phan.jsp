<!--
    Dữ liệu tiếp nhận:
        URL:
            Paths:
                Usecase         -   Usecase sử dụng
                UsecasePath     -   UsecasePath sử dụng
            Params:
                SearchInput     -   Input tìm kiếm
                SearchOption    -   Option tìm kiếm
        Controller:
            NextUsecaseTable       -   Usecase chuyển tiếp trong table
            NextUsecasePathTable   -   UsecasePath chuyển tiếp trong table
            <DsLopHocPhanSection>:
        SessionStorage:
            UIDManager
            UIDRegular
Chuẩn View URL truy cập:   ../${Usecase}/${UsecasePath}.htm?SearchInput=${SearchInput}&SearchOption=${SearchOption}
-->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Danh sách lớp</title>
    <!-- MARK: STYLE -->
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
        /* MARK: boardBar design */
        nav {
            background: var(--bg-color);
            display: flex;
            flex-shrink: 0;
            justify-content: space-between;
            align-items: center;
            box-shadow: 1px 1px 2px var(--main-box-color);
            padding: .5rem 2rem;
            gap: 2rem;
            overflow: hidden;

            a {
                font-weight: 500;
                color: var(--text-color);
            }
            a.add-object {
                text-align: end;
            }
            h2 {
                cursor: default;
            }
            form {
                position: relative;
                flex-basis: 50rem;
                width: 100%;
                height: auto;
                display: flex;
                border: 2px solid var(--main-box-color);
                border-radius: .7rem;
                gap: 1rem;
                overflow: hidden;

                input {
                    flex-grow: 10;
                    min-width: 2rem;
                    height: 100%;
                    background: transparent;
                    border: none;
                    outline: none;
                    font-size: 1em;
                    font-weight: 500;
                    color: #162938;
                    padding: .7rem;
                }
                input::placeholder {
                    color: black;
                }
                input:-webkit-autofill { 
                    -webkit-background-clip: text;
                }
                select {
                    border-left: 2px solid var(--main-box-color);
                    border-right: 2px solid var(--main-box-color);
                    cursor: pointer;
                    transition: .1s; 
                }
                select:hover {
                    background-color: var(--text-box-color);
                    border-radius: 1rem;
                }
                button {
                    width: 4rem;
                    border-left: 2px solid var(--main-box-color);
                    cursor: pointer;
                    transition: .1s;
                }
                button:hover {
                    width: 5rem;
                    background-color: var(--text-box-color);
                    border-top-left-radius: 1rem;
                    border-bottom-left-radius: 1rem;
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
            table {
                width: 100%;
                overflow: visible;
                cursor: default;

                thead th {
                    background: var(--main-color);
                }
                tbody {
                    tr{
                        transition: .1s;
                    }
                    tr.table-row {
                        position: relative;
                        overflow: visible;
                    }
                    td {
                        text-align: center;
                        border-right: .2rem solid var(--main-box-color);
                        border-bottom: .2rem solid var(--main-box-color);
                    }
                    td.IdLHP,
                    td.MonHoc,
                    td.LopSV {
                        overflow-wrap: anywhere;
                    }
                    td.table-option {
                        font-size: 3rem;

                        button {
                            background: transparent;
                            cursor: pointer;

                            ion-icon {
                                font-size: 2rem;
                            }
                        }
                        div {
                            position: absolute;
                            top: -2rem;
                            right: 2rem;
                            height: auto;
                            display: flex;
                            padding: 1rem;
                            transform-origin: top;
                            transform: scale(1, 0);
                            transition: .2s;
                            z-index: 1;

                            ul {
                                
                                background: var(--second-bg-color);
                                border: .1rem solid var(--text-color);
                                border-radius: .3rem;
                                display: flex;
                                flex-direction: column;
                                padding: .5rem;
                                li {
                                    background: var(--second-bg-color);
                                    width: max-content;
                                    display: inline-flex;
                                    overflow: visible;
                                    z-index: 1;

                                    a {
                                        font-weight: 500;
                                        color: var(--text-color);
                                    }
                                }
                            }
                            
                        }
                        button:hover ~ div,
                        div:hover {
                            transform: scale(1, 1);
                        }
                    }
                } 
            }
        } 

        @media only screen and ( width <= 768px) {/* Small devices (portrait tablets and large phones, 600px and up to 768px) */
            /* media boardBar design */
            nav {
                a {
                    font-size: 1rem;
                }
                h2 {
                    font-size: 1.3rem;
                }
            } 
            /* media boardContent design */
            main {
                padding-top: 1rem;
                
                table {
                    thead th {
                        border: .3rem solid var(--main-box-color);
                        border-radius: 1rem;
                        font-size: 1rem;
                    }
                    tbody td {
                        font-size: .8rem;
                    }
                }
            }
        }
        @media only screen and ( 768px < width ) {/* Medium devices (landscape tablets, 768px and up) */
            /* media boardBar design */
            nav {
                a {
                    font-size: 1.4rem;
                }
                h2 {
                    font-size: 1.8rem;
                }
            } 
            /* media boardContent design */
            main {
                padding: 1.5rem .5rem;

                table {
                    padding: .5rem 0;
                    border: .3rem solid var(--main-box-color);
                    border-radius: 1rem;
                    
                    thead th {
                        border: .2rem solid var(--main-box-color);
                        border-radius: .4rem;
                        font-size: 1.8rem;
                    }
                    tbody td {
                        font-size: 1.4rem;
                    }
                }
            }
        }
    </style>
    <!-- MARK:SCRIPT -->
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

        // Lấy thông tin từ params urls
        var SearchInput = params.get('SearchInput');
        var SearchOption = params.get('SearchOption');

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
            // Trường hợp người sử dụng là quản lý
            else if ( UIDManager ) {

                // Trường hợp xem danh sách lớp học theo bộ lọc
                if (Usecase === 'DsLHP' && UsecasePath === 'XemDsLHP') {

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");
                    

                    // Ẩn phần tử button hướng dẫn
                    document.querySelector('button#openGuide').classList.add("hidden");

                } else if (Usecase === 'DsLHP' && UsecasePath === 'ThemTTMPH') {

                    // Thay đổi nội dung của các thẻ trong nav
                    document.querySelector('.board-bar h2.title').textContent = "Thêm lịch mượn phòng học";
                    
                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");

                    // Ẩn phần tử button hướng dẫn
                    document.querySelector('button#openGuide').classList.add("hidden");
                }
                else {  //Xử lý lỗi ngoại lệ truy cập
                	window.location.href = "../Error.htm?Message= Lỗi UID hoặc Usecase không tìm thấy";
                }

            }
            // Trường hợp người sử dụng là người mượn phòng 
            else if ( UIDRegular ) {
            
                //Trường hợp lập thủ tục đổi buổi học
                if (Usecase === 'DPH' && UsecasePath === 'ChonLHP') {

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-regular");

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
			
            if (SearchInput) document.querySelector('.filter input').value = SearchInput;
            if (SearchOption === 'GiangVien') document.querySelector('.filter option[value="GiangVien"]').setAttribute('selected', 'selected');
            else if (SearchOption === 'Ngay_BD') document.querySelector('.filter option[value="Ngay_BD"]').setAttribute('selected', 'selected');
            else document.querySelector('.filter option[value="GiangVien"]').setAttribute('selected', 'selected');
            
        }
        // MARK: setFormAction
		function setFormAction() {
            const form = document.querySelector('.filter');
            const tableBody = document.querySelector('tbody');
            
            form.addEventListener('submit', function (event) {
            	sortAction(form, tableBody);
            });
        };
        // MARK: sortAction
        function sortAction() {
            const form = document.querySelector('.filter');
            const tableBody = document.querySelector('tbody');
        
            event.preventDefault();
        
            const searchTerm = form.searching.value.toLowerCase();
            const sortByClass = '.' + form.sort.value;
        
            const rows = Array.from(tableBody.getElementsByTagName('tr'));
        
            rows.sort((a, b) => {
                const aValue = a.querySelector(sortByClass).textContent.toLowerCase();
                const bValue = b.querySelector(sortByClass).textContent.toLowerCase();
        
                return aValue.localeCompare(bValue);
            });
         
            tableBody.innerHTML = '';
            rows.forEach(row => {
                const containsSearchTerm = searchTerm === '' || Array.from(row.children).some(cell => cell.textContent.toLowerCase().includes(searchTerm));
                // Duyệt qua tất cả các ô trong hàng
                Array.from(row.children).forEach((cell, index) => {
                    // Nếu hàng không chứa từ khóa tìm kiếm, ẩn cột đó bằng cách thiết lập style.UsecasePath thành "none"
                    if (!containsSearchTerm) {
                        row.children[index].classList.add("hidden");
                    } else {
                        row.children[index].classList.remove("hidden");
                    }
                });
        
                // Thêm hàng vào tbody của bảng
                tableBody.appendChild(row);
            });
        }

     	// Gọi hàm khi trang được load
        // MARK: DOMContentLoaded
        document.addEventListener("DOMContentLoaded", function () {
            setUsecases();
            setFormValues();
            // setFormAction();
            // sortAction(); 
        });
        
        
    </script>
</head>

<body>
    <!-- MARK: boardbar -->
    <nav class="board-bar">
        <a class="go-back" href="#" onclick="history.back();">Quay lại</a>
        <h2 class="title">Danh sách lớp học</h2>
        <form class="filter" action="">
            <input type="search" name="searching" placeholder="Nhập nội dung tìm kiếm">
            <select name="sort">
                <option value="GiangVien">Theo giảng viên</option>
                <option value="Ngay_BD">Theo thời gian</option>
            </select>
            <button type="submit">Lọc</button>
        </form>
        <hr>
    </nav>
    <!-- MARK: boardcontent -->
    <main>
        <table>
            <thead>
                <tr>
                    <th class="IdLHP">Mã lớp</th>
                    <th class="MonHoc">Mã môn học</th>
                    <th class="TenMonHoc">Tên môn học</th>
                    <th class="NhomTo">Nhóm tổ</th>
                    <th class="LopSV">Lớp giảng dạy</th>
                    <th class="GiangVien">Giảng viên</th>
                    <th class="Ngay_BD">Giai đoạn bắt đầu</th>
                    <th class="Ngay_KT">Giai đoạn kết thúc</th>
                    <th class="table-option"></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="LopHocPhan" items="${DsLopHocPhan}">
                    <tr id='row-click-id-${LopHocPhan.idLHP}${LopHocPhan.lopHocPhanSections[0].idLHPSection}' class="table-row"> 
                        <td class="IdLHP" rowspan="${LopHocPhan.lopHocPhanSections[1] != null ? 2 : 1}">
                            ${LopHocPhan.idLHP}
                        </td>
                        <td class="MonHoc" rowspan="${LopHocPhan.lopHocPhanSections[1] != null ? 2 : 1}">
                            ${LopHocPhan.monHoc.maMH}
                        </td>
			            <td class="TenMonHoc" rowspan="${LopHocPhan.lopHocPhanSections[1] != null ? 2 : 1}">
                            ${LopHocPhan.monHoc.tenMH}
                        </td>
                        <td class="NhomTo" rowspan="${LopHocPhan.lopHocPhanSections[1] != null ? 2 : 1}">
                            ${LopHocPhan.nhom}
                            <c:forEach var="LopHocPhanSection" items="${LopHocPhan.lopHocPhanSections}">
                                <c:if test="${LopHocPhanSection.nhomTo != ''}"> 
                                    - ${LopHocPhanSection.nhomTo}
                                </c:if>
                            </c:forEach>
                        </td>
                        <td class="LopSV" rowspan="${LopHocPhan.lopHocPhanSections[1] != null ? 2 : 1}">
                            ${LopHocPhan.lopSV.maLopSV}
                        </td>
                        <td class="GiangVien">
                            ${LopHocPhan.lopHocPhanSections[0].giangVien.ttNgMPH.hoTen}
                        </td>
			            <td class="Ngay_BD">
                            ${LopHocPhan.lopHocPhanSections[0].ngay_BD}
                        </td>
			            <td class="Ngay_KT">
                            ${LopHocPhan.lopHocPhanSections[0].ngay_KT}
                        </td>
                        <!-- Nếu không có Usecase và UsecasePath thích hợp chuyển tiếp, hiển thị button option -->
                        <c:if test="${NextUsecaseTableRowChoose == null && NextUsecasePathTableRowChoose == null}">
                            <td id="table-option-id-${LopHocPhan.idLHP}" class="table-option"  rowspan="${LopHocPhan.lopHocPhanSections[1] != null ? 2 : 1}">
                                <button id="button-option" type="button">
                                    <ion-icon name="ellipsis-vertical-outline"></ion-icon>
                                </button>
                                <div class="hover-dropdown-menu" >
                                    <ul class="dropdown-menu" >
                                        <li><a id="option-one-id-${LopHocPhan.idLHP}" href="#scriptSet452436">
                                            Xem chi tiết học phần
                                        </a></li>
                                        <li><a id="option-two-id-${LopHocPhan.idLHP}" href="#scriptSet653275">
                                            Sửa thông tin học phần
                                        </a></li>
                                        <li><a id="option-three-id-${LopHocPhan.idLHP}" href="#scriptSet553535">
                                            Xóa thông tin học phần
                                        </a></li>
                                        <li><a id="option-four-id-${LopHocPhan.idLHP}" href="#scriptSet195728">
                                            Xem lịch mượn phòng theo học phần
                                        </a></li>
                                        
                                    </ul> 
                                </div>                
                            </td>
                            <script id="scriptSet452436">
                                var tableLink = document.getElementById('option-one-id-${LopHocPhan.idLHP}');
                                tableLink.setAttribute('href', "../${NextUsecaseTableOption1}/${NextUsecasePathTableOption1}.htm?IdLHP=${LopHocPhan.idLHP}&SearchInput=${LopHocPhan.lopSV.maLopSV}&SearchOption=LopSV" + "&UID=" + UIDManager + UIDRegular);
                            </script>
                            <script id="scriptSet653275">
                                var tableLink = document.getElementById('option-two-id-${LopHocPhan.idLHP}');
                                tableLink.setAttribute('href', "../${NextUsecaseTableOption2}/${NextUsecasePathTableOption2}.htm?IdLHP=${LopHocPhan.idLHP}&SearchInput=${LopHocPhan.lopSV.maLopSV}&SearchOption=LopSV" + "&UID=" + UIDManager + UIDRegular);
                            </script>
                            <script id="scriptSet553535">
                                var tableLink = document.getElementById('option-three-id-${LopHocPhan.idLHP}');
                                tableLink.setAttribute('href', "../${NextUsecaseTableOption3}/${NextUsecasePathTableOption3}.htm?IdLHP=${LopHocPhan.idLHP}&SearchInput=${LopHocPhan.lopSV.maLopSV}&SearchOption=LopSV" + "&UID=" + UIDManager + UIDRegular);
                            </script>
                            <script id="scriptSet195728">
                                var tableLink = document.getElementById('option-four-id-${LopHocPhan.idLHP}');
                                tableLink.setAttribute('href', "../${NextUsecaseTableOption4}/${NextUsecasePathTableOption4}.htm?IdLHP=${LopHocPhan.idLHP}&SearchInput=${LopHocPhan.lopSV.maLopSV}&SearchOption=LopSV" + "&UID=" + UIDManager + UIDRegular);
                            </script>
                        </c:if>
			        </tr>
                    <script>
                        {
                            // Hiệu ứng khi rê chuột vào hàng
                            var row0GiangVienLink = document.querySelector('#row-click-id-${LopHocPhan.idLHP}${LopHocPhan.lopHocPhanSections[0].idLHPSection} .GiangVien');
                            var row0NgayBDLink = document.querySelector('#row-click-id-${LopHocPhan.idLHP}${LopHocPhan.lopHocPhanSections[0].idLHPSection} .Ngay_BD');
                            var row0NgayKTLink = document.querySelector('#row-click-id-${LopHocPhan.idLHP}${LopHocPhan.lopHocPhanSections[0].idLHPSection} .Ngay_KT');
                            function row0MouseOver() {
                                document.querySelector('#row-click-id-${LopHocPhan.idLHP}${LopHocPhan.lopHocPhanSections[0].idLHPSection} .GiangVien').style.backgroundColor = "var(--main-color)";
                                document.querySelector('#row-click-id-${LopHocPhan.idLHP}${LopHocPhan.lopHocPhanSections[0].idLHPSection} .Ngay_BD').style.backgroundColor = "var(--main-color)";
                                document.querySelector('#row-click-id-${LopHocPhan.idLHP}${LopHocPhan.lopHocPhanSections[0].idLHPSection} .Ngay_KT').style.backgroundColor = "var(--main-color)";
                            }
                            function row0MouseOut() {
                                document.querySelector('#row-click-id-${LopHocPhan.idLHP}${LopHocPhan.lopHocPhanSections[0].idLHPSection} .GiangVien').style.backgroundColor = "";
                                document.querySelector('#row-click-id-${LopHocPhan.idLHP}${LopHocPhan.lopHocPhanSections[0].idLHPSection} .Ngay_BD').style.backgroundColor = "";
                                document.querySelector('#row-click-id-${LopHocPhan.idLHP}${LopHocPhan.lopHocPhanSections[0].idLHPSection} .Ngay_KT').style.backgroundColor = "";
                            }
                            function handleMouseEvents(element) {
                                element.addEventListener("mouseover", function() {  
                                    row0MouseOver();
                                });
                                element.addEventListener("mouseout", function() {
                                    row0MouseOut();
                                });
                            }
                            handleMouseEvents(row0GiangVienLink);
                            handleMouseEvents(row0NgayBDLink);
                            handleMouseEvents(row0NgayKTLink);

                            // Chuyển hướng khi click vào hàng, nếu có Usecase và UsecasePath thích hợp chuyển tiếp
                            if("${NextUsecaseTableRowChoose}" !== "" && "${NextUsecasePathTableRowChoose}" !== "") { 
                            
                                row0GiangVienLink.setAttribute('onclick', "location.href = '../${NextUsecaseTableRowChoose}/${NextUsecasePathTableRowChoose}.htm?IdLHP=${LopHocPhan.idLHP}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin + "'");
                                row0NgayBDLink.setAttribute('onclick', "location.href = '../${NextUsecaseTableRowChoose}/${NextUsecasePathTableRowChoose}.htm?IdLHP=${LopHocPhan.idLHP}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin + "'");
                                row0NgayKTLink.setAttribute('onclick', "location.href = '../${NextUsecaseTableRowChoose}/${NextUsecasePathTableRowChoose}.htm?IdLHP=${LopHocPhan.idLHP}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin + "'");
                                row0GiangVienLink.style.cursor = "pointer";
                                row0NgayBDLink.style.cursor = "pointer";
                                row0NgayKTLink.style.cursor = "pointer";
                                
                                if("${LopHocPhan.lopHocPhanSections[1]}" !== "") {
                                    row1Link.setAttribute('onclick', "location.href = '../${NextUsecaseTableRowChoose}/${NextUsecasePathTableRowChoose}.htm?IdLHP=${LopHocPhan.idLHP}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin + "'");
                                    row1Link.style.cursor = "pointer";
                                }
                            }
                        }
                    </script>
                    <!-- Nếu có 2 lớp học phần, thêm hàng thứ 2 -->
                    <c:if test="${LopHocPhan.lopHocPhanSections[1] != null}">
                        <tr id='row-click-id-${LopHocPhan.idLHP}${LopHocPhan.lopHocPhanSections[1].idLHPSection}' class="table-row"> 
                            <td class="GiangVien">${LopHocPhan.lopHocPhanSections[1].giangVien.ttNgMPH.hoTen}</td>
                            <td class="Ngay_BD">${LopHocPhan.lopHocPhanSections[1].ngay_BD}</td>
                            <td class="Ngay_KT">${LopHocPhan.lopHocPhanSections[1].ngay_KT}</td>
                        </tr>
                        <script>
                            {
                                // Hiệu ứng khi rê chuột vào hàng
                                var row1Link = document.querySelector('#row-click-id-${LopHocPhan.idLHP}${LopHocPhan.lopHocPhanSections[1].idLHPSection}');

                                row1Link.addEventListener("mouseover", function() {
                                    this.style.backgroundColor = "var(--main-color)";
                                });
                                row1Link.addEventListener("mouseout", function() {
                                    this.style.backgroundColor = "";
                                });
                                // Chuyển hướng khi click vào hàng, nếu có Usecase và UsecasePath thích hợp chuyển tiếp
                                if("${NextUsecaseTableRowChoose}" !== "" && "${NextUsecasePathTableRowChoose}" !== "") {
                                    var row0Link = document.querySelector('#row-click-id-${LopHocPhan.idLHP}${LopHocPhan.lopHocPhanSections[0].idLHPSection}');
                                    row0Link.setAttribute('onclick', "location.href = '../${NextUsecaseTableRowChoose}/${NextUsecasePathTableRowChoose}.htm?IdLHP=${LopHocPhan.idLHP}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin + "'");
                                    row0Link.style.cursor = "pointer";
                                }
                            }
                        </script>
                    </c:if>
			    </c:forEach>
            </tbody>
        </table>
    </main>	
    <button id="openGuide" class="step1" onclick="window.dialog.showModal()">Hướng dẫn</button>
    <%@ include file="../../components/partials/guide-dialog.jsp" %>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>

</html>