package qlmph.services;

import qlmph.DAO.QLTaiKhoan.TaiKhoanDAO;
import qlmph.DAO.QLTaiKhoan.VaiTroDAO;
import qlmph.models.QLTaiKhoan.TaiKhoan;
import qlmph.models.QLTaiKhoan.VaiTro;
import qlmph.utils.Converter;

public class TaiKhoanService {

    public static TaiKhoan getByTenDangNhapAndMatKhau(String tenDangNhap, String matKhau) {
        TaiKhoan taiKhoan = TaiKhoanDAO.getByTenDangNhapAndMatKhau(tenDangNhap, matKhau);
        return taiKhoan;

    }
    public static String getUID(TaiKhoan taiKhoan) {
        return Converter.toString8Char(taiKhoan.getIdTaiKhoan());
    }
    public static String getVaiTro(TaiKhoan taiKhoan) {
        VaiTro vaiTro = VaiTroDAO.getByIdVaiTro(taiKhoan.getIdVaiTro());
        String tenVaiTro = vaiTro.getTenVaitro();
        if(tenVaiTro.equals("Giảng viên") 
        || tenVaiTro.equals("Sinh viên")) return "Regular";

        else if(tenVaiTro.equals("Quản lý")) return "Manager";

        else if(tenVaiTro.equals("Admin")) return "Admin";

        return "none";
    }

}