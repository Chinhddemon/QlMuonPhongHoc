<!-- 
Controller: 
Điều hướng nhận điều kiện:
Usecase         -   Usecase sử dụng
UsecasePath     -   UsecasePath sử dụng
UIDManager      -   UsecaseID quản lý
Điều hướng nhận thông tin:
SearchInput     -   Input tìm kiếm
SearchOption    -   Option tìm kiếm
<GiangVien> với thông tin:
    IdGV        -   Id giảng viên
    HoTen       -   Họ tên giảng viên
    NgaySinh    -   Ngày sinh
    GioiTinh    -   Giới tính
    Email       -   Email
    SDT         -   Số điện thoại
    MaGV        -   Mã giảng viên
    ChucDanh    -   Chức danh
Xử lý điều kiện truy cập:
NextUsecase-Table       -   Usecase chuyển tiếp trong table
NextUsecasePath-Table   -   UsecasePath chuyển tiếp trong table
Chuẩn View URL truy cập:   ../${Usecase}/${UsecasePath}.htm?SearchInput=${SearchInput}&SearchOption=${SearchOption}
-->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
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
                    font-size: 1rem;
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
            table {
                margin-top: 1rem;

                thead tr th {
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
            table {
                margin: 1.5rem;
                padding: .5rem 0;
                border: .3rem solid var(--main-box-color);
                border-radius: 1rem;
                overflow: hidden;

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

        // Tạo dynamic memory cho paths
        var LastUsecase = null
        var LastUsecasePath = null

        // Lấy thông tin từ params urls
        var SearchInput = params.get('SearchInput')
        var SearchOption = params.get('SearchOption')

        // Lấy giá trị của các tham số từ sessionScope
        var UIDManager = sessionStorage.getItem('UIDManager');
        var UIDRegular = sessionStorage.getItem('UIDRegular');

        // In ra console để kiểm tra
        //console.log(Usecase, UsecasePath, UIDManager,UIDRegular)
        //console.log(SearchInput, SearchOption)

        function setUsecases() {

            // Trường hợp xem danh sách giảng viên
            if (UIDManager && Usecase === 'DsGV' && UsecasePath === 'XemDsGV') {

                // Chỉnh sửa phần tử nav theo Usecase
                document.querySelector('.board-bar').classList.add("menu-manager");

            }
            else {
                window.location.href = "../ErrorHandling/index.html";
            }
        }

        function sortbyTerm() {
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
        <!-- URL sử dụng trong controller -->
        <!-- <a class="go-home" href="../Home.htm" target="_parent">Trang chủ</a> -->
        <a class="go-home" href="../Login/index.html?UIDManager=${UIDManager}&UIDRegular=${UIDRegular}"
            target="_parent">Trang chủ</a>
        <h2>Danh sách giảng viên</h2>
        <form class="filter" action="">
            <input type="search" name="searching" placeholder="Nhập nội dung tìm kiếm">
            <select name="sort">
                <option value="HoTen">Theo họ tên</option>
                <option value="ChucDanh">Theo chức danh</option>
            </select>
            <button type="submit">Lọc</button>
        </form>
        <hr>
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
            <!-- Sử dụng Usecase với trường hợp sử dụng là xem danh sách mượn phòng học theo giảng viên 
    điều hướng với điều kiện: 
        NextUsecase-Table=DsMPH
        NextUsecasePath-Table=DsMPH
        UIDManager
        SearchInput=${GiangVien.HoTen}
        SearchOption=GiangVien
-->
            <!-- URL sử dụng trong controller -->
            <!-- <c:forEach var="GiangVien" items="${GiangVien}"> -->
            <!-- <tr onclick="location.href = '../${NextUsecase-Table}/${NextUsecasePath-Table}.htm?SearchInput=${SearchInput}&SearchOption=${SearchOption}';">
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
            <!-- Sử dụng Usecase với trường hợp sử dụng là xem danh sách mượn phòng học theo giảng viên  -->
            <tr
                onclick="location.href = '../DsMuonPhongHoc/index.html?Usecase=DsMPH&Display=XemDsMPH&UIDManager=01435676&SearchInput=Nguy%E1%BB%85n%20Ng%E1%BB%8Dc%20Duy&SearchOption=GiangVien';">
                <td class="MaGV">none</td>
                <td class="HoTen">Nguyễn Ngọc Duy</td>
                <td class="NgaySinh">5/2/1989</td>
                <td class="GioiTinh">Nam</td>
                <td class="Email">duynn@ptithcm.edu.vn</td>
                <td class="SDT">0123456879</td>
                <td class="ChucDanh">Giảng viên chính</td>
            </tr>
            <!-- Sử dụng Usecase với trường hợp sử dụng là xem danh sách mượn phòng học theo giảng viên  -->
            <tr
                onclick="location.href = '../DsMuonPhongHoc/index.html?Usecase=DsMPH&Display=XemDsMPH&UIDManager=01435676&SearchInput=Nguy%E1%BB%85n%20H%E1%BB%AFu%20Vinh&SearchOption=GiangVien';">
                <td class="MaGV">N21DCCN094</td>
                <td class="HoTen">Nguyễn Hữu Vinh</td>
                <td class="NgaySinh">6/7/2003</td>
                <td class="GioiTinh">Nam</td>
                <td class="Email">n21dccn094@ptithcm.edu.vn</td>
                <td class="SDT">0234567891</td>
                <td class="ChucDanh">Trợ giảng</td>
            </tr>
            <!-- Sử dụng Usecase với trường hợp sử dụng là xem danh sách mượn phòng học theo giảng viên  -->
            <tr
                onclick="location.href = '../DsMuonPhongHoc/index.html?Usecase=DsMPH&Display=XemDsMPH&UIDManager=01435676&SearchInput=Nguy%E1%BB%85n%20Th%E1%BB%8B%20B%C3%ADch%20Nguy%C3%AAn&SearchOption=GiangVien';">
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