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

    // console.log(UC, Display, Form, UIDManager,UIDRegular)
    // console.log(SearchInput, SearchOption)
    // Trường hợp xem danh sách lịch mượn phòng học
    if( UIDManager && UC === 'DsMPH' && Display === 'DsMPH' ) {

        // Ẩn phần tử button hướng dẫn
        document.querySelector('button#openGuide').classList.add("hidden");

    }
    // Trường hợp xem danh sách lịch mượn phòng học theo giảng viên
    else if( UIDManager && UC === 'DsGV' && Display === 'DsMPH' ) {

        if ( SearchInput ) document.querySelector('.filter input').value = SearchInput;
        if ( SearchOption ) document.querySelector('.filter option[value="GiangVien"]').setAttribute('selected', 'selected');

        // Ẩn phần tử button hướng dẫn
        document.querySelector('button#openGuide').classList.add("hidden");

    } 
    // Trường hợp lập thủ tục mượn phòng học
    else if ( UIDRegular && UC === 'MPH' & Display === 'YCMPH' ){

        // Ẩn các phần tử button trong nav
        document.querySelector('.board-bar .add-object').classList.add("hidden");

        // Ẩn các phần tử label trong form
        document.querySelector('.board-content .DsNgMPH').classList.add("hidden");
        // Ẩn các phần tử button trong form
        document.querySelector('.board-content .submit-object').classList.add("hidden");

        // Bỏ thuộc tính disabled của các phần tử input
        document.querySelector('.board-content .YeuCau input').removeAttribute('disabled');

    } 
    else {
        window.location.href = "../ErrorHandling/index.html";
    }
}

function sortbyTerm() {
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

            if (sortBy === 'ThoiGian_BD') {
                function parseTimeString(timeString) {
                    const [time, date] = timeString.split(' ');
                    const [hours, minutes] = time.split(':');
                    const [day, month, year] = date.split('/');
                
                    // Month in JavaScript is 0-based, so we subtract 1
                    return new Date(year, month - 1, day, hours, minutes);
                }
                
                const aTime = parseTimeString(aValue);
                const bTime = parseTimeString(bValue);

                return aTime - bTime;
            } else {
                return aValue.localeCompare(bValue);
            }
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