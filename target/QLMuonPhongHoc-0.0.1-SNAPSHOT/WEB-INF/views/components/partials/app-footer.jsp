<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<style>
    footer {
        p {
            display: block;

            a {
                transition: .3s;
            }

            span {
                display: inline-flex;
                transition: .3s;
            }
        }
    }

    @media only screen and (width <=992px) {

        /* Small devices (portrait tablets and large phones, 600px and up) */
        footer {
            p,
            p a,
            p span {
                font-size: 1rem;
            }
        }
    }

    @media only screen and (992px < width) {

        /* Medium devices (landscape tablets, 992px and up) */
        footer {
            p,
            p a,
            p span {
                font-size: 1.3rem;
            }
        }
    }
</style>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // // Lấy địa chỉ URL hiện tại
        var url = window.location.href;

        let urlParts = url.split('?');
        
        let paths = urlParts[0].split('/');
        let params = new URLSearchParams(urlParts[1]);

        // Lấy thông tin từ paths urls
        var MainPath = paths[paths.length - 1];
        if (MainPath !== "HomeManager" && MainPath !== "HomeAdmin") {
            const OTPItems = document.querySelector('#OTP-field');
            OTPItems.style.display = 'none'; // Ẩn mã xác nhận đi
        }
    });
</script>
<p id="policies-terms">
    <a class="" href="#">Chính sách bảo mật</a>
    <span>|</span>
    <a class="" href="#">Điều khoản dịch vụ</a>
</p>
<p id="contact">Liên hệ P.CTSV:
    <span>Address: ${addressContact}.</span>
    <span>Email: ${emailContact}.</span>
    <span>Phone: ${phoneContact}.</span>
    <br>
    để tìm hiểu thêm về quy trình mượn phòng.
</p>
<p id="copyright">
    <span>&copy; 2024. Nhóm 11 môn Công nghệ phần mềm.</span>
    <span>Qua giảng viên Nguyễn Thị Bích Nguyên hướng dẫn.</span>
</p>
<p id="OTP-field">
    <span><b>Mã xác nhận: ${OTP}</b></span>
</p>