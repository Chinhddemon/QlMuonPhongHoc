package qlmph.repository.QLTaiKhoan;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.DBUtil.DBUtil;
import qlmph.model.QLTaiKhoan.TaiKhoan;

@Repository
public class TaiKhoanRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @Transactional
    public TaiKhoan getByTenDangNhapAndMatKhau(String tenDangNhap, String matKhau) {
        TaiKhoan taiKhoan = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();	
            taiKhoan = (TaiKhoan) session.createQuery("FROM TaiKhoan WHERE tenDangNhap = :tenDangNhap AND matKhau = :matKhau")
                            .setParameter("tenDangNhap", tenDangNhap)
                            .setParameter("matKhau", matKhau)
                            .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return taiKhoan;
    }

    public static TaiKhoan getByIdTaiKhoan(UUID IdTaiKhoan) {
        TaiKhoan taiKhoan = null;

        try (Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM TaiKhoan WHERE IdTaiKhoan = ?");) {
            
            statement.setObject(1, IdTaiKhoan);

            try(ResultSet resultSet = statement.executeQuery();) {
                // Duyệt qua kết quả để tìm kết quả phù hợp 
                if (resultSet.next()) {
                    short idVaiTro = resultSet.getShort("IdVaiTro");
                    String tenDangNhap = resultSet.getString("TenDangNhap");
                    String matKhau = resultSet.getString("MatKhau");
                    Timestamp _CreateAt = resultSet.getTimestamp("_CreateAt");
                    Timestamp _UpdateAt = resultSet.getTimestamp("_UpdateAt");
                    Timestamp _DeleteAt = resultSet.getTimestamp("_DeleteAt");
                    taiKhoan = new TaiKhoan(IdTaiKhoan, idVaiTro, tenDangNhap, matKhau, _CreateAt, _UpdateAt, _DeleteAt);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
        }
        return taiKhoan;
    }
}