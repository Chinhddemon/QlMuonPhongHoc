document.addEventListener("DOMContentLoaded", function () {
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
});