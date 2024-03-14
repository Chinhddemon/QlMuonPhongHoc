function setUsecases() {
    const urlParams = new URLSearchParams(window.location.search);
    
    // Lấy giá trị của các tham số từ URL
    const UIDManager = urlParams.get('UIDManager');
    const UIDRegular = urlParams.get('UIDRegular');

    // console.log(UIDManager,UIDRegular)

    // Trường hợp chưa đăng nhập
    if( !UIDManager ) {
        window.location.href = "../Login/index.html";
    }
    
}

// Hàm ẩn menu theo màn hình sử dụng
function hideMenu () {
    const menuRegularItems = document.querySelectorAll('.menu-regular a');

    menuRegularItems.forEach(item => {
        item.addEventListener('click', function(event) {
            const menu = document.querySelector('.board-menu');
            menu.style.display = 'none'; // Ẩn menu đi
        });
    });
}
document.addEventListener("DOMContentLoaded", function () {
    setUsecases();
    hideMenu();
});