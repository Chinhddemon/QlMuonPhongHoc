function setUsecases() {
    const urlParams = new URLSearchParams(window.location.search);
    
    // Lấy giá trị của các tham số từ URL
    const UIDManager = urlParams.get('UIDManager');
    const UIDRegular = urlParams.get('UIDRegular');

    // console.log(UC, Display, Form, UIDManager,UIDRegular)


    // Loại bỏ khi xây dựng controller
    // Trường hợp đã đăng nhập
    // if ( UIDRegular ){
    //     window.location.href = "";
    // }
    if( UIDManager ) {
        window.location.href = "../HomeManager/index.html";
    }
    
}

document.addEventListener("DOMContentLoaded", function () {
    setUsecases();
});