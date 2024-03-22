package qlmph.services;
import java.sql.SQLException;

import qlmph.DAO.QLTaiKhoan.TaiKhoanDAO;
import qlmph.DAO.QLTaiKhoan.VaiTroDAO;
import qlmph.models.QLTaiKhoan.TaiKhoan;

public class TaiKhoanService {
    TaiKhoanDAO taiKhoanDAO = new TaiKhoanDAO(); 
    VaiTroDAO vaiTroDAO = new VaiTroDAO();
    public boolean kiemTraDangNhap(String tenDangNhap, String matKhau) {
        try {
            TaiKhoan taiKhoan = taiKhoanDAO.timTaiKhoanTheoTDN(tenDangNhap);
            if (taiKhoan.getMatKhau().equals(matKhau)) {
                return true; 
            } else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean isManager(String tenDangNhap) {
        try {
            TaiKhoan taiKhoan = taiKhoanDAO.timTaiKhoanTheoTDN(tenDangNhap);
            String vaiTro = vaiTroDAO.kiemTraVaiTro(taiKhoan.getIdVaiTro());
            if(vaiTro.equals("Giảng viên") || vaiTro.equals("Sinh viên")) {
                return false;
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int layIdTuTDN(String tenDangNhap) {
    	try {
			TaiKhoan taiKhoan = taiKhoanDAO.timTaiKhoanTheoTDN(tenDangNhap);
			int id = taiKhoan.getIdNguoiDung();
			return id;
    	} catch (Exception e) {
    		e.printStackTrace();
    		return 0;   		
    	}
    }
}

