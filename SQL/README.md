# Mô tả

- `Table.sql`: File cấu trúc database tổng quát, bao gồm ràng buộc dữ liệu và các thuộc tính trong bảng, tuy nhiên không có mối ràng buộc ngoại bảng ngoài khóa ngoại.
- `Trigger_.sql`: File cấu hình ràng buộc giữa các bảng cũng như can thiệp và chỉnh sửa thông tin ngoại bảng khi có truy vấn.
- `RawData.sql`: File nhập thông tin vào database, hiện tại sử dụng để thử nghiệm ràng buộc và sửa lỗi.
- `ProcedureFunctionAndView.sql`: Gồm 2 phần:
    - Procedure: Các hàm được xây dựng trong SQL để thực hiện các nhiệm vụ cụ thể, được sử dụng song song với `Role.sql`.
    - View: Các hàm view được cấu hình chọn lọc thông tin hiển thị. Sử dụng như hàm hỗ trợ procedure.
- `Role.sql`: File xây dựng và thiết kế quy tắc roles trong database, roles vận hành ứng dụng, được sử dụng song song với `Procedure.sql` để xác định quyền truy cập.
- `Rule.sql`: Các hàm được cấu hình ràng buộc dữ liệu. Sử dụng như hàm hỗ trợ ràng buộc thuộc tính.
- `Index.sql`: Các gói lệnh chỉ mục được sử dụng để tối ưu hóa truy vấn. Sử dụng kết hợp với Partition.sql.
- `Partition.sql`: Gói lệnh sử dụng kỹ thuật phân chia dữ liệu để tối ưu hiệu suất truy vấn. Sử dụng kết hợp với Index.sql.
- `Query.sql`: Khối lệnh truy vấn sử dụng trong quá trình xây dựng database.
- `CopyData.sql`: Gói lệnh sử dụng để sao chép mọi thông tin qua database khác. Chỉ hiệu quả với cùng một cấu trúc bảng và cùng tên các thuộc tính.


# Cài đặt database theo thứ tự:

1. `Rule.sql` -- Chưa sử dụng được
2. `Partition.sql` -- Chưa sử dụng được
3. `Table.sql`
4. `Index.sql` -- Chưa sử dụng được
5. `TriggerBeforeInsert.sql`
8. `Role.sql` -- Chưa sử dụng được
6. `ProcedureFunctionAndView.sql`
7. `RawData.sql` hoặc `CopyData.sql` nếu chuyển từ database khác hoặc sử dụng file import khác được cung cấp
8. `TriggerAfterInsert.sql`

Hoặc sử dụng file `Total.sql` (bao gồm tất cả file trên, data được sử dụng từ `RawData.sql`) để tạo database.