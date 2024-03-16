package qlmph.DAO.QLThongTin;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.UUID;

import qlmph.DBUtil.DBUtil;
import qlmph.Models.QLTaiKhoan.GiangVien;
import qlmph.Models.QLThongTin.MonHoc;

public class MonHocDAO {
    
    public static MonHoc getByMaMH(String MaMH) {
        // Tạo class lưu giữ thông tin truy vấn 
        MonHoc monHoc = null;
    
        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM MonHoc WHERE IdGV = ?");
            statement.setString(1, MaMH);
    
            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();
    
            // Xử lý kết quả
            if (resultSet.next()) {
                // Lấy thông tin từ kết quả
                String maMH = resultSet.getString("MaMH");
                String tenMH = resultSet.getString("TenMH");
                Timestamp _UpdateAt = resultSet.getTimestamp("_UpdateAt");
                Timestamp _DeleteAt = resultSet.getTimestamp("_DeleteAt");
                // Lưu trữ thông tin vào class
                monHoc = new MonHoc(maMH, tenMH, _UpdateAt, _DeleteAt);
            } else {
                // Không tìm thấy bản ghi nào với ID cụ thể
            }
    
            // Đóng kết nối, các tài nguyên
            resultSet.close();
            statement.close();
            connection.close(); 
            // Đảm bảo đóng kết nối sau khi sử dụng
        } catch (SQLException e) {
            e.printStackTrace(); // In ra thông tin lỗi nếu có
        }
    
        return monHoc;
    }

}

