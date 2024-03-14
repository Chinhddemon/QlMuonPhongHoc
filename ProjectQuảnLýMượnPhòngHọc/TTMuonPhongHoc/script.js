function setUsecases() {
    // // Lấy địa chỉ URL hiện tại
    // var url = window.location.href;

    // // Lấy phần pathname của URL và loại bỏ đuôi ".htm" (nếu có)
    // var pathnameWithoutExtension = window.location.pathname.replace(/\.htm$/, '');

    // // Tách phần pathname thành một mảng các phần tử sử dụng dấu "/"
    // var pathnameParts = pathnameWithoutExtension.split('/');

    // // Lấy thông tin từ phần tử của mảng
    // var Usecase = pathnameParts[0];
    // var Display = pathnameParts[1];
    // var Form = pathnameParts[1];

    // Lấy giá trị của các tham số từ request
    // var UIDManager = '<%= request.getAttribute("UIDManager") %>';
    // var UIDRegular = '<%= request.getAttribute("UIDRegular") %>';

    // Bỏ các dòng code lấy giá trị từ URL khi connect với controller
                const urlParams = new URLSearchParams(window.location.search);
                                    
                // Lấy giá trị của các tham số từ URL
                const Usecase = urlParams.get('Usecase');
                const Display = urlParams.get('Display');
                const Form = urlParams.get('Form');
                const UIDManager = urlParams.get('UIDManager');
                const UIDRegular = urlParams.get('UIDRegular');

    // In ra console để kiểm tra
    // console.log(Usecase, Display, Form, UIDManager,UIDRegular)
    // console.log(SearchInput, SearchOption)

    // Trường hợp xem thông tin lịch mượn phòng học
    if( UIDManager && Usecase === 'DsMPH' && Display === 'TTMPH') {

        // Chỉnh sửa phần tử nav theo Usecase
        document.querySelector('.board-bar').classList.add("menu-manager");

        // Thay đổi nội dung của các thẻ trong nav
        document.querySelector('.board-bar h2.title').textContent = "Mã mượn phòng học: ";

        // Ẩn các phần tử button trong form
        document.querySelector('.board-content .cancel-object').classList.add("hidden");
        document.querySelector('.board-content .conform-object').classList.add("hidden");
        document.querySelector('.board-content .submit-object').classList.add("hidden");

        // Ẩn phần tử button hướng dẫn
        document.querySelector('button#openGuide').classList.add("hidden");

    } 
    // Trường hợp thêm thông tin lịch mượn phòng học
    else if( UIDManager && Usecase === 'DsMPH' && Form === 'ThemTTMPH' ) {

        // Chỉnh sửa phần tử nav theo Usecase
        document.querySelector('.board-bar').classList.add("menu-manager");

        // Thay đổi nội dung của các thẻ trong nav
        document.querySelector('.board-bar h2.title').textContent = "Thêm thông tin lịch mượn phòng";
        // Ẩn các phần tử button trong nav
        document.querySelector('.board-bar .update-object').classList.add("hidden");
        document.querySelector('.board-bar .remove-object').classList.add("hidden");

        // Thay đổi nội dung của các thẻ trong form
        document.querySelector('.board-content .DsNgMPH button').textContent = "Nhập danh sách cho phép mượn phòng học";

        // Ẩn các phần tử label trong form
        document.querySelector('.board-content .GiangVien').classList.add("hidden");
        document.querySelector('.board-content .MaLopSV').classList.add("hidden");
        document.querySelector('.board-content .TenMH').classList.add("hidden");
        document.querySelector('.board-content .TrangThai').classList.add("hidden");
        document.querySelector('.board-content .NgMPH').classList.add("hidden");
        document.querySelector('.board-content .VaiTro').classList.add("hidden");
        document.querySelector('.board-content .QL_Duyet').classList.add("hidden");
        document.querySelector('.board-content .YeuCau').classList.add("hidden");
        // Ẩn các phần tử button trong form
        document.querySelector('.board-content .conform-object').classList.add("hidden");
        // Bỏ thuộc tính disabled của các phần tử 
        document.querySelector('.board-content .MaPH input').removeAttribute('disabled');
        document.querySelector('.board-content .ThoiGian_BD input').removeAttribute('disabled');
        document.querySelector('.board-content .ThoiGian_KT input').removeAttribute('disabled');
        document.querySelector('.board-content .HinhThuc select').removeAttribute('disabled');
        document.querySelector('.board-content .LyDo input').removeAttribute('disabled');

        // Ẩn phần tử button hướng dẫn
        document.querySelector('button#openGuide').classList.add("hidden");

    } 
    // Trường hợp lập thủ tục mượn phòng học
    else if ( UIDRegular && Usecase === 'MPH' & Display === 'YCMPH' ){

        // Chỉnh sửa phần tử nav theo Usecase
        document.querySelector('.board-bar').classList.add("menu-regular");

        // Thay đổi nội dung của các thẻ trong nav
        document.querySelector('.board-bar h2.title').textContent = "Thủ tục mượn phòng với mã: ";
        // Ẩn các phần tử button trong nav
        document.querySelector('.board-bar .update-object').classList.add("hidden");
        document.querySelector('.board-bar .remove-object').classList.add("hidden");

        // Ẩn các phần tử label trong form
        document.querySelector('.board-content .LyDo').classList.add("hidden");
        document.querySelector('.board-content .NgMPH').classList.add("hidden");
        document.querySelector('.board-content .VaiTro').classList.add("hidden");
        document.querySelector('.board-content .QL_Duyet').classList.add("hidden");
        // Ẩn các phần tử button trong form
        document.querySelector('.board-content .DsNgMPH').classList.add("hidden");
        document.querySelector('.board-content .submit-object').classList.add("hidden");

        // Bỏ thuộc tính disabled của các phần tử
        document.querySelector('.board-content .YeuCau input').removeAttribute('disabled');

    }
    // Trường hợp lập thủ tục đổi buổi học
    else if ( UIDRegular && Usecase === 'DBH' & Display === 'TTDBH' ){

        // Chỉnh sửa phần tử nav theo Usecase
        document.querySelector('.board-bar').classList.add("menu-regular");

        // Thay đổi nội dung của các thẻ trong nav
        document.querySelector('.board-bar h2.title').textContent = "Thủ tục đổi buổi học";
        // Ẩn các phần tử button trong nav
        document.querySelector('.board-bar .update-object').classList.add("hidden");
        document.querySelector('.board-bar .remove-object').classList.add("hidden");

        // Ẩn các phần tử label trong form
        document.querySelector('.board-content .TrangThai').classList.add("hidden");
        document.querySelector('.board-content .NgMPH').classList.add("hidden");
        document.querySelector('.board-content .VaiTro').classList.add("hidden");
        document.querySelector('.board-content .QL_Duyet').classList.add("hidden");
        // Ẩn các phần tử button trong form
        document.querySelector('.board-content .DsNgMPH').classList.add("hidden");
        document.querySelector('.board-content .submit-object').classList.add("hidden");

        // Bỏ thuộc tính disabled của các phần tử
        document.querySelector('.board-content .MaPH input').removeAttribute('disabled');
        document.querySelector('.board-content .ThoiGian_BD input').removeAttribute('disabled');
        document.querySelector('.board-content .ThoiGian_KT input').removeAttribute('disabled');
        document.querySelector('.board-content .HinhThuc select').removeAttribute('disabled');
        document.querySelector('.board-content .LyDo input').removeAttribute('disabled');
        document.querySelector('.board-content .YeuCau input').removeAttribute('disabled');

    } 
    else { //Xử lý lỗi ngoại lệ truy cập
        window.location.href = "../ErrorHandling/index.html";
    }
}

// Hàm đặt giá trị cho các thẻ input trong form
function setFormValues() {
    const urlParams = new URLSearchParams(window.location.search);
        
    // Lấy giá trị của các tham số từ URL
    const MaLMPH = urlParams.get('MaLMPH');
    const MaLH = urlParams.get('MaLH');
    const GiangVien = urlParams.get('GiangVien');
    const MaLopSV = urlParams.get('MaLopSV');
    const MaMH = urlParams.get('MaMH');
    const TenMH = urlParams.get('TenMH');
    const MaPH = urlParams.get('MaPH');
    const ThoiGian_BD = urlParams.get('ThoiGian_BD');
    const ThoiGian_KT = urlParams.get('ThoiGian_KT');
    const HinhThuc = urlParams.get('HinhThuc');
    const LyDo = urlParams.get('LyDo');
    const TrangThai = urlParams.get('TrangThai');
    const NgMPH = urlParams.get('NgMPH');
    const VaiTro = urlParams.get('VaiTro');
    const QL_Duyet = urlParams.get('QL_Duyet');
    const YeuCau = urlParams.get('YeuCau');

    const title = document.querySelector('.board-bar h2.title');
    // Đặt nội dung văn bản của phần tử này
    title.textContent = title.textContent + ( MaLMPH ? MaLMPH : "" );
    
    // Hiển thị dữ liệu trên HTML
    document.querySelector('.board-content .GiangVien input').value = GiangVien;
    document.querySelector('.board-content .MaLopSV input').value = MaLopSV;
    document.querySelector('.board-content .TenMH input').value = TenMH;
    document.querySelector('.board-content .MaPH input').value = MaPH;
    document.querySelector('.board-content .ThoiGian_BD input').value = ThoiGian_BD;
    document.querySelector('.board-content .ThoiGian_KT input').value = ThoiGian_KT;
    document.querySelector('.board-content .HinhThuc select').value = HinhThuc;
    document.querySelector('.board-content .LyDo input').value = LyDo;
    document.querySelector('.board-content .TrangThai input').value = TrangThai;
    document.querySelector('.board-content .NgMPH input').value = NgMPH;
    document.querySelector('.board-content .VaiTro input').value = VaiTro;
    document.querySelector('.board-content .QL_Duyet input').value = QL_Duyet;
    if ( YeuCau ) document.querySelector('.board-content .YeuCau input').value = YeuCau;
}

// Gọi hàm setFormValues khi trang được load
document.addEventListener("DOMContentLoaded", function () {
    setUsecases();
    setFormValues();
});
