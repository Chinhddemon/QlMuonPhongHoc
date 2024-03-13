document.addEventListener("DOMContentLoaded", function() {
    const menuRegularItems = document.querySelectorAll('.menu-regular a');

    menuRegularItems.forEach(item => {
        item.addEventListener('click', function(event) {
            const menu = document.querySelector('.board-menu');
            menu.style.display = 'none'; // Ẩn menu đi
        });
    });
});