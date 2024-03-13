<!-- Điều hướng nhận điều kiện:
        UC              -   Usecase sử dụng
        Display         -   UC/Display sử dụng
        Form            -   UC/Form sử dụng
        UIDManager      -   UsecaseID quản lý
    Điều hướng nhận thông tin:
        SearchInput     -   Input tìm kiếm
        SearchOption    -   Option tìm kiếm
        <GiangVien> với thông tin:
            IdGV        -   Id giảng viên
            MaGV        -   Mã giảng viên
            HoTen       -   Họ tên giảng viên
            NgaySinh    -   Ngày sinh
            GioiTinh    -   Giới tính
            Email       -   Email
            SDT         -   Số điện thoại
            ChucDanh    -   Chức danh
-->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Danh sách giảng viên</title>
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
                flex-basis: 100rem;
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
                    color: var(--main-box-color);
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
        table {
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
                td.MaGiangVien,
                td.Email {
                    overflow-wrap: anywhere;
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
            table {
                margin-top: 1rem;
        
                thead tr th {
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
            table {
                margin: 1.5rem;
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
        
            // console.log(UC, Display, Form, UIDManager,UIDRegular)
            // console.log(SearchInput, SearchOption)
            // Trường hợp xem danh sách giảng viên
            if( UIDManager && UC === 'DsGV' && Display === 'DsGV' ) {
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
        <h2>Danh sách giảng viên</h2>
        <form class="filter" action="">
            <input type="search" name="searching" placeholder="Tìm kiếm" disabled>
            <select name="sort">
                <option value="HoTen">Theo họ tên</option>
                <option value="ChucDanh">Theo chức danh</option>
            </select>
            <button type="submit">Lọc</button>
        </form>
        <hr>
        <!-- Sử dụng Usecase với trường hợp sử dụng là xem danh sách mượn phòng học ( Form=ThemTTMPH ) -->
        <a class="nav-object" href="../DsMuonPhongHoc/index.html">Xem danh sách lịch mượn phòng</a>
    </nav>
    <table>
        <thead>
            <tr>
                <th class="MaGV">Mã giảng viên</th>  
                <th class="HoTen">Họ tên giảng viên</th>
                <th class="NgaySinh">Ngày sinh</th>
                <th class="GioiTinh">Giới tính</th>
                <th class="Email">Email</th>
                <th class="SDT">Số điện thoại</th>
                <th class="ChucDanh">Chức danh giảng viên</th> 
            </tr>
        </thead>
        <tbody>
            <!-- <c:forEach var="GiangVien" items="${GiangVien}"> -->
                <!-- Sử dụng Usecase với trường hợp sử dụng là xem danh sách mượn phòng học theo giảng viên 
                    điều hướng với điều kiện: 
                        UC=DsGV
                        Display=DsMPH
                        UIDManager
                        SearchInput=${GiangVien.HoTen}
                        SearchOption=GiangVien
                -->
                <!-- <tr onclick="location.href = '../DsMuonPhongHoc/index.html?UC=${UC}&Display=${Display}&Form=${Form}&UIDManager=${UIDManager}&UIDRegular=${UIDRegular}&SearchInput=${GiangVien.HoTen}&SearchOption=${SearchOption}';">
                    <td class="MaGV">${GiangVien.MaGV}</td>
                    <td class="HoTen">${GiangVien.HoTen}</td>
                    <td class="NgaySinh">${GiangVien.NgaySinh}</td>
                    <td class="GioiTinh">${GiangVien.GioiTinh}</td>
                    <td class="Email">${GiangVien.Email}</td>
                    <td class="SDT">${GiangVien.SDT}</td>
                    <td class="ChucDanh">${GiangVien.ChucDanh}</td>
                </tr> -->
            <!-- </c:forEach> -->

            <!-- Mẫu dữ liệu -->
            <!-- Sử dụng Usecase với trường hợp sử dụng là xem thông tin mượn phòng học ( Display=TTMPH ) -->
            <tr onclick="location.href = '../DsMuonPhongHoc/index.html?UC=DsGV&Display=DsMPH&UIDManager=01435676&SearchInput=Nguy%E1%BB%85n%20Ng%E1%BB%8Dc%20Duy&SearchOption=GiangVien';">
                <td class="MaGV">none</td>
                <td class="HoTen">Nguyễn Ngọc Duy</td>
                <td class="NgaySinh">5/2/1989</td>
                <td class="GioiTinh">Nam</td>
                <td class="Email">duynn@ptithcm.edu.vn</td>
                <td class="SDT">0123456879</td>
                <td class="ChucDanh">Giảng viên chính</td>
            </tr>
            <!-- Sử dụng Usecase với trường hợp sử dụng là xem thông tin mượn phòng học ( Display=TTMPH ) -->
            <tr onclick="location.href = '../DsMuonPhongHoc/index.html?UC=DsGV&Display=DsMPH&UIDManager=01435676&SearchInput=Nguy%E1%BB%85n%20H%E1%BB%AFu%20Vinh&SearchOption=GiangVien';">
                <td class="MaGV">N21DCCN094</td>
                <td class="HoTen">Nguyễn Hữu Vinh</td>
                <td class="NgaySinh">6/7/2003</td>
                <td class="GioiTinh">Nam</td>
                <td class="Email">n21dccn094@ptithcm.edu.vn</td>
                <td class="SDT">0234567891</td>
                <td class="ChucDanh">Trợ giảng</td>
            </tr>
            <tr onclick="location.href = '../DsMuonPhongHoc/index.html?UC=DsGV&Display=DsMPH&UIDManager=01435676&SearchInput=Nguy%E1%BB%85n%20Th%E1%BB%8B%20B%C3%ADch%20Nguy%C3%AAn&SearchOption=GiangVien';">
                <td class="MaGV">none</td>
                <td class="HoTen">Nguyễn Thị Bích Nguyên</td>
                <td class="NgaySinh">8/2/1986</td>
                <td class="GioiTinh">Nữ</td>
                <td class="Email">ntbichnguyen@ptithcm.edu.vn</td>
                <td class="SDT">0345678912</td>
                <td class="ChucDanh">Giảng viên chính</td>
            </tr>
        </tbody>
    </table>
</body>

</html>