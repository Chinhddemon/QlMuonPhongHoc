<!-- Điều hướng nhận điều kiện:
        UC              -   Usecase sử dụng
        Display         -   UC/Display sử dụng
        Form            -   UC/Form sử dụng
        UIDManager      -   UsecaseID quản lý
        UIDRegular      -   UsecaseID người mượn phòng
    Điều hướng nhận thông tin:
        SearchInput     -   Input tìm kiếm
        SearchOption    -   Option tìm kiếm
        <DsGV> với thông tin:
            MaLH        -   Mã lớp học
            IdGV        -   Id giảng viên
            GiangVien   -   Họ tên giảng viên
            MaLopSV     -   Mã lớp giảng dạy
            MaMH        -   Mã môn học
            TenMH       -   Tên môn học
            Ngay_BD     -   Kỳ học bắt đầu
            Ngay_KT     -   Kỳ học kết thúc
-->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Danh sách lớp </title>
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
            form.filter {
                position: relative;
                flex-basis: 100rem;
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
                    font-size: 1em;
                    font-weight: 500;
                    color: #162938;
                    padding:  1rem;
                }
                input::placeholder {
                    color: black;
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
        /* boardContent design */
        main {
            table {
                width: 100%;

                thead th {
                    background: var(--main-color);
                    cursor: default;
                }
                tbody {
                    tr{
                        cursor: pointer;
                        transition: .1s;
                    }
                    tr:hover{
                        background-color: var(--main-color);
                    }
                    tr.hidden {
                        display: none;
                    }
                    td.MaLH,
                    td.MaMH,
                    td.MaLopSV {
                        overflow-wrap: anywhere;
                    }
                } 
            }
        } 

        @media only screen and ( width <= 768px) {/* Small devices (portrait tablets and large phones, 600px and up to 768px) */
            /* media boardBar design */
            nav {
                a {
                    font-size: 1.7rem;
                }
                h2 {
                    font-size: 2rem;
                }
            } 
            /* media boardContent design */
            main {
                padding-top: 1rem;
                
                table {
                    thead th {
                        border: .3rem solid var(--main-box-color);
                        border-radius: 1rem;
                        font-size: 1.7rem;
                    }
                    tbody {
                        td {
                            text-align: center;
                            border-right: .2rem solid var(--main-box-color);
                            border-bottom: .2rem solid var(--main-box-color);
                            font-size: 1.5rem;
                        }
                        td:last-child {
                            border-right: none;
                        }
                    } 
                }
            }
        }
        @media only screen and ( 768px < width ) {/* Medium devices (landscape tablets, 768px and up) */
            /* media boardBar design */
            nav {
                a {
                    font-size: 2rem;
                }
                h2 {
                    font-size: 2.2rem;
                }
            } 
            /* media boardContent design */
            main {
                padding: 1.5rem .5rem;

                table {
                    padding: .5rem 0;
                    border: .3rem solid var(--main-box-color);
                    border-radius: 1rem;
                    overflow: hidden;
                    
                    thead th {
                        border: .2rem solid var(--main-box-color);
                        border-radius: .4rem;
                        font-size: 2.1rem;
                    }
                    tbody td {
                        text-align: center;
                        border-right: .2rem solid var(--main-box-color);
                        border-bottom: .2rem solid var(--main-box-color);
                        font-size: 2rem;
                    }
                }
            }
        }
    </style>
    <script>
        function setUsecases() {
            const urlParams = new URLSearchParams(window.location.search);
            
            // Lấy giá trị của các tham số từ URL
            const UC = urlParams.get('UC');
            const Display = urlParams.get('Display');
            const Form = urlParams.get('Form');
            const UIDManager = urlParams.get('UIDManager');
            const UIDRegular = urlParams.get('UIDRegular');
        
            const SearchInput = urlParams.get('SearchInput');
            const SearchOption = urlParams.get('SearchOption');
            console.log(UC, Display, Form, UIDManager,UIDRegular)
                console.log(SearchInput, SearchOption)
            
            // Trường hợp xem danh sách lớp học
            if( UIDManager && UC === 'DsLH' && Display === 'DsLH' ) {
        
                //Tìm tất cả thẻ tr
                const trNav = document.querySelectorAll('table tbody tr')
                for (var i = 0; i < trNav.length; i++) { // Lặp qua từng thẻ tr
                    trNav[i].removeAttribute('onclick'); // Bỏ thuộc tính onclick
                }
        
                // Ẩn phần tử button hướng dẫn
                document.querySelector('button#openGuide').classList.add("hidden");
                
            } 
            //Trường hợp lập thủ tục đổi buổi học
            else if ( UIDRegular && UC === 'DBH' && Display === 'DsLH' ) {
        
                //ByPass
        
            }
            else {
                window.location.href = "../ErrorHandling/index.html";
            }
        }
        
        function sortbyTerm(){
            const form = document.querySelector('.filter');
            const tableBody = document.querySelector('tbody');
        
            form.addEventListener('submit', function (event) {
                event.preventDefault();
        
                const searchTerm = form.searching.value.toLowerCase();
                const sortBy = form.sort.value;
        
                const rows = Array.from(tableBody.getElementsByTagName('tr'));
        
                rows.sort((a, b) => {
                    const aValue = a.querySelector(`.${sortBy}`).textContent.toLowerCase();
                    const bValue = b.querySelector(`.${sortBy}`).textContent.toLowerCase();
        
                    return aValue.localeCompare(bValue);
                });
        
                tableBody.innerHTML = '';
                rows.forEach(row => {
                    const containsSearchTerm = searchTerm === '' || Array.from(row.children).some(cell => cell.textContent.toLowerCase().includes(searchTerm));
                    if (containsSearchTerm) {
                        tableBody.appendChild(row);
                    }
                });
            });
        }
        
        document.addEventListener("DOMContentLoaded", function () {
            setUsecases();
            sortbyTerm();
        });
    </script>
</head>

<body>
    <nav class="board-bar">
        <a class="go-home" href="../Login/index.html?UIDManager=${UIDManager}&UIDRegular=${UIDRegular}" target="_parent">Trang chủ</a>
        <h2>Danh sách lớp học</h2>
        <form class="filter" action="">
            <input type="search" name="searching" placeholder="Tìm kiếm" disabled>
            <select name="sort">
                <option value="GiangVien">Theo giảng viên</option>
                <option value="MaLopSV">Theo lớp giảng dạy</option>
                <option value="TenMH">Theo tên môn học</option>
            </select>
            <button type="submit">Lọc</button>
        </form>
        <!-- Sử dụng Usecase với trường hợp sử dụng là thêm thông tin mượn phòng học ( Form=ThemTTMPH ) -->
        <a class="nav-object" href="../DsMuonPhongHoc/index.html?UC=DsMPH&Display=DsMPH&UIDManager=${UIDManager}">Xem danh sách lịch mượn phòng</a>
    </nav>
    <main>
        <table>
            <thead>
                <tr>
                    <th class="MaLH">Mã lớp học</th>
                    <th class="GiangVien">Giảng viên giảng dạy</th> 
                    <th class="MaLopSV">Lớp giảng dạy</th>
                    <th class="MaMH">Mã môn học</th>
                    <th class="TenMH">Tên môn học</th>
                    <th class="Ngay_BD">Kỳ học bắt đầu</th>
                    <th class="Ngay_KT">Kỳ học kết thúc</th>
                </tr>
            </thead>
            <tbody>
                <!-- <c:forEach var="LopHoc" items="${DsLopHoc}"> -->
                    <!--  Sử dụng Usecase với trường hợp sử dụng là cung cấp thông tin đổi buổi học 
                        điều hướng với điều kiện: 
                            UC=DBH
                            Display=TTDBH
                            UIDRegular
                        điều hướng với thông tin:
                            MaLH=${LopHoc.MaLH}
                            IdGV==${LopHoc.IdGV}
                            GiangVien=${LopHoc.GiangVien}
                            MaLopSV=${LopHoc.MaLopSV}
                            MaMH=${LopHoc.MaMH}
                            TenMH=${LopHoc.MaMH}     
                    -->
                    <!-- <tr onclick="location.href = '../TTMuonPhongHoc/index.html?UC=DBH&Display=TTDBH&UIDRegular=${UIDRegular}&MaLH=${LopHoc.MaLH}&GiangVien=${LopHoc.GiangVien}&MaLopSV=${LopHoc.MaLopSV}&MaMH=${LopHoc.MaMH}&TenMH=${LopHoc.TenMH}';">
                        <td class="MaLH">${LopHoc.MaLH}</td>
                        <td class="MaMH">${LopHoc.MaMH}</td>
                        <td class="TenMH">${LopHoc.TenMH}</td>
                        <td class="GiangVien">${LopHoc.GiangVien}</td>
                        <td class="MaLopSV">${LopHoc.MaLopSV}</td>
                        <td class="Ngay_BD">${LopHoc.Ngay_BD}</td>
                        <td class="Ngay_KT">${LopHoc.Ngay_KT}</td>
                    </tr>
                </c:forEach> -->

                <!-- Mẫu dữ liệu -->
                <tr onclick="location.href = '../TTMuonPhongHoc/index.html?UC=DBH&Display=TTDBH&UIDRegular=${UIDRegular}&MaLH=L123&GiangVien=Nguy%E1%BB%85n%20%C4%90%E1%BB%A9c%20Th%E1%BB%8Bnh&MaLopSV=D22CQCN01-N&MaMH=INT1359-3&TenMH=To%C3%A1n%20r%E1%BB%9Fi%20r%E1%BA%A1c%202';">
                    <td class="MaLH">L123</td>
                    <td class="GiangVien">Nguyễn Đức Thịnh</td>
                    <td class="MaLopSV">D22CQCN01-N</td>
                    <td class="MaMH">INT1359-3</td>
                    <td class="TenMH">Toán rời rạc 2</td>
                    <td class="Ngay_BD">01/03/2024</td>
                    <td class="Ngay_KT">10/05/2024</td>
                </tr>
                <!-- Sử dụng Usecase với trường hợp sử dụng là xem thông tin mượn phòng học ( Display=TTMPH ) -->
                <tr onclick="location.href = '../TTMuonPhongHoc/index.html?UC=DBH&Display=TTDBH&UIDRegular=${UIDRegular}&MaLH=L124&GiangVien=Nguy%E1%BB%85n%20Ng%E1%BB%8Dc%20Duy&MaLopSV=D21CQAT01-N&MaMH=INT1341&TenMH=Nh%E1%BA%ADp%20m%C3%B4n%20tr%C3%AD%20tu%E1%BB%87%20nh%C3%A2n%20t%E1%BA%A1o';">
                    <td class="MaLH">L124</td>
                    <td class="GiangVien">Nguyễn Ngọc Duy</td>
                    <td class="MaLopSV">D21CQAT01-N</td>
                    <td class="MaMH">INT1341</td>
                    <td class="TenMH">Nhập môn trí tuệ nhân tạo</td>
                    <td class="Ngay_BD">11/01/2024</td>
                    <td class="Ngay_KT">04/04/2024</td>
                </tr>
                <tr onclick="location.href = '../TTMuonPhongHoc/index.html?UC=DBH&Display=TTDBH&UIDRegular=${UIDRegular}&MaLH=L125&GiangVien=Nguy%E1%BB%85n%20Th%E1%BB%8B%20B%C3%ADch%20Nguy%C3%AAn&MaLopSV=D21CQCN01-N&MaMH=INT1340&TenMH=Nh%E1%BA%ADp%20m%C3%B4n%20c%C3%B4ng%20ngh%E1%BB%87%20ph%E1%BA%A7n%20m%E1%BB%81m';">
                    <td class="MaLH">L125</td>
                    <td class="GiangVien">Nguyễn Thị Bích Nguyên</td>
                    <td class="MaLopSV">D21CQCN01-N</td>
                    <td class="MaMH">INT1340</td>
                    <td class="TenMH">Nhập môn công nghệ phần mềm</td>
                    <td class="Ngay_BD">09/01/2024</td>
                    <td class="Ngay_KT">02/04/2024</td>
                </tr>
            </tbody>
        </table>
    </main>
    <button id="openGuide" onclick="window.dialog.showModal()">Hướng dẫn</button>
    <dialog id="dialog">
        <form method="dialog">
            <div>Hướng dẫn</div>
            <p>
                <b>1. Chọn lớp học mà sinh viên, giảng viên cần mượn phòng giảng dạy.</b><br>
                2. Cung cấp thêm thông tin mượn phòng để quản lý duyệt. <br>
                3. Chờ quản lý kiểm tra thông tin và nhận đồ xài :&gt;
            </p>
            <button id="closeGuide">Close</button>
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