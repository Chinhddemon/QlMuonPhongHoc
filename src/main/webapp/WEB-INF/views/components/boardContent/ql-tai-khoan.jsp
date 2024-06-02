<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage NhomToHocPhan Divs</title>
    <style>
        .innocent {
            margin: 10px 0;
            padding: 10px;
            border: 1px solid #ccc;
        }
        .hidden {
            display: none;
        }
    </style>
</head>
<body>
    <div id="container">
        <!-- Thẻ innocent mẫu -->
        <div id="NhomToHocPhan-template" class="innocent hidden mark-remove">
            <hr>
            <label class="GiangVien">
                <span>Giảng viên: </span>
                <select disabled required name="MaGiangVien">
                    <option disabled selected hidden value="">Chọn giảng viên</option>
                    <c:forEach var="GiangVien" items="${DsGiangVien}">
                        <option value="${GiangVien.maGiangVien}">
                            ${GiangVien.maGiangVien} - ${GiangVien.nguoiDung.hoTen}
                        </option>
                    </c:forEach>
                </select>
            </label>
            <label class="NhomTo MucDich">
                <span>Hình thức học: </span>
                <select disabled required name="MucDich">
                    <option disabled selected hidden value="">Chọn hình thức học</option>
                    <option value="LT">Lý thuyết</option>
                    <option value="TH">Thực hành</option>
                    <option value="U">Khác</option>
                </select>
            </label>
            <label class="StartDate">
                <span>Ngày bắt đầu: </span>
                <input type="date" disabled required name="StartDate-Section">
            </label>
            <label class="EndDate">
                <span>Ngày kết thúc:</span>
                <input type="date" disabled required name="EndDate-Section">
            </label>
            <button class="remove-object" type="button">Lược bỏ thông tin</button>
        </div>
    </div>
    <button class="add-object" type="button">Thêm thông tin</button>
    <button class="remove-last-object" type="button">Xóa thẻ cuối cùng</button>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Lấy HTML từ template
            const nhomToHocPhanTemplate = document.getElementById('NhomToHocPhan-template').outerHTML;

            // Thêm thẻ innocent mới
            function addNhomToHocPhan() {
                const container = document.getElementById('container');
                const div = document.createElement('div');
                div.innerHTML = nhomToHocPhanTemplate;
                const newElement = div.firstChild;
                newElement.classList.remove('hidden');
                container.appendChild(newElement);

                // Gắn sự kiện cho nút xóa mới
                newElement.querySelector('.remove-object').addEventListener('click', removeNhomToHocPhan);
            }

            // Xóa thẻ innocent chứa nút xóa
            function removeNhomToHocPhan(event) {
                const button = event.target;
                const innocentDiv = button.closest('.innocent');
                innocentDiv.remove();
            }

            // Xóa thẻ innocent cuối cùng
            function removeLastNhomToHocPhan() {
                const innocentDivs = document.querySelectorAll('.innocent');
                if (innocentDivs.length > 0) {
                    innocentDivs[innocentDivs.length - 1].remove();
                }
            }

            // Gắn sự kiện cho các nút
            document.querySelector('.add-object').addEventListener('click', addNhomToHocPhan);
            document.querySelector('.remove-last-object').addEventListener('click', removeLastNhomToHocPhan);
            document.querySelectorAll('.remove-object').forEach(button => {
                button.addEventListener('click', removeNhomToHocPhan);
            });
        });
    </script>
</body>
</html>
