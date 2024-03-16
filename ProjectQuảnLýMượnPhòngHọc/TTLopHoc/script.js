// // Lấy địa chỉ URL hiện tại
var url = window.location.href;

// Lấy phần pathname của URL và loại bỏ đuôi ".htm" (nếu có)
var urlWithoutExtension = url.replace(/\.htm$/, '');

let urlParts = urlWithoutExtension.split('?');
let paths = urlParts[0].split('/');
let params = new URLSearchParams(urlParts[1]);

// // Lấy thông tin từ phần tử của mảng
// var Usecase = paths[paths.length - 2];
// var UsecasePath = paths[paths.length - 1];

// Lấy giá trị của các tham số từ request
// var UIDManager = '<%= request.getAttribute("UIDManager") %>';
// var UIDRegular = '<%= request.getAttribute("UIDRegular") %>';

// Bỏ các dòng code lấy giá trị từ URL khi connect với controller
            var urlParams = new URLSearchParams(window.location.search);
                                            
            // Lấy giá trị của các tham số từ URL
            var Usecase = urlParams.get('Usecase');
            var UsecasePath = urlParams.get('Display') || urlParams.get('Form');
            var UIDManager = urlParams.get('UIDManager');
            var UIDRegular = urlParams.get('UIDRegular');

            var LastUsecase = urlParams.get('Usecase');
            var LastUsecasePath = urlParams.get('UsecasePath');
            var LastForm = urlParams.get('Form');

// In ra console để kiểm tra
// console.log(Usecase, UsecasePath, UIDManager,UIDRegular)
// console.log(SearchInput, SearchOption)

function setUsecases() {

    // Trường hợp xem thông tin lớp học
    if( UIDManager && Usecase === 'TTLH' && UsecasePath === 'XemTTLH') {

        // Chỉnh sửa phần tử nav theo Usecase
        document.querySelector('.board-bar').classList.add("menu-manager");
        
        // Hiện các phần tử button trong nav
        document.querySelector('.board-bar .update-object').classList.remove("hidden");
        document.querySelector('.board-bar .remove-object').classList.remove("hidden");

        // Thay đổi nội dung của các thẻ trong nav
        document.querySelector('.board-bar h2.title').textContent = "Mã lớp học: ";

        // Ẩn các phần tử label trong form
        document.querySelector('.board-content .XacNhan').classList.add("hidden");
        // Ẩn các phần tử button trong form
        document.querySelector('.board-content .submit').classList.add("hidden");
        document.querySelector('.board-content .cancel-object').classList.add("hidden");
        document.querySelector('.board-content .conform-object').classList.add("hidden");
        document.querySelector('.board-content .submit-object').classList.add("hidden");

        // Thêm thuộc tính disabled của các phần tử 
        const listInput = document.querySelectorAll('.board-content input');
        for (var i = 0; i < listInput.length; i++) { // Lặp qua từng thẻ input
            listInput[i].setAttribute('disabled', 'true');
        }
        const listSelect = document.querySelectorAll('.board-content select');
        for (var i = 0; i < listSelect.length; i++) { // Lặp qua từng thẻ select
            listSelect[i].setAttribute('disabled', 'true');
        }

    }
    // Trường hợp chỉnh sửa thông tin lớp học
    else if( UIDManager && Usecase === 'TTLH' && UsecasePath === 'SuaTTLH' ) {

        // Chỉnh sửa phần tử nav theo Usecase
        document.querySelector('.board-bar').classList.add("menu-manager");

        // Thay đổi nội dung của các thẻ trong nav
        document.querySelector('.board-bar h2.title').textContent = "Chỉnh sửa lớp học mã: ";
        // Ẩn các phần tử button trong nav
        document.querySelector('.board-bar .update-object').classList.add("hidden");
        document.querySelector('.board-bar .remove-object').classList.add("hidden");

        // Ẩn các phần tử button trong form
        document.querySelector('.board-content .submit-object').classList.add("hidden");

        // Bỏ thuộc tính disabled của các phần tử
        document.querySelector('.board-content .GiangVien select').removeAttribute('disabled');
        document.querySelector('.board-content .MaLopSV select').removeAttribute('disabled');
        document.querySelector('.board-content .MaMH select').removeAttribute('disabled');
        document.querySelector('.board-content .Ngay_BD input').removeAttribute('disabled');
        document.querySelector('.board-content .Ngay_KT input').removeAttribute('disabled');
        document.querySelector('.board-content .XacNhan input').removeAttribute('disabled');

        // Hiện các phần tử button trong form
        document.querySelector('.board-content .submit').classList.remove("hidden");
        document.querySelector('.board-content .cancel-object').classList.remove("hidden");
        document.querySelector('.board-content .conform-object').classList.remove("hidden");

    }
    else { //Xử lý lỗi ngoại lệ truy cập
        window.location.href = "../ErrorHandling/index.html";
    }
}

// Hàm đặt giá trị cho các thẻ input trong form
function setFormValues() {
    const urlParams = new URLSearchParams(window.location.search);

    // Lấy giá trị của các tham số từ request
    // var MaLH = '<%= request.getAttribute("MaLH") %>';
    // var IdGV = '<%= request.getAttribute("IdGV") %>';
    // var GiangVien = '<%= request.getAttribute("GiangVien") %>';
    // var MaLopSV = '<%= request.getAttribute("MaLopSV") %>';
    // var MaMH = '<%= request.getAttribute("MaMH") %>';
    // var TenMH = '<%= request.getAttribute("TenMH") %>';
    // var Ngay_BD = '<%= request.getAttribute("Ngay_BD") %>';
    // var Ngay_KT = '<%= request.getAttribute("Ngay_KT") %>';
      
    // Bỏ các dòng code lấy giá trị từ URL khi connect với controller
                // Lấy giá trị của các tham số từ URL
                const MaLH = urlParams.get('MaLH');
                const IdGV = urlParams.get('IdGV');
                const GiangVien = urlParams.get('GiangVien');
                const MaLopSV = urlParams.get('MaLopSV');
                const MaMH = urlParams.get('MaMH');
                const TenMH = urlParams.get('TenMH');
                const Ngay_BD = urlParams.get('Ngay_BD');
                const Ngay_KT = urlParams.get('Ngay_KT');
                

    const title = document.querySelector('.board-bar h2.title');
    // Đặt nội dung văn bản của phần tử này
    title.textContent = title.textContent + ( MaLH ? MaLH : "" );

    
    
    // Hiển thị dữ liệu trên HTML
    document.querySelector('.board-content .MaLH input').value = MaLH;
    document.querySelector('.board-content .GiangVien select').value = GiangVien;
    document.querySelector('.board-content .MaLopSV select').value = MaLopSV;
    document.querySelector('.board-content .MaMH select').value = MaMH;
    document.querySelector('.board-content .Ngay_BD input').value = Ngay_BD;
    document.querySelector('.board-content .Ngay_KT input').value = Ngay_KT;
}

// Gọi hàm setFormValues khi trang được load
document.addEventListener("DOMContentLoaded", function () {
    setUsecases();
    setFormValues();
});

// Gọi hàm settingToUpdateData khi thao tác với nút update-object
function settingToUpdateData () {
    // // Thay đổi path thứ hai thành 'DSMPH'
    // UsecasePath = 'SuaTTMPH';

    // Tạo URL mới từ các phần tử đã thay đổi
    // let newURL = paths.join('/') + '.htm' + '?' + params.toString(); ;

    // Bỏ các dòng code khi connect với controller
        params.set('Display', '');
        params.set('Form', 'SuaTTLH');

        let newURL = paths.join('/') + '?' + params.toString();

    // Thay đổi URL và reload lại trang
    history.back();
    history.pushState(null, '', newURL);
    window.location.reload();
}
function settingToDeleteData () {

}
function settingToCancelChangeData () {
    // // Thay đổi path thứ hai thành 'DSMPH'
    // UsecasePath = 'TTMPH';

    // Tạo URL mới từ các phần tử đã thay đổi
    // let newURL = paths.join('/') + '.htm' + '?' + params.toString(); ;

        // Bỏ các dòng code khi connect với controller
        params.set('Display', '');
        params.set('Form', 'XemTTLH');

        let newURL = paths.join('/') + '?' + params.toString();

    // Thay đổi URL và reload lại trang
    history.back();
    history.pushState(null, '', newURL);
    window.location.reload();
}
function settingToSubmitData () {
    
}