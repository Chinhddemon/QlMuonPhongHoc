function setUsecases() {
    // // Lấy địa chỉ URL hiện tại
    // var url = window.location.href;

    // // Lấy phần pathname của URL và loại bỏ đuôi ".htm" (nếu có)
    // var pathnameWithoutExtension = window.location.pathname.replace(/\.htm$/, '');

    // // Tách phần pathname thành một mảng các phần tử sử dụng dấu "/"
    // var pathnameParts = pathnameWithoutExtension.split('/');

    // // Lấy thông tin từ phần tử của mảng
    // var Usecase = pathnameParts[0];
    // var Display_Form = pathnameParts[1];

    // var SearchInput = url.searchParams.get("SearchInput");
    // var SearchOption = url.searchParams.get("SearchOption");

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

                const SearchInput = urlParams.get('SearchInput');
                const SearchOption = urlParams.get('SearchOption');

    // In ra console để kiểm tra
    // console.log(Usecase, Display, Form, UIDManager,UIDRegular)
    // console.log(SearchInput, SearchOption)

    // Trường hợp xem danh sách giảng viên
    if( UIDManager && Usecase === 'DsGV' && Display === 'DsGV' ) {

        // Chỉnh sửa phần tử nav theo Usecase
        document.querySelector('.board-bar').classList.add("menu-manager");

    }
    else {
        window.location.href = "../ErrorHandling/index.html";
    }
}

function sortbyTerm(){
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
            if (containsSearchTerm) {
                tableBody.appendChild(row);
            }
        });
    });
}

document.addEventListener("DOMContentLoaded", function () {
    setUsecases();
    sortbyTerm();
});