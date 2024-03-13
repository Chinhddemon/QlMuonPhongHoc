<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
    footer p span {
        display: inline-flex;
    }
    @media only screen and ( width <= 992px) {/* Small devices (portrait tablets and large phones, 600px and up) */
        footer p,
        footer p a,
        footer p span {
            font-size: 1rem;
        }
    }
    @media only screen and ( 992px < width) {/* Medium devices (landscape tablets, 992px and up) */
        footer p,
        footer p a,
        footer p span {
            font-size: 2rem;
        }
    }
</style>
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
</p id="copyright">
<p>
    <span>&copy; 2024. Nhóm 11 môn Công nghệ phần mềm.</span>
    <span>Qua giảng viên Nguyễn Thị Bích Nguyên hướng dẫn.</span>
</p>
<p>
    <span>UID: ${UIDManager}</span>
</p>