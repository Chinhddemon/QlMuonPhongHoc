package qlmph.services;

import qlmph.DAO.QLTaiKhoan.TaiKhoanDAO;
import qlmph.models.QLTaiKhoan.TaiKhoan;
import qlmph.utils.Converter;

public class TaiKhoanService {

    public static TaiKhoan getByTenDangNhapAndMatKhau(String tenDangNhap, String matKhau) {
        TaiKhoan taiKhoan = TaiKhoanDAO.getByTenDangNhapAndMatKhau(tenDangNhap, matKhau);
        return taiKhoan;

    }
    
    public static String getUID(TaiKhoan taiKhoan) {
        return Converter.toString8Char(taiKhoan.getIdTaiKhoan());
    }    

}