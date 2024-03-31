<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
    footer {
        p {
            display: block;

            span {
                display: inline-flex;
            }
        }
    }
    @media only screen and ( width <= 992px) {/* Small devices (portrait tablets and large phones, 600px and up) */
        footer {
            p
            p a,
            p span {
                font-size: 1.3rem;
            }
        } 
    }
    @media only screen and ( 992px < width) {/* Medium devices (landscape tablets, 992px and up) */
        footer {
            p
            p a,
            p span {
                font-size: 1.6rem;
            }
        } 
    }
</style>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // // Lấy địa chỉ URL hiện tại
        var url = window.location.href;

        let urlParts = url.split('?');
        // Lấy phần pathname của URL và loại bỏ đuôi ".htm" (nếu có)
        let paths = urlParts[0].replace(/\.htm$/, '').split('/');
        let params = new URLSearchParams(urlParts[1]);

        // Lấy thông tin từ paths urls
        var MainPath = paths[paths.length - 1];
        if(MainPath === "Login" || MainPath === "HomeRegular")
        {
            const tokenItems = document.querySelector('#token-field');
            tokenItems.style.display = 'none'; // Ẩn menu đi
        }
    });
</script>
<p id="policies-terms">
    <a class="" href="#">Chính sách bảo mật</a>
    <span>|</span>
    <a class="" href="#">Điều khoản dịch vụ</a>
</p>
<p id="contact">Liên hệ PCTSV:
    <span>Address: ${addressContact}</span>
    <span>Email: ${emailContact}</span>
    <span>Phone: ${phoneContact}</span>
    để hiểu thêm về quy trình mượn phòng.
</p>
<p id="copyright">
    <span>&copy; 2024. Nhóm 11 môn Công nghệ phần mềm.</span>
    <span>Qua giảng viên Nguyễn Thị Bích Nguyên hướng dẫn.</span>
</p>
<p id="token-field">
    <span><b>Mã xác nhận: ${Token}</b></span>
</p>