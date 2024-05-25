<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<style>
    button#openGuide {
        position: fixed;
        bottom: 0px;
        right: 0px;
        border: .2rem solid black;
        border-radius: 1rem;
        margin: .3rem;
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

    @media only screen and (width <=768px) {

        /* Small devices (portrait tablets and large phones, 600px and up to 768px) */
        dialog {
            div {
                font-size: 1.5rem;
            }

            p {
                font-size: 1rem;
            }
        }
    }

    @media only screen and (768px < width) {

        /* Medium devices (landscape tablets, 768px and up) */
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
<dialog id="dialog">
    <form method="dialog">
        <div>Hướng dẫn</div>
        <p>
            <b>1. Chọn lịch học mà sinh viên, giảng viên cần mượn phòng giảng dạy.<br></b>
            2. Cung cấp thêm thông tin mượn phòng để quản lý duyệt. <br>
            3. Nhập mã xác nhận từ quản lý và nhận đồ xài :&gt;
        </p>
        <button onclick="closeModal()">Close</button>
    </form>
</dialog>

<script>
    // Lấy thẻ dialog
    var dialog = document.getElementById('dialog');

    // Hiển thị dialog
    function showModal() {
        dialog.showModal();
    }

    // Đóng dialog
    function closeModal() {
        dialog.close();
    }

    // Xử lý việc đóng dialog khi click bên ngoài
    window.onclick = function (event) {
        if (event.target === dialog) {
            dialog.close();
        }
    };
</script>