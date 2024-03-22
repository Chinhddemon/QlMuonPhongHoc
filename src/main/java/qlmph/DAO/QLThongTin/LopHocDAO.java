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

        List<LopHoc> dsLopHoc = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM LopHoc");) {

            try (ResultSet resultSet = statement.executeQuery();) {
                while (resultSet.next()) {
                    // Lấy thông tin từ kết quả
                    int idLH = resultSet.getInt("IdLH");
                    UUID idGVGiangDay = (UUID) resultSet.getObject("IdGVGiangDay");
                    String maMH = resultSet.getString("MaMH");
                    String maLopSV = resultSet.getString("MaLopSV");
                    Date ngay_BD = resultSet.getDate("Ngay_BD");
                    Date ngay_KT = resultSet.getDate("Ngay_KT");
                    Timestamp _CreatedAt = resultSet.getTimestamp("_CreateAt");
                    Timestamp _UpdateAt = resultSet.getTimestamp("_UpdateAt");
                    Timestamp _DeleteAt = resultSet.getTimestamp("_DeleteAt");
                    // Tạo đối tượng lớp học với thông tin lấy được và thêm vào danh sách
                    LopHoc lopHoc = new LopHoc(idLH, idGVGiangDay, maMH, maLopSV, ngay_BD, ngay_KT, _CreatedAt, _UpdateAt, _DeleteAt);
                    dsLopHoc.add(lopHoc);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
        }

        return dsLopHoc;
    }

    public static LopHoc getByIdLH(int IdLH) {

        LopHoc lopHoc = null;

        try (Connection connection = DBUtil.getConnection();
        PreparedStatement statement = connection.prepareStatement("SELECT * FROM LopHoc WHERE IdLH = ?");) {

            statement.setInt(1, IdLH);

            try (ResultSet resultSet = statement.executeQuery();) {
                if (resultSet.next()) {
                    UUID idGVGiangDay = (UUID) resultSet.getObject("IdGVGiangDay");
                    String maMH = resultSet.getString("MaMH");
                    String maLopSV = resultSet.getString("MaLopSV");
                    Date ngay_BD = resultSet.getDate("Ngay_BD");
                    Date ngay_KT = resultSet.getDate("Ngay_KT");
                    Timestamp _CreatedAt = resultSet.getTimestamp("_CreateAt");
                    Timestamp _UpdateAt = resultSet.getTimestamp("_UpdateAt");
                    Timestamp _DeleteAt = resultSet.getTimestamp("_DeleteAt");
                    // Tạo đối tượng lớp học với thông tin lấy được và thêm vào danh sách
                    lopHoc = new LopHoc(IdLH, idGVGiangDay, maMH, maLopSV, ngay_BD, ngay_KT, _CreatedAt, _UpdateAt, _DeleteAt);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
            System.out.println("Không tìm thấy lớp học với IdLH = " + IdLH);
        }

        return lopHoc;
    }
}
