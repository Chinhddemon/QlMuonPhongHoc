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
            <DsNgMPH>:
                idNgMPH     -   Id người mượn phòng học
                maNgMPH     -   Mã người mượn phòng học
                hoTen       -   Họ tên giảng viên
                ngaySinh    -   Ngày sinh
                gioiTinh    -   Giới tính
                email       -   Email
                sDT         -   Số điện thoại
                chucDanh    -   Chức danh
                chucVu      -   Chức vụ
        SessionStorage:
            UIDManager
            UIDRegular
    Chuẩn View URL truy cập:   ../${Usecase}/${UsecasePath}.htm?SearchInput=${SearchInput}&SearchOption=${SearchOption}
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
            height: 100vh;
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
                    padding:  1rem;
                }
                input::placeholder {
                    color: black;
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
                    td.MaBuoiHoc,
                    td.MaDoiBuoiHoc,
                    td.LopGiangDay {
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

            // Trường hợp người sử dụng là quản lý
            if ( UIDManager ) {

                // Trường hợp xem danh sách người mượn phòng học theo bộ lọc 
                if ( Usecase === 'DsNgMPH' && UsecasePath === 'XemDsNgMPH' ) {

                    // Chỉnh sửa phần tử nav theo Usecase
                    document.querySelector('.board-bar').classList.add("menu-manager");
                    
                    if (SearchInput) document.querySelector('.filter input').value = SearchInput;
                    // if (SearchOption === 'GiangVien') document.querySelector('.filter option[value="GiangVien"]').setAttribute('selected', 'selected');

                }
            }
            else {  // Không phát hiện mã UID
                window.location.href = "../Login.htm?Message=Không phát hiện mã UID";
           	}
        }

        function setFormAction() {
            const form = document.querySelector('.filter');
            const tableBody = document.querySelector('tbody');
            
            form.addEventListener('submit', function (event) {
            	sortAction(form, tableBody);
            });
        };
        
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
            // setFormValues();
            setFormAction();
            sortAction(); 
        });
    </script>
</head>

<body>
    <nav class="board-bar">
        <!-- URL sử dụng trong controller -->
        <!-- <a class="go-home" href="../Home.htm" target="_parent">Trang chủ</a> -->
        <a class="go-home" href="../Login/index.html?UIDManager=${UIDManager}&UIDRegular=${UIDRegular}" target="_parent">Trang chủ</a>
        <h2>Danh sách người mượn phòng</h2>
        <form class="filter" action="">
            <input type="search" name="searching" placeholder="Nhập nội dung tìm kiếm">
            <select name="sort">
                <option value="MaNgMPH">Theo mã</option>
                <option value="HoTen">Theo họ tên</option>
                <option value="GioiTinh">Theo giới tính</option>
                <option value="ChucDanh">Theo chức danh</option>
                <option value="ChucVu">Theo chức vụ</option>
            </select>
            <button type="submit">Lọc</button>
        </form>
        <hr>
    </nav>
    <main>
        <table>
            <thead>
                <tr>
                    <th class="MaNgMPH">Mã người mượn phòng</th>    
                    <th class="HoTen">Họ tên</th>
                    <th class="NgaySinh">Ngày sinh</th>
                    <th class="GioiTinh">Giới tính</th>
                    <th class="Email">Email</th>
                    <th class="SDT">Số điện thoại</th>
                    <th class="ChucDanh">Chức danh</th> 
                    <th class="ChucVu">Chức vụ</th> 
                </tr>
            </thead>
            <tbody>
                <c:forEach var="NgMPH" items="${DsNgMPH}">
                    <!-- <tr onclick="location.href = '../${NextUsecaseTable}/${NextUsecasePathTable}.htm?SearchInput=${SearchInput}&SearchOption=${SearchOption}';"> -->
                    <tr>
                        <td class="MaNgMPH">${NgMPH.maNgMPH}</td>
                        <td class="HoTen">${NgMPH.hoTen}</td>
                        <td class="NgaySinh">${NgMPH.ngaySinh}</td>
                        <td class="GioiTinh">${NgMPH.gioiTinh}</td>
                        <td class="Email">${NgMPH.email}</td>
                        <td class="SDT">${NgMPH.sDT}</td>
                        <td class="ChucDanh">${NgMPH.chucDanh}</td>
                        <td class="ChucVu">${NgMPH.chucVu}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </main>
</body>

</html>