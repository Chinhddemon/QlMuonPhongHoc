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
            <DsLichMPH>:
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
    <title>Danh sách mượn phòng học</title>
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

        html {
            font-size: 62.5%;
            overflow-x: hidden;
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
            background-color: var(--bg-color);
            display: flex;
            flex-shrink: 0;
            justify-content: space-between;
            align-items: center;
            box-shadow: 1px 1px 2px black;
            padding: .5rem 2rem;
            gap: 2rem;
            overflow: hidden;

            a {
                font-weight: 500;
                color: var(--text-color);
            }

            a#add-object {
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
                border: 2px solid #162938;
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
                    font-size: 1rem;
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
                    border-left: 2px solid #162938;
                    border-right: 2px solid #162938;
                    cursor: pointer;
                    transition: .1s;
                }

                select:hover {
                    background-color: var(--text-box-color);
                    border-radius: 1rem;
                }

                button {
                    width: 4rem;
                    border-left: 2px solid #162938;
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

        /* boardContent design */
        main {
            table {
                width: 100%;
                overflow: visible;
                cursor: default;

                thead th {
                    background: var(--main-color);
                }

                tbody {
                    tr {
                        transition: .1s;
                    }

                    tr:hover {
                        background-color: var(--main-color);
                    }
                    td.IdLMPH,
                    td.MaLopSV {
                        overflow-wrap: anywhere;
                    }
                    tr.table-row {
                        position: relative;
                        overflow: visible;
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

        @media only screen and (width <=768px) {

            /* Small devices (portrait tablets and large phones, 600px and up to 768px) */
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

                    tbody {
                        td {
                            text-align: center;
                            border-right: .2rem solid var(--main-box-color);
                            border-bottom: .2rem solid var(--main-box-color);
                            font-size: .8rem;
                        }

                        td:last-child {
                            border-right: none;
                        }
                    }
                }
            }
        }

        @media only screen and (768px < width) {

            /* Medium devices (landscape tablets, 768px and up) */
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
                        text-align: center;
                        border-right: .2rem solid var(--main-box-color);
                        border-bottom: .2rem solid var(--main-box-color);
                        font-size: 1.4rem;
                    }
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

        // Lấy thông tin từ params urls
        var SearchInput = params.get('SearchInput')
        var SearchOption = params.get('SearchOption')

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

                // Trường hợp xem danh sách lịch mượn phòng học theo bộ lọc
                if ( Usecase === 'DsMPH' && UsecasePath === 'XemDsMPH' ) {

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

                // Trường hợp lập thủ tục mượn phòng học
                if ( Usecase === 'MPH' && UsecasePath === 'ChonLMPH' ) {

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-regular");

                    // Ẩn các phần tử button trong nav
                    document.querySelector('.board-bar #add-object').classList.add("hidden");

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
			
            if (SearchInput) document.querySelector('.filter input').value = SearchInput;
            if (SearchOption === 'ThoiGian_BD') document.querySelector('.filter option[value="ThoiGian_BD"]').setAttribute('selected', 'selected');
            else if (SearchOption === 'GiangVien') document.querySelector('.filter option[value="GiangVien"]').setAttribute('selected', 'selected');
            else if (SearchOption === 'MaLopSV') document.querySelector('.filter option[value="MaLopSV"]').setAttribute('selected', 'selected');
            else if (SearchOption === 'MucDich') document.querySelector('.filter option[value="MucDich"]').setAttribute('selected', 'selected');
            else document.querySelector('.filter option[value="ThoiGian_BD"]').setAttribute('selected', 'selected');
        }

        function setFormAction() {
            const form = document.querySelector('.filter');
            const tableBody = document.querySelector('tbody');
            
            form.addEventListener('submit', function (event) {
            	sortAction(form, tableBody);
            });
        };
        function sortAction () {
        	const form = document.querySelector('.filter');
        	const tableBody = document.querySelector('tbody');
        	
        	event.preventDefault();
            
            const searchTerm = form.searching.value.toLowerCase();
            const sortByClass = '.' + form.sort.value;

            const rows = Array.from(tableBody.getElementsByTagName('tr'));

            rows.sort((a, b) => {
                const aValue = a.querySelector(sortByClass).textContent.toLowerCase();
                const bValue = b.querySelector(sortByClass).textContent.toLowerCase();

                if (sortByClass === '.ThoiGian_BD') {
                    function parseTimeString(timeString) {
                        const [time, date] = timeString.split(' ');
                        const [hours, minutes] = time.split(':');
                        const [day, month, year] = date.split('/');

                        // Month in JavaScript is 0-based, so we subtract 1
                        return new Date(year, month - 1, day, hours, minutes);
                    }

                    const aTime = parseTimeString(aValue);
                    const bTime = parseTimeString(bValue);

                    return aTime - bTime;
                } else {
                    return aValue.localeCompare(bValue);
                }
            });

            tableBody.innerHTML = '';
            rows.forEach(row => {
                const containsSearchTerm = searchTerm === '' || Array.from(row.children).some(cell => cell.textContent.toLowerCase().includes(searchTerm));
                // Duyệt qua tất cả các ô trong hàng
                Array.from(row.children).forEach((cell, index) => {
                    // Nếu hàng không chứa từ khóa tìm kiếm, ẩn cột đó bằng cách thiết lập style.UsecasePath thành "none"
                    if (!containsSearchTerm) {
                        row.children[index].classList.add("hidden");
                    }
                    else {
                        row.children[index].classList.remove("hidden");
                    }
                });

                // Thêm hàng vào tbody của bảng
                tableBody.appendChild(row)
            });
        }

        // Gọi hàm khi trang được load
        document.addEventListener("DOMContentLoaded", function () {
            setUsecases();
            setFormValues();
            setFormAction();
            sortAction(); 
        });
 
    </script>
</head>

<body>
    <nav class="board-bar">
        <a class="go-back" href="#" onclick="history.back();">Quay lại</a>
        <h2>Danh sách lịch mượn phòng học</h2>
        <form class="filter" action="">
            <input type="search" name="searching" placeholder="Nhập nội dung tìm kiếm">
            <select name="sort">
                <option value="ThoiGian_BD">Theo thời gian</option>
                <option value="GiangVien">Theo giảng viên</option>
                <option value="MaLopSV">Theo lớp học</option>
                <option value="MucDich">Theo loại thủ tục</option>
            </select>
            <button type="submit">Lọc</button>
        </form>
        <hr>
        <a id="add-object" href="scriptSet">Thêm lịch mượn phòng</a>
        <script>
            var tableLink = document.getElementById('add-object');
            tableLink.setAttribute('href', "../CTMPH/ThemTTMPH.htm?" + "&UID=" + UIDManager + UIDRegular);
        </script>
    </nav>
    <main>
        <table>
            <thead>
                <tr>
                    <th class="IdLMPH">Mã lịch mượn phòng</th>
                    <th class="GiangVien">Giảng viên</th>
                    <th class="MaLopSV">Lớp học</th>
                    <th class="MonHoc">Môn học</th>
                    <th class="PhongHoc">Phòng học</th>
                    <th class="ThoiGian_BD">Thời gian mượn</th>
                    <th class="ThoiGian_KT">Thời gian trả</th>
                    <th class="MucDich">Mục đích</th>
                    <th class="TrangThai">Trạng thái</th>
                    <th class="table-option"></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="LichMPH" items="${DsLichMPH}">
                    <tr id='row-click-id-${LichMPH.idLMPH}' class="table-row"> 
                        <td class="IdLMPH">${LichMPH.idLMPH}</td>
                        <td class="GiangVien">${LichMPH.lopHocPhan.giangVien.ttNgMPH.hoTen}</td>
                        <td class="MaLopSV">${LichMPH.lopHocPhan.lopSV.maLopSV}</td>
                        <td class="MonHoc">${LichMPH.lopHocPhan.monHoc.maMH} - ${LichMPH.lopHocPhan.monHoc.tenMH}</td>
                        <td class="MaPH">${LichMPH.phongHoc.maPH}</td>
                        <td class="ThoiGian_BD">${LichMPH.thoiGian_BD}</td>
                        <td class="ThoiGian_KT">${LichMPH.thoiGian_KT}</td>
                        <td class="MucDich">${LichMPH.mucDich}</td>
                        <td class="TrangThai">
                            <c:choose>
                                <c:when test="${LichMPH._DeleteAt != null}">Đã hủy</c:when>
					            <c:when test="${LichMPH.muonPhongHoc != null && LichMPH.muonPhongHoc.thoiGian_TPH != ''}">Đã mượn phòng</c:when>
                                <c:when test="${LichMPH.muonPhongHoc != null && LichMPH.muonPhongHoc.thoiGian_TPH == ''}">Chưa trả phòng</c:when>
					            <c:otherwise>Chưa mượn phòng</c:otherwise>
					        </c:choose>
                        </td>
                        <td id="table-option-id-${LichMPH.idLMPH}" class="table-option">
                            <button id="button-option" type="button">
                                <ion-icon name="ellipsis-vertical-outline"></ion-icon>
                            </button>
                            <div class="hover-dropdown-menu" >
                                <ul class="dropdown-menu" >
                                    <li><a id="option-one-id-${LichMPH.idLMPH}" href="scriptSet">Xem chi tiết</a></li>
                                    <script>
                                        var tableLink = document.getElementById('option-one-id-${LichMPH.idLMPH}');
                                        tableLink.setAttribute('href', "../${NextUsecaseTableOption1}/${NextUsecasePathTableOption1}.htm?IdLichMPH=${LichMPH.idLMPH}" + "&UID=" + UIDManager + UIDRegular);
                                    </script>
                                    <li><a href="#">Lựa chọn ngắn</a></li>
                                    <li><a href="#">Lựa chọn vừa phải </a></li>
                                </ul> 
                            </div>
                        </td>
                    </tr>
                    <script>
                        if("${NextUsecaseTableRowChoose}" != "" && "${NextUsecasePathTableRowChoose}" != "") {
                            var optionLink = document.querySelectorAll('.table-option');
                            for (var i = 0; i < optionLink.length; i++) {
                                optionLink[i].style.display = "none";
                            }
                            var rowLink = document.getElementById('row-click-id-${LichMPH.idLMPH}');
                            rowLink.setAttribute('onclick', "location.href = '../${NextUsecaseTableRowChoose}/${NextUsecasePathTableRowChoose}.htm?IdLichMPH=${LichMPH.idLMPH}" + "&UID=" + UIDManager + UIDRegular + UIDAdmin + "'");
                            rowLink.style.cursor = "pointer";
                        }
                    </script>
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