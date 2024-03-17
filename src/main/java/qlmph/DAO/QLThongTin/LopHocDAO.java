package qlmph.DAO.QLThongTin;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import qlmph.DBUtil.DBUtil;
import qlmph.models.QLThongTin.LopHoc;

public class LopHocDAO {

    public static List<LopHoc> getAll() {
        // Tạo danh sách để lưu trữ thông tin các lớp học
        List<LopHoc> dsLopHoc = new ArrayList<>();

        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM LopHoc");

            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();

            // Xử lý kết quả
            while (resultSet.next()) {
                // Lấy thông tin từ kết quả
                String maLH = resultSet.getString("MaLH");
                UUID idGV_GiangDay = (UUID) resultSet.getObject("IdGV_GiangDay");
                String maMH = resultSet.getString("MaMH");
                String maLopSV = resultSet.getString("MaLopSV");
                Date ngay_BD = resultSet.getDate("Ngay_BD");
                Date ngay_KT = resultSet.getDate("Ngay_KT");
                Timestamp _CreatedAt = resultSet.getTimestamp("_CreateAt");
                Timestamp _DeleteAt = resultSet.getTimestamp("_DeleteAt");
                // Tạo đối tượng lớp học với thông tin lấy được và thêm vào danh sách
                LopHoc lopHoc = new LopHoc(maLH, idGV_GiangDay, maMH, maLopSV, ngay_BD, ngay_KT, _CreatedAt, _DeleteAt);
                dsLopHoc.add(lopHoc);
            }

            // Đóng kết nối và các tài nguyên
            resultSet.close();
            statement.close();
            connection.close(); 
        } catch (SQLException e) {
            e.printStackTrace(); // In ra thông tin lỗi nếu có
        }

        return dsLopHoc;
    }

    public static LopHoc getByMaLH(String MaLH) {
        // Tạo class lưu giữ thông tin truy vấn 
        LopHoc lopHoc = null;
    
        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM LopHoc WHERE MaLH = ?");
            statement.setString(1, MaLH);
    
            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();
    
            // Xử lý kết quả
            if (resultSet.next()) {
                // Lấy thông tin từ kết quả
                String maLH = resultSet.getString("MaLH");
                UUID idGV_GiangDay = (UUID) resultSet.getObject("IdGV_GiangDay");
                String maMH = resultSet.getString("MaMH");
                String maLopSV = resultSet.getString("MaLopSV");
                Date ngay_BD = resultSet.getDate("Ngay_BD");
                Date ngay_KT = resultSet.getDate("Ngay_KT");
                Timestamp _CreatedAt = resultSet.getTimestamp("_CreateAt");
                Timestamp _DeleteAt = resultSet.getTimestamp("_DeleteAt");
                // Lưu trữ thông tin vào class
                lopHoc = new LopHoc(maLH, idGV_GiangDay, maMH, maLopSV, ngay_BD, ngay_KT, _CreatedAt, _DeleteAt);
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
    
        return lopHoc;
    }
}
