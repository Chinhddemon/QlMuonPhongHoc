function setUsecases() {
    const urlParams = new URLSearchParams(window.location.search);
    
    // Lấy giá trị của các tham số từ URL
    const UC = urlParams.get('UC');
    const Display = urlParams.get('Display');
    const Form = urlParams.get('Form');
    const UIDManager = urlParams.get('UIDManager');
    const UIDRegular = urlParams.get('UIDRegular');

    const SearchInput = urlParams.get('SearchInput');
    const SearchOption = urlParams.get('SearchOption');

    console.log(UC, Display, Form, UIDManager,UIDRegular)
    console.log(SearchInput, SearchOption)
    // Trường hợp xem danh sách giảng viên
    if( UIDManager && UC === 'DsGV' && Display === 'DsGV' ) {
        //ByPass
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